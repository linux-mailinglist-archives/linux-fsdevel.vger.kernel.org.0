Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D611AFB34
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgDSOME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 10:12:04 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:45528 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgDSOLq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:11:46 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 233A7209FE;
        Sun, 19 Apr 2020 14:11:42 +0000 (UTC)
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
Subject: [PATCH v12 4/7] proc: add option to mount only a pids subset
Date:   Sun, 19 Apr 2020 16:10:54 +0200
Message-Id: <20200419141057.621356-5-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200419141057.621356-1-gladkov.alexey@gmail.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sun, 19 Apr 2020 14:11:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows to hide all files and directories in the procfs that are not
related to tasks.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/generic.c       |  9 +++++++++
 fs/proc/inode.c         |  6 ++++++
 fs/proc/root.c          | 33 +++++++++++++++++++++++++++++++++
 include/linux/proc_fs.h |  7 +++++++
 4 files changed, 55 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 4ed6dabdf6ff..2f9fa179194d 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -269,6 +269,11 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
 		unsigned int flags)
 {
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
+
+	if (fs_info->pidonly == PROC_PIDONLY_ON)
+		return ERR_PTR(-ENOENT);
+
 	return proc_lookup_de(dir, dentry, PDE(dir));
 }
 
@@ -325,6 +330,10 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 int proc_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+
+	if (fs_info->pidonly == PROC_PIDONLY_ON)
+		return 1;
 
 	return proc_readdir_de(file, ctx, PDE(inode));
 }
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 9c756531282a..0d5e68fa842f 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -173,6 +173,8 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, fs_info->pid_gid));
 	if (fs_info->hide_pid != HIDEPID_OFF)
 		seq_printf(seq, ",hidepid=%u", fs_info->hide_pid);
+	if (fs_info->pidonly != PROC_PIDONLY_OFF)
+		seq_printf(seq, ",subset=pid");
 
 	return 0;
 }
@@ -463,6 +465,7 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
 
 static int proc_reg_open(struct inode *inode, struct file *file)
 {
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct proc_dir_entry *pde = PDE(inode);
 	int rv = 0;
 	typeof_member(struct proc_ops, proc_open) open;
@@ -476,6 +479,9 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 		return rv;
 	}
 
+	if (fs_info->pidonly == PROC_PIDONLY_ON)
+		return -ENOENT;
+
 	/*
 	 * Ensure that
 	 * 1) PDE's ->release hook will be called no matter what
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 8f23b951d685..baff006a918f 100644
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
+	Opt_subset,
 };
 
 static const struct fs_parameter_spec proc_fs_parameters[] = {
 	fsparam_u32("gid",	Opt_gid),
 	fsparam_u32("hidepid",	Opt_hidepid),
+	fsparam_string("subset",	Opt_subset),
 	{}
 };
 
@@ -55,6 +58,29 @@ static inline int valid_hidepid(unsigned int value)
 		value == HIDEPID_NOT_PTRACEABLE);
 }
 
+static int proc_parse_subset_param(struct fs_context *fc, char *value)
+{
+	struct proc_fs_context *ctx = fc->fs_private;
+
+	while (value) {
+		char *ptr = strchr(value, ',');
+
+		if (ptr != NULL)
+			*ptr++ = '\0';
+
+		if (*value != '\0') {
+			if (!strcmp(value, "pid")) {
+				ctx->pidonly = PROC_PIDONLY_ON;
+			} else {
+				return invalf(fc, "proc: unsupported subset option - %s\n", value);
+			}
+		}
+		value = ptr;
+	}
+
+	return 0;
+}
+
 static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct proc_fs_context *ctx = fc->fs_private;
@@ -76,6 +102,11 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->hidepid = result.uint_32;
 		break;
 
+	case Opt_subset:
+		if (proc_parse_subset_param(fc, param->string) < 0)
+			return -EINVAL;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -94,6 +125,8 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
 		fs_info->hide_pid = ctx->hidepid;
+	if (ctx->mask & (1 << Opt_subset))
+		fs_info->pidonly = ctx->pidonly;
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 5bdc117ae947..8bc31ba5cd9c 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -50,12 +50,19 @@ enum {
 	HIDEPID_NOT_PTRACEABLE = 4, /* Limit pids to only ptraceable pids */
 };
 
+/* definitions for proc mount option pidonly */
+enum {
+	PROC_PIDONLY_OFF = 0,
+	PROC_PIDONLY_ON  = 1,
+};
+
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
 	struct dentry *proc_self;        /* For /proc/self */
 	struct dentry *proc_thread_self; /* For /proc/thread-self */
 	kgid_t pid_gid;
 	int hide_pid;
+	int pidonly;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.25.3

