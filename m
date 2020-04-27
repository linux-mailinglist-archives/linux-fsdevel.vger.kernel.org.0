Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7D1BA626
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgD0OSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 10:18:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36633 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727855AbgD0OSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587997113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXBh56e/cVjJYDBi4/WWQN3ZOpbJ4iri789A7MlSYT4=;
        b=GdLtMT92ocPAt0pKpKN5IE+9P2wOW+kr5WnmCUjIUXJhU+3mRKQtiYXsDC1gpqGJGeqIvc
        OzhjOxr8SA/FOT5BoYx8nGyZcFP+YuMbORHnmVDJi/9Z5xqUv0xjIBrIdw2fVuTLyju9u5
        ZdOo8o1sIM7xSLpqfHAU95R23FlscOU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-13eYywvsOzuTc8MmTd2yXA-1; Mon, 27 Apr 2020 10:18:31 -0400
X-MC-Unique: 13eYywvsOzuTc8MmTd2yXA-1
Received: by mail-wm1-f70.google.com with SMTP id h6so7214456wmi.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 07:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eXBh56e/cVjJYDBi4/WWQN3ZOpbJ4iri789A7MlSYT4=;
        b=niGVRLwNZXu8Up2Qt4IqGlmOOKRx15a9ao9aGDiHE5b84KYvsVp5iiqwx+kJIj/Kdt
         fV0NrBb7/jWngwpZFpNFSMm6udczljytSV3vH+CYW3OLiDhsYNEYBx3AtZfTuDgUQQd/
         jy61pG4loP2sXiQ6Qz6FTEX+zWKBt/pUQGayMZlsx79cNFoboBuUIBQStsAMZF5FhZ54
         u/dnGm7ZFq+mRFbpGiVL/gLPHi5qS+ieUA4iOky5NU0/YIW2xdZ59r3Dwi2x0xFijsj6
         5c2J3ijY0iQHvlba6Dx/vfMQrFiGawtUKEbhugVcxhb1eSuawAGg++IQTZDH+xcrwC3m
         bgZw==
X-Gm-Message-State: AGi0Pub9+IOtn3YkaVerVIoGEGEmrWO5OcvRbk+x3GrWVUZae8Jrlo2C
        NAH5Y7K8pCzpcVLkv6TAqyngijb4RtaMuRsLlRPybOLP9ZEaVqFdZKqKv+M01pxeOrS9alxD8Vg
        NTiRMjuLCdyJYF+Fkn1I00PVpAA==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr27339857wrr.253.1587997109772;
        Mon, 27 Apr 2020 07:18:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8vPCMrKQz05i3LpJNlEx9PWnqzC/jC7kqfVpEpnkAve0tGVXLHNJYwEzBjoISKlDyUNkc7Q==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr27339822wrr.253.1587997109250;
        Mon, 27 Apr 2020 07:18:29 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.207])
        by smtp.gmail.com with ESMTPSA id 1sm15914570wmz.13.2020.04.27.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:18:28 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mst@redhat.com,
        borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [RFC PATCH 4/5] statsfs fs: virtual fs to show stats to the end-user
Date:   Mon, 27 Apr 2020 16:18:15 +0200
Message-Id: <20200427141816.16703-5-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200427141816.16703-1-eesposit@redhat.com>
References: <20200427141816.16703-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add virtual fs that maps statsfs sources with directories, and values
(simple or aggregates) to files.

Every time a file is read/cleared, the fs internally invokes the statsfs
API to get/set the requested value.

fs/statsfs/inode.cis pretty much similar to what is done in
fs/debugfs/inode.c, with the exception that the API is only
composed by statsfs_create_file, statsfs_create_dir and statsfs_remove.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/statsfs/Makefile        |   2 +-
 fs/statsfs/inode.c         | 337 +++++++++++++++++++++++++++++++++++++
 fs/statsfs/internal.h      |  15 ++
 fs/statsfs/statsfs.c       | 162 ++++++++++++++++++
 include/linux/statsfs.h    |  12 ++
 include/uapi/linux/magic.h |   1 +
 tools/lib/api/fs/fs.c      |  21 +++
 7 files changed, 549 insertions(+), 1 deletion(-)
 create mode 100644 fs/statsfs/inode.c

diff --git a/fs/statsfs/Makefile b/fs/statsfs/Makefile
index f546e3f03a12..5df4513a2f34 100644
--- a/fs/statsfs/Makefile
+++ b/fs/statsfs/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-statsfs-objs	:= statsfs.o
+statsfs-objs	:= inode.o statsfs.o
 statsfs-tests-objs	:= statsfs-tests.o
 
 obj-$(CONFIG_STATS_FS)	+= statsfs.o
diff --git a/fs/statsfs/inode.c b/fs/statsfs/inode.c
new file mode 100644
index 000000000000..f774c6618017
--- /dev/null
+++ b/fs/statsfs/inode.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  inode.c - part of statsfs, a tiny little statsfs file system
+ *
+ *  Copyright (C) 2020 Emanuele Giuseppe Esposito <eesposit@redhat.com>
+ *  Copyright (C) 2020 Redhat
+ */
+#define pr_fmt(fmt)	"statsfs: " fmt
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/init.h>
+#include <linux/statsfs.h>
+#include <linux/string.h>
+#include <linux/seq_file.h>
+#include <linux/parser.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+#define STATSFS_DEFAULT_MODE	0700
+
+static struct simple_fs statsfs;
+static bool statsfs_registered;
+
+struct statsfs_mount_opts {
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
+struct statsfs_fs_info {
+	struct statsfs_mount_opts mount_opts;
+};
+
+static int statsfs_parse_options(char *data, struct statsfs_mount_opts *opts)
+{
+	substring_t args[MAX_OPT_ARGS];
+	int option;
+	int token;
+	kuid_t uid;
+	kgid_t gid;
+	char *p;
+
+	opts->mode = STATSFS_DEFAULT_MODE;
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
+		 * but traditionally statsfs has ignored all mount options
+		 */
+		}
+	}
+
+	return 0;
+}
+
+static int statsfs_apply_options(struct super_block *sb)
+{
+	struct statsfs_fs_info *fsi = sb->s_fs_info;
+	struct inode *inode = d_inode(sb->s_root);
+	struct statsfs_mount_opts *opts = &fsi->mount_opts;
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
+static int statsfs_remount(struct super_block *sb, int *flags, char *data)
+{
+	int err;
+	struct statsfs_fs_info *fsi = sb->s_fs_info;
+
+	sync_filesystem(sb);
+	err = statsfs_parse_options(data, &fsi->mount_opts);
+	if (err)
+		goto fail;
+
+	statsfs_apply_options(sb);
+
+fail:
+	return err;
+}
+
+static int statsfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct statsfs_fs_info *fsi = root->d_sb->s_fs_info;
+	struct statsfs_mount_opts *opts = &fsi->mount_opts;
+
+	if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+			   from_kuid_munged(&init_user_ns, opts->uid));
+	if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+			   from_kgid_munged(&init_user_ns, opts->gid));
+	if (opts->mode != STATSFS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", opts->mode);
+
+	return 0;
+}
+
+
+static void statsfs_free_inode(struct inode *inode)
+{
+	kfree(inode->i_private);
+	free_inode_nonrcu(inode);
+}
+
+static const struct super_operations statsfs_super_operations = {
+	.statfs		= simple_statfs,
+	.remount_fs	= statsfs_remount,
+	.show_options	= statsfs_show_options,
+	.free_inode	= statsfs_free_inode,
+};
+
+static int statsfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	static const struct tree_descr statsfs_files[] = {{""}};
+	struct statsfs_fs_info *fsi;
+	int err;
+
+	fsi = kzalloc(sizeof(struct statsfs_fs_info), GFP_KERNEL);
+	sb->s_fs_info = fsi;
+	if (!fsi) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	err = statsfs_parse_options(data, &fsi->mount_opts);
+	if (err)
+		goto fail;
+
+	err  =  simple_fill_super(sb, STATSFS_MAGIC, statsfs_files);
+	if (err)
+		goto fail;
+
+	sb->s_op = &statsfs_super_operations;
+
+	statsfs_apply_options(sb);
+
+	return 0;
+
+fail:
+	kfree(fsi);
+	sb->s_fs_info = NULL;
+	return err;
+}
+
+static struct dentry *statsfs_mount(struct file_system_type *fs_type,
+			int flags, const char *dev_name,
+			void *data)
+{
+	return mount_single(fs_type, flags, data, statsfs_fill_super);
+}
+
+static struct file_system_type statsfs_fs_type = {
+	.owner =	THIS_MODULE,
+	.name =		"statsfs",
+	.mount =	statsfs_mount,
+	.kill_sb =	kill_litter_super,
+};
+MODULE_ALIAS_FS("statsfs");
+
+
+/**
+ * statsfs_create_file - create a file in the statsfs filesystem
+ * @val: a pointer to a statsfs_value containing all the infos of
+ * the file to create (name, permission)
+ * @src: a pointer to a statsfs_source containing the dentry of where
+ * to add this file
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the statsfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
+ * returned.
+ *
+ * Val and src will be also inglobated in a ststsfs_data_inode struct
+ * that will be internally stored as inode->i_private and used in the
+ * get/set attribute functions (see statsfs_ops in statsfs.c).
+ */
+struct dentry *statsfs_create_file(struct statsfs_value *val, struct statsfs_source *src)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	struct statsfs_data_inode *val_inode;
+
+	val_inode = kzalloc(sizeof(struct statsfs_data_inode), GFP_KERNEL);
+	if (!val_inode) {
+		printk(KERN_ERR
+			"Kzalloc failure in statsfs_create_files (ENOMEM)\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	val_inode->src = src;
+	val_inode->val = val;
+
+
+	dentry = simplefs_create_file(&statsfs, &statsfs_fs_type,
+				      val->name, statsfs_val_get_mode(val),
+					  src->source_dentry, val_inode, &inode);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode->i_fop = &statsfs_ops;
+
+	return simplefs_finish_dentry(dentry, inode);
+}
+/**
+ * statsfs_create_dir - create a directory in the statsfs filesystem
+ * @name: a pointer to a string containing the name of the directory to
+ *        create.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          directory will be created in the root of the statsfs filesystem.
+ *
+ * This function creates a directory in statsfs with the given name.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the statsfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
+ * returned.
+ */
+struct dentry *statsfs_create_dir(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+
+	dentry = simplefs_create_dir(&statsfs, &statsfs_fs_type,
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
+	simple_release_fs(&statsfs);
+}
+
+/**
+ * statsfs_remove - recursively removes a directory
+ * @dentry: a pointer to a the dentry of the directory to be removed.  If this
+ *          parameter is NULL or an error value, nothing will be done.
+ *
+ * This function recursively removes a directory tree in statsfs that
+ * was previously created with a call to another statsfs function
+ * (like statsfs_create_file() or variants thereof.)
+ *
+ * This function is required to be called in order for the file to be
+ * removed, no automatic cleanup of files will happen when a module is
+ * removed, you are responsible here.
+ */
+void statsfs_remove(struct dentry *dentry)
+{
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	simple_pin_fs(&statsfs, &statsfs_fs_type);
+	simple_recursive_removal(dentry, remove_one);
+	simple_release_fs(&statsfs);
+}
+/**
+ * statsfs_initialized - Tells whether statsfs has been registered
+ */
+bool statsfs_initialized(void)
+{
+	return statsfs_registered;
+}
+EXPORT_SYMBOL_GPL(statsfs_initialized);
+
+static int __init statsfs_init(void)
+{
+	int retval;
+
+	retval = sysfs_create_mount_point(kernel_kobj, "statsfs");
+	if (retval)
+		return retval;
+
+	retval = register_filesystem(&statsfs_fs_type);
+	if (retval)
+		sysfs_remove_mount_point(kernel_kobj, "statsfs");
+	else
+		statsfs_registered = true;
+
+	return retval;
+}
+core_initcall(statsfs_init);
diff --git a/fs/statsfs/internal.h b/fs/statsfs/internal.h
index f124683a2ded..64211f252d6c 100644
--- a/fs/statsfs/internal.h
+++ b/fs/statsfs/internal.h
@@ -15,6 +15,21 @@ struct statsfs_value_source {
 	struct list_head list_element;
 };
 
+struct statsfs_data_inode {
+	struct statsfs_source *src;
+	struct statsfs_value *val;
+};
+
+extern const struct file_operations statsfs_ops;
+
+struct dentry *statsfs_create_file(struct statsfs_value *val,
+				   struct statsfs_source *src);
+
+struct dentry *statsfs_create_dir(const char *name, struct dentry *parent);
+
+void statsfs_remove(struct dentry *dentry);
+#define statsfs_remove_recursive statsfs_remove
+
 int statsfs_val_get_mode(struct statsfs_value *val);
 
 #endif /* _STATSFS_INTERNAL_H_ */
diff --git a/fs/statsfs/statsfs.c b/fs/statsfs/statsfs.c
index 0ad1d985be46..5a56a2cef581 100644
--- a/fs/statsfs/statsfs.c
+++ b/fs/statsfs/statsfs.c
@@ -17,16 +17,114 @@ struct statsfs_aggregate_value {
 	uint32_t count, count_zero;
 };
 
+static void statsfs_source_remove_files(struct statsfs_source *src);
+
 static int is_val_signed(struct statsfs_value *val)
 {
 	return val->type & STATSFS_SIGN;
 }
 
+static int statsfs_attr_get(void *data, u64 *val)
+{
+	int r = -EFAULT;
+	struct statsfs_data_inode *val_inode =
+		(struct statsfs_data_inode *)data;
+
+	r = statsfs_source_get_value(val_inode->src, val_inode->val, val);
+	return r;
+}
+
+static int statsfs_attr_clear(void *data, u64 val)
+{
+	int r = -EFAULT;
+	struct statsfs_data_inode *val_inode =
+		(struct statsfs_data_inode *)data;
+
+	if (val)
+		return -EINVAL;
+
+	r = statsfs_source_clear(val_inode->src, val_inode->val);
+	return r;
+}
+
 int statsfs_val_get_mode(struct statsfs_value *val)
 {
 	return val->mode ? val->mode : 0644;
 }
 
+static int statsfs_attr_data_open(struct inode *inode, struct file *file)
+{
+	struct statsfs_data_inode *val_inode;
+	char *fmt;
+
+	val_inode = (struct statsfs_data_inode *)inode->i_private;
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
+	if (simple_attr_open(inode, file, statsfs_attr_get,
+			     statsfs_val_get_mode(val_inode->val) & 0222 ?
+				     statsfs_attr_clear :
+				     NULL,
+			     fmt)) {
+		statsfs_source_put(val_inode->src);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static int statsfs_attr_release(struct inode *inode, struct file *file)
+{
+	struct statsfs_data_inode *val_inode;
+
+	val_inode = (struct statsfs_data_inode *)inode->i_private;
+
+	simple_attr_release(inode, file);
+	statsfs_source_put(val_inode->src);
+
+	return 0;
+}
+
+const struct file_operations statsfs_ops = {
+	.owner = THIS_MODULE,
+	.open = statsfs_attr_data_open,
+	.release = statsfs_attr_release,
+	.read = simple_attr_read,
+	.write = simple_attr_write,
+	.llseek = no_llseek,
+};
+
+/* Called with rwsem held for writing */
+static void statsfs_source_remove_files_locked(struct statsfs_source *src)
+{
+	struct statsfs_source *child;
+
+	if (src->source_dentry == NULL)
+		return;
+
+	list_for_each_entry(child, &src->subordinates_head, list_element)
+		statsfs_source_remove_files(child);
+
+	statsfs_remove_recursive(src->source_dentry);
+	src->source_dentry = NULL;
+}
+
+static void statsfs_source_remove_files(struct statsfs_source *src)
+{
+	down_write(&src->rwsem);
+	statsfs_source_remove_files_locked(src);
+	up_write(&src->rwsem);
+}
+
 static struct statsfs_value *find_value(struct statsfs_value_source *src,
 					struct statsfs_value *val)
 {
@@ -59,6 +157,61 @@ search_value_in_source(struct statsfs_source *src, struct statsfs_value *arg,
 	return NULL;
 }
 
+/* Called with rwsem held for writing */
+static void statsfs_create_files_locked(struct statsfs_source *source)
+{
+	struct statsfs_value_source *val_src;
+	struct statsfs_value *val;
+
+	if (!source->source_dentry)
+		return;
+
+	list_for_each_entry(val_src, &source->values_head, list_element) {
+		if (val_src->files_created)
+			continue;
+
+		for (val = val_src->values; val->name; val++)
+			statsfs_create_file(val, source);
+
+		val_src->files_created = true;
+	}
+}
+
+/* Called with rwsem held for writing */
+static void statsfs_create_files_recursive_locked(struct statsfs_source *source,
+						  struct dentry *parent_dentry)
+{
+	struct statsfs_source *child;
+
+	/* first check values in this folder, since it might be new */
+	if (!source->source_dentry) {
+		source->source_dentry =
+			statsfs_create_dir(source->name, parent_dentry);
+	}
+
+	statsfs_create_files_locked(source);
+
+	list_for_each_entry(child, &source->subordinates_head, list_element) {
+		if (child->source_dentry == NULL) {
+			/* assume that if child has a folder,
+			 * also the sub-child have that.
+			 */
+			down_write(&child->rwsem);
+			statsfs_create_files_recursive_locked(
+				child, source->source_dentry);
+			up_write(&child->rwsem);
+		}
+	}
+}
+
+void statsfs_source_register(struct statsfs_source *source)
+{
+	down_write(&source->rwsem);
+	statsfs_create_files_recursive_locked(source, NULL);
+	up_write(&source->rwsem);
+}
+EXPORT_SYMBOL_GPL(statsfs_source_register);
+
 /* Called with rwsem held for writing */
 static struct statsfs_value_source *create_value_source(void *base)
 {
@@ -96,6 +249,9 @@ int statsfs_source_add_values(struct statsfs_source *source,
 	/* add the val_src to the source list */
 	list_add(&val_src->list_element, &source->values_head);
 
+	/* create child if it's the case */
+	statsfs_create_files_locked(source);
+
 	up_write(&source->rwsem);
 
 	return 0;
@@ -109,6 +265,10 @@ void statsfs_source_add_subordinate(struct statsfs_source *source,
 
 	statsfs_source_get(sub);
 	list_add(&sub->list_element, &source->subordinates_head);
+	if (source->source_dentry) {
+		statsfs_create_files_recursive_locked(sub,
+						      source->source_dentry);
+	}
 
 	up_write(&source->rwsem);
 }
@@ -127,6 +287,7 @@ statsfs_source_remove_subordinate_locked(struct statsfs_source *source,
 		if (src_entry == sub) {
 			WARN_ON(strcmp(src_entry->name, sub->name) != 0);
 			list_del_init(&src_entry->list_element);
+			statsfs_source_remove_files(src_entry);
 			statsfs_source_put(src_entry);
 			return;
 		}
@@ -572,6 +733,7 @@ static void statsfs_source_destroy(struct kref *kref_source)
 		statsfs_source_remove_subordinate_locked(source, child);
 	}
 
+	statsfs_source_remove_files_locked(source);
 
 	up_write(&source->rwsem);
 	kfree(source->name);
diff --git a/include/linux/statsfs.h b/include/linux/statsfs.h
index 3f01f094946d..f6e8eead1124 100644
--- a/include/linux/statsfs.h
+++ b/include/linux/statsfs.h
@@ -87,6 +87,18 @@ struct statsfs_source {
  */
 struct statsfs_source *statsfs_source_create(const char *fmt, ...);
 
+/**
+ * statsfs_source_register - register a source in the statsfs filesystem
+ * @source: a pointer to the source that will be registered
+ *
+ * TAdd the given folder as direct child of /sys/kernel/statsfs.
+ * It also starts to recursively search its own child and create all folders
+ * and files if they weren't already. All subsequent add_subordinate calls
+ * on the same source that is used in this function will create corresponding
+ * files and directories.
+ */
+void statsfs_source_register(struct statsfs_source *source);
+
 /**
  * statsfs_source_add_values - adds values to the given source
  * @source: a pointer to the source that will receive the values
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

