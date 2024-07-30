Return-Path: <linux-fsdevel+bounces-24538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D69406E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E531E282B85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D356190467;
	Tue, 30 Jul 2024 05:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WG2Q93Cn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D019004E;
	Tue, 30 Jul 2024 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316492; cv=none; b=EjoyTnuhx6qUNHTZI4LuAR5gJbMwOhScvc4DgPqPRX8BXTJA6VSi8USNBsvBszXE5hvDr6mNObreeMRyy6LQbdiRnLghtlJx24pnBhMmAnI1QELYuoVtfkmMRMZ66gSg+XVOt/V7HQ4oRI7mnGpmRR6hG6TYNOMdhubuZ7r8GnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316492; c=relaxed/simple;
	bh=IWr1u8hvxijbFswBFlAGbrFiaQy7BFLyOt7qorbkMAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfLuibhFSNZAWxEXsV7bdKrW8Z1t85l7q4i3X+GAgROidtJ9B/hkRuH4jJ9tcXTT6QAbW+/4ARuS0osuugvc2lJdCmUSt7dwLevR70SxGV3U9HsWp5NdwmoA9Vctaj7CESuSJl7ckPzpaJuAV0k1n80ZP7IkhHoJZbNApOy9GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WG2Q93Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843DCC4AF0F;
	Tue, 30 Jul 2024 05:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316492;
	bh=IWr1u8hvxijbFswBFlAGbrFiaQy7BFLyOt7qorbkMAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WG2Q93CnL3EONkXqUc6YnC6Rz4tprrQJuPwj4ZtEjY9FLPXaepqhIs5qa8jPEZDK3
	 HzRHiqIFa3Zaf5+fyHydx255y407zRHBUUmcsEgrqOqsy+Y7P9l8cSnRuc/TPUToqR
	 YhJRCUueB3fdPY9osvDd12UAKcTVmxhiVr5Ra8ENRqcunhJw560KSV/BraAIAG9lsO
	 r83lxpTo/hAgdOSrnA9KTFvU/vkm3xDS17FC68aIJ8sgExOOoXYfDhmZ7r5GqtANe/
	 V6bAFsa6AFgCzhsLh2sA5m1i/wvfR6i3YgwJzQkDN1xgUM7tSDU1xVk01bepoXyBuT
	 Na1xODqvHb1YA==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 06/39] net/socket.c: switch to CLASS(fd)
Date: Tue, 30 Jul 2024 01:15:52 -0400
Message-Id: <20240730051625.14349-6-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

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

[conflicts in a couple of functions]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/file.h |   6 -
 net/socket.c         | 303 +++++++++++++++++++------------------------
 2 files changed, 137 insertions(+), 172 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 00a42604d322..3353d70fd460 100644
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
index c0d4f5032374..c09c69eddafa 100644
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
@@ -1848,16 +1830,20 @@ int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen)
 {
 	struct socket *sock;
 	struct sockaddr_storage address;
-	int err, fput_needed;
-
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock) {
-		err = move_addr_to_kernel(umyaddr, addrlen, &address);
-		if (!err)
-			err = __sys_bind_socket(sock, &address, addrlen);
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
+	return __sys_bind_socket(sock, &address, addrlen);
 }
 
 SYSCALL_DEFINE3(bind, int, fd, struct sockaddr __user *, umyaddr, int, addrlen)
@@ -1886,15 +1872,16 @@ int __sys_listen_socket(struct socket *sock, int backlog)
 
 int __sys_listen(int fd, int backlog)
 {
+	CLASS(fd, f)(fd);
 	struct socket *sock;
-	int err, fput_needed;
 
-	sock = sockfd_lookup_light(fd, &err, &fput_needed);
-	if (sock) {
-		err = __sys_listen_socket(sock, backlog);
-		fput_light(sock->file, fput_needed);
-	}
-	return err;
+	if (fd_empty(f))
+		return -EBADF;
+	sock = sock_from_file(fd_file(f));
+	if (unlikely(!sock))
+		return -ENOTSOCK;
+
+	return __sys_listen_socket(sock, backlog);
 }
 
 SYSCALL_DEFINE2(listen, int, fd, int, backlog)
@@ -2004,17 +1991,12 @@ static int __sys_accept4_file(struct file *file, struct sockaddr __user *upeer_s
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
@@ -2066,20 +2048,18 @@ int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
 
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
@@ -2098,26 +2078,25 @@ int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
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
@@ -2136,26 +2115,25 @@ int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
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
@@ -2176,14 +2154,17 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
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
@@ -2193,7 +2174,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
 	if (addr) {
 		err = move_addr_to_kernel(addr, addr_len, &address);
 		if (err < 0)
-			goto out_put;
+			return err;
 		msg.msg_name = (struct sockaddr *)&address;
 		msg.msg_namelen = addr_len;
 	}
@@ -2201,12 +2182,7 @@ int __sys_sendto(int fd, void __user *buff, size_t len, unsigned int flags,
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
@@ -2241,14 +2217,18 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
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
@@ -2260,9 +2240,6 @@ int __sys_recvfrom(int fd, void __user *ubuf, size_t size, unsigned int flags,
 		if (err2 < 0)
 			err = err2;
 	}
-
-	fput_light(sock->file, fput_needed);
-out:
 	return err;
 }
 
@@ -2337,17 +2314,16 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
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
@@ -2403,20 +2379,17 @@ EXPORT_SYMBOL(do_sock_getsockopt);
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
@@ -2442,15 +2415,16 @@ int __sys_shutdown_sock(struct socket *sock, int how)
 
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
@@ -2666,22 +2640,21 @@ long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
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
@@ -2696,7 +2669,7 @@ SYSCALL_DEFINE3(sendmsg, int, fd, struct user_msghdr __user *, msg, unsigned int
 int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		   unsigned int flags, bool forbid_cmsg_compat)
 {
-	int fput_needed, err, datagrams;
+	int err, datagrams;
 	struct socket *sock;
 	struct mmsghdr __user *entry;
 	struct compat_mmsghdr __user *compat_entry;
@@ -2712,9 +2685,13 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 
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
@@ -2751,8 +2728,6 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		cond_resched();
 	}
 
-	fput_light(sock->file, fput_needed);
-
 	/* We only return an error if no datagrams were able to be sent */
 	if (datagrams != 0)
 		return datagrams;
@@ -2874,22 +2849,21 @@ long __sys_recvmsg_sock(struct socket *sock, struct msghdr *msg,
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
@@ -2906,7 +2880,7 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 			  unsigned int vlen, unsigned int flags,
 			  struct timespec64 *timeout)
 {
-	int fput_needed, err, datagrams;
+	int err, datagrams;
 	struct socket *sock;
 	struct mmsghdr __user *entry;
 	struct compat_mmsghdr __user *compat_entry;
@@ -2921,16 +2895,18 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 
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
@@ -2987,12 +2963,10 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
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
@@ -3007,9 +2981,6 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
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


