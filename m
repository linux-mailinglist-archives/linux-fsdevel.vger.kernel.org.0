Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A881EEB7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgFDUEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 16:04:42 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:54032 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgFDUEh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:04:37 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 74A8E209D4;
        Thu,  4 Jun 2020 20:04:33 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/2] proc: use subset option to hide some top-level procfs entries
Date:   Thu,  4 Jun 2020 22:04:12 +0200
Message-Id: <20200604200413.587896-2-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200604200413.587896-1-gladkov.alexey@gmail.com>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 04 Jun 2020 20:04:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In addition to subset=pid, added the ability to specify top-level
directory and file names.

Not all directories in procfs have proc directory entries. For example,
/proc/sys has its own directory operations and does not have proc
directory entries. But all paths in procfs have at least one top-level
proc directory entry.

Since files or directories can be created by kernel modules as they are
loaded, we use a list of names to check a proc directory entries.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/base.c          | 15 +++++++-
 fs/proc/generic.c       | 75 ++++++++++++++++++++++++++++++--------
 fs/proc/inode.c         | 18 ++++++---
 fs/proc/internal.h      | 12 ++++++
 fs/proc/root.c          | 81 +++++++++++++++++++++++++++++++++--------
 include/linux/proc_fs.h | 11 +++---
 6 files changed, 169 insertions(+), 43 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b1d94d14ed5a..9851a1f80e8c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3329,6 +3329,10 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 		goto out;
 
 	fs_info = proc_sb_info(dentry->d_sb);
+
+	if (!is_pids_visible(fs_info))
+		goto out;
+
 	ns = fs_info->pid_ns;
 	rcu_read_lock();
 	task = find_task_by_pid_ns(tgid, ns);
@@ -3388,13 +3392,18 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
-	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
-	struct pid_namespace *ns = proc_pid_ns(file_inode(file)->i_sb);
+	struct proc_fs_info *fs_info;
+	struct pid_namespace *ns;
 	loff_t pos = ctx->pos;
 
 	if (pos >= PID_MAX_LIMIT + TGID_OFFSET)
 		return 0;
 
+	fs_info = proc_sb_info(file_inode(file)->i_sb);
+
+	if (!is_pids_visible(fs_info))
+		goto out;
+
 	if (pos == TGID_OFFSET - 2) {
 		struct inode *inode = d_inode(fs_info->proc_self);
 		if (!dir_emit(ctx, "self", 4, inode->i_ino, DT_LNK))
@@ -3407,6 +3416,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
+	ns = proc_pid_ns(file_inode(file)->i_sb);
 	iter.tgid = pos - TGID_OFFSET;
 	iter.task = NULL;
 	for (iter = next_tgid(ns, iter);
@@ -3427,6 +3437,7 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 			return 0;
 		}
 	}
+out:
 	ctx->pos = PID_MAX_LIMIT + TGID_OFFSET;
 	return 0;
 }
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 2f9fa179194d..e96a593d3b09 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -196,6 +196,48 @@ static int xlate_proc_name(const char *name, struct proc_dir_entry **ret,
 	return rv;
 }
 
+bool is_pde_visible(struct proc_fs_info *fs_info, struct proc_dir_entry *pde)
+{
+	int i;
+
+	if (!fs_info->whitelist || pde == &proc_root)
+		return 1;
+
+	read_lock(&proc_subdir_lock);
+
+	for (i = 0; fs_info->whitelist[i]; i++) {
+		struct proc_dir_entry *ent, *de;
+
+		if (!strcmp(fs_info->whitelist[i], "pid"))
+			continue;
+
+		ent = pde_subdir_find(&proc_root, fs_info->whitelist[i],
+				strlen(fs_info->whitelist[i]));
+		if (!ent)
+			continue;
+
+		if (ent == pde) {
+			read_unlock(&proc_subdir_lock);
+			return 1;
+		}
+
+		if (!S_ISDIR(ent->mode))
+			continue;
+
+		de = pde->parent;
+		while (de != &proc_root) {
+			if (ent == de) {
+				read_unlock(&proc_subdir_lock);
+				return 1;
+			}
+			de = de->parent;
+		}
+	}
+
+	read_unlock(&proc_subdir_lock);
+	return 0;
+}
+
 static DEFINE_IDA(proc_inum_ida);
 
 #define PROC_DYNAMIC_FIRST 0xF0000000U
@@ -251,6 +293,9 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 {
 	struct inode *inode;
 
+	if (!is_visible(dir))
+		return ERR_PTR(-ENOENT);
+
 	read_lock(&proc_subdir_lock);
 	de = pde_subdir_find(de, dentry->d_name.name, dentry->d_name.len);
 	if (de) {
@@ -259,6 +304,8 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
+		if (!is_visible(inode))
+			return ERR_PTR(-ENOENT);
 		d_set_d_op(dentry, de->proc_dops);
 		return d_splice_alias(inode, dentry);
 	}
@@ -269,11 +316,6 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
-	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
-
-	if (fs_info->pidonly == PROC_PIDONLY_ON)
-		return ERR_PTR(-ENOENT);
-
 	return proc_lookup_de(dir, dentry, PDE(dir));
 }
 
@@ -289,11 +331,17 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
 int proc_readdir_de(struct file *file, struct dir_context *ctx,
 		    struct proc_dir_entry *de)
 {
+	struct proc_fs_info *fs_info;
 	int i;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
+	fs_info = proc_sb_info(file_inode(file)->i_sb);
+
+	if (!is_pde_visible(fs_info, de))
+		return 0;
+
 	i = ctx->pos - 2;
 	read_lock(&proc_subdir_lock);
 	de = pde_subdir_first(de);
@@ -312,12 +360,14 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 		struct proc_dir_entry *next;
 		pde_get(de);
 		read_unlock(&proc_subdir_lock);
-		if (!dir_emit(ctx, de->name, de->namelen,
-			    de->low_ino, de->mode >> 12)) {
-			pde_put(de);
-			return 0;
+		if (is_pde_visible(fs_info, de)) {
+			if (!dir_emit(ctx, de->name, de->namelen,
+				    de->low_ino, de->mode >> 12)) {
+				pde_put(de);
+				return 0;
+			}
+			ctx->pos++;
 		}
-		ctx->pos++;
 		read_lock(&proc_subdir_lock);
 		next = pde_subdir_next(de);
 		pde_put(de);
@@ -330,11 +380,6 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 int proc_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
-
-	if (fs_info->pidonly == PROC_PIDONLY_ON)
-		return 1;
-
 	return proc_readdir_de(file, ctx, PDE(inode));
 }
 
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f40c2532c057..61374eb76ce4 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -181,13 +181,20 @@ static inline const char *hidepid2str(enum proc_hidepid v)
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
+	int i;
 
 	if (!gid_eq(fs_info->pid_gid, GLOBAL_ROOT_GID))
 		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, fs_info->pid_gid));
 	if (fs_info->hide_pid != HIDEPID_OFF)
 		seq_printf(seq, ",hidepid=%s", hidepid2str(fs_info->hide_pid));
-	if (fs_info->pidonly != PROC_PIDONLY_OFF)
-		seq_printf(seq, ",subset=pid");
+	if (fs_info->whitelist) {
+		seq_puts(seq, ",subset=");
+		for (i = 0; fs_info->whitelist[i]; i++) {
+			if (i)
+				seq_puts(seq, ":");
+			seq_printf(seq, "%s", fs_info->whitelist[i]);
+		}
+	}
 
 	return 0;
 }
@@ -478,13 +485,15 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
 
 static int proc_reg_open(struct inode *inode, struct file *file)
 {
-	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct proc_dir_entry *pde = PDE(inode);
 	int rv = 0;
 	typeof_member(struct proc_ops, proc_open) open;
 	typeof_member(struct proc_ops, proc_release) release;
 	struct pde_opener *pdeo;
 
+	if (!is_visible(inode))
+		return -ENOENT;
+
 	if (pde_is_permanent(pde)) {
 		open = pde->proc_ops->proc_open;
 		if (open)
@@ -492,9 +501,6 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 		return rv;
 	}
 
-	if (fs_info->pidonly == PROC_PIDONLY_ON)
-		return -ENOENT;
-
 	/*
 	 * Ensure that
 	 * 1) PDE's ->release hook will be called no matter what
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 917cc85e3466..2f14a3692fc1 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -203,6 +203,18 @@ static inline bool is_empty_pde(const struct proc_dir_entry *pde)
 }
 extern ssize_t proc_simple_write(struct file *, const char __user *, size_t, loff_t *);
 
+extern bool is_pde_visible(struct proc_fs_info *fs_info, struct proc_dir_entry *pde);
+
+static inline bool is_pids_visible(struct proc_fs_info *fs_info)
+{
+	return (fs_info->pids_visibility == PROC_PIDS_VISIBLE);
+}
+
+static inline bool is_visible(struct inode *inode)
+{
+	return is_pde_visible(proc_sb_info(inode->i_sb), PDE(inode));
+}
+
 /*
  * inode.c
  */
diff --git a/fs/proc/root.c b/fs/proc/root.c
index ffebed1999e5..5401d88abe9d 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -34,7 +34,8 @@ struct proc_fs_context {
 	unsigned int		mask;
 	enum proc_hidepid	hidepid;
 	int			gid;
-	enum proc_pidonly	pidonly;
+	enum proc_pids_visible	pids_visibility;
+	char			**whitelist;
 };
 
 enum proc_param {
@@ -89,26 +90,71 @@ static int proc_parse_hidepid_param(struct fs_context *fc, struct fs_parameter *
 	return 0;
 }
 
-static int proc_parse_subset_param(struct fs_context *fc, char *value)
+static int proc_parse_subset_param(struct fs_context *fc, const char *value)
 {
+	int i, elemsiz, siz;
+	const char *elem, *endelem, *delim, *endval;
+	char *ptr;
 	struct proc_fs_context *ctx = fc->fs_private;
 
-	while (value) {
-		char *ptr = strchr(value, ',');
+	if (strpbrk(value, "/ "))
+		return invalf(fc, "proc: unsupported subset value - `%s'", value);
 
-		if (ptr != NULL)
-			*ptr++ = '\0';
+	endval = value + strlen(value) + 1;
+	siz = i = 0;
 
-		if (*value != '\0') {
-			if (!strcmp(value, "pid")) {
-				ctx->pidonly = PROC_PIDONLY_ON;
-			} else {
-				return invalf(fc, "proc: unsupported subset option - %s\n", value);
-			}
+	for (delim = elem = value; delim; elem = endelem) {
+		delim = strchr(elem, ':');
+
+		endelem = delim ? ++delim : endval;
+		elemsiz = endelem - elem;
+
+		if (elemsiz > 1) {
+			siz += sizeof(char *) + elemsiz;
+			i++;
 		}
-		value = ptr;
 	}
 
+	if (!i)
+		return invalf(fc, "proc: empty subset value is not valid");
+
+	siz += sizeof(char *);
+	i++;
+
+	kfree(ctx->whitelist);
+	ctx->whitelist = kmalloc(siz, GFP_KERNEL);
+
+	if (!ctx->whitelist) {
+		errorf(fc, "proc: unable to allocate enough memory to store subset filter");
+		return -ENOMEM;
+	}
+
+	ctx->pids_visibility = PROC_PIDS_INVISIBLE;
+
+	ptr = (char *)(ctx->whitelist + i);
+	siz = i = 0;
+
+	for (delim = elem = value; delim; elem = endelem) {
+		delim = strchr(elem, ':');
+
+		endelem = delim ? ++delim : endval;
+		elemsiz = endelem - elem;
+
+		if (elemsiz <= 1)
+			continue;
+
+		if (!strncmp("pid", elem, elemsiz - 1))
+			ctx->pids_visibility = PROC_PIDS_VISIBLE;
+
+		strncpy(ptr, elem, elemsiz);
+		ctx->whitelist[i] = ptr;
+		ctx->whitelist[i][elemsiz - 1] = '\0';
+
+		ptr += elemsiz;
+		i++;
+	}
+	ctx->whitelist[i] = NULL;
+
 	return 0;
 }
 
@@ -155,8 +201,11 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
 		fs_info->hide_pid = ctx->hidepid;
-	if (ctx->mask & (1 << Opt_subset))
-		fs_info->pidonly = ctx->pidonly;
+	if (ctx->mask & (1 << Opt_subset)) {
+		kfree(fs_info->whitelist);
+		fs_info->whitelist = ctx->whitelist;
+		fs_info->pids_visibility = ctx->pids_visibility;
+	}
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
@@ -270,6 +319,8 @@ static void proc_kill_sb(struct super_block *sb)
 	if (fs_info->proc_thread_self)
 		dput(fs_info->proc_thread_self);
 
+	kfree(fs_info->whitelist);
+
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
 	kfree(fs_info);
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 6ec524d8842c..74d56ddb67b6 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -50,10 +50,10 @@ enum proc_hidepid {
 	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
 };
 
-/* definitions for proc mount option pidonly */
-enum proc_pidonly {
-	PROC_PIDONLY_OFF = 0,
-	PROC_PIDONLY_ON  = 1,
+/* definitions for pid visibility */
+enum proc_pids_visible {
+	PROC_PIDS_VISIBLE   = 0,
+	PROC_PIDS_INVISIBLE = 1,
 };
 
 struct proc_fs_info {
@@ -62,7 +62,8 @@ struct proc_fs_info {
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
-	enum proc_pidonly pidonly;
+	enum proc_pids_visible pids_visibility;
+	char **whitelist;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.25.4

