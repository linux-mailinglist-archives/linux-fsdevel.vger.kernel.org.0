Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1C501A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfFXFxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 01:53:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfFXFxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=//DYfOpEMU7kNFvGSRLB7oTmBaBAqXAsZxH+fPTIU08=; b=eIINl8Uo7JjnHFtmadoV6ttrwW
        njCXzKXgLqNDi8Bxt79tVKbF0WcE11lKhVVzUev7yTeK8Osf+2a8HbuNgi7HfNs1SAnSF4Dp1YkV0
        3LIH+AOqgqgEm0hwt0muoEtLSXGE/+nwmbGcY8b/7EhJSYX1+9oqUd/x2vz8VW0AnVQReD5aplVM2
        TFe6OFH/Pf3kHO8KhTpQ/jFR0l3Alv5ykPras8+0pgt3LNG2DLUv8uMKH8RRQsQUkyaEfENGRjTIQ
        tYKMQiFIF1lUstfvIdY26EvM1afqtE/xnSeYuECZgBUpXMQBgylkVzV3akYkUaYS88JFA1weBo5TO
        xz0aGOUw==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHun-000463-87; Mon, 24 Jun 2019 05:53:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] xfs: don't preallocate a transaction for file size updates
Date:   Mon, 24 Jun 2019 07:52:48 +0200
Message-Id: <20190624055253.31183-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624055253.31183-1-hch@lst.de>
References: <20190624055253.31183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have historically decided that we want to preallocate the xfs_trans
structure at writeback time so that we don't have to allocate on in
the I/O completion handler.  But we treat unwrittent extent and COW
fork conversions different already, which proves that the transaction
allocations in the end I/O handler are not a problem.  Removing the
preallocation gets rid of a lot of corner case code, and also ensures
we only allocate one and log a transaction when actually required,
as the ioend merging can reduce the number of actual i_size updates
significantly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c | 110 +++++-----------------------------------------
 fs/xfs/xfs_aops.h |   1 -
 2 files changed, 12 insertions(+), 99 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 633baaaff7ae..017b87b7765f 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -130,44 +130,23 @@ static inline bool xfs_ioend_is_append(struct xfs_ioend *ioend)
 		XFS_I(ioend->io_inode)->i_d.di_size;
 }
 
-STATIC int
-xfs_setfilesize_trans_alloc(
-	struct xfs_ioend	*ioend)
-{
-	struct xfs_mount	*mp = XFS_I(ioend->io_inode)->i_mount;
-	struct xfs_trans	*tp;
-	int			error;
-
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
-	if (error)
-		return error;
-
-	ioend->io_append_trans = tp;
-
-	/*
-	 * We may pass freeze protection with a transaction.  So tell lockdep
-	 * we released it.
-	 */
-	__sb_writers_release(ioend->io_inode->i_sb, SB_FREEZE_FS);
-	/*
-	 * We hand off the transaction to the completion thread now, so
-	 * clear the flag here.
-	 */
-	current_restore_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-	return 0;
-}
-
 /*
  * Update on-disk file size now that data has been written to disk.
  */
-STATIC int
-__xfs_setfilesize(
+int
+xfs_setfilesize(
 	struct xfs_inode	*ip,
-	struct xfs_trans	*tp,
 	xfs_off_t		offset,
 	size_t			size)
 {
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
 	xfs_fsize_t		isize;
+	int			error;
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
+	if (error)
+		return error;
 
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	isize = xfs_new_eof(ip, offset + size);
@@ -186,48 +165,6 @@ __xfs_setfilesize(
 	return xfs_trans_commit(tp);
 }
 
-int
-xfs_setfilesize(
-	struct xfs_inode	*ip,
-	xfs_off_t		offset,
-	size_t			size)
-{
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
-	int			error;
-
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
-	if (error)
-		return error;
-
-	return __xfs_setfilesize(ip, tp, offset, size);
-}
-
-STATIC int
-xfs_setfilesize_ioend(
-	struct xfs_ioend	*ioend,
-	int			error)
-{
-	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
-	struct xfs_trans	*tp = ioend->io_append_trans;
-
-	/*
-	 * The transaction may have been allocated in the I/O submission thread,
-	 * thus we need to mark ourselves as being in a transaction manually.
-	 * Similarly for freeze protection.
-	 */
-	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
-
-	/* we abort the update if there was an IO error */
-	if (error) {
-		xfs_trans_cancel(tp);
-		return error;
-	}
-
-	return __xfs_setfilesize(ip, tp, ioend->io_offset, ioend->io_size);
-}
-
 /*
  * IO write completion.
  */
@@ -267,12 +204,9 @@ xfs_end_ioend(
 		error = xfs_reflink_end_cow(ip, offset, size);
 	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
-	else
-		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
-
+	if (!error && xfs_ioend_is_append(ioend))
+		error = xfs_setfilesize(ip, offset, size);
 done:
-	if (ioend->io_append_trans)
-		error = xfs_setfilesize_ioend(ioend, error);
 	list_replace_init(&ioend->io_list, &ioend_list);
 	xfs_destroy_ioend(ioend, error);
 
@@ -307,8 +241,6 @@ xfs_ioend_can_merge(
 		return false;
 	if (ioend->io_offset + ioend->io_size != next->io_offset)
 		return false;
-	if (xfs_ioend_is_append(ioend) != xfs_ioend_is_append(next))
-		return false;
 	return true;
 }
 
@@ -320,7 +252,6 @@ xfs_ioend_try_merge(
 {
 	struct xfs_ioend	*next_ioend;
 	int			ioend_error;
-	int			error;
 
 	if (list_empty(more_ioends))
 		return;
@@ -334,10 +265,6 @@ xfs_ioend_try_merge(
 			break;
 		list_move_tail(&next_ioend->io_list, &ioend->io_list);
 		ioend->io_size += next_ioend->io_size;
-		if (ioend->io_append_trans) {
-			error = xfs_setfilesize_ioend(next_ioend, 1);
-			ASSERT(error == 1);
-		}
 	}
 }
 
@@ -398,7 +325,7 @@ xfs_end_bio(
 
 	if (ioend->io_fork == XFS_COW_FORK ||
 	    ioend->io_type == IOMAP_UNWRITTEN ||
-	    ioend->io_append_trans != NULL) {
+	    xfs_ioend_is_append(ioend)) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
 		if (list_empty(&ip->i_ioend_list))
 			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
@@ -660,18 +587,6 @@ xfs_submit_ioend(
 		memalloc_nofs_restore(nofs_flag);
 	}
 
-	/* Reserve log space if we might write beyond the on-disk inode size. */
-	if (!status &&
-	    (ioend->io_fork == XFS_COW_FORK ||
-	     ioend->io_type != IOMAP_UNWRITTEN) &&
-	    xfs_ioend_is_append(ioend) &&
-	    !ioend->io_append_trans) {
-		unsigned nofs_flag = memalloc_nofs_save();
-
-		status = xfs_setfilesize_trans_alloc(ioend);
-		memalloc_nofs_restore(nofs_flag);
-	}
-
 	ioend->io_bio->bi_private = ioend;
 	ioend->io_bio->bi_end_io = xfs_end_bio;
 
@@ -715,7 +630,6 @@ xfs_alloc_ioend(
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
-	ioend->io_append_trans = NULL;
 	ioend->io_bio = bio;
 	return ioend;
 }
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 72e30d1c3bdf..23c087f0bcbf 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -18,7 +18,6 @@ struct xfs_ioend {
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	xfs_off_t		io_offset;	/* offset in the file */
-	struct xfs_trans	*io_append_trans;/* xact. for size update */
 	struct bio		*io_bio;	/* bio being built */
 	struct bio		io_inline_bio;	/* MUST BE LAST! */
 };
-- 
2.20.1

