Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813451A3430
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 14:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgDIMjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 08:39:16 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:58534 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgDIMip (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:38:45 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id C49E6209D7;
        Thu,  9 Apr 2020 12:38:42 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH RESEND v11 3/8] proc: move hide_pid, pid_gid from pid_namespace to proc_fs_info
Date:   Thu,  9 Apr 2020 14:37:47 +0200
Message-Id: <20200409123752.1070597-4-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200409123752.1070597-1-gladkov.alexey@gmail.com>
References: <20200409123752.1070597-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 09 Apr 2020 12:38:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move hide_pid and pid_gid parameters inside procfs fs_info struct
instead of making them per pid namespace. Since we have a multiple
procfs instances per pid namespace we need to make sure that all
proc-specific parameters are also per-superblock.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/base.c                | 18 +++++++++---------
 fs/proc/inode.c               |  9 ++++-----
 fs/proc/root.c                |  4 ++--
 include/linux/pid_namespace.h |  8 --------
 include/linux/proc_fs.h       |  9 +++++++++
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3b9155a69ade..43a28907baf9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -697,13 +697,13 @@ int proc_setattr(struct dentry *dentry, struct iattr *attr)
  * May current process learn task's sched/cmdline info (for hide_pid_min=1)
  * or euid/egid (for hide_pid_min=2)?
  */
-static bool has_pid_permissions(struct pid_namespace *pid,
+static bool has_pid_permissions(struct proc_fs_info *fs_info,
 				 struct task_struct *task,
 				 int hide_pid_min)
 {
-	if (pid->hide_pid < hide_pid_min)
+	if (fs_info->hide_pid < hide_pid_min)
 		return true;
-	if (in_group_p(pid->pid_gid))
+	if (in_group_p(fs_info->pid_gid))
 		return true;
 	return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
 }
@@ -711,18 +711,18 @@ static bool has_pid_permissions(struct pid_namespace *pid,
 
 static int proc_pid_permission(struct inode *inode, int mask)
 {
-	struct pid_namespace *pid = proc_pid_ns(inode);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
 	bool has_perms;
 
 	task = get_proc_task(inode);
 	if (!task)
 		return -ESRCH;
-	has_perms = has_pid_permissions(pid, task, HIDEPID_NO_ACCESS);
+	has_perms = has_pid_permissions(fs_info, task, HIDEPID_NO_ACCESS);
 	put_task_struct(task);
 
 	if (!has_perms) {
-		if (pid->hide_pid == HIDEPID_INVISIBLE) {
+		if (fs_info->hide_pid == HIDEPID_INVISIBLE) {
 			/*
 			 * Let's make getdents(), stat(), and open()
 			 * consistent with each other.  If a process
@@ -1897,7 +1897,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	struct pid_namespace *pid = proc_pid_ns(inode);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
 
 	generic_fillattr(inode, stat);
@@ -1907,7 +1907,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 	rcu_read_lock();
 	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (task) {
-		if (!has_pid_permissions(pid, task, HIDEPID_INVISIBLE)) {
+		if (!has_pid_permissions(fs_info, task, HIDEPID_INVISIBLE)) {
 			rcu_read_unlock();
 			/*
 			 * This doesn't prevent learning whether PID exists,
@@ -3402,7 +3402,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		unsigned int len;
 
 		cond_resched();
-		if (!has_pid_permissions(ns, iter.task, HIDEPID_INVISIBLE))
+		if (!has_pid_permissions(fs_info, iter.task, HIDEPID_INVISIBLE))
 			continue;
 
 		len = snprintf(name, sizeof(name), "%u", iter.tgid);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 6e4c6728338b..91fe4896fa85 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -168,12 +168,11 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
-	struct pid_namespace *pid = fs_info->pid_ns;
 
-	if (!gid_eq(pid->pid_gid, GLOBAL_ROOT_GID))
-		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, pid->pid_gid));
-	if (pid->hide_pid != HIDEPID_OFF)
-		seq_printf(seq, ",hidepid=%u", pid->hide_pid);
+	if (!gid_eq(fs_info->pid_gid, GLOBAL_ROOT_GID))
+		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, fs_info->pid_gid));
+	if (fs_info->hide_pid != HIDEPID_OFF)
+		seq_printf(seq, ",hidepid=%u", fs_info->hide_pid);
 
 	return 0;
 }
diff --git a/fs/proc/root.c b/fs/proc/root.c
index b28adbb0b937..616e8976185c 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -85,9 +85,9 @@ static void proc_apply_options(struct super_block *s,
 	struct proc_fs_context *ctx = fc->fs_private;
 
 	if (ctx->mask & (1 << Opt_gid))
-		pid_ns->pid_gid = make_kgid(user_ns, ctx->gid);
+		ctx->fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
-		pid_ns->hide_pid = ctx->hidepid;
+		ctx->fs_info->hide_pid = ctx->hidepid;
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index de4534d93cb6..5a5cb45ac57e 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -17,12 +17,6 @@
 
 struct fs_pin;
 
-enum { /* definitions for pid_namespace's hide_pid field */
-	HIDEPID_OFF	  = 0,
-	HIDEPID_NO_ACCESS = 1,
-	HIDEPID_INVISIBLE = 2,
-};
-
 struct pid_namespace {
 	struct kref kref;
 	struct idr idr;
@@ -37,8 +31,6 @@ struct pid_namespace {
 #endif
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
-	kgid_t pid_gid;
-	int hide_pid;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
 } __randomize_layout;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 5920a4ecd71b..7d852dbca253 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -27,10 +27,19 @@ struct proc_ops {
 	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 };
 
+/* definitions for hide_pid field */
+enum {
+	HIDEPID_OFF	  = 0,
+	HIDEPID_NO_ACCESS = 1,
+	HIDEPID_INVISIBLE = 2,
+};
+
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
 	struct dentry *proc_self;        /* For /proc/self */
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
+	kgid_t pid_gid;
+	int hide_pid;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.25.2

