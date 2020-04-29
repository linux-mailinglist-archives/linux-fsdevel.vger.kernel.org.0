Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E261BD26B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD2CpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgD2CpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2iAZ9156399;
        Wed, 29 Apr 2020 02:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EnWcOENY45vRma4eOt7J2rnoMq67iuOnNc2LJyn0OHY=;
 b=bngsgZs8v4AfwRwfa0FEwuW9snXCwUNNO3JtBh8uBQalRL3H6SDcdbYVn6cjxDUpIsCC
 PrjtIl1/DOHKeewWnpUVBZOmrxRX1OKkof5KJuBzN35rxb8eo4TWS9mH0HqLSnt2HviG
 KXeXMj2JQfajVHXRHdULZFPV4ByMPHHUqvOuHxGTnBTy8GA8eaVkxY+ABMUDDocXMFG1
 xnBj6mRI7JjmvZpjGhHJ0HwAgC2lz835UpIavai/8IiBDu4rP1C5onh60vbU+vo5fwH5
 AIRNxZlWpWktM+4hndi7lhNdmFsEbpMQ3t/3TM7rJ7eQh0rrkb7EtJMbwV1fx94Prrcv GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30p01nsthw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2ggFe071513;
        Wed, 29 Apr 2020 02:45:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30mxphp2rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2j8XC003599;
        Wed, 29 Apr 2020 02:45:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:07 -0700
Subject: [PATCH 08/18] xfs: introduce a swap-extent log intent item
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:06 -0700
Message-ID: <158812830680.168506.10239099532005921334.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=3 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Introduce a new intent log item to handle swapping extents.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/Makefile                 |    1 
 fs/xfs/libxfs/xfs_log_format.h  |   55 ++++++
 fs/xfs/libxfs/xfs_log_recover.h |    1 
 fs/xfs/xfs_log.c                |    2 
 fs/xfs/xfs_log_recover.c        |    6 +
 fs/xfs/xfs_super.c              |   17 ++
 fs/xfs/xfs_swapext_item.c       |  365 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_swapext_item.h       |   67 +++++++
 8 files changed, 512 insertions(+), 2 deletions(-)
 create mode 100644 fs/xfs/xfs_swapext_item.c
 create mode 100644 fs/xfs/xfs_swapext_item.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 2bd822c784cb..27b4bd5c8ffe 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -109,6 +109,7 @@ xfs-y				+= xfs_log.o \
 				   xfs_inode_item.o \
 				   xfs_refcount_item.o \
 				   xfs_rmap_item.o \
+				   xfs_swapext_item.o \
 				   xfs_log_recover.o \
 				   xfs_trans_ail.o \
 				   xfs_trans_buf.o
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 382b7cd6ba82..ceb67213df64 100644
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
@@ -786,6 +792,51 @@ struct xfs_bud_log_format {
 	uint64_t		bud_bui_id;	/* id of corresponding bui */
 };
 
+/*
+ * SXI/SXD (extent swapping) log format definitions
+ */
+
+struct xfs_swap_extent {
+	uint64_t		se_inode1;
+	uint64_t		se_inode2;
+	uint64_t		se_startoff1;
+	uint64_t		se_startoff2;
+	uint64_t		se_blockcount;
+	uint64_t		se_flags;
+	int64_t			se_isize1;
+	int64_t			se_isize2;
+};
+
+/* Swap extents between extended attribute forks. */
+#define XFS_SWAP_EXTENT_ATTR_FORK	(1ULL << 0)
+
+/* Set the file sizes when finished. */
+#define XFS_SWAP_EXTENT_SET_SIZES	(1ULL << 1)
+
+#define XFS_SWAP_EXTENT_FLAGS		(XFS_SWAP_EXTENT_ATTR_FORK | \
+					 XFS_SWAP_EXTENT_SET_SIZES)
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
index b36ccaa5465b..c9cd6775f50c 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -169,6 +169,7 @@ extern const struct xlog_recover_intent_type xlog_recover_extfree_type;
 extern const struct xlog_recover_intent_type xlog_recover_rmap_type;
 extern const struct xlog_recover_intent_type xlog_recover_refcount_type;
 extern const struct xlog_recover_intent_type xlog_recover_bmap_type;
+extern const struct xlog_recover_intent_type xlog_recover_swapext_type;
 
 typedef bool (*xlog_recover_release_intent_fn)(struct xlog *log,
 		struct xfs_log_item *item, uint64_t intent_id);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 00fda2e8e738..f589157059d2 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1975,6 +1975,8 @@ xlog_print_tic_res(
 	    REG_TYPE_STR(CUD_FORMAT, "cud_format"),
 	    REG_TYPE_STR(BUI_FORMAT, "bui_format"),
 	    REG_TYPE_STR(BUD_FORMAT, "bud_format"),
+	    REG_TYPE_STR(SXI_FORMAT, "sxi_format"),
+	    REG_TYPE_STR(SXD_FORMAT, "sxd_format"),
 	};
 	BUILD_BUG_ON(ARRAY_SIZE(res_type_str) != XLOG_REG_TYPE_MAX + 1);
 #undef REG_TYPE_STR
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 1c836dcf3e3e..4f990a45291b 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1851,6 +1851,9 @@ xlog_intent_for_type(
 	case XFS_LI_BUI:
 	case XFS_LI_BUD:
 		return &xlog_recover_bmap_type;
+	case XFS_LI_SXI:
+	case XFS_LI_SXD:
+		return &xlog_recover_swapext_type;
 	default:
 		return NULL;
 	}
@@ -1865,6 +1868,7 @@ xlog_is_intent_done_item(
 	case XFS_LI_RUD:
 	case XFS_LI_CUD:
 	case XFS_LI_BUD:
+	case XFS_LI_SXD:
 		return true;
 	default:
 		return false;
@@ -1917,6 +1921,8 @@ xlog_item_for_type(
 	case XFS_LI_CUD:
 	case XFS_LI_BUI:
 	case XFS_LI_BUD:
+	case XFS_LI_SXI:
+	case XFS_LI_SXD:
 		return &xlog_intent_item_type;
 	case XFS_LI_INODE:
 		return &xlog_inode_item_type;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 42d82c9d2a1d..206db91d113f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -35,6 +35,7 @@
 #include "xfs_refcount_item.h"
 #include "xfs_bmap_item.h"
 #include "xfs_reflink.h"
+#include "xfs_swapext_item.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -2075,8 +2076,24 @@ xfs_init_zones(void)
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
index 000000000000..63ba43e5c3bb
--- /dev/null
+++ b/fs/xfs/xfs_swapext_item.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
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
+static inline struct xfs_sxi_log_item *SXI_ITEM(struct xfs_log_item *lip)
+{
+	return container_of(lip, struct xfs_sxi_log_item, sxi_item);
+}
+
+STATIC void
+xfs_sxi_item_free(
+	struct xfs_sxi_log_item	*ilip)
+{
+	kmem_cache_free(xfs_sxi_zone, ilip);
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
+	struct xfs_sxi_log_item	*ilip)
+{
+	ASSERT(atomic_read(&ilip->sxi_refcount) > 0);
+	if (atomic_dec_and_test(&ilip->sxi_refcount)) {
+		xfs_trans_ail_remove(&ilip->sxi_item, SHUTDOWN_LOG_IO_ERROR);
+		xfs_sxi_item_free(ilip);
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
+ * This is called to fill in the vector of log iovecs for the
+ * given sxi log item. We use only 1 iovec, and we point that
+ * at the sxi_log_format structure embedded in the sxi item.
+ * It is at this point that we assert that all of the extent
+ * slots in the sxi item have been filled.
+ */
+STATIC void
+xfs_sxi_item_format(
+	struct xfs_log_item	*lip,
+	struct xfs_log_vec	*lv)
+{
+	struct xfs_sxi_log_item	*ilip = SXI_ITEM(lip);
+	struct xfs_log_iovec	*vecp = NULL;
+
+	ilip->sxi_format.sxi_type = XFS_LI_SXI;
+	ilip->sxi_format.sxi_size = 1;
+
+	xlog_copy_iovec(lv, &vecp, XLOG_REG_TYPE_SXI_FORMAT, &ilip->sxi_format,
+			sizeof(struct xfs_sxi_log_format));
+}
+
+/*
+ * The unpin operation is the last place an SXI is manipulated in the log. It is
+ * either inserted in the AIL or aborted in the event of a log I/O error. In
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
+	struct xfs_sxi_log_item	*ilip = SXI_ITEM(lip);
+
+	xfs_sxi_release(ilip);
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
+static const struct xfs_item_ops xfs_sxi_item_ops = {
+	.iop_size	= xfs_sxi_item_size,
+	.iop_format	= xfs_sxi_item_format,
+	.iop_unpin	= xfs_sxi_item_unpin,
+	.iop_release	= xfs_sxi_item_release,
+};
+
+/*
+ * Allocate and initialize an sxi item with the given number of extents.
+ */
+STATIC struct xfs_sxi_log_item *
+xfs_sxi_init(
+	struct xfs_mount		*mp)
+
+{
+	struct xfs_sxi_log_item		*ilip;
+
+	ilip = kmem_zone_zalloc(xfs_sxi_zone, 0);
+
+	xfs_log_item_init(mp, &ilip->sxi_item, XFS_LI_SXI, &xfs_sxi_item_ops);
+	ilip->sxi_format.sxi_id = (uintptr_t)(void *)ilip;
+	atomic_set(&ilip->sxi_refcount, 2);
+
+	return ilip;
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
+ * This is called to fill in the vector of log iovecs for the
+ * given sxd log item. We use only 1 iovec, and we point that
+ * at the sxd_log_format structure embedded in the sxd item.
+ * It is at this point that we assert that all of the extent
+ * slots in the sxd item have been filled.
+ */
+STATIC void
+xfs_sxd_item_format(
+	struct xfs_log_item	*lip,
+	struct xfs_log_vec	*lv)
+{
+	struct xfs_sxd_log_item	*dlip = SXD_ITEM(lip);
+	struct xfs_log_iovec	*vecp = NULL;
+
+	dlip->sxd_format.sxd_type = XFS_LI_SXD;
+	dlip->sxd_format.sxd_size = 1;
+
+	xlog_copy_iovec(lv, &vecp, XLOG_REG_TYPE_SXD_FORMAT, &dlip->sxd_format,
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
+	struct xfs_sxd_log_item	*dlip = SXD_ITEM(lip);
+
+	xfs_sxi_release(dlip->sxd_intent_log_item);
+	kmem_cache_free(xfs_sxd_zone, dlip);
+}
+
+static const struct xfs_item_ops xfs_sxd_item_ops = {
+	.flags		= XFS_ITEM_RELEASE_WHEN_COMMITTED,
+	.iop_size	= xfs_sxd_item_size,
+	.iop_format	= xfs_sxd_item_format,
+	.iop_release	= xfs_sxd_item_release,
+};
+
+/*
+ * Process a swapext update intent item that was recovered from the log.
+ * We need to update some inode's bmbt.
+ */
+STATIC int
+xfs_sxi_recover(
+	struct xfs_mount		*mp,
+	struct xfs_defer_freezer	**dffp,
+	struct xfs_sxi_log_item		*ilip)
+{
+	return -EFSCORRUPTED;
+}
+
+/*
+ * Copy an SXI format buffer from the given buf, and into the destination
+ * SXI format structure.  The SXI/SXD items were designed not to need any
+ * special alignment handling.
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
+ * This routine is called to create an in-core extent swapext update
+ * item from the sxi format structure which was logged on disk.
+ * It allocates an in-core sxi, copies the extents from the format
+ * structure into it, and adds the sxi to the AIL with the given
+ * LSN.
+ */
+STATIC int
+xlog_recover_sxi(
+	struct xlog			*log,
+	struct xlog_recover_item	*item,
+	xfs_lsn_t			lsn)
+{
+	int				error;
+	struct xfs_mount		*mp = log->l_mp;
+	struct xfs_sxi_log_item		*ilip;
+	struct xfs_sxi_log_format	*sxi_formatp;
+
+	sxi_formatp = item->ri_buf[0].i_addr;
+
+	if (sxi_formatp->__pad != 0) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+	ilip = xfs_sxi_init(mp);
+	error = xfs_sxi_copy_format(&item->ri_buf[0], &ilip->sxi_format);
+	if (error) {
+		xfs_sxi_item_free(ilip);
+		return error;
+	}
+	xlog_recover_insert_ail(log, &ilip->sxi_item, lsn);
+	xfs_sxi_release(ilip);
+	return 0;
+}
+
+STATIC bool
+xlog_release_sxi(
+	struct xlog		*log,
+	struct xfs_log_item	*lip,
+	uint64_t		intent_id)
+{
+	struct xfs_sxi_log_item	*ilip = SXI_ITEM(lip);
+	struct xfs_ail		*ailp = log->l_ailp;
+
+	if (ilip->sxi_format.sxi_id == intent_id) {
+		/*
+		 * Drop the SXD reference to the SXI. This
+		 * removes the SXI from the AIL and frees it.
+		 */
+		spin_unlock(&ailp->ail_lock);
+		xfs_sxi_release(ilip);
+		spin_lock(&ailp->ail_lock);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * This routine is called when an SXD format structure is found in a committed
+ * transaction in the log. Its purpose is to cancel the corresponding SXI if it
+ * was still in the log. To do this it searches the AIL for the SXI with an id
+ * equal to that in the SXD format structure. If we find it we drop the SXD
+ * reference, which removes the SXI from the AIL and frees it.
+ */
+STATIC int
+xlog_recover_sxd(
+	struct xlog			*log,
+	struct xlog_recover_item	*item)
+{
+	struct xfs_sxd_log_format	*sxd_formatp;
+
+	sxd_formatp = item->ri_buf[0].i_addr;
+	if (item->ri_buf[0].i_len != sizeof(struct xfs_sxd_log_format)) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
+	xlog_recover_release_intent(log, XFS_LI_SXI, sxd_formatp->sxd_sxi_id,
+			 xlog_release_sxi);
+	return 0;
+}
+
+/* Recover the SXI if necessary. */
+STATIC int
+xlog_recover_process_sxi(
+	struct xlog			*log,
+	struct xfs_defer_freezer	**dffp,
+	struct xfs_log_item		*lip)
+{
+	struct xfs_ail			*ailp = log->l_ailp;
+	struct xfs_sxi_log_item		*ilip = SXI_ITEM(lip);
+	int				error;
+
+	/*
+	 * Skip SXIs that we've already processed.
+	 */
+	if (test_bit(XFS_SXI_RECOVERED, &ilip->sxi_flags))
+		return 0;
+
+	spin_unlock(&ailp->ail_lock);
+	error = xfs_sxi_recover(log->l_mp, dffp, ilip);
+	spin_lock(&ailp->ail_lock);
+
+	return error;
+}
+
+/* Release the SXI since we're cancelling everything. */
+STATIC void
+xlog_recover_cancel_sxi(
+	struct xfs_log_item		*lip)
+{
+	xfs_sxi_release(SXI_ITEM(lip));
+}
+
+const struct xlog_recover_intent_type xlog_recover_swapext_type = {
+	.recover_intent		= xlog_recover_sxi,
+	.recover_done		= xlog_recover_sxd,
+	.process_intent		= xlog_recover_process_sxi,
+	.cancel_intent		= xlog_recover_cancel_sxi,
+};
diff --git a/fs/xfs/xfs_swapext_item.h b/fs/xfs/xfs_swapext_item.h
new file mode 100644
index 000000000000..63e2c15d117d
--- /dev/null
+++ b/fs/xfs/xfs_swapext_item.h
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
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
+ * Define SXI flag bits. Manipulated by set/clear/test_bit operators.
+ */
+#define	XFS_SXI_RECOVERED		1
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
+	unsigned long			sxi_flags;
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

