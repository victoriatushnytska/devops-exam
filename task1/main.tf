resource "digitalocean_vpc" "main" {
  name     = "${var.surname}-vpc"
  region   = var.region
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_firewall" "main" {
  name = "${var.surname}-firewall"
  droplet_ids = [digitalocean_droplet.node.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000-8003"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_ssh_key" "default" {
  name       = "exam-ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCttIlhehwaH7vpe+ZRX77vY7arNPzMNAY0w9m5OkfLP8RVqlJnIFZ63RaNHd55uJEw8nrQwpVf6J+bXLd784GknHppSbLJl7UZW9uWdY5mREgiLtnCAHUi8S1gzfut1eTg+9fKbC+wmwnbUJEd/YNPRLND7sf2QI08U+FdxTHFhqAY7WwiYVm8vTXx949zOrfj8/FN+ZB3lgV55WOAtIjfPBNMcNavDek/aDnYY9PG5fKI6VKrKc7pj2EIU52zjwAdvdi00iVmhFgU032KaSkId1Jjw8MVo17BSkf4eEghPjeAqsYBaMsbdIinvvpVOHzHfPHpz4Ywi0pNKce0q1srVvGH0pIZLZzU6LaRz/EFKZ+Y2l77Hu/6ZmSregIH7rMQxRmWTLsvjECfo8639doX2mWnQEoQNUtxxJt8Wrd2H0cDX88mVVk52AvU9e0XW73TQfxbGJo9KT++PNNQYtMp89PEJX7MizvQj1hlV+E1EvHYHVGjdd4ztabFAIWeG7kGXAJz8gZnxJTZQXrBT4GpacGfA6BPTBSHYWEaFBS0S+F2ru1UhEDQyohHs4iKxC22nTw1C8mbGoIpbBiu4B3taIQy34yEvtkgrpA/2liusTk+fJViCsdKeY3aT2m568rkidTOFXWCOsIt6vNMO/h8wHs3cgUnsWi1jZvNd0c8CQ== vikatushnytska@vikas-MacBook-Air.local"
}

resource "digitalocean_droplet" "node" {
  name     = "${var.surname}-node"
  size     = "s-2vcpu-4gb"
  image    = "ubuntu-24-04-x64"
  region   = var.region
  vpc_
