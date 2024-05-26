Return-Path: <linux-fsdevel+bounces-20164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D14F78CF27B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 05:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E740D280A7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 03:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2511849;
	Sun, 26 May 2024 03:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AXWTIgun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB8A23
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2024 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716694840; cv=none; b=t4YsqkhvLtqmmRVLP3UO7v96HOKC98+7PWimLojxL2GH/5/I0bm9vY2sFt6/7NT4O/HyS1FkFKZ7Bl88D3S0mQekQoflsvpNLNPsC8KdDLmolaT7Ob476NKoNK2vN6wWJK2ri2OkD+2Tvh/tSFHV7smM1gzh21jl+InSs4n6v3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716694840; c=relaxed/simple;
	bh=UBeEo19PnGH8BwQR+3p0VdXZjOqWrvXmB9lyb4NWwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kXb0dbUbc9Q/BMhipttNHaWcWTP02y/K1uffwDPBAkSbiOp9/fPSf2qNggAETiC5fV3LZVKwHExmUPr4PVVgZQ8owdImzUn+3k0Qo6QB+ZzdK4XIrZiXXPbY/Z12mVRFIsXqR7fPj6Alih58CUeK/IOiPyVKhfRI7V9Os2aZNlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AXWTIgun; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NfCYUe40AdCYwKuccwX2638d1xgr7NzQtVlkdQSqdlY=; b=AXWTIgun+y8MAhR/p3DLkBR5Cj
	9NCZAvRWA0nJL3IDSvsyToEPX3x+woUiWzZhh/tkG2RlSRTdKOAXNBaR/a0rLuySUjcVwBXMuIMOe
	guC6+s8mjT3wbOFd56IiHqHwR3ZvtZVvmtFUe8H9XBXsbnoqzREtEapGakTvUI+sZpXJzzQL0Os8I
	QES+yGrEkackdVma3k5i9bkcKhr5O19qhBpRYr5XCgx9I6gGnsyFEnkWI7Tm6hO6ldj6n+AxfLbKz
	Wee+sfibdKxyj73JyeAv8dcVESP/y8l3AUZzGcfQQwsB9aqd5B5Tihrx4M6VJmW0NTywJZzQ6K89j
	iZDRnbnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sB4kK-008n0R-3D;
	Sun, 26 May 2024 03:40:33 +0000
Date: Sun, 26 May 2024 04:40:32 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: netdev@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput
Message-ID: <20240526034032.GY2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Checking the theory that the important part in sockfd_lookup_light() is
avoiding needless file refcount operations, not the marginal reduction
of the register pressure from not keeping a struct file pointer in the
caller.

If that's true, we should get the same benefits from straight fdget()/fdput().
And AFAICS with sane use of CLASS(fd) we can get a better code generation...

Would be nice if somebody tested it on networking test suites (including
benchmarks)...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/include/linux/file.h b/include/linux/file.h
index 45d0f4800abd..831fda778e23 100644
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
 struct fd {
 	struct file *file;
 	unsigned int flags;
@@ -76,6 +70,12 @@ static inline struct fd fdget_pos(int fd)
 	return __to_fd(__fdget_pos(fd));
 }
 
+static inline bool fd_empty(struct fd f)
+{
+	// better code with gcc that way
+	return unlikely(!(f.flags | (unsigned long)f.file));
+}
+
 static inline void fdput_pos(struct fd f)
 {
 	if (f.flags & FDPUT_POS_UNLOCK)
diff --git a/net/socket.c b/net/socket.c
index e416920e9399..297293797df2 100644
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
-	if (f.file) {
-		sock = sock_from_file(f.file);
-		if (likely(sock)) {
-			*fput_needed = f.flags & FDPUT_FPUT;
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
+	sock = sock_from_file(f.file);
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
+	sock = sock_from_file(f.file);
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
-	if (f.file) {
-		ret = __sys_accept4_file(f.file, upeer_sockaddr,
+	if (fd_empty(f))
+		return -EBADF;
+	return __sys_accept4_file(f.file, upeer_sockaddr,
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
-	if (f.file) {
-		struct sockaddr_storage address;
+	if (fd_empty(f))
+		return -EBADF;
 
-		ret = move_addr_to_kernel(uservaddr, addrlen, &address);
-		if (!ret)
-			ret = __sys_connect_file(f.file, &address, addrlen, 0);
-		fdput(f);
-	}
+	ret = move_addr_to_kernel(uservaddr, addrlen, &address);
+	if (ret)
+		return ret;
 
-	return ret;
+	return __sys_connect_file(f.file, &address, addrlen, 0);
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
+	sock = sock_from_file(f.file);
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
+	sock = sock_from_file(f.file);
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
@@ -2162,16 +2140,13 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
-	int err;
 	struct msghdr msg;
-	int fput_needed;
+	CLASS(fd, f)(fd);
+	int err;
 
 	err = import_ubuf(ITER_SOURCE, buff, len, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
 
 	msg.msg_name = NULL;
 	msg.msg_control = NULL;
@@ -2181,20 +2156,22 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (addr) {
 		err = move_addr_to_kernel(addr, addr_len, &address);
 		if (err < 0)
-			goto out_put;
+			return err;
 		msg.msg_name = (struct sockaddr *)&address;
 		msg.msg_namelen = addr_len;
 	}
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
+
 	flags &= ~MSG_INTERNAL_SENDMSG_FLAGS;
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
@@ -2229,14 +2206,17 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 	};
 	struct socket *sock;
 	int err, err2;
-	int fput_needed;
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	err = import_ubuf(ITER_DEST, ubuf, size, &msg.msg_iter);
 	if (unlikely(err))
 		return err;
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
 
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
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-	err = do_sock_setsockopt(sock, compat, level, optname, optval, optlen);
-
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
+	sock = sock_from_file(f.file);
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
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
+
+	return __sys_shutdown_sock(sock, how);
 }
 
 SYSCALL_DEFINE2(shutdown, int, fd, int, how)
@@ -2654,22 +2628,20 @@ long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
 long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
 		   bool forbid_cmsg_compat)
 {
-	int fput_needed, err;
 	struct msghdr msg_sys;
 	struct socket *sock;
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
-
-	err = ___sys_sendmsg(sock, msg, &msg_sys, flags, NULL, 0);
-
-	fput_light(sock->file, fput_needed);
-out:
-	return err;
+	return ___sys_sendmsg(sock, msg, &msg_sys, flags, NULL, 0);
 }
 
 SYSCALL_DEFINE3(sendmsg, int, fd, struct user_msghdr __user *, msg, unsigned int, flags)
@@ -2684,13 +2656,20 @@ SYSCALL_DEFINE3(sendmsg, int, fd, struct user_msghdr __user *, msg, unsigned int
 int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		   unsigned int flags, bool forbid_cmsg_compat)
 {
-	int fput_needed, err, datagrams;
+	int err, datagrams;
 	struct socket *sock;
 	struct mmsghdr __user *entry;
 	struct compat_mmsghdr __user *compat_entry;
 	struct msghdr msg_sys;
 	struct used_address used_address;
 	unsigned int oflags = flags;
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
 		return -EINVAL;
@@ -2700,10 +2679,6 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
 	datagrams = 0;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
-
 	used_address.name_len = UINT_MAX;
 	entry = mmsg;
 	compat_entry = (struct compat_mmsghdr __user *)mmsg;
@@ -2739,8 +2714,6 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		cond_resched();
 	}
 
-	fput_light(sock->file, fput_needed);
-
 	/* We only return an error if no datagrams were able to be sent */
 	if (datagrams != 0)
 		return datagrams;
@@ -2862,22 +2835,20 @@ long __sys_recvmsg_sock(struct socket *sock, struct msghdr *msg,
 long __sys_recvmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
 		   bool forbid_cmsg_compat)
 {
-	int fput_needed, err;
 	struct msghdr msg_sys;
 	struct socket *sock;
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
 	if (forbid_cmsg_compat && (flags & MSG_CMSG_COMPAT))
 		return -EINVAL;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		goto out;
-
-	err = ___sys_recvmsg(sock, msg, &msg_sys, flags, 0);
-
-	fput_light(sock->file, fput_needed);
-out:
-	return err;
+	return ___sys_recvmsg(sock, msg, &msg_sys, flags, 0);
 }
 
 SYSCALL_DEFINE3(recvmsg, int, fd, struct user_msghdr __user *, msg,
@@ -2894,31 +2865,32 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  struct timespec64 *timeout)
 {
-	int fput_needed, err, datagrams;
+	int err, datagrams;
 	struct socket *sock;
 	struct mmsghdr __user *entry;
 	struct compat_mmsghdr __user *compat_entry;
 	struct msghdr msg_sys;
 	struct timespec64 end_time;
 	struct timespec64 timeout64;
+	CLASS(fd, f)(fd);
 
 	if (timeout &&
 	    poll_select_set_timeout(&end_time, timeout->tv_sec,
 				    timeout->tv_nsec))
 		return -EINVAL;
 
-	datagrams = 0;
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(f.file);
+	if (unlikely(!sock))
+		return -ENOTSOCK;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (!sock)
-		return err;
+	datagrams = 0;
 
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
@@ -2975,12 +2947,10 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
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
@@ -2995,9 +2965,6 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 		 */
 		WRITE_ONCE(sock->sk->sk_err, -err);
 	}
-out_put:
-	fput_light(sock->file, fput_needed);
-
 	return datagrams;
 }
 

