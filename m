Return-Path: <linux-fsdevel+bounces-18129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933E8B5F98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145471F23E49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24786ADB;
	Mon, 29 Apr 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz7JzbAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C0386636;
	Mon, 29 Apr 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410323; cv=none; b=dwuS81OXl3M749tkfWrhVP+keLZ7WsMu7Dw2F0UWMLOKlP4FU2zW3d/ENdu4MHBCUEYHG1C1ILG2kKdfsms6FsDh9CwkpBYX5tNioR+wQ6zCCQc1V3U8dngGjTfk7rXnhl4ghVXKP7MjSWwFSSSIduaG3In2kzvxpZs3pPbuqcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410323; c=relaxed/simple;
	bh=jsPGyOwkC8X4WUgX0lbpTX6dCPCsii/eyuR6Mz+GpWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbslYsVUPoHgt/5ntLVeVSXogAjE+jydMZExPte9/cjc7ji3B7UUazUJdR4QNSImNBUBtSQBeN/lJkhn4Naa9p2tTuVGrlO6n9L4mlnaZXMU5IzNnOXCHoH+GXFUkKXpRC1ynFJJgBdNzamFedveLI/TPiSfzpH+rBQoNCSl448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz7JzbAI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ee575da779so205353a34.2;
        Mon, 29 Apr 2024 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410319; x=1715015119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MilasPvhzvPiGTInd59RFs02ReQyQfw/VRapBOjtlfM=;
        b=Sz7JzbAIfY9KstG7hfiL18NohUUTDpzyovs7i8Ek2Q4TtwH+XExZit0cRSzp+Mc/JQ
         8+Xn9ZOJMoVXc6mCpwI5L9BrhJ9r79qo8ZOBLmFGxQO372qWxV275HKY5QADHHyE0/H5
         7CHBEHQrGh2KVPBUkaycTQHn1tICECXLQIzXoHjDqQFrx3ttmFI1QKgzbV/MwvbjHxPs
         i8EBtfq4isQiM6EreVDhg7iT1vI3HWBrWcO7NhhekJXV/Q4q/DcBMYtOz8VlDn1/oFIu
         Dai+nEAvyZf4QMdkJS1QJwqZWgwDqZ1QpGmf85R0wWZM6kDMuwnA7j0J0V7CtEejwr89
         ncjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410319; x=1715015119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MilasPvhzvPiGTInd59RFs02ReQyQfw/VRapBOjtlfM=;
        b=aTI7/1dDDh0lQqtolOAoCNYrTbOHgGdqxRcQIkY+8U99FzOSSjAE+ozg3n3mVtRUPr
         Whf8uY32ZFTC+Tl82xhqslxv2SZXk6zIaRt2MpNN7cMMADAfTcc8kK0TOI++mHYj8CEe
         0fNqcV8/w6b+dusMWbZzVPOtSDAG3Js3GH3F/JZhy7zF+OihDDD58dOtFSNmMZ48Yb2+
         C1lCeSg767rPQNkqppB0yj+oICvZdweYjIjJTamtWeXHHQ4RuoMzd3Yn8yA1eupK/gNs
         pNw35fxb7m+RcPyW33cOjLmVE7+CkoqURnwTifxzid6XFII67AZ59+i/bR4pfPjknPUQ
         +lDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5HLhEro1TTDo585K/8W2jFn2LIu4le1/7EXt3TTn5RChufxhWDIFTgkuWsP65K7i3Uq1/q95JYsMt1RuZ49kE2VSv2vL4X5ycs4OPem51vW1C5hhXDmOC+Sf0m0tSotJnGRsr88V1Kg==
X-Gm-Message-State: AOJu0YxKizLkIFTKpyxLv/z1/qV3nIuddUNCC6IKBhV0w8Yyl3TtDGko
	9+DIKdLzQbzZRscXqzTUgVZoX0F9+0HRAI63NTpiKSmaV5vySJF2
X-Google-Smtp-Source: AGHT+IGvLXcUVeIkg6vV7OMCWw5YqAe1KWWabhYTgi9tEZ/mgodSlwYBR1JbErJxPxFlPTBLShZEXQ==
X-Received: by 2002:a05:6830:16d5:b0:6ee:2a3a:566 with SMTP id l21-20020a05683016d500b006ee2a3a0566mr4642555otr.14.1714410318984;
        Mon, 29 Apr 2024 10:05:18 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.05.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:18 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 08/12] famfs: module operations & fs_context
Date: Mon, 29 Apr 2024 12:04:24 -0500
Message-Id: <86694a1a663ab0b6e8e35c7b187f5ad179103482.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1714409084.git.john@groves.net>
References: <cover.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Start building up from the famfs module operations. This commit
includes the following:

* Register as a file system
* Parse mount parameters
* Allocate or find (and initialize) a superblock via famfs_get_tree()
* Lookup the host dax device, and bail if it's in use (or not dax)
* Register as the holder of the dax device if it's available
* Add Kconfig and Makefile misc to build famfs
* Add FAMFS_SUPER_MAGIC to include/uapi/linux/magic.h
* Add export of fs/namei.c:may_open_dev(), which famfs needs to call
* Update MAINTAINERS file for the fs/famfs/ path

The following exports had to happen to enable famfs:

* This uses the new fs/super.c:kill_char_super() - the other kill*super
  helpers were not quite right.
* This uses the dev_dax_iomap export of dax_dev_get()

This commit builds but is otherwise too incomplete to run

Signed-off-by: John Groves <john@groves.net>
---
 MAINTAINERS                |   1 +
 fs/Kconfig                 |   2 +
 fs/Makefile                |   1 +
 fs/famfs/Kconfig           |  10 ++
 fs/famfs/Makefile          |   5 +
 fs/famfs/famfs_inode.c     | 345 +++++++++++++++++++++++++++++++++++++
 fs/famfs/famfs_internal.h  |  36 ++++
 fs/namei.c                 |   1 +
 include/uapi/linux/magic.h |   1 +
 9 files changed, 402 insertions(+)
 create mode 100644 fs/famfs/Kconfig
 create mode 100644 fs/famfs/Makefile
 create mode 100644 fs/famfs/famfs_inode.c
 create mode 100644 fs/famfs/famfs_internal.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f2d847dcf01..365d678e2f40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8188,6 +8188,7 @@ L:	linux-cxl@vger.kernel.org
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/famfs.rst
+F:	fs/famfs
 
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..53b4629e92a0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -140,6 +140,8 @@ source "fs/autofs/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
 
+source "fs/famfs/Kconfig"
+
 menu "Caches"
 
 source "fs/netfs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..3393f399a9e9 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_FAMFS)             += famfs/
diff --git a/fs/famfs/Kconfig b/fs/famfs/Kconfig
new file mode 100644
index 000000000000..edb8980820f7
--- /dev/null
+++ b/fs/famfs/Kconfig
@@ -0,0 +1,10 @@
+
+
+config FAMFS
+       tristate "famfs: shared memory file system"
+       depends on DEV_DAX && FS_DAX && DEV_DAX_IOMAP
+       help
+	  Support for the famfs file system. Famfs is a dax file system that
+	  can support scale-out shared access to fabric-attached memory
+	  (e.g. CXL shared memory). Famfs is not a general purpose file system;
+	  it is an enabler for data sets in shared memory.
diff --git a/fs/famfs/Makefile b/fs/famfs/Makefile
new file mode 100644
index 000000000000..62230bcd6793
--- /dev/null
+++ b/fs/famfs/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FAMFS) += famfs.o
+
+famfs-y := famfs_inode.o
diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
new file mode 100644
index 000000000000..61306240fc0b
--- /dev/null
+++ b/fs/famfs/famfs_inode.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2024 Micron Technology, inc
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+
+#include <linux/fs.h>
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/parser.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/dax.h>
+#include <linux/hugetlb.h>
+#include <linux/iomap.h>
+#include <linux/path.h>
+#include <linux/namei.h>
+
+#include "famfs_internal.h"
+
+#define FAMFS_DEFAULT_MODE	0755
+
+static struct inode *famfs_get_inode(struct super_block *sb,
+				     const struct inode *dir,
+				     umode_t mode, dev_t dev)
+{
+	struct inode *inode = new_inode(sb);
+	struct timespec64 tv;
+
+	if (!inode)
+		return NULL;
+
+	inode->i_ino = get_next_ino();
+	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+	inode->i_mapping->a_ops = &ram_aops;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_unevictable(inode->i_mapping);
+	tv = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, tv);
+	inode_set_atime_to_ts(inode, tv);
+
+	switch (mode & S_IFMT) {
+	default:
+		init_special_inode(inode, mode, dev);
+		break;
+	case S_IFREG:
+		inode->i_op = NULL /* famfs_file_inode_operations */;
+		inode->i_fop = NULL /* &famfs_file_operations */;
+		break;
+	case S_IFDIR:
+		inode->i_op = NULL /* famfs_dir_inode_operations */;
+		inode->i_fop = &simple_dir_operations;
+
+		/* Directory inodes start off with i_nlink == 2 (for ".") */
+		inc_nlink(inode);
+		break;
+	case S_IFLNK:
+		inode->i_op = &page_symlink_inode_operations;
+		inode_nohighmem(inode);
+		break;
+	}
+	return inode;
+}
+
+/*
+ * famfs dax_operations  (for char dax)
+ */
+static int
+famfs_dax_notify_failure(struct dax_device *dax_dev, u64 offset,
+			u64 len, int mf_flags)
+{
+	struct super_block *sb = dax_holder(dax_dev);
+	struct famfs_fs_info *fsi = sb->s_fs_info;
+
+	pr_err("%s: rootdev=%s offset=%lld len=%llu flags=%x\n", __func__,
+	       fsi->rootdev, offset, len, mf_flags);
+
+	return 0;
+}
+
+static const struct dax_holder_operations famfs_dax_holder_ops = {
+	.notify_failure		= famfs_dax_notify_failure,
+};
+
+/*****************************************************************************
+ * fs_context_operations
+ */
+
+static int
+famfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	int rc = 0;
+
+	sb->s_maxbytes		= MAX_LFS_FILESIZE;
+	sb->s_blocksize		= PAGE_SIZE;
+	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_magic		= FAMFS_SUPER_MAGIC;
+	sb->s_op		= NULL /* famfs_super_ops */;
+	sb->s_time_gran		= 1;
+
+	return rc;
+}
+
+static int
+lookup_daxdev(const char *pathname, dev_t *devno)
+{
+	struct inode *inode;
+	struct path path;
+	int err;
+
+	if (!pathname || !*pathname)
+		return -EINVAL;
+
+	err = kern_path(pathname, LOOKUP_FOLLOW, &path);
+	if (err)
+		return err;
+
+	inode = d_backing_inode(path.dentry);
+	if (!S_ISCHR(inode->i_mode)) {
+		err = -EINVAL;
+		goto out_path_put;
+	}
+
+	if (!may_open_dev(&path)) { /* had to export this */
+		err = -EACCES;
+		goto out_path_put;
+	}
+
+	 /* if it's dax, i_rdev is struct dax_device */
+	*devno = inode->i_rdev;
+
+out_path_put:
+	path_put(&path);
+	return err;
+}
+
+static int
+famfs_get_tree(struct fs_context *fc)
+{
+	struct famfs_fs_info *fsi = fc->s_fs_info;
+	struct dax_device *dax_devp;
+	struct super_block *sb;
+	struct inode *inode;
+	dev_t daxdevno;
+	int err;
+
+	/* TODO: clean up chatty messages */
+
+	err = lookup_daxdev(fc->source, &daxdevno);
+	if (err)
+		return err;
+
+	fsi->daxdevno = daxdevno;
+
+	/* This will set sb->s_dev=daxdevno */
+	sb = sget_dev(fc, daxdevno);
+	if (IS_ERR(sb)) {
+		pr_err("%s: sget_dev error\n", __func__);
+		return PTR_ERR(sb);
+	}
+
+	if (sb->s_root) {
+		pr_info("%s: found a matching suerblock for %s\n",
+			__func__, fc->source);
+
+		/* We don't expect to find a match by dev_t; if we do, it must
+		 * already be mounted, so we bail
+		 */
+		err = -EBUSY;
+		goto deactivate_out;
+	} else {
+		pr_info("%s: initializing new superblock for %s\n",
+			__func__, fc->source);
+		err = famfs_fill_super(sb, fc);
+		if (err)
+			goto deactivate_out;
+	}
+
+	/* This will fail if it's not a dax device */
+	dax_devp = dax_dev_get(daxdevno);
+	if (!dax_devp) {
+		pr_warn("%s: device %s not found or not dax\n",
+		       __func__, fc->source);
+		err = -ENODEV;
+		goto deactivate_out;
+	}
+
+	err = fs_dax_get(dax_devp, sb, &famfs_dax_holder_ops);
+	if (err) {
+		pr_err("%s: fs_dax_get(%lld) failed\n", __func__, (u64)daxdevno);
+		err = -EBUSY;
+		goto deactivate_out;
+	}
+	fsi->dax_devp = dax_devp;
+
+	inode = famfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root) {
+		pr_err("%s: d_make_root() failed\n", __func__);
+		err = -ENOMEM;
+		fs_put_dax(fsi->dax_devp, sb);
+		goto deactivate_out;
+	}
+
+	sb->s_flags |= SB_ACTIVE;
+
+	WARN_ON(fc->root);
+	fc->root = dget(sb->s_root);
+	return err;
+
+deactivate_out:
+	pr_debug("%s: deactivating sb=%llx\n", __func__, (u64)sb);
+	deactivate_locked_super(sb);
+	return err;
+}
+
+/*****************************************************************************/
+
+enum famfs_param {
+	Opt_mode,
+	Opt_dax,
+};
+
+const struct fs_parameter_spec famfs_fs_parameters[] = {
+	fsparam_u32oct("mode",	  Opt_mode),
+	fsparam_string("dax",     Opt_dax),
+	{}
+};
+
+static int famfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct famfs_fs_info *fsi = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, famfs_fs_parameters, param, &result);
+	if (opt == -ENOPARAM) {
+		opt = vfs_parse_fs_param_source(fc, param);
+		if (opt != -ENOPARAM)
+			return opt;
+
+		return 0;
+	}
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_mode:
+		fsi->mount_opts.mode = result.uint_32 & S_IALLUGO;
+		break;
+	case Opt_dax:
+		if (strcmp(param->string, "always"))
+			pr_notice("%s: invalid dax mode %s\n",
+				  __func__, param->string);
+		break;
+	}
+
+	return 0;
+}
+
+static void famfs_free_fc(struct fs_context *fc)
+{
+	struct famfs_fs_info *fsi = fc->s_fs_info;
+
+	if (fsi && fsi->rootdev)
+		kfree(fsi->rootdev);
+
+	kfree(fsi);
+}
+
+static const struct fs_context_operations famfs_context_ops = {
+	.free		= famfs_free_fc,
+	.parse_param	= famfs_parse_param,
+	.get_tree	= famfs_get_tree,
+};
+
+static int famfs_init_fs_context(struct fs_context *fc)
+{
+	struct famfs_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	fsi->mount_opts.mode = FAMFS_DEFAULT_MODE;
+	fc->s_fs_info        = fsi;
+	fc->ops              = &famfs_context_ops;
+	return 0;
+}
+
+static void famfs_kill_sb(struct super_block *sb)
+{
+	struct famfs_fs_info *fsi = sb->s_fs_info;
+
+	if (fsi->dax_devp)
+		fs_put_dax(fsi->dax_devp, sb);
+	if (fsi && fsi->rootdev)
+		kfree(fsi->rootdev);
+	kfree(fsi);
+	sb->s_fs_info = NULL;
+
+	kill_char_super(sb); /* new */
+}
+
+#define MODULE_NAME "famfs"
+static struct file_system_type famfs_fs_type = {
+	.name		  = MODULE_NAME,
+	.init_fs_context  = famfs_init_fs_context,
+	.parameters	  = famfs_fs_parameters,
+	.kill_sb	  = famfs_kill_sb,
+	.fs_flags	  = FS_USERNS_MOUNT,
+};
+
+/******************************************************************************
+ * Module stuff
+ */
+static int __init init_famfs_fs(void)
+{
+	int rc;
+
+	rc = register_filesystem(&famfs_fs_type);
+
+	return rc;
+}
+
+static void
+__exit famfs_exit(void)
+{
+	unregister_filesystem(&famfs_fs_type);
+	pr_info("%s: unregistered\n", __func__);
+}
+
+fs_initcall(init_famfs_fs);
+module_exit(famfs_exit);
+
+MODULE_AUTHOR("John Groves, Micron Technology");
+MODULE_LICENSE("GPL");
diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
new file mode 100644
index 000000000000..951b32ec4fbd
--- /dev/null
+++ b/fs/famfs/famfs_internal.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2024 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+#ifndef FAMFS_INTERNAL_H
+#define FAMFS_INTERNAL_H
+
+struct famfs_mount_opts {
+	umode_t mode;
+};
+
+/**
+ * @famfs_fs_info
+ *
+ * @mount_opts: the mount options
+ * @dax_devp:   The underlying character devdax device
+ * @rootdev:    Dax device path used in mount
+ * @daxdevno:   Dax device dev_t
+ * @deverror:   True if the dax device has called our notify_failure entry
+ *              point, or if other "shutdown" conditions exist
+ */
+struct famfs_fs_info {
+	struct famfs_mount_opts  mount_opts;
+	struct dax_device       *dax_devp;
+	char                    *rootdev;
+	dev_t                    daxdevno;
+	bool                     deverror;
+};
+
+#endif /* FAMFS_INTERNAL_H */
diff --git a/fs/namei.c b/fs/namei.c
index c5b2a25be7d0..f24b268473cd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3229,6 +3229,7 @@ bool may_open_dev(const struct path *path)
 	return !(path->mnt->mnt_flags & MNT_NODEV) &&
 		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
 }
+EXPORT_SYMBOL(may_open_dev);
 
 static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		    int acc_mode, int flag)
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 1b40a968ba91..e9bdd6a415e2 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -37,6 +37,7 @@
 #define HOSTFS_SUPER_MAGIC	0x00c0ffee
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
+#define FAMFS_SUPER_MAGIC	0x87b282ff
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.43.0


