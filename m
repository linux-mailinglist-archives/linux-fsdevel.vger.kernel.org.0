Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD706DD923
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfJSOpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4UIkSasFnPqOeq93On0A6QnIcY6b7rHvv9QJsF1T7t0=; b=BzknDE/GfDbN9iJkqaiw2hmawk
        7Md2zyC/OFFLeF7uJY3evGTn/0JLWuFO2h9PROXZwAAwOJIJTGO6kibz7Fzp20V5hhFhW1V8IPHMA
        uHcGuaVI4gR+NvceaNGv//p/JztMXMsvKb17aa32i/IO8eDPgUPpHXT8b1Mq59uEW+dtCr6UMIvhH
        GH0tuQJYGYy4cwLPOOxYdhPp/SOTqYqySE1/tv9XgHqYmE4i038M7laLc5tt12AHe2ZKYF6P/1RJt
        +R7jnaYYTEK32KNuBIDE1X/piUXBn+3ble56Yz34fGKfphm6kwACaDUqxzoUwlWLgFzMjdKOHxMXy
        vtuHnqMQ==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpyZ-0001uP-9C; Sat, 19 Oct 2019 14:45:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 03/12] xfs: pass two imaps to xfs_reflink_allocate_cow
Date:   Sat, 19 Oct 2019 16:44:39 +0200
Message-Id: <20191019144448.21483-4-hch@lst.de>
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

xfs_reflink_allocate_cow consumes the source data fork imap, and
potentially returns the COW fork imap.  Split the arguments in two
to clear up the calling conventions and to prepare for returning
a source iomap from ->iomap_begin.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c   |  8 ++++----
 fs/xfs/xfs_reflink.c | 30 +++++++++++++++---------------
 fs/xfs/xfs_reflink.h |  4 ++--
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f1d32bcf48bd..2cd546531b74 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -996,9 +996,8 @@ xfs_file_iomap_begin(
 			goto out_found;
 
 		/* may drop and re-acquire the ilock */
-		cmap = imap;
-		error = xfs_reflink_allocate_cow(ip, &cmap, &shared, &lockmode,
-				directio);
+		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
+				&lockmode, directio);
 		if (error)
 			goto out_unlock;
 
@@ -1011,7 +1010,8 @@ xfs_file_iomap_begin(
 		 * newly allocated address.  If the data fork has a hole, copy
 		 * the COW fork mapping to avoid allocating to the data fork.
 		 */
-		if (directio || imap.br_startblock == HOLESTARTBLOCK)
+		if (shared &&
+		    (directio || imap.br_startblock == HOLESTARTBLOCK))
 			imap = cmap;
 
 		end_fsb = imap.br_startoff + imap.br_blockcount;
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 7fc728a8852b..19a6e4644123 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -308,13 +308,13 @@ static int
 xfs_find_trim_cow_extent(
 	struct xfs_inode	*ip,
 	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	bool			*found)
 {
 	xfs_fileoff_t		offset_fsb = imap->br_startoff;
 	xfs_filblks_t		count_fsb = imap->br_blockcount;
 	struct xfs_iext_cursor	icur;
-	struct xfs_bmbt_irec	got;
 
 	*found = false;
 
@@ -322,23 +322,22 @@ xfs_find_trim_cow_extent(
 	 * If we don't find an overlapping extent, trim the range we need to
 	 * allocate to fit the hole we found.
 	 */
-	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &got))
-		got.br_startoff = offset_fsb + count_fsb;
-	if (got.br_startoff > offset_fsb) {
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, cmap))
+		cmap->br_startoff = offset_fsb + count_fsb;
+	if (cmap->br_startoff > offset_fsb) {
 		xfs_trim_extent(imap, imap->br_startoff,
-				got.br_startoff - imap->br_startoff);
+				cmap->br_startoff - imap->br_startoff);
 		return xfs_inode_need_cow(ip, imap, shared);
 	}
 
 	*shared = true;
-	if (isnullstartblock(got.br_startblock)) {
-		xfs_trim_extent(imap, got.br_startoff, got.br_blockcount);
+	if (isnullstartblock(cmap->br_startblock)) {
+		xfs_trim_extent(imap, cmap->br_startoff, cmap->br_blockcount);
 		return 0;
 	}
 
 	/* real extent found - no need to allocate */
-	xfs_trim_extent(&got, offset_fsb, count_fsb);
-	*imap = got;
+	xfs_trim_extent(cmap, offset_fsb, count_fsb);
 	*found = true;
 	return 0;
 }
@@ -348,6 +347,7 @@ int
 xfs_reflink_allocate_cow(
 	struct xfs_inode	*ip,
 	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
 	bool			*shared,
 	uint			*lockmode,
 	bool			convert_now)
@@ -367,7 +367,7 @@ xfs_reflink_allocate_cow(
 		xfs_ifork_init_cow(ip);
 	}
 
-	error = xfs_find_trim_cow_extent(ip, imap, shared, &found);
+	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
 	if (error || !*shared)
 		return error;
 	if (found)
@@ -392,7 +392,7 @@ xfs_reflink_allocate_cow(
 	/*
 	 * Check for an overlapping extent again now that we dropped the ilock.
 	 */
-	error = xfs_find_trim_cow_extent(ip, imap, shared, &found);
+	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
 	if (error || !*shared)
 		goto out_trans_cancel;
 	if (found) {
@@ -411,7 +411,7 @@ xfs_reflink_allocate_cow(
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
 			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC,
-			resblks, imap, &nimaps);
+			resblks, cmap, &nimaps);
 	if (error)
 		goto out_unreserve;
 
@@ -427,15 +427,15 @@ xfs_reflink_allocate_cow(
 	if (nimaps == 0)
 		return -ENOSPC;
 convert:
-	xfs_trim_extent(imap, offset_fsb, count_fsb);
+	xfs_trim_extent(cmap, offset_fsb, count_fsb);
 	/*
 	 * COW fork extents are supposed to remain unwritten until we're ready
 	 * to initiate a disk write.  For direct I/O we are going to write the
 	 * data and need the conversion, but for buffered writes we're done.
 	 */
-	if (!convert_now || imap->br_state == XFS_EXT_NORM)
+	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
 		return 0;
-	trace_xfs_reflink_convert_cow(ip, imap);
+	trace_xfs_reflink_convert_cow(ip, cmap);
 	return xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
 
 out_unreserve:
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 28a43b7f581d..d18ad7f4fb64 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -25,8 +25,8 @@ extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
 bool xfs_inode_need_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool *shared);
 
-extern int xfs_reflink_allocate_cow(struct xfs_inode *ip,
-		struct xfs_bmbt_irec *imap, bool *shared, uint *lockmode,
+int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
+		struct xfs_bmbt_irec *cmap, bool *shared, uint *lockmode,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
-- 
2.20.1

