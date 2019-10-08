Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD1CF371
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfJHHQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:16:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0nh3bL96qzPReW4fX5N7GDAdMCerePYLFTH+BhkLkIQ=; b=IkQl5Ad4R+1aiHjo9fXLGbyiz7
        ZbYsRFgqjL/WvdzMZAcmA6zi2/FtyYBUiIHYuRfkZkgMQrdlvNB/jiqnyhEJr3kbObPu11bGlI7VP
        55nWIWIga1Hfn0FZixojggLBEIANirw7aziKsATEdqsNyH/22PpDwX142wmuxb4Hg1t2cK4ggU/X8
        dnlZBBhxxsRVomYd/ojyC6xFj6GaN0SIZQQcHq1e0CghDTybsTpFq2GMxZXSsZlSlFD9e6J2fxcTn
        R9736myodb8mOnhvNOEbGEmIIRIQ8mYPvg5su3i7u9XhUpQ8JMboMc2QwQagr2+jzJHE8s6seJFcl
        qHB1uoug==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjjL-0006Mj-FX; Tue, 08 Oct 2019 07:16:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 20/20] xfs: improve the IOMAP_NOWAIT check for COW inodes
Date:   Tue,  8 Oct 2019 09:15:27 +0200
Message-Id: <20191008071527.29304-21-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008071527.29304-1-hch@lst.de>
References: <20191008071527.29304-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Only bail out once we know that a COW allocation is actually required,
similar to how we handle normal data fork allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cc3d8fa011fc..46dee9c9e6ef 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -693,15 +693,8 @@ xfs_ilock_for_iomap(
 	 * COW writes may allocate delalloc space or convert unwritten COW
 	 * extents, so we need to make sure to take the lock exclusively here.
 	 */
-	if (xfs_is_cow_inode(ip) && is_write) {
-		/*
-		 * FIXME: It could still overwrite on unshared extents and not
-		 * need allocation.
-		 */
-		if (flags & IOMAP_NOWAIT)
-			return -EAGAIN;
+	if (xfs_is_cow_inode(ip) && is_write)
 		mode = XFS_ILOCK_EXCL;
-	}
 
 	/*
 	 * Extents not yet cached requires exclusive access, don't block.  This
@@ -760,12 +753,6 @@ xfs_direct_write_iomap_begin(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	/*
-	 * Lock the inode in the manner required for the specified operation and
-	 * check for as many conditions that would result in blocking as
-	 * possible. This removes most of the non-blocking checks from the
-	 * mapping code below.
-	 */
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -775,11 +762,11 @@ xfs_direct_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
-	/*
-	 * Break shared extents if necessary. Checks for non-blocking IO have
-	 * been done up front, so we don't need to do them here.
-	 */
 	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
+		error = -EAGAIN;
+		if (flags & IOMAP_NOWAIT)
+			goto out_unlock;
+
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
 				&lockmode, flags & IOMAP_DIRECT);
-- 
2.20.1

