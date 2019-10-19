Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F298DD935
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfJSOps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfJSOpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zKgBJvf2CgJssDMwEgh5OD9wfnikXOzzr89qGtyRCgc=; b=UhbHhxHvRd1svQYNrLzT3+cH+Y
        N9tgiCyH3osG4NAWTXHp4rLvphMocKJiqfMeLzv4mr4E4Uvk1QR9wUdno4XuZXuR0GfUyVBqtGBfn
        nRRnlXiouy+3FasQet6R2qzXMA5lTg27XzZot4f/Dh/Xd6JgXZaNuwbCGuqMlqp5hPEp5MIIwWlAN
        Nvy0Ix2bOQqNeGpCzJRXfqaPy+tBvA0/Otd70l2UhFv1q9mtC3HfUJMU9LYtcYcTdeLNrQ6Jd1gxl
        W66KXjx/lB5UZ07wHa8u/iVLmbg84y5dsX+/7GdWIdrIULq/mF89WuFWdIVoCnVNfolMpA8UfXLCS
        9vkuhNoA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpzH-0003E4-2T; Sat, 19 Oct 2019 14:45:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 12/12] xfs: improve the IOMAP_NOWAIT check for COW inodes
Date:   Sat, 19 Oct 2019 16:44:48 +0200
Message-Id: <20191019144448.21483-13-hch@lst.de>
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

Only bail out once we know that a COW allocation is actually required,
similar to how we handle normal data fork allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 6b429bfd5bb8..bf0c7756ac90 100644
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
@@ -769,12 +762,6 @@ xfs_direct_write_iomap_begin(
 	if (offset + length > i_size_read(inode))
 		iomap_flags |= IOMAP_F_DIRTY;
 
-	/*
-	 * Lock the inode in the manner required for the specified operation and
-	 * check for as many conditions that would result in blocking as
-	 * possible. This removes most of the non-blocking checks from the
-	 * mapping code below.
-	 */
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -784,11 +771,11 @@ xfs_direct_write_iomap_begin(
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

