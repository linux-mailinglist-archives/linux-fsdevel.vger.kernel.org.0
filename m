Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE6461382
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377248AbhK2LM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 06:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376844AbhK2LKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:10:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4DC08EC67;
        Mon, 29 Nov 2021 02:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Lh32cIVjzS0GG/4N1gXHtjc7DeeA3FMh6AaAiw8XwdI=; b=BdWmeWGwTz1dwQd9HBwxuiWH91
        wSx0J5WiTs0PsNfCjNWm0R5/tmMa2YjZCUtrW44D+OaXQTOW+Ktl6COFHW1mIRjYk5IexxHKMT/XV
        0z1bcz3kQS/jmtK6nKxYwNvG5WRmH1SOaZTdTOfof0D00XnkxOjU4VCmuM69nwX02BMI909D4inen
        2h6O53IU0+hC0TttijYOXCoeK8BAvaCk2mGXeSfCF32Qsmvg234JLTXUzRUZcMtwLVGw7K4JYKJbe
        e9GPY0SW6hx57ShOhEVDWDwxn70XDTHRuGIy9EUS2OavIQuQvZvNJCszOSJ5OahmE8yIDUPwWNx5b
        PjjCzX0A==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdnv-0073V2-LY; Mon, 29 Nov 2021 10:22:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 23/29] xfs: pass the mapping flags to xfs_bmbt_to_iomap
Date:   Mon, 29 Nov 2021 11:21:57 +0100
Message-Id: <20211129102203.2243509-24-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To prepare for looking at the IOMAP_DAX flag in xfs_bmbt_to_iomap pass in
the input mapping flags to xfs_bmbt_to_iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_bmap.c |  4 ++--
 fs/xfs/xfs_aops.c        |  2 +-
 fs/xfs/xfs_iomap.c       | 35 ++++++++++++++++++++---------------
 fs/xfs/xfs_iomap.h       |  5 +++--
 fs/xfs/xfs_pnfs.c        |  2 +-
 5 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 4dccd4d90622d..74198dd82b035 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4551,7 +4551,7 @@ xfs_bmapi_convert_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
-		xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
+		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 		*seq = READ_ONCE(ifp->if_seq);
 		goto out_trans_cancel;
 	}
@@ -4598,7 +4598,7 @@ xfs_bmapi_convert_delalloc(
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
-	xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
+	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags);
 	*seq = READ_ONCE(ifp->if_seq);
 
 	if (whichfork == XFS_COW_FORK)
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index c8c15c3c31471..6ac3449a68ba0 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -359,7 +359,7 @@ xfs_map_blocks(
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 9b7f92c6aef33..d6beb1502f8bc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -53,7 +53,8 @@ xfs_bmbt_to_iomap(
 	struct xfs_inode	*ip,
 	struct iomap		*iomap,
 	struct xfs_bmbt_irec	*imap,
-	u16			flags)
+	unsigned int		mapping_flags,
+	u16			iomap_flags)
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
@@ -79,7 +80,7 @@ xfs_bmbt_to_iomap(
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
 	iomap->bdev = target->bt_bdev;
 	iomap->dax_dev = target->bt_daxdev;
-	iomap->flags = flags;
+	iomap->flags = iomap_flags;
 
 	if (xfs_ipincount(ip) &&
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
@@ -799,7 +800,7 @@ xfs_direct_write_iomap_begin(
 
 	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags);
 
 allocate_blocks:
 	error = -EAGAIN;
@@ -830,18 +831,19 @@ xfs_direct_write_iomap_begin(
 		return error;
 
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags | IOMAP_F_NEW);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
+				 iomap_flags | IOMAP_F_NEW);
 
 out_found_cow:
 	xfs_iunlock(ip, lockmode);
 	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
 	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
 	if (imap.br_startblock != HOLESTARTBLOCK) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
 		if (error)
 			return error;
 	}
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED);
 
 out_unlock:
 	if (lockmode)
@@ -1051,23 +1053,24 @@ xfs_buffered_write_iomap_begin(
 	 */
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW);
 
 found_imap:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
 
 found_cow:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0);
 		if (error)
 			return error;
-		return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
+		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
+					 IOMAP_F_SHARED);
 	}
 
 	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
-	return xfs_bmbt_to_iomap(ip, iomap, &cmap, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0);
 
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
@@ -1176,7 +1179,8 @@ xfs_read_iomap_begin(
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared ? IOMAP_F_SHARED : 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
+				 shared ? IOMAP_F_SHARED : 0);
 }
 
 const struct iomap_ops xfs_read_iomap_ops = {
@@ -1235,7 +1239,8 @@ xfs_seek_iomap_begin(
 		if (data_fsb < cow_fsb + cmap.br_blockcount)
 			end_fsb = min(end_fsb, data_fsb);
 		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
-		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
+		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
+					  IOMAP_F_SHARED);
 		/*
 		 * This is a COW extent, so we must probe the page cache
 		 * because there could be dirty page cache being backed
@@ -1257,7 +1262,7 @@ xfs_seek_iomap_begin(
 	imap.br_state = XFS_EXT_NORM;
 done:
 	xfs_trim_extent(&imap, offset_fsb, end_fsb);
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
 out_unlock:
 	xfs_iunlock(ip, lockmode);
 	return error;
@@ -1304,7 +1309,7 @@ xfs_xattr_iomap_begin(
 	if (error)
 		return error;
 	ASSERT(nimaps);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0);
 }
 
 const struct iomap_ops xfs_xattr_iomap_ops = {
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index f1a281ab9328c..657cc02290f22 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -17,8 +17,9 @@ int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
 xfs_fileoff_t xfs_iomap_eof_align_last_fsb(struct xfs_inode *ip,
 		xfs_fileoff_t end_fsb);
 
-int xfs_bmbt_to_iomap(struct xfs_inode *, struct iomap *,
-		struct xfs_bmbt_irec *, u16);
+int xfs_bmbt_to_iomap(struct xfs_inode *ip, struct iomap *iomap,
+		struct xfs_bmbt_irec *imap, unsigned int mapping_flags,
+		u16 iomap_flags);
 
 int xfs_zero_range(struct xfs_inode *ip, loff_t pos, loff_t len,
 		bool *did_zero);
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 5e1d29d8b2e73..7ce1ea11fc3f3 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -173,7 +173,7 @@ xfs_fs_map_blocks(
 	}
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
+	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0, 0);
 	*device_generation = mp->m_generation;
 	return error;
 out_unlock:
-- 
2.30.2

