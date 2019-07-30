Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C730179DE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfG3BVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:21:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfG3BVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:21:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18eEg095542;
        Tue, 30 Jul 2019 01:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=z/3AwJYxfd9ZldKMi25xhX++8r7wdar2uNG2dshCkh4=;
 b=pnlq38FPhdFTHDKVN0RvE/77STImdHDxAla0RbHgft8CGxoT0OOPrawMjaXdjYNrSqc6
 f62eRBcQStZSZZvMeeJev+ss8Tw+u+kr9v0tAGT5DdsVFGJbr5xJBh+1NVKQwa5rpQXZ
 ksgcgjLH2mM+aflsbaqDjHqt1Aby7zlGrtOVWZMCkfYgjfRTNbXrwbpQVwiU+Y+1S5Nx
 Va8f8PhpcDa3dJ3LYmbn+748gfOgu2cJ06lvikwlyCviFYvMJGwtlSK9BXh7SOSBI0/i
 8QBMeTZRqM8K79rbI1GUm+qVpD7v2JHTQL4nOp3Y6q1Ka7U/7XyMsRVvErNH+yDjChA6 zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u0ejpb0k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1IR7c087589;
        Tue, 30 Jul 2019 01:18:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u0bqtt7r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6U1Im6h012473;
        Tue, 30 Jul 2019 01:18:48 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:18:47 -0700
Subject: [PATCH 1/5] xfs: use a struct iomap in xfs_writepage_ctx
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@lst.de>,
        agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:18:43 -0700
Message-ID: <156444952349.2682520.6180005494290997205.stgit@magnolia>
In-Reply-To: <156444951713.2682520.8109813555788585092.stgit@magnolia>
References: <156444951713.2682520.8109813555788585092.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

In preparation for moving the XFS writeback code to fs/iomap.c, switch
it to use struct iomap instead of the XFS-specific struct xfs_bmbt_irec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c |   14 ++++++--
 fs/xfs/libxfs/xfs_bmap.h |    3 +-
 fs/xfs/xfs_aops.c        |   82 +++++++++++++++++++++-------------------------
 fs/xfs/xfs_aops.h        |    2 +
 4 files changed, 50 insertions(+), 51 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index baf0b72c0a37..2a0d9427a9e2 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -34,6 +34,7 @@
 #include "xfs_ag_resv.h"
 #include "xfs_refcount.h"
 #include "xfs_icache.h"
+#include "xfs_iomap.h"
 
 
 kmem_zone_t		*xfs_bmap_free_item_zone;
@@ -4452,16 +4453,21 @@ int
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
@@ -4491,7 +4497,7 @@ xfs_bmapi_convert_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
-		*imap = bma.got;
+		xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
 		*seq = READ_ONCE(ifp->if_seq);
 		goto out_trans_cancel;
 	}
@@ -4524,7 +4530,7 @@ xfs_bmapi_convert_delalloc(
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
-	*imap = bma.got;
+	xfs_bmbt_to_iomap(ip, iomap, &bma.got, flags);
 	*seq = READ_ONCE(ifp->if_seq);
 
 	if (whichfork == XFS_COW_FORK) {
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 8f597f9abdbe..3c3470f11648 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -220,8 +220,7 @@ int	xfs_bmapi_reserve_delalloc(struct xfs_inode *ip, int whichfork,
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
index 4e4a4d7df5ac..8a1cd562a358 100644
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
@@ -279,7 +279,7 @@ xfs_end_ioend(
 	 */
 	if (ioend->io_fork == XFS_COW_FORK)
 		error = xfs_reflink_end_cow(ip, offset, size);
-	else if (ioend->io_state == XFS_EXT_UNWRITTEN)
+	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
 	else
 		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
@@ -303,8 +303,8 @@ xfs_ioend_can_merge(
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
@@ -409,7 +409,7 @@ xfs_end_bio(
 	unsigned long		flags;
 
 	if (ioend->io_fork == XFS_COW_FORK ||
-	    ioend->io_state == XFS_EXT_UNWRITTEN ||
+	    ioend->io_type == IOMAP_UNWRITTEN ||
 	    ioend->io_append_trans != NULL) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
 		if (list_empty(&ip->i_ioend_list))
@@ -429,10 +429,10 @@ static bool
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
@@ -459,7 +459,7 @@ xfs_imap_valid(
 
 /*
  * Pass in a dellalloc extent and convert it to real extents, return the real
- * extent that maps offset_fsb in wpc->imap.
+ * extent that maps offset_fsb in wpc->iomap.
  *
  * The current page is held locked so nothing could have removed the block
  * backing offset_fsb, although it could have moved from the COW to the data
@@ -469,23 +469,23 @@ static int
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
+	 * and put the result into wpc->imap.  Allocate in a loop because it may
+	 * take several attempts to allocate real blocks for a contiguous
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
@@ -525,7 +525,7 @@ xfs_map_blocks(
 	 * against concurrent updates and provides a memory barrier on the way
 	 * out that ensures that we always see the current value.
 	 */
-	if (xfs_imap_valid(wpc, ip, offset_fsb))
+	if (xfs_imap_valid(wpc, ip, offset))
 		return 0;
 
 	/*
@@ -558,7 +558,7 @@ xfs_map_blocks(
 	 * No COW extent overlap. Revalidate now that we may have updated
 	 * ->cow_seq. If the data mapping is still valid, we're done.
 	 */
-	if (xfs_imap_valid(wpc, ip, offset_fsb)) {
+	if (xfs_imap_valid(wpc, ip, offset)) {
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
 		return 0;
 	}
@@ -598,11 +598,11 @@ xfs_map_blocks(
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
@@ -622,12 +622,15 @@ xfs_map_blocks(
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
@@ -670,7 +673,7 @@ xfs_submit_ioend(
 	/* Reserve log space if we might write beyond the on-disk inode size. */
 	if (!status &&
 	    (ioend->io_fork == XFS_COW_FORK ||
-	     ioend->io_state != XFS_EXT_UNWRITTEN) &&
+	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
 	    !ioend->io_append_trans)
 		status = xfs_setfilesize_trans_alloc(ioend);
@@ -699,10 +702,8 @@ xfs_submit_ioend(
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
@@ -710,7 +711,7 @@ xfs_alloc_ioend(
 	struct bio		*bio;
 
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
-	bio_set_dev(bio, bdev);
+	bio_set_dev(bio, wpc->iomap.bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	bio->bi_write_hint = inode->i_write_hint;
@@ -718,8 +719,8 @@ xfs_alloc_ioend(
 
 	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_fork = fork;
-	ioend->io_state = state;
+	ioend->io_fork = wpc->fork;
+	ioend->io_type = wpc->iomap.type;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
@@ -767,26 +768,19 @@ xfs_add_to_ioend(
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
@@ -900,7 +894,7 @@ xfs_writepage_map(
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

