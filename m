Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20A16510E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBSVBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:01:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSVBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vhLH5Sbrak3JAHbVrH4ikkRxZI58fwVlV1VnoATDnKM=; b=WXBgTKQseU8E34FxKQI0F2BT+o
        CQ7O4Q4Hr6JgCjCHNJs0UaY4bivB07YB9Mp447bJYCwoplvd1D+OL7cnRtYs35XBf3evBAD69gnvb
        12ucE1OpTnyHYjLZ7m5HeP+SJoRKvp6sFMkk9vat3VTmGpEhSNVll6sVlBYIdZaUY9OBgstb2XvXi
        38RTWxE3tC1OZRty3qOOKhJ4OJbTOu4lTQbG8cFdd90DPceHh455tUlFgOrmyoxcNaTaUFVMASCWz
        rnV8O9HzXEmt07Cb2ZhBfuAC9Lr/oNscwOBJAe9YnjUwO0l6BmNfmFOUEZSGqv+oEI97+rO6oMQ90
        sDELCpfA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSv-0008Tm-1k; Wed, 19 Feb 2020 21:01:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 09/24] mm: Put readahead pages in cache earlier
Date:   Wed, 19 Feb 2020 13:00:48 -0800
Message-Id: <20200219210103.32400-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

When populating the page cache for readahead, mappings that use
->readpages must populate the page cache themselves as the pages are
passed on a linked list which would normally be used for the page cache's
LRU.  For mappings that use ->readpage or the upcoming ->readahead method,
we can put the pages into the page cache as soon as they're allocated,
which solves a race between readahead and direct IO.  It also lets us
remove the gfp argument from read_pages().

Use the new readahead_page() API to implement the repeated calls to
->readpage(), just like most filesystems will.  This iterator also
supports huge pages, even though none of the filesystems have been
converted to use them yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 20 +++++++++++++++++
 mm/readahead.c          | 48 +++++++++++++++++++++++++----------------
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 55fcea0249e6..4989d330fada 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -647,8 +647,28 @@ struct readahead_control {
 /* private: use the readahead_* accessors instead */
 	pgoff_t _index;
 	unsigned int _nr_pages;
+	unsigned int _batch_count;
 };
 
+static inline struct page *readahead_page(struct readahead_control *rac)
+{
+	struct page *page;
+
+	BUG_ON(rac->_batch_count > rac->_nr_pages);
+	rac->_nr_pages -= rac->_batch_count;
+	rac->_index += rac->_batch_count;
+	rac->_batch_count = 0;
+
+	if (!rac->_nr_pages)
+		return NULL;
+
+	page = xa_load(&rac->mapping->i_pages, rac->_index);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	rac->_batch_count = hpage_nr_pages(page);
+
+	return page;
+}
+
 /* The number of pages in this readahead block */
 static inline unsigned int readahead_count(struct readahead_control *rac)
 {
diff --git a/mm/readahead.c b/mm/readahead.c
index 83df5c061d33..aaa209559ba2 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,15 +113,14 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 
 EXPORT_SYMBOL(read_cache_pages);
 
-static void read_pages(struct readahead_control *rac, struct list_head *pages,
-		gfp_t gfp)
+static void read_pages(struct readahead_control *rac, struct list_head *pages)
 {
 	const struct address_space_operations *aops = rac->mapping->a_ops;
+	struct page *page;
 	struct blk_plug plug;
-	unsigned page_idx;
 
 	if (!readahead_count(rac))
-		return;
+		goto out;
 
 	blk_start_plug(&plug);
 
@@ -130,23 +129,23 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 				readahead_count(rac));
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
-		goto out;
-	}
-
-	for (page_idx = 0; page_idx < readahead_count(rac); page_idx++) {
-		struct page *page = lru_to_page(pages);
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, rac->mapping, page->index,
-				gfp))
+		rac->_index += rac->_nr_pages;
+		rac->_nr_pages = 0;
+	} else {
+		while ((page = readahead_page(rac))) {
 			aops->readpage(rac->file, page);
-		put_page(page);
+			put_page(page);
+		}
 	}
 
-out:
 	blk_finish_plug(&plug);
 
 	BUG_ON(!list_empty(pages));
-	rac->_nr_pages = 0;
+	BUG_ON(readahead_count(rac));
+
+out:
+	/* If we were called due to a conflicting page, skip over it */
+	rac->_index++;
 }
 
 /*
@@ -165,9 +164,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	LIST_HEAD(page_pool);
 	loff_t isize = i_size_read(inode);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
+	bool use_list = mapping->a_ops->readpages;
 	struct readahead_control rac = {
 		.mapping = mapping,
 		.file = filp,
+		._index = index,
 		._nr_pages = 0,
 	};
 	unsigned long i;
@@ -184,6 +185,8 @@ void __do_page_cache_readahead(struct address_space *mapping,
 		if (index + i > end_index)
 			break;
 
+		BUG_ON(index + i != rac._index + rac._nr_pages);
+
 		page = xa_load(&mapping->i_pages, index + i);
 		if (page && !xa_is_value(page)) {
 			/*
@@ -191,15 +194,22 @@ void __do_page_cache_readahead(struct address_space *mapping,
 			 * contiguous pages before continuing with the next
 			 * batch.
 			 */
-			read_pages(&rac, &page_pool, gfp_mask);
+			read_pages(&rac, &page_pool);
 			continue;
 		}
 
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = index + i;
-		list_add(&page->lru, &page_pool);
+		if (use_list) {
+			page->index = index + i;
+			list_add(&page->lru, &page_pool);
+		} else if (add_to_page_cache_lru(page, mapping, index + i,
+					gfp_mask) < 0) {
+			put_page(page);
+			read_pages(&rac, &page_pool);
+			continue;
+		}
 		if (i == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		rac._nr_pages++;
@@ -210,7 +220,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(&rac, &page_pool, gfp_mask);
+	read_pages(&rac, &page_pool);
 }
 
 /*
-- 
2.25.0

