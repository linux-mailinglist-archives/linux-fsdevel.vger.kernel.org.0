Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860D757D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjGRNWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 09:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGRNV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:21:56 -0400
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C5B1B0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 06:21:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689686510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0y7Lruf7k6wpufCBL5FzUjeh6mIyCUNtfoGkFLeIM4=;
        b=QptRUwaIeWlE7S0XZtQ++Fk+rXilXz7UJW1tnKBfY6HRL+H9WJWa14E+NmBB1SpvG0+fSx
        DY7hWNWE9J37w0522dgBmtXj1/nZGpTHuT/FR2vFLYJtdusgdYnzE40EFHPci0wi4foW/1
        z36ReA550EaBQEbWtfsDxXqaN9/eOi0=
From:   Hao Xu <hao.xu@linux.dev>
To:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 4/5] xfs: add NOWAIT semantics for readdir
Date:   Tue, 18 Jul 2023 21:21:11 +0800
Message-Id: <20230718132112.461218-5-hao.xu@linux.dev>
In-Reply-To: <20230718132112.461218-1-hao.xu@linux.dev>
References: <20230718132112.461218-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

Implement NOWAIT semantics for readdir. Return EAGAIN error to the
caller if it would block, like failing to get locks, or going to
do IO.

Co-developed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Hao Xu <howeyxu@tencent.com>
[fixes deadlock issue, tweak code style]
---
 fs/xfs/libxfs/xfs_da_btree.c   | 16 ++++++++++
 fs/xfs/libxfs/xfs_da_btree.h   |  1 +
 fs/xfs/libxfs/xfs_dir2_block.c |  7 ++--
 fs/xfs/libxfs/xfs_dir2_priv.h  |  2 +-
 fs/xfs/scrub/dir.c             |  2 +-
 fs/xfs/scrub/readdir.c         |  2 +-
 fs/xfs/xfs_dir2_readdir.c      | 58 +++++++++++++++++++++++++++-------
 fs/xfs/xfs_inode.c             | 17 ++++++++++
 fs/xfs/xfs_inode.h             | 15 +++++----
 9 files changed, 96 insertions(+), 24 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index e576560b46e9..7a1a0af24197 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -2643,16 +2643,32 @@ xfs_da_read_buf(
 	struct xfs_buf_map	map, *mapp = &map;
 	int			nmap = 1;
 	int			error;
+	int			buf_flags = 0;
 
 	*bpp = NULL;
 	error = xfs_dabuf_map(dp, bno, flags, whichfork, &mapp, &nmap);
 	if (error || !nmap)
 		goto out_free;
 
+	/*
+	 * NOWAIT semantics mean we don't wait on the buffer lock nor do we
+	 * issue IO for this buffer if it is not already in memory. Caller will
+	 * retry. This will return -EAGAIN if the buffer is in memory and cannot
+	 * be locked, and no buffer and no error if it isn't in memory.  We
+	 * translate both of those into a return state of -EAGAIN and *bpp =
+	 * NULL.
+	 */
+	if (flags & XFS_DABUF_NOWAIT)
+		buf_flags |= XBF_TRYLOCK | XBF_INCORE;
 	error = xfs_trans_read_buf_map(mp, tp, mp->m_ddev_targp, mapp, nmap, 0,
 			&bp, ops);
 	if (error)
 		goto out_free;
+	if (!bp) {
+		ASSERT(flags & XFS_DABUF_NOWAIT);
+		error = -EAGAIN;
+		goto out_free;
+	}
 
 	if (whichfork == XFS_ATTR_FORK)
 		xfs_buf_set_ref(bp, XFS_ATTR_BTREE_REF);
diff --git a/fs/xfs/libxfs/xfs_da_btree.h b/fs/xfs/libxfs/xfs_da_btree.h
index ffa3df5b2893..32e7b1cca402 100644
--- a/fs/xfs/libxfs/xfs_da_btree.h
+++ b/fs/xfs/libxfs/xfs_da_btree.h
@@ -205,6 +205,7 @@ int	xfs_da3_node_read_mapped(struct xfs_trans *tp, struct xfs_inode *dp,
  */
 
 #define XFS_DABUF_MAP_HOLE_OK	(1u << 0)
+#define XFS_DABUF_NOWAIT	(1u << 1)
 
 int	xfs_da_grow_inode(xfs_da_args_t *args, xfs_dablk_t *new_blkno);
 int	xfs_da_grow_inode_int(struct xfs_da_args *args, xfs_fileoff_t *bno,
diff --git a/fs/xfs/libxfs/xfs_dir2_block.c b/fs/xfs/libxfs/xfs_dir2_block.c
index 00f960a703b2..59b24a594add 100644
--- a/fs/xfs/libxfs/xfs_dir2_block.c
+++ b/fs/xfs/libxfs/xfs_dir2_block.c
@@ -135,13 +135,14 @@ int
 xfs_dir3_block_read(
 	struct xfs_trans	*tp,
 	struct xfs_inode	*dp,
+	unsigned int		flags,
 	struct xfs_buf		**bpp)
 {
 	struct xfs_mount	*mp = dp->i_mount;
 	xfs_failaddr_t		fa;
 	int			err;
 
-	err = xfs_da_read_buf(tp, dp, mp->m_dir_geo->datablk, 0, bpp,
+	err = xfs_da_read_buf(tp, dp, mp->m_dir_geo->datablk, flags, bpp,
 				XFS_DATA_FORK, &xfs_dir3_block_buf_ops);
 	if (err || !*bpp)
 		return err;
@@ -380,7 +381,7 @@ xfs_dir2_block_addname(
 	tp = args->trans;
 
 	/* Read the (one and only) directory block into bp. */
-	error = xfs_dir3_block_read(tp, dp, &bp);
+	error = xfs_dir3_block_read(tp, dp, 0, &bp);
 	if (error)
 		return error;
 
@@ -695,7 +696,7 @@ xfs_dir2_block_lookup_int(
 	dp = args->dp;
 	tp = args->trans;
 
-	error = xfs_dir3_block_read(tp, dp, &bp);
+	error = xfs_dir3_block_read(tp, dp, 0, &bp);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/libxfs/xfs_dir2_priv.h b/fs/xfs/libxfs/xfs_dir2_priv.h
index 7404a9ff1a92..7d4cf8a0f15b 100644
--- a/fs/xfs/libxfs/xfs_dir2_priv.h
+++ b/fs/xfs/libxfs/xfs_dir2_priv.h
@@ -51,7 +51,7 @@ extern int xfs_dir_cilookup_result(struct xfs_da_args *args,
 
 /* xfs_dir2_block.c */
 extern int xfs_dir3_block_read(struct xfs_trans *tp, struct xfs_inode *dp,
-			       struct xfs_buf **bpp);
+			       unsigned int flags, struct xfs_buf **bpp);
 extern int xfs_dir2_block_addname(struct xfs_da_args *args);
 extern int xfs_dir2_block_lookup(struct xfs_da_args *args);
 extern int xfs_dir2_block_removename(struct xfs_da_args *args);
diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 0b491784b759..5cc51f201bd7 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -313,7 +313,7 @@ xchk_directory_data_bestfree(
 		/* dir block format */
 		if (lblk != XFS_B_TO_FSBT(mp, XFS_DIR2_DATA_OFFSET))
 			xchk_fblock_set_corrupt(sc, XFS_DATA_FORK, lblk);
-		error = xfs_dir3_block_read(sc->tp, sc->ip, &bp);
+		error = xfs_dir3_block_read(sc->tp, sc->ip, 0, &bp);
 	} else {
 		/* dir data format */
 		error = xfs_dir3_data_read(sc->tp, sc->ip, lblk, 0, &bp);
diff --git a/fs/xfs/scrub/readdir.c b/fs/xfs/scrub/readdir.c
index e51c1544be63..f0a727311632 100644
--- a/fs/xfs/scrub/readdir.c
+++ b/fs/xfs/scrub/readdir.c
@@ -101,7 +101,7 @@ xchk_dir_walk_block(
 	unsigned int		off, next_off, end;
 	int			error;
 
-	error = xfs_dir3_block_read(sc->tp, dp, &bp);
+	error = xfs_dir3_block_read(sc->tp, dp, 0, &bp);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_dir2_readdir.c b/fs/xfs/xfs_dir2_readdir.c
index 9f3ceb461515..55bccc2d0da7 100644
--- a/fs/xfs/xfs_dir2_readdir.c
+++ b/fs/xfs/xfs_dir2_readdir.c
@@ -149,6 +149,7 @@ xfs_dir2_block_getdents(
 	struct xfs_da_geometry	*geo = args->geo;
 	unsigned int		offset, next_offset;
 	unsigned int		end;
+	unsigned int		flags = 0;
 
 	/*
 	 * If the block number in the offset is out of range, we're done.
@@ -156,7 +157,9 @@ xfs_dir2_block_getdents(
 	if (xfs_dir2_dataptr_to_db(geo, ctx->pos) > geo->datablk)
 		return 0;
 
-	error = xfs_dir3_block_read(args->trans, dp, &bp);
+	if (ctx->flags & DIR_CONTEXT_F_NOWAIT)
+		flags |= XFS_DABUF_NOWAIT;
+	error = xfs_dir3_block_read(args->trans, dp, flags, &bp);
 	if (error)
 		return error;
 
@@ -240,6 +243,7 @@ xfs_dir2_block_getdents(
 STATIC int
 xfs_dir2_leaf_readbuf(
 	struct xfs_da_args	*args,
+	struct dir_context	*ctx,
 	size_t			bufsize,
 	xfs_dir2_off_t		*cur_off,
 	xfs_dablk_t		*ra_blk,
@@ -258,10 +262,15 @@ xfs_dir2_leaf_readbuf(
 	struct xfs_iext_cursor	icur;
 	int			ra_want;
 	int			error = 0;
-
-	error = xfs_iread_extents(args->trans, dp, XFS_DATA_FORK);
-	if (error)
-		goto out;
+	unsigned int		flags = 0;
+
+	if (ctx->flags & DIR_CONTEXT_F_NOWAIT) {
+		flags |= XFS_DABUF_NOWAIT;
+	} else {
+		error = xfs_iread_extents(args->trans, dp, XFS_DATA_FORK);
+		if (error)
+			goto out;
+	}
 
 	/*
 	 * Look for mapped directory blocks at or above the current offset.
@@ -280,7 +289,7 @@ xfs_dir2_leaf_readbuf(
 	new_off = xfs_dir2_da_to_byte(geo, map.br_startoff);
 	if (new_off > *cur_off)
 		*cur_off = new_off;
-	error = xfs_dir3_data_read(args->trans, dp, map.br_startoff, 0, &bp);
+	error = xfs_dir3_data_read(args->trans, dp, map.br_startoff, flags, &bp);
 	if (error)
 		goto out;
 
@@ -337,6 +346,16 @@ xfs_dir2_leaf_readbuf(
 	goto out;
 }
 
+static inline int
+xfs_ilock_for_readdir(
+	struct xfs_inode	*dp,
+	bool			nowait)
+{
+	if (nowait)
+		return xfs_ilock_data_map_shared_nowait(dp);
+	return xfs_ilock_data_map_shared(dp);
+}
+
 /*
  * Getdents (readdir) for leaf and node directories.
  * This reads the data blocks only, so is the same for both forms.
@@ -360,6 +379,7 @@ xfs_dir2_leaf_getdents(
 	int			byteoff;	/* offset in current block */
 	unsigned int		offset = 0;
 	int			error = 0;	/* error return value */
+	int			written = 0;
 
 	/*
 	 * If the offset is at or past the largest allowed value,
@@ -391,10 +411,16 @@ xfs_dir2_leaf_getdents(
 				bp = NULL;
 			}
 
-			if (*lock_mode == 0)
-				*lock_mode = xfs_ilock_data_map_shared(dp);
-			error = xfs_dir2_leaf_readbuf(args, bufsize, &curoff,
-					&rablk, &bp);
+			if (*lock_mode == 0) {
+				*lock_mode = xfs_ilock_for_readdir(dp,
+					ctx->flags & DIR_CONTEXT_F_NOWAIT);
+				if (!*lock_mode) {
+					error = -EAGAIN;
+					break;
+				}
+			}
+			error = xfs_dir2_leaf_readbuf(args, ctx, bufsize,
+					&curoff, &rablk, &bp);
 			if (error || !bp)
 				break;
 
@@ -479,6 +505,7 @@ xfs_dir2_leaf_getdents(
 		 */
 		offset += length;
 		curoff += length;
+		written += length;
 		/* bufsize may have just been a guess; don't go negative */
 		bufsize = bufsize > length ? bufsize - length : 0;
 	}
@@ -492,6 +519,8 @@ xfs_dir2_leaf_getdents(
 		ctx->pos = xfs_dir2_byte_to_dataptr(curoff) & 0x7fffffff;
 	if (bp)
 		xfs_trans_brelse(args->trans, bp);
+	if (error == -EAGAIN && written > 0)
+		error = 0;
 	return error;
 }
 
@@ -514,6 +543,7 @@ xfs_readdir(
 	unsigned int		lock_mode;
 	bool			isblock;
 	int			error;
+	bool			nowait;
 
 	trace_xfs_readdir(dp);
 
@@ -531,7 +561,11 @@ xfs_readdir(
 	if (dp->i_df.if_format == XFS_DINODE_FMT_LOCAL)
 		return xfs_dir2_sf_getdents(&args, ctx);
 
-	lock_mode = xfs_ilock_data_map_shared(dp);
+	nowait = ctx->flags & DIR_CONTEXT_F_NOWAIT;
+	lock_mode = xfs_ilock_for_readdir(dp, nowait);
+	if (!lock_mode)
+		return -EAGAIN;
+
 	error = xfs_dir2_isblock(&args, &isblock);
 	if (error)
 		goto out_unlock;
@@ -546,5 +580,7 @@ xfs_readdir(
 out_unlock:
 	if (lock_mode)
 		xfs_iunlock(dp, lock_mode);
+	if (error == -EAGAIN)
+		ASSERT(nowait);
 	return error;
 }
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9e62cc500140..48b1257b3ec4 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -120,6 +120,23 @@ xfs_ilock_data_map_shared(
 	return lock_mode;
 }
 
+/*
+ * Similar to xfs_ilock_data_map_shared(), except that it will only try to lock
+ * the inode in shared mode if the extents are already in memory. If it fails to
+ * get the lock or has to do IO to read the extent list, fail the operation by
+ * returning 0 as the lock mode.
+ */
+uint
+xfs_ilock_data_map_shared_nowait(
+	struct xfs_inode	*ip)
+{
+	if (xfs_need_iread_extents(&ip->i_df))
+		return 0;
+	if (!xfs_ilock_nowait(ip, XFS_ILOCK_SHARED))
+		return 0;
+	return XFS_ILOCK_SHARED;
+}
+
 uint
 xfs_ilock_attr_map_shared(
 	struct xfs_inode	*ip)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 7547caf2f2ab..2cdb4daadacf 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -490,13 +490,14 @@ int		xfs_rename(struct mnt_idmap *idmap,
 			   struct xfs_name *target_name,
 			   struct xfs_inode *target_ip, unsigned int flags);
 
-void		xfs_ilock(xfs_inode_t *, uint);
-int		xfs_ilock_nowait(xfs_inode_t *, uint);
-void		xfs_iunlock(xfs_inode_t *, uint);
-void		xfs_ilock_demote(xfs_inode_t *, uint);
-bool		xfs_isilocked(struct xfs_inode *, uint);
-uint		xfs_ilock_data_map_shared(struct xfs_inode *);
-uint		xfs_ilock_attr_map_shared(struct xfs_inode *);
+void		xfs_ilock(struct xfs_inode *ip, uint lockmode);
+int		xfs_ilock_nowait(struct xfs_inode *ip, uint lockmode);
+void		xfs_iunlock(struct xfs_inode *ip, uint lockmode);
+void		xfs_ilock_demote(struct xfs_inode *ip, uint lockmode);
+bool		xfs_isilocked(struct xfs_inode *ip, uint lockmode);
+uint		xfs_ilock_data_map_shared(struct xfs_inode *ip);
+uint		xfs_ilock_data_map_shared_nowait(struct xfs_inode *ip);
+uint		xfs_ilock_attr_map_shared(struct xfs_inode *ip);
 
 uint		xfs_ip2xflags(struct xfs_inode *);
 int		xfs_ifree(struct xfs_trans *, struct xfs_inode *);
-- 
2.25.1

