Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDE2DD925
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfJSOpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Oct 2019 10:45:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfJSOpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Oct 2019 10:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9gqOrgwEToTP/tGzaG/qSverKxC8jiQUtNTJPhqO68M=; b=uWOjOHFVY6/R62iHkEnJ6PiMti
        Mp6dA53hGF7dx0907JsY//ktu3PK9wEcnt3QizPuGXKbYyz37/6aP5I9Os5S2w+q1+AUQBXB8+kAg
        GLVLXaS4yy1E04v8/z39mUQyjKmiIK6WsxtTEXhol3HOB2LQT9vtNlbJfCmuwCp9StNIr+KdvRuem
        /qihM9KdclDcYF9fqF2aMIJSzRoU/QXnEB2sT/yKwR532tGyrq1ks6UNtjNdTZ19F8b/KgnH5VFvK
        mezXhuNWb14Z2o9dcKTQM1GdSVNtAKjmRBoQQZBgwbcnQZ/mwoQGfdJvqWsBCqdCK14EpbF+FwrDT
        y/6TbrUw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLpyc-0002Au-1N; Sat, 19 Oct 2019 14:45:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 04/12] xfs: refactor xfs_file_iomap_begin_delay
Date:   Sat, 19 Oct 2019 16:44:40 +0200
Message-Id: <20191019144448.21483-5-hch@lst.de>
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

Rejuggle the return path to prepare for filling out a source iomap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_iomap.c | 48 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 2cd546531b74..38e0b1221d51 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -539,7 +539,6 @@ xfs_file_iomap_begin_delay(
 	struct xfs_iext_cursor	icur, ccur;
 	xfs_fsblock_t		prealloc_blocks = 0;
 	bool			eof = false, cow_eof = false, shared = false;
-	u16			iomap_flags = 0;
 	int			whichfork = XFS_DATA_FORK;
 	int			error = 0;
 
@@ -600,8 +599,7 @@ xfs_file_iomap_begin_delay(
 				&ccur, &cmap);
 		if (!cow_eof && cmap.br_startoff <= offset_fsb) {
 			trace_xfs_reflink_cow_found(ip, &cmap);
-			whichfork = XFS_COW_FORK;
-			goto done;
+			goto found_cow;
 		}
 	}
 
@@ -615,7 +613,7 @@ xfs_file_iomap_begin_delay(
 		    ((flags & IOMAP_ZERO) && imap.br_state != XFS_EXT_NORM)) {
 			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
 					&imap);
-			goto done;
+			goto found_imap;
 		}
 
 		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
@@ -629,7 +627,7 @@ xfs_file_iomap_begin_delay(
 		if (!shared) {
 			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
 					&imap);
-			goto done;
+			goto found_imap;
 		}
 
 		/*
@@ -703,35 +701,37 @@ xfs_file_iomap_begin_delay(
 		goto out_unlock;
 	}
 
+	if (whichfork == XFS_COW_FORK) {
+		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
+		goto found_cow;
+	}
+
 	/*
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
-	if (whichfork == XFS_DATA_FORK) {
-		iomap_flags |= IOMAP_F_NEW;
-		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
-	} else {
-		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
-	}
-done:
-	if (whichfork == XFS_COW_FORK) {
-		if (imap.br_startoff > offset_fsb) {
-			xfs_trim_extent(&cmap, offset_fsb,
-					imap.br_startoff - offset_fsb);
-			error = xfs_bmbt_to_iomap(ip, iomap, &cmap,
-					IOMAP_F_SHARED);
-			goto out_unlock;
-		}
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
+
+found_imap:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
+
+found_cow:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	if (imap.br_startoff <= offset_fsb) {
 		/* ensure we only report blocks we have a reservation for */
 		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
-		shared = true;
+		return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_SHARED);
 	}
-	if (shared)
-		iomap_flags |= IOMAP_F_SHARED;
-	error = xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
+	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
+
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
+
 }
 
 int
-- 
2.20.1

