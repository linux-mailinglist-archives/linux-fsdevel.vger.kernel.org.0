Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB230350B95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 03:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhDABJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 21:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232672AbhDABJV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 21:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 606AE6105A;
        Thu,  1 Apr 2021 01:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617239361;
        bh=y2kCY62qKGGmKStEnXjlXWC4gx6OOLI/cHwryLxs59g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OXSvJKhMUegJmLy5LqylgVURk0NCC2YVZRNct3cuDNP7sVoqDHbAtOfu5oP+9pvF0
         Vcl+lW0jRQjuOVolaKp5OcFPwUxuEJ8qvClEywXbzarhDcnX3eFZI/qJXK687gWKXW
         Zh8gvUdkxxgFPz6FTe5kqhANtO0+9RV7Qa42kbdDT77q03kPbBFSoudzyT0xJ3Fplb
         cjlSLOAzpM3KMZ5qtN9Q8eMNnMRQGzWTY5ZnnFOgOo+h3q+ewWuMlsjfU1MvU5H0KE
         adf11zkCNqIVk9eXbOHacUSYmdK14BEQut/OJa6ONLx4DIJEUsI8pRsJusiqW+F9ah
         +4KGDBPjFcUvQ==
Subject: [PATCH 06/18] xfs: introduce a swap-extent log intent item
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Wed, 31 Mar 2021 18:09:20 -0700
Message-ID: <161723936048.3149451.14004566958999353770.stgit@magnolia>
In-Reply-To: <161723932606.3149451.12366114306150243052.stgit@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Introduce a new intent log item to handle swapping extents.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Makefile                 |    1 
 fs/xfs/libxfs/xfs_log_format.h  |   59 +++++++
 fs/xfs/libxfs/xfs_log_recover.h |    2 
 fs/xfs/xfs_log.c                |    2 
 fs/xfs/xfs_log_recover.c        |    2 
 fs/xfs/xfs_super.c              |   17 ++
 fs/xfs/xfs_swapext_item.c       |  328 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_swapext_item.h       |   61 +++++++
 8 files changed, 470 insertions(+), 2 deletions(-)
 create mode 100644 fs/xfs/xfs_swapext_item.c
 create mode 100644 fs/xfs/xfs_swapext_item.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index dac3bec1a695..a7cc6f496ad0 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -107,6 +107,7 @@ xfs-y				+= xfs_log.o \
 				   xfs_inode_item_recover.o \
 				   xfs_refcount_item.o \
 				   xfs_rmap_item.o \
+				   xfs_swapext_item.o \
 				   xfs_log_recover.o \
 				   xfs_trans_ail.o \
 				   xfs_trans_buf.o
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 6107dac4bd6b..52ca6d72de6a 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -117,7 +117,9 @@ struct xfs_unmount_log_format {
 #define XLOG_REG_TYPE_CUD_FORMAT	24
 #define XLOG_REG_TYPE_BUI_FORMAT	25
 #define XLOG_REG_TYPE_BUD_FORMAT	26
-#define XLOG_REG_TYPE_MAX		26
+#define XLOG_REG_TYPE_SXI_FORMAT	27
+#define XLOG_REG_TYPE_SXD_FORMAT	28
+#define XLOG_REG_TYPE_MAX		28
 
 /*
  * Flags to log operation header
@@ -240,6 +242,8 @@ typedef struct xfs_trans_header {
 #define	XFS_LI_CUD		0x1243
 #define	XFS_LI_BUI		0x1244	/* bmbt update intent */
 #define	XFS_LI_BUD		0x1245
+#define	XFS_LI_SXI		0x1246
+#define	XFS_LI_SXD		0x1247
 
 #define XFS_LI_TYPE_DESC \
 	{ XFS_LI_EFI,		"XFS_LI_EFI" }, \
@@ -255,7 +259,9 @@ typedef struct xfs_trans_header {
 	{ XFS_LI_CUI,		"XFS_LI_CUI" }, \
 	{ XFS_LI_CUD,		"XFS_LI_CUD" }, \
 	{ XFS_LI_BUI,		"XFS_LI_BUI" }, \
-	{ XFS_LI_BUD,		"XFS_LI_BUD" }
+	{ XFS_LI_BUD,		"XFS_LI_BUD" }, \
+	{ XFS_LI_SXI,		"XFS_LI_SXI" }, \
+	{ XFS_LI_SXD,		"XFS_LI_SXD" }
 
 /*
  * Inode Log Item Format definitions.
@@ -784,6 +790,55 @@ struct xfs_bud_log_format {
 	uint64_t		bud_bui_id;	/* id of corresponding bui */
 };
 
+/*
+ * SXI/SXD (extent swapping) log format definitions
+ */
+
+struct xfs_swap_extent {
+	uint64_t		sx_inode1;
+	uint64_t		sx_inode2;
+	uint64_t		sx_startoff1;
+	uint64_t		sx_startoff2;
+	uint64_t		sx_blockcount;
+	uint64_t		sx_flags;
+	int64_t			sx_isize1;
+	int64_t			sx_isize2;
+};
+
+/* Swap extents between extended attribute forks. */
+#define XFS_SWAP_EXTENT_ATTR_FORK	(1ULL << 0)
+
+/* Set the file sizes when finished. */
+#define XFS_SWAP_EXTENT_SET_SIZES	(1ULL << 1)
+
+/* Do not swap any part of the range where file1's mapping is a hole. */
+#define XFS_SWAP_EXTENT_SKIP_FILE1_HOLES (1ULL << 2)
+
+#define XFS_SWAP_EXTENT_FLAGS		(XFS_SWAP_EXTENT_ATTR_FORK | \
+					 XFS_SWAP_EXTENT_SET_SIZES | \
+					 XFS_SWAP_EXTENT_SKIP_FILE1_HOLES)
+
+/* This is the structure used to lay out an sxi log item in the log. */
+struct xfs_sxi_log_format {
+	uint16_t		sxi_type;	/* sxi log item type */
+	uint16_t		sxi_size;	/* size of this item */
+	uint32_t		__pad;		/* must be zero */
+	uint64_t		sxi_id;		/* sxi identifier */
+	struct xfs_swap_extent	sxi_extent;	/* extent to swap */
+};
+
+/*
+ * This is the structure used to lay out an sxd log item in the
+ * log.  The sxd_extents array is a variable size array whose
+ * size is given by sxd_nextents;
+ */
+struct xfs_sxd_log_format {
+	uint16_t		sxd_type;	/* sxd log item type */
+	uint16_t		sxd_size;	/* size of this item */
+	uint32_t		__pad;
+	uint64_t		sxd_sxi_id;	/* id of corresponding bui */
+};
+
 /*
  * Dquot Log format definitions.
  *
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 3cca2bfe714c..dcc11a8c438a 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -72,6 +72,8 @@ extern const struct xlog_recover_item_ops xlog_rui_item_ops;
 extern const struct xlog_recover_item_ops xlog_rud_item_ops;
 extern const struct xlog_recover_item_ops xlog_cui_item_ops;
 extern const struct xlog_recover_item_ops xlog_cud_item_ops;
+extern const struct xlog_recover_item_ops xlog_sxi_item_ops;
+extern const struct xlog_recover_item_ops xlog_sxd_item_ops;
 
 /*
  * Macros, structures, prototypes for internal log manager use.
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index cb72be62da3e..34213fce3eed 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -2113,6 +2113,8 @@ xlog_print_tic_res(
 	    REG_TYPE_STR(CUD_FORMAT, "cud_format"),
 	    REG_TYPE_STR(BUI_FORMAT, "bui_format"),
 	    REG_TYPE_STR(BUD_FORMAT, "bud_format"),
+	    REG_TYPE_STR(SXI_FORMAT, "sxi_format"),
+	    REG_TYPE_STR(SXD_FORMAT, "sxd_format"),
 	};
 	BUILD_BUG_ON(ARRAY_SIZE(res_type_str) != XLOG_REG_TYPE_MAX + 1);
 #undef REG_TYPE_STR
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index fdba9b55822e..107bb222d79f 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1775,6 +1775,8 @@ static const struct xlog_recover_item_ops *xlog_recover_item_ops[] = {
 	&xlog_cud_item_ops,
 	&xlog_bui_item_ops,
 	&xlog_bud_item_ops,
+	&xlog_sxi_item_ops,
+	&xlog_sxd_item_ops,
 };
 
 static const struct xlog_recover_item_ops *
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 175dc7acaca8..85ced8cc6070 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -36,6 +36,7 @@
 #include "xfs_bmap_item.h"
 #include "xfs_reflink.h"
 #include "xfs_pwork.h"
+#include "xfs_swapext_item.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -2121,8 +2122,24 @@ xfs_init_zones(void)
 	if (!xfs_bui_zone)
 		goto out_destroy_bud_zone;
 
+	xfs_sxd_zone = kmem_cache_create("xfs_sxd_item",
+					 sizeof(struct xfs_sxd_log_item),
+					 0, 0, NULL);
+	if (!xfs_sxd_zone)
+		goto out_destroy_bui_zone;
+
+	xfs_sxi_zone = kmem_cache_create("xfs_sxi_item",
+					 sizeof(struct xfs_sxi_log_item),
+					 0, 0, NULL);
+	if (!xfs_sxi_zone)
+		goto out_destroy_sxd_zone;
+
 	return 0;
 
+ out_destroy_sxd_zone:
+	kmem_cache_destroy(xfs_sxd_zone);
+ out_destroy_bui_zone:
+	kmem_cache_destroy(xfs_bui_zone);
  out_destroy_bud_zone:
 	kmem_cache_destroy(xfs_bud_zone);
  out_destroy_cui_zone:
diff --git a/fs/xfs/xfs_swapext_item.c b/fs/xfs/xfs_swapext_item.c
new file mode 100644
index 000000000000..83913e9fd4d4
--- /dev/null
+++ b/fs/xfs/xfs_swapext_item.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_bit.h"
+#include "xfs_shared.h"
+#include "xfs_mount.h"
+#include "xfs_defer.h"
+#include "xfs_inode.h"
+#include "xfs_trans.h"
+#include "xfs_trans_priv.h"
+#include "xfs_swapext_item.h"
+#include "xfs_log.h"
+#include "xfs_bmap.h"
+#include "xfs_icache.h"
+#include "xfs_trans_space.h"
+#include "xfs_error.h"
+#include "xfs_log_priv.h"
+#include "xfs_log_recover.h"
+
+kmem_zone_t	*xfs_sxi_zone;
+kmem_zone_t	*xfs_sxd_zone;
+
+static const struct xfs_item_ops xfs_sxi_item_ops;
+
+static inline struct xfs_sxi_log_item *SXI_ITEM(struct xfs_log_item *lip)
+{
+	return container_of(lip, struct xfs_sxi_log_item, sxi_item);
+}
+
+STATIC void
+xfs_sxi_item_free(
+	struct xfs_sxi_log_item	*sxi_lip)
+{
+	kmem_cache_free(xfs_sxi_zone, sxi_lip);
+}
+
+/*
+ * Freeing the SXI requires that we remove it from the AIL if it has already
+ * been placed there. However, the SXI may not yet have been placed in the AIL
+ * when called by xfs_sxi_release() from SXD processing due to the ordering of
+ * committed vs unpin operations in bulk insert operations. Hence the reference
+ * count to ensure only the last caller frees the SXI.
+ */
+STATIC void
+xfs_sxi_release(
+	struct xfs_sxi_log_item	*sxi_lip)
+{
+	ASSERT(atomic_read(&sxi_lip->sxi_refcount) > 0);
+	if (atomic_dec_and_test(&sxi_lip->sxi_refcount)) {
+		xfs_trans_ail_delete(&sxi_lip->sxi_item, SHUTDOWN_LOG_IO_ERROR);
+		xfs_sxi_item_free(sxi_lip);
+	}
+}
+
+
+STATIC void
+xfs_sxi_item_size(
+	struct xfs_log_item	*lip,
+	int			*nvecs,
+	int			*nbytes)
+{
+	*nvecs += 1;
+	*nbytes += sizeof(struct xfs_sxi_log_format);
+}
+
+/*
+ * This is called to fill in the vector of log iovecs for the given sxi log
+ * item. We use only 1 iovec, and we point that at the sxi_log_format structure
+ * embedded in the sxi item.
+ */
+STATIC void
+xfs_sxi_item_format(
+	struct xfs_log_item	*lip,
+	struct xfs_log_vec	*lv)
+{
+	struct xfs_sxi_log_item	*sxi_lip = SXI_ITEM(lip);
+	struct xfs_log_iovec	*vecp = NULL;
+
+	sxi_lip->sxi_format.sxi_type = XFS_LI_SXI;
+	sxi_lip->sxi_format.sxi_size = 1;
+
+	xlog_copy_iovec(lv, &vecp, XLOG_REG_TYPE_SXI_FORMAT,
+			&sxi_lip->sxi_format,
+			sizeof(struct xfs_sxi_log_format));
+}
+
+/*
+ * The unpin operation is the last place an SXI is manipulated in the log. It
+ * is either inserted in the AIL or aborted in the event of a log I/O error. In
+ * either case, the SXI transaction has been successfully committed to make it
+ * this far. Therefore, we expect whoever committed the SXI to either construct
+ * and commit the SXD or drop the SXD's reference in the event of error. Simply
+ * drop the log's SXI reference now that the log is done with it.
+ */
+STATIC void
+xfs_sxi_item_unpin(
+	struct xfs_log_item	*lip,
+	int			remove)
+{
+	struct xfs_sxi_log_item	*sxi_lip = SXI_ITEM(lip);
+
+	xfs_sxi_release(sxi_lip);
+}
+
+/*
+ * The SXI has been either committed or aborted if the transaction has been
+ * cancelled. If the transaction was cancelled, an SXD isn't going to be
+ * constructed and thus we free the SXI here directly.
+ */
+STATIC void
+xfs_sxi_item_release(
+	struct xfs_log_item	*lip)
+{
+	xfs_sxi_release(SXI_ITEM(lip));
+}
+
+/* Allocate and initialize an sxi item with the given number of extents. */
+STATIC struct xfs_sxi_log_item *
+xfs_sxi_init(
+	struct xfs_mount		*mp)
+
+{
+	struct xfs_sxi_log_item		*sxi_lip;
+
+	sxi_lip = kmem_cache_zalloc(xfs_sxi_zone, GFP_KERNEL | __GFP_NOFAIL);
+
+	xfs_log_item_init(mp, &sxi_lip->sxi_item, XFS_LI_SXI, &xfs_sxi_item_ops);
+	sxi_lip->sxi_format.sxi_id = (uintptr_t)(void *)sxi_lip;
+	atomic_set(&sxi_lip->sxi_refcount, 2);
+
+	return sxi_lip;
+}
+
+static inline struct xfs_sxd_log_item *SXD_ITEM(struct xfs_log_item *lip)
+{
+	return container_of(lip, struct xfs_sxd_log_item, sxd_item);
+}
+
+STATIC void
+xfs_sxd_item_size(
+	struct xfs_log_item	*lip,
+	int			*nvecs,
+	int			*nbytes)
+{
+	*nvecs += 1;
+	*nbytes += sizeof(struct xfs_sxd_log_format);
+}
+
+/*
+ * This is called to fill in the vector of log iovecs for the given sxd log
+ * item. We use only 1 iovec, and we point that at the sxd_log_format structure
+ * embedded in the sxd item.
+ */
+STATIC void
+xfs_sxd_item_format(
+	struct xfs_log_item	*lip,
+	struct xfs_log_vec	*lv)
+{
+	struct xfs_sxd_log_item	*sxd_lip = SXD_ITEM(lip);
+	struct xfs_log_iovec	*vecp = NULL;
+
+	sxd_lip->sxd_format.sxd_type = XFS_LI_SXD;
+	sxd_lip->sxd_format.sxd_size = 1;
+
+	xlog_copy_iovec(lv, &vecp, XLOG_REG_TYPE_SXD_FORMAT, &sxd_lip->sxd_format,
+			sizeof(struct xfs_sxd_log_format));
+}
+
+/*
+ * The SXD is either committed or aborted if the transaction is cancelled. If
+ * the transaction is cancelled, drop our reference to the SXI and free the
+ * SXD.
+ */
+STATIC void
+xfs_sxd_item_release(
+	struct xfs_log_item	*lip)
+{
+	struct xfs_sxd_log_item	*sxd_lip = SXD_ITEM(lip);
+
+	xfs_sxi_release(sxd_lip->sxd_intent_log_item);
+	kmem_cache_free(xfs_sxd_zone, sxd_lip);
+}
+
+static const struct xfs_item_ops xfs_sxd_item_ops = {
+	.flags		= XFS_ITEM_RELEASE_WHEN_COMMITTED,
+	.iop_size	= xfs_sxd_item_size,
+	.iop_format	= xfs_sxd_item_format,
+	.iop_release	= xfs_sxd_item_release,
+};
+
+/* Process a swapext update intent item that was recovered from the log. */
+STATIC int
+xfs_sxi_item_recover(
+	struct xfs_log_item		*lip,
+	struct list_head		*capture_list)
+{
+	return -EFSCORRUPTED;
+}
+
+STATIC bool
+xfs_sxi_item_match(
+	struct xfs_log_item	*lip,
+	uint64_t		intent_id)
+{
+	return SXI_ITEM(lip)->sxi_format.sxi_id == intent_id;
+}
+
+/* Relog an intent item to push the log tail forward. */
+static struct xfs_log_item *
+xfs_sxi_item_relog(
+	struct xfs_log_item		*intent,
+	struct xfs_trans		*tp)
+{
+	ASSERT(0);
+	return NULL;
+}
+
+static const struct xfs_item_ops xfs_sxi_item_ops = {
+	.iop_size	= xfs_sxi_item_size,
+	.iop_format	= xfs_sxi_item_format,
+	.iop_unpin	= xfs_sxi_item_unpin,
+	.iop_release	= xfs_sxi_item_release,
+	.iop_recover	= xfs_sxi_item_recover,
+	.iop_match	= xfs_sxi_item_match,
+	.iop_relog	= xfs_sxi_item_relog,
+};
+
+/*
+ * Copy an SXI format buffer from the given buf, and into the destination SXI
+ * format structure.  The SXI/SXD items were designed not to need any special
+ * alignment handling.
+ */
+static int
+xfs_sxi_copy_format(
+	struct xfs_log_iovec		*buf,
+	struct xfs_sxi_log_format	*dst_sxi_fmt)
+{
+	struct xfs_sxi_log_format	*src_sxi_fmt;
+	size_t				len;
+
+	src_sxi_fmt = buf->i_addr;
+	len = sizeof(struct xfs_sxi_log_format);
+
+	if (buf->i_len == len) {
+		memcpy(dst_sxi_fmt, src_sxi_fmt, len);
+		return 0;
+	}
+	XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, NULL);
+	return -EFSCORRUPTED;
+}
+
+/*
+ * This routine is called to create an in-core extent swapext update item from
+ * the sxi format structure which was logged on disk.  It allocates an in-core
+ * sxi, copies the extents from the format structure into it, and adds the sxi
+ * to the AIL with the given LSN.
+ */
+STATIC int
+xlog_recover_sxi_commit_pass2(
+	struct xlog			*log,
+	struct list_head		*buffer_list,
+	struct xlog_recover_item	*item,
+	xfs_lsn_t			lsn)
+{
+	int				error;
+	struct xfs_mount		*mp = log->l_mp;
+	struct xfs_sxi_log_item		*sxi_lip;
+	struct xfs_sxi_log_format	*sxi_formatp;
+
+	sxi_formatp = item->ri_buf[0].i_addr;
+
+	if (sxi_formatp->__pad != 0) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+	sxi_lip = xfs_sxi_init(mp);
+	error = xfs_sxi_copy_format(&item->ri_buf[0], &sxi_lip->sxi_format);
+	if (error) {
+		xfs_sxi_item_free(sxi_lip);
+		return error;
+	}
+	xfs_trans_ail_insert(log->l_ailp, &sxi_lip->sxi_item, lsn);
+	xfs_sxi_release(sxi_lip);
+	return 0;
+}
+
+const struct xlog_recover_item_ops xlog_sxi_item_ops = {
+	.item_type		= XFS_LI_SXI,
+	.commit_pass2		= xlog_recover_sxi_commit_pass2,
+};
+
+/*
+ * This routine is called when an SXD format structure is found in a committed
+ * transaction in the log. Its purpose is to cancel the corresponding SXI if it
+ * was still in the log. To do this it searches the AIL for the SXI with an id
+ * equal to that in the SXD format structure. If we find it we drop the SXD
+ * reference, which removes the SXI from the AIL and frees it.
+ */
+STATIC int
+xlog_recover_sxd_commit_pass2(
+	struct xlog			*log,
+	struct list_head		*buffer_list,
+	struct xlog_recover_item	*item,
+	xfs_lsn_t			lsn)
+{
+	struct xfs_sxd_log_format	*sxd_formatp;
+
+	sxd_formatp = item->ri_buf[0].i_addr;
+	if (item->ri_buf[0].i_len != sizeof(struct xfs_sxd_log_format)) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
+	xlog_recover_release_intent(log, XFS_LI_SXI, sxd_formatp->sxd_sxi_id);
+	return 0;
+}
+
+const struct xlog_recover_item_ops xlog_sxd_item_ops = {
+	.item_type		= XFS_LI_SXD,
+	.commit_pass2		= xlog_recover_sxd_commit_pass2,
+};
diff --git a/fs/xfs/xfs_swapext_item.h b/fs/xfs/xfs_swapext_item.h
new file mode 100644
index 000000000000..7caeccdcaa81
--- /dev/null
+++ b/fs/xfs/xfs_swapext_item.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef	__XFS_SWAPEXT_ITEM_H__
+#define	__XFS_SWAPEXT_ITEM_H__
+
+/*
+ * The extent swapping intent item help us perform atomic extent swaps between
+ * two inode forks.  It does this by tracking the range of logical offsets that
+ * still need to be swapped, and relogs as progress happens.
+ *
+ * *I items should be recorded in the *first* of a series of rolled
+ * transactions, and the *D items should be recorded in the same transaction
+ * that records the associated bmbt updates.
+ *
+ * Should the system crash after the commit of the first transaction but
+ * before the commit of the final transaction in a series, log recovery will
+ * use the redo information recorded by the intent items to replay the
+ * rest of the extent swaps.
+ */
+
+/* kernel only SXI/SXD definitions */
+
+struct xfs_mount;
+struct kmem_zone;
+
+/*
+ * Max number of extents in fast allocation path.
+ */
+#define	XFS_SXI_MAX_FAST_EXTENTS	1
+
+/*
+ * This is the "swapext update intent" log item.  It is used to log the fact
+ * that we are swapping extents between two files.  It is used in conjunction
+ * with the "swapext update done" log item described below.
+ *
+ * These log items follow the same rules as struct xfs_efi_log_item; see the
+ * comments about that structure (in xfs_extfree_item.h) for more details.
+ */
+struct xfs_sxi_log_item {
+	struct xfs_log_item		sxi_item;
+	atomic_t			sxi_refcount;
+	struct xfs_sxi_log_format	sxi_format;
+};
+
+/*
+ * This is the "swapext update done" log item.  It is used to log the fact that
+ * some extent swapping mentioned in an earlier sxi item have been performed.
+ */
+struct xfs_sxd_log_item {
+	struct xfs_log_item		sxd_item;
+	struct xfs_sxi_log_item		*sxd_intent_log_item;
+	struct xfs_sxd_log_format	sxd_format;
+};
+
+extern struct kmem_zone	*xfs_sxi_zone;
+extern struct kmem_zone	*xfs_sxd_zone;
+
+#endif	/* __XFS_SWAPEXT_ITEM_H__ */

