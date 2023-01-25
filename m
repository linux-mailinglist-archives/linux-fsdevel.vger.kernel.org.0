Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59767B5ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjAYPaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjAYP3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:29:51 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D359B40
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 07:29:42 -0800 (PST)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-3L7hQhr3NEibyln3yWV5BQ-1; Wed, 25 Jan 2023 10:29:30 -0500
X-MC-Unique: 3L7hQhr3NEibyln3yWV5BQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FF52857A81;
        Wed, 25 Jan 2023 15:29:29 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (ovpn-208-16.brq.redhat.com [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8003C2026D4B;
        Wed, 25 Jan 2023 15:29:27 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Val Cowan <vcowan@redhat.com>
Subject: [RFC PATCH v1 2/6] proc: Add allowlist to control access to procfs files
Date:   Wed, 25 Jan 2023 16:28:49 +0100
Message-Id: <d87edbe023efb28f60ea04a2e694330db44aa868.1674660533.git.legion@kernel.org>
In-Reply-To: <cover.1674660533.git.legion@kernel.org>
References: <cover.1674660533.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If, after creating a container and mounting procfs, the system
configuration may change and new files may appear in procfs. Files
including writable root or any other users.

In most cases, it is known in advance which files in procfs the user
needs in the container. It is much easier to control the list of what
you want than to control the list of unwanted files.

To do this, subset=allowlist is added to control the visibility of
static files in procfs (not process pids). After that, the control file
/proc/allowlist appears in the root of the filesystem. This file
contains a list of files and directories that will be visible in this
vmountpoint. Immediately after mount, this file contains only one
name - the name of the file itself.

The admin can add names, read this file to get the current state of the
allowlist. The file behaves almost like a regular file. Changes are
applied when the file is closed.

To prevent changes to allowlist, admin should remove its name from the
list of allowed files. After this change, the file will disappear.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/Kconfig          |  10 ++
 fs/proc/Makefile         |   1 +
 fs/proc/generic.c        |  15 ++-
 fs/proc/internal.h       |  29 +++++
 fs/proc/proc_allowlist.c | 221 +++++++++++++++++++++++++++++++++++++++
 fs/proc/root.c           |  27 ++++-
 include/linux/proc_fs.h  |   8 ++
 7 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100644 fs/proc/proc_allowlist.c

diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 32b1116ae137..bfe80b1fd31f 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -108,3 +108,13 @@ config PROC_PID_ARCH_STATUS
 config PROC_CPU_RESCTRL
 	def_bool n
 	depends on PROC_FS
+
+config PROC_ALLOW_LIST
+	bool "/proc/allowlist support"
+	depends on PROC_FS
+	default n
+	help
+	  Provides a way to restrict access to certain files in procfs. Mounting
+	  procfs with subset=allowlist will add the file /proc/allowlist which
+	  contains a list of files and directories that should be accessed. To
+	  prevent the list from being changed, the file itself must be excluded.
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..3c7d3dacbd2f 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -34,3 +34,4 @@ proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
 proc-$(CONFIG_BOOT_CONFIG)	+= bootconfig.o
+proc-$(CONFIG_PROC_ALLOW_LIST)	+= proc_allowlist.o
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 587b91d9d998..d4c8589987e7 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -43,7 +43,7 @@ void pde_free(struct proc_dir_entry *pde)
 	kmem_cache_free(proc_dir_entry_cache, pde);
 }
 
-static int proc_match(const char *name, struct proc_dir_entry *de, unsigned int len)
+int proc_match(const char *name, struct proc_dir_entry *de, unsigned int len)
 {
 	if (len < de->namelen)
 		return -1;
@@ -251,6 +251,9 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 	if (de) {
 		pde_get(de);
 		read_unlock(&proc_subdir_lock);
+		if (!proc_pde_access_allowed(proc_sb_info(dir->i_sb), de)) {
+			return ERR_PTR(-ENOENT);
+		}
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
@@ -266,7 +269,7 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
 {
 	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
 
-	if (fs_info->pidonly == PROC_PIDONLY_ON)
+	if (fs_info->pidonly == PROC_PIDONLY_ON && !proc_has_allowlist(fs_info))
 		return ERR_PTR(-ENOENT);
 
 	return proc_lookup_de(dir, dentry, PDE(dir));
@@ -284,6 +287,9 @@ struct dentry *proc_lookup(struct inode *dir, struct dentry *dentry,
 int proc_readdir_de(struct file *file, struct dir_context *ctx,
 		    struct proc_dir_entry *de)
 {
+	struct inode *inode = file_inode(file);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+
 	int i;
 
 	if (!dir_emit_dots(file, ctx))
@@ -307,7 +313,8 @@ int proc_readdir_de(struct file *file, struct dir_context *ctx,
 		struct proc_dir_entry *next;
 		pde_get(de);
 		read_unlock(&proc_subdir_lock);
-		if (!dir_emit(ctx, de->name, de->namelen,
+		if (proc_pde_access_allowed(fs_info, de) &&
+		    !dir_emit(ctx, de->name, de->namelen,
 			    de->low_ino, de->mode >> 12)) {
 			pde_put(de);
 			return 0;
@@ -327,7 +334,7 @@ int proc_readdir(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 
-	if (fs_info->pidonly == PROC_PIDONLY_ON)
+	if (fs_info->pidonly == PROC_PIDONLY_ON && !proc_has_allowlist(fs_info))
 		return 1;
 
 	return proc_readdir_de(file, ctx, PDE(inode));
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index b701d0207edf..999d105f6f96 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -84,6 +84,16 @@ static inline void pde_make_permanent(struct proc_dir_entry *pde)
 	pde->flags |= PROC_ENTRY_PERMANENT;
 }
 
+static inline bool pde_is_allowlist(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_ALLOWLIST;
+}
+
+static inline void pde_make_allowlist(struct proc_dir_entry *pde)
+{
+	pde->flags |= PROC_ENTRY_ALLOWLIST;
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
@@ -187,6 +197,7 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 		struct proc_dir_entry **parent, void *data);
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp);
+extern int proc_match(const char *, struct proc_dir_entry *, unsigned int);
 extern struct dentry *proc_lookup(struct inode *, struct dentry *, unsigned int);
 struct dentry *proc_lookup_de(struct inode *, struct dentry *, struct proc_dir_entry *);
 extern int proc_readdir(struct file *, struct dir_context *);
@@ -318,3 +329,21 @@ static inline void pde_force_lookup(struct proc_dir_entry *pde)
 	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
 	pde->proc_dops = &proc_net_dentry_ops;
 }
+
+/*
+ * proc_allowlist.c
+ */
+#ifdef CONFIG_PROC_ALLOW_LIST
+extern bool proc_has_allowlist(struct proc_fs_info *);
+extern bool proc_pde_access_allowed(struct proc_fs_info *, struct proc_dir_entry *);
+#else
+static inline bool proc_has_allowlist(struct proc_fs_info *fs_info)
+{
+	return false;
+}
+
+static inline bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry *pde)
+{
+	return true;
+}
+#endif
diff --git a/fs/proc/proc_allowlist.c b/fs/proc/proc_allowlist.c
new file mode 100644
index 000000000000..b38e11b04199
--- /dev/null
+++ b/fs/proc/proc_allowlist.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  linux/fs/proc/proc_allowlist.c
+ *
+ *  Copyright (C) 2022
+ *
+ *  Author: Alexey Gladkov <legion@kernel.org>
+ */
+#include <linux/sizes.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/rwlock.h>
+#include "internal.h"
+
+#define FILE_SEQFILE(f) ((struct seq_file *)((f)->private_data))
+#define FILE_DATA(f) (FILE_SEQFILE(f)->private)
+
+bool proc_has_allowlist(struct proc_fs_info *fs_info)
+{
+	bool ret;
+	unsigned long flags;
+
+	read_lock_irqsave(&fs_info->allowlist_lock, flags);
+	ret = (fs_info->allowlist == NULL);
+	read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
+
+	return ret;
+}
+
+bool proc_pde_access_allowed(struct proc_fs_info *fs_info, struct proc_dir_entry *de)
+{
+	bool ret = false;
+	char *ptr;
+	unsigned long flags;
+
+	read_lock_irqsave(&fs_info->allowlist_lock, flags);
+
+	if (!fs_info->allowlist) {
+		read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
+
+		if (!pde_is_allowlist(de))
+			ret = true;
+
+		return ret;
+	}
+
+	ptr = fs_info->allowlist;
+
+	while (*ptr != '\0') {
+		struct proc_dir_entry *pde;
+		char *sep, *end;
+		size_t len, pathlen;
+
+		if (!(sep = strchr(ptr, '\n')))
+			pathlen = strlen(ptr);
+		else
+			pathlen = (sep - ptr);
+
+		if (!pathlen)
+			goto next;
+
+		pde = de;
+		end = NULL;
+		len = pathlen;
+
+		while (ptr != end && len > 0) {
+			end = ptr + len - 1;
+
+			while (1) {
+				if (*end == '/') {
+					end++;
+					break;
+				}
+				if (end == ptr)
+					break;
+				end--;
+			}
+
+			if (proc_match(end, pde, ptr + len - end))
+				goto next;
+
+			len = end - ptr - 1;
+			pde = pde->parent;
+		}
+
+		ret = true;
+		break;
+next:
+		ptr += pathlen + 1;
+	}
+
+	read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
+
+	return ret;
+}
+
+static int show_allowlist(struct seq_file *m, void *v)
+{
+	struct proc_fs_info *fs_info = proc_sb_info(m->file->f_inode->i_sb);
+	char *p = fs_info->allowlist;
+	unsigned long flags;
+
+	read_lock_irqsave(&fs_info->allowlist_lock, flags);
+	if (p)
+		seq_puts(m, p);
+	read_unlock_irqrestore(&fs_info->allowlist_lock, flags);
+
+	return 0;
+}
+
+static int open_allowlist(struct inode *inode, struct file *file)
+{
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	// we need this because shrink_dcache_sb() can't drop our own dentry.
+	if (!proc_pde_access_allowed(fs_info, PDE(inode)))
+		return -ENOENT;
+
+	// we want a null-terminated string so not all 128K are available.
+	ret = single_open_size(file, show_allowlist, NULL, SZ_128K);
+
+	if (!ret && (file->f_mode & FMODE_WRITE) &&
+	    (file->f_flags & O_APPEND) && !(file->f_flags & O_TRUNC))
+		show_allowlist(FILE_SEQFILE(file), NULL);
+
+	return ret;
+}
+
+static ssize_t write_allowlist(struct file *file, const char __user *buffer, size_t count, loff_t *pos)
+{
+	struct seq_file *seq_file = FILE_SEQFILE(file);
+	ssize_t ret;
+	ssize_t n = count;
+	const char *ptr = buffer;
+
+	if ((seq_file->count + count) >= (seq_file->size - 1))
+		return -EFBIG;
+
+	while (n > 0) {
+		char chunk[SZ_256];
+		loff_t chkpos = 0;
+		ssize_t i, len;
+
+		len = simple_write_to_buffer(chunk, sizeof(chunk), &chkpos, ptr, n);
+		if (len < 0)
+			return len;
+
+		for (i = 0; i < len; i++) {
+			if (!isprint(chunk[i]) && chunk[i] != '\n')
+				return -EINVAL;
+		}
+
+		ret = seq_write(seq_file, chunk, len);
+		if (ret < 0)
+			return -EINVAL;
+
+		ptr += len;
+		n -= len;
+	}
+
+	if (pos)
+		*pos += count;
+
+	return count;
+}
+
+static int close_allowlist(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq_file = FILE_SEQFILE(file);
+	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
+
+	if (seq_file->buf && (file->f_mode & FMODE_WRITE)) {
+		char *buf;
+
+		if (!seq_get_buf(seq_file, &buf))
+			return -EIO;
+		*buf = '\0';
+
+		if (strcmp(seq_file->buf, fs_info->allowlist)) {
+			unsigned long flags;
+
+			buf = kstrndup(seq_file->buf, seq_file->count, GFP_KERNEL_ACCOUNT);
+			if (!buf)
+				return -EIO;
+
+			write_lock_irqsave(&fs_info->allowlist_lock, flags);
+
+			shrink_dcache_sb(inode->i_sb);
+
+			kfree(fs_info->allowlist);
+			fs_info->allowlist = buf;
+
+			write_unlock_irqrestore(&fs_info->allowlist_lock, flags);
+		}
+	}
+
+	return single_release(inode, file);
+}
+
+static const struct proc_ops proc_allowlist_ops = {
+	.proc_open	= open_allowlist,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_write	= write_allowlist,
+	.proc_release	= close_allowlist,
+};
+
+static int __init proc_allowlist_init(void)
+{
+	struct proc_dir_entry *pde;
+	pde = proc_create("allowlist", S_IRUSR | S_IWUSR, NULL, &proc_allowlist_ops);
+	pde_make_permanent(pde);
+	pde_make_allowlist(pde);
+	return 0;
+}
+fs_initcall(proc_allowlist_init);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 5f1015b6418d..1564f5cd118d 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -32,6 +32,7 @@ struct proc_fs_context {
 	enum proc_hidepid	hidepid;
 	int			gid;
 	enum proc_pidonly	pidonly;
+	enum proc_allowlist	allowlist;
 };
 
 enum proc_param {
@@ -99,6 +100,9 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
 		if (*value != '\0') {
 			if (!strcmp(value, "pid")) {
 				ctx->pidonly = PROC_PIDONLY_ON;
+			} else if (IS_ENABLED(CONFIG_PROC_ALLOW_LIST) &&
+				   !strcmp(value, "allowlist")) {
+				ctx->allowlist = PROC_ALLOWLIST_ON;
 			} else {
 				return invalf(fc, "proc: unsupported subset option - %s\n", value);
 			}
@@ -142,6 +146,18 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
+static char *proc_init_allowlist(void)
+{
+	char *content = kstrdup("allowlist\n", GFP_KERNEL_ACCOUNT);
+
+	if (!content) {
+		pr_err("proc_init_allowlist: allocation allowlist failed\n");
+		return NULL;
+	}
+
+	return content;
+}
+
 static void proc_apply_options(struct proc_fs_info *fs_info,
 			       struct fs_context *fc,
 			       struct user_namespace *user_ns)
@@ -152,8 +168,14 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
 		fs_info->hide_pid = ctx->hidepid;
-	if (ctx->mask & (1 << Opt_subset))
+	if (ctx->mask & (1 << Opt_subset)) {
 		fs_info->pidonly = ctx->pidonly;
+		if (ctx->allowlist == PROC_ALLOWLIST_ON) {
+			fs_info->allowlist = proc_init_allowlist();
+		} else {
+			fs_info->allowlist = NULL;
+		}
+	}
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
@@ -167,6 +189,8 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	if (!fs_info)
 		return -ENOMEM;
 
+	rwlock_init(&fs_info->allowlist_lock);
+
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	proc_apply_options(fs_info, fc, current_user_ns());
 
@@ -271,6 +295,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
+	kfree(fs_info->allowlist);
 	kfree(fs_info);
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0260f5ea98fe..9105d75aeb18 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -24,6 +24,7 @@ enum {
 #else
 	PROC_ENTRY_PERMANENT = 1U << 0,
 #endif
+	PROC_ENTRY_ALLOWLIST = 1U << 1,
 };
 
 struct proc_ops {
@@ -58,6 +59,11 @@ enum proc_pidonly {
 	PROC_PIDONLY_ON  = 1,
 };
 
+enum proc_allowlist {
+	PROC_ALLOWLIST_OFF = 0,
+	PROC_ALLOWLIST_ON  = 1,
+};
+
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
 	struct dentry *proc_self;        /* For /proc/self */
@@ -65,6 +71,8 @@ struct proc_fs_info {
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
+	char *allowlist;
+	rwlock_t allowlist_lock;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.33.6

