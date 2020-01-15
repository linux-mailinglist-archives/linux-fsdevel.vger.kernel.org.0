Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABE313B7D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAOCjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:39:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgAOCjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jnl/1wWGv1qKEBLHgKybzlxexpnxYVaV1z0LZYLTylg=; b=fNsMdZDDDhAxaEf0S5ZbQhtNbp
        ck5GXITH0c/I/yAiRxCPJbzo63MhyMhJhzU1be8Im3AienbE6KGmJi+ZKsXSLRnrsnzhvpClwB3Zv
        MRBwZhZx9dyTKOkawc+gD7lpb4re71ROQLaFy48H+DtWwSEi3/dimRkMzHiXHLVkOoxp8zOT0yW7E
        euCKIlxjmoU9QLU7I/L/LntRGRhficSYXtBbWeaXj+scxxexJ+8rr8L1w1RiC3gbpKhH33ubXFhqo
        wkcO5m1MoHrjWJmW12sNVfu5GP12rfT89te61rBUNeeLlJoPq5y9ZyW4NSh+euQbBi80jqbrm0PJo
        GKj/mpUQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZy-0008Al-3l; Wed, 15 Jan 2020 02:38:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v2 4/9] readahead: Put pages in cache earlier
Date:   Tue, 14 Jan 2020 18:38:38 -0800
Message-Id: <20200115023843.31325-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

At allocation time, put the pages in the cache unless we're using
->readpages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 51 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index fc77d13af556..5a6676640f20 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -114,10 +114,10 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 EXPORT_SYMBOL(read_cache_pages);
 
 static void read_pages(struct address_space *mapping, struct file *filp,
-		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
+		struct list_head *pages, pgoff_t start,
+		unsigned int nr_pages)
 {
 	struct blk_plug plug;
-	unsigned page_idx;
 
 	blk_start_plug(&plug);
 
@@ -125,18 +125,17 @@ static void read_pages(struct address_space *mapping, struct file *filp,
 		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
-		goto out;
-	}
+	} else {
+		struct page *page;
+		unsigned long index;
 
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		struct page *page = lru_to_page(pages);
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
+		xa_for_each_range(&mapping->i_pages, index, page, start,
+				start + nr_pages - 1) {
 			mapping->a_ops->readpage(filp, page);
-		put_page(page);
+			put_page(page);
+		}
 	}
 
-out:
 	blk_finish_plug(&plug);
 }
 
@@ -157,9 +156,11 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
+	pgoff_t page_offset;
 	unsigned long nr_pages = 0;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	bool use_list = mapping->a_ops->readpages;
 
 	if (isize == 0)
 		goto out;
@@ -170,7 +171,7 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = offset + page_idx;
+		page_offset = offset + page_idx;
 
 		if (page_offset > end_index)
 			break;
@@ -178,13 +179,14 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		page = xa_load(&mapping->i_pages, page_offset);
 		if (page && !xa_is_value(page)) {
 			/*
-			 * Page already present?  Kick off the current batch of
-			 * contiguous pages before continuing with the next
-			 * batch.
+			 * Page already present?  Kick off the current batch
+			 * of contiguous pages before continuing with the
+			 * next batch.
 			 */
 			if (nr_pages)
-				read_pages(mapping, filp, &page_pool, nr_pages,
-						gfp_mask);
+				read_pages(mapping, filp, &page_pool,
+						page_offset - nr_pages,
+						nr_pages);
 			nr_pages = 0;
 			continue;
 		}
@@ -192,8 +194,18 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
-		list_add(&page->lru, &page_pool);
+		if (use_list) {
+			page->index = page_offset;
+			list_add(&page->lru, &page_pool);
+		} else if (!add_to_page_cache_lru(page, mapping, page_offset,
+					gfp_mask)) {
+			if (nr_pages)
+				read_pages(mapping, filp, &page_pool,
+						page_offset - nr_pages,
+						nr_pages);
+			nr_pages = 0;
+			continue;
+		}
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		nr_pages++;
@@ -205,7 +217,8 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	 * will then handle the error.
 	 */
 	if (nr_pages)
-		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
+		read_pages(mapping, filp, &page_pool, page_offset - nr_pages,
+				nr_pages);
 	BUG_ON(!list_empty(&page_pool));
 out:
 	return nr_pages;
-- 
2.24.1

