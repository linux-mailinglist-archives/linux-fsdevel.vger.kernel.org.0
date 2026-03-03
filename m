Return-Path: <linux-fsdevel+bounces-79231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA0lG2fopmlWZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:55:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DF1F0D47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B2663077145
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC836605F;
	Tue,  3 Mar 2026 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6UJFgX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC6368976;
	Tue,  3 Mar 2026 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545788; cv=none; b=ZQDcXrCcaBUjeZ2LkfU8QXCVCRqsMVTJ1ZqHTT4r2WQKKSW578m2I2f+ARJFDBIYtAAZVWr2t9Ew7qgMIRhqlReVXXKPrQuBfIdD+ZmcgCAHXBH/sxYujpQSqPir+qLEi3o30kg9HIaKmZJWERiwAM8KNPZVBnIkDw24kDlqRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545788; c=relaxed/simple;
	bh=xWc1SYhagsFIDcFD1Ftyff0sKkkiatJdtEEz/BrQlu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nERYc3aYMJwyk12gPZIYxWWBtSPL3Vl6pZSlR8XvQ21kh6zIWV1R0LoLo5i8JE64C676+KluLBLdQE0hVMLdMuos73BQsi1pbFew8jTRdrrTfVl4NrYdAya71hORf38Bi8eInehBkbpTW6cR+KLj3jjh/T3dP17jKw5uoOam5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6UJFgX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4117C2BCAF;
	Tue,  3 Mar 2026 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545787;
	bh=xWc1SYhagsFIDcFD1Ftyff0sKkkiatJdtEEz/BrQlu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I6UJFgX3ETgpJRUabnKnCKeS3y3BTYQTmNPCdjeYA1TUGdjIaWFp12INNy9U0iJ6b
	 3OwaymS1YWZWJc+Yey3dZads/5t7Xaj2ozzOz95rdt17n5TZOA6Bm1L3ZT5fYx45Ti
	 E/nVWlnY/l/WkBGCl3NH6rUtMnZtAXoL3/blXOa9QkE4FSSOCh4ArUJbBiaEJvlN7L
	 vQToiagtJH+XTpkGGGZrN7j8BpmAf4lWL/MhQw5SBa25sllxCLJeqyVZUmY2sF1vx5
	 VqdMeXHFVTOvxombxAbi9hR0fOfAnIdM6tCZPophF3NMDPMis693dtFv/NIZg1RIdD
	 F/GsnxciPK2uQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:22 +0100
Subject: [PATCH RFC DRAFT POC 11/11] fs: isolate all kthreads in nullfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-11-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9100; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xWc1SYhagsFIDcFD1Ftyff0sKkkiatJdtEEz/BrQlu0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3bP7UYr29pnt0xuprRP+CBQtHDqiyubtk7xFlPVN
 P70VNz2QEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE3rEw/JU+ccosULbBSqdX
 4a1Y7OXOcieXetebbQXCtatcp67KTGRkmLFyzoQDffON2K2Cs6TcPSUkXX0uaK577SV5knv7n3x
 JbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 051DF1F0D47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79231-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Leave all kthreads isolated in nullfs and move userspace init into its
separate fs_struct that any kthread can grab on demand to perform
lookup. This isolates kthreads from userspace filesystem state quite a
bit and makes it hard for anyone to mess up when performing filesystem
operations from kthreads. Without LOOKUP_IN_INIT they will just not be
able to do anything at all: no lookup or creation.

Add a new struct kernel_clone_args extension that allows to create a
task that shares init's filesystem state. This is only going to be used
by user_mode_thread() which execute stuff in init's filesystem state.
That concept should go away.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c             | 49 +++++++++++++++++++++++++++++++++++++++++++---
 fs/namei.c                 |  4 ++--
 fs/namespace.c             |  4 ----
 include/linux/fs_struct.h  |  1 +
 include/linux/init_task.h  |  1 +
 include/linux/sched/task.h |  1 +
 init/main.c                | 10 +++++++++-
 kernel/fork.c              | 26 +++++++++++++++++++++---
 8 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 64b5840131cb..164139c27380 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -8,6 +8,7 @@
 #include <linux/fs_struct.h>
 #include <linux/init_task.h>
 #include "internal.h"
+#include "mount.h"
 
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
@@ -160,13 +161,30 @@ EXPORT_SYMBOL_GPL(unshare_fs_struct);
  * fs_struct state. Breaking that contract sucks for both sides.
  * So just don't bother with extra work for this. No sane init
  * system should ever do this.
+ *
+ * On older kernels if PID 1 unshared its filesystem state with us the
+ * kernel simply used the stale fs_struct state implicitly pinning
+ * anything that PID 1 had last used. Even if PID 1 might've moved on to
+ * some completely different fs_struct state and might've even unmounted
+ * the old root.
+ *
+ * This has hilarious consequences: Think continuing to dump coredump
+ * state into an implicitly pinned directory somewhere. Calling random
+ * binaries in the old rootfs via usermodehelpers.
+ *
+ * Be aggressive about this: We simply reject operating on stale
+ * fs_struct state by reverting to nullfs. Every kworker that does
+ * lookups after this point will fail. Every usermodehelper call will
+ * fail. Tough luck but let's be kind and emit a warning to userspace.
  */
 static inline bool nullfs_userspace_init(void)
 {
 	struct fs_struct *fs = current->fs;
 
-	if (unlikely(current->pid == 1) && fs != &init_fs) {
+	if (unlikely(current->pid == 1) && fs != &userspace_init_fs) {
 		pr_warn("VFS: Pid 1 stopped sharing filesystem state\n");
+		set_fs_root(&userspace_init_fs, &init_fs.root);
+		set_fs_pwd(&userspace_init_fs, &init_fs.root);
 		return true;
 	}
 
@@ -186,7 +204,9 @@ struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
 		new_fs = fs;
 	read_sequnlock_excl(&fs->seq);
 
-	nullfs_userspace_init();
+	/* one reference belongs to us */
+	if (nullfs_userspace_init())
+		return NULL;
 	return new_fs;
 }
 
@@ -197,8 +217,31 @@ struct fs_struct init_fs = {
 	.umask		= 0022,
 };
 
+struct fs_struct userspace_init_fs = {
+	.users		= 1,
+	.seq		= __SEQLOCK_UNLOCKED(userspace_init_fs.seq),
+	.umask		= 0022,
+};
+
 void init_root(struct path *root)
 {
-	get_fs_root(&init_fs, root);
+	get_fs_root(&userspace_init_fs, root);
 }
 EXPORT_SYMBOL_GPL(init_root);
+
+void __init init_userspace_fs(void)
+{
+	struct mount *m;
+	struct path root;
+
+	/* Move PID 1 from nullfs into the initramfs. */
+	m = topmost_overmount(current->nsproxy->mnt_ns->root);
+	root.mnt = &m->mnt;
+	root.dentry = root.mnt->mnt_root;
+
+	VFS_WARN_ON_ONCE(current->fs != &init_fs);
+	VFS_WARN_ON_ONCE(current->pid != 1);
+	set_fs_root(&userspace_init_fs, &root);
+	set_fs_pwd(&userspace_init_fs, &root);
+	switch_fs_struct(&userspace_init_fs);
+}
diff --git a/fs/namei.c b/fs/namei.c
index 976b1e9f7032..6cc53040e9eb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1102,7 +1102,7 @@ static int set_root(struct nameidata *nd)
 	struct fs_struct *fs;
 
 	if (nd->flags & LOOKUP_IN_INIT)
-		fs = &init_fs;
+		fs = &userspace_init_fs;
 	else
 		fs = current->fs;
 
@@ -2724,7 +2724,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		struct fs_struct *fs;
 
 		if (nd->flags & LOOKUP_IN_INIT)
-			fs = &init_fs;
+			fs = &userspace_init_fs;
 		else
 			fs = current->fs;
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..10056ac1dcd2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6190,10 +6190,6 @@ static void __init init_mount_tree(void)
 
 	init_task.nsproxy->mnt_ns = &init_mnt_ns;
 	get_mnt_ns(&init_mnt_ns);
-
-	/* The root and pwd always point to the mutable rootfs. */
-	root.mnt	= mnt;
-	root.dentry	= mnt->mnt_root;
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
 
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 8ff1acd8389d..5c40fdc39550 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -50,5 +50,6 @@ static inline int current_umask(void)
 }
 
 void init_root(struct path *root);
+void __init init_userspace_fs(void);
 
 #endif /* _LINUX_FS_STRUCT_H */
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index a6cb241ea00c..f27f88598394 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -24,6 +24,7 @@
 
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
+extern struct fs_struct userspace_init_fs;
 extern struct nsproxy init_nsproxy;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 41ed884cffc9..e0c1ca8c6a18 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -31,6 +31,7 @@ struct kernel_clone_args {
 	u32 io_thread:1;
 	u32 user_worker:1;
 	u32 no_files:1;
+	u32 umh:1;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
diff --git a/init/main.c b/init/main.c
index 1cb395dd94e4..ca0d0914c63e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -102,6 +102,7 @@
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
+#include <linux/fs_struct.h>
 #include <linux/ptdump.h>
 #include <linux/time_namespace.h>
 #include <linux/unaligned.h>
@@ -713,6 +714,11 @@ static __initdata DECLARE_COMPLETION(kthreadd_done);
 
 static noinline void __ref __noreturn rest_init(void)
 {
+	struct kernel_clone_args init_args = {
+		.flags		= (CLONE_FS | CLONE_VM | CLONE_UNTRACED),
+		.fn		= kernel_init,
+		.fn_arg		= NULL,
+	};
 	struct task_struct *tsk;
 	int pid;
 
@@ -722,7 +728,7 @@ static noinline void __ref __noreturn rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	pid = user_mode_thread(kernel_init, NULL, CLONE_FS);
+	pid = kernel_clone(&init_args);
 	/*
 	 * Pin init on the boot CPU. Task migration is not properly working
 	 * until sched_init_smp() has been run. It will set the allowed
@@ -1574,6 +1580,8 @@ static int __ref kernel_init(void *unused)
 {
 	int ret;
 
+	init_userspace_fs();
+
 	/*
 	 * Wait until kthreadd is all set-up.
 	 */
diff --git a/kernel/fork.c b/kernel/fork.c
index 583078c69bbd..121538f58272 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1590,9 +1590,28 @@ static int copy_mm(u64 clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_fs(u64 clone_flags, struct task_struct *tsk)
+static int copy_fs(u64 clone_flags, struct task_struct *tsk, bool umh)
 {
-	struct fs_struct *fs = current->fs;
+	struct fs_struct *fs;
+
+	/*
+	 * Usermodehelper may use userspace_init_fs filesystem state but
+	 * they don't get to create mount namespaces, share the
+	 * filesystem state, or be started from a non-initial mount
+	 * namespace.
+	 */
+	if (umh) {
+		if (clone_flags & (CLONE_NEWNS | CLONE_FS))
+			return -EINVAL;
+		if (current->nsproxy->mnt_ns != &init_mnt_ns)
+			return -EINVAL;
+	}
+
+	if (umh)
+		fs = &userspace_init_fs;
+	else
+		fs = current->fs;
+
 	if (clone_flags & CLONE_FS) {
 		/* tsk->fs is already what we want */
 		read_seqlock_excl(&fs->seq);
@@ -2211,7 +2230,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
-	retval = copy_fs(clone_flags, p);
+	retval = copy_fs(clone_flags, p, args->umh);
 	if (retval)
 		goto bad_fork_cleanup_files;
 	retval = copy_sighand(clone_flags, p);
@@ -2725,6 +2744,7 @@ pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
 		.exit_signal	= (flags & CSIGNAL),
 		.fn		= fn,
 		.fn_arg		= arg,
+		.umh		= 1,
 	};
 
 	return kernel_clone(&args);

-- 
2.47.3


