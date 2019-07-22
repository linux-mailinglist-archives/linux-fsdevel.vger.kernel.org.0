Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2016FD02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfGVJvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 05:51:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbfGVJup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DcAqO2yhuDxMoLZeJxJygvdpoO7YnAsQWYM+jGtG+XQ=; b=S2u6qZEtrGXp9A4rQRNF+9qID2
        spFE2sMluIlTn6LwMJ9M9oG+Uk0BF3oyuP3zmfFvzkZL4SB+HS2Tns3mpppdufbfrlYb0WeZm8xWu
        tuo9Lc6sd5Sow7vE2i9Nt7pNf65e9OXZB60EDG7QRE0wvnAopq9vsDUW+QdgmJ4XQGUardMaNJsjK
        Wpcnf3wN9dbmizscnfCtt9EL7YG9O71rzLrDIDG/oQt3eJXzWtfK3ro5O/qh+1aIH3d3N7cemLYgY
        8JHtduhadl8vR0Dv8AmQ5iBMLFV7Io94VfLxUtbLaQMbxxD8OZavPr12FB6SSnFLhO5/hqTLolhO5
        PNqMP24Q==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUxu-0005e3-Jt; Mon, 22 Jul 2019 09:50:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] xfs: remove the fork fields in the writepage_ctx and ioend
Date:   Mon, 22 Jul 2019 11:50:18 +0200
Message-Id: <20190722095024.19075-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
References: <20190722095024.19075-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for moving the writeback code to iomap.c, replace the
XFS-specific COW fork concept with the iomap IOMAP_F_SHARED flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c | 42 ++++++++++++++++++++++--------------------
 fs/xfs/xfs_aops.h |  2 +-
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 12f42922251c..93f1bf315585 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -23,7 +23,6 @@
  */
 struct xfs_writepage_ctx {
 	struct iomap		iomap;
-	int			fork;
 	unsigned int		data_seq;
 	unsigned int		cow_seq;
 	struct xfs_ioend	*ioend;
@@ -269,7 +268,7 @@ xfs_end_ioend(
 	 */
 	error = blk_status_to_errno(ioend->io_bio->bi_status);
 	if (unlikely(error)) {
-		if (ioend->io_fork == XFS_COW_FORK)
+		if (ioend->io_flags & IOMAP_F_SHARED)
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
 		goto done;
 	}
@@ -277,7 +276,7 @@ xfs_end_ioend(
 	/*
 	 * Success: commit the COW or unwritten blocks if needed.
 	 */
-	if (ioend->io_fork == XFS_COW_FORK)
+	if (ioend->io_flags & IOMAP_F_SHARED)
 		error = xfs_reflink_end_cow(ip, offset, size);
 	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
@@ -301,7 +300,8 @@ xfs_ioend_can_merge(
 {
 	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
 		return false;
-	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
+	if ((ioend->io_flags & IOMAP_F_SHARED) ^
+	    (next->io_flags & IOMAP_F_SHARED))
 		return false;
 	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
 	    (next->io_type == IOMAP_UNWRITTEN))
@@ -408,7 +408,7 @@ xfs_end_bio(
 	struct xfs_mount	*mp = ip->i_mount;
 	unsigned long		flags;
 
-	if (ioend->io_fork == XFS_COW_FORK ||
+	if ((ioend->io_flags & IOMAP_F_SHARED) ||
 	    ioend->io_type == IOMAP_UNWRITTEN ||
 	    ioend->io_private) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
@@ -439,7 +439,7 @@ xfs_imap_valid(
 	 * covers the offset. Be careful to check this first because the caller
 	 * can revalidate a COW mapping without updating the data seqno.
 	 */
-	if (wpc->fork == XFS_COW_FORK)
+	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		return true;
 
 	/*
@@ -469,6 +469,7 @@ static int
 xfs_convert_blocks(
 	struct xfs_writepage_ctx *wpc,
 	struct xfs_inode	*ip,
+	int			whichfork,
 	loff_t			offset)
 {
 	int			error;
@@ -480,8 +481,8 @@ xfs_convert_blocks(
 	 * delalloc extent if free space is sufficiently fragmented.
 	 */
 	do {
-		error = xfs_bmapi_convert_delalloc(ip, wpc->fork, offset,
-				&wpc->iomap, wpc->fork == XFS_COW_FORK ?
+		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
+				&wpc->iomap, whichfork == XFS_COW_FORK ?
 					&wpc->cow_seq : &wpc->data_seq);
 		if (error)
 			return error;
@@ -502,6 +503,7 @@ xfs_map_blocks(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
 	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
+	int			whichfork = XFS_DATA_FORK;
 	struct xfs_bmbt_irec	imap;
 	struct xfs_iext_cursor	icur;
 	int			retries = 0;
@@ -550,7 +552,7 @@ xfs_map_blocks(
 		wpc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-		wpc->fork = XFS_COW_FORK;
+		whichfork = XFS_COW_FORK;
 		goto allocate_blocks;
 	}
 
@@ -573,8 +575,6 @@ xfs_map_blocks(
 	wpc->data_seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-	wpc->fork = XFS_DATA_FORK;
-
 	/* landed in a hole or beyond EOF? */
 	if (imap.br_startoff > offset_fsb) {
 		imap.br_blockcount = imap.br_startoff - offset_fsb;
@@ -599,10 +599,10 @@ xfs_map_blocks(
 		goto allocate_blocks;
 
 	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0);
-	trace_xfs_map_blocks_found(ip, offset, count, wpc->fork, &imap);
+	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
-	error = xfs_convert_blocks(wpc, ip, offset);
+	error = xfs_convert_blocks(wpc, ip, whichfork, offset);
 	if (error) {
 		/*
 		 * If we failed to find the extent in the COW fork we might have
@@ -611,7 +611,8 @@ xfs_map_blocks(
 		 * the former case, but prevent additional retries to avoid
 		 * looping forever for the latter case.
 		 */
-		if (error == -EAGAIN && wpc->fork == XFS_COW_FORK && !retries++)
+		if (error == -EAGAIN && (wpc->iomap.flags & IOMAP_F_SHARED) &&
+		    !retries++)
 			goto retry;
 		ASSERT(error != -EAGAIN);
 		return error;
@@ -622,7 +623,7 @@ xfs_map_blocks(
 	 * original delalloc one.  Trim the return extent to the next COW
 	 * boundary again to force a re-lookup.
 	 */
-	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
+	if (!(wpc->iomap.flags & IOMAP_F_SHARED) && cow_fsb != NULLFILEOFF) {
 		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
 
 		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
@@ -631,7 +632,7 @@ xfs_map_blocks(
 
 	ASSERT(wpc->iomap.offset <= offset);
 	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
-	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
+	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
 	return 0;
 }
 
@@ -665,14 +666,14 @@ xfs_submit_ioend(
 	nofs_flag = memalloc_nofs_save();
 
 	/* Convert CoW extents to regular */
-	if (!status && ioend->io_fork == XFS_COW_FORK) {
+	if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
 		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
 				ioend->io_offset, ioend->io_size);
 	}
 
 	/* Reserve log space if we might write beyond the on-disk inode size. */
 	if (!status &&
-	    (ioend->io_fork == XFS_COW_FORK ||
+	    ((ioend->io_flags & IOMAP_F_SHARED) ||
 	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
 	    !ioend->io_private)
@@ -719,8 +720,8 @@ xfs_alloc_ioend(
 
 	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_fork = wpc->fork;
 	ioend->io_type = wpc->iomap.type;
+	ioend->io_flags = wpc->iomap.flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
@@ -774,7 +775,8 @@ xfs_add_to_ioend(
 	bool			merged, same_page = false;
 
 	if (!wpc->ioend ||
-	    wpc->fork != wpc->ioend->io_fork ||
+	    (wpc->iomap.flags & IOMAP_F_SHARED) !=
+	    (wpc->ioend->io_flags & IOMAP_F_SHARED) ||
 	    wpc->iomap.type != wpc->ioend->io_type ||
 	    sector != bio_end_sector(wpc->ioend->io_bio) ||
 	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 6a45d675dcba..4a0226cdad4f 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -13,8 +13,8 @@ extern struct bio_set xfs_ioend_bioset;
  */
 struct xfs_ioend {
 	struct list_head	io_list;	/* next ioend in chain */
-	int			io_fork;	/* inode fork written back */
 	u16			io_type;
+	u16			io_flags;	/* IOMAP_F_* */
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	xfs_off_t		io_offset;	/* offset in the file */
-- 
2.20.1

