Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27061F5C8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgFJUOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbgFJUNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE75C0085C7;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MzsyfRnyDe67a2Cfz5uY3LqHozA0IstJ5c01vhKwG9I=; b=VD7fU7LuZ61xGvb1zRlmkXDnh4
        +J3601D7omZ47AOcyP+VEXSGypqy+y0+hH94n8UEFLeQPDc9dsY5Bu2qWFAiwrAzglRamvVcwu+7e
        d848ODtU2nVCwl6T6jTIu7CidmoIFW1nRasfwKVUVqR6Gbo9E6hfsX6u+0FHkIXuquVSbZsrp7L6s
        QunVJjJ+xkv3jR36/3bmAKO2y7f9H7k/36I5mAdyPKpS/Z+vlPZca6tXIviFNHXpLj78UH1o4bpk/
        +cTr/CPFU8TDrENMB7Y1x9EXwm/3E5+x6cjoODs5Zjc2SxJhs/ZkfbNLuM/fmRCDAwnGwV1jLpy6W
        KRUk9+Pg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003YT-B2; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 50/51] mm: Add THP readahead
Date:   Wed, 10 Jun 2020 13:13:44 -0700
Message-Id: <20200610201345.13273-51-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the filesystem supports THPs, allocate larger pages in the
readahead code when it seems worth doing.  The heuristic for choosing
larger page sizes will surely need some tuning, but this aggressive
ramp-up seems good for testing.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 74c7e1eff540..98bbcc986b39 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -149,7 +149,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 	blk_finish_plug(&plug);
 
-	BUG_ON(!list_empty(pages));
+	BUG_ON(pages && !list_empty(pages));
 	BUG_ON(readahead_count(rac));
 
 out:
@@ -428,13 +428,92 @@ static int try_context_readahead(struct address_space *mapping,
 	return 1;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int ra_alloc_page(struct readahead_control *rac, pgoff_t index,
+		pgoff_t mark, unsigned int order, gfp_t gfp)
+{
+	int err;
+	struct page *page = __page_cache_alloc_order(gfp, order);
+
+	if (!page)
+		return -ENOMEM;
+	if (mark - index < (1UL << order))
+		SetPageReadahead(page);
+	err = add_to_page_cache_lru(page, rac->mapping, index, gfp);
+	if (err)
+		put_page(page);
+	else
+		rac->_nr_pages += 1UL << order;
+	return err;
+}
+
+static bool page_cache_readahead_order(struct readahead_control *rac,
+		struct file_ra_state *ra, unsigned int order)
+{
+	struct address_space *mapping = rac->mapping;
+	unsigned int old_order = order;
+	pgoff_t index = readahead_index(rac);
+	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t mark = index + ra->size - ra->async_size;
+	int err = 0;
+	gfp_t gfp = readahead_gfp_mask(mapping);
+
+	if (!mapping_thp_support(mapping))
+		return false;
+
+	limit = min(limit, index + ra->size - 1);
+
+	/* Grow page size up to PMD size */
+	if (order < HPAGE_PMD_ORDER) {
+		order += 2;
+		if (order > HPAGE_PMD_ORDER)
+			order = HPAGE_PMD_ORDER;
+		while ((1 << order) > ra->size)
+			order--;
+	}
+
+	/* If size is somehow misaligned, fill with order-0 pages */
+	while (!err && index & ((1UL << old_order) - 1))
+		err = ra_alloc_page(rac, index++, mark, 0, gfp);
+
+	while (!err && index & ((1UL << order) - 1)) {
+		err = ra_alloc_page(rac, index, mark, old_order, gfp);
+		index += 1UL << old_order;
+	}
+
+	while (!err && index <= limit) {
+		err = ra_alloc_page(rac, index, mark, order, gfp);
+		index += 1UL << order;
+	}
+
+	if (index > limit) {
+		ra->size += index - limit - 1;
+		ra->async_size += index - limit - 1;
+	}
+
+	read_pages(rac, NULL, false);
+
+	/*
+	 * If there were already pages in the page cache, then we may have
+	 * left some gaps.  Let the regular readahead code take care of this
+	 * situation.
+	 */
+	return !err;
+}
+#else
+static bool page_cache_readahead_order(struct readahead_control *rac,
+		struct file_ra_state *ra, unsigned int order)
+{
+	return false;
+}
+#endif
+
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
 static void ondemand_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file,
-		bool hit_readahead_marker, pgoff_t index,
-		unsigned long req_size)
+		struct page *page, pgoff_t index, unsigned long req_size)
 {
 	DEFINE_READAHEAD(rac, file, mapping, index);
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
@@ -473,7 +552,7 @@ static void ondemand_readahead(struct address_space *mapping,
 	 * Query the pagecache for async_size, which normally equals to
 	 * readahead size. Ramp it up and use it as the new readahead size.
 	 */
-	if (hit_readahead_marker) {
+	if (page) {
 		pgoff_t start;
 
 		rcu_read_lock();
@@ -544,6 +623,8 @@ static void ondemand_readahead(struct address_space *mapping,
 	}
 
 	rac._index = ra->start;
+	if (page && page_cache_readahead_order(&rac, ra, thp_order(page)))
+		return;
 	__do_page_cache_readahead(&rac, ra->size, ra->async_size);
 }
 
@@ -578,7 +659,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, false, index, req_count);
+	ondemand_readahead(mapping, ra, filp, NULL, index, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
@@ -624,7 +705,7 @@ page_cache_async_readahead(struct address_space *mapping,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, true, index, req_count);
+	ondemand_readahead(mapping, ra, filp, page, index, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 
-- 
2.26.2

