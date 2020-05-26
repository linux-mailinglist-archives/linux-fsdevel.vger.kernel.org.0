Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C923C1C3793
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 13:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEDLEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 07:04:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbgEDLEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 07:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588590244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VkfN+lWbvFtfkCLXoWvPciyWXkGdcSzlEXtJA502Gk=;
        b=I/RN6QXqlYf6GrAl6LsgUOJ8syiGu96kHl27n3g2IQwqsNkgeGZ2ekDKqsHnz24LRRahwH
        4m4qmjRwcvaUj6ebMeedHB9bROE33GOKktoC3lBGQ4+u5ryKoa1+rxwtoKAPasx63zE03g
        dWzoprZQY+Fe3jWXpepevb9TBWm5YsQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-m-LsSUlrNfC5r_fYmvWeFQ-1; Mon, 04 May 2020 07:04:00 -0400
X-MC-Unique: m-LsSUlrNfC5r_fYmvWeFQ-1
Received: by mail-wr1-f72.google.com with SMTP id r11so10554329wrx.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 04:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VkfN+lWbvFtfkCLXoWvPciyWXkGdcSzlEXtJA502Gk=;
        b=KI6CH8hgQ/HsM/XvzUDOLkR9xt9CDulkUoq5zh89OvzoJu+C+Sd0VaOe+AGVjSEk20
         0R7Jv6KyvK2JS5RgB2vixFBJGpSXZyUsPDsAqlfTtNCqnAU1ERhU+Bt+rwAEw0vLJhdD
         2OkHlFHVQxBaXLernLSALmDv0IH+wDZb2F5u+CzVi7e5Gozvr/LK0BJEQfpXbuuR8U9D
         2uwS84auIaYa2QMSySOCQYtTIwsBZgUXA96F2NbIkcIn+WGrINhhefQ85KC+t4nDxEcU
         uSqHvPI3nQSBNtQ2VbZqmMgjVpKaXFyk9FGwWKgh4DYegzp5CGmSO/4XjdWXIsMRBjNR
         jdXQ==
X-Gm-Message-State: AGi0PuYrm01F9F4dg8B2QWqZJW5V/eH1bv/i2FMVDq6xLQ8EVsw5LRNs
        184xVed1mJcEMKukiOgMp2lkO1BSTA7czxH1K03ATfC+MBIkBwmmM2fJBPAuwRickO+Z1ceG3s4
        Z+y4Cbt60hAfGFeU3+1O0D6jHgA==
X-Received: by 2002:adf:d4d0:: with SMTP id w16mr18692751wrk.264.1588590238153;
        Mon, 04 May 2020 04:03:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJMYICkAN9cpMz9cRRnOmDV9/d+/9UnH/NwQK5n40Rp0IwiF44IBJDbWOx2hddQWmKHbvqNNQ==
X-Received: by 2002:adf:d4d0:: with SMTP id w16mr18692707wrk.264.1588590237693;
        Mon, 04 May 2020 04:03:57 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id a13sm10885750wrv.67.2020.05.04.04.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:03:57 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 4/5] stats_fs fs: virtual fs to show stats to the end-user
Date:   Mon,  4 May 2020 13:03:43 +0200
Message-Id: <20200504110344.17560-5-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504110344.17560-1-eesposit@redhat.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add virtual fs that maps stats_fs sources with directories, and values
(simple or aggregates) to files.

Every time a file is read/cleared, the fs internally invokes the stats_fs
API to get/set the requested value.

fs/stats_fs/inode.c is pretty much similar to what is done in
fs/debugfs/inode.c, with the exception that the API is only
composed by stats_fs_create_file, stats_fs_create_dir and stats_fs_remove.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/stats_fs/Makefile       |   2 +-
 fs/stats_fs/inode.c        | 337 +++++++++++++++++++++++++++++++++++++
 fs/stats_fs/internal.h     |  15 ++
 fs/stats_fs/stats_fs.c     | 163 ++++++++++++++++++
 include/linux/stats_fs.h   |  15 ++
 include/uapi/linux/magic.h |   1 +
 tools/lib/api/fs/fs.c      |  21 +++
 7 files changed, 553 insertions(+), 1 deletion(-)
 create mode 100644 fs/stats_fs/inode.c

diff --git a/fs/stats_fs/Makefile b/fs/stats_fs/Makefile
index 9db130fac6b6..ac12c27545f6 100644
--- a/fs/stats_fs/Makefile
+++ b/fs/stats_fs/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-stats_fs-objs	:= stats_fs.o
+stats_fs-objs	:= inode.o stats_fs.o
 stats_fs-tests-objs	:= stats_fs-tests.o
 
 obj-$(CONFIG_STATS_FS)	+= stats_fs.o
diff --git a/fs/stats_fs/inode.c b/fs/stats_fs/inode.c
new file mode 100644
index 000000000000..865ee91656ba
--- /dev/null
+++ b/fs/stats_fs/inode.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  inode.c - part of stats_fs, a tiny little stats_fs file system
+ *
+ *  Copyright (C) 2020 Emanuele Giuseppe Esposito <eesposit@redhat.com>
+ *  Copyright (C) 2020 Redhat
+ */
+#define pr_fmt(fmt)	"stats_fs: " fmt
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/init.h>
+#include <linux/stats_fs.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/parser.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+#define STATS_FS_DEFAULT_MODE	0700
+
+static struct simple_fs stats_fs;
+static bool stats_fs_registered;
+
+struct stats_fs_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
+	umode_t mode;
+};
+
+enum {
+	Opt_uid,
+	Opt_gid,
+	Opt_mode,
+	Opt_err
+};
+
+static const match_table_t tokens = {
+	{Opt_uid, "uid=%u"},
+	{Opt_gid, "gid=%u"},
+	{Opt_mode, "mode=%o"},
+	{Opt_err, NULL}
+};
+
+struct stats_fs_fs_info {
+	struct stats_fs_mount_opts mount_opts;
+};
+
+static int stats_fs_parse_options(char *data, struct stats_fs_mount_opts *opts)
+{
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+	int token;
+	kuid_t uid;
+	kgid_t gid;
+	char *p;
+
+	opts->mode = STATS_FS_DEFAULT_MODE;
+
+	while ((p = strsep(&data, ",")) != NULL) {
+		if (!*p)
+			continue;
+
+		token = match_token(p, tokens, args);
+		switch (token) {
+		case Opt_uid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			uid = make_kuid(current_user_ns(), option);
+			if (!uid_valid(uid))
+				return -EINVAL;
+			opts->uid = uid;
+			break;
+		case Opt_gid:
+			if (match_int(&args[0], &option))
+				return -EINVAL;
+			gid = make_kgid(current_user_ns(), option);
+			if (!gid_valid(gid))
+				return -EINVAL;
+			opts->gid = gid;
+			break;
+		case Opt_mode:
+			if (match_octal(&args[0], &option))
+				return -EINVAL;
+			opts->mode = option & S_IALLUGO;
+			break;
+		/*
+		 * We might like to report bad mount options here;
+		 * but traditionally stats_fs has ignored all mount options
+		 */
+		}
+	}
+
+	return 0;
+}
+
+static int stats_fs_apply_options(struct super_block *sb)
+{
+	struct stats_fs_fs_info *fsi = sb->s_fs_info;
+	struct inode *inode = d_inode(sb->s_root);
+	struct stats_fs_mount_opts *opts = &fsi->mount_opts;
+
+	inode->i_mode &= ~S_IALLUGO;
+	inode->i_mode |= opts->mode;
+
+	inode->i_uid = opts->uid;
+	inode->i_gid = opts->gid;
+
+	return 0;
+}
+
+static int stats_fs_remount(struct super_block *sb, int *flags, char *data)
+{
+	int err;
+	struct stats_fs_fs_info *fsi = sb->s_fs_info;
+
+	sync_filesystem(sb);
+	err = stats_fs_parse_options(data, &fsi->mount_opts);
+	if (err)
+		goto fail;
+
+	stats_fs_apply_options(sb);
+
+fail:
+	return err;
+}
+
+static int stats_fs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct stats_fs_fs_info *fsi = root->d_sb->s_fs_info;
+	struct stats_fs_mount_opts *opts = &fsi->mount_opts;
+
+	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+			   from_kuid_munged(&init_user_ns, opts->uid));
+	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+			   from_kgid_munged(&init_user_ns, opts->gid));
+	if (opts->mode != STATS_FS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", opts->mode);
+
+	return 0;
+}
+
+
+static void stats_fs_free_inode(struct inode *inode)
+{
+	kfree(inode->i_private);
+	free_inode_nonrcu(inode);
+}
+
+static const struct super_operations stats_fs_super_operations = {
+	.statfs		= simple_statfs,
+	.remount_fs	= stats_fs_remount,
+	.show_options	= stats_fs_show_options,
+	.free_inode	= stats_fs_free_inode,
+};
+
+static int stats_fs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static const struct tree_descr stats_fs_files[] = {{""}};
+	struct stats_fs_fs_info *fsi;
+	int err;
+
+	fsi = kzalloc(sizeof(struct stats_fs_fs_info), GFP_KERNEL);
+	sb->s_fs_info = fsi;
+	if (!fsi) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	err = stats_fs_parse_options(data, &fsi->mount_opts);
+	if (err)
+		goto fail;
+
+	err  =  simple_fill_super(sb, STATSFS_MAGIC, stats_fs_files);
+	if (err)
+		goto fail;
+
+	sb->s_op = &stats_fs_super_operations;
+
+	stats_fs_apply_options(sb);
+
+	return 0;
+
+fail:
+	kfree(fsi);
+	sb->s_fs_info = NULL;
+	return err;
+}
+
+static struct dentry *stats_fs_mount(struct file_system_type *fs_type,
+			int flags, const char *dev_name,
+			void *data)
+{
+	return mount_single(fs_type, flags, data, stats_fs_fill_super);
+}
+
+static struct file_system_type stats_fs_fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"statsfs",
+	.mount =	stats_fs_mount,
+	.kill_sb =	kill_litter_super,
+};
+MODULE_ALIAS_FS("statsfs");
+
+
+/**
+ * stats_fs_create_file - create a file in the stats_fs filesystem
+ * @val: a pointer to a stats_fs_value containing all the infos of
+ * the file to create (name, permission)
+ * @src: a pointer to a stats_fs_source containing the dentry of where
+ * to add this file
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the stats_fs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
+ * returned.
+ *
+ * Val and src will be also inglobated in a ststsfs_data_inode struct
+ * that will be internally stored as inode->i_private and used in the
+ * get/set attribute functions (see stats_fs_ops in stats_fs.c).
+ */
+struct dentry *stats_fs_create_file(struct stats_fs_value *val, struct stats_fs_source *src)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	struct stats_fs_data_inode *val_inode;
+
+	val_inode = kzalloc(sizeof(struct stats_fs_data_inode), GFP_KERNEL);
+	if (!val_inode) {
+		printk(KERN_ERR
+			"Kzalloc failure in stats_fs_create_files (ENOMEM)\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	val_inode->src = src;
+	val_inode->val = val;
+
+
+	dentry = simplefs_create_file(&stats_fs, &stats_fs_fs_type,
+				      val->name, stats_fs_val_get_mode(val),
+					  src->source_dentry, val_inode, &inode);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode->i_fop = &stats_fs_ops;
+
+	return simplefs_finish_dentry(dentry, inode);
+}
+/**
+ * stats_fs_create_dir - create a directory in the stats_fs filesystem
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          directory will be created in the root of the stats_fs filesystem.
+ *
+ * This function creates a directory in stats_fs with the given name.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the stats_fs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
+ * returned.
+ */
+struct dentry *stats_fs_create_dir(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = simplefs_create_dir(&stats_fs, &stats_fs_fs_type,
+				     name, 0755, parent, &inode);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode->i_op = &simple_dir_inode_operations;
+	return simplefs_finish_dentry(dentry, inode);
+}
+
+static void remove_one(struct dentry *victim)
+{
+	simple_release_fs(&stats_fs);
+}
+
+/**
+ * stats_fs_remove - recursively removes a directory
+ * @dentry: a pointer to a the dentry of the directory to be removed.  If this
+ *          parameter is NULL or an error value, nothing will be done.
+ *
+ * This function recursively removes a directory tree in stats_fs that
+ * was previously created with a call to another stats_fs function
+ * (like stats_fs_create_file() or variants thereof.)
+ *
+ * This function is required to be called in order for the file to be
+ * removed, no automatic cleanup of files will happen when a module is
+ * removed, you are responsible here.
+ */
+void stats_fs_remove(struct dentry *dentry)
+{
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	simple_pin_fs(&stats_fs, &stats_fs_fs_type);
+	simple_recursive_removal(dentry, remove_one);
+	simple_release_fs(&stats_fs);
+}
+/**
+ * stats_fs_initialized - Tells whether stats_fs has been registered
+ */
+bool stats_fs_initialized(void)
+{
+	return stats_fs_registered;
+}
+EXPORT_SYMBOL_GPL(stats_fs_initialized);
+
+static int __init stats_fs_init(void)
+{
+	int retval;
+
+	retval = sysfs_create_mount_point(kernel_kobj, "statsfs");
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&stats_fs_fs_type);
+	if (retval)
+		sysfs_remove_mount_point(kernel_kobj, "statsfs");
+	else
+		stats_fs_registered = true;
+
+	return retval;
+}
+core_initcall(stats_fs_init);
diff --git a/fs/stats_fs/internal.h b/fs/stats_fs/internal.h
index ddf262a60736..1f7bb1da6c3c 100644
--- a/fs/stats_fs/internal.h
+++ b/fs/stats_fs/internal.h
@@ -15,6 +15,21 @@ struct stats_fs_value_source {
 	struct list_head list_element;
 };
 
+struct stats_fs_data_inode {
+	struct stats_fs_source *src;
+	struct stats_fs_value *val;
+};
+
+extern const struct file_operations stats_fs_ops;
+
+struct dentry *stats_fs_create_file(struct stats_fs_value *val,
+				   struct stats_fs_source *src);
+
+struct dentry *stats_fs_create_dir(const char *name, struct dentry *parent);
+
+void stats_fs_remove(struct dentry *dentry);
+#define stats_fs_remove_recursive stats_fs_remove
+
 int stats_fs_val_get_mode(struct stats_fs_value *val);
 
 #endif /* _STATS_FS_INTERNAL_H_ */
diff --git a/fs/stats_fs/stats_fs.c b/fs/stats_fs/stats_fs.c
index b63de12769e2..4ac6fe1ec62e 100644
--- a/fs/stats_fs/stats_fs.c
+++ b/fs/stats_fs/stats_fs.c
@@ -17,16 +17,114 @@ struct stats_fs_aggregate_value {
 	uint32_t count, count_zero;
 };
 
+static void stats_fs_source_remove_files(struct stats_fs_source *src);
+
 static int is_val_signed(struct stats_fs_value *val)
 {
 	return val->type & STATS_FS_SIGN;
 }
 
+static int stats_fs_attr_get(void *data, u64 *val)
+{
+	int r = -EFAULT;
+	struct stats_fs_data_inode *val_inode =
+		(struct stats_fs_data_inode *)data;
+
+	r = stats_fs_source_get_value(val_inode->src, val_inode->val, val);
+	return r;
+}
+
+static int stats_fs_attr_clear(void *data, u64 val)
+{
+	int r = -EFAULT;
+	struct stats_fs_data_inode *val_inode =
+		(struct stats_fs_data_inode *)data;
+
+	if (val)
+		return -EINVAL;
+
+	r = stats_fs_source_clear(val_inode->src, val_inode->val);
+	return r;
+}
+
 int stats_fs_val_get_mode(struct stats_fs_value *val)
 {
 	return val->mode ? val->mode : 0644;
 }
 
+static int stats_fs_attr_data_open(struct inode *inode, struct file *file)
+{
+	struct stats_fs_data_inode *val_inode;
+	char *fmt;
+
+	val_inode = (struct stats_fs_data_inode *)inode->i_private;
+
+	/* Inodes hold a  pointer to the source which is not included in the
+	 * refcount, so they files be opened while destroy is running, but
+	 * values are removed (base_addr = NULL) before the source is destroyed.
+	 */
+	if (!kref_get_unless_zero(&val_inode->src->refcount))
+		return -ENOENT;
+
+	if (is_val_signed(val_inode->val))
+		fmt = "%lld\n";
+	else
+		fmt = "%llu\n";
+
+	if (simple_attr_open(inode, file, stats_fs_attr_get,
+			     stats_fs_val_get_mode(val_inode->val) & 0222 ?
+				     stats_fs_attr_clear :
+				     NULL,
+			     fmt)) {
+		stats_fs_source_put(val_inode->src);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int stats_fs_attr_release(struct inode *inode, struct file *file)
+{
+	struct stats_fs_data_inode *val_inode;
+
+	val_inode = (struct stats_fs_data_inode *)inode->i_private;
+
+	simple_attr_release(inode, file);
+	stats_fs_source_put(val_inode->src);
+
+	return 0;
+}
+
+const struct file_operations stats_fs_ops = {
+	.owner = THIS_MODULE,
+	.open = stats_fs_attr_data_open,
+	.release = stats_fs_attr_release,
+	.read = simple_attr_read,
+	.write = simple_attr_write,
+	.llseek = no_llseek,
+};
+
+/* Called with rwsem held for writing */
+static void stats_fs_source_remove_files_locked(struct stats_fs_source *src)
+{
+	struct stats_fs_source *child;
+
+	if (src->source_dentry == NULL)
+		return;
+
+	list_for_each_entry (child, &src->subordinates_head, list_element)
+		stats_fs_source_remove_files(child);
+
+	stats_fs_remove_recursive(src->source_dentry);
+	src->source_dentry = NULL;
+}
+
+static void stats_fs_source_remove_files(struct stats_fs_source *src)
+{
+	down_write(&src->rwsem);
+	stats_fs_source_remove_files_locked(src);
+	up_write(&src->rwsem);
+}
+
 static struct stats_fs_value *find_value(struct stats_fs_value_source *src,
 					 struct stats_fs_value *val)
 {
@@ -57,6 +155,62 @@ search_value_in_source(struct stats_fs_source *src, struct stats_fs_value *arg,
 	return NULL;
 }
 
+/* Called with rwsem held for writing */
+static void stats_fs_create_files_locked(struct stats_fs_source *source)
+{
+	struct stats_fs_value_source *val_src;
+	struct stats_fs_value *val;
+
+	if (!source->source_dentry)
+		return;
+
+	list_for_each_entry (val_src, &source->values_head, list_element) {
+		if (val_src->files_created)
+			continue;
+
+		for (val = val_src->values; val->name; val++)
+			stats_fs_create_file(val, source);
+
+		val_src->files_created = true;
+	}
+}
+
+/* Called with rwsem held for writing */
+static void
+stats_fs_create_files_recursive_locked(struct stats_fs_source *source,
+				       struct dentry *parent_dentry)
+{
+	struct stats_fs_source *child;
+
+	/* first check values in this folder, since it might be new */
+	if (!source->source_dentry) {
+		source->source_dentry =
+			stats_fs_create_dir(source->name, parent_dentry);
+	}
+
+	stats_fs_create_files_locked(source);
+
+	list_for_each_entry (child, &source->subordinates_head, list_element) {
+		if (child->source_dentry == NULL) {
+			/* assume that if child has a folder,
+			 * also the sub-child have that.
+			 */
+			down_write(&child->rwsem);
+			stats_fs_create_files_recursive_locked(
+				child, source->source_dentry);
+			up_write(&child->rwsem);
+		}
+	}
+}
+
+void stats_fs_source_register(struct stats_fs_source *source)
+{
+	down_write(&source->rwsem);
+	stats_fs_create_files_recursive_locked(source, NULL);
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(stats_fs_source_register);
+
 /* Called with rwsem held for writing */
 static struct stats_fs_value_source *create_value_source(void *base)
 {
@@ -93,6 +247,9 @@ int stats_fs_source_add_values(struct stats_fs_source *source,
 	/* add the val_src to the source list */
 	list_add(&val_src->list_element, &source->values_head);
 
+	/* create child if it's the case */
+	stats_fs_create_files_locked(source);
+
 	up_write(&source->rwsem);
 
 	return 0;
@@ -106,6 +263,9 @@ void stats_fs_source_add_subordinate(struct stats_fs_source *source,
 
 	stats_fs_source_get(sub);
 	list_add(&sub->list_element, &source->subordinates_head);
+	if (source->source_dentry)
+		stats_fs_create_files_recursive_locked(sub,
+						       source->source_dentry);
 
 	up_write(&source->rwsem);
 }
@@ -122,6 +282,7 @@ stats_fs_source_remove_subordinate_locked(struct stats_fs_source *source,
 			     list_element) {
 		if (src_entry == sub) {
 			list_del_init(&src_entry->list_element);
+			stats_fs_source_remove_files(src_entry);
 			stats_fs_source_put(src_entry);
 			return;
 		}
@@ -565,6 +726,8 @@ static void stats_fs_source_destroy(struct kref *kref_source)
 		stats_fs_source_remove_subordinate_locked(source, child);
 	}
 
+	stats_fs_source_remove_files_locked(source);
+
 	up_write(&source->rwsem);
 	kfree(source->name);
 	kfree(source);
diff --git a/include/linux/stats_fs.h b/include/linux/stats_fs.h
index dc2d2e11f5ea..b04c42d827cf 100644
--- a/include/linux/stats_fs.h
+++ b/include/linux/stats_fs.h
@@ -87,6 +87,18 @@ struct stats_fs_source {
  */
 struct stats_fs_source *stats_fs_source_create(const char *fmt, ...);
 
+/**
+ * stats_fs_source_register - register a source in the stats_fs filesystem
+ * @source: a pointer to the source that will be registered
+ *
+ * Add the given folder as direct child of /sys/kernel/statsfs.
+ * It also starts to recursively search its own child and create all folders
+ * and files if they weren't already. All subsequent add_subordinate calls
+ * on the same source that is used in this function will create corresponding
+ * files and directories.
+ */
+void stats_fs_source_register(struct stats_fs_source *source);
+
 /**
  * stats_fs_source_add_values - adds values to the given source
  * @source: a pointer to the source that will receive the values
@@ -235,6 +247,9 @@ static inline struct stats_fs_source *stats_fs_source_create(const char *fmt,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline void stats_fs_source_register(struct stats_fs_source *source)
+{ }
+
 static inline int stats_fs_source_add_values(struct stats_fs_source *source,
 					     struct stats_fs_value *val,
 					     void *base_ptr)
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index d78064007b17..46c66ea3fc9e 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -10,6 +10,7 @@
 #define CRAMFS_MAGIC		0x28cd3d45	/* some random number */
 #define CRAMFS_MAGIC_WEND	0x453dcd28	/* magic number with the wrong endianess */
 #define DEBUGFS_MAGIC          0x64626720
+#define STATSFS_MAGIC          0x73746174
 #define SECURITYFS_MAGIC	0x73636673
 #define SELINUX_MAGIC		0xf97cff8c
 #define SMACK_MAGIC		0x43415d53	/* "SMAC" */
diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 027b18f7ed8c..6fe306206dfb 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -35,6 +35,10 @@
 #define TRACEFS_MAGIC          0x74726163
 #endif
 
+#ifndef STATSFS_MAGIC
+#define STATSFS_MAGIC          0x73746174
+#endif
+
 #ifndef HUGETLBFS_MAGIC
 #define HUGETLBFS_MAGIC        0x958458f6
 #endif
@@ -76,6 +80,16 @@ static const char * const tracefs__known_mountpoints[] = {
 	0,
 };
 
+#ifndef STATSFS_DEFAULT_PATH
+#define STATSFS_DEFAULT_PATH "/sys/kernel/statsfs"
+#endif
+
+static const char * const statsfs__known_mountpoints[] = {
+	STATSFS_DEFAULT_PATH,
+	"/statsfs",
+	0,
+};
+
 static const char * const hugetlbfs__known_mountpoints[] = {
 	0,
 };
@@ -100,6 +114,7 @@ enum {
 	FS__TRACEFS = 3,
 	FS__HUGETLBFS = 4,
 	FS__BPF_FS = 5,
+	FS__STATSFS = 6,
 };
 
 #ifndef TRACEFS_MAGIC
@@ -127,6 +142,11 @@ static struct fs fs__entries[] = {
 		.mounts	= tracefs__known_mountpoints,
 		.magic	= TRACEFS_MAGIC,
 	},
+	[FS__STATSFS] = {
+		.name	= "statsfs",
+		.mounts	= statsfs__known_mountpoints,
+		.magic	= STATSFS_MAGIC,
+	},
 	[FS__HUGETLBFS] = {
 		.name	= "hugetlbfs",
 		.mounts = hugetlbfs__known_mountpoints,
@@ -297,6 +317,7 @@ FS(sysfs,   FS__SYSFS);
 FS(procfs,  FS__PROCFS);
 FS(debugfs, FS__DEBUGFS);
 FS(tracefs, FS__TRACEFS);
+FS(statsfs, FS__STATSFS);
 FS(hugetlbfs, FS__HUGETLBFS);
 FS(bpf_fs, FS__BPF_FS);
 
-- 
2.25.2

