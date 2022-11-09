Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ADD62322C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKISQX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKISQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:16:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD0275C2;
        Wed,  9 Nov 2022 10:16:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77D2061C01;
        Wed,  9 Nov 2022 18:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EDFC433C1;
        Wed,  9 Nov 2022 18:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017778;
        bh=dMMwZNxf5ZYNl29ixV58mDFn4SND3Uayu/r9VKWrqxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DmAiKzKOmgFGPjb2ZlU+VqmOnPM2iC8GpPsbWdU4F1YYVlwQUsxkXLksHoqYb7eH1
         5OypzzOIp/ZgcxRmbih3nPdr4zCPIU0Gc62cjb1FEDP+LsMDodV0mI/P1dkBrd7+nv
         WpYZlS6PycRk1cl6DZXFeZl0vhuvnJDk8TDB4ywmKPXzqWen2xwptjwdcDdCN8wuRy
         Ca1RCzjWGgYZ0R1sVUKwMSgBBUFYYpflEXUfpV7bB7QM5yYhmgrecaGSHNNrkgE8SQ
         SwjUnl9xxBMOs2Bt7ezjrkGk2SDp8NBaJ6UnSanxsT5k1oy/ki00UmJw+bDwuDU2xx
         M6TwqwctrL3IA==
Subject: [PATCH 06/14] xfs: use iomap_valid method to detect stale cached
 iomaps
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        hch@infradead.org
Date:   Wed, 09 Nov 2022 10:16:18 -0800
Message-ID: <166801777846.3992140.13450989888668636860.stgit@magnolia>
In-Reply-To: <166801774453.3992140.241667783932550826.stgit@magnolia>
References: <166801774453.3992140.241667783932550826.stgit@magnolia>
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

From: Dave Chinner <dchinner@redhat.com>

Now that iomap supports a mechanism to validate cached iomaps for
buffered write operations, hook it up to the XFS buffered write ops
so that we can avoid data corruptions that result from stale cached
iomaps. See:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

or the ->iomap_valid() introduction commit for exact details of the
corruption vector.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c |    4 +--
 fs/xfs/xfs_aops.c        |    2 +
 fs/xfs/xfs_iomap.c       |   69 +++++++++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_iomap.h       |    4 +--
 fs/xfs/xfs_pnfs.c        |    5 ++-
 5 files changed, 61 insertions(+), 23 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 49d0d4ea63fc..db225130618c 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4551,8 +4551,8 @@ xfs_bmapi_convert_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
-		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 		*seq = READ_ONCE(ifp->if_seq);
+		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
 		goto out_trans_cancel;
 	}
 
@@ -4599,8 +4599,8 @@ xfs_bmapi_convert_delalloc(
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
-	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 	*seq = READ_ONCE(ifp->if_seq);
+	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags, *seq);
 
 	if (whichfork == XFS_COW_FORK)
 		xfs_refcount_alloc_cow_extent(tp, bma.blkno, bma.length);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 5d1a995b15f8..ca5a9e45a48c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -373,7 +373,7 @@ xfs_map_blocks(
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0);
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 2d48fcc7bd6f..5053ffcf10fe 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -54,7 +54,8 @@ xfs_bmbt_to_iomap(
 	struct iomap		*iomap,
 	struct xfs_bmbt_irec	*imap,
 	unsigned int		mapping_flags,
-	u16			iomap_flags)
+	u16			iomap_flags,
+	int			sequence)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
@@ -91,6 +92,9 @@ xfs_bmbt_to_iomap(
 	if (xfs_ipincount(ip) &&
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
+
+	/* The extent tree sequence is needed for iomap validity checking. */
+	*((int *)&iomap->private) = sequence;
 	return 0;
 }
 
@@ -195,7 +199,8 @@ xfs_iomap_write_direct(
 	xfs_fileoff_t		offset_fsb,
 	xfs_fileoff_t		count_fsb,
 	unsigned int		flags,
-	struct xfs_bmbt_irec	*imap)
+	struct xfs_bmbt_irec	*imap,
+	int			*seq)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
@@ -285,6 +290,8 @@ xfs_iomap_write_direct(
 		error = xfs_alert_fsblock_zero(ip, imap);
 
 out_unlock:
+	if (seq)
+		*seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 
@@ -743,6 +750,7 @@ xfs_direct_write_iomap_begin(
 	bool			shared = false;
 	u16			iomap_flags = 0;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
+	int			seq;
 
 	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
 
@@ -811,9 +819,10 @@ xfs_direct_write_iomap_begin(
 			goto out_unlock;
 	}
 
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 
 allocate_blocks:
 	error = -EAGAIN;
@@ -839,24 +848,25 @@ xfs_direct_write_iomap_begin(
 	xfs_iunlock(ip, lockmode);
 
 	error = xfs_iomap_write_direct(ip, offset_fsb, end_fsb - offset_fsb,
-			flags, &imap);
+			flags, &imap, &seq);
 	if (error)
 		return error;
 
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 iomap_flags | IOMAP_F_NEW);
+				 iomap_flags | IOMAP_F_NEW, seq);
 
 out_found_cow:
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, lockmode);
 	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
 	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
 	if (imap.br_startblock != HOLESTARTBLOCK) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
 			return error;
 	}
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
 
 out_unlock:
 	if (lockmode)
@@ -915,6 +925,7 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
+	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1094,26 +1105,29 @@ xfs_buffered_write_iomap_begin(
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
 
 found_imap:
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
 found_cow:
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
 			return error;
 		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					 IOMAP_F_SHARED);
+					 IOMAP_F_SHARED, seq);
 	}
 
 	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
 
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1328,9 +1342,26 @@ xfs_buffered_write_iomap_end(
 	return 0;
 }
 
+/*
+ * Check that the iomap passed to us is still valid for the given offset and
+ * length.
+ */
+static bool
+xfs_buffered_write_iomap_valid(
+	struct inode		*inode,
+	const struct iomap	*iomap)
+{
+	int			seq = *((int *)&iomap->private);
+
+	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
+		return false;
+	return true;
+}
+
 const struct iomap_ops xfs_buffered_write_iomap_ops = {
 	.iomap_begin		= xfs_buffered_write_iomap_begin,
 	.iomap_end		= xfs_buffered_write_iomap_end,
+	.iomap_valid		= xfs_buffered_write_iomap_valid,
 };
 
 /*
@@ -1359,6 +1390,7 @@ xfs_read_iomap_begin(
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
+	int			seq;
 
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
 
@@ -1372,13 +1404,14 @@ xfs_read_iomap_begin(
 			       &nimaps, 0);
 	if (!error && (flags & IOMAP_REPORT))
 		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
+	seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 shared ? IOMAP_F_SHARED : 0);
+				 shared ? IOMAP_F_SHARED : 0, seq);
 }
 
 const struct iomap_ops xfs_read_iomap_ops = {
@@ -1438,7 +1471,7 @@ xfs_seek_iomap_begin(
 			end_fsb = min(end_fsb, data_fsb);
 		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
 		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
-					  IOMAP_F_SHARED);
+				IOMAP_F_SHARED, READ_ONCE(ip->i_cowfp->if_seq));
 		/*
 		 * This is a COW extent, so we must probe the page cache
 		 * because there could be dirty page cache being backed
@@ -1460,7 +1493,8 @@ xfs_seek_iomap_begin(
 	imap.br_state = XFS_EXT_NORM;
 done:
 	xfs_trim_extent(&imap, offset_fsb, end_fsb);
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0,
+			READ_ONCE(ip->i_df.if_seq));
 out_unlock:
 	xfs_iunlock(ip, lockmode);
 	return error;
@@ -1486,6 +1520,7 @@ xfs_xattr_iomap_begin(
 	struct xfs_bmbt_irec	imap;
 	int			nimaps = 1, error = 0;
 	unsigned		lockmode;
+	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -1502,12 +1537,14 @@ xfs_xattr_iomap_begin(
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
 			       &nimaps, XFS_BMAPI_ATTRFORK);
 out_unlock:
+
+	seq = READ_ONCE(ip->i_af.if_seq);
 	xfs_iunlock(ip, lockmode);
 
 	if (error)
 		return error;
 	ASSERT(nimaps);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 }
 
 const struct iomap_ops xfs_xattr_iomap_ops = {
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index 0f62ab633040..792fed2a9072 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -13,14 +13,14 @@ struct xfs_bmbt_irec;
 
 int xfs_iomap_write_direct(struct xfs_inode *ip, xfs_fileoff_t offset_fsb,
 		xfs_fileoff_t count_fsb, unsigned int flags,
-		struct xfs_bmbt_irec *imap);
+		struct xfs_bmbt_irec *imap, int *sequence);
 int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
 int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
 		struct xfs_bmbt_irec *imap, unsigned int mapping_flags,
-		u16 iomap_flags);
+		u16 iomap_flags, int sequence);
 
 int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
 		bool *did_zero);
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 37a24f0f7cd4..eea507a80c5c 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -125,6 +125,7 @@ xfs_fs_map_blocks(
 	int			nimaps = 1;
 	uint			lock_flags;
 	int			error = 0;
+	int			seq;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
@@ -189,7 +190,7 @@ xfs_fs_map_blocks(
 		xfs_iunlock(ip, lock_flags);
 
 		error = xfs_iomap_write_direct(ip, offset_fsb,
-				end_fsb - offset_fsb, 0, &imap);
+				end_fsb - offset_fsb, 0, &imap, &seq);
 		if (error)
 			goto out_unlock;
 
@@ -209,7 +210,7 @@ xfs_fs_map_blocks(
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0, seq);
 	*device_generation = mp->m_generation;
 	return error;
 out_unlock:

