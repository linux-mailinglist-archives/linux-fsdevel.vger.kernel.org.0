Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A39373E43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhEEPR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhEEPR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:17:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E7C061574;
        Wed,  5 May 2021 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IgD6Z/R8KKTP/Q+2YwElx93aowViVL+rNNVE6FqBr6U=; b=oA1hkqh32JwxKPh1pfi/X+8oil
        Pr37p3BhCYgmBYBz9CXB3HW+CqdBoOtW5Aa1NoAfnWbe6oOkpeQ6SzbjPex57MH3Ctq61fMI+EBE6
        ZQIxeDyR54TMIwMKcpt8MheffKOiJ4px6SeCsZJO7Tyi+1pBIHu8FwTxjy7mzgrUQkItnJvwYh4bz
        5vt25J+mxbtjmcP1Kkra4f8ZjbwHTp/hGF6KOTB0+LaCz0H4KeKPk5gAIP7sKPiEPHjubBfKfk1Uq
        xVkr58gbhAPPycozWGlWuVoBEvEbgfj4O7E/vY0LO6OiBeAtRuwUwm2RjgawrFYoR+KOPXUXLuea9
        GJCabOsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJEk-000Tsk-Fr; Wed, 05 May 2021 15:15:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH v9 08/96] mm: Fix struct page layout on 32-bit systems
Date:   Wed,  5 May 2021 16:05:00 +0100
Message-Id: <20210505150628.111735-9-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

32-bit architectures which expect 8-byte alignment for 8-byte integers
and need 64-bit DMA addresses (arm, mips, ppc) had their struct page
inadvertently expanded in 2019.  When the dma_addr_t was added, it forced
the alignment of the union to 8 bytes, which inserted a 4 byte gap between
'flags' and the union.

Fix this by storing the dma_addr_t in one or two adjacent unsigned longs.
This restores the alignment to that of an unsigned long.  We always
store the low bits in the first word to prevent the PageTail bit from
being inadvertently set on a big endian platform.  If that happened,
get_user_pages_fast() racing against a page which was freed and
reallocated to the page_pool could dereference a bogus compound_head(),
which would be hard to trace back to this cause.

Fixes: c25fff7171be ("mm: add dma_addr_t to struct page")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 include/linux/mm_types.h |  4 ++--
 include/net/page_pool.h  | 12 +++++++++++-
 net/core/page_pool.c     | 12 +++++++-----
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6613b26a8894..5aacc1c10a45 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -97,10 +97,10 @@ struct page {
 		};
 		struct {	/* page_pool used by netstack */
 			/**
-			 * @dma_addr: might require a 64-bit value even on
+			 * @dma_addr: might require a 64-bit value on
 			 * 32-bit architectures.
 			 */
-			dma_addr_t dma_addr;
+			unsigned long dma_addr[2];
 		};
 		struct {	/* slab, slob and slub */
 			union {
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 6d517a37c18b..b4b6de909c93 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -198,7 +198,17 @@ static inline void page_pool_recycle_direct(struct page_pool *pool,
 
 static inline dma_addr_t page_pool_get_dma_addr(struct page *page)
 {
-	return page->dma_addr;
+	dma_addr_t ret = page->dma_addr[0];
+	if (sizeof(dma_addr_t) > sizeof(unsigned long))
+		ret |= (dma_addr_t)page->dma_addr[1] << 16 << 16;
+	return ret;
+}
+
+static inline void page_pool_set_dma_addr(struct page *page, dma_addr_t addr)
+{
+	page->dma_addr[0] = addr;
+	if (sizeof(dma_addr_t) > sizeof(unsigned long))
+		page->dma_addr[1] = upper_32_bits(addr);
 }
 
 static inline bool is_page_pool_compiled_in(void)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 9ec1aa9640ad..3c4c4c7a0402 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -174,8 +174,10 @@ static void page_pool_dma_sync_for_device(struct page_pool *pool,
 					  struct page *page,
 					  unsigned int dma_sync_size)
 {
+	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
+
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
-	dma_sync_single_range_for_device(pool->p.dev, page->dma_addr,
+	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
 					 pool->p.offset, dma_sync_size,
 					 pool->p.dma_dir);
 }
@@ -195,7 +197,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (dma_mapping_error(pool->p.dev, dma))
 		return false;
 
-	page->dma_addr = dma;
+	page_pool_set_dma_addr(page, dma);
 
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
@@ -331,13 +333,13 @@ void page_pool_release_page(struct page_pool *pool, struct page *page)
 		 */
 		goto skip_dma_unmap;
 
-	dma = page->dma_addr;
+	dma = page_pool_get_dma_addr(page);
 
-	/* When page is unmapped, it cannot be returned our pool */
+	/* When page is unmapped, it cannot be returned to our pool */
 	dma_unmap_page_attrs(pool->p.dev, dma,
 			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
 			     DMA_ATTR_SKIP_CPU_SYNC);
-	page->dma_addr = 0;
+	page_pool_set_dma_addr(page, 0);
 skip_dma_unmap:
 	/* This may be the last page returned, releasing the pool, so
 	 * it is not safe to reference pool afterwards.
-- 
2.30.2

