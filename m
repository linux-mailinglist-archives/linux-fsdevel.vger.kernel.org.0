Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E125C537
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGAVzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:55:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H5iiLixQpBoYnoSWeGAijoRFuz0TrYtuZ+fjQILjz6Q=; b=J/E7EYiXP7KURncHP/I7TaurfZ
        f8GsL8/al9rM/Q8EwPLXDA2wIWiZArHbitOB3/meR60cNhxzSICFR83rjSn3fDx1E6GmPdsFO7Vof
        nfqLZlGtQnJTMEFeQI+Te6u/y9LYIRTvNZWJDWnWiTedsQjsb0Lllp8tierlZyegNzlwSd6boanGl
        Gre2ltK12b/LvSn3e0DN66tElt0ndRrPsuT33Y55e97l/KvzGGILWLwFJpyuEDO+AbhSIxGvX4Fvd
        9reTIFaKBqVdB1iJk48ocLl2h5SwLeXgtt88sk2gtIpJW3LfdpiLY9SBYdgNxkEYh8aMTwYxtufD0
        hJGqPF1w==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4GM-0000Wp-78; Mon, 01 Jul 2019 21:55:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 02/15] FOLD: iomap: make ->submit_ioend optional
Date:   Mon,  1 Jul 2019 23:54:26 +0200
Message-Id: <20190701215439.19162-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
References: <20190701215439.19162-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a default end_io handler that comple file systems can override
if they need deferred action.  With that we don't need an submit_ioend
method for simple file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c        | 26 +++++++++++++++++++++-----
 fs/xfs/xfs_aops.c | 23 ++++++++++-------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index ebfff663b2a9..7574f63939cc 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -2350,6 +2350,13 @@ iomap_sort_ioends(struct list_head *ioend_list)
 }
 EXPORT_SYMBOL_GPL(iomap_sort_ioends);
 
+static void iomap_writepage_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = bio->bi_private;
+
+	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
+}
+
 /*
  * Submit the bio for an ioend. We are passed an ioend with a bio attached to
  * it, and we submit that bio. The ioend may be used for multiple bio
@@ -2368,14 +2375,23 @@ static int
 iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 		int error)
 {
+	ioend->io_bio->bi_private = ioend;
+	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
+
 	/*
-	 * If we are failing the IO now, just mark the ioend with an error and
-	 * finish it.  This will run IO completion immediately as there is only
-	 * one reference to the ioend at this point in time.
+	 * File systems can perform actions at submit time and/or override
+	 * the end_io handler here for complex operations like copy on write
+	 * extent manipulation or unwritten extent conversions.
 	 */
-	ioend->io_bio->bi_private = ioend;
-	error = wpc->ops->submit_ioend(ioend, error);
+	if (wpc->ops->submit_ioend)
+		error = wpc->ops->submit_ioend(ioend, error);
 	if (error) {
+		/*
+		 * If we are failing the IO now, just mark the ioend with an
+		 * error and finish it.  This will run IO completion immediately
+		 * as there is only one reference to the ioend at this point in
+		 * time.
+		 */
 		ioend->io_bio->bi_status = errno_to_blk_status(error);
 		bio_endio(ioend->io_bio);
 		return error;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 0821312a1d11..ac1404bc583c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -265,20 +265,14 @@ xfs_end_bio(
 {
 	struct iomap_ioend	*ioend = bio->bi_private;
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
-	struct xfs_mount	*mp = ip->i_mount;
 	unsigned long		flags;
 
-	if ((ioend->io_flags & IOMAP_F_SHARED) ||
-	    ioend->io_type == IOMAP_UNWRITTEN ||
-	    ioend->io_private) {
-		spin_lock_irqsave(&ip->i_ioend_lock, flags);
-		if (list_empty(&ip->i_ioend_list))
-			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
-						 &ip->i_ioend_work));
-		list_add_tail(&ioend->io_list, &ip->i_ioend_list);
-		spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
-	} else
-		iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
+	spin_lock_irqsave(&ip->i_ioend_lock, flags);
+	if (list_empty(&ip->i_ioend_list))
+		WARN_ON_ONCE(!queue_work(ip->i_mount->m_unwritten_workqueue,
+					 &ip->i_ioend_work));
+	list_add_tail(&ioend->io_list, &ip->i_ioend_list);
+	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 }
 
 /*
@@ -531,7 +525,10 @@ xfs_submit_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
-	ioend->io_bio->bi_end_io = xfs_end_bio;
+	if ((ioend->io_flags & IOMAP_F_SHARED) ||
+	    ioend->io_type == IOMAP_UNWRITTEN ||
+	    ioend->io_private)
+		ioend->io_bio->bi_end_io = xfs_end_bio;
 	return status;
 }
 
-- 
2.20.1

