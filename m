Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C451495BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 14:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgAYNGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 08:06:49 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:41358 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAYNGr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:06:47 -0500
Received: from localhost.localdomain (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id B02BFC61B3E;
        Sat, 25 Jan 2020 13:06:43 +0000 (UTC)
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
Subject: [PATCH v7 02/11] proc: add proc_fs_info struct to store proc information
Date:   Sat, 25 Jan 2020 14:05:32 +0100
Message-Id: <20200125130541.450409-3-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200125130541.450409-1-gladkov.alexey@gmail.com>
References: <20200125130541.450409-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation patch that adds proc_fs_info to be able to store
different procfs options and informations. Right now some mount options
are stored inside the pid namespace which makes it hard to change or
modernize procfs without affecting pid namespaces. Plus we do want to
treat proc as more of a real mount point and filesystem. procfs is part
of Linux API where it offers some features using filesystem syscalls and
in order to support some features where we are able to have multiple
instances of procfs, each one with its mount options inside the same pid
namespace, we have to separate these procfs instances.

This is the same feature that was also added to other Linux interfaces
like devpts in order to support containers, sandboxes, and to have
multiple instances of devpts filesystem [1].

[1] https://elixir.bootlin.com/linux/v3.4/source/Documentation/filesystems/devpts.txt

Cc: Kees Cook <keescook@chromium.org>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/locks.c              |  6 +++--
 fs/proc/base.c          |  8 +++++--
 fs/proc/inode.c         |  4 ++--
 fs/proc/root.c          | 49 +++++++++++++++++++++++++++--------------
 include/linux/proc_fs.h | 11 ++++++++-
 5 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6970f55daf54..21200e3005e4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2795,7 +2795,8 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 {
 	struct inode *inode = NULL;
 	unsigned int fl_pid;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct proc_fs_info *fs_info = proc_sb_info(file_inode(f->file)->i_sb);
+	struct pid_namespace *proc_pidns = fs_info->pid_ns;
 
 	fl_pid = locks_translate_pid(fl, proc_pidns);
 	/*
@@ -2873,7 +2874,8 @@ static int locks_show(struct seq_file *f, void *v)
 {
 	struct locks_iterator *iter = f->private;
 	struct file_lock *fl, *bfl;
-	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
+	struct proc_fs_info *fs_info = proc_sb_info(file_inode(f->file)->i_sb);
+	struct pid_namespace *proc_pidns = fs_info->pid_ns;
 
 	fl = hlist_entry(v, struct file_lock, fl_link);
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..672e71c52dbd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3243,6 +3243,7 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 {
 	struct task_struct *task;
 	unsigned tgid;
+	struct proc_fs_info *fs_info;
 	struct pid_namespace *ns;
 	struct dentry *result = ERR_PTR(-ENOENT);
 
@@ -3250,7 +3251,8 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 	if (tgid == ~0U)
 		goto out;
 
-	ns = dentry->d_sb->s_fs_info;
+	fs_info = proc_sb_info(dentry->d_sb);
+	ns = fs_info->pid_ns;
 	rcu_read_lock();
 	task = find_task_by_pid_ns(tgid, ns);
 	if (task)
@@ -3538,6 +3540,7 @@ static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry
 	struct task_struct *task;
 	struct task_struct *leader = get_proc_task(dir);
 	unsigned tid;
+	struct proc_fs_info *fs_info;
 	struct pid_namespace *ns;
 	struct dentry *result = ERR_PTR(-ENOENT);
 
@@ -3548,7 +3551,8 @@ static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry
 	if (tid == ~0U)
 		goto out;
 
-	ns = dentry->d_sb->s_fs_info;
+	fs_info = proc_sb_info(dentry->d_sb);
+	ns = fs_info->pid_ns;
 	rcu_read_lock();
 	task = find_task_by_pid_ns(tid, ns);
 	if (task)
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index dbe43a50caf2..b631608dfbcc 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -104,8 +104,8 @@ void __init proc_init_kmemcache(void)
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
 {
-	struct super_block *sb = root->d_sb;
-	struct pid_namespace *pid = sb->s_fs_info;
+	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
+	struct pid_namespace *pid = fs_info->pid_ns;
 
 	if (!gid_eq(pid->pid_gid, GLOBAL_ROOT_GID))
 		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, pid->pid_gid));
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 0b7c8dffc9ae..d449f095f0f7 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -30,7 +30,7 @@
 #include "internal.h"
 
 struct proc_fs_context {
-	struct pid_namespace	*pid_ns;
+	struct proc_fs_info	*fs_info;
 	unsigned int		mask;
 	int			hidepid;
 	int			gid;
@@ -97,7 +97,8 @@ static void proc_apply_options(struct super_block *s,
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 {
-	struct pid_namespace *pid_ns = get_pid_ns(s->s_fs_info);
+	struct proc_fs_context *ctx = fc->fs_private;
+	struct pid_namespace *pid_ns = get_pid_ns(ctx->fs_info->pid_ns);
 	struct inode *root_inode;
 	int ret;
 
@@ -145,7 +146,8 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 static int proc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
-	struct pid_namespace *pid = sb->s_fs_info;
+	struct proc_fs_info *fs_info = proc_sb_info(sb);
+	struct pid_namespace *pid = fs_info->pid_ns;
 
 	sync_filesystem(sb);
 
@@ -157,14 +159,14 @@ static int proc_get_tree(struct fs_context *fc)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 
-	return get_tree_keyed(fc, proc_fill_super, ctx->pid_ns);
+	return get_tree_keyed(fc, proc_fill_super, ctx->fs_info);
 }
 
 static void proc_fs_context_free(struct fs_context *fc)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
 
-	put_pid_ns(ctx->pid_ns);
+	put_pid_ns(ctx->fs_info->pid_ns);
 	kfree(ctx);
 }
 
@@ -178,14 +180,27 @@ static const struct fs_context_operations proc_fs_context_ops = {
 static int proc_init_fs_context(struct fs_context *fc)
 {
 	struct proc_fs_context *ctx;
+	struct pid_namespace *pid_ns;
 
 	ctx = kzalloc(sizeof(struct proc_fs_context), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->pid_ns = get_pid_ns(task_active_pid_ns(current));
+	pid_ns = get_pid_ns(task_active_pid_ns(current));
+
+	if (!pid_ns->proc_mnt) {
+		ctx->fs_info = kzalloc(sizeof(struct proc_fs_info), GFP_KERNEL);
+		if (!ctx->fs_info) {
+			kfree(ctx);
+			return -ENOMEM;
+		}
+		ctx->fs_info->pid_ns = pid_ns;
+	} else {
+		ctx->fs_info = proc_sb_info(pid_ns->proc_mnt->mnt_sb);
+	}
+
 	put_user_ns(fc->user_ns);
-	fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);
+	fc->user_ns = get_user_ns(ctx->fs_info->pid_ns->user_ns);
 	fc->fs_private = ctx;
 	fc->ops = &proc_fs_context_ops;
 	return 0;
@@ -193,15 +208,15 @@ static int proc_init_fs_context(struct fs_context *fc)
 
 static void proc_kill_sb(struct super_block *sb)
 {
-	struct pid_namespace *ns;
+	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	ns = (struct pid_namespace *)sb->s_fs_info;
-	if (ns->proc_self)
-		dput(ns->proc_self);
-	if (ns->proc_thread_self)
-		dput(ns->proc_thread_self);
+	if (fs_info->pid_ns->proc_self)
+		dput(fs_info->pid_ns->proc_self);
+	if (fs_info->pid_ns->proc_thread_self)
+		dput(fs_info->pid_ns->proc_thread_self);
 	kill_anon_super(sb);
-	put_pid_ns(ns);
+	put_pid_ns(fs_info->pid_ns);
+	kfree(fs_info);
 }
 
 static struct file_system_type proc_fs_type = {
@@ -314,10 +329,10 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
 	}
 
 	ctx = fc->fs_private;
-	if (ctx->pid_ns != ns) {
-		put_pid_ns(ctx->pid_ns);
+	if (ctx->fs_info->pid_ns != ns) {
+		put_pid_ns(ctx->fs_info->pid_ns);
 		get_pid_ns(ns);
-		ctx->pid_ns = ns;
+		ctx->fs_info->pid_ns = ns;
 	}
 
 	mnt = fc_mount(fc);
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index a705aa2d03f9..2d79489e55aa 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -12,6 +12,15 @@ struct proc_dir_entry;
 struct seq_file;
 struct seq_operations;
 
+struct proc_fs_info {
+	struct pid_namespace *pid_ns;
+};
+
+static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
 #ifdef CONFIG_PROC_FS
 
 typedef int (*proc_write_t)(struct file *, char *, size_t);
@@ -146,7 +155,7 @@ int open_related_ns(struct ns_common *ns,
 /* get the associated pid namespace for a file in procfs */
 static inline struct pid_namespace *proc_pid_ns(const struct inode *inode)
 {
-	return inode->i_sb->s_fs_info;
+	return proc_sb_info(inode->i_sb)->pid_ns;
 }
 
 #endif /* _LINUX_PROC_FS_H */
-- 
2.24.1

