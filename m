Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB84F28E201
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbgJNOPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 10:15:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:42450 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbgJNOPX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:15:23 -0400
Received: from [172.16.25.93] (helo=amikhalitsyn-pc0.sw.ru)
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kShXi-004ONi-FS; Wed, 14 Oct 2020 17:14:14 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     miklos@szeredi.hu
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] overlayfs: add fsinfo(FSINFO_ATTR_OVL_SOURCES) support
Date:   Wed, 14 Oct 2020 17:14:16 +0300
Message-Id: <20201014141416.25272-1-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FSINFO_ATTR_OVL_SOURCES fsinfo attribute allows us
to export fhandles for overlayfs source directories
such as upperdir, workdir, lowerdirs.

This patchs adds initial support of fsinfo into overlayfs.
If community decide to take this way of C/R support
in overlayfs then I have plan to implement FSINFO_ATTR_SUPPORTS
and FSINFO_ATTR_FEATURES standard attributes handlers too.

Cc: David Howells <dhowells@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
---
 fs/overlayfs/Makefile       |   1 +
 fs/overlayfs/fsinfo.c       | 133 ++++++++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h    |   6 ++
 fs/overlayfs/super.c        |   3 +
 include/uapi/linux/fsinfo.h |  31 +++++++++
 5 files changed, 174 insertions(+)
 create mode 100644 fs/overlayfs/fsinfo.c

diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
index 9164c585eb2f..db555c0e4508 100644
--- a/fs/overlayfs/Makefile
+++ b/fs/overlayfs/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_OVERLAY_FS) += overlay.o
 
 overlay-objs := super.o namei.o util.o inode.o file.o dir.o readdir.o \
 		copy_up.o export.o
+overlay-$(CONFIG_FSINFO)	+= fsinfo.o
diff --git a/fs/overlayfs/fsinfo.c b/fs/overlayfs/fsinfo.c
new file mode 100644
index 000000000000..9857949dcce5
--- /dev/null
+++ b/fs/overlayfs/fsinfo.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Filesystem information for overlayfs
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/mount.h>
+#include <linux/fsinfo.h>
+#include "overlayfs.h"
+
+static int __ovl_encode_mnt_opt_fh(struct fsinfo_ovl_source *p,
+				   struct dentry *dentry)
+{
+	int fh_type, dwords;
+	int buflen = MAX_HANDLE_SZ;
+	int err;
+
+	/* we ask for a non connected handle */
+	dwords = buflen >> 2;
+	fh_type = exportfs_encode_fh(dentry, (void *)p->fh.f_handle, &dwords, 0);
+	buflen = (dwords << 2);
+
+	err = -EIO;
+	if (WARN_ON(fh_type < 0) ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
+	    WARN_ON(fh_type == FILEID_INVALID))
+		goto out_err;
+
+	p->fh.handle_type = fh_type;
+	p->fh.handle_bytes = buflen;
+
+	/*
+	 * Ideally, we want to have mnt_id+fhandle, but overlayfs not
+	 * keep refcnts on layers mounts and we couldn't determine
+	 * mnt_ids for layers. So, let's give s_dev to CRIU.
+	 * It's better than nothing.
+	 */
+	p->s_dev = dentry->d_sb->s_dev;
+
+	return 0;
+
+out_err:
+	return err;
+}
+
+static int ovl_fsinfo_store_source(struct fsinfo_ovl_source *p,
+				   enum fsinfo_ovl_source_type type,
+				   struct dentry *dentry)
+{
+	__ovl_encode_mnt_opt_fh(p, dentry);
+	p->type = type;
+	return 0;
+}
+
+static long ovl_ioctl_stor_lower_fhandle(struct fsinfo_ovl_source *p,
+					 struct super_block *sb,
+					 unsigned long arg)
+{
+	struct ovl_entry *oe = sb->s_root->d_fsdata;
+	struct dentry *origin;
+
+	if (arg >= oe->numlower)
+		return -EINVAL;
+
+	origin = oe->lowerstack[arg].dentry;
+
+	return ovl_fsinfo_store_source(p, FSINFO_OVL_LWR, origin);
+}
+
+static long ovl_ioctl_stor_upper_fhandle(struct fsinfo_ovl_source *p,
+					 struct super_block *sb)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct dentry *origin;
+
+	if (!ofs->config.upperdir)
+		return -EINVAL;
+
+	origin = OVL_I(d_inode(sb->s_root))->__upperdentry;
+
+	return ovl_fsinfo_store_source(p, FSINFO_OVL_UPPR, origin);
+}
+
+static long ovl_ioctl_stor_work_fhandle(struct fsinfo_ovl_source *p,
+					struct super_block *sb)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+
+	if (!ofs->config.upperdir)
+		return -EINVAL;
+
+	return ovl_fsinfo_store_source(p, FSINFO_OVL_WRK, ofs->workbasedir);
+}
+
+static int ovl_fsinfo_sources(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_ovl_source *p = ctx->buffer;
+	struct super_block *sb = path->dentry->d_sb;
+	struct ovl_fs *ofs = sb->s_fs_info;
+	struct ovl_entry *oe = sb->s_root->d_fsdata;
+	size_t nr_sources = (oe->numlower + 2 * !!ofs->config.upperdir);
+	unsigned int i = 0, j;
+	int ret = -ENODATA;
+
+	ret = nr_sources * sizeof(*p);
+	if (ret <= ctx->buf_size) {
+		if (ofs->config.upperdir) {
+			ovl_ioctl_stor_upper_fhandle(&p[i++], sb);
+			ovl_ioctl_stor_work_fhandle(&p[i++], sb);
+		}
+
+		for (j = 0; j < oe->numlower; j++)
+			ovl_ioctl_stor_lower_fhandle(&p[i++], sb, j);
+	}
+
+	return ret;
+}
+
+static const struct fsinfo_attribute ovl_fsinfo_attributes[] = {
+	/* TODO: implement FSINFO_ATTR_SUPPORTS and FSINFO_ATTR_FEATURES */
+	/*
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		ovl_fsinfo_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		ovl_fsinfo_features),
+	*/
+	FSINFO_LIST	(FSINFO_ATTR_OVL_SOURCES,	ovl_fsinfo_sources),
+	{}
+};
+
+int ovl_fsinfo(struct path *path, struct fsinfo_context *ctx)
+{
+	return fsinfo_get_attribute(path, ctx, ovl_fsinfo_attributes);
+}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 29bc1ec699e7..1c0ac23ecf8f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/uuid.h>
 #include <linux/fs.h>
+#include <linux/xattr.h>
 #include "ovl_entry.h"
 
 #undef pr_fmt
@@ -492,3 +493,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 
 /* export.c */
 extern const struct export_operations ovl_export_operations;
+
+/* fsinfo.c */
+#ifdef CONFIG_FSINFO
+extern int ovl_fsinfo(struct path *path, struct fsinfo_context *ctx);
+#endif
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 4b38141c2985..1a4cdbbd766f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -392,6 +392,9 @@ static const struct super_operations ovl_super_operations = {
 	.put_super	= ovl_put_super,
 	.sync_fs	= ovl_sync_fs,
 	.statfs		= ovl_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= ovl_fsinfo,
+#endif
 	.show_options	= ovl_show_options,
 	.remount_fs	= ovl_remount,
 };
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index dcd764771a7d..83c2511691e4 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -10,6 +10,8 @@
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/openat2.h>
+#include <linux/fs.h>
+#include <linux/exportfs.h>
 
 /*
  * The filesystem attributes that can be requested.  Note that some attributes
@@ -44,6 +46,8 @@
 #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
 #define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of the Nth server */
 
+#define FSINFO_ATTR_OVL_SOURCES		0x400	/* List of overlayfs source dirs fhandles+sdev */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -341,4 +345,31 @@ struct fsinfo_error_state {
 
 #define FSINFO_ATTR_ERROR_STATE__STRUCT struct fsinfo_error_state
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO).
+ *
+ * This gives information about the overlayfs upperdir, workdir, lowerdir
+ * superblock options (exported as fhandles).
+ */
+enum fsinfo_ovl_source_type {
+	FSINFO_OVL_UPPR	= 0,	/* upperdir */
+	FSINFO_OVL_WRK	= 1,	/* workdir */
+	FSINFO_OVL_LWR	= 2,	/* lowerdir list item */
+};
+
+/* DISCUSS: we can also export mnt_unique_id here which introduced by fsinfo patchset
+ * and then use him to detect if source was unmounted in the time gap between the moment when
+ * overlayfs was mounted and C/R process was started.
+ * We can get mnt_unique_id also by using fsinfo(FSINFO_ATTR_MOUNT_ALL)
+ */
+struct fsinfo_ovl_source {
+	enum fsinfo_ovl_source_type type;
+	__u32 s_dev;
+	struct file_handle fh;
+	/* use f_handle field from struct file_handle */
+	__u8 __fhdata[MAX_HANDLE_SZ];
+};
+
+#define FSINFO_ATTR_OVL_SOURCES__STRUCT struct fsinfo_ovl_source
+
 #endif /* _UAPI_LINUX_FSINFO_H */
-- 
2.25.1

