Return-Path: <linux-fsdevel+bounces-49245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351CAB9AF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1610350444D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C624169B;
	Fri, 16 May 2025 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHYq3n6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F824166E;
	Fri, 16 May 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394773; cv=none; b=p0CaV+Iyx3S/etQRjsuQomtfzF7dJgkCa/sjDZ9shATDMnTOWMZx3i991gBVhDc8AlKrMLR7xR4g9w9MwUvjpD9w6uwq0vcCsNNtXcW/3OXocJFo6O8gAf7jhYlHbBumNkd87/f9t6Yq8+jV9tq+7Gc1vfoXzKQbwxcHo29WppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394773; c=relaxed/simple;
	bh=lBq5fYSvXf+MUseDlW1solvXpXQVzOG148v6Vygqtuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSSvU6ubYFXeNhjDU5/w987c5IBFBM3OrDkc04wThWgGfHGhwO+TeBfetiWVVg5RaplvOjSXrU4imJJis62DLldi+OzQhjb2w/K8s9rvBohkciSq67jfXLRnrjifqtwQh82hYq3WAYZIsVOqJkiiZmNiQWdaIPMh61dowiXn/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHYq3n6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED7AC4CEEF;
	Fri, 16 May 2025 11:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394772;
	bh=lBq5fYSvXf+MUseDlW1solvXpXQVzOG148v6Vygqtuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZHYq3n6KxJpCo/J+fIsddX1zWKvl3pCFecvBstZBJUARnmoGkmlB6urJqK+mlsTPI
	 5eEJ5t4CdDwcdOaLXDlg6tQpJoNmuw/CA6n4O0uHRmbUdjX6RCXBnp2n99CTZnRJay
	 HSWhu4kVUjWCR5sVKno43FMgqR6MEgayJCiyuYVYWs1MVMpxeJZOanyYuDCjbz8lTF
	 9FeFmjVK8Yu4HMStCCPlfUJDBqHmorw3CKaaM5QpQU/fN1BE5Ct4kzpo/Zq65qKx1h
	 jgS9mUH5alpWD+mH2A/5ZzIljgfGH4iH6aPDy/a+iEyWXAWuJVu9tcI+2nu4ZpwHBX
	 JmX58ZqoGO0ug==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 May 2025 13:25:32 +0200
Subject: [PATCH v8 5/9] pidfs, coredump: add PIDFD_INFO_COREDUMP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-work-coredump-socket-v8-5-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=8340; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lBq5fYSvXf+MUseDlW1solvXpXQVzOG148v6Vygqtuk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2y9ohYvpqD+9dPs/ycXnH+fu8fuukCl5g/tSQd1H
 1asKHRj6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjInlRGhovircIhPhOUj1g3
 hD67YT6nLe3gWXuvc/Ldsp6pF3Rb7zAyXLVp71v4TcE/xuLHg9j1qSq5FxZXBTted64oa562k9W
 SEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extend the PIDFD_INFO_COREDUMP ioctl() with the new PIDFD_INFO_COREDUMP
mask flag. This adds the @coredump_mask field to struct pidfd_info.

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

The kernel guarantees that by the time the connection is made the all
PIDFD_INFO_COREDUMP info is available.

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c              | 31 ++++++++++++++++++++++++++
 fs/pidfs.c                 | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h      |  5 +++++
 include/uapi/linux/pidfd.h | 16 ++++++++++++++
 4 files changed, 107 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 6eaf2ff89af8..48064b1d6305 100644
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
 
@@ -590,6 +592,8 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 		if (IS_ERR(pidfs_file))
 			return PTR_ERR(pidfs_file);
 
+		pidfs_coredump(cp);
+
 		/*
 		 * Usermode helpers are childen of either
 		 * system_unbound_wq or of kthreadd. So we know that
@@ -866,8 +870,31 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (IS_ERR(file))
 			goto close_fail;
 
+		/*
+		 * Set the thread-group leader pid which is used for the
+		 * peer credentials during connect() below. Then
+		 * immediately register it in pidfs...
+		 */
+		cprm.pid = task_tgid(current);
+		retval = pidfs_register_pid(cprm.pid);
+		if (retval)
+			goto close_fail;
+
+		/*
+		 * ... and set the coredump information so userspace
+		 * has it available after connect()...
+		 */
+		pidfs_coredump(&cprm);
+
 		retval = kernel_connect(socket, (struct sockaddr *)(&addr),
 					addr_len, O_NONBLOCK | SOCK_COREDUMP);
+
+		/*
+		 * ... Make sure to only put our reference after connect() took
+		 * its own reference keeping the pidfs entry alive ...
+		 */
+		pidfs_put_pid(cprm.pid);
+
 		if (retval) {
 			if (retval == -EAGAIN)
 				coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
@@ -876,6 +903,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
index 3b39e471840b..c0069fd52dd4 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -20,6 +20,7 @@
 #include <linux/time_namespace.h>
 #include <linux/utsname.h>
 #include <net/net_namespace.h>
+#include <linux/coredump.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -33,6 +34,7 @@ static struct kmem_cache *pidfs_cachep __ro_after_init;
 struct pidfs_exit_info {
 	__u64 cgroupid;
 	__s32 exit_code;
+	__u32 coredump_mask;
 };
 
 struct pidfs_inode {
@@ -240,6 +242,22 @@ static inline bool pid_in_current_pidns(const struct pid *pid)
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
@@ -280,6 +298,11 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 	}
 
+	if (mask & PIDFD_INFO_COREDUMP) {
+		kinfo.mask |= PIDFD_INFO_COREDUMP;
+		kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
+	}
+
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
 		/*
@@ -296,6 +319,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!c)
 		return -ESRCH;
 
+	if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
+		task_lock(task);
+		if (task->mm)
+			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
+		task_unlock(task);
+	}
+
 	/* Unconditionally return identifiers and credentials, the rest only on request */
 
 	user_ns = current_user_ns();
@@ -559,6 +589,31 @@ void pidfs_exit(struct task_struct *tsk)
 	}
 }
 
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
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 2676890c4d0d..77e7db194914 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -2,11 +2,16 @@
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
 extern const struct dentry_operations pidfs_dentry_operations;
 int pidfs_register_pid(struct pid *pid);
 void pidfs_get_pid(struct pid *pid);
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 8c1511edd0e9..c27a4e238e4b 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -25,9 +25,23 @@
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
+ */
+#define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
+#define PIDFD_COREDUMP_SKIP	(1U << 1) /* coredumping generation was skipped. */
+#define PIDFD_COREDUMP_USER	(1U << 2) /* coredump was done as the user. */
+#define PIDFD_COREDUMP_ROOT	(1U << 3) /* coredump was done as root. */
+
 /*
  * The concept of process and threads in userland and the kernel is a confusing
  * one - within the kernel every thread is a 'task' with its own individual PID,
@@ -92,6 +106,8 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__s32 exit_code;
+	__u32 coredump_mask;
+	__u32 __spare1;
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF

-- 
2.47.2


