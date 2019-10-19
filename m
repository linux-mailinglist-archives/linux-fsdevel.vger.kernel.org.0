Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959DFDD927
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfJSOpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2AYpOoHZwf/SNFoHrx8qtzQVx7q4RvXdeONEpFLh7hw=; b=R7xRD3EbPdA5QRWP/TmcIrzyiW
        pbe0mKcR8JGNxIfVKC+XtIWF4hTur29dd/6+9k17qPvS9oX5lgxTEr6JIDLFr5iXzK7yvb+CPMENy
        uUSWXBNdS3QE7h2fzotMZZZ1Ct18fYpghkWdhv8IAjakkoUkG5bg85LSyAX05/PutwnGHVPkVItL7
        WbjevakguBNlyCRteB+JPXiJufhh8tkLAjO0OvbMLpdBJCJfjbJNQAyqs1KXDxBS08OUdpJLNg1mc
        rQWaGTe8fdg1Zc9DflSrivf/q1lsCj9A6LzgBtvpqcN95fzg1hDiwluHgahYzTw47TqYbXOmXHHSV
        3LoY3aQA==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpyf-0002fk-3s; Sat, 19 Oct 2019 14:45:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 05/12] xfs: fill out the srcmap in iomap_begin
Date:   Sat, 19 Oct 2019 16:44:41 +0200
Message-Id: <20191019144448.21483-6-hch@lst.de>
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

Replace our local hacks to report the source block in the main iomap
with the proper scrmap reporting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 49 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 38e0b1221d51..08c0f0a369d7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -527,7 +527,8 @@ xfs_file_iomap_begin_delay(
 	loff_t			offset,
 	loff_t			count,
 	unsigned		flags,
-	struct iomap		*iomap)
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
@@ -721,11 +722,13 @@ xfs_file_iomap_begin_delay(
 found_cow:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	if (imap.br_startoff <= offset_fsb) {
-		/* ensure we only report blocks we have a reservation for */
-		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
-		return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_SHARED);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
+		if (error)
+			return error;
+	} else {
+		xfs_trim_extent(&cmap, offset_fsb,
+				imap.br_startoff - offset_fsb);
 	}
-	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
 
 out_unlock:
@@ -933,7 +936,7 @@ xfs_file_iomap_begin(
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_bmbt_irec	imap;
+	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb, end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
@@ -947,7 +950,7 @@ xfs_file_iomap_begin(
 			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
 		/* Reserve delalloc blocks for regular writeback. */
 		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
-				iomap);
+				iomap, srcmap);
 	}
 
 	/*
@@ -987,9 +990,6 @@ xfs_file_iomap_begin(
 	 * been done up front, so we don't need to do them here.
 	 */
 	if (xfs_is_cow_inode(ip)) {
-		struct xfs_bmbt_irec	cmap;
-		bool			directio = (flags & IOMAP_DIRECT);
-
 		/* if zeroing doesn't need COW allocation, then we are done. */
 		if ((flags & IOMAP_ZERO) &&
 		    !needs_cow_for_zeroing(&imap, nimaps))
@@ -997,23 +997,11 @@ xfs_file_iomap_begin(
 
 		/* may drop and re-acquire the ilock */
 		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
-				&lockmode, directio);
+				&lockmode, flags & IOMAP_DIRECT);
 		if (error)
 			goto out_unlock;
-
-		/*
-		 * For buffered writes we need to report the address of the
-		 * previous block (if there was any) so that the higher level
-		 * write code can perform read-modify-write operations; we
-		 * won't need the CoW fork mapping until writeback.  For direct
-		 * I/O, which must be block aligned, we need to report the
-		 * newly allocated address.  If the data fork has a hole, copy
-		 * the COW fork mapping to avoid allocating to the data fork.
-		 */
-		if (shared &&
-		    (directio || imap.br_startblock == HOLESTARTBLOCK))
-			imap = cmap;
-
+		if (shared)
+			goto out_found_cow;
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
@@ -1074,6 +1062,17 @@ xfs_file_iomap_begin(
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
 	goto out_finish;
 
+out_found_cow:
+	xfs_iunlock(ip, lockmode);
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	if (imap.br_startblock != HOLESTARTBLOCK) {
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
+		if (error)
+			return error;
+	}
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
+
 out_unlock:
 	xfs_iunlock(ip, lockmode);
 	return error;
-- 
2.20.1

