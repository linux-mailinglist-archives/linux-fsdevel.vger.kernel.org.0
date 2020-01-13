Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C56B1394FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 16:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgAMPhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 10:37:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgAMPhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dOAadIMTUupd20Eg2Q5RqFxOIthPxhUDYq6Q/juU65U=; b=h5nnknDpxtg47EUFlq9egYwY2Q
        BVp+XqvUz3RyOjCxys3SgxE+ritoHjVvgyDZ36NkMrrrwfr2kC2knN1NP0CoGkVdvtuFhj2Yvf4tA
        VjSYy3z+eL3rL11kVEmD7VKk1EGwVF9GyZ7wc8sscVYOXXEURYqq314o60EJJWx/6ToUW5CoKJjAn
        DpuvjUPQ5hkFpWzMcnaTNX+I0A70aAjno35EMwqvH8u+pFuUGSYiQjJrf8chJCmwN5w6GYyvu31GU
        pa2Kqn/JHsmhmGP6MdHRRtR0ZidTpsH5FAet4RtCa4BKvSNH4Xi2reB0reKS+G7/yxIkwXXkq0YYg
        vYkIgTuw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir1mr-00075z-5B; Mon, 13 Jan 2020 15:37:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        jlayton@kernel.org, hch@infradead.org
Subject: [PATCH 3/8] mm: Use a pagevec for readahead
Date:   Mon, 13 Jan 2020 07:37:41 -0800
Message-Id: <20200113153746.26654-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200113153746.26654-1-willy@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Instead of using a linked list, use a small array.  This does mean we
will allocate and then submit for I/O no more than 15 pages at a time
(60kB), but we have the block queue plugged so the bios can be combined
afterwards.  We generally don't readahead more than 256kB anyway,
so this is not a huge reduction in efficiency, and we'll make up
for it with later patches.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/readahead.c | 97 +++++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 45 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6bf73ef33b7e..76a70a4406b5 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,35 +113,37 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static int read_pages(struct address_space *mapping, struct file *filp,
-		struct list_head *pages, unsigned int nr_pages, gfp_t gfp)
+/*
+ * We ignore I/O errors - they will be handled by the actual consumer of
+ * the data that we attempted to prefetch.
+ */
+static unsigned read_pages(struct address_space *mapping, struct file *filp,
+		struct pagevec *pvec, pgoff_t offset, gfp_t gfp)
 {
-	struct blk_plug plug;
-	unsigned page_idx;
-	int ret;
-
-	blk_start_plug(&plug);
+	struct page *page;
+	unsigned int nr_pages = pagevec_count(pvec);
 
 	if (mapping->a_ops->readpages) {
-		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
-		/* Clean up the remaining pages */
-		put_pages_list(pages);
-		goto out;
-	}
+		LIST_HEAD(pages);
 
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		struct page *page = lru_to_page(pages);
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, mapping, page->index, gfp))
-			mapping->a_ops->readpage(filp, page);
-		put_page(page);
+		pagevec_for_each(pvec, page) {
+			page->index = offset++;
+			list_add(&page->lru, &pages);
+		}
+		mapping->a_ops->readpages(filp, mapping, &pages, nr_pages);
+		/* Clean up the remaining pages */
+		put_pages_list(&pages);
+	} else {
+		pagevec_for_each(pvec, page) {
+			if (!add_to_page_cache_lru(page, mapping, offset++,
+						gfp))
+				mapping->a_ops->readpage(filp, page);
+			put_page(page);
+		}
 	}
-	ret = 0;
 
-out:
-	blk_finish_plug(&plug);
-
-	return ret;
+	pagevec_reinit(pvec);
+	return nr_pages;
 }
 
 /*
@@ -159,59 +161,64 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct page *page;
 	unsigned long end_index;	/* The last page we want to read */
-	LIST_HEAD(page_pool);
+	struct pagevec pages;
 	int page_idx;
+	pgoff_t page_offset = offset;
 	unsigned long nr_pages = 0;
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	struct blk_plug plug;
+
+	blk_start_plug(&plug);
 
 	if (isize == 0)
 		goto out;
 
 	end_index = ((isize - 1) >> PAGE_SHIFT);
+	pagevec_init(&pages);
 
 	/*
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = offset + page_idx;
+		page_offset++;
 
 		if (page_offset > end_index)
 			break;
 
 		page = xa_load(&mapping->i_pages, page_offset);
+
+		/*
+		 * Page already present?  Kick off the current batch of
+		 * contiguous pages before continuing with the next batch.
+		 */
 		if (page && !xa_is_value(page)) {
-			/*
-			 * Page already present?  Kick off the current batch of
-			 * contiguous pages before continuing with the next
-			 * batch.
-			 */
-			if (nr_pages)
-				read_pages(mapping, filp, &page_pool, nr_pages,
-						gfp_mask);
-			nr_pages = 0;
+			unsigned int count = pagevec_count(&pages);
+
+			if (count)
+				nr_pages += read_pages(mapping, filp, &pages,
+						offset, gfp_mask);
+			offset = page_offset + 1;
 			continue;
 		}
 
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
-		list_add(&page->lru, &page_pool);
+		if (pagevec_add(&pages, page) == 0) {
+			nr_pages += read_pages(mapping, filp, &pages,
+					offset, gfp_mask);
+			offset = page_offset + 1;
+		}
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
-		nr_pages++;
 	}
 
-	/*
-	 * Now start the IO.  We ignore I/O errors - if the page is not
-	 * uptodate then the caller will launch readpage again, and
-	 * will then handle the error.
-	 */
-	if (nr_pages)
-		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
-	BUG_ON(!list_empty(&page_pool));
+	if (pagevec_count(&pages))
+		nr_pages += read_pages(mapping, filp, &pages, offset, gfp_mask);
 out:
+	blk_finish_plug(&plug);
+
 	return nr_pages;
 }
 
-- 
2.24.1

