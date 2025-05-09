Return-Path: <linux-fsdevel+bounces-48557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69495AB10A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426B61C25D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93338290BC4;
	Fri,  9 May 2025 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJnFhLPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230928ECFE;
	Fri,  9 May 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786382; cv=none; b=UhozAjcSfAy534pbcHaclNrqmoU6CrJIvvjDguUecinQZDpRFQSRpUy2Yp1C9RcTz5G/+cZriUZTA8m3cuuPSGAGY+7FJ8EAaarOA+Rlh9pZaax3qRnYsfaVn3PxxqWgFuNkbIXqQ6xHZ3lDVYZHAVTEv9B3tPN6wooNa9eTYb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786382; c=relaxed/simple;
	bh=xatkpe2vSXcXIpbbqm020+HAgg0XaXWOakYxbQLw2kQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MrVBML3xA/jc5DhR9/bcBZKZUAFBPlSzeeD8vP28PULpWKWnzvPGe8ebye2VOEQA6JcShiHVaKOIPOVOl1IokhUf+o1xzi6WOkj1HIojnl+GWKKYk6HzR3StX8axYFUPvGTNbYqBNkHUYwiV6Y8ZW/X/lmgYwNiSugwUUB1314Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJnFhLPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ED3C4CEEE;
	Fri,  9 May 2025 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786377;
	bh=xatkpe2vSXcXIpbbqm020+HAgg0XaXWOakYxbQLw2kQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RJnFhLPQnjZYXr5NnPfBIHoHtAufOVNJ7QbEMNSnSPFBnTIIPq7rX021eLm0eIj5X
	 SDPaylO+V9O7Yeym07YygDT4A5EJbdXIZLwo83tsBnkD+WL22wmlK4Y2lxBLHoS4C1
	 03Hw1Zv2JQYgbQyMbsIbmTVyOsA7fhWpLpWIgchahYhgH5dC9hABaaHZC7rtYbPcGq
	 vHrVj3G62hocRcBRH9HEUUiLgwEXK3/2xg2Ln5RNz2JjnckpRDuyejXhDuva/5/Wv1
	 UzypoWQPhN9Q5XzQXkxLmm7V6KNokug1ttUYQyQ97IYD0H2RdzBxjcQx5onC0sPXWe
	 qweSXF14FxBEw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 09 May 2025 12:25:37 +0200
Subject: [PATCH v5 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-work-coredump-socket-v5-5-23c5b14df1bc@kernel.org>
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=12604; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xatkpe2vSXcXIpbbqm020+HAgg0XaXWOakYxbQLw2kQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3tDi+iv54YqGqNr5nZop58w+HPffZJgdG5fVHsbdt
 vH3imV7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiFMvwz8bJ8NL9VcJ8/a/d
 XbR36ogqyR6O0rj7//KfT3fex5tPb2JkmL5kzdasX1u1PxtFPXw+4/W52w9Vwz6s/3wm7PSD7bI
 JzzgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
mask flag. This adds the fields @coredump_mask and @coredump_cookie to
struct pidfd_info.

When a task coredumps the kernel will provide the following information
to userspace in @coredump_mask:

* PIDFD_COREDUMPED is raised if the task did actually coredump.
* PIDFD_COREDUMP_SKIP is raised if the task skipped coredumping (e.g.,
  undumpable).
* PIDFD_COREDUMP_USER is raised if this is a regular coredump and
  doesn't need special care by the coredump server.
* PIDFD_COREDUMP_ROOT is raised if the generated coredump should be
  treated as sensitive and the coredump server should restrict to the
  generated coredump to sufficiently privileged users.

If userspace uses the coredump socket to process coredumps it needs to
be able to discern connection from the kernel from connects from
userspace (e.g., Python generating it's own coredumps and forwarding
them to systemd). The @coredump_cookie extension uses the SO_COOKIE of
the new connection. This allows userspace to validate that the
connection has been made from the kernel by a crashing task:

   fd_coredump = accept4(fd_socket, NULL, NULL, SOCK_CLOEXEC);
   getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd, &fd_peer_pidfd_len);

   struct pidfd_info info = {
           info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
   };

   ioctl(pidfd, PIDFD_GET_INFO, &info);
   /* Refuse connections that aren't from a crashing task. */
   if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED) )
           close(fd_coredump);

   /*
    * Make sure that the coredump cookie matches the connection cookie.
    * If they don't it's not the coredump connection from the kernel.
    * We'll get another connection request in a bit.
    */
   getsocketop(fd_coredump, SOL_SOCKET, SO_COOKIE, &peer_cookie, &peer_cookie_len);
   if (!info.coredump_cookie || (info.coredump_cookie != peer_cookie))
           close(fd_coredump);

The kernel guarantees that by the time the connection is made the all
PIDFD_INFO_COREDUMP info is available.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c              | 37 ++++++++++++++++++++++-
 fs/pidfs.c                 | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/net.h        |  1 +
 include/linux/pidfs.h      | 10 +++++++
 include/uapi/linux/pidfd.h | 22 ++++++++++++++
 net/unix/af_unix.c         |  7 +++++
 6 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d3599d671c51..ff42688ec9ac 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -46,7 +46,9 @@
 #include <linux/pidfs.h>
 #include <linux/net.h>
 #include <linux/socket.h>
+#include <net/af_unix.h>
 #include <net/net_namespace.h>
+#include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 #include <uapi/linux/un.h>
 
@@ -599,6 +601,8 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 		if (IS_ERR(pidfs_file))
 			return PTR_ERR(pidfs_file);
 
+		pidfs_coredump(cp);
+
 		/*
 		 * Usermode helpers are childen of either
 		 * system_unbound_wq or of kthreadd. So we know that
@@ -899,15 +903,46 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto close_fail;
 		}
 
+		/*
+		 * Set the thread-group leader pid which is used for the
+		 * peer credentials during connect() below. Then
+		 * immediately register it in pidfs...
+		 */
+		cprm.pid = task_tgid(current);
+		retval = pidfs_register_pid(cprm.pid);
+		if (retval) {
+			sock_release(socket);
+			goto close_fail;
+		}
+
+		/*
+		 * ... and set the coredump information so userspace
+		 * has it available after connect()...
+		 */
+		pidfs_coredump(&cprm);
+
+		/*
+		 * ... On connect() the peer credentials are recorded
+		 * and @cprm.pid registered in pidfs...
+		 */
 		retval = kernel_connect(socket,
 					(struct sockaddr *)(&coredump_unix_socket),
-					COREDUMP_UNIX_SOCKET_ADDR_SIZE, O_NONBLOCK);
+					COREDUMP_UNIX_SOCKET_ADDR_SIZE, O_NONBLOCK |
+					SOCK_COREDUMP);
+
+		/* ... So we can safely put our pidfs reference now... */
+		pidfs_put_pid(cprm.pid);
+
 		if (retval) {
 			if (retval == -EAGAIN)
 				coredump_report_failure("Skipping as coredump socket connection %s couldn't complete immediately", cn.corename);
 			goto close_fail;
 		}
 
+		/* ... and validate that @sk_peer_pid matches @cprm.pid. */
+		if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid != cprm.pid))
+			goto close_fail;
+
 		cprm.limit = RLIM_INFINITY;
 		cprm.file = no_free_ptr(file);
 #else
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 3b39e471840b..848a12c8f9cf 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -20,6 +20,7 @@
 #include <linux/time_namespace.h>
 #include <linux/utsname.h>
 #include <net/net_namespace.h>
+#include <linux/coredump.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -33,6 +34,8 @@ static struct kmem_cache *pidfs_cachep __ro_after_init;
 struct pidfs_exit_info {
 	__u64 cgroupid;
 	__s32 exit_code;
+	__u32 coredump_mask;
+	__u64 coredump_cookie;
 };
 
 struct pidfs_inode {
@@ -240,6 +243,22 @@ static inline bool pid_in_current_pidns(const struct pid *pid)
 	return false;
 }
 
+static __u32 pidfs_coredump_mask(unsigned long mm_flags)
+{
+	switch (__get_dumpable(mm_flags)) {
+	case SUID_DUMP_USER:
+		return PIDFD_COREDUMP_USER;
+	case SUID_DUMP_ROOT:
+		return PIDFD_COREDUMP_ROOT;
+	case SUID_DUMP_DISABLE:
+		return PIDFD_COREDUMP_SKIP;
+	default:
+		WARN_ON_ONCE(true);
+	}
+
+	return 0;
+}
+
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
@@ -280,6 +299,12 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	}
 
+	if (mask & PIDFD_INFO_COREDUMP) {
+		kinfo.mask |= PIDFD_INFO_COREDUMP;
+		kinfo.coredump_cookie = READ_ONCE(pidfs_i(inode)->__pei.coredump_cookie);
+		kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
+	}
+
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
 		/*
@@ -296,6 +321,15 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!c)
 		return -ESRCH;
 
+	if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
+		task_lock(task);
+		if (task->mm) {
+			kinfo.coredump_cookie = READ_ONCE(pidfs_i(inode)->__pei.coredump_cookie);
+			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
+		}
+		task_unlock(task);
+	}
+
 	/* Unconditionally return identifiers and credentials, the rest only on request */
 
 	user_ns = current_user_ns();
@@ -559,6 +593,47 @@ void pidfs_exit(struct task_struct *tsk)
 	}
 }
 
+#if defined(CONFIG_COREDUMP) && defined(CONFIG_UNIX)
+void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie)
+{
+	struct pidfs_exit_info *exit_info;
+	struct dentry *dentry = pid->stashed;
+	struct inode *inode;
+
+	if (WARN_ON_ONCE(!dentry))
+		return;
+
+	inode = d_inode(dentry);
+	exit_info = &pidfs_i(inode)->__pei;
+	smp_store_release(&exit_info->coredump_cookie, coredump_cookie);
+}
+#endif
+
+#ifdef CONFIG_COREDUMP
+void pidfs_coredump(const struct coredump_params *cprm)
+{
+	struct pid *pid = cprm->pid;
+	struct pidfs_exit_info *exit_info;
+	struct dentry *dentry;
+	struct inode *inode;
+	__u32 coredump_mask = 0;
+
+	dentry = pid->stashed;
+	if (WARN_ON_ONCE(!dentry))
+		return;
+
+	inode = d_inode(dentry);
+	exit_info = &pidfs_i(inode)->__pei;
+	/* Note how we were coredumped. */
+	coredump_mask = pidfs_coredump_mask(cprm->mm_flags);
+	/* Note that we actually did coredump. */
+	coredump_mask |= PIDFD_COREDUMPED;
+	/* If coredumping is set to skip we should never end up here. */
+	VFS_WARN_ON_ONCE(coredump_mask & PIDFD_COREDUMP_SKIP);
+	smp_store_release(&exit_info->coredump_mask, coredump_mask);
+}
+#endif
+
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
 /*
diff --git a/include/linux/net.h b/include/linux/net.h
index 0ff950eecc6b..139c85d0f2ea 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -81,6 +81,7 @@ enum sock_type {
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
+#define SOCK_COREDUMP	O_NOCTTY
 
 #endif /* ARCH_HAS_SOCKET_TYPES */
 
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 2676890c4d0d..497997bc5e34 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -2,11 +2,21 @@
 #ifndef _LINUX_PID_FS_H
 #define _LINUX_PID_FS_H
 
+struct coredump_params;
+
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
 void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
 void pidfs_exit(struct task_struct *tsk);
+#ifdef CONFIG_COREDUMP
+void pidfs_coredump(const struct coredump_params *cprm);
+#endif
+#if defined(CONFIG_COREDUMP) && defined(CONFIG_UNIX)
+void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie);
+#elif defined(CONFIG_UNIX)
+static inline void pidfs_coredump_cookie(struct pid *pid, u64 coredump_cookie) { }
+#endif
 extern const struct dentry_operations pidfs_dentry_operations;
 int pidfs_register_pid(struct pid *pid);
 void pidfs_get_pid(struct pid *pid);
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 8c1511edd0e9..69267c5ae6d0 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -25,9 +25,28 @@
 #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
 #define PIDFD_INFO_EXIT			(1UL << 3) /* Only returned if requested. */
+#define PIDFD_INFO_COREDUMP		(1UL << 4) /* Only returned if requested. */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 
+/*
+ * Values for @coredump_mask in pidfd_info.
+ * Only valid if PIDFD_INFO_COREDUMP is set in @mask.
+ *
+ * Note, the @PIDFD_COREDUMP_ROOT flag indicates that the generated
+ * coredump should be treated as sensitive and access should only be
+ * granted to privileged users.
+ *
+ * If the coredump AF_UNIX socket is used for processing coredumps
+ * @coredump_cookie will be set to the socket SO_COOKIE of the receivers
+ * client socket. This allows the coredump handler to detect whether an
+ * incoming coredump connection was initiated from the crashing task.
+ */
+#define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
+#define PIDFD_COREDUMP_SKIP	(1U << 1) /* coredumping generation was skipped. */
+#define PIDFD_COREDUMP_USER	(1U << 2) /* coredump was done as the user. */
+#define PIDFD_COREDUMP_ROOT	(1U << 3) /* coredump was done as root. */
+
 /*
  * The concept of process and threads in userland and the kernel is a confusing
  * one - within the kernel every thread is a 'task' with its own individual PID,
@@ -92,6 +111,9 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__s32 exit_code;
+	__u32 coredump_mask;
+	__u32 __spare1;
+	__u64 coredump_cookie;
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 05e5a4737333..294667b572ee 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -101,6 +101,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <linux/sock_diag.h>
 #include <linux/coredump.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
@@ -753,6 +754,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 struct unix_peercred {
 	struct pid *peer_pid;
+	u64 cookie;
 	const struct cred *peer_cred;
 };
 
@@ -788,6 +790,8 @@ static void drop_peercred(struct unix_peercred *peercred)
 static inline void init_peercred(struct sock *sk,
 				 const struct unix_peercred *peercred)
 {
+	if (peercred->cookie)
+		pidfs_coredump_cookie(peercred->peer_pid, peercred->cookie);
 	sk->sk_peer_pid = peercred->peer_pid;
 	sk->sk_peer_cred = peercred->peer_cred;
 }
@@ -1699,6 +1703,9 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	unix_peer(newsk)	= sk;
 	newsk->sk_state		= TCP_ESTABLISHED;
 	newsk->sk_type		= sk->sk_type;
+	/* Prepare a new socket cookie for the receiver. */
+	if (flags & SOCK_COREDUMP)
+		peercred.cookie = sock_gen_cookie(newsk);
 	init_peercred(newsk, &peercred);
 	newu = unix_sk(newsk);
 	newu->listener = other;

-- 
2.47.2


