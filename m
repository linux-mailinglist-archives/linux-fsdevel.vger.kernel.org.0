Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB4F63B704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 02:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiK2BV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 20:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiK2BVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:21:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A71240931;
        Mon, 28 Nov 2022 17:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 493B061356;
        Tue, 29 Nov 2022 01:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFA3C433C1;
        Tue, 29 Nov 2022 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669684878;
        bh=nDVt+11vimimGgPmn28oMbn4U3yRubU+C+8rSKam9+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLOHXBcxR8e61qwTQp0riHHwXZvZ5fQ4sZ0RNpzhl0Xkzc0uzhs1nPpZTw0oFmPas
         YWLbZ6/9w0Xo79g8SOFSO+Hfx/QomaBkBvLc4oXC0+KIs6HBMVAexgkAAilcayPL9C
         R/NO3CW5hJ6wbMcICD/JfA2DOvEcp8nCwa9GTcS5BM12BDDSLvDrvLwfE+AfeaK8ys
         naZcoox5lJouV8b/h8RUVMf8GN2OvsVtyWBs6ZiSFOgaFk9FUOJI43JqntJgFm068x
         JsoGj0RL3hOPxRnmmu7k66S9RIlL1kUOjZM8yw7MZADVHTlYtGkZjoeG137fd/sCkL
         WDhQgcrAv+25g==
Date:   Mon, 28 Nov 2022 17:21:18 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/9] xfs: add debug knob to slow down writeback for fun
Message-ID: <Y4VejsHGU/tZuRYs@magnolia>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3XWf5j1zVGvV4@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4U3XWf5j1zVGvV4@magnolia>
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
v2: this time with tracepoints
---
 fs/xfs/libxfs/xfs_errortag.h |    4 +++-
 fs/xfs/xfs_aops.c            |   14 +++++++++++--
 fs/xfs/xfs_error.c           |   11 +++++++++++
 fs/xfs/xfs_error.h           |   12 +++++++++++
 fs/xfs/xfs_trace.c           |    2 ++
 fs/xfs/xfs_trace.h           |   44 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 84 insertions(+), 3 deletions(-)

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
index a22d90af40c8..41734202796f 100644
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
@@ -217,11 +219,17 @@ xfs_imap_valid(
 	 * checked (and found nothing at this offset) could have added
 	 * overlapping blocks.
 	 */
-	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq))
+	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq)) {
+		trace_xfs_wb_data_iomap_invalid(ip, &wpc->iomap,
+				XFS_WPC(wpc)->data_seq, XFS_DATA_FORK);
 		return false;
+	}
 	if (xfs_inode_has_cow_data(ip) &&
-	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
+	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq)) {
+		trace_xfs_wb_cow_iomap_invalid(ip, &wpc->iomap,
+				XFS_WPC(wpc)->cow_seq, XFS_COW_FORK);
 		return false;
+	}
 	return true;
 }
 
@@ -285,6 +293,8 @@ xfs_map_blocks(
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
index 5191e9145e55..936d0c52d6af 100644
--- a/fs/xfs/xfs_error.h
+++ b/fs/xfs/xfs_error.h
@@ -45,6 +45,17 @@ extern bool xfs_errortag_test(struct xfs_mount *mp, const char *expression,
 		const char *file, int line, unsigned int error_tag);
 #define XFS_TEST_ERROR(expr, mp, tag)		\
 	((expr) || xfs_errortag_test((mp), #expr, __FILE__, __LINE__, (tag)))
+bool xfs_errortag_enabled(struct xfs_mount *mp, unsigned int tag);
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
@@ -55,6 +66,7 @@ extern int xfs_errortag_clearall(struct xfs_mount *mp);
 #define xfs_errortag_init(mp)			(0)
 #define xfs_errortag_del(mp)
 #define XFS_TEST_ERROR(expr, mp, tag)		(expr)
+#define XFS_ERRORTAG_DELAY(mp, tag)		((void)0)
 #define xfs_errortag_set(mp, tag, val)		(ENOSYS)
 #define xfs_errortag_add(mp, tag)		(ENOSYS)
 #define xfs_errortag_clearall(mp)		(ENOSYS)
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index d269ef57ff01..8a5dc1538aa8 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -34,6 +34,8 @@
 #include "xfs_ag.h"
 #include "xfs_ag_resv.h"
 #include "xfs_error.h"
+#include <linux/iomap.h>
+#include "xfs_iomap.h"
 
 /*
  * We include this last to have the helpers above available for the trace
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 372d871bccc5..c9ada9577a4a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -3352,6 +3352,50 @@ DEFINE_EVENT(xfs_inode_irec_class, name, \
 	TP_PROTO(struct xfs_inode *ip, struct xfs_bmbt_irec *irec), \
 	TP_ARGS(ip, irec))
 
+/* inode iomap invalidation events */
+DECLARE_EVENT_CLASS(xfs_wb_invalid_class,
+	TP_PROTO(struct xfs_inode *ip, const struct iomap *iomap, unsigned int wpcseq, int whichfork),
+	TP_ARGS(ip, iomap, wpcseq, whichfork),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(u64, addr)
+		__field(loff_t, pos)
+		__field(u64, len)
+		__field(u16, type)
+		__field(u16, flags)
+		__field(u32, wpcseq)
+		__field(u32, forkseq)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->addr = iomap->addr;
+		__entry->pos = iomap->offset;
+		__entry->len = iomap->length;
+		__entry->type = iomap->type;
+		__entry->flags = iomap->flags;
+		__entry->wpcseq = wpcseq;
+		__entry->forkseq = READ_ONCE(xfs_ifork_ptr(ip, whichfork)->if_seq);
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx addr 0x%llx bytecount 0x%llx type 0x%x flags 0x%x wpcseq 0x%x forkseq 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->addr,
+		  __entry->len,
+		  __entry->type,
+		  __entry->flags,
+		  __entry->wpcseq,
+		  __entry->forkseq)
+);
+#define DEFINE_WB_INVALID_EVENT(name) \
+DEFINE_EVENT(xfs_wb_invalid_class, name, \
+	TP_PROTO(struct xfs_inode *ip, const struct iomap *iomap, unsigned int wpcseq, int whichfork), \
+	TP_ARGS(ip, iomap, wpcseq, whichfork))
+DEFINE_WB_INVALID_EVENT(xfs_wb_cow_iomap_invalid);
+DEFINE_WB_INVALID_EVENT(xfs_wb_data_iomap_invalid);
+
 /* refcount/reflink tracepoint definitions */
 
 /* reflink tracepoints */
