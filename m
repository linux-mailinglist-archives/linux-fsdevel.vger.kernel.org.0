Return-Path: <linux-fsdevel+bounces-21145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2978A8FF9CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ECF284B65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB8E1B28D;
	Fri,  7 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L/X9KdiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EF125B9
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725602; cv=none; b=d7vwUgDLegLXKufbPKgXGmZ0rd7bQwMDUjkwh6VL7M9dPuDHwVnmalTDaQNgUX7SYSol/OGA/ytFPEfBQMRJS4cEq1aW6I9rkTOuk6c6CegPAFraZ8kaXdZ0D3p1hqrK2Kn2TWo0mxghY0+T/FvnXmzqejKx8Tz3zUXykY4kIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725602; c=relaxed/simple;
	bh=jbQDNmjdOl3DVfQmFgHDXbgPNMmk+eAwmPmfTNm1mC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ciUERR9FRB7b6m8dHEln3AByQOUVnsCpQph1gp3t/6EkTv9BO2Y3tsWgZWObAZ5OFpeXJs79oiOHjvqVm8EWdwrhROgcG3YXVxagAyBPbg3YtbkzwZpfPQpHXWLh7dpRK3GpzZrkOOi74HAnQCxB1ry0Trga5X3dLg7mHLs6xZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L/X9KdiJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KnJwsvhSb2V9KKabGYKwZt7vzpqFmHIXGO5cNnvgBAg=; b=L/X9KdiJoeVsCdjdyD2ZLENwYb
	JnKcpG9USCwhPOff8HkkC2X8ayP5Z/+vnUAkHoP7qw2zDrHXb1qBUolj1qGtOaKOV4DezCphjNWp4
	JT+2JRSe31OEUeXFYstDUrg8++lFVOdyYul69SLp/V/uACnCVEcTfC4YsScJ2+YJ1HogXzOMUd6L/
	2WRDF4F2SlHrsh+3lgkuG5cgqTktnCMAVtNaGO/y5r12g/ryew7FITHJKrzwJwyhVLEOoUmjTkeoX
	XMht9CEoxkOwm1xep4G9hpE993NsY4WMb22sBB4J0czx9M4Qh8P5hv1l69l6chYVMhuYpGbuemf6z
	zZ1H8IOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOta-009xBd-1b;
	Fri, 07 Jun 2024 01:59:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 06/19] net/socket.c: switch to CLASS(fd)
Date: Fri,  7 Jun 2024 02:59:44 +0100
Message-Id: <20240607015957.2372428-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	I strongly suspect that important part in sockfd_lookup_light()
is avoiding needless file refcount operations, not the marginal reduction
of the register pressure from not keeping a struct file pointer in
the caller.

	If that's true, we should get the same benefits from straight
fdget()/fdput().  And AFAICS with sane use of CLASS(fd) we can get a
better code generation...

	Would be nice if somebody tested it on networking test suites
(including benchmarks)...

	sockfd_lookup_light() does fdget(), uses sock_from_file() to
get the associated socket and returns the struct socket reference to
the caller, along with "do we need to fput()" flag.  No matching fdput(),
the caller does its equivalent manually, using the fact that sock->file
points to the struct file the socket has come from.

	Get rid of that - have the callers do fdget()/fdput() and
use sock_from_file() directly.  That kills sockfd_lookup_light()
and fput_light() (no users left).

	What's more, we can get rid of explicit fdget()/fdput() by
switching to CLASS(fd, ...) - code generation does not suffer, since
now fdput() inserted on "descriptor is not opened" failure exit
is recognized to be a no-op by compiler.

	We could split that commit in two (getting rid of sockd_lookup_light()
and switch to CLASS(fd, ...)), but AFAICS it ends up being harder to read
that way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/file.h |   6 -
 net/socket.c         | 325 ++++++++++++++++++++-----------------------
 2 files changed, 148 insertions(+), 183 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 7bc6e24e86ce..744a6315f1ac 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -29,12 +29,6 @@ extern struct file *alloc_file_pseudo_noaccount(struct inode *, struct vfsmount
 extern struct file *alloc_file_clone(struct file *, int flags,
 	const struct file_operations *);
 
-static inline void fput_light(struct file *file, int fput_needed)
-{
-	if (fput_needed)
-		fput(file);
-}
-
 /* either a reference to struct file + flags
  * (cloned vs. borrowed, pos locked), with
  * flags stored in lower bits of value,
diff --git a/net/socket.c b/net/socket.c
index a2c509363d4d..ca3fd754fb5b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -510,7 +510,7 @@ static int sock_map_fd(struct socket *sock, int flags)
 
 struct socket *sock_from_file(struct file *file)
 {
-	if (file->f_op == &socket_file_ops)
+	if (likely(file->f_op == &socket_file_ops))
 		return file->private_data;	/* set in sock_alloc_file */
 
 	return NULL;
@@ -550,24 +550,6 @@ struct socket *sockfd_lookup(int fd, int *err)
 }
 EXPORT_SYMBOL(sockfd_lookup);
 
-static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
-{
-	struct fd f = fdget(fd);
-	struct socket *sock;
-
-	*err = -EBADF;
-	if (fd_file(f)) {
-		sock = sock_from_file(fd_file(f));
-		if (likely(sock)) {
-			*fput_needed = f.word & FDPUT_FPUT;
-			return sock;
-		}
-		*err = -ENOTSOCK;
-		fdput(f);
-	}
-	return NULL;
-}
-
 static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 				size_t size)
 {
@@ -1834,23 +1816,25 @@ int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
-	int err, fput_needed;
-
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock) {
-		err = move_addr_to_kernel(umyaddr, addrlen, &address);
-		if (!err) {
-			err = security_socket_bind(sock,
-						   (struct sockaddr *)&address,
-						   addrlen);
-			if (!err)
-				err = READ_ONCE(sock->ops)->bind(sock,
-						      (struct sockaddr *)
-						      &address, addrlen);
-		}
-		fput_light(sock->file, fput_needed);
-	}
-	return err;
+	CLASS(fd, f)(fd);
+	int err;
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
+
+	err = move_addr_to_kernel(umyaddr, addrlen, &address);
+	if (unlikely(err))
+		return err;
+
+	err = security_socket_bind(sock, (struct sockaddr *)&address, addrlen);
+	if (unlikely(err))
+		return err;
+
+	return READ_ONCE(sock->ops)->bind(sock,
+					  (struct sockaddr *)&address, addrlen);
 }
 
 SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
@@ -1867,21 +1851,24 @@ SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
 int __sys_listen(int fd, int backlog)
 {
 	struct socket *sock;
-	int err, fput_needed;
+	CLASS(fd, f)(fd);
 	int somaxconn;
+	int err;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock) {
-		somaxconn = READ_ONCE(sock_net(sock->sk)->core.sysctl_somaxconn);
-		if ((unsigned int)backlog > somaxconn)
-			backlog = somaxconn;
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-		err = security_socket_listen(sock, backlog);
-		if (!err)
-			err = READ_ONCE(sock->ops)->listen(sock, backlog);
+	somaxconn = READ_ONCE(sock_net(sock->sk)->core.sysctl_somaxconn);
+	if ((unsigned int)backlog > somaxconn)
+		backlog = somaxconn;
+
+	err = security_socket_listen(sock, backlog);
+	if (!err)
+		err = READ_ONCE(sock->ops)->listen(sock, backlog);
 
-		fput_light(sock->file, fput_needed);
-	}
 	return err;
 }
 
@@ -1992,17 +1979,12 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
 int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 		  int __user *upeer_addrlen, int flags)
 {
-	int ret = -EBADF;
-	struct fd f;
+	CLASS(fd, f)(fd);
 
-	f = fdget(fd);
-	if (fd_file(f)) {
-		ret = __sys_accept4_file(fd_file(f), upeer_sockaddr,
+	if (fd_empty(f))
+		return -EBADF;
+	return __sys_accept4_file(fd_file(f), upeer_sockaddr,
 					 upeer_addrlen, flags);
-		fdput(f);
-	}
-
-	return ret;
 }
 
 SYSCALL_DEFINE4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
@@ -2054,20 +2036,18 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 
 int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
 {
-	int ret = -EBADF;
-	struct fd f;
+	struct sockaddr_storage address;
+	CLASS(fd, f)(fd);
+	int ret;
 
-	f = fdget(fd);
-	if (fd_file(f)) {
-		struct sockaddr_storage address;
+	if (fd_empty(f))
+		return -EBADF;
 
-		ret = move_addr_to_kernel(uservaddr, addrlen, &address);
-		if (!ret)
-			ret = __sys_connect_file(fd_file(f), &address, addrlen, 0);
-		fdput(f);
-	}
+	ret = move_addr_to_kernel(uservaddr, addrlen, &address);
+	if (ret)
+		return ret;
 
-	return ret;
+	return __sys_connect_file(fd_file(f), &address, addrlen, 0);
 }
 
 SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
@@ -2086,26 +2066,25 @@ int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
-	int err, fput_needed;
+	CLASS(fd, f)(fd);
+	int err;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	err = security_socket_getsockname(sock);
 	if (err)
-		goto out_put;
+		return err;
 
 	err = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 0);
 	if (err < 0)
-		goto out_put;
-	/* "err" is actually length in this case */
-	err = move_addr_to_user(&address, err, usockaddr, usockaddr_len);
+		return err;
 
-out_put:
-	fput_light(sock->file, fput_needed);
-out:
-	return err;
+	/* "err" is actually length in this case */
+	return move_addr_to_user(&address, err, usockaddr, usockaddr_len);
 }
 
 SYSCALL_DEFINE3(getsockname, int, fd, struct sockaddr __user *, usockaddr,
@@ -2124,26 +2103,25 @@ int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
-	int err, fput_needed;
+	CLASS(fd, f)(fd);
+	int err;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock != NULL) {
-		const struct proto_ops *ops = READ_ONCE(sock->ops);
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-		err = security_socket_getpeername(sock);
-		if (err) {
-			fput_light(sock->file, fput_needed);
-			return err;
-		}
+	err = security_socket_getpeername(sock);
+	if (err)
+		return err;
 
-		err = ops->getname(sock, (struct sockaddr *)&address, 1);
-		if (err >= 0)
-			/* "err" is actually length in this case */
-			err = move_addr_to_user(&address, err, usockaddr,
-						usockaddr_len);
-		fput_light(sock->file, fput_needed);
-	}
-	return err;
+	err = READ_ONCE(sock->ops)->getname(sock, (struct sockaddr *)&address, 1);
+	if (err < 0)
+		return err;
+
+	/* "err" is actually length in this case */
+	return move_addr_to_user(&address, err, usockaddr, usockaddr_len);
 }
 
 SYSCALL_DEFINE3(getpeername, int, fd, struct sockaddr __user *, usockaddr,
@@ -2164,14 +2142,17 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	struct sockaddr_storage address;
 	int err;
 	struct msghdr msg;
-	int fput_needed;
 
 	err = import_ubuf(ITER_SOURCE, buff, len, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	msg.msg_name = NULL;
 	msg.msg_control = NULL;
@@ -2181,7 +2162,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (addr) {
 		err = move_addr_to_kernel(addr, addr_len, &address);
 		if (err < 0)
-			goto out_put;
+			return err;
 		msg.msg_name = (struct sockaddr *)&address;
 		msg.msg_namelen = addr_len;
 	}
@@ -2189,12 +2170,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
 	msg.msg_flags = flags;
-	err = __sock_sendmsg(sock, &msg);
-
-out_put:
-	fput_light(sock->file, fput_needed);
-out:
-	return err;
+	return __sock_sendmsg(sock, &msg);
 }
 
 SYSCALL_DEFINE6(sendto, int, fd, void __user *, buff, size_t, len,
@@ -2229,14 +2205,18 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 	};
 	struct socket *sock;
 	int err, err2;
-	int fput_needed;
 
 	err = import_ubuf(ITER_DEST, ubuf, size, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
+
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	if (sock->file->f_flags & O_NONBLOCK)
 		flags |= MSG_DONTWAIT;
@@ -2248,9 +2228,6 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 		if (err2 < 0)
 			err = err2;
 	}
-
-	fput_light(sock->file, fput_needed);
-out:
 	return err;
 }
 
@@ -2325,17 +2302,16 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 {
 	sockptr_t optval = USER_SOCKPTR(user_optval);
 	bool compat = in_compat_syscall();
-	int err, fput_needed;
 	struct socket *sock;
+	CLASS(fd, f)(fd);
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
-
-	err = do_sock_setsockopt(sock, compat, level, optname, optval, optlen);
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-	fput_light(sock->file, fput_needed);
-	return err;
+	return do_sock_setsockopt(sock, compat, level, optname, optval, optlen);
 }
 
 SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
@@ -2391,20 +2367,17 @@ EXPORT_SYMBOL(do_sock_getsockopt);
 int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		int __user *optlen)
 {
-	int err, fput_needed;
 	struct socket *sock;
-	bool compat;
+	CLASS(fd, f)(fd);
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-	compat = in_compat_syscall();
-	err = do_sock_getsockopt(sock, compat, level, optname,
+	return do_sock_getsockopt(sock, in_compat_syscall(), level, optname,
 				 USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
-
-	fput_light(sock->file, fput_needed);
-	return err;
 }
 
 SYSCALL_DEFINE5(getsockopt, int, fd, int, level, int, optname,
@@ -2430,15 +2403,16 @@ int __sys_shutdown_sock(struct socket *sock, int how)
 
 int __sys_shutdown(int fd, int how)
 {
-	int err, fput_needed;
 	struct socket *sock;
+	CLASS(fd, f)(fd);
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock != NULL) {
-		err = __sys_shutdown_sock(sock, how);
-		fput_light(sock->file, fput_needed);
-	}
-	return err;
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
+
+	return __sys_shutdown_sock(sock, how);
 }
 
 SYSCALL_DEFINE2(shutdown, int, fd, int, how)
@@ -2654,22 +2628,21 @@ long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
 long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
 		   bool forbid_cmsg_compat)
 {
-	int fput_needed, err;
 	struct msghdr msg_sys;
 	struct socket *sock;
 
 	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
+	CLASS(fd, f)(fd);
 
-	err = ___sys_sendmsg(sock, msg, &msg_sys, flags, NULL, 0);
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-	fput_light(sock->file, fput_needed);
-out:
-	return err;
+	return ___sys_sendmsg(sock, msg, &msg_sys, flags, NULL, 0);
 }
 
 SYSCALL_DEFINE3(sendmsg, int, fd, struct user_msghdr __user *, msg, unsigned int, flags)
@@ -2684,7 +2657,7 @@ SYSCALL_DEFINE3(sendmsg, int, fd, struct user_msghdr __user *, msg, unsigned int
 int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		   unsigned int flags, bool forbid_cmsg_compat)
 {
-	int fput_needed, err, datagrams;
+	int err, datagrams;
 	struct socket *sock;
 	struct mmsghdr __user *entry;
 	struct compat_mmsghdr __user *compat_entry;
@@ -2700,9 +2673,13 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 	datagrams = 0;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	used_address.name_len = UINT_MAX;
 	entry = mmsg;
@@ -2739,8 +2716,6 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		cond_resched();
 	}
 
-	fput_light(sock->file, fput_needed);
-
 	/* We only return an error if no datagrams were able to be sent */
 	if (datagrams != 0)
 		return datagrams;
@@ -2862,22 +2837,21 @@ long __sys_recvmsg_sock(struct socket *sock, struct msghdr *msg,
 long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
 		   bool forbid_cmsg_compat)
 {
-	int fput_needed, err;
 	struct msghdr msg_sys;
 	struct socket *sock;
 
 	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
+	CLASS(fd, f)(fd);
 
-	err = ___sys_recvmsg(sock, msg, &msg_sys, flags, 0);
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-	fput_light(sock->file, fput_needed);
-out:
-	return err;
+	return ___sys_recvmsg(sock, msg, &msg_sys, flags, 0);
 }
 
 SYSCALL_DEFINE3(recvmsg, int, fd, struct user_msghdr __user *, msg,
@@ -2894,7 +2868,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  struct timespec64 *timeout)
 {
-	int fput_needed, err, datagrams;
+	int err, datagrams;
 	struct socket *sock;
 	struct mmsghdr __user *entry;
 	struct compat_mmsghdr __user *compat_entry;
@@ -2909,16 +2883,18 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 
 	datagrams = 0;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	if (likely(!(flags & MSG_ERRQUEUE))) {
 		err = sock_error(sock->sk);
-		if (err) {
-			datagrams = err;
-			goto out_put;
-		}
+		if (err)
+			return err;
 	}
 
 	entry = mmsg;
@@ -2975,12 +2951,10 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 	}
 
 	if (err == 0)
-		goto out_put;
+		return datagrams;
 
-	if (datagrams == 0) {
-		datagrams = err;
-		goto out_put;
-	}
+	if (datagrams == 0)
+		return err;
 
 	/*
 	 * We may return less entries than requested (vlen) if the
@@ -2995,9 +2969,6 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 		 */
 		WRITE_ONCE(sock->sk->sk_err, -err);
 	}
-out_put:
-	fput_light(sock->file, fput_needed);
-
 	return datagrams;
 }
 
-- 
2.39.2


