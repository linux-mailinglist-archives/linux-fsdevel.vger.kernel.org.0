Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548D1A691C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfICM5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 08:57:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICM5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wRZ62gYcY3l9ES1kuF7j97VnjkkxVJoyCb7Lo/Cs0a8=; b=Ane8CpRF3AYL04VzuTWEnTjqzx
        jgnd3b8rZemSIRheFVWl/L+udfNbZusJJDMVoHv05XSqDgtl8a8vYdFFiPpvz9FEl45roiq4paxtU
        kPjuW0jBsi7Enpyn8rkbis9eYv6G1WTiAZ+jMKQtfU0DzrLxtE/D7HUyuDTMhouBtkgTUXRkHKKmB
        0DWIbPuHL6ur0T1W/Aa4PVEgXyh9Q+1/iZnAYmGfJDp5qAnJOpz2ZujfiNB7d1vff40bnZ4/9+4gH
        SsKVO8dxEd/de/q71nSnlaJlkUs/9El32uJypsvE9JkZGm5wr/Jf7D4tUGAcKW6SG88IN5ewHcUES
        yxRcpn0w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i58Nd-0002BT-4v; Tue, 03 Sep 2019 12:57:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     darrick.wong@oracle.com, linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH 3/5] xfs: remove the fork fields in the writepage_ctx and ioend
Date:   Tue,  3 Sep 2019 14:57:41 +0200
Message-Id: <20190903125743.2970-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903125743.2970-1-hch@lst.de>
References: <20190903125743.2970-1-hch@lst.de>
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
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c | 42 ++++++++++++++++++++++--------------------
 fs/xfs/xfs_aops.h |  2 +-
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b9255ea91a5c..236dc8371d97 100644
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

