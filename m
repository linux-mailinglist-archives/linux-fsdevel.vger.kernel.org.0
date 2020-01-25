Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB91495AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 14:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAYNGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 08:06:55 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:41582 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbgAYNGz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:06:55 -0500
Received: from localhost.localdomain (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 4E45CC61B45;
        Sat, 25 Jan 2020 13:06:50 +0000 (UTC)
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
Subject: [PATCH v7 09/11] proc: add option to mount only a pids subset
Date:   Sat, 25 Jan 2020 14:05:39 +0100
Message-Id: <20200125130541.450409-10-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200125130541.450409-1-gladkov.alexey@gmail.com>
References: <20200125130541.450409-1-gladkov.alexey@gmail.com>
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
 fs/proc/generic.c       |  9 +++++++++
 fs/proc/inode.c         |  7 +++++++
 fs/proc/internal.h      | 10 ++++++++++
 fs/proc/root.c          | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/proc_fs.h |  7 +++++++
 5 files changed, 69 insertions(+)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 64e9ee1b129e..6f6517d63053 100644
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
 
@@ -323,6 +328,10 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 int proc_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+
+	if (proc_fs_pidonly(fs_info) == PROC_PIDONLY_ON)
+		return 1;
 
 	return proc_readdir_de(file, ctx, PDE(inode));
 }
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 70b722fb8811..f35eef117775 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -114,6 +114,9 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 	if (hidepid != HIDEPID_OFF)
 		seq_printf(seq, ",hidepid=%u", hidepid);
 
+	if (proc_fs_pidonly(fs_info) != PROC_PIDONLY_OFF)
+		seq_printf(seq, ",subset=pidfs");
+
 	return 0;
 }
 
@@ -333,12 +336,16 @@ proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr,
 
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
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index ff2f274b2e0d..e2c729267317 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -126,6 +126,11 @@ static inline void proc_fs_set_hide_pid(struct proc_fs_info *fs_info, int hide_p
 	fs_info->hide_pid = hide_pid;
 }
 
+static inline void proc_fs_set_pidonly(struct proc_fs_info *fs_info, int value)
+{
+	fs_info->pidonly = value;
+}
+
 static inline void proc_fs_set_pid_gid(struct proc_fs_info *fs_info, kgid_t gid)
 {
 	fs_info->pid_gid = gid;
@@ -141,6 +146,11 @@ static inline kgid_t proc_fs_pid_gid(struct proc_fs_info *fs_info)
 	return fs_info->pid_gid;
 }
 
+static inline int proc_fs_pidonly(struct proc_fs_info *fs_info)
+{
+	return fs_info->pidonly;
+}
+
 void task_dump_owner(struct task_struct *task, umode_t mode,
 		     kuid_t *ruid, kgid_t *rgid);
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 57276cb65528..8e8d5c930e32 100644
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
 
 static const struct fs_parameter_spec proc_param_specs[] = {
 	fsparam_u32("gid",	Opt_gid),
 	fsparam_u32("hidepid",	Opt_hidepid),
+	fsparam_string("subset",	Opt_subset),
 	{}
 };
 
@@ -61,6 +64,30 @@ valid_hidepid(unsigned int value)
 		value == HIDEPID_NOT_PTRACABLE);
 }
 
+static inline int
+proc_parse_subset_param(struct fs_context *fc, char *value)
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
+			if (!strcmp(value, "pidfs")) {
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
@@ -82,6 +109,11 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
@@ -102,6 +134,7 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 
 		proc_fs_set_pid_gid(fs_info, proc_fs_pid_gid(pidns_fs_info));
 		proc_fs_set_hide_pid(fs_info, proc_fs_hide_pid(pidns_fs_info));
+		proc_fs_set_pidonly(fs_info, proc_fs_pidonly(pidns_fs_info));
 	}
 
 	if (ctx->mask & (1 << Opt_gid))
@@ -109,6 +142,9 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 
 	if (ctx->mask & (1 << Opt_hidepid))
 		proc_fs_set_hide_pid(fs_info, ctx->hidepid);
+
+	if (ctx->mask & (1 << Opt_subset))
+		proc_fs_set_pidonly(fs_info, ctx->pidonly);
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 6822548405a7..3ad0a47c3556 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,6 +20,12 @@ enum {
 	HIDEPID_NOT_PTRACABLE = 4, /* Limit pids to only ptracable pids */
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
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.24.1

