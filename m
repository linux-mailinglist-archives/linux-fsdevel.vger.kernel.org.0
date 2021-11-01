Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A03442221
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhKAU7f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 16:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAU7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:59:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2905C061714;
        Mon,  1 Nov 2021 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gGbc9jiBTx/dWnhLSV+gSx/4RJyglUUJJRl1T18Kt1s=; b=PtE8t6cIO2CEsZwpyQW4W5f8+u
        xyaQRWBMn9xi4KXOv7DE4LwqQsp9ueR+CopZpCySEGFmQs1E3Ro6k2QJkE4vsqHghxJfid/82aXcK
        j9fvtGlTfrNNFvUfsE2nAR4ffEyAQJ5FrnOAXJIhEFHUTsTilBbppuYSdfcqZ2Z9ZigX9y07M+uyc
        KxelE21s9oelQmXrHE0CEoNiMK++F+bN0ZdUDrOPUvjLFczOa6PfCScNKPeWEoMbO/nGOjky8ouKe
        yVFauiTe1pMSYx5sfevSndIqyx3dUBmQHsiQ45CDMHhIJA2XItQQmZDwrwAljeG9zh4qC/+qRzWEQ
        XY5EnW9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mheIV-0040pd-HW; Mon, 01 Nov 2021 20:53:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 08/21] iomap: Add iomap_invalidate_folio
Date:   Mon,  1 Nov 2021 20:39:16 +0000
Message-Id: <20211101203929.954622-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211101203929.954622-1-willy@infradead.org>
References: <20211101203929.954622-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Keep iomap_invalidatepage around as a wrapper for use in address_space
operations.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 20 ++++++++++++--------
 include/linux/iomap.h  |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a6b64a1ad468..e9a60520e769 100644
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
index 63f4ea4dac9b..91de58ca09fc 100644
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

