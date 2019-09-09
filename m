Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA0ADEF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbfIIS2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:28:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZzFusGIfHg9iXxnsWEgkJc/5L9ZSf9UTJPCz7Ga6hPM=; b=DUqjbZMrhrfiWLXyNy8qS/3v1
        VOLr3XdJyFCQAFJd12Ogfdy9L6C/INw8P2eyr1KfnttqWknExdCwyMxiOHzX4Uba+rmDhDVb/7Fb5
        392BThCKVLbm4/CorXWplL7UwBglbnPkJ/BgNV//WdPrz++bqID0/2wf/7AZZ+WqUi6swQDOZkJ9r
        hRVD8BAkKN3dVCwm2hjbRw5u4Z8eg2ldb8nzb/MBD3BD2ed2rChZa8eHSHtbMbXJxgJXiPIsOUEo7
        LgUsbgK62pM+hgCBSKGZt/a8IgE4ZgdKEmO4HV/f8O2B6e/SkYHg9ZUwNqWXVAPbr1b9rUt0ZeRnh
        wp2rQrFTQ==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7OOb-00028O-5P; Mon, 09 Sep 2019 18:28:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/19] xfs: cleanup xfs_iomap_write_unwritten
Date:   Mon,  9 Sep 2019 20:27:21 +0200
Message-Id: <20190909182722.16783-19-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move more checks into the helpers that determine if we need a COW
operation or allocation and split the return path for when an existing
data for allocation has been found versus a new allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 74 ++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 0e575ca1e3fc..e4e79aa5b695 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -642,23 +642,42 @@ xfs_iomap_write_unwritten(
 static inline bool
 imap_needs_alloc(
 	struct inode		*inode,
+	unsigned		flags,
 	struct xfs_bmbt_irec	*imap,
 	int			nimaps)
 {
-	return !nimaps ||
-		imap->br_startblock == HOLESTARTBLOCK ||
-		imap->br_startblock == DELAYSTARTBLOCK ||
-		(IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN);
+	/* don't allocate blocks when just zeroing */
+	if (flags & IOMAP_ZERO)
+		return false;
+	if (!nimaps ||
+	    imap->br_startblock == HOLESTARTBLOCK ||
+	    imap->br_startblock == DELAYSTARTBLOCK)
+		return true;
+	/* we convert unwritten extents before copying the data for DAX */
+	if (IS_DAX(inode) && imap->br_state == XFS_EXT_UNWRITTEN)
+		return true;
+	return false;
 }
 
 static inline bool
-needs_cow_for_zeroing(
+imap_needs_cow(
+	struct xfs_inode	*ip,
 	struct xfs_bmbt_irec	*imap,
+	unsigned int		flags,
 	int			nimaps)
 {
-	return nimaps &&
-		imap->br_startblock != HOLESTARTBLOCK &&
-		imap->br_state != XFS_EXT_UNWRITTEN;
+	if (!xfs_is_cow_inode(ip))
+		return false;
+
+	/* when zeroing we don't have to COW holes or unwritten extents */
+	if (flags & IOMAP_ZERO) {
+		if (!nimaps ||
+		    imap->br_startblock == HOLESTARTBLOCK ||
+		    imap->br_state == XFS_EXT_UNWRITTEN)
+			return false;
+	}
+
+	return true;
 }
 
 static int
@@ -734,7 +753,6 @@ xfs_direct_write_iomap_begin(
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
-	u16			iomap_flags = 0;
 	unsigned		lockmode;
 
 	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
@@ -761,12 +779,7 @@ xfs_direct_write_iomap_begin(
 	 * Break shared extents if necessary. Checks for non-blocking IO have
 	 * been done up front, so we don't need to do them here.
 	 */
-	if (xfs_is_cow_inode(ip)) {
-		/* if zeroing doesn't need COW allocation, then we are done. */
-		if ((flags & IOMAP_ZERO) &&
-		    !needs_cow_for_zeroing(&imap, nimaps))
-			goto out_found;
-
+	if (imap_needs_cow(ip, &imap, flags, nimaps)) {
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
 				&lockmode, flags & IOMAP_DIRECT);
@@ -778,18 +791,17 @@ xfs_direct_write_iomap_begin(
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	/* Don't need to allocate over holes when doing zeroing operations. */
-	if (flags & IOMAP_ZERO)
-		goto out_found;
+	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+		goto allocate_blocks;
 
-	if (!imap_needs_alloc(inode, &imap, nimaps))
-		goto out_found;
+	xfs_iunlock(ip, lockmode);
+	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
 
-	/* If nowait is set bail since we are going to make allocations. */
-	if (flags & IOMAP_NOWAIT) {
-		error = -EAGAIN;
+allocate_blocks:
+	error = -EAGAIN;
+	if (flags & IOMAP_NOWAIT)
 		goto out_unlock;
-	}
 
 	/*
 	 * We cap the maximum length we map to a sane size  to keep the chunks
@@ -808,22 +820,12 @@ xfs_direct_write_iomap_begin(
 	 */
 	if (lockmode == XFS_ILOCK_EXCL)
 		xfs_ilock_demote(ip, lockmode);
-	error = xfs_iomap_write_direct(ip, offset, length, &imap,
-			nimaps);
+	error = xfs_iomap_write_direct(ip, offset, length, &imap, nimaps);
 	if (error)
 		return error;
 
-	iomap_flags |= IOMAP_F_NEW;
 	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
-
-out_finish:
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
-
-out_found:
-	ASSERT(nimaps);
-	xfs_iunlock(ip, lockmode);
-	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	goto out_finish;
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
 
 out_found_cow:
 	xfs_iunlock(ip, lockmode);
-- 
2.20.1

