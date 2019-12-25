Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4213312A7F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 14:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLYNDN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 08:03:13 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:36124 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfLYNDN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:03:13 -0500
Received: from localhost.localdomain (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 73932C61B16;
        Wed, 25 Dec 2019 12:53:24 +0000 (UTC)
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
Subject: [PATCH v6 09/10] proc: add option to mount only a pids subset
Date:   Wed, 25 Dec 2019 13:51:50 +0100
Message-Id: <20191225125151.1950142-10-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
References: <20191225125151.1950142-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows to hide all files and directories in the procfs that are not
related to tasks.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/generic.c       | 20 ++++++++++++++++++++
 fs/proc/inode.c         |  8 ++++++++
 fs/proc/root.c          | 14 ++++++++++++++
 include/linux/proc_fs.h | 26 ++++++++++++++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 64e9ee1b129e..2fa919a5544d 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -267,6 +267,11 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
+
+	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
+		return ERR_PTR(-ENOENT);
+
 	return proc_lookup_de(dir, dentry, PDE(dir));
 }
 
@@ -323,10 +328,24 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 int proc_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+
+	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
+		return 1;
 
 	return proc_readdir_de(file, ctx, PDE(inode));
 }
 
+static int proc_dir_open(struct inode *inode, struct file *file)
+{
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+
+	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
+		return -ENOENT;
+
+	return 0;
+}
+
 /*
  * These are the generic /proc directory operations. They
  * use the in-memory "struct proc_dir_entry" tree to parse
@@ -336,6 +355,7 @@ static const struct file_operations proc_dir_operations = {
 	.llseek			= generic_file_llseek,
 	.read			= generic_read_dir,
 	.iterate_shared		= proc_readdir,
+	.open			= proc_dir_open,
 };
 
 /*
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 70b722fb8811..fe9d20da3862 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -107,6 +107,7 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
 	int hidepid = proc_fs_hide_pid(fs_info);
 	kgid_t gid = proc_fs_pid_gid(fs_info);
+	int pidonly = proc_fs_pidonly(fs_info);
 
 	if (!gid_eq(gid, GLOBAL_ROOT_GID))
 		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, gid));
@@ -114,6 +115,9 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 	if (hidepid != HIDEPID_OFF)
 		seq_printf(seq, ",hidepid=%u", hidepid);
 
+	if (pidonly != PROC_PIDONLY_OFF)
+		seq_printf(seq, ",pidonly=%u", pidonly);
+
 	return 0;
 }
 
@@ -333,12 +337,16 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
 
 static int proc_reg_open(struct inode *inode, struct file *file)
 {
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct proc_dir_entry *pde = PDE(inode);
 	int rv = 0;
 	typeof_member(struct file_operations, open) open;
 	typeof_member(struct file_operations, release) release;
 	struct pde_opener *pdeo;
 
+	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
+		return -ENOENT;
+
 	/*
 	 * Ensure that
 	 * 1) PDE's ->release hook will be called no matter what
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 3c7b29140293..fc26c22a5906 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -34,16 +34,19 @@ struct proc_fs_context {
 	unsigned int		mask;
 	int			hidepid;
 	int			gid;
+	int			pidonly;
 };
 
 enum proc_param {
 	Opt_gid,
 	Opt_hidepid,
+	Opt_pidonly,
 };
 
 static const struct fs_parameter_spec proc_param_specs[] = {
 	fsparam_u32("gid",	Opt_gid),
 	fsparam_u32("hidepid",	Opt_hidepid),
+	fsparam_u32("pidonly",	Opt_pidonly),
 	{}
 };
 
@@ -74,6 +77,13 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return invalf(fc, "proc: hidepid value must be between 0 and 3.\n");
 		break;
 
+	case Opt_pidonly:
+		ctx->pidonly = result.uint_32;
+		if (ctx->pidonly < PROC_PIDONLY_OFF ||
+		    ctx->pidonly > PROC_PIDONLY_ON)
+			return invalf(fc, "proc: pidonly value must be 0 or 1.\n");
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -94,6 +104,7 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 
 		proc_fs_set_pid_gid(fs_info, proc_fs_pid_gid(pidns_fs_info));
 		proc_fs_set_hide_pid(fs_info, proc_fs_hide_pid(pidns_fs_info));
+		proc_fs_set_pidonly(fs_info, proc_fs_pidonly(pidns_fs_info));
 	}
 
 	if (ctx->mask & (1 << Opt_gid))
@@ -101,6 +112,9 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 
 	if (ctx->mask & (1 << Opt_hidepid))
 		proc_fs_set_hide_pid(fs_info, ctx->hidepid);
+
+	if (ctx->mask & (1 << Opt_pidonly))
+		proc_fs_set_pidonly(fs_info, ctx->pidonly);
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 83c87ea65505..ef1c0d9712b0 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,6 +20,12 @@ enum {
 	HIDEPID_NOT_PTRACABLE = 3, /* Limit pids to only ptracable pids */
 };
 
+/* definitions for proc mount option pidonly */
+enum {
+	PROC_PIDONLY_OFF = 0,
+	PROC_PIDONLY_ON  = 1,
+};
+
 struct proc_fs_info {
 	struct list_head pidns_entry;    /* Node in procfs_mounts of a pidns */
 	struct super_block *m_super;
@@ -28,6 +34,7 @@ struct proc_fs_info {
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
 	kgid_t pid_gid;
 	int hide_pid;
+	int pidonly;
 };
 
 #ifdef CONFIG_PROC_FS
@@ -39,6 +46,11 @@ static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+static inline void proc_fs_set_pidonly(struct proc_fs_info *fs_info, int value)
+{
+	fs_info->pidonly = value;
+}
+
 static inline void proc_fs_set_hide_pid(struct proc_fs_info *fs_info, int hide_pid)
 {
 	fs_info->hide_pid = hide_pid;
@@ -49,6 +61,11 @@ static inline void proc_fs_set_pid_gid(struct proc_fs_info *fs_info, kgid_t gid)
 	fs_info->pid_gid = gid;
 }
 
+static inline int proc_fs_pidonly(struct proc_fs_info *fs_info)
+{
+	return fs_info->pidonly;
+}
+
 static inline int proc_fs_hide_pid(struct proc_fs_info *fs_info)
 {
 	return fs_info->hide_pid;
@@ -134,6 +151,10 @@ static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
 	return NULL;
 }
 
+static inline void proc_fs_set_pidonly(struct proc_fs_info *fs_info, int value)
+{
+}
+
 static inline void proc_fs_set_hide_pid(struct proc_fs_info *fs_info, int hide_pid)
 {
 }
@@ -142,6 +163,11 @@ static inline void proc_fs_set_pid_gid(struct proc_info_fs *fs_info, kgid_t gid)
 {
 }
 
+static inline void proc_fs_pidonly(struct proc_fs_info *fs_info)
+{
+	return PROC_PIDONLY_OFF;
+}
+
 static inline int proc_fs_hide_pid(struct proc_fs_info *fs_info)
 {
 	return 0;
-- 
2.24.1

