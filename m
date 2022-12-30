Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46782659ECD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiL3Xvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiL3Xvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:51:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1F8FC2;
        Fri, 30 Dec 2022 15:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F75F61B98;
        Fri, 30 Dec 2022 23:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71633C433EF;
        Fri, 30 Dec 2022 23:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444302;
        bh=8w0KrGvFUuIxoZdeLwDguV5toFy9tFeYMYThtVUxXHE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aijH4cJ4SdnCd9aU+BQo/VGGfs0U6q5JFcwD6j6jDNnGlmfoKl4ZfCxXCbnwhwT7u
         8yjG1B32QAR8lQYMKS7fowoyhTQ+UTpmm6ciOFBO/vYnfox3m8SMSJjAEGMVCAa3cg
         l6dWPogSST5t0ZUuIZE7l+zHuqArQl2ziA3xkb7GQS4E2Uciyx8E4av99duLz7HD6v
         aGuzEEIu5TmWKD8H2LhoMOuVBxC8mvF5TPSQPUxxnexMNlb9/i2OVlcqIEQRXOYu5I
         5wGWhJvHDfNHCEBQ7uMtvCLFhQtEvqmPwQMkPm4q99Sy+35tfNsmvzMYJg1RJ6PWGy
         0kjEnyKD7Cj5g==
Subject: [PATCH 06/21] xfs: introduce a swap-extent log intent item
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:56 -0800
Message-ID: <167243843608.699466.6025805169564879348.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Introduce a new intent log item to handle swapping extents.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Makefile                 |    1 
 fs/xfs/libxfs/xfs_log_format.h  |   51 ++++++
 fs/xfs/libxfs/xfs_log_recover.h |    2 
 fs/xfs/xfs_log_recover.c        |    2 
 fs/xfs/xfs_super.c              |   19 ++
 fs/xfs/xfs_swapext_item.c       |  320 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_swapext_item.h       |   56 +++++++
 7 files changed, 448 insertions(+), 3 deletions(-)
 create mode 100644 fs/xfs/xfs_swapext_item.c
 create mode 100644 fs/xfs/xfs_swapext_item.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index fc83759656c6..c5cb8cf6ffbb 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -109,6 +109,7 @@ xfs-y				+= xfs_log.o \
 				   xfs_iunlink_item.o \
 				   xfs_refcount_item.o \
 				   xfs_rmap_item.o \
+				   xfs_swapext_item.o \
 				   xfs_log_recover.o \
 				   xfs_trans_ail.o \
 				   xfs_trans_buf.o
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 367f536d9881..b105a5ef6644 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -117,8 +117,9 @@ struct xfs_unmount_log_format {
 #define XLOG_REG_TYPE_ATTRD_FORMAT	28
 #define XLOG_REG_TYPE_ATTR_NAME	29
 #define XLOG_REG_TYPE_ATTR_VALUE	30
-#define XLOG_REG_TYPE_MAX		30
-
+#define XLOG_REG_TYPE_SXI_FORMAT	31
+#define XLOG_REG_TYPE_SXD_FORMAT	32
+#define XLOG_REG_TYPE_MAX		32
 
 /*
  * Flags to log operation header
@@ -243,6 +244,8 @@ typedef struct xfs_trans_header {
 #define	XFS_LI_BUD		0x1245
 #define	XFS_LI_ATTRI		0x1246  /* attr set/remove intent*/
 #define	XFS_LI_ATTRD		0x1247  /* attr set/remove done */
+#define	XFS_LI_SXI		0x1248  /* extent swap intent */
+#define	XFS_LI_SXD		0x1249  /* extent swap done */
 
 #define XFS_LI_TYPE_DESC \
 	{ XFS_LI_EFI,		"XFS_LI_EFI" }, \
@@ -260,7 +263,9 @@ typedef struct xfs_trans_header {
 	{ XFS_LI_BUI,		"XFS_LI_BUI" }, \
 	{ XFS_LI_BUD,		"XFS_LI_BUD" }, \
 	{ XFS_LI_ATTRI,		"XFS_LI_ATTRI" }, \
-	{ XFS_LI_ATTRD,		"XFS_LI_ATTRD" }
+	{ XFS_LI_ATTRD,		"XFS_LI_ATTRD" }, \
+	{ XFS_LI_SXI,		"XFS_LI_SXI" }, \
+	{ XFS_LI_SXD,		"XFS_LI_SXD" }
 
 /*
  * Inode Log Item Format definitions.
@@ -871,6 +876,46 @@ struct xfs_bud_log_format {
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
+#define XFS_SWAP_EXT_FLAGS		(0)
+
+#define XFS_SWAP_EXT_STRINGS
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
index 2420865f3007..6162c93b5d38 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -74,6 +74,8 @@ extern const struct xlog_recover_item_ops xlog_cui_item_ops;
 extern const struct xlog_recover_item_ops xlog_cud_item_ops;
 extern const struct xlog_recover_item_ops xlog_attri_item_ops;
 extern const struct xlog_recover_item_ops xlog_attrd_item_ops;
+extern const struct xlog_recover_item_ops xlog_sxi_item_ops;
+extern const struct xlog_recover_item_ops xlog_sxd_item_ops;
 
 /*
  * Macros, structures, prototypes for internal log manager use.
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 81ce08c23306..006ceff1959d 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1796,6 +1796,8 @@ static const struct xlog_recover_item_ops *xlog_recover_item_ops[] = {
 	&xlog_bud_item_ops,
 	&xlog_attri_item_ops,
 	&xlog_attrd_item_ops,
+	&xlog_sxi_item_ops,
+	&xlog_sxd_item_ops,
 };
 
 static const struct xlog_recover_item_ops *
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a16d4d1b35d0..4cf26611f46f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -42,6 +42,7 @@
 #include "xfs_xattr.h"
 #include "xfs_iunlink_item.h"
 #include "scrub/rcbag_btree.h"
+#include "xfs_swapext_item.h"
 
 #include <linux/magic.h>
 #include <linux/fs_context.h>
@@ -2122,8 +2123,24 @@ xfs_init_caches(void)
 	if (!xfs_iunlink_cache)
 		goto out_destroy_attri_cache;
 
+	xfs_sxd_cache = kmem_cache_create("xfs_sxd_item",
+					 sizeof(struct xfs_sxd_log_item),
+					 0, 0, NULL);
+	if (!xfs_sxd_cache)
+		goto out_destroy_iul_cache;
+
+	xfs_sxi_cache = kmem_cache_create("xfs_sxi_item",
+					 sizeof(struct xfs_sxi_log_item),
+					 0, 0, NULL);
+	if (!xfs_sxi_cache)
+		goto out_destroy_sxd_cache;
+
 	return 0;
 
+ out_destroy_sxd_cache:
+	kmem_cache_destroy(xfs_sxd_cache);
+ out_destroy_iul_cache:
+	kmem_cache_destroy(xfs_iunlink_cache);
  out_destroy_attri_cache:
 	kmem_cache_destroy(xfs_attri_cache);
  out_destroy_attrd_cache:
@@ -2180,6 +2197,8 @@ xfs_destroy_caches(void)
 	 * destroy caches.
 	 */
 	rcu_barrier();
+	kmem_cache_destroy(xfs_sxd_cache);
+	kmem_cache_destroy(xfs_sxi_cache);
 	kmem_cache_destroy(xfs_iunlink_cache);
 	kmem_cache_destroy(xfs_attri_cache);
 	kmem_cache_destroy(xfs_attrd_cache);
diff --git a/fs/xfs/xfs_swapext_item.c b/fs/xfs/xfs_swapext_item.c
new file mode 100644
index 000000000000..ea4a3a8de7e3
--- /dev/null
+++ b/fs/xfs/xfs_swapext_item.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 Oracle.  All Rights Reserved.
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
+struct kmem_cache	*xfs_sxi_cache;
+struct kmem_cache	*xfs_sxd_cache;
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
+	kmem_free(sxi_lip->sxi_item.li_lv_shadow);
+	kmem_cache_free(xfs_sxi_cache, sxi_lip);
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
+	struct xfs_mount	*mp)
+
+{
+	struct xfs_sxi_log_item	*sxi_lip;
+
+	sxi_lip = kmem_cache_zalloc(xfs_sxi_cache, GFP_KERNEL | __GFP_NOFAIL);
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
+	kmem_free(sxd_lip->sxd_item.li_lv_shadow);
+	xfs_sxi_release(sxd_lip->sxd_intent_log_item);
+	kmem_cache_free(xfs_sxd_cache, sxd_lip);
+}
+
+static struct xfs_log_item *
+xfs_sxd_item_intent(
+	struct xfs_log_item	*lip)
+{
+	return &SXD_ITEM(lip)->sxd_intent_log_item->sxi_item;
+}
+
+static const struct xfs_item_ops xfs_sxd_item_ops = {
+	.flags		= XFS_ITEM_RELEASE_WHEN_COMMITTED |
+			  XFS_ITEM_INTENT_DONE,
+	.iop_size	= xfs_sxd_item_size,
+	.iop_format	= xfs_sxd_item_format,
+	.iop_release	= xfs_sxd_item_release,
+	.iop_intent	= xfs_sxd_item_intent,
+};
+
+/* Process a swapext update intent item that was recovered from the log. */
+STATIC int
+xfs_sxi_item_recover(
+	struct xfs_log_item	*lip,
+	struct list_head	*capture_list)
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
+	struct xfs_log_item	*intent,
+	struct xfs_trans	*tp)
+{
+	ASSERT(0);
+	return NULL;
+}
+
+static const struct xfs_item_ops xfs_sxi_item_ops = {
+	.flags		= XFS_ITEM_INTENT,
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
+	struct xfs_mount		*mp = log->l_mp;
+	struct xfs_sxi_log_item		*sxi_lip;
+	struct xfs_sxi_log_format	*sxi_formatp;
+	size_t				len;
+
+	sxi_formatp = item->ri_buf[0].i_addr;
+
+	if (sxi_formatp->__pad != 0) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
+	len = sizeof(struct xfs_sxi_log_format);
+	if (item->ri_buf[0].i_len != len) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
+	sxi_lip = xfs_sxi_init(mp);
+	memcpy(&sxi_lip->sxi_format, sxi_formatp, len);
+
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
index 000000000000..e3cb59692e50
--- /dev/null
+++ b/fs/xfs/xfs_swapext_item.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2022 Oracle.  All Rights Reserved.
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
+struct kmem_cache;
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
+extern struct kmem_cache	*xfs_sxi_cache;
+extern struct kmem_cache	*xfs_sxd_cache;
+
+#endif	/* __XFS_SWAPEXT_ITEM_H__ */

