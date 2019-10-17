Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFFEDB539
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441154AbfJQR4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:56:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440825AbfJQR4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dGE1e6QGCr6mlDbPZ1DEM4nkZzDRC+vGjZxbRr95UU0=; b=PulMIdKJOqc2U79z/0dPMjkMdm
        tlILLsLraj4oaDGw9mbZ+AqQ8lRXtiCJgq1L7L65auJqycQJYNZTm3x/i2lhyqLJajCn/mXSBddO5
        dA9p7wULoQlZUf2vM0ktcxt56psttfNohJUixR8+7Ia72snutahOC2Qp7fiVd+oWTpdB0+SM5I+Qx
        9cY1M9pZSYZEXmQ4Y3ydYw7bKLkwzx8SRoxklyYbt15pFOraqSxhoePJNnMi7Ej+moSeE6gzB77GD
        Yfg/vROwibozElL0uJqPKPojltYshdRbpq7eG5WKev604HvPiiLS6q7UcgBH9J3DwoFmtxA1DSVo6
        e0I/KO+w==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA10-0000zJ-RX; Thu, 17 Oct 2019 17:56:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 07/14] xfs: remove the fork fields in the writepage_ctx and ioend
Date:   Thu, 17 Oct 2019 19:56:17 +0200
Message-Id: <20191017175624.30305-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
References: <20191017175624.30305-1-hch@lst.de>
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
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c | 71 ++++++++++++++++++++++++++++++-----------------
 fs/xfs/xfs_aops.h |  2 +-
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index df5955388adc..00fe40b35f72 100644
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
@@ -272,7 +271,7 @@ xfs_end_ioend(
 	 */
 	error = blk_status_to_errno(ioend->io_bio->bi_status);
 	if (unlikely(error)) {
-		if (ioend->io_fork == XFS_COW_FORK)
+		if (ioend->io_flags & IOMAP_F_SHARED)
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
 		goto done;
 	}
@@ -280,7 +279,7 @@ xfs_end_ioend(
 	/*
 	 * Success: commit the COW or unwritten blocks if needed.
 	 */
-	if (ioend->io_fork == XFS_COW_FORK)
+	if (ioend->io_flags & IOMAP_F_SHARED)
 		error = xfs_reflink_end_cow(ip, offset, size);
 	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
@@ -304,7 +303,8 @@ xfs_ioend_can_merge(
 {
 	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
 		return false;
-	if ((ioend->io_fork == XFS_COW_FORK) ^ (next->io_fork == XFS_COW_FORK))
+	if ((ioend->io_flags & IOMAP_F_SHARED) ^
+	    (next->io_flags & IOMAP_F_SHARED))
 		return false;
 	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
 	    (next->io_type == IOMAP_UNWRITTEN))
@@ -404,6 +404,13 @@ xfs_end_io(
 	}
 }
 
+static inline bool xfs_ioend_needs_workqueue(struct xfs_ioend *ioend)
+{
+	return ioend->io_private ||
+		ioend->io_type == IOMAP_UNWRITTEN ||
+		(ioend->io_flags & IOMAP_F_SHARED);
+}
+
 STATIC void
 xfs_end_bio(
 	struct bio		*bio)
@@ -413,9 +420,7 @@ xfs_end_bio(
 	struct xfs_mount	*mp = ip->i_mount;
 	unsigned long		flags;
 
-	if (ioend->io_fork == XFS_COW_FORK ||
-	    ioend->io_type == IOMAP_UNWRITTEN ||
-	    ioend->io_private) {
+	if (xfs_ioend_needs_workqueue(ioend)) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
 		if (list_empty(&ip->i_ioend_list))
 			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
@@ -444,7 +449,7 @@ xfs_imap_valid(
 	 * covers the offset. Be careful to check this first because the caller
 	 * can revalidate a COW mapping without updating the data seqno.
 	 */
-	if (wpc->fork == XFS_COW_FORK)
+	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		return true;
 
 	/*
@@ -474,6 +479,7 @@ static int
 xfs_convert_blocks(
 	struct xfs_writepage_ctx *wpc,
 	struct xfs_inode	*ip,
+	int			whichfork,
 	loff_t			offset)
 {
 	int			error;
@@ -485,8 +491,8 @@ xfs_convert_blocks(
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
@@ -507,6 +513,7 @@ xfs_map_blocks(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, offset + count);
 	xfs_fileoff_t		cow_fsb = NULLFILEOFF;
+	int			whichfork = XFS_DATA_FORK;
 	struct xfs_bmbt_irec	imap;
 	struct xfs_iext_cursor	icur;
 	int			retries = 0;
@@ -555,7 +562,7 @@ xfs_map_blocks(
 		wpc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-		wpc->fork = XFS_COW_FORK;
+		whichfork = XFS_COW_FORK;
 		goto allocate_blocks;
 	}
 
@@ -578,8 +585,6 @@ xfs_map_blocks(
 	wpc->data_seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
-	wpc->fork = XFS_DATA_FORK;
-
 	/* landed in a hole or beyond EOF? */
 	if (imap.br_startoff > offset_fsb) {
 		imap.br_blockcount = imap.br_startoff - offset_fsb;
@@ -604,10 +609,10 @@ xfs_map_blocks(
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
@@ -616,7 +621,7 @@ xfs_map_blocks(
 		 * the former case, but prevent additional retries to avoid
 		 * looping forever for the latter case.
 		 */
-		if (error == -EAGAIN && wpc->fork == XFS_COW_FORK && !retries++)
+		if (error == -EAGAIN && whichfork == XFS_COW_FORK && !retries++)
 			goto retry;
 		ASSERT(error != -EAGAIN);
 		return error;
@@ -627,7 +632,7 @@ xfs_map_blocks(
 	 * original delalloc one.  Trim the return extent to the next COW
 	 * boundary again to force a re-lookup.
 	 */
-	if (wpc->fork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
+	if (whichfork != XFS_COW_FORK && cow_fsb != NULLFILEOFF) {
 		loff_t		cow_offset = XFS_FSB_TO_B(mp, cow_fsb);
 
 		if (cow_offset < wpc->iomap.offset + wpc->iomap.length)
@@ -636,7 +641,7 @@ xfs_map_blocks(
 
 	ASSERT(wpc->iomap.offset <= offset);
 	ASSERT(wpc->iomap.offset + wpc->iomap.length > offset);
-	trace_xfs_map_blocks_alloc(ip, offset, count, wpc->fork, &imap);
+	trace_xfs_map_blocks_alloc(ip, offset, count, whichfork, &imap);
 	return 0;
 }
 
@@ -670,14 +675,14 @@ xfs_submit_ioend(
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
@@ -724,8 +729,8 @@ xfs_alloc_ioend(
 
 	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
 	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_fork = wpc->fork;
 	ioend->io_type = wpc->iomap.type;
+	ioend->io_flags = wpc->iomap.flags;
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
@@ -759,6 +764,24 @@ xfs_chain_bio(
 	return new;
 }
 
+static bool
+xfs_can_add_to_ioend(
+	struct xfs_writepage_ctx *wpc,
+	xfs_off_t		offset,
+	sector_t		sector)
+{
+	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
+	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
+		return false;
+	if (wpc->iomap.type != wpc->ioend->io_type)
+		return false;
+	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
+		return false;
+	if (sector != bio_end_sector(wpc->ioend->io_bio))
+		return false;
+	return true;
+}
+
 /*
  * Test to see if we have an existing ioend structure that we could append to
  * first, otherwise finish off the current ioend and start another.
@@ -778,11 +801,7 @@ xfs_add_to_ioend(
 	unsigned		poff = offset & (PAGE_SIZE - 1);
 	bool			merged, same_page = false;
 
-	if (!wpc->ioend ||
-	    wpc->fork != wpc->ioend->io_fork ||
-	    wpc->iomap.type != wpc->ioend->io_type ||
-	    sector != bio_end_sector(wpc->ioend->io_bio) ||
-	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
+	if (!wpc->ioend || !xfs_can_add_to_ioend(wpc, offset, sector)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
 		wpc->ioend = xfs_alloc_ioend(inode, wpc, offset, sector, wbc);
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

