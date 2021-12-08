Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAC46CC7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbhLHE25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3464C0698CF
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oP34gRnxYnpVikw5uBW13SizoUTUkR9UbaCi/Ytt8fE=; b=N+pqVt0IZ4UHZiUWl3CkDM93hw
        u5Q9Lvmk1GBLboQnh/yxZ5BtO38i98Eg11PDRhOyb+wEAVUbyB9sREQCKHFaM7tuXP/o1wR18GvBn
        fDr5b2V+tETvZj+ZSlHnBGS6irXnUiAhfDo9gA7K05UNKoVwG22XMn1ThcAPInCvFsnC36PIwYOLU
        WVZ3gd51j7lRQVENu0wEPd7QVeTuLKgIsFznCD9QWZqOouBfG4SI83dRygt9jPU1WO9Bvws5OYAqf
        Wl4jXTPX7PCixZbIc9zZHdFogGFECHz/m9EfdTutmKg6QfAdQjS8S+yDEeBpTTanHv9mbhVuXzh04
        HO3CS6xQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU5-0084ab-U9; Wed, 08 Dec 2021 04:23:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 33/48] mm: Add unmap_mapping_folio()
Date:   Wed,  8 Dec 2021 04:22:41 +0000
Message-Id: <20211208042256.1923824-34-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert both callers of unmap_mapping_page() to call unmap_mapping_folio()
instead.  Also move zap_details from linux/mm.h to mm/internal.h

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 24 ------------------------
 mm/internal.h      | 25 ++++++++++++++++++++++++-
 mm/memory.c        | 27 +++++++++++++--------------
 mm/truncate.c      |  4 ++--
 4 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 145f045b0ddc..c9cdb26802fb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1825,28 +1825,6 @@ static inline bool can_do_mlock(void) { return false; }
 extern int user_shm_lock(size_t, struct ucounts *);
 extern void user_shm_unlock(size_t, struct ucounts *);
 
-/*
- * Parameter block passed down to zap_pte_range in exceptional cases.
- */
-struct zap_details {
-	struct address_space *zap_mapping;	/* Check page->mapping if set */
-	struct page *single_page;		/* Locked page to be unmapped */
-};
-
-/*
- * We set details->zap_mappings when we want to unmap shared but keep private
- * pages. Return true if skip zapping this page, false otherwise.
- */
-static inline bool
-zap_skip_check_mapping(struct zap_details *details, struct page *page)
-{
-	if (!details || !page)
-		return false;
-
-	return details->zap_mapping &&
-	    (details->zap_mapping != page_rmapping(page));
-}
-
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -1892,7 +1870,6 @@ extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 extern int fixup_user_fault(struct mm_struct *mm,
 			    unsigned long address, unsigned int fault_flags,
 			    bool *unlocked);
-void unmap_mapping_page(struct page *page);
 void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows);
 void unmap_mapping_range(struct address_space *mapping,
@@ -1913,7 +1890,6 @@ static inline int fixup_user_fault(struct mm_struct *mm, unsigned long address,
 	BUG();
 	return -EFAULT;
 }
-static inline void unmap_mapping_page(struct page *page) { }
 static inline void unmap_mapping_pages(struct address_space *mapping,
 		pgoff_t start, pgoff_t nr, bool even_cows) { }
 static inline void unmap_mapping_range(struct address_space *mapping,
diff --git a/mm/internal.h b/mm/internal.h
index 3b79a5c9427a..3f359f4830da 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -74,6 +74,28 @@ static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
 }
 
+/*
+ * Parameter block passed down to zap_pte_range in exceptional cases.
+ */
+struct zap_details {
+	struct address_space *zap_mapping;	/* Check page->mapping if set */
+	struct folio *single_folio;	/* Locked folio to be unmapped */
+};
+
+/*
+ * We set details->zap_mappings when we want to unmap shared but keep private
+ * pages. Return true if skip zapping this page, false otherwise.
+ */
+static inline bool
+zap_skip_check_mapping(struct zap_details *details, struct page *page)
+{
+	if (!details || !page)
+		return false;
+
+	return details->zap_mapping &&
+	    (details->zap_mapping != page_rmapping(page));
+}
+
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end,
@@ -388,6 +410,7 @@ void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 
 #ifdef CONFIG_MMU
+void unmap_mapping_folio(struct folio *folio);
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
 extern long faultin_vma_page_range(struct vm_area_struct *vma,
@@ -491,8 +514,8 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 	}
 	return fpin;
 }
-
 #else /* !CONFIG_MMU */
+static inline void unmap_mapping_folio(struct folio *folio) { }
 static inline void clear_page_mlock(struct page *page) { }
 static inline void mlock_vma_page(struct page *page) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
diff --git a/mm/memory.c b/mm/memory.c
index 8f1de811a1dc..a86027026f2a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1443,8 +1443,8 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			else if (zap_huge_pmd(tlb, vma, pmd, addr))
 				goto next;
 			/* fall through */
-		} else if (details && details->single_page &&
-			   PageTransCompound(details->single_page) &&
+		} else if (details && details->single_folio &&
+			   folio_test_pmd_mappable(details->single_folio) &&
 			   next - addr == HPAGE_PMD_SIZE && pmd_none(*pmd)) {
 			spinlock_t *ptl = pmd_lock(tlb->mm, pmd);
 			/*
@@ -3332,31 +3332,30 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 }
 
 /**
- * unmap_mapping_page() - Unmap single page from processes.
- * @page: The locked page to be unmapped.
+ * unmap_mapping_folio() - Unmap single folio from processes.
+ * @folio: The locked folio to be unmapped.
  *
- * Unmap this page from any userspace process which still has it mmaped.
+ * Unmap this folio from any userspace process which still has it mmaped.
  * Typically, for efficiency, the range of nearby pages has already been
  * unmapped by unmap_mapping_pages() or unmap_mapping_range().  But once
- * truncation or invalidation holds the lock on a page, it may find that
- * the page has been remapped again: and then uses unmap_mapping_page()
+ * truncation or invalidation holds the lock on a folio, it may find that
+ * the page has been remapped again: and then uses unmap_mapping_folio()
  * to unmap it finally.
  */
-void unmap_mapping_page(struct page *page)
+void unmap_mapping_folio(struct folio *folio)
 {
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	struct zap_details details = { };
 	pgoff_t	first_index;
 	pgoff_t	last_index;
 
-	VM_BUG_ON(!PageLocked(page));
-	VM_BUG_ON(PageTail(page));
+	VM_BUG_ON(!folio_test_locked(folio));
 
-	first_index = page->index;
-	last_index = page->index + thp_nr_pages(page) - 1;
+	first_index = folio->index;
+	last_index = folio->index + folio_nr_pages(folio) - 1;
 
 	details.zap_mapping = mapping;
-	details.single_page = page;
+	details.single_folio = folio;
 
 	i_mmap_lock_write(mapping);
 	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
diff --git a/mm/truncate.c b/mm/truncate.c
index ab86b07c1e9c..c98feea75a10 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -180,7 +180,7 @@ void do_invalidatepage(struct page *page, unsigned int offset,
 static void truncate_cleanup_folio(struct folio *folio)
 {
 	if (folio_mapped(folio))
-		unmap_mapping_page(&folio->page);
+		unmap_mapping_folio(folio);
 
 	if (folio_has_private(folio))
 		do_invalidatepage(&folio->page, 0, folio_size(folio));
@@ -670,7 +670,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 			wait_on_page_writeback(page);
 
 			if (page_mapped(page))
-				unmap_mapping_page(page);
+				unmap_mapping_folio(page_folio(page));
 			BUG_ON(page_mapped(page));
 
 			ret2 = do_launder_page(mapping, page);
-- 
2.33.0

