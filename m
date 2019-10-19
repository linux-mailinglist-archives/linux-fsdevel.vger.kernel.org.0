Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA6DD933
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfJSOph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfJSOph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eGlRvof0fQ1r5cyh5RaEErlpbpsdm83DtZKCzC6ilrM=; b=TVqdFskUlegopKA8zaYmvIkww+
        LZVBNn7flIX6oEv3kStg0f7ioNDL22FFeIS0vLwJZx0f6n7LMkTkn04r4zJkdphlVWDXVPRCraNPQ
        XR5BxY0aRhyHzcMHFrSd3hgEnKII8KKVL4U4YXK+klITFZ8TL1OQrUPcunoum4biYe/Imqb5Iv+EN
        d4DvtSrX0jCptxPFxrIzn5Jo8/SmyfdFjc10frDCYtlXZHAFypl9TD9Tk5jNJFE/eoIWYw9P9m9Qn
        KJVUmgm6mhEjEiYxatfCPeExW42rIf2QAeQ4onJZMGIwBju3qo4duqGUYZnMk2wO63izLeuqHpyW6
        BGM4vb7w==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpz5-0003Cn-R1; Sat, 19 Oct 2019 14:45:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 11/12] xfs: cleanup xfs_direct_write_iomap_begin
Date:   Sat, 19 Oct 2019 16:44:47 +0200
Message-Id: <20191019144448.21483-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191019144448.21483-1-hch@lst.de>
References: <20191019144448.21483-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 88 ++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 42 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index b6e17594d10a..6b429bfd5bb8 100644
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
+	unsigned int		flags,
 	struct xfs_bmbt_irec	*imap,
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
@@ -742,6 +761,14 @@ xfs_direct_write_iomap_begin(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
+	/*
+	 * Writes that span EOF might trigger an IO size update on completion,
+	 * so consider them to be dirty for the purposes of O_DSYNC even if
+	 * there is no other metadata changes pending or have been made here.
+	 */
+	if (offset + length > i_size_read(inode))
+		iomap_flags |= IOMAP_F_DIRTY;
+
 	/*
 	 * Lock the inode in the manner required for the specified operation and
 	 * check for as many conditions that would result in blocking as
@@ -761,12 +788,7 @@ xfs_direct_write_iomap_begin(
 	 * Break shared extents if necessary. Checks for non-blocking IO have
 	 * been done up front, so we don't need to do them here.
 	 */
-	if (xfs_is_cow_inode(ip)) {
-		/* if zeroing doesn't need COW allocation, then we are done. */
-		if ((flags & IOMAP_ZERO) &&
-		    !needs_cow_for_zeroing(&imap, nimaps))
-			goto out_found;
-
+	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
 				&lockmode, flags & IOMAP_DIRECT);
@@ -778,18 +800,17 @@ xfs_direct_write_iomap_begin(
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
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
 
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
@@ -808,29 +829,12 @@ xfs_direct_write_iomap_begin(
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
-	/*
-	 * Writes that span EOF might trigger an IO size update on completion,
-	 * so consider them to be dirty for the purposes of O_DSYNC even if
-	 * there is no other metadata changes pending or have been made here.
-	 */
-	if (offset + length > i_size_read(inode))
-		iomap_flags |= IOMAP_F_DIRTY;
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
-
-out_found:
-	ASSERT(nimaps);
-	xfs_iunlock(ip, lockmode);
-	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	goto out_finish;
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags | IOMAP_F_NEW);
 
 out_found_cow:
 	xfs_iunlock(ip, lockmode);
-- 
2.20.1

