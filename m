Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF60711C0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjEZBGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjEZBG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C03119C;
        Thu, 25 May 2023 18:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A54C8647D0;
        Fri, 26 May 2023 01:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A755C433EF;
        Fri, 26 May 2023 01:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063185;
        bh=vmCUSlSSDF+eK3AGAteLNbmM2hGiFQQx8DhQOStWmx4=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=sHyb4hMVdjBDSnSd1hXIAyVnxufMtGdOopNduiI/3pFOum/o1VWEPnrOCeaStEKlg
         Q0W+bGOoSJHPW1jRD46YTgDNh8NIH2nRK5D+tA3dYVB/A9HRSZoXSmymVwAujiaLWP
         zcDCBtr/staVV8C94aEAD+3Yu/QdObBnIUrRiNq08vH+tebTlHLll7AHcqJcNPgdEN
         wS4Wk7WLnbAqQt3uaRzHR9F/Ch0/2l1sQ7pOU6TjKpS2EldsjA+8CX0ZpUOMaTAkdg
         B6lMhuU8MVjbQVYMynC4Z4FLThpGd8SeA7R+tSg96EZOLxEeAxjkhzBD0Tg2NfgTjM
         ppwOAqPXGUiIQ==
Date:   Thu, 25 May 2023 18:06:24 -0700
Subject: [PATCH 7/9] xfs: consolidate btree block allocation tracepoints
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506061953.3733082.1567323682056667252.stgit@frogsfrogsfrogs>
In-Reply-To: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
References: <168506061839.3733082.9818919714772025609.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 3e966182b90a..fbed51b4462e 100644
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
@@ -3016,7 +3030,7 @@ xfs_btree_new_iroot(
 	pp = xfs_btree_ptr_addr(cur, 1, block);
 
 	/* Allocate the new block. If we can't do it, we're toast. Give up. */
-	error = cur->bc_ops->alloc_block(cur, pp, &nptr, stat);
+	error = xfs_btree_alloc_block(cur, pp, &nptr, stat);
 	if (error)
 		goto error0;
 	if (*stat == 0)
@@ -3116,7 +3130,7 @@ xfs_btree_new_root(
 	cur->bc_ops->init_ptr_from_cur(cur, &rptr);
 
 	/* Allocate the new block. If we can't do it, we're toast. Give up. */
-	error = cur->bc_ops->alloc_block(cur, &rptr, &lptr, stat);
+	error = xfs_btree_alloc_block(cur, &rptr, &lptr, stat);
 	if (error)
 		goto error0;
 	if (*stat == 0)
diff --git a/fs/xfs/libxfs/xfs_refcount_btree.c b/fs/xfs/libxfs/xfs_refcount_btree.c
index 978f00e9e99e..c5b99f1322ba 100644
--- a/fs/xfs/libxfs/xfs_refcount_btree.c
+++ b/fs/xfs/libxfs/xfs_refcount_btree.c
@@ -77,8 +77,6 @@ xfs_refcountbt_alloc_block(
 					xfs_refc_block(args.mp)));
 	if (error)
 		goto out_error;
-	trace_xfs_refcountbt_alloc_block(cur->bc_mp, cur->bc_ag.pag->pag_agno,
-			args.agbno, 1);
 	if (args.fsbno == NULLFSBLOCK) {
 		*stat = 0;
 		return 0;
diff --git a/fs/xfs/libxfs/xfs_rmap_btree.c b/fs/xfs/libxfs/xfs_rmap_btree.c
index 0dc086bc528f..43ff2236f623 100644
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
index 10fb261e6c17..b1a1c90d8feb 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -2523,6 +2523,53 @@ DEFINE_EVENT(xfs_btree_cur_class, name, \
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
@@ -2906,7 +2953,6 @@ DEFINE_EVENT(xfs_rmapbt_class, name, \
 DEFINE_RMAP_DEFERRED_EVENT(xfs_rmap_defer);
 DEFINE_RMAP_DEFERRED_EVENT(xfs_rmap_deferred);
 
-DEFINE_BUSY_EVENT(xfs_rmapbt_alloc_block);
 DEFINE_RMAPBT_EVENT(xfs_rmap_update);
 DEFINE_RMAPBT_EVENT(xfs_rmap_insert);
 DEFINE_RMAPBT_EVENT(xfs_rmap_delete);
@@ -3264,7 +3310,6 @@ DEFINE_EVENT(xfs_refcount_triple_extent_class, name, \
 	TP_ARGS(mp, agno, i1, i2, i3))
 
 /* refcount btree tracepoints */
-DEFINE_BUSY_EVENT(xfs_refcountbt_alloc_block);
 DEFINE_AG_BTREE_LOOKUP_EVENT(xfs_refcount_lookup);
 DEFINE_REFCOUNT_EXTENT_EVENT(xfs_refcount_get);
 DEFINE_REFCOUNT_EXTENT_EVENT(xfs_refcount_update);

