Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1D32E0A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCEEWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEEWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:22:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6486C061574;
        Thu,  4 Mar 2021 20:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PJMDVzBGNFdjhf6t/3/5VE6jTBhydf1jdb3Lpx2OhtA=; b=JTROAvijqYfvnr+BFahul4HXq3
        EsnBBVkU4zMVXGycqIDB1bN6gcx+NFJcCRG2tFUqDOUIGo9JzySGOAvIfGwvHTS9P5BKRYfzrr8L7
        93QGCGwRvlxLquF2WmwTsXBdnWcA5523Bg0S242U4kX3YCiH53YETO/F5jlpu7dahaXjdO74twtDX
        vn92MZW+u0J0LAgZjM1yW176QThhrmWi3cTouEs+431OotR76T+VvF2ZWqC7pAZ5++zIArrqwIOVI
        M9YWGJVjbKB1eJPMqSIg52bnOnxolawt+NZqjIOsY+YCBKMvY4DaHa/PUfmlbijIR/WAYKnuKhUg4
        46nVAI2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI1y1-00A3fp-Al; Fri, 05 Mar 2021 04:21:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 10/25] mm/util: Add folio_mapping and folio_file_mapping
Date:   Fri,  5 Mar 2021 04:18:46 +0000
Message-Id: <20210305041901.2396498-11-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are the folio equivalent of page_mapping() and page_file_mapping().
Add an out-of-line page_mapping() wrapper around folio_mapping()
in order to prevent the page_folio() call from bloating every caller
of page_mapping().  Adjust page_file_mapping() and page_mapping_file()
to use folios internally.

This ends up saving 102 bytes of text overall.  folio_mapping() is
45 bytes shorter than page_mapping() was, but the compiler chooses to
inline folio_mapping() into page_mapping_file(), for a net increase of
69 bytes in the core.  This is made up for by a few bytes less in dozens
of nfs functions (which call page_file_mapping()).  The small amount of
difference appears to be a slight change in gcc's register allocation
decisions, which allow:

   48 8b 56 08         mov    0x8(%rsi),%rdx
   48 8d 42 ff         lea    -0x1(%rdx),%rax
   83 e2 01            and    $0x1,%edx
   48 0f 44 c6         cmove  %rsi,%rax

to become:

   48 8b 46 08         mov    0x8(%rsi),%rax
   48 8d 78 ff         lea    -0x1(%rax),%rdi
   a8 01               test   $0x1,%al
   48 0f 44 fe         cmove  %rsi,%rdi

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      | 14 --------------
 include/linux/pagemap.h | 17 +++++++++++++++++
 mm/Makefile             |  2 +-
 mm/folio-compat.c       | 13 +++++++++++++
 mm/swapfile.c           |  6 +++---
 mm/util.c               | 20 ++++++++++----------
 6 files changed, 44 insertions(+), 28 deletions(-)
 create mode 100644 mm/folio-compat.c

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4595955805f8..9199b59ee8da 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1603,19 +1603,6 @@ void page_address_init(void);
 
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
@@ -1630,7 +1617,6 @@ static inline pgoff_t page_index(struct page *page)
 }
 
 bool page_mapped(struct page *page);
-struct address_space *page_mapping(struct page *page);
 struct address_space *page_mapping_file(struct page *page);
 
 /*
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5094b50f7680..5a2c0764d7c0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -157,6 +157,23 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 
 void release_pages(struct page **pages, int nr);
 
+struct address_space *page_mapping(struct page *);
+struct address_space *folio_mapping(struct folio *);
+struct address_space *__folio_file_mapping(struct folio *);
+
+static inline struct address_space *folio_file_mapping(struct folio *folio)
+{
+	if (unlikely(FolioSwapCache(folio)))
+		return __folio_file_mapping(folio);
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
  * speculatively take a reference to a page.
  * If the page is free (_refcount == 0), then _refcount is untouched, and 0
diff --git a/mm/Makefile b/mm/Makefile
index 72227b24a616..ceb0089efd29 100644
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
index 084a5b9a18e5..b80af7537d9e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3535,11 +3535,11 @@ struct swap_info_struct *page_swap_info(struct page *page)
 /*
  * out-of-line __page_file_ methods to avoid include hell.
  */
-struct address_space *__page_file_mapping(struct page *page)
+struct address_space *__folio_file_mapping(struct folio *folio)
 {
-	return page_swap_info(page)->swap_file->f_mapping;
+	return page_swap_info(&folio->page)->swap_file->f_mapping;
 }
-EXPORT_SYMBOL_GPL(__page_file_mapping);
+EXPORT_SYMBOL_GPL(__folio_file_mapping);
 
 pgoff_t __page_file_index(struct page *page)
 {
diff --git a/mm/util.c b/mm/util.c
index 54870226cea6..9ab72cfa4aa1 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -686,39 +686,39 @@ struct anon_vma *page_anon_vma(struct page *page)
 	return __page_rmapping(page);
 }
 
-struct address_space *page_mapping(struct page *page)
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
+	if (unlikely(FolioSwapCache(folio))) {
 		swp_entry_t entry;
 
-		entry.val = page_private(page);
+		entry.val = folio_private(folio);
 		return swap_address_space(entry);
 	}
 
-	mapping = page->mapping;
+	mapping = folio->page.mapping;
 	if ((unsigned long)mapping & PAGE_MAPPING_ANON)
 		return NULL;
 
 	return (void *)((unsigned long)mapping & ~PAGE_MAPPING_FLAGS);
 }
-EXPORT_SYMBOL(page_mapping);
+EXPORT_SYMBOL(folio_mapping);
 
 /*
  * For file cache pages, return the address_space, otherwise return NULL
  */
 struct address_space *page_mapping_file(struct page *page)
 {
-	if (unlikely(PageSwapCache(page)))
+	struct folio *folio = page_folio(page);
+
+	if (unlikely(FolioSwapCache(folio)))
 		return NULL;
-	return page_mapping(page);
+	return folio_mapping(folio);
 }
 
 /* Slow path of page_mapcount() for compound pages */
-- 
2.30.0

