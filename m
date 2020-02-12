Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFA159FEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgBLESt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F5NU3oCRsJ/VRewPgyFmDI/jOyoaYvHI3EnYnqICXs0=; b=lTq6KvZ25CFBn20eSyRhQz+xt4
        xZ5E0flMQSOELfzqd57XfcPrr/jsPgY5r7h5VGuLF8q8wml2MDikHBD1nkHZxF9oGnyYdmwD/nBOJ
        5rSiKXMb5QcGERIaLQXM/T9RTt7f8B/4vli/UrD3Y4uEBPB3+vbbi0uGsbBVDvmcJx6IzRE9lSdH3
        IBqUNVplisHwBmiOyYmef8UmsYF2HfbbPUQasNPZXwcFJfxaTuFUqdY1Z0wwSVA0k60KQ1LbCJzdH
        E4aajx9ShctTRRA6nl9E05t9s7BupBssLXhxgL+gGIqri1khlJg9vlNER8XmyWjsAcqS0QZMbGckM
        gIRtseLQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006pC-HQ; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/25] mm: Add large page readahead
Date:   Tue, 11 Feb 2020 20:18:44 -0800
Message-Id: <20200212041845.25879-25-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the filesystem supports large pages, allocate larger pages in the
readahead code when it seems worth doing.  The heuristic for choosing
larger page sizes will surely need some tuning, but this aggressive
ramp-up seems good for testing.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 29ca25c8f01e..b582f09aa7e3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -406,13 +406,96 @@ static int try_context_readahead(struct address_space *mapping,
 	return 1;
 }
 
+static inline int ra_alloc_page(struct address_space *mapping, pgoff_t offset,
+		pgoff_t mark, unsigned int order, gfp_t gfp)
+{
+	int err;
+	struct page *page = __page_cache_alloc_order(gfp, order);
+
+	if (!page)
+		return -ENOMEM;
+	if (mark - offset < (1UL << order))
+		SetPageReadahead(page);
+	err = add_to_page_cache_lru(page, mapping, offset, gfp);
+	if (err)
+		put_page(page);
+	return err;
+}
+
+#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
+
+static unsigned long page_cache_readahead_order(struct address_space *mapping,
+		struct file_ra_state *ra, struct file *file, unsigned int order)
+{
+	struct readahead_control rac = {
+		.mapping = mapping,
+		.file = file,
+		.start = ra->start,
+		.nr_pages = 0,
+	};
+	unsigned int old_order = order;
+	pgoff_t offset = ra->start;
+	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
+	pgoff_t mark = offset + ra->size - ra->async_size;
+	int err = 0;
+	gfp_t gfp = readahead_gfp_mask(mapping);
+
+	limit = min(limit, offset + ra->size - 1);
+
+	/* Grow page size up to PMD size */
+	if (order < PMD_ORDER) {
+		order += 2;
+		if (order > PMD_ORDER)
+			order = PMD_ORDER;
+		while ((1 << order) > ra->size)
+			order--;
+	}
+
+	/* If size is somehow misaligned, fill with order-0 pages */
+	while (!err && offset & ((1UL << old_order) - 1)) {
+		err = ra_alloc_page(mapping, offset++, mark, 0, gfp);
+		if (!err)
+			rac.nr_pages++;
+	}
+
+	while (!err && offset & ((1UL << order) - 1)) {
+		err = ra_alloc_page(mapping, offset, mark, old_order, gfp);
+		if (!err)
+			rac.nr_pages += 1UL << old_order;
+		offset += 1UL << old_order;
+	}
+
+	while (!err && offset <= limit) {
+		err = ra_alloc_page(mapping, offset, mark, order, gfp);
+		if (!err)
+			rac.nr_pages += 1UL << order;
+		offset += 1UL << order;
+	}
+
+	if (offset > limit) {
+		ra->size += offset - limit - 1;
+		ra->async_size += offset - limit - 1;
+	}
+
+	read_pages(&rac, NULL);
+
+	/*
+	 * If there were already pages in the page cache, then we may have
+	 * left some gaps.  Let the regular readahead code take care of this
+	 * situation.
+	 */
+	if (err)
+		return ra_submit(ra, mapping, file);
+	return 0;
+}
+
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
 static unsigned long
 ondemand_readahead(struct address_space *mapping,
 		   struct file_ra_state *ra, struct file *filp,
-		   bool hit_readahead_marker, pgoff_t offset,
+		   struct page *page, pgoff_t offset,
 		   unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
@@ -451,7 +534,7 @@ ondemand_readahead(struct address_space *mapping,
 	 * Query the pagecache for async_size, which normally equals to
 	 * readahead size. Ramp it up and use it as the new readahead size.
 	 */
-	if (hit_readahead_marker) {
+	if (page) {
 		pgoff_t start;
 
 		rcu_read_lock();
@@ -520,7 +603,12 @@ ondemand_readahead(struct address_space *mapping,
 		}
 	}
 
-	return ra_submit(ra, mapping, filp);
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) || !page ||
+	    !(mapping->host->i_sb->s_type->fs_flags & FS_LARGE_PAGES))
+		return ra_submit(ra, mapping, filp);
+
+	return page_cache_readahead_order(mapping, ra, filp,
+						compound_order(page));
 }
 
 /**
@@ -555,7 +643,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	}
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, false, offset, req_size);
+	ondemand_readahead(mapping, ra, filp, NULL, offset, req_size);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_readahead);
 
@@ -602,7 +690,7 @@ page_cache_async_readahead(struct address_space *mapping,
 		return;
 
 	/* do read-ahead */
-	ondemand_readahead(mapping, ra, filp, true, offset, req_size);
+	ondemand_readahead(mapping, ra, filp, page, offset, req_size);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_readahead);
 
-- 
2.25.0

