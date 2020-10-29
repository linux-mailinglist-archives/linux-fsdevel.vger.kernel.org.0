Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6F129F565
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJ2Te1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgJ2TeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24298C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wmxCHbi3U3r2Cgj8P7MXYuiRGLaiVPEgjTYbK8P//3o=; b=UBv1pHc9YqhyysyzsEv48fXnR5
        OsvB0zVLCy1RrfHvu5sor3juarZomqtlTo6qP9+dl4UXMlbLqBh6jXcMvlNMY0c1PcUVxM8hfdDDf
        bSm+ZVY3xoNuC3O95k7Lday+o2ssEVKRNXi9a4+x3RBLDd+hFLvEUdsp8xOwuBgji8n32avKg7YtH
        ANeDZoy65mZsMbciBszt4BatDfn0IkgZmwImOkCVYlHH+Pheu6doQAv/jSqOcIHCoUzfOUsYGnazZ
        MAp80CGE5Sj4INiR2kj0g/wdOcUXQqW3LdSmTGxr0hedawo7cgBthiR711qQhWIvgd98l4D9o+3If
        SBX0EbRg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgZ-0007cj-I3; Thu, 29 Oct 2020 19:34:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 15/19] mm/readahead: Add THP readahead
Date:   Thu, 29 Oct 2020 19:34:01 +0000
Message-Id: <20201029193405.29125-16-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the filesystem supports THPs, allocate larger pages in the
readahead code when it seems worth doing.  The heuristic for choosing
larger page sizes will surely need some tuning, but this aggressive
ramp-up seems good for testing.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 6 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index c5b0457415be..dc9876104ee8 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -149,7 +149,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 
 	blk_finish_plug(&plug);
 
-	BUG_ON(!list_empty(pages));
+	BUG_ON(pages && !list_empty(pages));
 	BUG_ON(readahead_count(rac));
 
 out:
@@ -429,11 +429,99 @@ static int try_context_readahead(struct address_space *mapping,
 	return 1;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline int ra_alloc_page(struct readahead_control *ractl, pgoff_t index,
+		pgoff_t mark, unsigned int order, gfp_t gfp)
+{
+	int err;
+	struct page *page = __page_cache_alloc_order(gfp, order);
+
+	if (!page)
+		return -ENOMEM;
+	if (mark - index < (1UL << order))
+		SetPageReadahead(page);
+	err = add_to_page_cache_lru(page, ractl->mapping, index, gfp);
+	if (err)
+		put_page(page);
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
+		err = ra_alloc_page(ractl, index, mark, order, gfp);
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
-		struct file_ra_state *ra, bool hit_readahead_marker,
+		struct file_ra_state *ra, struct page *page,
 		unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
@@ -473,7 +561,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * Query the pagecache for async_size, which normally equals to
 	 * readahead size. Ramp it up and use it as the new readahead size.
 	 */
-	if (hit_readahead_marker) {
+	if (page) {
 		pgoff_t start;
 
 		rcu_read_lock();
@@ -546,7 +634,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	}
 
 	ractl->_index = ra->start;
-	do_page_cache_ra(ractl, ra->size, ra->async_size);
+	page_cache_ra_order(ractl, ra, page ? thp_order(page) : 0);
 }
 
 void page_cache_sync_ra(struct readahead_control *ractl,
@@ -574,7 +662,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, ra, false, req_count);
+	ondemand_readahead(ractl, ra, NULL, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
@@ -604,7 +692,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(ractl, ra, true, req_count);
+	ondemand_readahead(ractl, ra, page, req_count);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
-- 
2.28.0

