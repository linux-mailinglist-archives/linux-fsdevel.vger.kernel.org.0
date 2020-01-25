Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B221495A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 14:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAYNGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 08:06:49 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:41440 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAYNGs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:06:48 -0500
Received: from localhost.localdomain (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 80EC3C61B40;
        Sat, 25 Jan 2020 13:06:45 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
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
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v7 04/11] proc: move hide_pid, pid_gid from pid_namespace to proc_fs_info
Date:   Sat, 25 Jan 2020 14:05:34 +0100
Message-Id: <20200125130541.450409-5-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200125130541.450409-1-gladkov.alexey@gmail.com>
References: <20200125130541.450409-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation patch that moves hide_pid and pid_gid parameters
to be stored inside procfs fs_info struct instead of making them per pid
namespace. Since we want to support multiple procfs instances we need to
make sure that all proc-specific parameters are also per-superblock.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/base.c                | 18 +++++++++---------
 fs/proc/inode.c               |  9 ++++-----
 fs/proc/root.c                | 10 ++++++++--
 include/linux/pid_namespace.h |  8 --------
 include/linux/proc_fs.h       |  9 +++++++++
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1eb366ad8b06..caca1929fee1 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -695,13 +695,13 @@ int proc_setattr(struct dentry *dentry, struct iattr *attr)
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
@@ -709,18 +709,18 @@ static bool has_pid_permissions(struct pid_namespace *pid,
 
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
@@ -1784,7 +1784,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
-	struct pid_namespace *pid = proc_pid_ns(inode);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
 
 	generic_fillattr(inode, stat);
@@ -1794,7 +1794,7 @@ int pid_getattr(const struct path *path, struct kstat *stat,
 	rcu_read_lock();
 	task = pid_task(proc_pid(inode), PIDTYPE_PID);
 	if (task) {
-		if (!has_pid_permissions(pid, task, HIDEPID_INVISIBLE)) {
+		if (!has_pid_permissions(fs_info, task, HIDEPID_INVISIBLE)) {
 			rcu_read_unlock();
 			/*
 			 * This doesn't prevent learning whether PID exists,
@@ -3344,7 +3344,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		unsigned int len;
 
 		cond_resched();
-		if (!has_pid_permissions(ns, iter.task, HIDEPID_INVISIBLE))
+		if (!has_pid_permissions(fs_info, iter.task, HIDEPID_INVISIBLE))
 			continue;
 
 		len = snprintf(name, sizeof(name), "%u", iter.tgid);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b631608dfbcc..b90c233e5968 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -105,12 +105,11 @@ void __init proc_init_kmemcache(void)
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
index 637e26cc795e..1ca47d446aa4 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -89,10 +89,16 @@ static void proc_apply_options(struct super_block *s,
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 
+	if (pid_ns->proc_mnt) {
+		struct proc_fs_info *fs_info = proc_sb_info(pid_ns->proc_mnt->mnt_sb);
+		ctx->fs_info->pid_gid = fs_info->pid_gid;
+		ctx->fs_info->hide_pid = fs_info->hide_pid;
+	}
+
 	if (ctx->mask & (1 << Opt_gid))
-		pid_ns->pid_gid = make_kgid(user_ns, ctx->gid);
+		ctx->fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
-		pid_ns->hide_pid = ctx->hidepid;
+		ctx->fs_info->hide_pid = ctx->hidepid;
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f91a8bf6e09e..66f47f1afe0d 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -15,12 +15,6 @@
 
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
@@ -39,8 +33,6 @@ struct pid_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 	struct work_struct proc_work;
-	kgid_t pid_gid;
-	int hide_pid;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
 } __randomize_layout;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 59162988998e..5f0b1b7e4271 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -12,10 +12,19 @@ struct proc_dir_entry;
 struct seq_file;
 struct seq_operations;
 
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
2.24.1

