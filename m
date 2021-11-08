Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F86447973
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhKHEmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhKHEmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:42:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D11C061570;
        Sun,  7 Nov 2021 20:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q1Ai1X6+Fnek7vW+SwIcp2mbpI4t9YxBCtqSnvMICLQ=; b=npS9cgzypBr8raxng12uWUCYz3
        AuuISL7OEB0doavXlhGMBc6jHQd3osjEV5JyDG+uP9AbwfjmRf15nUJY2ogiI5boe0D9kgIRYQ3en
        yOQiqjZF5V0g2BdN8QD5pOx8/8kSnLrGcDkyGsEaKK6DPHuf4gm4tTwaOs6/mAo7ih3PKV7nKnJUM
        ZhtedQ2XtVrucgomsHC6cDUAE28fHqWJoBhYVLm3rxk0DqgkjX9+zrgHOQg/1Tti3zTFI5IekyvzV
        mcvMsrTl2hJuHiI8LkZLd41L9z9KkEGUw38gHV0+exc6d6Rul6GHR4zj46+WyB3XTvTIO0Y7gXsMG
        G+f4LC9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwNy-008A9y-8g; Mon, 08 Nov 2021 04:36:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/28] iomap: Add iomap_invalidate_folio
Date:   Mon,  8 Nov 2021 04:05:35 +0000
Message-Id: <20211108040551.1942823-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep iomap_invalidatepage around as a wrapper for use in address_space
operations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 20 ++++++++++++--------
 include/linux/iomap.h  |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 49f96fdadcb4..b7cbe4d202d8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -468,23 +468,27 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL_GPL(iomap_releasepage);
 
-void
-iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
+void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
 {
-	struct folio *folio = page_folio(page);
-
-	trace_iomap_invalidatepage(page->mapping->host, offset, len);
+	trace_iomap_invalidatepage(folio->mapping->host, offset, len);
 
 	/*
 	 * If we're invalidating the entire page, clear the dirty state from it
 	 * and release it to avoid unnecessary buildup of the LRU.
 	 */
-	if (offset == 0 && len == PAGE_SIZE) {
-		WARN_ON_ONCE(PageWriteback(page));
-		cancel_dirty_page(page);
+	if (offset == 0 && len == folio_size(folio)) {
+		WARN_ON_ONCE(folio_test_writeback(folio));
+		folio_cancel_dirty(folio);
 		iomap_page_release(folio);
 	}
 }
+EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
+
+void iomap_invalidatepage(struct page *page, unsigned int offset,
+		unsigned int len)
+{
+	iomap_invalidate_folio(page_folio(page), offset, len);
+}
 EXPORT_SYMBOL_GPL(iomap_invalidatepage);
 
 #ifdef CONFIG_MIGRATION
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6d1b08d0ae93..29491fb9c5ba 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -225,6 +225,7 @@ void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
+void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 void iomap_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int len);
 #ifdef CONFIG_MIGRATION
-- 
2.33.0

