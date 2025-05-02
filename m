Return-Path: <linux-fsdevel+bounces-47918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866DAA726D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B654C6C9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE32566D2;
	Fri,  2 May 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJT/EH56"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C802561D4;
	Fri,  2 May 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189787; cv=none; b=U/T27peU4f/wT5JTdIApwUDj8isJYdg48Ec4dLb/Nm+bG/Fl47wfalI16+tyhIpEyIlle1rErwckChIfDs5kWmcWLTJwW1HYxf+LdxmuFyDPn0g7KuIsXnclpSaRvT0T9V9dmRT3tn8aGery5F/kpqGqyC9cYW+pXPKHRgatB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189787; c=relaxed/simple;
	bh=Q+HdCX2y54OlEoGDyCxnEP5wtN8IQL7luYDJY8KMhvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyyDH+l7f9icqB3ru0d5aVGFiGzZIuLCAi7s/l6N/1GV2hHH/sQB9VOPQ+GnDbV48Z3lQNF9p0SkzK2LlSMApMWXtAexDYLn+WIy2rrJ5m2nhsULhQvzwfaUZn1UtpA9ehHl1nk7Zch2WmfaAqkiKwekr7oH/perua+L3vBXAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJT/EH56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22284C4CEEB;
	Fri,  2 May 2025 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746189787;
	bh=Q+HdCX2y54OlEoGDyCxnEP5wtN8IQL7luYDJY8KMhvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hJT/EH56YF0tFr1a5Ft92cdpoOK90Gr51NzmVkRhJBJk10YMJjWFViFrQQHcUNyjR
	 VsImmr8Q1eM8bR9CCLUS1mmWv68iOlqljrhzQg1ju3G4XTEjeQgORxxGZTJg1g10Bg
	 IPggo2HLspXm5KugsRDc+MlUb4vJcDdE589+mj+6gn1ejSCyOLrQAsABAnoCjr62+Z
	 d7efoBqEIzkqNJM7Cb2fjT7R4rwJIPBYtrWAem08F7l9ECHuLn+knop2Vev+eF7ZWI
	 KcL9xHbxMThE1SBXk7SUPhVRAKDSn9Jhd4M/qx+BlhV2pKVj7StsUe+s76+mYGXbgM
	 zRL+E9EbfdFtg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 May 2025 14:42:36 +0200
Subject: [PATCH RFC v2 5/6] pidfs, coredump: add PIDFD_INFO_COREDUMP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-work-coredump-socket-v2-5-43259042ffc7@kernel.org>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6369; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Q+HdCX2y54OlEoGDyCxnEP5wtN8IQL7luYDJY8KMhvs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSI7D0Qf9p20QeNRrGnfaWCbVoJSZrxRvs1v6feMTEsO
 HtAac6ZjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8jWD4Z+m2ZvL9ordSITXS
 D3epbTDaMM3ztI/gvujGhmtuTz7saWb4p8PfvOy69NdMn7O/Wn923T5ReTfYdc1Rd+dLGSYc74+
 YcwAA
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
 fs/coredump.c              |  5 ++++
 fs/pidfs.c                 | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h      |  3 +++
 include/uapi/linux/pidfd.h | 11 +++++++++
 4 files changed, 77 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1c7428c23878..735b5b94c518 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -48,6 +48,7 @@
 #include <linux/net.h>
 #include <uapi/linux/un.h>
 #include <linux/socket.h>
+#include <net/sock.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -594,6 +595,8 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 		if (IS_ERR(pidfs_file))
 			return PTR_ERR(pidfs_file);
 
+		pidfs_coredump(cp);
+
 		/*
 		 * Usermode helpers are childen of either
 		 * system_unbound_wq or of kthreadd. So we know that
@@ -904,6 +907,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto close_fail;
 
 		cprm.limit = RLIM_INFINITY;
+		cprm.pid = task_tgid(current);
+		pidfs_coredump(&cprm);
 #endif
 		cprm.file = no_free_ptr(file);
 		break;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 3b39e471840b..c891f4ef9c38 100644
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
+	__s32 coredump_mask;
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
@@ -292,6 +310,21 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		goto copy_out;
 	}
 
+	/*
+	 * Should we require privilege to access that information? Seems
+	 * pointless because we already expose whether a task is
+	 * coredumping in /proc/<pid>/status.
+	 */
+	if (mask & PIDFD_INFO_COREDUMP) {
+		kinfo.mask |= PIDFD_INFO_COREDUMP;
+		kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
+		if (!kinfo.coredump_mask) {
+			task_lock(task);
+			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
+			task_unlock(task);
+		}
+	}
+
 	c = get_task_cred(task);
 	if (!c)
 		return -ESRCH;
@@ -559,6 +592,31 @@ void pidfs_exit(struct task_struct *tsk)
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
index 8c1511edd0e9..b7c831f4cf4b 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -25,9 +25,19 @@
 #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
 #define PIDFD_INFO_EXIT			(1UL << 3) /* Only returned if requested. */
+#define PIDFD_INFO_COREDUMP		(1UL << 4) /* Only returned if requested. */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 
+/*
+ * Values for @coredump_mask in pidfd_info.
+ * Only valid if PIDFD_INFO_SUID_COREDUMP is set in @mask.
+ */
+#define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
+#define PIDFD_COREDUMP_SKIP	(1U << 1) /* coredumping generation was skipped. */
+#define PIDFD_COREDUMP_USER	(1U << 2) /* coredump was done as the user. */
+#define PIDFD_COREDUMP_ROOT	(1U << 3) /* coredump was done as root. */
+
 /*
  * The concept of process and threads in userland and the kernel is a confusing
  * one - within the kernel every thread is a 'task' with its own individual PID,
@@ -92,6 +102,7 @@ struct pidfd_info {
 	__u32 fsuid;
 	__u32 fsgid;
 	__s32 exit_code;
+	__u32 coredump_mask;
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF

-- 
2.47.2


