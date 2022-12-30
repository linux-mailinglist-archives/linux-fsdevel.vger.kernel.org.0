Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45515659E81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiL3XmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiL3XmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:42:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EAC1DF1A;
        Fri, 30 Dec 2022 15:42:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80A1361C31;
        Fri, 30 Dec 2022 23:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70E1C433EF;
        Fri, 30 Dec 2022 23:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672443726;
        bh=bmcf5Ciu1VeuaaKrB3UQb0SOVUyuNBT/v9QTl+XQDBc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B1sVqHBSe0AWk0dPRrXqx15SwKZ4R3vry4OXCxWH79PY7lDmpBbKaJcYLEr31cCTU
         WhVMuggv9DaP4mjqxHI/JN60i6GDdv3x4N6lkqgRxz+jlmDxxiPY69WZiuaIXIRTDr
         lu7muwIN0SaC9tX5Lqd5lMqtBDZwiP1r2MAAMM+5ejeSqgSAlCKs8K/f1VloZwvxw0
         04hwQwr9B/4HxXjHZtH56fAcmsGr4OR3KascOU2fcdkEAT917j0X5PhKGJfMJ0Ntk2
         VEaGZwNERa33ANoadFWDkuPCFHoDYpSczAsNzwWY12XyWC+JNPOIDCnqjiTUOQhwz6
         AORGWM0R/jVkw==
Subject: [PATCH 4/7] xfs: consolidate btree block freeing tracepoints
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:26 -0800
Message-ID: <167243840656.696535.17469067472257583534.stgit@magnolia>
In-Reply-To: <167243840589.696535.4812770109109400531.stgit@magnolia>
References: <167243840589.696535.4812770109109400531.stgit@magnolia>
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

Don't waste tracepoint segment memory on per-btree block freeing
tracepoints when we can do it from the generic btree code.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_btree.c          |    2 ++
 fs/xfs/libxfs/xfs_refcount_btree.c |    2 --
 fs/xfs/libxfs/xfs_rmap_btree.c     |    2 --
 fs/xfs/xfs_trace.h                 |   32 ++++++++++++++++++++++++++++++--
 4 files changed, 32 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 02c237984fa6..7fab2df1046f 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -414,6 +414,8 @@ xfs_btree_free_block(
 {
 	int			error;
 
+	trace_xfs_btree_free_block(cur, bp);
+
 	error = cur->bc_ops->free_block(cur, bp);
 	if (!error) {
 		xfs_trans_binval(cur->bc_tp, bp);
diff --git a/fs/xfs/libxfs/xfs_refcount_btree.c b/fs/xfs/libxfs/xfs_refcount_btree.c
index 1bf991bf452f..b1d1f3bb159f 100644
--- a/fs/xfs/libxfs/xfs_refcount_btree.c
+++ b/fs/xfs/libxfs/xfs_refcount_btree.c
@@ -108,8 +108,6 @@ xfs_refcountbt_free_block(
 	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, xfs_buf_daddr(bp));
 	int			error;
 
-	trace_xfs_refcountbt_free_block(cur->bc_mp, cur->bc_ag.pag->pag_agno,
-			XFS_FSB_TO_AGBNO(cur->bc_mp, fsbno), 1);
 	be32_add_cpu(&agf->agf_refcount_blocks, -1);
 	xfs_alloc_log_agf(cur->bc_tp, agbp, XFS_AGF_REFCOUNT_BLOCKS);
 	error = xfs_free_extent(cur->bc_tp, cur->bc_ag.pag,
diff --git a/fs/xfs/libxfs/xfs_rmap_btree.c b/fs/xfs/libxfs/xfs_rmap_btree.c
index 2c90a05ca814..1421fcfcad64 100644
--- a/fs/xfs/libxfs/xfs_rmap_btree.c
+++ b/fs/xfs/libxfs/xfs_rmap_btree.c
@@ -125,8 +125,6 @@ xfs_rmapbt_free_block(
 	int			error;
 
 	bno = xfs_daddr_to_agbno(cur->bc_mp, xfs_buf_daddr(bp));
-	trace_xfs_rmapbt_free_block(cur->bc_mp, pag->pag_agno,
-			bno, 1);
 	be32_add_cpu(&agf->agf_rmap_blocks, -1);
 	xfs_alloc_log_agf(cur->bc_tp, agbp, XFS_AGF_RMAP_BLOCKS);
 	error = xfs_alloc_put_freelist(pag, cur->bc_tp, agbp, NULL, bno, 1);
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 145808b733ce..50f4d4410976 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -2515,6 +2515,36 @@ DEFINE_EVENT(xfs_btree_cur_class, name, \
 DEFINE_BTREE_CUR_EVENT(xfs_btree_updkeys);
 DEFINE_BTREE_CUR_EVENT(xfs_btree_overlapped_query_range);
 
+TRACE_EVENT(xfs_btree_free_block,
+	TP_PROTO(struct xfs_btree_cur *cur, struct xfs_buf *bp),
+	TP_ARGS(cur, bp),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_agnumber_t, agno)
+		__field(xfs_ino_t, ino)
+		__field(xfs_btnum_t, btnum)
+		__field(xfs_agblock_t, agbno)
+	),
+	TP_fast_assign(
+		__entry->dev = cur->bc_mp->m_super->s_dev;
+		__entry->agno = xfs_daddr_to_agno(cur->bc_mp,
+							xfs_buf_daddr(bp));
+		if (cur->bc_flags & XFS_BTREE_ROOT_IN_INODE)
+			__entry->ino = cur->bc_ino.ip->i_ino;
+		else
+			__entry->ino = 0;
+		__entry->btnum = cur->bc_btnum;
+		__entry->agbno = xfs_daddr_to_agbno(cur->bc_mp,
+							xfs_buf_daddr(bp));
+	),
+	TP_printk("dev %d:%d btree %s agno 0x%x ino 0x%llx agbno 0x%x",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->btnum, XFS_BTNUM_STRINGS),
+		  __entry->agno,
+		  __entry->ino,
+		  __entry->agbno)
+);
+
 /* deferred ops */
 struct xfs_defer_pending;
 
@@ -2869,7 +2899,6 @@ DEFINE_RMAP_DEFERRED_EVENT(xfs_rmap_defer);
 DEFINE_RMAP_DEFERRED_EVENT(xfs_rmap_deferred);
 
 DEFINE_BUSY_EVENT(xfs_rmapbt_alloc_block);
-DEFINE_BUSY_EVENT(xfs_rmapbt_free_block);
 DEFINE_RMAPBT_EVENT(xfs_rmap_update);
 DEFINE_RMAPBT_EVENT(xfs_rmap_insert);
 DEFINE_RMAPBT_EVENT(xfs_rmap_delete);
@@ -3228,7 +3257,6 @@ DEFINE_EVENT(xfs_refcount_triple_extent_class, name, \
 
 /* refcount btree tracepoints */
 DEFINE_BUSY_EVENT(xfs_refcountbt_alloc_block);
-DEFINE_BUSY_EVENT(xfs_refcountbt_free_block);
 DEFINE_AG_BTREE_LOOKUP_EVENT(xfs_refcount_lookup);
 DEFINE_REFCOUNT_EXTENT_EVENT(xfs_refcount_get);
 DEFINE_REFCOUNT_EXTENT_EVENT(xfs_refcount_update);

