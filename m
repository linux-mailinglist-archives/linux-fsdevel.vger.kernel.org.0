Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513503C986F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhGOFcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbhGOFcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:32:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EEC06175F;
        Wed, 14 Jul 2021 22:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XiMUvgaQRDYtKInq/h4jgn0syV52emYjHtsQoYohWY4=; b=uXEmtwKK4BYhtjvIXP5eOWI8a6
        7Dj9kZ96pnzLmW5EdnGCY/fBzRzRjcxFsOrIcBr9sWGfUzQtR3LwnfAfp6894LET/mIkzV7BL3K4a
        4jaXee88MmQJDcyVz2tLHWF3GhdbXCrM14RsVtnlQqx/0Lv5EEkTHhUFMLeJHUD54I1NRwY9nwQXk
        ni7/rKoyHH3v+66NlAExxvUdkmxUUMzcC9/UGqgQ46+NVKREUMDARCSnQkTjLdW1Qac6k2EyAyJdk
        Jn7uU+gzBpzuFGcefZ/o+bMzq9LxSspKDLnJJYm4kfWaX7BdlbPl56xpssJY8V/Oeee3/l3ka5J+L
        b5oKWFKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tuu-0031Js-3E; Thu, 15 Jul 2021 05:28:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 138/138] mm/readahead: Add multi-page folio readahead
Date:   Thu, 15 Jul 2021 04:37:04 +0100
Message-Id: <20210715033704.692967-139-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the filesystem supports multi-page folios, allocate larger pages in
the readahead code when it seems worth doing.  The heuristic for choosing
larger page sizes will surely need some tuning, but this aggressive
ramp-up has been good for testing.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 102 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e1df44ad57ed..27e76cc2a9ba 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -149,7 +149,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 	blk_finish_plug(&plug);
 
-	BUG_ON(!list_empty(pages));
+	BUG_ON(pages && !list_empty(pages));
 	BUG_ON(readahead_count(rac));
 
 out:
@@ -430,11 +430,99 @@ static int try_context_readahead(struct address_space *mapping,
 	return 1;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
+		pgoff_t mark, unsigned int order, gfp_t gfp)
+{
+	int err;
+	struct folio *folio = filemap_alloc_folio(gfp, order);
+
+	if (!folio)
+		return -ENOMEM;
+	if (mark - index < (1UL << order))
+		folio_set_readahead(folio);
+	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
+	if (err)
+		folio_put(folio);
+	else
+		ractl->_nr_pages += 1UL << order;
+	return err;
+}
+
+static void page_cache_ra_order(struct readahead_control *ractl,
+		struct file_ra_state *ra, unsigned int new_order)
+{
+	struct address_space *mapping = ractl->mapping;
+	pgoff_t index = readahead_index(ractl);
+	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t mark = index + ra->size - ra->async_size;
+	int err = 0;
+	gfp_t gfp = readahead_gfp_mask(mapping);
+
+	if (!mapping_thp_support(mapping) || ra->size < 4)
+		goto fallback;
+
+	limit = min(limit, index + ra->size - 1);
+
+	/* Grow page size up to PMD size */
+	if (new_order < HPAGE_PMD_ORDER) {
+		new_order += 2;
+		if (new_order > HPAGE_PMD_ORDER)
+			new_order = HPAGE_PMD_ORDER;
+		while ((1 << new_order) > ra->size)
+			new_order--;
+	}
+
+	while (index <= limit) {
+		unsigned int order = new_order;
+
+		/* Align with smaller pages if needed */
+		if (index & ((1UL << order) - 1)) {
+			order = __ffs(index);
+			if (order == 1)
+				order = 0;
+		}
+		/* Don't allocate pages past EOF */
+		while (index + (1UL << order) - 1 > limit) {
+			if (--order == 1)
+				order = 0;
+		}
+		err = ra_alloc_folio(ractl, index, mark, order, gfp);
+		if (err)
+			break;
+		index += 1UL << order;
+	}
+
+	if (index > limit) {
+		ra->size += index - limit - 1;
+		ra->async_size += index - limit - 1;
+	}
+
+	read_pages(ractl, NULL, false);
+
+	/*
+	 * If there were already pages in the page cache, then we may have
+	 * left some gaps.  Let the regular readahead code take care of this
+	 * situation.
+	 */
+	if (!err)
+		return;
+fallback:
+	do_page_cache_ra(ractl, ra->size, ra->async_size);
+}
+#else
+static void page_cache_ra_order(struct readahead_control *ractl,
+		struct file_ra_state *ra, unsigned int order)
+{
+	do_page_cache_ra(ractl, ra->size, ra->async_size);
+}
+#endif
+
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
 static void ondemand_readahead(struct readahead_control *ractl,
-		bool hit_readahead_marker, unsigned long req_size)
+		struct folio *folio, unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
 	struct file_ra_state *ra = ractl->ra;
@@ -469,12 +557,12 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	/*
-	 * Hit a marked page without valid readahead state.
+	 * Hit a marked folio without valid readahead state.
 	 * E.g. interleaved reads.
 	 * Query the pagecache for async_size, which normally equals to
 	 * readahead size. Ramp it up and use it as the new readahead size.
 	 */
-	if (hit_readahead_marker) {
+	if (folio) {
 		pgoff_t start;
 
 		rcu_read_lock();
@@ -547,7 +635,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	ractl->_index = ra->start;
-	do_page_cache_ra(ractl, ra->size, ra->async_size);
+	page_cache_ra_order(ractl, ra, folio ? folio_order(folio) : 0);
 }
 
 void page_cache_sync_ra(struct readahead_control *ractl,
@@ -575,7 +663,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, false, req_count);
+	ondemand_readahead(ractl, NULL, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
@@ -604,7 +692,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, true, req_count);
+	ondemand_readahead(ractl, folio, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
-- 
2.30.2

