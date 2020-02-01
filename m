Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C5114F832
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgBAPMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:12:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBAPMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6RY0UUjdaQhDdTRUN9wz8mjIn266EGtHTTMcbVMwTms=; b=sg8vRCPjK4w0XFjy7NZSoRgAsd
        sBqqUd+isaXbSIeuUVYJtJcfV1jXRDPy/1U16VGmZmw7bTQ2rLIGBTuQKAD/evbIN/2CGbqf86yup
        XZ76ZxqM71IlldJbmwKxuiwssBnvs5ewBtmJYaNdUdUO6dOPG3sciLrooImEXaiNT1xW8H07J2elq
        MLCqW63FKLppkTHRkeZA8wHWWlexMlCPdis108H2QqcdbP7xU7qfs0u4ZevSD35ABj+qvZpfKPRbf
        WCKm37R+Iue4NcPjCNjV5Q89mRHaRwM5fowkUIPipwzn+iV7HDCMv8T9DB6eFWwAwMXNJ5OgUQWmH
        9h9aE2Jw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuRu-0006HP-4H; Sat, 01 Feb 2020 15:12:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH v4 03/12] readahead: Put pages in cache earlier
Date:   Sat,  1 Feb 2020 07:12:31 -0800
Message-Id: <20200201151240.24082-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201151240.24082-1-willy@infradead.org>
References: <20200201151240.24082-1-willy@infradead.org>
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
Cc: linux-btrfs@vger.kernel.org
Cc: linux-erofs@lists.ozlabs.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-xfs@vger.kernel.org
Cc: cluster-devel@redhat.com
Cc: ocfs2-devel@oss.oracle.com
---
 mm/readahead.c | 64 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index fc77d13af556..7daef0038b14 100644
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
 
@@ -153,13 +152,14 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
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
@@ -170,21 +170,32 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 	 * Preallocate as many pages as we will need.
 	 */
 	for (page_idx = 0; page_idx < nr_to_read; page_idx++) {
-		pgoff_t page_offset = offset + page_idx;
+		struct page *page;
 
+		page_offset = offset + page_idx;
 		if (page_offset > end_index)
 			break;
 
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
+			/*
+			 * It's possible this page is the page we should
+			 * be marking with PageReadahead.  However, we
+			 * don't have a stable ref to this page so it might
+			 * be reallocated to another user before we can set
+			 * the bit.  There's probably another page in the
+			 * cache marked with PageReadahead from the other
+			 * process which accessed this file.
+			 */
 			nr_pages = 0;
 			continue;
 		}
@@ -192,8 +203,20 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
 		page = __page_cache_alloc(gfp_mask);
 		if (!page)
 			break;
-		page->index = page_offset;
-		list_add(&page->lru, &page_pool);
+		if (use_list) {
+			page->index = page_offset;
+			list_add(&page->lru, &page_pool);
+		} else if (add_to_page_cache_lru(page, mapping, page_offset,
+					gfp_mask) < 0) {
+			if (nr_pages)
+				read_pages(mapping, filp, &page_pool,
+						page_offset - nr_pages,
+						nr_pages);
+			put_page(page);
+			nr_pages = 0;
+			continue;
+		}
+
 		if (page_idx == nr_to_read - lookahead_size)
 			SetPageReadahead(page);
 		nr_pages++;
@@ -205,7 +228,8 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
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

