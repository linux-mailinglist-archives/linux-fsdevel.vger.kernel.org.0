Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA2442290
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 22:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhKAVZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 17:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhKAVZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:25:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD2C061714;
        Mon,  1 Nov 2021 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nwAzZRMDr+7Cg6zEH4I8k5Ji0CIMLbAy3jNfQy75VRs=; b=TehrpSOaZGQNFD1bjbAS/Ydl1Z
        d2N30JBydUePwBLC0B7lEIDdzYeZ+17J+7yyEk3uyRrX8GWx+TlFHVboZTvhCNMymjGpy6XlJ5Azs
        CIUyPjQhfhZkKq3vbRTTGUUOO07CttObB71NWJZ1sf/WBQCT1YmJDOlriFIqhV92KFV7hlFmbPrjh
        NuV2ciejrWeQJvXh9QNA4tF3aPae1NiorfJ8Xc6GclFL5jE2m8BqUTCh3I3g40dT+EGP6Iv0T8BMT
        33LQmfg7S33ex6GTy6SmINtAJCRONAl4e9PAj3iWN4Ayir+DJQIi26uuN1S2a9ALwXu06gjeL/Uyo
        WCaD4nYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheXE-0041v3-NG; Mon, 01 Nov 2021 21:08:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 17/21] iomap,xfs: Convert ->discard_page to ->discard_folio
Date:   Mon,  1 Nov 2021 20:39:25 +0000
Message-Id: <20211101203929.954622-18-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

XFS has the only implementation of ->discard_page today, so convert it
to use folios in the same patch as converting the API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c |  4 ++--
 fs/xfs/xfs_aops.c      | 24 ++++++++++++------------
 include/linux/iomap.h  |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6862487f4067..c50ae76835ca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1349,8 +1349,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * won't be affected by I/O completion and we must unlock it
 		 * now.
 		 */
-		if (wpc->ops->discard_page)
-			wpc->ops->discard_page(page, file_offset);
+		if (wpc->ops->discard_folio)
+			wpc->ops->discard_folio(page_folio(page), file_offset);
 		if (!count) {
 			ClearPageUptodate(page);
 			unlock_page(page);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 34fc6148032a..c6c4d07d0d26 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -428,37 +428,37 @@ xfs_prepare_ioend(
  * see a ENOSPC in writeback).
  */
 static void
-xfs_discard_page(
-	struct page		*page,
-	loff_t			fileoff)
+xfs_discard_folio(
+	struct folio		*folio,
+	loff_t			pos)
 {
-	struct inode		*inode = page->mapping->host;
+	struct inode		*inode = folio->mapping->host;
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	unsigned int		pageoff = offset_in_page(fileoff);
-	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
-	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);
+	size_t			offset = offset_in_folio(folio, pos);
+	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, pos);
+	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, offset);
 	int			error;
 
 	if (xfs_is_shutdown(mp))
 		goto out_invalidate;
 
 	xfs_alert_ratelimited(mp,
-		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
-			page, ip->i_ino, fileoff);
+		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
+			folio, ip->i_ino, pos);
 
 	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			i_blocks_per_page(inode, page) - pageoff_fsb);
+			i_blocks_per_folio(inode, folio) - pageoff_fsb);
 	if (error && !xfs_is_shutdown(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
+	iomap_invalidate_folio(folio, offset, folio_size(folio) - offset);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
 	.map_blocks		= xfs_map_blocks,
 	.prepare_ioend		= xfs_prepare_ioend,
-	.discard_page		= xfs_discard_page,
+	.discard_folio		= xfs_discard_folio,
 };
 
 STATIC int
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 91de58ca09fc..1a161314d7e4 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -285,7 +285,7 @@ struct iomap_writeback_ops {
 	 * Optional, allows the file system to discard state on a page where
 	 * we failed to submit any I/O.
 	 */
-	void (*discard_page)(struct page *page, loff_t fileoff);
+	void (*discard_folio)(struct folio *folio, loff_t pos);
 };
 
 struct iomap_writepage_ctx {
-- 
2.33.0

