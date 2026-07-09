resource "aws_instance" "webserver1" {
  ami           = "ami-002192a70217ac181"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_az1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.webserver1_sg.id
  ]
  tags = {
    Name = "Web Server1"
  }
}
resource "aws_instance" "webserver2" {
  ami           = "ami-002192a70217ac181"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_az2.id
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.profile.name
  tags = {
    Name = "Web Server2"
  }
}
resource "aws_instance" "jumpserver" {
  ami           = "ami-002192a70217ac181"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_az1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.jump_sg.id
  ]
  tags = {
    Name = "Jump Server"
  }
}
resource "aws_lb_target_group_attachment" "web1" {

  target_group_arn = aws_lb_target_group.tg.arn

  target_id = aws_instance.webserver1.id

  port = 80
}

resource "aws_lb_target_group_attachment" "web2" {

  target_group_arn = aws_lb_target_group.tg.arn

  target_id = aws_instance.webserver2.id

  port = 80
}
