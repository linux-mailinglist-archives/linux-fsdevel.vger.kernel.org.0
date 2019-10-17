Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2D8DB53B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441028AbfJQR4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:56:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440825AbfJQR4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vEdFgDFkS2yumQvn6A/BOyLV7mHdreaTf14NtVspvAw=; b=a8Xht+tjM2ya+d2RxnJUOTJjbd
        ZafySHElDplNM1pu9EDPxYgoxk2mYpaiJxDAdLEGst/pMmCXJPSTNMFUG5ZdvatG49kkor11V7VuB
        KxaNaOiQ6xowvPIri2pyEvJM2nlfmh6nGYgnJ/c2EhB77E6QkiprsEdgPsLgtP46Ttne+49sYNIpv
        c6k7SyL2dxM4vQeb7GccsxollvWOdvJmQG1ptyCkBpSsvO09FgUKZLIgImrNlOtHiK/LeMA8vGGnM
        zA1Dl62dScY8xrd3qpTXflRQDkHRFIOsmnGh7oBvwX+FUXXsnuThz6FYNk/XqXfcjZSUjlPyMXJo0
        kJj5bNTA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA0y-0000w3-7c; Thu, 17 Oct 2019 17:56:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 06/14] xfs: turn io_append_trans into an io_private void pointer
Date:   Thu, 17 Oct 2019 19:56:16 +0200
Message-Id: <20191017175624.30305-7-hch@lst.de>
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

In preparation for moving the ioend structure to common code we need
to get rid of the xfs-specific xfs_trans type.  Just make it a file
system private void pointer instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c | 26 +++++++++++++-------------
 fs/xfs/xfs_aops.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index c29ef69d1e51..df5955388adc 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -153,7 +153,7 @@ xfs_setfilesize_trans_alloc(
 	if (error)
 		return error;
 
-	ioend->io_append_trans = tp;
+	ioend->io_private = tp;
 
 	/*
 	 * We may pass freeze protection with a transaction.  So tell lockdep
@@ -220,7 +220,7 @@ xfs_setfilesize_ioend(
 	int			error)
 {
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
-	struct xfs_trans	*tp = ioend->io_append_trans;
+	struct xfs_trans	*tp = ioend->io_private;
 
 	/*
 	 * The transaction may have been allocated in the I/O submission thread,
@@ -285,10 +285,10 @@ xfs_end_ioend(
 	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
 	else
-		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
+		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_private);
 
 done:
-	if (ioend->io_append_trans)
+	if (ioend->io_private)
 		error = xfs_setfilesize_ioend(ioend, error);
 	xfs_destroy_ioends(ioend, error);
 	memalloc_nofs_restore(nofs_flag);
@@ -321,13 +321,13 @@ xfs_ioend_can_merge(
  * as it is guaranteed to be clean.
  */
 static void
-xfs_ioend_merge_append_transactions(
+xfs_ioend_merge_private(
 	struct xfs_ioend	*ioend,
 	struct xfs_ioend	*next)
 {
-	if (!ioend->io_append_trans) {
-		ioend->io_append_trans = next->io_append_trans;
-		next->io_append_trans = NULL;
+	if (!ioend->io_private) {
+		ioend->io_private = next->io_private;
+		next->io_private = NULL;
 	} else {
 		xfs_setfilesize_ioend(next, -ECANCELED);
 	}
@@ -349,8 +349,8 @@ xfs_ioend_try_merge(
 			break;
 		list_move_tail(&next->io_list, &ioend->io_list);
 		ioend->io_size += next->io_size;
-		if (next->io_append_trans)
-			xfs_ioend_merge_append_transactions(ioend, next);
+		if (next->io_private)
+			xfs_ioend_merge_private(ioend, next);
 	}
 }
 
@@ -415,7 +415,7 @@ xfs_end_bio(
 
 	if (ioend->io_fork == XFS_COW_FORK ||
 	    ioend->io_type == IOMAP_UNWRITTEN ||
-	    ioend->io_append_trans != NULL) {
+	    ioend->io_private) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
 		if (list_empty(&ip->i_ioend_list))
 			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
@@ -680,7 +680,7 @@ xfs_submit_ioend(
 	    (ioend->io_fork == XFS_COW_FORK ||
 	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
-	    !ioend->io_append_trans)
+	    !ioend->io_private)
 		status = xfs_setfilesize_trans_alloc(ioend);
 
 	memalloc_nofs_restore(nofs_flag);
@@ -729,7 +729,7 @@ xfs_alloc_ioend(
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
-	ioend->io_append_trans = NULL;
+	ioend->io_private = NULL;
 	ioend->io_bio = bio;
 	return ioend;
 }
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 4af8ec0115cd..6a45d675dcba 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -18,7 +18,7 @@ struct xfs_ioend {
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	xfs_off_t		io_offset;	/* offset in the file */
-	struct xfs_trans	*io_append_trans;/* xact. for size update */
+	void			*io_private;	/* file system private data */
 	struct bio		*io_bio;	/* bio being built */
 	struct bio		io_inline_bio;	/* MUST BE LAST! */
 };
-- 
2.20.1

