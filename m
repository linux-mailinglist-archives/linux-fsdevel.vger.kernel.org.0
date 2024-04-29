Return-Path: <linux-fsdevel+bounces-18133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 039758B5FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCD0B2377A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC06126F2F;
	Mon, 29 Apr 2024 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDVzS2ar"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AA127E28;
	Mon, 29 Apr 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410343; cv=none; b=DsrLvxOnRDKxot1nxo0npkSKm/68YQClG0e1S8ggy0pg4QmjAOoqGPNK02KDaYwggU/1pU6hmeohPBSR9v+9bhfschQSh6VPOjJu1mv/ZFz7R2Ummr6xJK2sSLnU4wk5ZFrbFhhcXrH8xpiSXFoKVzmYDFjg0Z6wOrYcHbFR0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410343; c=relaxed/simple;
	bh=uraQR7x/sGs8bT6f+ne9e8Dyo7H0N2VLJU5n4krNVvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QxEVcAUwh9kob5BKXG3rVIccvU+EINupez5LyBs07YklLvl2qu6eNc5qPl1anTtUqsjqY6IZA0m4dMC9XjPe8Jqr+Cb6wEvJDVid9wQqkklse9pK8QA+xSOewotXzkVeSHsBWdj8dRueV5ZVb30Xy39qqTmxJM+2hu/UNR0fFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDVzS2ar; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ee2d64423cso897411a34.2;
        Mon, 29 Apr 2024 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410336; x=1715015136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XGfzHhfU9BjKWtreEiEkkMsTodSRwxrpWg7XVozVVs=;
        b=RDVzS2arTu/qw1xVZ8ug+4dXKoh05AWdEltOpcxtJzXAOMptOAV131uhHYJvqIaa5o
         Ov4YttYLRG5PptkbKlL4WUZ6r+sWeIIWSWS5Z1irxmTMDyY20QN3IE3CdJcZvDkkCbvv
         xROiXk3eSZ7eo6g8KaCdqxXDSoYTRrudFv0gV/XAx3YN6vjeZEBFYmwpl9p8zjweJGFI
         KG31QFkZPk44yjR4Sk2VFqN28LbjChhbIVoIqGTf1gUkCFwgpQ6+Qd2+o1A/EOvzhrJo
         vGPXAujgR+WqxprdaKw+ix6QWIjXI3ThY0jwMcVxFMkxsbPBA1ZBEfBmgZ3w0nlRTgEL
         Eqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410336; x=1715015136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XGfzHhfU9BjKWtreEiEkkMsTodSRwxrpWg7XVozVVs=;
        b=PhlVlxUnv3GG4nCs5qBkuVM7K8oVWxkOpQN25xenNqbzqnoI4dqj4y1t1kTtHDA4eK
         hqVhuN4Ybopd0Vlhd5Z3atWUpAMZ/cAmlGkjIW71gppierNh6kPiU8gV3IwNSIhnvqpR
         LY6B+563mg0MWqpt3PADPEAf2c+X+abIa9DOGXJLwrbxjfd3QNr/byoWFg7McaUOGMKI
         Ocuv5dsdPtLwrj4XjgdvlNIMsLe5xQ7hZ4nlffTUqQH9fa4J5oT9T76lJGGSEFHmYdXk
         MJ+v1sKx8Wp+3FyfqIM2XRbXMmXV9wLNelbo7kcgNUStr+n7GEwh1iALVbF4eAlWTxNs
         NMkw==
X-Forwarded-Encrypted: i=1; AJvYcCX1W0SrWGOZGykH/zaKOu+z7jKpNqv2YTpKT/DHk95Pf4MRMfjs+bzl2TgJaavkvM2ooIIhdnk8tnp5jIaMGBPpQCryz6jCzUvL9ZLIFgI3GRWbYqtUrP7kB6HhZm78ycGwKECHmvWHHw==
X-Gm-Message-State: AOJu0YwMgEyVClaqu9JcmyHJBcpkYHo4TQXLxQQ1nJ3CYj2ZbeMDemPl
	9Ra5JWHPUrPS/lSVzjFnlTWdfLFFbzOb7DhOJCK1mSsa0R8WsEmV
X-Google-Smtp-Source: AGHT+IFa4ttTfbKQGFpDgkeFkiAf/nTCdj5A92xX4+XR8LBf8Q0ctWa5/uMWEr1Ye2nwSdUIywl4GQ==
X-Received: by 2002:a9d:6a11:0:b0:6ee:2798:4b95 with SMTP id g17-20020a9d6a11000000b006ee27984b95mr4654535otn.10.1714410335740;
        Mon, 29 Apr 2024 10:05:35 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.05.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 12/12] famfs: famfs_ioctl and core file-to-memory mapping logic & iomap_ops
Date: Mon, 29 Apr 2024 12:04:28 -0500
Message-Id: <5824030d31a853ff591b3e1fb4f206b2fd4d1f9f.1714409084.git.john@groves.net>
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

* Add uapi include file famfs_ioctl.h. The famfs user space uses ioctl on
  individual files to pass in mapping information and file size. This
  would be hard to do via sysfs or other means, since it's file-specific.
* Add the per-file ioctl function famfs_file_ioctl() into
  struct file_operations, and introduces the famfs_file_init_dax()
  function (which is called by famfs_file_ioct())
* Add the famfs iomap_ops. When either dax_iomap_fault() or dax_iomap_rw()
  is called, we get a callback via our iomap_begin() handler. The question
  being asked is "please resolve (file, offset) to (daxdev, offset)". The
  function famfs_meta_to_dax_offset() does this.
* Expose the famfs ABI version as
  /sys/module/famfs/parameters/famfs_kabi_version

The current ioctls are:

FAMFS_IOC_MAP_CREATE - famfs_file_init_dax() associates a dax extent
                       list with a file, making it into a proper famfs
                       file.Starting with an empty file (which is not
                       useful), This turns the file into a DAX file backed
                       by the specified extent list from devdax memory.
FAMFSIOC_NOP         - A convenient way for user space to verify it's a
                       famfs file
FAMFSIOC_MAP_GET     - Get the header of the metadata for a file
FAMFSIOC_MAP_GETEXT  - Get the extents for a file

The last two, together, are comparable to xfs_bmap. Our user space tools
use them primarly in testing.

Signed-off-by: John Groves <john@groves.net>
---
 MAINTAINERS                      |   1 +
 fs/famfs/famfs_file.c            | 391 ++++++++++++++++++++++++++++++-
 fs/famfs/famfs_internal.h        |  14 ++
 include/uapi/linux/famfs_ioctl.h |  61 +++++
 4 files changed, 461 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/linux/famfs_ioctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 365d678e2f40..29d81be488bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8189,6 +8189,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Supported
 F:	Documentation/filesystems/famfs.rst
 F:	fs/famfs
+F:	include/uapi/linux/famfs_ioctl.h
 
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
index 585b776dd73c..ac34e606ca1b 100644
--- a/fs/famfs/famfs_file.c
+++ b/fs/famfs/famfs_file.c
@@ -14,8 +14,371 @@
 #include <linux/dax.h>
 #include <linux/iomap.h>
 
+#include <linux/famfs_ioctl.h>
 #include "famfs_internal.h"
 
+/* Expose famfs kernel abi version as a read-only module parameter */
+static int famfs_kabi_version = FAMFS_KABI_VERSION;
+module_param(famfs_kabi_version, int, 0444);
+MODULE_PARM_DESC(famfs_kabi_version, "famfs kernel abi version");
+
+/**
+ * famfs_meta_alloc() - Allocate famfs file metadata
+ * @metap:       Pointer to an mcache_map_meta pointer
+ * @ext_count:  The number of extents needed
+ */
+static int
+famfs_meta_alloc(struct famfs_file_meta **metap, size_t ext_count)
+{
+	struct famfs_file_meta *meta;
+
+	meta = kzalloc(struct_size(meta, tfs_extents, ext_count), GFP_KERNEL);
+	if (!meta)
+		return -ENOMEM;
+
+	meta->tfs_extent_ct = ext_count;
+	meta->error = false;
+	*metap = meta;
+
+	return 0;
+}
+
+static void
+famfs_meta_free(struct famfs_file_meta *map)
+{
+	kfree(map);
+}
+
+/**
+ * famfs_file_init_dax() - FAMFSIOC_MAP_CREATE ioctl handler
+ * @file: the un-initialized file
+ * @arg:  ptr to struct mcioc_map in user space
+ *
+ * Setup the dax mapping for a file. Files are created empty, and then function
+ * is called by famfs_file_ioctl() to setup the mapping and set the file size.
+ */
+static int
+famfs_file_init_dax(struct file *file, void __user *arg)
+{
+	struct famfs_file_meta *meta = NULL;
+	struct famfs_ioc_map imap;
+	struct famfs_fs_info *fsi;
+	size_t extent_total = 0;
+	int alignment_errs = 0;
+	struct super_block *sb;
+	struct inode *inode;
+	size_t ext_count;
+	int rc;
+	int i;
+
+	inode = file_inode(file);
+	if (!inode) {
+		rc = -EBADF;
+		goto errout;
+	}
+
+	sb  = inode->i_sb;
+	fsi = sb->s_fs_info;
+	if (fsi->deverror)
+		return -ENODEV;
+
+	rc = copy_from_user(&imap, arg, sizeof(imap));
+	if (rc)
+		return -EFAULT;
+
+	ext_count = imap.ext_list_count;
+	if (ext_count < 1) {
+		rc = -ENOSPC;
+		goto errout;
+	}
+
+	if (ext_count > FAMFS_MAX_EXTENTS) {
+		rc = -E2BIG;
+		goto errout;
+	}
+
+	rc = famfs_meta_alloc(&meta, ext_count);
+	if (rc)
+		goto errout;
+
+	meta->file_type = imap.file_type;
+	meta->file_size = imap.file_size;
+
+	/* Fill in the internal file metadata structure */
+	for (i = 0; i < imap.ext_list_count; i++) {
+		size_t len;
+		off_t  offset;
+
+		offset = imap.ext_list[i].offset;
+		len    = imap.ext_list[i].len;
+
+		extent_total += len;
+
+		if (WARN_ON(offset == 0 && meta->file_type != FAMFS_SUPERBLOCK)) {
+			rc = -EINVAL;
+			goto errout;
+		}
+
+		meta->tfs_extents[i].offset = offset;
+		meta->tfs_extents[i].len    = len;
+
+		/* All extent addresses/offsets must be 2MiB aligned,
+		 * and all but the last length must be a 2MiB multiple.
+		 */
+		if (!IS_ALIGNED(offset, PMD_SIZE)) {
+			pr_err("%s: error ext %d hpa %lx not aligned\n",
+			       __func__, i, offset);
+			alignment_errs++;
+		}
+		if (i < (imap.ext_list_count - 1) && !IS_ALIGNED(len, PMD_SIZE)) {
+			pr_err("%s: error ext %d length %ld not aligned\n",
+			       __func__, i, len);
+			alignment_errs++;
+		}
+	}
+
+	/*
+	 * File size can be <= ext list size, since extent sizes are constrained
+	 * to PMD multiples
+	 */
+	if (imap.file_size > extent_total) {
+		pr_err("%s: file size %lld larger than ext list size %lld\n",
+		       __func__, (u64)imap.file_size, (u64)extent_total);
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	if (alignment_errs > 0) {
+		pr_err("%s: there were %d alignment errors in the extent list\n",
+		       __func__, alignment_errs);
+		rc = -EINVAL;
+		goto errout;
+	}
+
+	/* Publish the famfs metadata on inode->i_private */
+	inode_lock(inode);
+	if (inode->i_private) {
+		rc = -EEXIST; /* file already has famfs metadata */
+	} else {
+		inode->i_private = meta;
+		i_size_write(inode, imap.file_size);
+		inode->i_flags |= S_DAX;
+	}
+	inode_unlock(inode);
+
+ errout:
+	if (rc)
+		famfs_meta_free(meta);
+
+	return rc;
+}
+
+/**
+ * famfs_file_ioctl() - Top-level famfs file ioctl handler
+ * @file: the file
+ * @cmd:  ioctl opcode
+ * @arg:  ioctl opcode argument (if any)
+ */
+static long
+famfs_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	struct famfs_fs_info *fsi = inode->i_sb->s_fs_info;
+	long rc;
+
+	if (fsi->deverror && (cmd != FAMFSIOC_NOP))
+		return -ENODEV;
+
+	switch (cmd) {
+	case FAMFSIOC_NOP:
+		rc = 0;
+		break;
+
+	case FAMFSIOC_MAP_CREATE:
+		rc = famfs_file_init_dax(file, (void *)arg);
+		break;
+
+	case FAMFSIOC_MAP_GET: {
+		struct inode *inode = file_inode(file);
+		struct famfs_file_meta *meta = inode->i_private;
+		struct famfs_ioc_map umeta;
+
+		memset(&umeta, 0, sizeof(umeta));
+
+		if (meta) {
+			/* TODO: do more to harmonize these structures */
+			umeta.extent_type    = meta->tfs_extent_type;
+			umeta.file_size      = i_size_read(inode);
+			umeta.ext_list_count = meta->tfs_extent_ct;
+
+			rc = copy_to_user((void __user *)arg, &umeta,
+					  sizeof(umeta));
+			if (rc)
+				pr_err("%s: copy_to_user returned %ld\n",
+				       __func__, rc);
+
+		} else {
+			rc = -EINVAL;
+		}
+		break;
+	}
+	case FAMFSIOC_MAP_GETEXT: {
+		struct inode *inode = file_inode(file);
+		struct famfs_file_meta *meta = inode->i_private;
+
+		if (meta)
+			rc = copy_to_user((void __user *)arg, meta->tfs_extents,
+			      meta->tfs_extent_ct * sizeof(struct famfs_extent));
+		else
+			rc = -EINVAL;
+		break;
+	}
+	default:
+		rc = -ENOTTY;
+		break;
+	}
+
+	return rc;
+}
+
+/*********************************************************************
+ * iomap_operations
+ *
+ * This stuff uses the iomap (dax-related) helpers to resolve file offsets to
+ * offsets within a dax device.
+ */
+
+static ssize_t famfs_file_invalid(struct inode *inode);
+
+/**
+ * famfs_meta_to_dax_offset() - Resolve (file, offset, len) to (daxdev, offset, len)
+ *
+ * This function is called by famfs_iomap_begin() to resolve an offset in a
+ * file to an offset in a dax device. This is upcalled from dax from calls to
+ * both  * dax_iomap_fault() and dax_iomap_rw(). Dax finishes the job resolving
+ * a fault to a specific physical page (the fault case) or doing a memcpy
+ * variant (the rw case)
+ *
+ * Pages can be PTE (4k), PMD (2MiB) or (theoretically) PuD (1GiB)
+ * (these sizes are for X86; may vary on other cpu architectures
+ *
+ * @inode:  The file where the fault occurred
+ * @iomap:       To be filled in to indicate where to find the right memory,
+ *               relative  to a dax device.
+ * @file_offset: Within the file where the fault occurred (will be page boundary)
+ * @len:         The length of the faulted mapping (will be a page multiple)
+ *               (will be trimmed in *iomap if it's disjoint in the extent list)
+ * @flags:
+ *
+ * Return values: 0. (info is returned in a modified @iomap struct)
+ */
+static int
+famfs_meta_to_dax_offset(struct inode *inode, struct iomap *iomap,
+			 loff_t file_offset, off_t len, unsigned int flags)
+{
+	struct famfs_file_meta *meta = inode->i_private;
+	int i;
+	loff_t local_offset = file_offset;
+	struct famfs_fs_info  *fsi = inode->i_sb->s_fs_info;
+
+	if (fsi->deverror || famfs_file_invalid(inode))
+		goto err_out;
+
+	iomap->offset = file_offset;
+
+	for (i = 0; i < meta->tfs_extent_ct; i++) {
+		loff_t dax_ext_offset = meta->tfs_extents[i].offset;
+		loff_t dax_ext_len    = meta->tfs_extents[i].len;
+
+		if ((dax_ext_offset == 0) &&
+		    (meta->file_type != FAMFS_SUPERBLOCK))
+			pr_warn("%s: zero offset on non-superblock file!!\n",
+				__func__);
+
+		/* local_offset is the offset minus the size of extents skipped
+		 * so far; If local_offset < dax_ext_len, the data of interest
+		 * starts in this extent
+		 */
+		if (local_offset < dax_ext_len) {
+			loff_t ext_len_remainder = dax_ext_len - local_offset;
+
+			/*
+			 * OK, we found the file metadata extent where this
+			 * data begins
+			 * @local_offset      - The offset within the current
+			 *                      extent
+			 * @ext_len_remainder - Remaining length of ext after
+			 *                      skipping local_offset
+			 * Outputs:
+			 * iomap->addr:   the offset within the dax device where
+			 *                the  data starts
+			 * iomap->offset: the file offset
+			 * iomap->length: the valid length resolved here
+			 */
+			iomap->addr    = dax_ext_offset + local_offset;
+			iomap->offset  = file_offset;
+			iomap->length  = min_t(loff_t, len, ext_len_remainder);
+			iomap->dax_dev = fsi->dax_devp;
+			iomap->type    = IOMAP_MAPPED;
+			iomap->flags   = flags;
+
+			return 0;
+		}
+		local_offset -= dax_ext_len; /* Get ready for the next extent */
+	}
+
+ err_out:
+	/* We fell out the end of the extent list.
+	 * Set iomap to zero length in this case, and return 0
+	 * This just means that the r/w is past EOF
+	 */
+	iomap->addr    = 0; /* there is no valid dax device offset */
+	iomap->offset  = file_offset; /* file offset */
+	iomap->length  = 0; /* this had better result in no access to dax mem */
+	iomap->dax_dev = fsi->dax_devp;
+	iomap->type    = IOMAP_MAPPED;
+	iomap->flags   = flags;
+
+	return 0;
+}
+
+/**
+ * famfs_iomap_begin() - Handler for iomap_begin upcall from dax
+ *
+ * This function is pretty simple because files are
+ * * never partially allocated
+ * * never have holes (never sparse)
+ * * never "allocate on write"
+ *
+ * @inode:  inode for the file being accessed
+ * @offset: offset within the file
+ * @length: Length being accessed at offset
+ * @flags:
+ * @iomap:  iomap struct to be filled in, resolving (offset, length) to
+ *          (daxdev, offset, len)
+ * @srcmap:
+ */
+static int
+famfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		  unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct famfs_file_meta *meta = inode->i_private;
+	size_t size;
+
+	size = i_size_read(inode);
+
+	WARN_ON(size != meta->file_size);
+
+	return famfs_meta_to_dax_offset(inode, iomap, offset, length, flags);
+}
+
+/* Note: We never need a special set of write_iomap_ops because famfs never
+ * performs allocation on write.
+ */
+const struct iomap_ops famfs_iomap_ops = {
+	.iomap_begin		= famfs_iomap_begin,
+};
+
 /*********************************************************************
  * vm_operations
  */
@@ -42,7 +405,7 @@ __famfs_filemap_fault(struct vm_fault *vmf, unsigned int pe_size,
 		file_update_time(vmf->vma->vm_file);
 	}
 
-	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, NULL /*&famfs_iomap_ops */);
+	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &famfs_iomap_ops);
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 
@@ -106,9 +469,25 @@ const struct vm_operations_struct famfs_file_vm_ops = {
 static ssize_t
 famfs_file_invalid(struct inode *inode)
 {
+	struct famfs_file_meta *meta = inode->i_private;
+	size_t i_size = i_size_read(inode);
+
+	if (!meta) {
+		pr_debug("%s: un-initialized famfs file\n", __func__);
+		return -EIO;
+	}
+	if (meta->error) {
+		pr_debug("%s: previously detected metadata errors\n", __func__);
+		return -EIO;
+	}
+	if (i_size != meta->file_size) {
+		pr_warn("%s: i_size overwritten from %ld to %ld\n",
+		       __func__, meta->file_size, i_size);
+		meta->error = true;
+		return -ENXIO;
+	}
 	if (!IS_DAX(inode)) {
-		pr_debug("%s: inode %llx IS_DAX is false\n",
-			 __func__, (u64)inode);
+		pr_debug("%s: inode %llx IS_DAX is false\n", __func__, (u64)inode);
 		return -ENXIO;
 	}
 	return 0;
@@ -155,7 +534,7 @@ famfs_dax_read_iter(struct kiocb *iocb, struct iov_iter	*to)
 	if (!iov_iter_count(to))
 		return 0;
 
-	rc = dax_iomap_rw(iocb, to, NULL /*&famfs_iomap_ops */);
+	rc = dax_iomap_rw(iocb, to, &famfs_iomap_ops);
 
 	file_accessed(iocb->ki_filp);
 	return rc;
@@ -181,7 +560,7 @@ famfs_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (!iov_iter_count(from))
 		return 0;
 
-	return dax_iomap_rw(iocb, from, NULL /*&famfs_iomap_ops*/);
+	return dax_iomap_rw(iocb, from, &famfs_iomap_ops);
 }
 
 static int
@@ -211,7 +590,7 @@ const struct file_operations famfs_file_operations = {
 	/* Custom famfs operations */
 	.write_iter	   = famfs_dax_write_iter,
 	.read_iter	   = famfs_dax_read_iter,
-	.unlocked_ioctl    = NULL /*famfs_file_ioctl*/,
+	.unlocked_ioctl    = famfs_file_ioctl,
 	.mmap		   = famfs_file_mmap,
 
 	/* Force PMD alignment for mmap */
diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
index 36efaef425e7..a45757d4cdea 100644
--- a/fs/famfs/famfs_internal.h
+++ b/fs/famfs/famfs_internal.h
@@ -11,8 +11,22 @@
 #ifndef FAMFS_INTERNAL_H
 #define FAMFS_INTERNAL_H
 
+#include <linux/famfs_ioctl.h>
+
 extern const struct file_operations famfs_file_operations;
 
+/*
+ * Each famfs dax file has this hanging from its inode->i_private.
+ */
+struct famfs_file_meta {
+	bool                   error;
+	enum famfs_file_type   file_type;
+	size_t                 file_size;
+	enum famfs_extent_type tfs_extent_type;
+	size_t                 tfs_extent_ct;
+	struct famfs_extent    tfs_extents[];
+};
+
 struct famfs_mount_opts {
 	umode_t mode;
 };
diff --git a/include/uapi/linux/famfs_ioctl.h b/include/uapi/linux/famfs_ioctl.h
new file mode 100644
index 000000000000..97ff5a2a8d13
--- /dev/null
+++ b/include/uapi/linux/famfs_ioctl.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2024 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+#ifndef FAMFS_IOCTL_H
+#define FAMFS_IOCTL_H
+
+#include <linux/ioctl.h>
+#include <linux/uuid.h>
+
+#define FAMFS_KABI_VERSION 42
+#define FAMFS_MAX_EXTENTS 2
+
+/* We anticipate the possiblity of supporting additional types of extents */
+enum famfs_extent_type {
+	SIMPLE_DAX_EXTENT,
+	INVALID_EXTENT_TYPE,
+};
+
+struct famfs_extent {
+	__u64              offset;
+	__u64              len;
+};
+
+enum famfs_file_type {
+	FAMFS_REG,
+	FAMFS_SUPERBLOCK,
+	FAMFS_LOG,
+};
+
+/**
+ * struct famfs_ioc_map - the famfs per-file metadata structure
+ * @extent_type: what type of extents are in this ext_list
+ * @file_type: Mark the superblock and log as special files. Maybe more later.
+ * @file_size: Size of the file, which is <= the size of the ext_list
+ * @ext_list_count: Number of extents
+ * @ext_list: 1 or more extents
+ */
+struct famfs_ioc_map {
+	enum famfs_extent_type    extent_type;
+	enum famfs_file_type      file_type;
+	__u64                     file_size;
+	__u64                     ext_list_count;
+	struct famfs_extent       ext_list[FAMFS_MAX_EXTENTS];
+};
+
+#define FAMFSIOC_MAGIC 'u'
+
+/* famfs file ioctl opcodes */
+#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 0x50, struct famfs_ioc_map)
+#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 0x51, struct famfs_ioc_map)
+#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 0x52, struct famfs_extent)
+#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  0x53)
+
+#endif /* FAMFS_IOCTL_H */
-- 
2.43.0


