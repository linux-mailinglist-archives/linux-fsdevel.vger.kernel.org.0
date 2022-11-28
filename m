Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF69D63B4D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 23:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiK1WeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 17:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiK1WeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:34:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C72409D;
        Mon, 28 Nov 2022 14:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3445DB8101B;
        Mon, 28 Nov 2022 22:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B3CC433D7;
        Mon, 28 Nov 2022 22:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669674845;
        bh=T8OED8edUGtVfhFZW3NCzxU1ahstev0rAsxeR2AWyVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izmL41XHv0mGhteSgkrw82gubpQli6FVNPt8Fdi+P3kupU6/lz/qS7G1gCVKNO2/G
         1qPMNFT1qvaYsul4d1AVXuwGmCnaQn5KOmTkPvYWgb3m2SZiVZlTnTvOSDjxX4yXdq
         qa5nyDUUexPGJPcmTJu07fr/pWFAF11Q2lDS2gzW+t7eiryGWRTu7FDPyR9IfRc682
         w7I0mNMtnwzTw7BsLiqXbSaq2jPrTpUNK8q1Y8HrOzEhcdt7+z+ENest4DbHIUsZIa
         RxfXo9g2ShvOPFcajWjqGL3wqQDLwzV5CV43PbY6ynQd4JxLSVfad+VBYo6fTC8+JY
         nn7W/gyDUm68Q==
Date:   Mon, 28 Nov 2022 14:34:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/9] xfs: add debug knob to slow down writeback for fun
Message-ID: <Y4U3XWf5j1zVGvV4@magnolia>
References: <20221123055812.747923-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123055812.747923-1-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Add a new error injection knob so that we can arbitrarily slow down
writeback to test for race conditions and aberrant reclaim behavior if
the writeback mechanisms are slow to issue writeback.  This will enable
functional testing for the ifork sequence counters introduced in commit
745b3f76d1c8 ("xfs: maintain a sequence count for inode fork
manipulations").

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_errortag.h |    4 +++-
 fs/xfs/xfs_aops.c            |   12 ++++++++++--
 fs/xfs/xfs_error.c           |   11 +++++++++++
 fs/xfs/xfs_error.h           |   22 ++++++++++++++++++++++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 580ccbd5aadc..f5f629174eca 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -61,7 +61,8 @@
 #define XFS_ERRTAG_LARP					39
 #define XFS_ERRTAG_DA_LEAF_SPLIT			40
 #define XFS_ERRTAG_ATTR_LEAF_TO_NODE			41
-#define XFS_ERRTAG_MAX					42
+#define XFS_ERRTAG_WB_DELAY_MS				42
+#define XFS_ERRTAG_MAX					43
 
 /*
  * Random factors for above tags, 1 means always, 2 means 1/2 time, etc.
@@ -107,5 +108,6 @@
 #define XFS_RANDOM_LARP					1
 #define XFS_RANDOM_DA_LEAF_SPLIT			1
 #define XFS_RANDOM_ATTR_LEAF_TO_NODE			1
+#define XFS_RANDOM_WB_DELAY_MS				3000
 
 #endif /* __XFS_ERRORTAG_H_ */
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a22d90af40c8..4a13260527b9 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -17,6 +17,8 @@
 #include "xfs_bmap.h"
 #include "xfs_bmap_util.h"
 #include "xfs_reflink.h"
+#include "xfs_errortag.h"
+#include "xfs_error.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -217,11 +219,15 @@ xfs_imap_valid(
 	 * checked (and found nothing at this offset) could have added
 	 * overlapping blocks.
 	 */
-	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq))
+	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq)) {
+		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WB_DELAY_MS);
 		return false;
+	}
 	if (xfs_inode_has_cow_data(ip) &&
-	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
+	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq)) {
+		XFS_ERRORTAG_REPORT(ip->i_mount, XFS_ERRTAG_WB_DELAY_MS);
 		return false;
+	}
 	return true;
 }
 
@@ -285,6 +291,8 @@ xfs_map_blocks(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	XFS_ERRORTAG_DELAY(mp, XFS_ERRTAG_WB_DELAY_MS);
+
 	/*
 	 * COW fork blocks can overlap data fork blocks even if the blocks
 	 * aren't shared.  COW I/O always takes precedent, so we must always
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index dea3c0649d2f..13ac52e7f9e5 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -60,6 +60,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	XFS_RANDOM_LARP,
 	XFS_RANDOM_DA_LEAF_SPLIT,
 	XFS_RANDOM_ATTR_LEAF_TO_NODE,
+	XFS_RANDOM_WB_DELAY_MS,
 };
 
 struct xfs_errortag_attr {
@@ -175,6 +176,7 @@ XFS_ERRORTAG_ATTR_RW(ag_resv_fail, XFS_ERRTAG_AG_RESV_FAIL);
 XFS_ERRORTAG_ATTR_RW(larp,		XFS_ERRTAG_LARP);
 XFS_ERRORTAG_ATTR_RW(da_leaf_split,	XFS_ERRTAG_DA_LEAF_SPLIT);
 XFS_ERRORTAG_ATTR_RW(attr_leaf_to_node,	XFS_ERRTAG_ATTR_LEAF_TO_NODE);
+XFS_ERRORTAG_ATTR_RW(wb_delay_ms,	XFS_ERRTAG_WB_DELAY_MS);
 
 static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(noerror),
@@ -218,6 +220,7 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(larp),
 	XFS_ERRORTAG_ATTR_LIST(da_leaf_split),
 	XFS_ERRORTAG_ATTR_LIST(attr_leaf_to_node),
+	XFS_ERRORTAG_ATTR_LIST(wb_delay_ms),
 	NULL,
 };
 ATTRIBUTE_GROUPS(xfs_errortag);
@@ -267,6 +270,14 @@ xfs_errortag_valid(
 	return true;
 }
 
+bool
+xfs_errortag_enabled(
+	struct xfs_mount	*mp,
+	unsigned int		tag)
+{
+	return mp->m_errortag && mp->m_errortag[tag] != 0;
+}
+
 bool
 xfs_errortag_test(
 	struct xfs_mount	*mp,
diff --git a/fs/xfs/xfs_error.h b/fs/xfs/xfs_error.h
index 5191e9145e55..15baa5428e1a 100644
--- a/fs/xfs/xfs_error.h
+++ b/fs/xfs/xfs_error.h
@@ -45,6 +45,26 @@ extern bool xfs_errortag_test(struct xfs_mount *mp, const char *expression,
 		const char *file, int line, unsigned int error_tag);
 #define XFS_TEST_ERROR(expr, mp, tag)		\
 	((expr) || xfs_errortag_test((mp), #expr, __FILE__, __LINE__, (tag)))
+bool xfs_errortag_enabled(struct xfs_mount *mp, unsigned int tag);
+#define XFS_ERRORTAG_REPORT(mp, tag)		\
+	do { \
+		if (!xfs_errortag_enabled((mp), (tag))) \
+			break; \
+		xfs_warn((mp), \
+"Injected errortag (%s) set to %u at file %s, line %d, on filesystem \"%s\"", \
+				#tag, (mp)->m_errortag[(tag)], \
+				__FILE__, __LINE__, (mp)->m_super->s_id); \
+	} while (0)
+#define XFS_ERRORTAG_DELAY(mp, tag)		\
+	do { \
+		if (!xfs_errortag_enabled((mp), (tag))) \
+			break; \
+		xfs_warn_ratelimited((mp), \
+"Injecting %ums delay at file %s, line %d, on filesystem \"%s\"", \
+				(mp)->m_errortag[(tag)], __FILE__, __LINE__, \
+				(mp)->m_super->s_id); \
+		mdelay((mp)->m_errortag[(tag)]); \
+	} while (0)
 
 extern int xfs_errortag_get(struct xfs_mount *mp, unsigned int error_tag);
 extern int xfs_errortag_set(struct xfs_mount *mp, unsigned int error_tag,
@@ -55,6 +75,8 @@ extern int xfs_errortag_clearall(struct xfs_mount *mp);
 #define xfs_errortag_init(mp)			(0)
 #define xfs_errortag_del(mp)
 #define XFS_TEST_ERROR(expr, mp, tag)		(expr)
+#define XFS_ERRORTAG_REPORT(mp, tag)		((void)0)
+#define XFS_ERRORTAG_DELAY(mp, tag)		((void)0)
 #define xfs_errortag_set(mp, tag, val)		(ENOSYS)
 #define xfs_errortag_add(mp, tag)		(ENOSYS)
 #define xfs_errortag_clearall(mp)		(ENOSYS)
