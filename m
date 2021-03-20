Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69D8342B0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 06:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCTFnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCTFm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 01:42:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A9C061762;
        Fri, 19 Mar 2021 22:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TogcGtiunGQHXTWVGfbYtEEeOKlg2CcfwBbKvI/9Sic=; b=TwajhSYg65zC2pd2McZvStKm+s
        eyhJqJEbPH4ESxUnlr2gr41CHw5au0E03GShLLhP+UAmCT7dOPN2EOiqj/9zGdTuMAGrAOOxROYFV
        zwX3HXWbfflS8XC4A/QAhcl15ZPNCRcA6k6Ja0FrlB37qbiPEpgLA81AKlzNHc7hVC9fSBOFg0H3J
        UADdccQYE9elg3BhahAhx9UOF0bCy7HoGvjr0U5Kjx+UsAd6hN3Vd3HpNH664QLhQ2N5+1Un+vR7v
        BuQ/fbfUdLo5G40VZsHjv+Buf4BEMr7rh06ogntOG+zLK047XTD5wblabyhl3rdw3032DXY0VV//z
        ofKautGg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNUNf-005SZ2-7z; Sat, 20 Mar 2021 05:42:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v5 13/27] mm/util: Add folio_mapping and folio_file_mapping
Date:   Sat, 20 Mar 2021 05:40:50 +0000
Message-Id: <20210320054104.1300774-14-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210320054104.1300774-1-willy@infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
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

This ends up saving 186 bytes of text overall.  folio_mapping() is
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      | 14 --------------
 include/linux/pagemap.h | 35 +++++++++++++++++++++++++++++++++--
 include/linux/swap.h    |  6 ++++++
 mm/Makefile             |  2 +-
 mm/folio-compat.c       | 13 +++++++++++++
 mm/swapfile.c           |  8 ++++----
 mm/util.c               | 30 ++++++++++++++++++------------
 7 files changed, 75 insertions(+), 33 deletions(-)
 create mode 100644 mm/folio-compat.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8fc7b04a1438..bc626c19f9f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1732,19 +1732,6 @@ void page_address_init(void);
 
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
@@ -1759,7 +1746,6 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
-struct address_space *page_mapping(struct page *page);
 
 /*
  * Return true only if the page has been allocated with
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f29c96ed3721..90e970f48039 100644
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
+	if (unlikely(FolioSwapCache(folio)))
+		return swapcache_mapping(folio);
+
+	return folio->page.mapping;
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
+	if (unlikely(FolioSwapCache(folio)))
 		return NULL;
-	return page_mapping(page);
+	return folio_mapping(folio);
 }
 
 /*
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4c3a844ac9b4..09316a5c33e9 100644
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
index 788c5ce5c0ef..9d6a7e8b5a3c 100644
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
index 0b6dd9d81da7..c4ed5b919c7d 100644
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
+	if (unlikely(FolioSlab(folio)))
 		return NULL;
 
-	if (unlikely(PageSwapCache(page))) {
-		swp_entry_t entry;
-
-		entry.val = page_private(page);
-		return swap_address_space(entry);
-	}
+	if (unlikely(FolioSwapCache(folio)))
+		return swap_address_space(folio_swap_entry(folio));
 
-	mapping = page->mapping;
+	mapping = folio->page.mapping;
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

