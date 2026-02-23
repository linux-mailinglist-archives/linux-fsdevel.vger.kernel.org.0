Return-Path: <linux-fsdevel+bounces-77927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBfZLQ8wnGkKAgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:46:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331AF175184
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C30A305F3D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C943612E2;
	Mon, 23 Feb 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqzNXBaC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6035CB62;
	Mon, 23 Feb 2026 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843520; cv=none; b=KtkYtgDkVH3P5CB8zBLeAn3FxrTZx8MVK3NaSG3ZMyDGVRgBJZRWv6EFtjgRrTN/aQJJDORsdw63ztb6n+RvsTSzyYZxtw1jYMJvfvXwftzBaeyjgUqam3GsfrlUQq70J/bE0imIArcQnUXhqyzOfFnunvB0UX4MLATlwXo/HKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843520; c=relaxed/simple;
	bh=G9Ydli7QKvtsbpSo/CDuprfDiZcxvPIHl0VZ9Lcvnes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9tUGTPy2u3TTzh3//sMYtuCW411VUpQOHCGam50Jr/ZYokzEfOPrEdDxZS7I9TCgbA6+Rmd6EUiZHbPQZzsxY/S+BL84CMYNHElfmMVXbFDI3TE/uaONtlVqiVTXBIwrReYsCJXcFX7iVV1sDKov/vmZol7ZWah/ZGbV3EgWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqzNXBaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EF3C116C6;
	Mon, 23 Feb 2026 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771843520;
	bh=G9Ydli7QKvtsbpSo/CDuprfDiZcxvPIHl0VZ9Lcvnes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UqzNXBaCPmn+pjJvrC+glFFj38r/TAxOywttV0MxHRmomNQzFhEjAbQtJV76eeTrT
	 ni0pQMf5Og3/gNE/HreMA3DUn8vPxB0wByVlNucf8MA2Zj9Jun8K+4Fi94AICUdBql
	 4Kz74MZzGzTmzhWPkViBwBnMtNHrRbqrxkEscOBHBZlnV+Of5IyXOvuqPIIyDVmah2
	 uxHvcAcreFnUiOMePrZm3deaGDYApKo62rgcSAve8KOdcVer9CAhx9gN9UGDrtLPqe
	 krrduPojYLFZZdaBHEhs2pbJBLR0YpOX3cMivtZKics8v4godus1cYDzyyNoqKNMdD
	 gbdFeeaCwE+vw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Feb 2026 11:44:59 +0100
Subject: [PATCH v4 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-work-pidfs-autoreap-v4-2-e393c08c09d1@kernel.org>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
In-Reply-To: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=7528; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G9Ydli7QKvtsbpSo/CDuprfDiZcxvPIHl0VZ9Lcvnes=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO0d+Z+2jtIbftl/hr9s1qUc3x293M3fj5sNTa1F9uO
 g8dOm9UdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkiyIjw6TOjGsnJ2krZbMr
 thv9PZtycyXDlFMhT8IvPy4xFzFQzWNkuMGqPu/r7CKmNcZ3duvqr/wQ+91u+aYAuV5m1T3PE3+
 kcwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77927-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 331AF175184
X-Rspamd-Action: no action

Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
lifetime to the pidfd returned from clone3(). When the last reference to
the struct file created by clone3() is closed the kernel sends SIGKILL
to the child. A pidfd obtained via pidfd_open() for the same process
does not keep the child alive and does not trigger autokill - only the
specific struct file from clone3() has this property.

This is useful for container runtimes, service managers, and sandboxed
subprocess execution - any scenario where the child must die if the
parent crashes or abandons the pidfd.

CLONE_PIDFD_AUTOKILL requires both CLONE_PIDFD (the whole point is tying
lifetime to the pidfd file) and CLONE_AUTOREAP (a killed child with no
one to reap it would become a zombie). CLONE_THREAD is rejected because
autokill targets a process not a thread.

The clone3 pidfd is identified by the PIDFD_AUTOKILL file flag set on
the struct file at clone3() time. The pidfs .release handler checks this
flag and sends SIGKILL via do_send_sig_info(SIGKILL, SEND_SIG_PRIV, ...)
only when it is set. Files from pidfd_open() or open_by_handle_at() are
distinct struct files that do not carry this flag. dup()/fork() share the
same struct file so they extend the child's lifetime until the last
reference drops.

CLONE_PIDFD_AUTOKILL automatically sets no_new_privs on the child
process. This ensures the child cannot escalate privileges beyond the
parent's credential level via setuid/setgid exec. Because the child can
never outprivilege the parent the autokill SIGKILL is always within the
parent's natural authority.

This is a deliberate departure from the pdeath_signal model which is
reset during secureexec and commit_creds() rendering it useless for
container runtimes that need to deprivilege themselves. Setting
no_new_privs on the child avoids the need for any such magical resets:
the kill-on-close contract is absolute.

The no_new_privs restriction only affects the child. The parent retains
its full privileges and can continue to execute setuid binaries.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 38 ++++++++++++++++++++++++++++++++------
 include/uapi/linux/pidfd.h |  1 +
 include/uapi/linux/sched.h |  1 +
 kernel/fork.c              | 22 +++++++++++++++++++---
 4 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 318253344b5c..a8d1bca0395d 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -8,6 +8,8 @@
 #include <linux/mount.h>
 #include <linux/pid.h>
 #include <linux/pidfs.h>
+#include <linux/sched/signal.h>
+#include <linux/signal.h>
 #include <linux/pid_namespace.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
@@ -637,7 +639,28 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return open_namespace(ns_common);
 }
 
+static int pidfs_file_release(struct inode *inode, struct file *file)
+{
+	struct pid *pid = inode->i_private;
+	struct task_struct *task;
+
+	if (!(file->f_flags & PIDFD_AUTOKILL))
+		return 0;
+
+	guard(rcu)();
+	task = pid_task(pid, PIDTYPE_TGID);
+	if (!task)
+		return 0;
+
+	/* Not available for kthreads or user workers for now. */
+	if (WARN_ON_ONCE(task->flags & (PF_KTHREAD | PF_USER_WORKER)))
+		return 0;
+	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_TGID);
+	return 0;
+}
+
 static const struct file_operations pidfs_file_operations = {
+	.release	= pidfs_file_release,
 	.poll		= pidfd_poll,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= pidfd_show_fdinfo,
@@ -1093,11 +1116,11 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	int ret;
 
 	/*
-	 * Ensure that PIDFD_STALE can be passed as a flag without
-	 * overloading other uapi pidfd flags.
+	 * Ensure that internal pidfd flags don't overlap with each
+	 * other or with uapi pidfd flags.
 	 */
-	BUILD_BUG_ON(PIDFD_STALE == PIDFD_THREAD);
-	BUILD_BUG_ON(PIDFD_STALE == PIDFD_NONBLOCK);
+	BUILD_BUG_ON(hweight32(PIDFD_THREAD | PIDFD_NONBLOCK |
+				PIDFD_STALE | PIDFD_AUTOKILL) != 4);
 
 	ret = path_from_stashed(&pid->stashed, pidfs_mnt, get_pid(pid), &path);
 	if (ret < 0)
@@ -1108,9 +1131,12 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 	flags &= ~PIDFD_STALE;
 	flags |= O_RDWR;
 	pidfd_file = dentry_open(&path, flags, current_cred());
-	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
+	/*
+	 * Raise PIDFD_THREAD and PIDFD_AUTOKILL explicitly as
+	 * do_dentry_open() strips O_EXCL and O_TRUNC.
+	 */
 	if (!IS_ERR(pidfd_file))
-		pidfd_file->f_flags |= (flags & PIDFD_THREAD);
+		pidfd_file->f_flags |= (flags & (PIDFD_THREAD | PIDFD_AUTOKILL));
 
 	return pidfd_file;
 }
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index ea9a6811fc76..9281956a9f32 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -13,6 +13,7 @@
 #ifdef __KERNEL__
 #include <linux/sched.h>
 #define PIDFD_STALE CLONE_PIDFD
+#define PIDFD_AUTOKILL O_TRUNC
 #endif
 
 /* Flags for pidfd_send_signal(). */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 8a22ea640817..b1aea8a86e2f 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -37,6 +37,7 @@
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 #define CLONE_AUTOREAP 0x400000000ULL /* Auto-reap child on exit. */
+#define CLONE_PIDFD_AUTOKILL 0x800000000ULL /* Kill child when clone pidfd closes. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index 0dedf2999f0c..778aed24e01d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2037,6 +2037,15 @@ __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
+	if (clone_flags & CLONE_PIDFD_AUTOKILL) {
+		if (!(clone_flags & CLONE_PIDFD))
+			return ERR_PTR(-EINVAL);
+		if (!(clone_flags & CLONE_AUTOREAP))
+			return ERR_PTR(-EINVAL);
+		if (clone_flags & CLONE_THREAD)
+			return ERR_PTR(-EINVAL);
+	}
+
 	/*
 	 * Force any signals received before this point to be delivered
 	 * before the fork happens.  Collect up signals sent to multiple
@@ -2259,13 +2268,20 @@ __latent_entropy struct task_struct *copy_process(
 	 * if the fd table isn't shared).
 	 */
 	if (clone_flags & CLONE_PIDFD) {
-		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
+		unsigned flags = PIDFD_STALE;
+
+		if (clone_flags & CLONE_THREAD)
+			flags |= PIDFD_THREAD;
+		if (clone_flags & CLONE_PIDFD_AUTOKILL) {
+			task_set_no_new_privs(p);
+			flags |= PIDFD_AUTOKILL;
+		}
 
 		/*
 		 * Note that no task has been attached to @pid yet indicate
 		 * that via CLONE_PIDFD.
 		 */
-		retval = pidfd_prepare(pid, flags | PIDFD_STALE, &pidfile);
+		retval = pidfd_prepare(pid, flags, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
 		pidfd = retval;
@@ -2909,7 +2925,7 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
 	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
-	      CLONE_AUTOREAP))
+	      CLONE_AUTOREAP | CLONE_PIDFD_AUTOKILL))
 		return false;
 
 	/*

-- 
2.47.3


