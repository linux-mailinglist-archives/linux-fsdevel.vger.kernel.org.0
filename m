Return-Path: <linux-fsdevel+bounces-13543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA01870A65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A821C21CFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4007C0B8;
	Mon,  4 Mar 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXBX3a9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981F7AE72
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579557; cv=none; b=kl4cNUOK1eCi/16rYveDC+mWyhtr52TcBI1moTmGQZx+75X1FqwRauCart4OMtz+h01sweWpUPbc2x6h0Ocn8pvPkIniZw4ogwqopmw1fu+j2Kn2shqHRSYECWDO612nrThNlm3xx3SnCbFSvicGwSLx8njlIxvMT4Jlz4o7EHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579557; c=relaxed/simple;
	bh=XTjLiyhVdd9ZYo0TFgCoVX3/KoKm08jzsPpVswpgNl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRkXyqTT+ETrsM4GBDiyYT9JFjcgxo8UrNgPZmWg6tHJPdVQpGYGuOKWvcF4bgpACkp2E9swog5y/yqxnxHUm3SBTUFuTos9bGm0rYZORDhURsWYQ+EK37DzTeLQ+mjj915Wv39uBqSaoMFAJAuF8ZGrkAkt7+lWYXGM+5XDZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXBX3a9r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5nvhH4v2uFtxCrRAIlPDOuH6lrJEApYvhutql3p8oI=;
	b=GXBX3a9rcYkvRm/hypiu+xCsUum1Nywh9hbjGa7LBHyUkwqp2THPVKVdIYsuMMjju6dUR/
	dNn4OEoOiw3OA9zKKN92qVup/R8c3gUsvq3dvI2Q3KYdf//3k+ubzysUYvPPR6dqGtUKgw
	GwsXcqwfghqhEBdiupJnhNXthoYz4b0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-u_nYB8aTN1G9BLldh_lePg-1; Mon, 04 Mar 2024 14:12:33 -0500
X-MC-Unique: u_nYB8aTN1G9BLldh_lePg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a443f00e9a7so269229966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579551; x=1710184351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5nvhH4v2uFtxCrRAIlPDOuH6lrJEApYvhutql3p8oI=;
        b=LB3qh0uJdzFwt2Ln13UMJHCoGCY1+l0YJSh/RRgUdps+D51TS6WnvKA0oSR/APm2KL
         5It/Ysg5DuqNPiSfqA2W+t61pWcInRRtYVBWpUkiW6HtmyYJf00Jnwe1fL2m3OU2Itvz
         XCoike36JSfsa8b96NI4vbWTPnMEVVlJDAERg0MybyoyS2f5YIjdXDqU+D7kQItOyu5H
         RPqjTn+k7fyJcqRX04/BEcDMHcrBEM+bJnb0aisTirBu33gdePrQ6MOAWlhDx2dRK1MP
         K2AqC52ybY1YcviI2NG6N2UIWoNkcOd91cqpv0apZvPpBH4FR0bU76plktu04bkdllQF
         ayKg==
X-Forwarded-Encrypted: i=1; AJvYcCUEr/fBdc4Hqt8lEIqPcn8bSduapKdoGSYWP23JqnIwlNIgbACsbHa09T0Bdymi2LMCcgpSkMjN5Z7AI4HqNNo3iVbT7PS548+G2tLYWQ==
X-Gm-Message-State: AOJu0Yw5J4bpLprYs4J1h4diHHjdZEDACcrOT06nuI1cM9RbO2wEWwzn
	fTHjJrfpO7XYsUDmRNr2XQYHHYmEkpU3MCulKMfGDC1e7C+e+kPw9qMm0RZtzHFKtaNiwNJ1LP8
	AvhgJRjCnxsqlGO/Pofk6FBhqjMJ8JAy+oMgL0Qq/djcdCXiNO6mG4QR+K8BZsA==
X-Received: by 2002:a17:906:4e90:b0:a45:d2c:eeed with SMTP id v16-20020a1709064e9000b00a450d2ceeedmr4142572eju.18.1709579550811;
        Mon, 04 Mar 2024 11:12:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzKOEPjXEqWdl/Lqbf3vWpW60zRsdJE9KwJ2Us9hsJfeT8Lr5UZqMEKnYr548cFvUl0fRv1Q==
X-Received: by 2002:a17:906:4e90:b0:a45:d2c:eeed with SMTP id v16-20020a1709064e9000b00a450d2ceeedmr4142569eju.18.1709579550473;
        Mon, 04 Mar 2024 11:12:30 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:29 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 21/24] xfs: add fs-verity support
Date: Mon,  4 Mar 2024 20:10:44 +0100
Message-ID: <20240304191046.157464-23-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add integration with fs-verity. The XFS store fs-verity metadata in
the extended file attributes. The metadata consist of verity
descriptor and Merkle tree blocks.

The descriptor is stored under "vdesc" extended attribute. The
Merkle tree blocks are stored under binary indexes which are offsets
into the Merkle tree.

When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
flag is set meaning that the Merkle tree is being build. The
initialization ends with storing of verity descriptor and setting
inode on-disk flag (XFS_DIFLAG2_VERITY).

The verification on read is done in read path of iomap.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/Makefile                 |   1 +
 fs/xfs/libxfs/xfs_attr.c        |  13 ++
 fs/xfs/libxfs/xfs_attr_leaf.c   |  17 +-
 fs/xfs/libxfs/xfs_attr_remote.c |   8 +-
 fs/xfs/libxfs/xfs_da_format.h   |  27 +++
 fs/xfs/libxfs/xfs_ondisk.h      |   4 +
 fs/xfs/xfs_inode.h              |   3 +-
 fs/xfs/xfs_super.c              |  10 +
 fs/xfs/xfs_verity.c             | 355 ++++++++++++++++++++++++++++++++
 fs/xfs/xfs_verity.h             |  33 +++
 10 files changed, 464 insertions(+), 7 deletions(-)
 create mode 100644 fs/xfs/xfs_verity.c
 create mode 100644 fs/xfs/xfs_verity.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index f8845e65cac7..8396a633b541 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -130,6 +130,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
 xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
+xfs-$(CONFIG_FS_VERITY)		+= xfs_verity.o
 
 # notify failure
 ifeq ($(CONFIG_MEMORY_FAILURE),y)
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index ca515e8bd2ed..cde5352db9aa 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -27,6 +27,7 @@
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
 #include "xfs_parent.h"
+#include "xfs_verity.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1527,6 +1528,18 @@ xfs_attr_namecheck(
 	if (flags & XFS_ATTR_PARENT)
 		return xfs_parent_namecheck(mp, name, length, flags);
 
+	if (flags & XFS_ATTR_VERITY) {
+		/* Merkle tree pages are stored under u64 indexes */
+		if (length == sizeof(struct xfs_fsverity_merkle_key))
+			return true;
+
+		/* Verity descriptor blocks are held in a named attribute. */
+		if (length == XFS_VERITY_DESCRIPTOR_NAME_LEN)
+			return true;
+
+		return false;
+	}
+
 	/*
 	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
 	 * out, so use >= for the length check.
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index b51f439e4aed..f1f6aefc0420 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -30,6 +30,7 @@
 #include "xfs_ag.h"
 #include "xfs_errortag.h"
 #include "xfs_health.h"
+#include "xfs_verity.h"
 
 
 /*
@@ -519,7 +520,12 @@ xfs_attr_copy_value(
 		return -ERANGE;
 	}
 
-	if (!args->value) {
+	/*
+	 * We don't want to allocate memory for fs-verity Merkle tree blocks
+	 * (fs-verity descriptor is fine though). They will be stored in
+	 * underlying xfs_buf
+	 */
+	if (!args->value && !xfs_verity_merkle_block(args)) {
 		args->value = kvmalloc(valuelen, GFP_KERNEL | __GFP_NOLOCKDEP);
 		if (!args->value)
 			return -ENOMEM;
@@ -538,7 +544,14 @@ xfs_attr_copy_value(
 	 */
 	if (!value)
 		return -EINVAL;
-	memcpy(args->value, value, valuelen);
+	/*
+	 * We won't copy Merkle tree block to the args->value as we want it be
+	 * in the xfs_buf. And we didn't allocate any memory in args->value.
+	 */
+	if (xfs_verity_merkle_block(args))
+		args->value = value;
+	else
+		memcpy(args->value, value, valuelen);
 	return 0;
 }
 
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index f1b7842da809..a631ddff8068 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -23,6 +23,7 @@
 #include "xfs_trace.h"
 #include "xfs_error.h"
 #include "xfs_health.h"
+#include "xfs_verity.h"
 
 #define ATTR_RMTVALUE_MAPSIZE	1	/* # of map entries at once */
 
@@ -404,11 +405,10 @@ xfs_attr_rmtval_get(
 	ASSERT(args->rmtvaluelen == args->valuelen);
 
 	/*
-	 * We also check for _OP_BUFFER as we want to trigger on
-	 * verity blocks only, not on verity_descriptor
+	 * For fs-verity we want additional space in the xfs_buf. This space is
+	 * used to copy xattr value without leaf headers (crc header).
 	 */
-	if (args->attr_filter & XFS_ATTR_VERITY &&
-			args->op_flags & XFS_DA_OP_BUFFER)
+	if (xfs_verity_merkle_block(args))
 		flags = XBF_DOUBLE_ALLOC;
 
 	valuelen = args->rmtvaluelen;
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index 28d4ac6fa156..c30c3c253191 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -914,4 +914,31 @@ struct xfs_parent_name_rec {
  */
 #define XFS_PARENT_DIRENT_NAME_MAX_SIZE		(MAXNAMELEN - 1)
 
+/*
+ * fs-verity attribute name format
+ *
+ * Merkle tree blocks are stored under extended attributes of the inode. The
+ * name of the attributes are offsets into merkle tree.
+ */
+struct xfs_fsverity_merkle_key {
+	__be64 merkleoff;
+};
+
+static inline void
+xfs_fsverity_merkle_key_to_disk(struct xfs_fsverity_merkle_key *key, loff_t pos)
+{
+	key->merkleoff = cpu_to_be64(pos);
+}
+
+static inline loff_t
+xfs_fsverity_name_to_block_offset(unsigned char *name)
+{
+	struct xfs_fsverity_merkle_key key = {
+		.merkleoff = *(__be64 *)name
+	};
+	loff_t offset = be64_to_cpu(key.merkleoff);
+
+	return offset;
+}
+
 #endif /* __XFS_DA_FORMAT_H__ */
diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
index 81885a6a028e..39209943c474 100644
--- a/fs/xfs/libxfs/xfs_ondisk.h
+++ b/fs/xfs/libxfs/xfs_ondisk.h
@@ -194,6 +194,10 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MIN << XFS_DQ_BIGTIME_SHIFT, 4);
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
+
+	/* fs-verity descriptor xattr name */
+	XFS_CHECK_VALUE(strlen(XFS_VERITY_DESCRIPTOR_NAME),
+			XFS_VERITY_DESCRIPTOR_NAME_LEN);
 }
 
 #endif /* __XFS_ONDISK_H */
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index ab46ffb3ac19..d6664e9afa22 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -348,7 +348,8 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
  * inactivation completes, both flags will be cleared and the inode is a
  * plain old IRECLAIMABLE inode.
  */
-#define XFS_INACTIVATING	(1 << 13)
+#define XFS_INACTIVATING		(1 << 13)
+#define XFS_IVERITY_CONSTRUCTION	(1 << 14) /* merkle tree construction */
 
 /* Quotacheck is running but inode has not been added to quota counts. */
 #define XFS_IQUOTAUNCHECKED	(1 << 14)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 9f9c35cff9bf..996e6ea91fe1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -30,6 +30,7 @@
 #include "xfs_filestream.h"
 #include "xfs_quota.h"
 #include "xfs_sysfs.h"
+#include "xfs_verity.h"
 #include "xfs_ondisk.h"
 #include "xfs_rmap_item.h"
 #include "xfs_refcount_item.h"
@@ -1520,6 +1521,11 @@ xfs_fs_fill_super(
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 	sb->s_op = &xfs_super_operations;
+#ifdef CONFIG_FS_VERITY
+	error = fsverity_set_ops(sb, &xfs_verity_ops);
+	if (error)
+		return error;
+#endif
 
 	/*
 	 * Delay mount work if the debug hook is set. This is debug
@@ -1729,6 +1735,10 @@ xfs_fs_fill_super(
 		goto out_filestream_unmount;
 	}
 
+	if (xfs_has_verity(mp))
+		xfs_alert(mp,
+	"EXPERIMENTAL fs-verity feature in use. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;
diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
new file mode 100644
index 000000000000..ea31b5bf6214
--- /dev/null
+++ b/fs/xfs/xfs_verity.c
@@ -0,0 +1,355 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Red Hat, Inc.
+ */
+#include "xfs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_log_format.h"
+#include "xfs_attr.h"
+#include "xfs_verity.h"
+#include "xfs_bmap_util.h"
+#include "xfs_log_format.h"
+#include "xfs_trans.h"
+#include "xfs_attr_leaf.h"
+
+/*
+ * Make fs-verity invalidate verified status of Merkle tree block
+ */
+static void
+xfs_verity_put_listent(
+	struct xfs_attr_list_context	*context,
+	int				flags,
+	unsigned char			*name,
+	int				namelen,
+	int				valuelen)
+{
+	struct fsverity_blockbuf	block = {
+		.offset = xfs_fsverity_name_to_block_offset(name),
+		.size = valuelen,
+	};
+	/*
+	 * Verity descriptor is smaller than 1024; verity block min size is
+	 * 1024. Exclude verity descriptor
+	 */
+	if (valuelen < 1024)
+		return;
+
+	fsverity_invalidate_block(VFS_I(context->dp), &block);
+}
+
+/*
+ * Iterate over extended attributes in the bp to invalidate Merkle tree blocks
+ */
+static int
+xfs_invalidate_blocks(
+	struct xfs_inode	*ip,
+	struct xfs_buf		*bp)
+{
+	struct xfs_attr_list_context context;
+
+	context.dp = ip;
+	context.resynch = 0;
+	context.buffer = NULL;
+	context.bufsize = 0;
+	context.firstu = 0;
+	context.attr_filter = XFS_ATTR_VERITY;
+	context.put_listent = xfs_verity_put_listent;
+
+	return xfs_attr3_leaf_list_int(bp, &context);
+}
+
+static int
+xfs_get_verity_descriptor(
+	struct inode		*inode,
+	void			*buf,
+	size_t			buf_size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	int			error = 0;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.value		= buf,
+		.valuelen	= buf_size,
+	};
+
+	/*
+	 * The fact that (returned attribute size) == (provided buf_size) is
+	 * checked by xfs_attr_copy_value() (returns -ERANGE)
+	 */
+	error = xfs_attr_get(&args);
+	if (error)
+		return error;
+
+	return args.valuelen;
+}
+
+static int
+xfs_begin_enable_verity(
+	struct file	    *filp)
+{
+	struct inode	    *inode = file_inode(filp);
+	struct xfs_inode    *ip = XFS_I(inode);
+	int		    error = 0;
+
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
+
+	if (IS_DAX(inode))
+		return -EINVAL;
+
+	if (xfs_iflags_test_and_set(ip, XFS_IVERITY_CONSTRUCTION))
+		return -EBUSY;
+
+	return error;
+}
+
+static int
+xfs_drop_merkle_tree(
+	struct xfs_inode		*ip,
+	u64				merkle_tree_size,
+	unsigned int			tree_blocksize)
+{
+	struct xfs_fsverity_merkle_key	name;
+	int				error = 0;
+	u64				offset = 0;
+	struct xfs_da_args		args = {
+		.dp			= ip,
+		.whichfork		= XFS_ATTR_FORK,
+		.attr_filter		= XFS_ATTR_VERITY,
+		.op_flags		= XFS_DA_OP_REMOVE,
+		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
+		/* NULL value make xfs_attr_set remove the attr */
+		.value			= NULL,
+	};
+
+	if (!merkle_tree_size)
+		return 0;
+
+	args.name = (const uint8_t *)&name.merkleoff;
+	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
+		xfs_fsverity_merkle_key_to_disk(&name, offset);
+		error = xfs_attr_set(&args);
+		if (error)
+			return error;
+	}
+
+	args.name = (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME;
+	args.namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
+	error = xfs_attr_set(&args);
+
+	return error;
+}
+
+static int
+xfs_end_enable_verity(
+	struct file		*filp,
+	const void		*desc,
+	size_t			desc_size,
+	u64			merkle_tree_size,
+	unsigned int		tree_blocksize)
+{
+	struct inode		*inode = file_inode(filp);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.attr_flags	= XATTR_CREATE,
+		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
+		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
+		.value		= (void *)desc,
+		.valuelen	= desc_size,
+	};
+	int			error = 0;
+
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
+
+	/* fs-verity failed, just cleanup */
+	if (desc == NULL)
+		goto out;
+
+	error = xfs_attr_set(&args);
+	if (error)
+		goto out;
+
+	/* Set fsverity inode flag */
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
+			0, 0, false, &tp);
+	if (error)
+		goto out;
+
+	/*
+	 * Ensure that we've persisted the verity information before we enable
+	 * it on the inode and tell the caller we have sealed the inode.
+	 */
+	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	xfs_trans_set_sync(tp);
+
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (!error)
+		inode->i_flags |= S_VERITY;
+
+out:
+	if (error)
+		WARN_ON_ONCE(xfs_drop_merkle_tree(ip, merkle_tree_size,
+						  tree_blocksize));
+
+	xfs_iflags_clear(ip, XFS_IVERITY_CONSTRUCTION);
+	return error;
+}
+
+static int
+xfs_read_merkle_tree_block(
+	struct inode			*inode,
+	u64				pos,
+	struct fsverity_blockbuf	*block,
+	unsigned int			log_blocksize,
+	u64				ra_bytes)
+{
+	struct xfs_inode		*ip = XFS_I(inode);
+	struct xfs_fsverity_merkle_key	name;
+	int				error = 0;
+	struct xfs_da_args		args = {
+		.dp			= ip,
+		.attr_filter		= XFS_ATTR_VERITY,
+		.op_flags		= XFS_DA_OP_BUFFER,
+		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
+		.valuelen		= (1 << log_blocksize),
+	};
+	xfs_fsverity_merkle_key_to_disk(&name, pos);
+	args.name = (const uint8_t *)&name.merkleoff;
+
+	error = xfs_attr_get(&args);
+	if (error)
+		goto out;
+
+	if (!args.valuelen)
+		return -ENODATA;
+
+	block->kaddr = args.value;
+	block->offset = pos;
+	block->size = args.valuelen;
+	block->context = args.bp;
+
+	/*
+	 * Memory barriers are used to force operation ordering of clearing
+	 * bitmap in fsverity_invalidate_block() and setting XBF_VERITY_SEEN
+	 * flag.
+	 *
+	 * Multiple threads may execute this code concurrently on the same block.
+	 * This is safe because we use memory barriers to ensure that if a
+	 * thread sees XBF_VERITY_SEEN, then fsverity bitmap is already up to
+	 * date.
+	 *
+	 * Invalidating block in a bitmap again at worst causes a hash block to
+	 * be verified redundantly. That event should be very rare, so it's not
+	 * worth using a lock to avoid.
+	 */
+	if (!(args.bp->b_flags & XBF_VERITY_SEEN)) {
+		/*
+		 * A read memory barrier is needed here to give ACQUIRE
+		 * semantics to the above check.
+		 */
+		smp_rmb();
+		/*
+		 * fs-verity is not aware if buffer was evicted from the memory.
+		 * Make fs-verity invalidate verfied status of all blocks in the
+		 * buffer.
+		 *
+		 * Single extended attribute can contain multiple Merkle tree
+		 * blocks:
+		 * - leaf with inline data -> invalidate all blocks in the leaf
+		 * - remote value -> invalidate single block
+		 *
+		 * For example, leaf on 64k system with 4k/1k filesystem will
+		 * contain multiple Merkle tree blocks.
+		 *
+		 * Only remote value buffers would have XBF_DOUBLE_ALLOC flag
+		 */
+		if (args.bp->b_flags & XBF_DOUBLE_ALLOC)
+			fsverity_invalidate_block(inode, block);
+		else {
+			error = xfs_invalidate_blocks(ip, args.bp);
+			if (error)
+				goto out;
+		}
+	}
+
+	/*
+	 * A write memory barrier is needed here to give RELEASE
+	 * semantics to the below flag.
+	 */
+	smp_wmb();
+	args.bp->b_flags |= XBF_VERITY_SEEN;
+
+	return error;
+
+out:
+	kvfree(args.value);
+	if (args.bp)
+		xfs_buf_rele(args.bp);
+	return error;
+}
+
+static int
+xfs_write_merkle_tree_block(
+	struct inode		*inode,
+	const void		*buf,
+	u64			pos,
+	unsigned int		size)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_fsverity_merkle_key	name;
+	struct xfs_da_args	args = {
+		.dp		= ip,
+		.whichfork	= XFS_ATTR_FORK,
+		.attr_filter	= XFS_ATTR_VERITY,
+		.attr_flags	= XATTR_CREATE,
+		.namelen	= sizeof(struct xfs_fsverity_merkle_key),
+		.value		= (void *)buf,
+		.valuelen	= size,
+	};
+
+	xfs_fsverity_merkle_key_to_disk(&name, pos);
+	args.name = (const uint8_t *)&name.merkleoff;
+
+	return xfs_attr_set(&args);
+}
+
+static void
+xfs_drop_block(
+	struct fsverity_blockbuf	*block)
+{
+	struct xfs_buf			*bp;
+
+	ASSERT(block != NULL);
+	bp = (struct xfs_buf *)block->context;
+	ASSERT(bp->b_flags & XBF_VERITY_SEEN);
+
+	xfs_buf_rele(bp);
+
+	kunmap_local(block->kaddr);
+}
+
+const struct fsverity_operations xfs_verity_ops = {
+	.begin_enable_verity		= &xfs_begin_enable_verity,
+	.end_enable_verity		= &xfs_end_enable_verity,
+	.get_verity_descriptor		= &xfs_get_verity_descriptor,
+	.read_merkle_tree_block		= &xfs_read_merkle_tree_block,
+	.write_merkle_tree_block	= &xfs_write_merkle_tree_block,
+	.drop_block			= &xfs_drop_block,
+};
diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
new file mode 100644
index 000000000000..deea15cd3cc5
--- /dev/null
+++ b/fs/xfs/xfs_verity.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Red Hat, Inc.
+ */
+#ifndef __XFS_VERITY_H__
+#define __XFS_VERITY_H__
+
+#include "xfs.h"
+#include "xfs_da_format.h"
+#include "xfs_da_btree.h"
+#include <linux/fsverity.h>
+
+#define XFS_VERITY_DESCRIPTOR_NAME "vdesc"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN 5
+
+static inline bool
+xfs_verity_merkle_block(
+		struct xfs_da_args *args)
+{
+	if (!(args->attr_filter & XFS_ATTR_VERITY))
+		return false;
+
+	if (!(args->op_flags & XFS_DA_OP_BUFFER))
+		return false;
+
+	return true;
+}
+
+#ifdef CONFIG_FS_VERITY
+extern const struct fsverity_operations xfs_verity_ops;
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_VERITY_H__ */
-- 
2.42.0


