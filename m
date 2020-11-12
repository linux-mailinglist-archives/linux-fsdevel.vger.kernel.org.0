Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B12B1047
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgKLV1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgKLV1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:27:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC5C0613D1;
        Thu, 12 Nov 2020 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HzBDjinxaIupRQuRgbw6uvZwV6m7KZ5Scf5MNsXtHDY=; b=U30C+OFTvsiV3WiiA64yPKrS2h
        0L/nxwCXdOgcaaXy0QOtr0vExD0rIZdj13SubElhEIVymcC/X0I1lqHpr7YqsDTbQSfNJq12fQ+kb
        5Im5l689oE7qlKyeNCr4+TDKh4lHN+49GU3Oc8X5WOZxgogY5eBwglqtR5AZRLNa0u1bzsfVG+IOe
        XLEwAvv2v58YK5Bb4sAhumPNmKarS1N3L0EfyVgFGOQJ0Epc73visw9eyLxFUhZ9AN8uNkG3EnlSd
        zcxBsEvIiXEZeenFlsM1SiiATMzH4v1o9iEhXIUxocoxgCIRKF1OoemThpn379JjDqQ/F9a7/qNgM
        1166Y06g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK7B-0007GN-90; Thu, 12 Nov 2020 21:26:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/16] mm: Add FGP_ENTRY
Date:   Thu, 12 Nov 2020 21:26:29 +0000
Message-Id: <20201112212641.27837-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The functionality of find_lock_entry() and find_get_entry() can be
provided by pagecache_get_pages(), which lets us delete find_lock_entry()
and make find_get_entry() static.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 44 ++++++++---------------------------------
 mm/internal.h           |  3 ---
 mm/shmem.c              |  3 ++-
 mm/swap_state.c         |  3 ++-
 5 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index edb990f3b930..55e1bff1c4b9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -313,6 +313,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 #define FGP_NOWAIT		0x00000020
 #define FGP_FOR_MMAP		0x00000040
 #define FGP_HEAD		0x00000080
+#define FGP_ENTRY		0x00000100
 
 struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 		int fgp_flags, gfp_t cache_gfp_mask);
diff --git a/mm/filemap.c b/mm/filemap.c
index bb6f2ae5a68c..01603f021740 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1662,7 +1662,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 
-/**
+/*
  * find_get_entry - find and get a page cache entry
  * @mapping: the address_space to search
  * @index: The page cache index.
@@ -1675,7 +1675,7 @@ EXPORT_SYMBOL(page_cache_prev_miss);
  *
  * Return: The head page or shadow entry, %NULL if nothing is found.
  */
-struct page *find_get_entry(struct address_space *mapping, pgoff_t index)
+static struct page *find_get_entry(struct address_space *mapping, pgoff_t index)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct page *page;
@@ -1711,39 +1711,6 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t index)
 	return page;
 }
 
-/**
- * find_lock_entry - Locate and lock a page cache entry.
- * @mapping: The address_space to search.
- * @index: The page cache index.
- *
- * Looks up the page at @mapping & @index.  If there is a page in the
- * cache, the head page is returned locked and with an increased refcount.
- *
- * If the slot holds a shadow entry of a previously evicted page, or a
- * swap entry from shmem/tmpfs, it is returned.
- *
- * Context: May sleep.
- * Return: The head page or shadow entry, %NULL if nothing is found.
- */
-struct page *find_lock_entry(struct address_space *mapping, pgoff_t index)
-{
-	struct page *page;
-
-repeat:
-	page = find_get_entry(mapping, index);
-	if (page && !xa_is_value(page)) {
-		lock_page(page);
-		/* Has the page been truncated? */
-		if (unlikely(page->mapping != mapping)) {
-			unlock_page(page);
-			put_page(page);
-			goto repeat;
-		}
-		VM_BUG_ON_PAGE(!thp_contains(page, index), page);
-	}
-	return page;
-}
-
 /**
  * pagecache_get_page - Find and get a reference to a page.
  * @mapping: The address_space to search.
@@ -1759,6 +1726,8 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t index)
  * * %FGP_LOCK - The page is returned locked.
  * * %FGP_HEAD - If the page is present and a THP, return the head page
  *   rather than the exact page specified by the index.
+ * * %FGP_ENTRY - If there is a shadow / swap / DAX entry, return it
+ *   instead of allocating a new page to replace it.
  * * %FGP_CREAT - If no page is present then a new page is allocated using
  *   @gfp_mask and added to the page cache and the VM's LRU list.
  *   The page is returned locked and with an increased refcount.
@@ -1783,8 +1752,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 
 repeat:
 	page = find_get_entry(mapping, index);
-	if (xa_is_value(page))
+	if (xa_is_value(page)) {
+		if (fgp_flags & FGP_ENTRY)
+			return page;
 		page = NULL;
+	}
 	if (!page)
 		goto no_page;
 
diff --git a/mm/internal.h b/mm/internal.h
index c43ccdddb0f6..93880d460e12 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -60,9 +60,6 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, &file->f_ra, nr_to_read);
 }
 
-struct page *find_get_entry(struct address_space *mapping, pgoff_t index);
-struct page *find_lock_entry(struct address_space *mapping, pgoff_t index);
-
 /**
  * page_evictable - test whether a page is evictable
  * @page: the page to test
diff --git a/mm/shmem.c b/mm/shmem.c
index 8076c171731c..c4feb05425f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1831,7 +1831,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	sbinfo = SHMEM_SB(inode->i_sb);
 	charge_mm = vma ? vma->vm_mm : current->mm;
 
-	page = find_lock_entry(mapping, index);
+	page = pagecache_get_page(mapping, index,
+					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
 	if (xa_is_value(page)) {
 		error = shmem_swapin_page(inode, index, &page,
 					  sgp, gfp, vma, fault_type);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d2161154d873..7cb4433edaa2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -427,7 +427,8 @@ struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index)
 {
 	swp_entry_t swp;
 	struct swap_info_struct *si;
-	struct page *page = find_get_entry(mapping, index);
+	struct page *page = pagecache_get_page(mapping, index,
+						FGP_ENTRY | FGP_HEAD, 0);
 
 	if (!page)
 		return page;
-- 
2.28.0

