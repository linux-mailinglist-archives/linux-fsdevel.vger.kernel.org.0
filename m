Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE6659E83
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiL3Xma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiL3XmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:42:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D76120AF;
        Fri, 30 Dec 2022 15:42:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17C4561C4A;
        Fri, 30 Dec 2022 23:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7565BC433D2;
        Fri, 30 Dec 2022 23:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672443742;
        bh=CzmAfxjnTBpHpIgWJd1E8d4oBdW7inMzYCZWZKeLrEI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aV9/0DszgOhC+4Zwus9k9F7s8uWorAH6xNsyaTPTUZHXfaHiSNXKQsRVMB1HoJv2c
         NwHE8q5FeZ7B99BTUZdgLMHfqkllR9gnpa36Sg0ll0D7msaK5BoHlQbR7cEz/ry9Qt
         mrdk6LoGn1m3GqdPuMS8ES5ekopEFzvj9FWJTPUovzJID//ey8B+z7WYlJxQsk4xm3
         s+AKjyvvOfQg4Hds78jcFGSymxjSgjijmmnfSHY3Qsg3rpZnRrbjF2VX4eMsS4t3d0
         rJgkvwc9GJCwt1NR0JkIwRr4Ru4L0yQkdsZ5cz21S+8gJjFMtE5vZKcflmiNWbdi5j
         nqS3/vz5BCfrQ==
Subject: [PATCH 5/7] xfs: consolidate btree block allocation tracepoints
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:26 -0800
Message-ID: <167243840671.696535.5630839227413502256.stgit@magnolia>
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

Don't waste tracepoint segment memory on per-btree block allocation
tracepoints when we can do it from the generic btree code.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_btree.c          |   20 ++++++++++++---
 fs/xfs/libxfs/xfs_refcount_btree.c |    2 -
 fs/xfs/libxfs/xfs_rmap_btree.c     |    2 -
 fs/xfs/xfs_trace.h                 |   49 +++++++++++++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 9 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_btree.c b/fs/xfs/libxfs/xfs_btree.c
index 7fab2df1046f..f577c0463c6e 100644
--- a/fs/xfs/libxfs/xfs_btree.c
+++ b/fs/xfs/libxfs/xfs_btree.c
@@ -2693,6 +2693,20 @@ xfs_btree_rshift(
 	return error;
 }
 
+static inline int
+xfs_btree_alloc_block(
+	struct xfs_btree_cur		*cur,
+	const union xfs_btree_ptr	*hint_block,
+	union xfs_btree_ptr		*new_block,
+	int				*stat)
+{
+	int				error;
+
+	error = cur->bc_ops->alloc_block(cur, hint_block, new_block, stat);
+	trace_xfs_btree_alloc_block(cur, new_block, *stat, error);
+	return error;
+}
+
 /*
  * Split cur/level block in half.
  * Return new block number and the key to its first
@@ -2736,7 +2750,7 @@ __xfs_btree_split(
 	xfs_btree_buf_to_ptr(cur, lbp, &lptr);
 
 	/* Allocate the new block. If we can't do it, we're toast. Give up. */
-	error = cur->bc_ops->alloc_block(cur, &lptr, &rptr, stat);
+	error = xfs_btree_alloc_block(cur, &lptr, &rptr, stat);
 	if (error)
 		goto error0;
 	if (*stat == 0)
@@ -3002,7 +3016,7 @@ xfs_btree_new_iroot(
 	pp = xfs_btree_ptr_addr(cur, 1, block);
 
 	/* Allocate the new block. If we can't do it, we're toast. Give up. */
-	error = cur->bc_ops->alloc_block(cur, pp, &nptr, stat);
+	error = xfs_btree_alloc_block(cur, pp, &nptr, stat);
 	if (error)
 		goto error0;
 	if (*stat == 0)
@@ -3102,7 +3116,7 @@ xfs_btree_new_root(
 	cur->bc_ops->init_ptr_from_cur(cur, &rptr);
 
 	/* Allocate the new block. If we can't do it, we're toast. Give up. */
-	error = cur->bc_ops->alloc_block(cur, &rptr, &lptr, stat);
+	error = xfs_btree_alloc_block(cur, &rptr, &lptr, stat);
 	if (error)
 		goto error0;
 	if (*stat == 0)
diff --git a/fs/xfs/libxfs/xfs_refcount_btree.c b/fs/xfs/libxfs/xfs_refcount_btree.c
index b1d1f3bb159f..b75005684aa2 100644
--- a/fs/xfs/libxfs/xfs_refcount_btree.c
+++ b/fs/xfs/libxfs/xfs_refcount_btree.c
@@ -77,8 +77,6 @@ xfs_refcountbt_alloc_block(
 	error = xfs_alloc_vextent(&args);
 	if (error)
 		goto out_error;
-	trace_xfs_refcountbt_alloc_block(cur->bc_mp, cur->bc_ag.pag->pag_agno,
-			args.agbno, 1);
 	if (args.fsbno == NULLFSBLOCK) {
 		*stat = 0;
 		return 0;
diff --git a/fs/xfs/libxfs/xfs_rmap_btree.c b/fs/xfs/libxfs/xfs_rmap_btree.c
index 1421fcfcad64..5583dbe43bb5 100644
--- a/fs/xfs/libxfs/xfs_rmap_btree.c
+++ b/fs/xfs/libxfs/xfs_rmap_btree.c
@@ -94,8 +94,6 @@ xfs_rmapbt_alloc_block(
 				       &bno, 1);
 	if (error)
 		return error;
-
-	trace_xfs_rmapbt_alloc_block(cur->bc_mp, pag->pag_agno, bno, 1);
 	if (bno == NULLAGBLOCK) {
 		*stat = 0;
 		return 0;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 50f4d4410976..d86dd34127f2 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -2515,6 +2515,53 @@ DEFINE_EVENT(xfs_btree_cur_class, name, \
 DEFINE_BTREE_CUR_EVENT(xfs_btree_updkeys);
 DEFINE_BTREE_CUR_EVENT(xfs_btree_overlapped_query_range);
 
+TRACE_EVENT(xfs_btree_alloc_block,
+	TP_PROTO(struct xfs_btree_cur *cur, union xfs_btree_ptr *ptr, int stat,
+		 int error),
+	TP_ARGS(cur, ptr, stat, error),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_agnumber_t, agno)
+		__field(xfs_ino_t, ino)
+		__field(xfs_btnum_t, btnum)
+		__field(int, error)
+		__field(xfs_agblock_t, agbno)
+	),
+	TP_fast_assign(
+		__entry->dev = cur->bc_mp->m_super->s_dev;
+		if (cur->bc_flags & XFS_BTREE_ROOT_IN_INODE) {
+			__entry->agno = 0;
+			__entry->ino = cur->bc_ino.ip->i_ino;
+		} else {
+			__entry->agno = cur->bc_ag.pag->pag_agno;
+			__entry->ino = 0;
+		}
+		__entry->btnum = cur->bc_btnum;
+		__entry->error = error;
+		if (!error && stat) {
+			if (cur->bc_flags & XFS_BTREE_LONG_PTRS) {
+				xfs_fsblock_t	fsb = be64_to_cpu(ptr->l);
+
+				__entry->agno = XFS_FSB_TO_AGNO(cur->bc_mp,
+								fsb);
+				__entry->agbno = XFS_FSB_TO_AGBNO(cur->bc_mp,
+								fsb);
+			} else {
+				__entry->agbno = be32_to_cpu(ptr->s);
+			}
+		} else {
+			__entry->agbno = NULLAGBLOCK;
+		}
+	),
+	TP_printk("dev %d:%d btree %s agno 0x%x ino 0x%llx agbno 0x%x error %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->btnum, XFS_BTNUM_STRINGS),
+		  __entry->agno,
+		  __entry->ino,
+		  __entry->agbno,
+		  __entry->error)
+);
+
 TRACE_EVENT(xfs_btree_free_block,
 	TP_PROTO(struct xfs_btree_cur *cur, struct xfs_buf *bp),
 	TP_ARGS(cur, bp),
@@ -2898,7 +2945,6 @@ DEFINE_EVENT(xfs_rmapbt_class, name, \
 DEFINE_RMAP_DEFERRED_EVENT(xfs_rmap_defer);
 DEFINE_RMAP_DEFERRED_EVENT(xfs_rmap_deferred);
 
-DEFINE_BUSY_EVENT(xfs_rmapbt_alloc_block);
 DEFINE_RMAPBT_EVENT(xfs_rmap_update);
 DEFINE_RMAPBT_EVENT(xfs_rmap_insert);
 DEFINE_RMAPBT_EVENT(xfs_rmap_delete);
@@ -3256,7 +3302,6 @@ DEFINE_EVENT(xfs_refcount_triple_extent_class, name, \
 	TP_ARGS(mp, agno, i1, i2, i3))
 
 /* refcount btree tracepoints */
-DEFINE_BUSY_EVENT(xfs_refcountbt_alloc_block);
 DEFINE_AG_BTREE_LOOKUP_EVENT(xfs_refcount_lookup);
 DEFINE_REFCOUNT_EXTENT_EVENT(xfs_refcount_get);
 DEFINE_REFCOUNT_EXTENT_EVENT(xfs_refcount_update);

