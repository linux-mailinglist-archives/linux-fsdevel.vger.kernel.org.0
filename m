Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B232A477E4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhLPVHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241577AbhLPVHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8AC06173E;
        Thu, 16 Dec 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=o6Ral/RyPuui2KR6pkvTTtFUtEwCOaZkk4vnlc1Lvww=; b=ohqW8pHPacdsExZWfF9e8NGdaG
        PFbEOUlGkc+weiITf9RjPzgmx7mBFOX0iClwo0kkftK0hbSrK/3zwKZXc2HGXatOUNS4MTcMpysDm
        p7jduSwEQhFH2Leevtb+mgkB9LldOuXPaUp6n3Yo23hCq4zxICgeFCNwePsEJclcLCVrZiIhr+f7G
        DXj7S+0xtA2u7qLVj3XJzwXraJi0z3y/ThlUmkF1u2M8Ks607POVwZ8IH3wGTB22fQpu9ry/I5DoP
        zkpR8OgYA7IqBJVh8QvNzQFlkkai6qtR1bF/XxJmY5xE3o7pGhfEE1Fk6XV12KqEE4jT9L8xoS7EV
        ewHox/4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyD-00Fx51-AN; Thu, 16 Dec 2021 21:07:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 20/25] iomap: Simplify iomap_writepage_map()
Date:   Thu, 16 Dec 2021 21:07:10 +0000
Message-Id: <20211216210715.3801857-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename end_offset to end_pos and file_offset to pos to match the rest
of the file.  Simplify the loop by calculating nblocks up front instead
of each time around the loop.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ceb7fbe4e7c9..20e7087aa75c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1307,37 +1307,36 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 static int
 iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
-		struct page *page, u64 end_offset)
+		struct page *page, u64 end_pos)
 {
 	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = iomap_page_create(inode, folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
-	u64 file_offset; /* file offset of page */
+	unsigned nblocks = i_blocks_per_folio(inode, folio);
+	u64 pos = folio_pos(folio);
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
 	/*
-	 * Walk through the page to find areas to write back. If we run off the
-	 * end of the current map or find the current map invalid, grab a new
-	 * one.
+	 * Walk through the folio to find areas to write back. If we
+	 * run off the end of the current map or find the current map
+	 * invalid, grab a new one.
 	 */
-	for (i = 0, file_offset = page_offset(page);
-	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
-	     i++, file_offset += len) {
+	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
 		if (iop && !test_bit(i, iop->uptodate))
 			continue;
 
-		error = wpc->ops->map_blocks(wpc, inode, file_offset);
+		error = wpc->ops->map_blocks(wpc, inode, pos);
 		if (error)
 			break;
 		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
 			continue;
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
-		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
+		iomap_add_to_ioend(inode, pos, page, iop, wpc, wbc,
 				 &submit_list);
 		count++;
 	}
@@ -1361,7 +1360,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		 * now.
 		 */
 		if (wpc->ops->discard_folio)
-			wpc->ops->discard_folio(folio, file_offset);
+			wpc->ops->discard_folio(folio, pos);
 		if (!count) {
 			ClearPageUptodate(page);
 			unlock_page(page);
-- 
2.33.0

