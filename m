Return-Path: <linux-fsdevel+bounces-48404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C39AAE67C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E350A1889C1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326A28DF1B;
	Wed,  7 May 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxNHRlyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DD28C2A2;
	Wed,  7 May 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634463; cv=none; b=QNJrYm8FPFWpHlWTHFBzVvZeXRhJnGI5c9beUA1YWhPBybNMJPpOo14YLwkRC7rCD358iaslZAC4l4BilUs6w5odRoUhpnKjmBFKrXsqRR5oDJ+K3s+qp52jf+MmPRIvkcma9lii2hWZviD4sH7RBiOkbWB9obsB6lCuJkKyafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634463; c=relaxed/simple;
	bh=NYTbVvw3ZuT5alPL+WDMuYmSB/1HpQbdNb1rA9c0OX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ss1xYlJ71wV27aHjLMRfcvyESt0GYUm9Rv7sQVM6Kl6X/iZcpchTr5rsvgHyE1GCfr5F5tEqil24fp8Pihq0702HDbyprQY+BBNBjSmXw2q9rNBgyQJZcA5gFyf2o8v+cRuJfjwbTVgr2/YL5kd1vro9tcp1F/NbKoQABISISrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxNHRlyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9126C4CEE2;
	Wed,  7 May 2025 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634463;
	bh=NYTbVvw3ZuT5alPL+WDMuYmSB/1HpQbdNb1rA9c0OX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WxNHRlyvdLfI1FNQKDABcH2YogdaieciSKxk2VORAZPcYfrpR+Vtw/kgCv/SVo/lJ
	 1PdxHIQclsv+zv1MEpbRC3TPmqv9ohC+BC+sAjKpmlSR1KBspD2iZ5pZ6MB15rRePQ
	 OgRfFLPO26LIM2RBhyNLNWcdd3xPHz8q9Fd8vS0rp3Sym4SddNoaCzDFhYSHhJAzwO
	 Uz/u1EXotf9eHHGbPQdnFs+xho3ttkiraXAUKbHww7B+LFXSfgDX0hrE9t6DfqbAY9
	 e9hZq5afYoK8tVvpKcsQ1EbjPD8QD8sinDCWrwScdNmk48rG60+3HHJabldi+2ebhe
	 fPXlsdoEI7i5w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:41 +0200
Subject: [PATCH v4 08/11] pidfs, coredump: add PIDFD_INFO_COREDUMP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-8-af0ef317b2d0@kernel.org>
References: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
In-Reply-To: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
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
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NYTbVvw3ZuT5alPL+WDMuYmSB/1HpQbdNb1rA9c0OX8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt20N6z45ITHngq3pIimjXXdFzRhzEqcdnHdh8/nwc
 zs3Z29y6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIiUZGhtsfDa8ulX237lNu
 7XSX9J/9L34tnjRNQFSmJ/jXiZRls/0ZGf7fe8o/UWCrW5nEDFOfAPlV1S0b5Xw9ne5rNCYzds9
 4wQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Let userspace know that the task coredumped and whether it was dumped as
root or as regular user. The latter is needed so that access permissions
to the executable are correctly handled.

I don't think this requires any additional privileges checks. The
missing exposure of the dumpability attribute of a given task is an
issue we should fix given that we already expose whether a task is
coredumping or not.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c              | 36 ++++++++++++++++++++++++++++++
 fs/pidfs.c                 | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h      |  3 +++
 include/uapi/linux/pidfd.h | 16 ++++++++++++++
 4 files changed, 110 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index e1e6f02e0ed7..ddff1854988f 100644
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
@@ -879,15 +883,47 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
 					COREDUMP_UNIX_SOCKET_ADDR_SIZE, O_NONBLOCK);
+
+		/*
+		 * ... So we can safely put our pidfs reference now...
+		 */
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
index 3b39e471840b..8c4d83fb115b 100644
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
 
+void pidfs_coredump(const struct coredump_params *cprm)
+{
+	struct pid *pid = cprm->pid;
+	struct pidfs_exit_info *exit_info;
+	struct dentry *dentry;
+	struct inode *inode;
+	__u32 coredump_mask = 0;
+
+	dentry = stashed_dentry_get(&pid->stashed);
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
+	/* Fwiw, this cannot be the last reference. */
+	dput(dentry);
+}
+
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
 /*
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 2676890c4d0d..f7729b9371bc 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -2,11 +2,14 @@
 #ifndef _LINUX_PID_FS_H
 #define _LINUX_PID_FS_H
 
+struct coredump_params;
+
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
 void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
 void pidfs_exit(struct task_struct *tsk);
+void pidfs_coredump(const struct coredump_params *cprm);
 extern const struct dentry_operations pidfs_dentry_operations;
 int pidfs_register_pid(struct pid *pid);
 void pidfs_get_pid(struct pid *pid);
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 8c1511edd0e9..84ac709f560c 100644
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
+ * Only valid if PIDFD_INFO_SUID_COREDUMP is set in @mask.
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


