Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7011CCD321
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2019 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfJFPsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 11:48:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJFPsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 11:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ufZqNDK3+uU9kr5oBL+2vvU1id6u4O7xmbDVj90QPs0=; b=rXiU+0oyNKtgVEPB0RwTYUqeJa
        M/FZ5csjToWK3kJ2aASEbGRUHQAMPakYvKk9binuwvKKEmePgTcIGilapm2VK3WnkgIU1TxRmbZNw
        7D2IpyhGFiVEnwtDK1ts/hzwwJX/EaGymHQOx+MwasUZEoew8lXGzNEebFNQQn0CkQvUB1YB8rfGU
        08Em270RdRcWhqgAQw4YUdKnBYVhbHroTGvcwg2NO/GH1wWmmCa8vP1sLEjqFWKvojbnup7kYY8hb
        83HNZNWdnyub+8AP2zjnIgy7AmTcqFgNzIgKhJw6QAxw6Bt62fyoKTXyXVToc2Fqxw8kSqrpWQPPD
        SBnGdc1g==;
Received: from [2001:4bb8:18c:4d4a:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iH8m2-0008Ta-H6; Sun, 06 Oct 2019 15:48:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH 08/11] xfs: use a struct iomap in xfs_writepage_ctx
Date:   Sun,  6 Oct 2019 17:46:05 +0200
Message-Id: <20191006154608.24738-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191006154608.24738-1-hch@lst.de>
References: <20191006154608.24738-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for moving the XFS writeback code to fs/iomap.c, switch
it to use struct iomap instead of the XFS-specific struct xfs_bmbt_irec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 14 +++++--
 fs/xfs/libxfs/xfs_bmap.h |  3 +-
 fs/xfs/xfs_aops.c        | 82 +++++++++++++++++++---------------------
 fs/xfs/xfs_aops.h        |  2 +-
 4 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 4edc25a2ba80..d0e7f9ef7b85 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -34,6 +34,7 @@
 #include "xfs_ag_resv.h"
 #include "xfs_refcount.h"
 #include "xfs_icache.h"
+#include "xfs_iomap.h"
 
 
 kmem_zone_t		*xfs_bmap_free_item_zone;
@@ -4454,16 +4455,21 @@ int
 xfs_bmapi_convert_delalloc(
 	struct xfs_inode	*ip,
 	int			whichfork,
-	xfs_fileoff_t		offset_fsb,
-	struct xfs_bmbt_irec	*imap,
+	xfs_off_t		offset,
+	struct iomap		*iomap,
 	unsigned int		*seq)
 {
 	struct xfs_ifork	*ifp = XFS_IFORK_PTR(ip, whichfork);
 	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	struct xfs_bmalloca	bma = { NULL };
+	u16			flags = 0;
 	struct xfs_trans	*tp;
 	int			error;
 
+	if (whichfork == XFS_COW_FORK)
+		flags |= IOMAP_F_SHARED;
+
 	/*
 	 * Space for the extent and indirect blocks was reserved when the
 	 * delalloc extent was created so there's no need to do so here.
@@ -4493,7 +4499,7 @@ xfs_bmapi_convert_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
-		*imap = bma.got;
+		xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
 		*seq = READ_ONCE(ifp->if_seq);
 		goto out_trans_cancel;
 	}
@@ -4526,7 +4532,7 @@ xfs_bmapi_convert_delalloc(
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
-	*imap = bma.got;
+	xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
 	*seq = READ_ONCE(ifp->if_seq);
 
 	if (whichfork == XFS_COW_FORK)
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 5bb446d80542..6281ea9747c0 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -227,8 +227,7 @@ int	xfs_bmapi_reserve_delalloc(struct xfs_inode *ip, int whichfork,
 		struct xfs_bmbt_irec *got, struct xfs_iext_cursor *cur,
 		int eof);
 int	xfs_bmapi_convert_delalloc(struct xfs_inode *ip, int whichfork,
-		xfs_fileoff_t offset_fsb, struct xfs_bmbt_irec *imap,
-		unsigned int *seq);
+		xfs_off_t offset, struct iomap *iomap, unsigned int *seq);
 int	xfs_bmap_add_extent_unwritten_real(struct xfs_trans *tp,
 		struct xfs_inode *ip, int whichfork,
 		struct xfs_iext_cursor *icur, struct xfs_btree_cur **curp,
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b6101673c8fb..9f22885902ef 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,7 +22,7 @@
  * structure owned by writepages passed to individual writepage calls
  */
 struct xfs_writepage_ctx {
-	struct xfs_bmbt_irec    imap;
+	struct iomap		iomap;
 	int			fork;
 	unsigned int		data_seq;
 	unsigned int		cow_seq;
@@ -267,7 +267,7 @@ xfs_end_ioend(
 	 */
 	if (ioend->io_fork == XFS_COW_FORK)
 		error = xfs_reflink_end_cow(ip, offset, size);
-	else if (ioend->io_state == XFS_EXT_UNWRITTEN)
+	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
 	else
 		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
@@ -300,8 +300,8 @@ xfs_ioend_can_merge(
 		return false;
 	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
 		return false;
-	if ((ioend->io_state == XFS_EXT_UNWRITTEN) ^
-	    (next->io_state == XFS_EXT_UNWRITTEN))
+	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
+	    (next->io_type == IOMAP_UNWRITTEN))
 		return false;
 	if (ioend->io_offset + ioend->io_size != next->io_offset)
 		return false;
@@ -403,7 +403,7 @@ xfs_end_bio(
 	unsigned long		flags;
 
 	if (ioend->io_fork == XFS_COW_FORK ||
-	    ioend->io_state == XFS_EXT_UNWRITTEN ||
+	    ioend->io_type == IOMAP_UNWRITTEN ||
 	    ioend->io_append_trans != NULL) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
 		if (list_empty(&ip->i_ioend_list))
@@ -423,10 +423,10 @@ static bool
 xfs_imap_valid(
 	struct xfs_writepage_ctx	*wpc,
 	struct xfs_inode		*ip,
-	xfs_fileoff_t			offset_fsb)
+	loff_t				offset)
 {
-	if (offset_fsb < wpc->imap.br_startoff ||
-	    offset_fsb >= wpc->imap.br_startoff + wpc->imap.br_blockcount)
+	if (offset < wpc->iomap.offset ||
+	    offset >= wpc->iomap.offset + wpc->iomap.length)
 		return false;
 	/*
 	 * If this is a COW mapping, it is sufficient to check that the mapping
@@ -453,7 +453,7 @@ xfs_imap_valid(
 
 /*
  * Pass in a dellalloc extent and convert it to real extents, return the real
- * extent that maps offset_fsb in wpc->imap.
+ * extent that maps offset_fsb in wpc->iomap.
  *
  * The current page is held locked so nothing could have removed the block
  * backing offset_fsb, although it could have moved from the COW to the data
@@ -463,23 +463,23 @@ static int
 xfs_convert_blocks(
 	struct xfs_writepage_ctx *wpc,
 	struct xfs_inode	*ip,
-	xfs_fileoff_t		offset_fsb)
+	loff_t			offset)
 {
 	int			error;
 
 	/*
-	 * Attempt to allocate whatever delalloc extent currently backs
-	 * offset_fsb and put the result into wpc->imap.  Allocate in a loop
-	 * because it may take several attempts to allocate real blocks for a
-	 * contiguous delalloc extent if free space is sufficiently fragmented.
+	 * Attempt to allocate whatever delalloc extent currently backs offset
+	 * and put the result into wpc->iomap.  Allocate in a loop because it
+	 * may take several attempts to allocate real blocks for a contiguous
+	 * delalloc extent if free space is sufficiently fragmented.
 	 */
 	do {
-		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset_fsb,
-				&wpc->imap, wpc->fork == XFS_COW_FORK ?
+		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset,
+				&wpc->iomap, wpc->fork == XFS_COW_FORK ?
 					&wpc->cow_seq : &wpc->data_seq);
 		if (error)
 			return error;
-	} while (wpc->imap.br_startoff + wpc->imap.br_blockcount <= offset_fsb);
+	} while (wpc->iomap.offset + wpc->iomap.length <= offset);
 
 	return 0;
 }
@@ -519,7 +519,7 @@ xfs_map_blocks(
 	 * against concurrent updates and provides a memory barrier on the way
 	 * out that ensures that we always see the current value.
 	 */
-	if (xfs_imap_valid(wpc, ip, offset_fsb))
+	if (xfs_imap_valid(wpc, ip, offset))
 		return 0;
 
 	/*
@@ -552,7 +552,7 @@ xfs_map_blocks(
 	 * No COW extent overlap. Revalidate now that we may have updated
 	 * ->cow_seq. If the data mapping is still valid, we're done.
 	 */
-	if (xfs_imap_valid(wpc, ip, offset_fsb)) {
+	if (xfs_imap_valid(wpc, ip, offset)) {
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
 		return 0;
 	}
@@ -592,11 +592,11 @@ xfs_map_blocks(
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	wpc->imap = imap;
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
 	trace_xfs_map_blocks_found(ip, offset, count, wpc->fork, &imap);
 	return 0;
 allocate_blocks:
-	error = xfs_convert_blocks(wpc, ip, offset_fsb);
+	error = xfs_convert_blocks(wpc, ip, offset);
 	if (error) {
 		/*
 		 * If we failed to find the extent in the COW fork we might have
@@ -616,12 +616,15 @@ xfs_map_blocks(
 	 * original delalloc one.  Trim the return extent to the next COW
 	 * boundary again to force a re-lookup.
 	 */
-	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF &&
-	    cow_fsb < wpc->imap.br_startoff + wpc->imap.br_blockcount)
-		wpc->imap.br_blockcount = cow_fsb - wpc->imap.br_startoff;
+	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
+		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
+
+		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
+			wpc->iomap.length = cow_offset - wpc->iomap.offset;
+	}
 
-	ASSERT(wpc->imap.br_startoff <= offset_fsb);
-	ASSERT(wpc->imap.br_startoff + wpc->imap.br_blockcount > offset_fsb);
+	ASSERT(wpc->iomap.offset <= offset);
+	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
 	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
 	return 0;
 }
@@ -664,7 +667,7 @@ xfs_submit_ioend(
 	/* Reserve log space if we might write beyond the on-disk inode size. */
 	if (!status &&
 	    (ioend->io_fork == XFS_COW_FORK ||
-	     ioend->io_state != XFS_EXT_UNWRITTEN) &&
+	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
 	    !ioend->io_append_trans)
 		status = xfs_setfilesize_trans_alloc(ioend);
@@ -693,10 +696,8 @@ xfs_submit_ioend(
 static struct xfs_ioend *
 xfs_alloc_ioend(
 	struct inode		*inode,
-	int			fork,
-	xfs_exntst_t		state,
+	struct xfs_writepage_ctx *wpc,
 	xfs_off_t		offset,
-	struct block_device	*bdev,
 	sector_t		sector,
 	struct writeback_control *wbc)
 {
@@ -704,7 +705,7 @@ xfs_alloc_ioend(
 	struct bio		*bio;
 
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
-	bio_set_dev(bio, bdev);
+	bio_set_dev(bio, wpc->iomap.bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	bio->bi_write_hint = inode->i_write_hint;
@@ -712,8 +713,8 @@ xfs_alloc_ioend(
 
 	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_fork = fork;
-	ioend->io_state = state;
+	ioend->io_fork = wpc->fork;
+	ioend->io_type = wpc->iomap.type;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
@@ -761,26 +762,19 @@ xfs_add_to_ioend(
 	struct writeback_control *wbc,
 	struct list_head	*iolist)
 {
-	struct xfs_inode	*ip = XFS_I(inode);
-	struct xfs_mount	*mp = ip->i_mount;
-	struct block_device	*bdev = xfs_find_bdev_for_inode(inode);
+	sector_t		sector = iomap_sector(&wpc->iomap, offset);
 	unsigned		len = i_blocksize(inode);
 	unsigned		poff = offset & (PAGE_SIZE - 1);
 	bool			merged, same_page = false;
-	sector_t		sector;
-
-	sector = xfs_fsb_to_db(ip, wpc->imap.br_startblock) +
-		((offset - XFS_FSB_TO_B(mp, wpc->imap.br_startoff)) >> 9);
 
 	if (!wpc->ioend ||
 	    wpc->fork != wpc->ioend->io_fork ||
-	    wpc->imap.br_state != wpc->ioend->io_state ||
+	    wpc->iomap.type != wpc->ioend->io_type ||
 	    sector != bio_end_sector(wpc->ioend->io_bio) ||
 	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = xfs_alloc_ioend(inode, wpc->fork,
-				wpc->imap.br_state, offset, bdev, sector, wbc);
+		wpc->ioend = xfs_alloc_ioend(inode, wpc, offset, sector, wbc);
 	}
 
 	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
@@ -894,7 +888,7 @@ xfs_writepage_map(
 		error = xfs_map_blocks(wpc, inode, file_offset);
 		if (error)
 			break;
-		if (wpc->imap.br_startblock == HOLESTARTBLOCK)
+		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
 		xfs_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
 				 &submit_list);
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 45a1ea240cbb..4af8ec0115cd 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -14,7 +14,7 @@ extern struct bio_set xfs_ioend_bioset;
 struct xfs_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
 	int			io_fork;	/* inode fork written back */
-	xfs_exntst_t		io_state;	/* extent state */
+	u16			io_type;
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	xfs_off_t		io_offset;	/* offset in the file */
-- 
2.20.1

