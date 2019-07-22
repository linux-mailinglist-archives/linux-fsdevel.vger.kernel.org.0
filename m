Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089B06FD01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfGVJvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 05:51:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfGVJun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QL/0SYWiR6C25cou03spGMO5E9EMENslX5CyuOQ1xdQ=; b=DX0005aqvUGWmaQ85RsDdUNbo7
        OGjmkm4ghe4w85xh6CDJUJdMyg/1bA7CRJ9df4sqBsCLwcpflo6mkaZ5KyhFcMm6mJqJidIVDu3oM
        MRyVV4X3ixTRjLBaqvslnuRb3hazZhW8VWFaCKJxaIUY6drj+6LFeVEr0/NHNFaxLCpBO5J+Nhtrn
        S8pDTris/r0/MWo8PDH/ZyOp746nLBlpYFjtJ4CyJHjMwuhjkQ3pYFIlm2CfAeBCx0osagHlh4//z
        ZZR9W8oKo+/ajYCdnSRlwp2brDupIBpvREU1+VxXWubyF2qHEwFVTro1Wfgaaq1gRDDiVOO2j7YT/
        ik3qMJOw==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUxs-0005cX-0Z; Mon, 22 Jul 2019 09:50:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] xfs: turn io_append_trans into an io_private void pointer
Date:   Mon, 22 Jul 2019 11:50:17 +0200
Message-Id: <20190722095024.19075-6-hch@lst.de>
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

In preparation for moving the ioend structure to common code we need
to get rid of the xfs-specific xfs_trans type.  Just make it a file
system private void pointer instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c | 26 +++++++++++++-------------
 fs/xfs/xfs_aops.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8a1cd562a358..12f42922251c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -150,7 +150,7 @@ xfs_setfilesize_trans_alloc(
 	if (error)
 		return error;
 
-	ioend->io_append_trans = tp;
+	ioend->io_private = tp;
 
 	/*
 	 * We may pass freeze protection with a transaction.  So tell lockdep
@@ -217,7 +217,7 @@ xfs_setfilesize_ioend(
 	int			error)
 {
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
-	struct xfs_trans	*tp = ioend->io_append_trans;
+	struct xfs_trans	*tp = ioend->io_private;
 
 	/*
 	 * The transaction may have been allocated in the I/O submission thread,
@@ -282,10 +282,10 @@ xfs_end_ioend(
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
@@ -318,13 +318,13 @@ xfs_ioend_can_merge(
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
@@ -346,8 +346,8 @@ xfs_ioend_try_merge(
 			break;
 		list_move_tail(&next->io_list, &ioend->io_list);
 		ioend->io_size += next->io_size;
-		if (next->io_append_trans)
-			xfs_ioend_merge_append_transactions(ioend, next);
+		if (next->io_private)
+			xfs_ioend_merge_private(ioend, next);
 	}
 }
 
@@ -410,7 +410,7 @@ xfs_end_bio(
 
 	if (ioend->io_fork == XFS_COW_FORK ||
 	    ioend->io_type == IOMAP_UNWRITTEN ||
-	    ioend->io_append_trans != NULL) {
+	    ioend->io_private) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
 		if (list_empty(&ip->i_ioend_list))
 			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
@@ -675,7 +675,7 @@ xfs_submit_ioend(
 	    (ioend->io_fork == XFS_COW_FORK ||
 	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
-	    !ioend->io_append_trans)
+	    !ioend->io_private)
 		status = xfs_setfilesize_trans_alloc(ioend);
 
 	memalloc_nofs_restore(nofs_flag);
@@ -724,7 +724,7 @@ xfs_alloc_ioend(
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

