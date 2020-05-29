Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011CD1E7327
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391714AbgE2DAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407291AbgE2C6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3560C008634;
        Thu, 28 May 2020 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6hOSY0AepZPUXeoiFiLtItvOqrCqHbgM6bZ40Vh0p/o=; b=bqWGL6nNFUxBWrAdJ2lQJ33NZs
        +Ij15Zop82OumlIIQf82UWNjsZz6a2dCf9eydJMCvNSQ+gFZE4YErya6iwCoIntUJwSKVSnYKrNUW
        8eLeZwVhrf16NQmKm4H/9evP1ew8g2ZGT3CNOKRtDQCNxpRpqDBKIIp9hAMMuRxXh4mpzk7ZeIdzW
        pMFIY8+o/IahjAQTt3xz0SYEHf1cS6c59CV3ZSYPsBgCi0VLCryUukwx03C4g5ZcH9X6MMM9h/1S/
        AMeIOQi9Ah65VyY/0pwzGtGvzr7v8Xf2c+zvJ96s+OsGtgg+hKeKhcn4L836bOzhVa4Pn96iUEfI1
        kq2zqr2A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008T2-Nl; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 30/39] mm: Handle truncates that split large pages
Date:   Thu, 28 May 2020 19:58:15 -0700
Message-Id: <20200529025824.32296-31-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Move shmem_punch_compound() to truncate.c and rename it to punch_thp().
Change its arguments to loff_t to make calling do_invalidatepage()
easier.  Call it when we find a THP in the cache.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h |  2 ++
 mm/shmem.c    | 30 ++--------------------------
 mm/truncate.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5efb13d5c226..3090e22b984d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -604,4 +604,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+bool punch_thp(struct page *page, loff_t start, loff_t end);
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index d722eb830317..a4d4e817a33f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -788,32 +788,6 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	}
 }
 
-/*
- * Check whether a hole-punch or truncation needs to split a huge page,
- * returning true if no split was required, or the split has been successful.
- *
- * Eviction (or truncation to 0 size) should never need to split a huge page;
- * but in rare cases might do so, if shmem_undo_range() failed to trylock on
- * head, and then succeeded to trylock on tail.
- *
- * A split can only succeed when there are no additional references on the
- * huge page: so the split below relies upon find_get_entries() having stopped
- * when it found a subpage of the huge page, without getting further references.
- */
-static bool shmem_punch_compound(struct page *page, pgoff_t start, pgoff_t end)
-{
-	if (!PageTransCompound(page))
-		return true;
-
-	/* Just proceed to delete a huge page wholly within the range punched */
-	if (PageHead(page) &&
-	    page->index >= start && page->index + HPAGE_PMD_NR <= end)
-		return true;
-
-	/* Try to split huge page, so we can truly punch the hole or truncate */
-	return split_huge_page(page) >= 0;
-}
-
 /*
  * Remove range of pages and swap entries from page cache, and free them.
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
@@ -867,7 +841,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if ((!unfalloc || !PageUptodate(page)) &&
 			    page_mapping(page) == mapping) {
 				VM_BUG_ON_PAGE(PageWriteback(page), page);
-				if (shmem_punch_compound(page, start, end))
+				if (punch_thp(page, lstart, lend))
 					truncate_inode_page(mapping, page);
 			}
 			unlock_page(page);
@@ -950,7 +924,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					break;
 				}
 				VM_BUG_ON_PAGE(PageWriteback(page), page);
-				if (shmem_punch_compound(page, start, end))
+				if (punch_thp(page, lstart, lend))
 					truncate_inode_page(mapping, page);
 				else {
 					/* Wipe the page and don't get stuck */
diff --git a/mm/truncate.c b/mm/truncate.c
index dad384a4dc6d..59cae74b152d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -229,6 +229,55 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
 	return 0;
 }
 
+/*
+ * Check whether a hole-punch or truncation needs to split a huge page,
+ * returning true if no split was required, or the split has been
+ * successful.
+ *
+ * Eviction (or truncation to 0 size) should never need to split a huge
+ * page; but in rare cases might do so, if shmem_undo_range() failed to
+ * trylock on head, and then succeeded to trylock on tail.
+ *
+ * A split can only succeed when there are no additional references on
+ * the huge page: so the split below relies upon find_get_entries()
+ * having stopped when it found a subpage of the huge page, without
+ * getting further references.
+ */
+bool punch_thp(struct page *page, loff_t start, loff_t end)
+{
+	struct page *head = compound_head(page);
+	loff_t pos = page_offset(head);
+	unsigned int offset, length;
+
+	if (!PageTransCompound(page))
+		return true;
+
+	if (pos < start)
+		offset = start - pos;
+	else
+		offset = 0;
+	length = thp_size(head);
+	if (pos + length < end)
+		length = length - offset;
+	else
+		length = end - pos - offset;
+
+	/* Just proceed to delete a huge page wholly within the range punched */
+	if (length == thp_size(head))
+		return true;
+
+	/*
+	 * We're going to split the page into order-0 pages.  Tell the
+	 * filesystem which range of the page is going to be punched out
+	 * so it can discard unnecessary private data.
+	 */
+	if (page_has_private(head))
+		do_invalidatepage(head, offset, length);
+
+	/* Try to split huge page, so we can truly punch the hole or truncate */
+	return split_huge_page(page) >= 0;
+}
+
 /*
  * Used to get rid of pages on hardware memory corruption.
  */
@@ -359,7 +408,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 				unlock_page(page);
 				continue;
 			}
-			pagevec_add(&locked_pvec, page);
+			if (punch_thp(page, lstart, lend))
+				pagevec_add(&locked_pvec, page);
 		}
 		for (i = 0; i < pagevec_count(&locked_pvec); i++)
 			truncate_cleanup_page(mapping, locked_pvec.pages[i]);
@@ -446,7 +496,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			lock_page(page);
 			WARN_ON(page_to_index(page) != index);
 			wait_on_page_writeback(page);
-			truncate_inode_page(mapping, page);
+			if (punch_thp(page, lstart, lend))
+				truncate_inode_page(mapping, page);
 			unlock_page(page);
 		}
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices, end);
-- 
2.26.2

