Return-Path: <linux-fsdevel+bounces-16395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2D89D120
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862381F224AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2C762D7;
	Tue,  9 Apr 2024 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hximWz0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362B176020;
	Tue,  9 Apr 2024 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633734; cv=none; b=i0kNHD4T1Ivgr1C6PnLaR4DNH2i+23CM68V8uYWszOFf0gh/y5LdVbtlNL6S8JoZM2n9PDbJhE3q+vhIvNnQinzOpmqlbpGoTpXBSa5dPOaq3JwDQQHw5A/Co1kMVhYif4nEdJCDGZc3mUJD3uRlc7JeuxfNpkACY03fI/RNG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633734; c=relaxed/simple;
	bh=/T/+lnC3XEpgri6CNiiedNoumwtsXZBBL6SyXUKzzKk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjbLlKlHpeWkBZN1tyo/Qtgc35GuOGWMzR/8ZnWgzntO3Webv4BA47Aum8h+e845bW2CqL9XMG6OuBh2h4PiAr4G7HF6f19a6im/WODuy6akVDH+qJYoL6fAnlMHAaUjxrhUwSSGvaXVeDNC/8LrfLmqvgcrIiEmDaLbl59i57k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hximWz0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3979C433C7;
	Tue,  9 Apr 2024 03:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633733;
	bh=/T/+lnC3XEpgri6CNiiedNoumwtsXZBBL6SyXUKzzKk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hximWz0bCC5EijXR9uXwIG34Cad9zibjxu6rN9U4pXCFzRjTqFnHDSjgMVJU+riHJ
	 XQfTgFCE3t7BycXUcw/bPikRF3XraPi4G6Uq5+K+dGb2TCACSWu+MQH0G6gFCmLtQf
	 tXORLcOCf2u8sQVl9KnQoHmbfcuOHFumb7wcQAuxeVcLviHl4lDCCytRI6Z1/VKIuW
	 rWmqLew6w1QZ6ZDu3Jhoexl1MemX6wDkjq2uc5vBFxd6WO1506rs7uCiIpev/GSJIe
	 4meWrU5IoDuO0qzbZC4sxh18BPcwZY+YiIym2G68L5nG5JNXX8bpFulMtKR275y3wH
	 JIps5bNrLy3HQ==
Date: Mon, 08 Apr 2024 20:35:33 -0700
Subject: [PATCH 04/14] xfs: introduce a file mapping exchange log intent item
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348528.2978056.1607981222814313504.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Introduce a new intent log item to handle exchanging mappings between
the forks of two files.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/Makefile                 |    1 
 fs/xfs/libxfs/xfs_log_format.h  |   42 ++++++-
 fs/xfs/libxfs/xfs_log_recover.h |    2 
 fs/xfs/xfs_exchmaps_item.c      |  235 +++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_exchmaps_item.h      |   59 ++++++++++
 fs/xfs/xfs_log_recover.c        |    2 
 fs/xfs/xfs_super.c              |   19 +++
 7 files changed, 357 insertions(+), 3 deletions(-)
 create mode 100644 fs/xfs/xfs_exchmaps_item.c
 create mode 100644 fs/xfs/xfs_exchmaps_item.h


diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 2474242f5a05f..68ca9726e7b7d 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -102,6 +102,7 @@ xfs-y				+= xfs_log.o \
 				   xfs_buf_item.o \
 				   xfs_buf_item_recover.o \
 				   xfs_dquot_item_recover.o \
+				   xfs_exchmaps_item.o \
 				   xfs_extfree_item.o \
 				   xfs_attr_item.o \
 				   xfs_icreate_item.o \
diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 16872972e1e97..09024431cae9a 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -117,8 +117,9 @@ struct xfs_unmount_log_format {
 #define XLOG_REG_TYPE_ATTRD_FORMAT	28
 #define XLOG_REG_TYPE_ATTR_NAME	29
 #define XLOG_REG_TYPE_ATTR_VALUE	30
-#define XLOG_REG_TYPE_MAX		30
-
+#define XLOG_REG_TYPE_XMI_FORMAT	31
+#define XLOG_REG_TYPE_XMD_FORMAT	32
+#define XLOG_REG_TYPE_MAX		32
 
 /*
  * Flags to log operation header
@@ -243,6 +244,8 @@ typedef struct xfs_trans_header {
 #define	XFS_LI_BUD		0x1245
 #define	XFS_LI_ATTRI		0x1246  /* attr set/remove intent*/
 #define	XFS_LI_ATTRD		0x1247  /* attr set/remove done */
+#define	XFS_LI_XMI		0x1248  /* mapping exchange intent */
+#define	XFS_LI_XMD		0x1249  /* mapping exchange done */
 
 #define XFS_LI_TYPE_DESC \
 	{ XFS_LI_EFI,		"XFS_LI_EFI" }, \
@@ -260,7 +263,9 @@ typedef struct xfs_trans_header {
 	{ XFS_LI_BUI,		"XFS_LI_BUI" }, \
 	{ XFS_LI_BUD,		"XFS_LI_BUD" }, \
 	{ XFS_LI_ATTRI,		"XFS_LI_ATTRI" }, \
-	{ XFS_LI_ATTRD,		"XFS_LI_ATTRD" }
+	{ XFS_LI_ATTRD,		"XFS_LI_ATTRD" }, \
+	{ XFS_LI_XMI,		"XFS_LI_XMI" }, \
+	{ XFS_LI_XMD,		"XFS_LI_XMD" }
 
 /*
  * Inode Log Item Format definitions.
@@ -878,6 +883,37 @@ struct xfs_bud_log_format {
 	uint64_t		bud_bui_id;	/* id of corresponding bui */
 };
 
+/*
+ * XMI/XMD (file mapping exchange) log format definitions
+ */
+
+/* This is the structure used to lay out an mapping exchange log item. */
+struct xfs_xmi_log_format {
+	uint16_t		xmi_type;	/* xmi log item type */
+	uint16_t		xmi_size;	/* size of this item */
+	uint32_t		__pad;		/* must be zero */
+	uint64_t		xmi_id;		/* xmi identifier */
+
+	uint64_t		xmi_inode1;	/* inumber of first file */
+	uint64_t		xmi_inode2;	/* inumber of second file */
+	uint64_t		xmi_startoff1;	/* block offset into file1 */
+	uint64_t		xmi_startoff2;	/* block offset into file2 */
+	uint64_t		xmi_blockcount;	/* number of blocks */
+	uint64_t		xmi_flags;	/* XFS_EXCHMAPS_* */
+	uint64_t		xmi_isize1;	/* intended file1 size */
+	uint64_t		xmi_isize2;	/* intended file2 size */
+};
+
+#define XFS_EXCHMAPS_LOGGED_FLAGS		(0)
+
+/* This is the structure used to lay out an mapping exchange done log item. */
+struct xfs_xmd_log_format {
+	uint16_t		xmd_type;	/* xmd log item type */
+	uint16_t		xmd_size;	/* size of this item */
+	uint32_t		__pad;
+	uint64_t		xmd_xmi_id;	/* id of corresponding xmi */
+};
+
 /*
  * Dquot Log format definitions.
  *
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 9fe7a9564bca9..47b758b49cb35 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -75,6 +75,8 @@ extern const struct xlog_recover_item_ops xlog_cui_item_ops;
 extern const struct xlog_recover_item_ops xlog_cud_item_ops;
 extern const struct xlog_recover_item_ops xlog_attri_item_ops;
 extern const struct xlog_recover_item_ops xlog_attrd_item_ops;
+extern const struct xlog_recover_item_ops xlog_xmi_item_ops;
+extern const struct xlog_recover_item_ops xlog_xmd_item_ops;
 
 /*
  * Macros, structures, prototypes for internal log manager use.
diff --git a/fs/xfs/xfs_exchmaps_item.c b/fs/xfs/xfs_exchmaps_item.c
new file mode 100644
index 0000000000000..65b0ade41b3d6
--- /dev/null
+++ b/fs/xfs/xfs_exchmaps_item.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020-2024 Oracle.  All Rights Reserved.
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
+#include "xfs_exchmaps_item.h"
+#include "xfs_log.h"
+#include "xfs_bmap.h"
+#include "xfs_icache.h"
+#include "xfs_trans_space.h"
+#include "xfs_error.h"
+#include "xfs_log_priv.h"
+#include "xfs_log_recover.h"
+
+struct kmem_cache	*xfs_xmi_cache;
+struct kmem_cache	*xfs_xmd_cache;
+
+static const struct xfs_item_ops xfs_xmi_item_ops;
+
+static inline struct xfs_xmi_log_item *XMI_ITEM(struct xfs_log_item *lip)
+{
+	return container_of(lip, struct xfs_xmi_log_item, xmi_item);
+}
+
+STATIC void
+xfs_xmi_item_free(
+	struct xfs_xmi_log_item	*xmi_lip)
+{
+	kvfree(xmi_lip->xmi_item.li_lv_shadow);
+	kmem_cache_free(xfs_xmi_cache, xmi_lip);
+}
+
+/*
+ * Freeing the XMI requires that we remove it from the AIL if it has already
+ * been placed there. However, the XMI may not yet have been placed in the AIL
+ * when called by xfs_xmi_release() from XMD processing due to the ordering of
+ * committed vs unpin operations in bulk insert operations. Hence the reference
+ * count to ensure only the last caller frees the XMI.
+ */
+STATIC void
+xfs_xmi_release(
+	struct xfs_xmi_log_item	*xmi_lip)
+{
+	ASSERT(atomic_read(&xmi_lip->xmi_refcount) > 0);
+	if (atomic_dec_and_test(&xmi_lip->xmi_refcount)) {
+		xfs_trans_ail_delete(&xmi_lip->xmi_item, 0);
+		xfs_xmi_item_free(xmi_lip);
+	}
+}
+
+
+STATIC void
+xfs_xmi_item_size(
+	struct xfs_log_item	*lip,
+	int			*nvecs,
+	int			*nbytes)
+{
+	*nvecs += 1;
+	*nbytes += sizeof(struct xfs_xmi_log_format);
+}
+
+/*
+ * This is called to fill in the vector of log iovecs for the given xmi log
+ * item. We use only 1 iovec, and we point that at the xmi_log_format structure
+ * embedded in the xmi item.
+ */
+STATIC void
+xfs_xmi_item_format(
+	struct xfs_log_item	*lip,
+	struct xfs_log_vec	*lv)
+{
+	struct xfs_xmi_log_item	*xmi_lip = XMI_ITEM(lip);
+	struct xfs_log_iovec	*vecp = NULL;
+
+	xmi_lip->xmi_format.xmi_type = XFS_LI_XMI;
+	xmi_lip->xmi_format.xmi_size = 1;
+
+	xlog_copy_iovec(lv, &vecp, XLOG_REG_TYPE_XMI_FORMAT,
+			&xmi_lip->xmi_format,
+			sizeof(struct xfs_xmi_log_format));
+}
+
+/*
+ * The unpin operation is the last place an XMI is manipulated in the log. It
+ * is either inserted in the AIL or aborted in the event of a log I/O error. In
+ * either case, the XMI transaction has been successfully committed to make it
+ * this far. Therefore, we expect whoever committed the XMI to either construct
+ * and commit the XMD or drop the XMD's reference in the event of error. Simply
+ * drop the log's XMI reference now that the log is done with it.
+ */
+STATIC void
+xfs_xmi_item_unpin(
+	struct xfs_log_item	*lip,
+	int			remove)
+{
+	struct xfs_xmi_log_item	*xmi_lip = XMI_ITEM(lip);
+
+	xfs_xmi_release(xmi_lip);
+}
+
+/*
+ * The XMI has been either committed or aborted if the transaction has been
+ * cancelled. If the transaction was cancelled, an XMD isn't going to be
+ * constructed and thus we free the XMI here directly.
+ */
+STATIC void
+xfs_xmi_item_release(
+	struct xfs_log_item	*lip)
+{
+	xfs_xmi_release(XMI_ITEM(lip));
+}
+
+/* Allocate and initialize an xmi item. */
+STATIC struct xfs_xmi_log_item *
+xfs_xmi_init(
+	struct xfs_mount	*mp)
+
+{
+	struct xfs_xmi_log_item	*xmi_lip;
+
+	xmi_lip = kmem_cache_zalloc(xfs_xmi_cache, GFP_KERNEL | __GFP_NOFAIL);
+
+	xfs_log_item_init(mp, &xmi_lip->xmi_item, XFS_LI_XMI, &xfs_xmi_item_ops);
+	xmi_lip->xmi_format.xmi_id = (uintptr_t)(void *)xmi_lip;
+	atomic_set(&xmi_lip->xmi_refcount, 2);
+
+	return xmi_lip;
+}
+
+static inline struct xfs_xmd_log_item *XMD_ITEM(struct xfs_log_item *lip)
+{
+	return container_of(lip, struct xfs_xmd_log_item, xmd_item);
+}
+
+STATIC bool
+xfs_xmi_item_match(
+	struct xfs_log_item	*lip,
+	uint64_t		intent_id)
+{
+	return XMI_ITEM(lip)->xmi_format.xmi_id == intent_id;
+}
+
+static const struct xfs_item_ops xfs_xmi_item_ops = {
+	.flags		= XFS_ITEM_INTENT,
+	.iop_size	= xfs_xmi_item_size,
+	.iop_format	= xfs_xmi_item_format,
+	.iop_unpin	= xfs_xmi_item_unpin,
+	.iop_release	= xfs_xmi_item_release,
+	.iop_match	= xfs_xmi_item_match,
+};
+
+/*
+ * This routine is called to create an in-core file mapping exchange item from
+ * the xmi format structure which was logged on disk.  It allocates an in-core
+ * xmi, copies the exchange information from the format structure into it, and
+ * adds the xmi to the AIL with the given LSN.
+ */
+STATIC int
+xlog_recover_xmi_commit_pass2(
+	struct xlog			*log,
+	struct list_head		*buffer_list,
+	struct xlog_recover_item	*item,
+	xfs_lsn_t			lsn)
+{
+	struct xfs_mount		*mp = log->l_mp;
+	struct xfs_xmi_log_item		*xmi_lip;
+	struct xfs_xmi_log_format	*xmi_formatp;
+	size_t				len;
+
+	len = sizeof(struct xfs_xmi_log_format);
+	if (item->ri_buf[0].i_len != len) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
+	xmi_formatp = item->ri_buf[0].i_addr;
+	if (xmi_formatp->__pad != 0) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
+	xmi_lip = xfs_xmi_init(mp);
+	memcpy(&xmi_lip->xmi_format, xmi_formatp, len);
+
+	/* not implemented yet */
+	return -EIO;
+}
+
+const struct xlog_recover_item_ops xlog_xmi_item_ops = {
+	.item_type		= XFS_LI_XMI,
+	.commit_pass2		= xlog_recover_xmi_commit_pass2,
+};
+
+/*
+ * This routine is called when an XMD format structure is found in a committed
+ * transaction in the log. Its purpose is to cancel the corresponding XMI if it
+ * was still in the log. To do this it searches the AIL for the XMI with an id
+ * equal to that in the XMD format structure. If we find it we drop the XMD
+ * reference, which removes the XMI from the AIL and frees it.
+ */
+STATIC int
+xlog_recover_xmd_commit_pass2(
+	struct xlog			*log,
+	struct list_head		*buffer_list,
+	struct xlog_recover_item	*item,
+	xfs_lsn_t			lsn)
+{
+	struct xfs_xmd_log_format	*xmd_formatp;
+
+	xmd_formatp = item->ri_buf[0].i_addr;
+	if (item->ri_buf[0].i_len != sizeof(struct xfs_xmd_log_format)) {
+		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, log->l_mp);
+		return -EFSCORRUPTED;
+	}
+
+	xlog_recover_release_intent(log, XFS_LI_XMI, xmd_formatp->xmd_xmi_id);
+	return 0;
+}
+
+const struct xlog_recover_item_ops xlog_xmd_item_ops = {
+	.item_type		= XFS_LI_XMD,
+	.commit_pass2		= xlog_recover_xmd_commit_pass2,
+};
diff --git a/fs/xfs/xfs_exchmaps_item.h b/fs/xfs/xfs_exchmaps_item.h
new file mode 100644
index 0000000000000..ada1eb314e658
--- /dev/null
+++ b/fs/xfs/xfs_exchmaps_item.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2020-2024 Oracle.  All Rights Reserved.
+ * Author: Darrick J. Wong <djwong@kernel.org>
+ */
+#ifndef	__XFS_EXCHMAPS_ITEM_H__
+#define	__XFS_EXCHMAPS_ITEM_H__
+
+/*
+ * The file mapping exchange intent item helps us exchange multiple file
+ * mappings between two inode forks.  It does this by tracking the range of
+ * file block offsets that still need to be exchanged, and relogs as progress
+ * happens.
+ *
+ * *I items should be recorded in the *first* of a series of rolled
+ * transactions, and the *D items should be recorded in the same transaction
+ * that records the associated bmbt updates.
+ *
+ * Should the system crash after the commit of the first transaction but
+ * before the commit of the final transaction in a series, log recovery will
+ * use the redo information recorded by the intent items to replay the
+ * rest of the mapping exchanges.
+ */
+
+/* kernel only XMI/XMD definitions */
+
+struct xfs_mount;
+struct kmem_cache;
+
+/*
+ * This is the incore file mapping exchange intent log item.  It is used to log
+ * the fact that we are exchanging mappings between two files.  It is used in
+ * conjunction with the incore file mapping exchange done log item described
+ * below.
+ *
+ * These log items follow the same rules as struct xfs_efi_log_item; see the
+ * comments about that structure (in xfs_extfree_item.h) for more details.
+ */
+struct xfs_xmi_log_item {
+	struct xfs_log_item		xmi_item;
+	atomic_t			xmi_refcount;
+	struct xfs_xmi_log_format	xmi_format;
+};
+
+/*
+ * This is the incore file mapping exchange done log item.  It is used to log
+ * the fact that an exchange mentioned in an earlier xmi item have been
+ * performed.
+ */
+struct xfs_xmd_log_item {
+	struct xfs_log_item		xmd_item;
+	struct xfs_xmi_log_item		*xmd_intent_log_item;
+	struct xfs_xmd_log_format	xmd_format;
+};
+
+extern struct kmem_cache	*xfs_xmi_cache;
+extern struct kmem_cache	*xfs_xmd_cache;
+
+#endif	/* __XFS_EXCHMAPS_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 41aec991433c5..1e5ba95adf2c7 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1789,6 +1789,8 @@ static const struct xlog_recover_item_ops *xlog_recover_item_ops[] = {
 	&xlog_bud_item_ops,
 	&xlog_attri_item_ops,
 	&xlog_attrd_item_ops,
+	&xlog_xmi_item_ops,
+	&xlog_xmd_item_ops,
 };
 
 static const struct xlog_recover_item_ops *
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index ab640055e07f4..7425a120c8f90 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -43,6 +43,7 @@
 #include "xfs_iunlink_item.h"
 #include "xfs_dahash_test.h"
 #include "xfs_rtbitmap.h"
+#include "xfs_exchmaps_item.h"
 #include "scrub/stats.h"
 #include "scrub/rcbag_btree.h"
 
@@ -2199,8 +2200,24 @@ xfs_init_caches(void)
 	if (!xfs_iunlink_cache)
 		goto out_destroy_attri_cache;
 
+	xfs_xmd_cache = kmem_cache_create("xfs_xmd_item",
+					 sizeof(struct xfs_xmd_log_item),
+					 0, 0, NULL);
+	if (!xfs_xmd_cache)
+		goto out_destroy_iul_cache;
+
+	xfs_xmi_cache = kmem_cache_create("xfs_xmi_item",
+					 sizeof(struct xfs_xmi_log_item),
+					 0, 0, NULL);
+	if (!xfs_xmi_cache)
+		goto out_destroy_xmd_cache;
+
 	return 0;
 
+ out_destroy_xmd_cache:
+	kmem_cache_destroy(xfs_xmd_cache);
+ out_destroy_iul_cache:
+	kmem_cache_destroy(xfs_iunlink_cache);
  out_destroy_attri_cache:
 	kmem_cache_destroy(xfs_attri_cache);
  out_destroy_attrd_cache:
@@ -2257,6 +2274,8 @@ xfs_destroy_caches(void)
 	 * destroy caches.
 	 */
 	rcu_barrier();
+	kmem_cache_destroy(xfs_xmd_cache);
+	kmem_cache_destroy(xfs_xmi_cache);
 	kmem_cache_destroy(xfs_iunlink_cache);
 	kmem_cache_destroy(xfs_attri_cache);
 	kmem_cache_destroy(xfs_attrd_cache);


