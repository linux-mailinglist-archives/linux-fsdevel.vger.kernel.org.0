Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F942500F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgHXPYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgHXPRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:17:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96BC061795;
        Mon, 24 Aug 2020 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eozBFwSKGPfBaW+jGggP/6aRg3H7QN0Z3eUiLt+WZqI=; b=GB8FYN2i+QVtGYzxtjTOv8TVE2
        K4Td5UBppble8UOssfOfKNFyoA/jgO03nfOSAO5nyNyyvp2+N1iHaVqGVGSyLUGO1x/cSyT2Q+PPC
        szEmqvJN2lOfDMNC8hLLRbj/b/9gf/xyA/qOa0pJ7WvjtSnQOMKNxhFzPRFtvHJqKmBXcTK0V3oY2
        /KVMc6hshLUZsQeW1JYTOQqnMTwv8VBh0i3/Z8GOkI//Z2YyJkJZmdbD2SGV5GrVD6MxYkPz8fd/9
        6i2ACc6kA6VjWnJkf2pp1MgiRrm2KCt8V7rIC1uJOzJqruJkzk22pd7VRQEVYaiNQJU9A9Zl27kig
        hvfYk3qA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEDX-0004Cy-IR; Mon, 24 Aug 2020 15:17:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] iomap: Support THPs in invalidatepage
Date:   Mon, 24 Aug 2020 16:16:55 +0100
Message-Id: <20200824151700.16097-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824151700.16097-1-willy@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we're punching a hole in a THP, we need to remove the per-page
iomap data as the THP is about to be split and each page will need
its own.  This means that writepage can now come across a page with
no iop allocated, so remove the assertions that there is already one,
and just create one (with the Uptodate bits set) if there isn't one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5cc0343b6a8e..9ea162617398 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -54,6 +54,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
 			GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
+	if (PageUptodate(page))
+		bitmap_fill(iop->uptodate, nr_blocks);
 	attach_page_private(page, iop);
 	return iop;
 }
@@ -483,10 +485,17 @@ iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
 	 * If we are invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
+	if (offset == 0 && len == thp_size(page)) {
 		WARN_ON_ONCE(PageWriteback(page));
 		cancel_dirty_page(page);
 		iomap_page_release(page);
+		return;
+	}
+
+	/* Punching a hole in a THP requires releasing the iop */
+	if (PageTransHuge(page)) {
+		VM_BUG_ON_PAGE(!PageUptodate(page), page);
+		iomap_page_release(page);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
@@ -1043,14 +1052,13 @@ static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		int error, unsigned int len)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = iomap_page_create(inode, page);
 
 	if (error) {
 		SetPageError(page);
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
 
 	if (!iop || atomic_sub_and_test(len, &iop->write_count))
@@ -1340,14 +1348,13 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct page *page, u64 end_offset)
 {
-	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_page *iop = iomap_page_create(inode, page);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	u64 file_offset; /* file offset of page */
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
 
 	/*
-- 
2.28.0

