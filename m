Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163743A7058
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbhFNU2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhFNU23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:28:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81207C061574;
        Mon, 14 Jun 2021 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dsGR2AbOCmA0/+J8i6E6x913kSjfVR3hIytXrngLNRs=; b=a63tLw7+7mgxuGpYZQbrEKrcSF
        9Z6+K/5Qzk9JRr4uulHfHEiVBt5iQbR9Fcf+qRjwau406jQcWEkVIacRoLAxZjy9U+q34U+V9Dho+
        7Ht8h5QYk1Cgmlyj4sCzpvCbWMn+8nZX20AKGIfgKE/8aFqLqY3vwwHTcrMM6dCZ5TvRrmkzu9eSL
        hp7Sf19+9HTBWcYh3ZidlI1VEWGVlKW+bGpf5NsEsxFOzeTlZGFJ+MOPHgiHszQoFLuqXtpp/4eA4
        FDOftT/CRbbMTZ3v/nz/N03FTtKe7TRFH7idvCU5Sg4v1n/KOwkQQrYm3SH7vP/derL8dBmTrWzIe
        RaTGUmJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lst8y-005nji-Ft; Mon, 14 Jun 2021 20:25:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 16/33] mm/util: Add folio_mapping() and folio_file_mapping()
Date:   Mon, 14 Jun 2021 21:14:18 +0100
Message-Id: <20210614201435.1379188-17-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalent of page_mapping() and page_file_mapping().
Add an out-of-line page_mapping() wrapper around folio_mapping()
in order to prevent the page_folio() call from bloating every caller
of page_mapping().  Adjust page_file_mapping() and page_mapping_file()
to use folios internally.  Rename __page_file_mapping() to
swapcache_mapping() and change it to take a folio.

This ends up saving 122 bytes of text overall.  folio_mapping() is
45 bytes shorter than page_mapping() was, but the new page_mapping()
wrapper is 30 bytes.  The major reduction is a few bytes less in dozens
of nfs functions (which call page_file_mapping()).  Most of these appear
to be a slight change in gcc's register allocation decisions, which allow:

   48 8b 56 08         mov    0x8(%rsi),%rdx
   48 8d 42 ff         lea    -0x1(%rdx),%rax
   83 e2 01            and    $0x1,%edx
   48 0f 44 c6         cmove  %rsi,%rax

to become:

   48 8b 46 08         mov    0x8(%rsi),%rax
   48 8d 78 ff         lea    -0x1(%rax),%rdi
   a8 01               test   $0x1,%al
   48 0f 44 fe         cmove  %rsi,%rdi

for a reduction of a single byte.  Once the NFS client is converted to
use folios, this entire sequence will disappear.

Also add folio_mapping() documentation.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 Documentation/core-api/mm-api.rst |  2 ++
 include/linux/mm.h                | 14 -------------
 include/linux/pagemap.h           | 35 +++++++++++++++++++++++++++++--
 include/linux/swap.h              |  6 ++++++
 mm/Makefile                       |  2 +-
 mm/folio-compat.c                 | 13 ++++++++++++
 mm/swapfile.c                     |  8 +++----
 mm/util.c                         | 30 +++++++++++++++-----------
 8 files changed, 77 insertions(+), 33 deletions(-)
 create mode 100644 mm/folio-compat.c

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index 5c459ee2acce..dcce6605947a 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -100,3 +100,5 @@ More Memory Management Functions
    :internal:
 .. kernel-doc:: include/linux/page_ref.h
 .. kernel-doc:: include/linux/mmzone.h
+.. kernel-doc:: mm/util.c
+   :functions: folio_mapping
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a16ea4e745a7..cd8078cbe21d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1754,19 +1754,6 @@ void page_address_init(void);
 
 extern void *page_rmapping(struct page *page);
 extern struct anon_vma *page_anon_vma(struct page *page);
-extern struct address_space *page_mapping(struct page *page);
-
-extern struct address_space *__page_file_mapping(struct page *);
-
-static inline
-struct address_space *page_file_mapping(struct page *page)
-{
-	if (unlikely(PageSwapCache(page)))
-		return __page_file_mapping(page);
-
-	return page->mapping;
-}
-
 extern pgoff_t __page_file_index(struct page *page);
 
 /*
@@ -1781,7 +1768,6 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
-struct address_space *page_mapping(struct page *page);
 
 /*
  * Return true only if the page has been allocated with
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 42a68d15db03..98becc81f069 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -162,14 +162,45 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 
 void release_pages(struct page **pages, int nr);
 
+struct address_space *page_mapping(struct page *);
+struct address_space *folio_mapping(struct folio *);
+struct address_space *swapcache_mapping(struct folio *);
+
+/**
+ * folio_file_mapping - Find the mapping this folio belongs to.
+ * @folio: The folio.
+ *
+ * For folios which are in the page cache, return the mapping that this
+ * page belongs to.  Folios in the swap cache return the mapping of the
+ * swap file or swap device where the data is stored.  This is different
+ * from the mapping returned by folio_mapping().  The only reason to
+ * use it is if, like NFS, you return 0 from ->activate_swapfile.
+ *
+ * Do not call this for folios which aren't in the page cache or swap cache.
+ */
+static inline struct address_space *folio_file_mapping(struct folio *folio)
+{
+	if (unlikely(folio_swapcache(folio)))
+		return swapcache_mapping(folio);
+
+	return folio->mapping;
+}
+
+static inline struct address_space *page_file_mapping(struct page *page)
+{
+	return folio_file_mapping(page_folio(page));
+}
+
 /*
  * For file cache pages, return the address_space, otherwise return NULL
  */
 static inline struct address_space *page_mapping_file(struct page *page)
 {
-	if (unlikely(PageSwapCache(page)))
+	struct folio *folio = page_folio(page);
+
+	if (unlikely(folio_swapcache(folio)))
 		return NULL;
-	return page_mapping(page);
+	return folio_mapping(folio);
 }
 
 static inline bool page_cache_add_speculative(struct page *page, int count)
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 144727041e78..20766342845b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -314,6 +314,12 @@ struct vma_swap_readahead {
 #endif
 };
 
+static inline swp_entry_t folio_swap_entry(struct folio *folio)
+{
+	swp_entry_t entry = { .val = page_private(&folio->page) };
+	return entry;
+}
+
 /* linux/mm/workingset.c */
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg);
diff --git a/mm/Makefile b/mm/Makefile
index bf71e295e9f6..0268ca5c8dbb 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -46,7 +46,7 @@ mmu-$(CONFIG_MMU)	+= process_vm_access.o
 endif
 
 obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
-			   maccess.o page-writeback.o \
+			   maccess.o page-writeback.o folio-compat.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
new file mode 100644
index 000000000000..5e107aa30a62
--- /dev/null
+++ b/mm/folio-compat.c
@@ -0,0 +1,13 @@
+/*
+ * Compatibility functions which bloat the callers too much to make inline.
+ * All of the callers of these functions should be converted to use folios
+ * eventually.
+ */
+
+#include <linux/pagemap.h>
+
+struct address_space *page_mapping(struct page *page)
+{
+	return folio_mapping(page_folio(page));
+}
+EXPORT_SYMBOL(page_mapping);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 149e77454e3c..d0ee24239a83 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3533,13 +3533,13 @@ struct swap_info_struct *page_swap_info(struct page *page)
 }
 
 /*
- * out-of-line __page_file_ methods to avoid include hell.
+ * out-of-line methods to avoid include hell.
  */
-struct address_space *__page_file_mapping(struct page *page)
+struct address_space *swapcache_mapping(struct folio *folio)
 {
-	return page_swap_info(page)->swap_file->f_mapping;
+	return page_swap_info(&folio->page)->swap_file->f_mapping;
 }
-EXPORT_SYMBOL_GPL(__page_file_mapping);
+EXPORT_SYMBOL_GPL(swapcache_mapping);
 
 pgoff_t __page_file_index(struct page *page)
 {
diff --git a/mm/util.c b/mm/util.c
index a8bf17f18a81..afd99591cb81 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,30 +686,36 @@ struct anon_vma *page_anon_vma(struct page *page)
 	return __page_rmapping(page);
 }
 
-struct address_space *page_mapping(struct page *page)
+/**
+ * folio_mapping - Find the mapping where this folio is stored.
+ * @folio: The folio.
+ *
+ * For folios which are in the page cache, return the mapping that this
+ * page belongs to.  Folios in the swap cache return the swap mapping
+ * this page is stored in (which is different from the mapping for the
+ * swap file or swap device where the data is stored).
+ *
+ * You can call this for folios which aren't in the swap cache or page
+ * cache and it will return NULL.
+ */
+struct address_space *folio_mapping(struct folio *folio)
 {
 	struct address_space *mapping;
 
-	page = compound_head(page);
-
 	/* This happens if someone calls flush_dcache_page on slab page */
-	if (unlikely(PageSlab(page)))
+	if (unlikely(folio_slab(folio)))
 		return NULL;
 
-	if (unlikely(PageSwapCache(page))) {
-		swp_entry_t entry;
-
-		entry.val = page_private(page);
-		return swap_address_space(entry);
-	}
+	if (unlikely(folio_swapcache(folio)))
+		return swap_address_space(folio_swap_entry(folio));
 
-	mapping = page->mapping;
+	mapping = folio->mapping;
 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
 		return NULL;
 
 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
 }
-EXPORT_SYMBOL(page_mapping);
+EXPORT_SYMBOL(folio_mapping);
 
 /* Slow path of page_mapcount() for compound pages */
 int __page_mapcount(struct page *page)
-- 
2.30.2

