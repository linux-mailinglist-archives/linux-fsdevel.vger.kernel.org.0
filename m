Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D18BD5E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411259AbfIYAwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404204AbfIYAwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0lJN/0sM0LXHeuSCNK/VyRj6hx2s9f2LfDmenH+FoVc=; b=Lkn3NuqIyAirOrFb1og7lnpDKD
        1C4EQL9P7Um54NNjITxEbJxxHma2imx4dglv7/9NfZ/Iorpdu9NczTtVPc6w+cgFu94qryssi3zI2
        dw5WRFPoq/+M0aV4JmiYi6ltKgI9izTyR7qF2hOScD4x5vPGaoI8G+r4c4lAEFkqDGITEm3DZY+8j
        IvjywdVjiiuoIhs+odCb67vKhZgVhvItF0FsvrR4zKN6m5bWkoKc/M4iBrvShbLNvlMdrF6C/sWys
        StvA7qAZFkgW21pirNSms0aUO7suhb8qsqcEHAIq5tbO7KVkWXDsXkJOzqmH3yXCvH0Ng1mevtv3W
        zGLAJK8w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00077J-RN; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 13/15] mm: Add a huge page fault handler for files
Date:   Tue, 24 Sep 2019 17:52:12 -0700
Message-Id: <20190925005214.27240-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: William Kucharski <william.kucharski@oracle.com>

Add filemap_huge_fault() to attempt to satisfy page
faults on memory-mapped read-only text pages using THP when possible.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
[rebased on top of mm prep patches -- Matthew]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  10 +++
 include/linux/pagemap.h |   8 ++
 mm/filemap.c            | 165 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 178 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 04bea9f9282c..623878f11eaf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2414,6 +2414,16 @@ extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
 extern vm_fault_t filemap_fault(struct vm_fault *vmf);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
+		enum page_entry_size pe_size);
+#else
+static inline vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
+		enum page_entry_size pe_size)
+{
+	return VM_FAULT_FALLBACK;
+}
+#endif
 extern void filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d6d97f9fb762..ae09788f5345 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -354,6 +354,14 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
 			mapping_gfp_mask(mapping));
 }
 
+/* This (head) page should be found at this offset in the page cache */
+static inline void page_cache_assert(struct page *page, pgoff_t offset)
+{
+	VM_BUG_ON_PAGE(PageTail(page), page);
+	VM_BUG_ON_PAGE(page->index == (offset & ~(compound_nr(page) - 1)),
+			page);
+}
+
 static inline struct page *find_subpage(struct page *page, pgoff_t offset)
 {
 	if (PageHuge(page))
diff --git a/mm/filemap.c b/mm/filemap.c
index b07ef9469861..8017e905df7a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1590,7 +1590,8 @@ static bool pagecache_is_conflict(struct page *page)
  *
  * Looks up the page cache entries at @mapping between @offset and
  * @offset + 2^@order.  If there is a page cache page, it is returned with
- * an increased refcount unless it is smaller than @order.
+ * an increased refcount unless it is smaller than @order.  This function
+ * returns the head page, not a tail page.
  *
  * If the slot holds a shadow entry of a previously evicted page, or a
  * swap entry from shmem/tmpfs, it is returned.
@@ -1601,7 +1602,7 @@ static bool pagecache_is_conflict(struct page *page)
 static struct page *__find_get_page(struct address_space *mapping,
 		unsigned long offset, unsigned int order)
 {
-	XA_STATE(xas, &mapping->i_pages, offset);
+	XA_STATE(xas, &mapping->i_pages, offset & ~((1UL << order) - 1));
 	struct page *page;
 
 	rcu_read_lock();
@@ -1635,7 +1636,6 @@ static struct page *__find_get_page(struct address_space *mapping,
 		put_page(page);
 		goto repeat;
 	}
-	page = find_subpage(page, offset);
 out:
 	rcu_read_unlock();
 
@@ -1741,11 +1741,12 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 			put_page(page);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(page->index != offset, page);
+		page_cache_assert(page, offset);
 	}
 
 	if (fgp_flags & FGP_ACCESSED)
 		mark_page_accessed(page);
+	page = find_subpage(page, offset);
 
 no_page:
 	if (!page && (fgp_flags & FGP_CREAT)) {
@@ -2638,7 +2639,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		put_page(page);
 		goto retry_find;
 	}
-	VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
+	page_cache_assert(page, offset);
 
 	/*
 	 * We have a locked page in the page cache, now we need to check
@@ -2711,6 +2712,160 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/**
+ * filemap_huge_fault - Read in file data for page fault handling.
+ * @vmf: struct vm_fault containing details of the fault.
+ * @pe_size: Page entry size.
+ *
+ * filemap_huge_fault() is invoked via the vma operations vector for a
+ * mapped memory region to read in file data during a page fault.
+ *
+ * The goto's are kind of ugly, but this streamlines the normal case of having
+ * it in the page cache, and handles the special cases reasonably without
+ * having a lot of duplicated code.
+ *
+ * vma->vm_mm->mmap_sem must be held on entry.
+ *
+ * If our return value has VM_FAULT_RETRY set, it's because the mmap_sem
+ * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
+ *
+ * If our return value does not have VM_FAULT_RETRY set, the mmap_sem
+ * has not been released.
+ *
+ * We never return with VM_FAULT_RETRY and a bit from VM_FAULT_ERROR set.
+ *
+ * Return: bitwise-OR of %VM_FAULT_ codes.
+ */
+vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
+				enum page_entry_size pe_size)
+{
+	int error;
+	struct vm_area_struct *vma = vmf->vma;
+	struct file *file = vma->vm_file;
+	struct file *fpin = NULL;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	pgoff_t offset = vmf->pgoff;
+	pgoff_t max_off;
+	struct page *page;
+	vm_fault_t ret = 0;
+
+	if (pe_size != PE_SIZE_PMD)
+		return VM_FAULT_FALLBACK;
+	/* Read-only mappings for now */
+	if (vmf->flags & FAULT_FLAG_WRITE)
+		return VM_FAULT_FALLBACK;
+	if (vma->vm_start & ~HPAGE_PMD_MASK)
+		return VM_FAULT_FALLBACK;
+	/* Don't allocate a huge page for the tail of the file (?) */
+	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely((offset | (HPAGE_PMD_NR - 1)) >= max_off))
+		return VM_FAULT_FALLBACK;
+
+	/*
+	 * Do we have something in the page cache already?
+	 */
+	page = __find_get_page(mapping, offset, HPAGE_PMD_ORDER);
+	if (likely(page)) {
+		if (pagecache_is_conflict(page))
+			return VM_FAULT_FALLBACK;
+		/* Readahead the next huge page here? */
+		page = find_subpage(page, offset & ~(HPAGE_PMD_NR - 1));
+	} else {
+		/* No page in the page cache at all */
+		count_vm_event(PGMAJFAULT);
+		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
+		ret = VM_FAULT_MAJOR;
+retry_find:
+		page = pagecache_get_page(mapping, offset,
+					  FGP_CREAT | FGP_FOR_MMAP | FGP_PMD,
+					  vmf->gfp_mask |
+						__GFP_NOWARN | __GFP_NORETRY);
+		if (!page)
+			return VM_FAULT_FALLBACK;
+	}
+
+	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
+		goto out_retry;
+
+	/* Did it get truncated? */
+	if (unlikely(page->mapping != mapping)) {
+		unlock_page(page);
+		put_page(page);
+		goto retry_find;
+	}
+	VM_BUG_ON_PAGE(page_to_index(page) != offset, page);
+
+	/*
+	 * We have a locked page in the page cache, now we need to check
+	 * that it's up-to-date.  Because we don't readahead in huge_fault,
+	 * this may or may not be due to an error.
+	 */
+	if (!PageUptodate(page))
+		goto page_not_uptodate;
+
+	/*
+	 * We've made it this far and we had to drop our mmap_sem, now is the
+	 * time to return to the upper layer and have it re-find the vma and
+	 * redo the fault.
+	 */
+	if (fpin) {
+		unlock_page(page);
+		goto out_retry;
+	}
+
+	/*
+	 * Found the page and have a reference on it.
+	 * We must recheck i_size under page lock.
+	 */
+	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(offset >= max_off)) {
+		unlock_page(page);
+		put_page(page);
+		return VM_FAULT_SIGBUS;
+	}
+
+	ret |= alloc_set_pte(vmf, NULL, page);
+	unlock_page(page);
+	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
+		put_page(page);
+	return ret;
+
+page_not_uptodate:
+	ClearPageError(page);
+	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+	error = mapping->a_ops->readpage(file, page);
+	if (!error) {
+		wait_on_page_locked(page);
+		if (!PageUptodate(page))
+			error = -EIO;
+	}
+	if (fpin)
+		goto out_retry;
+	put_page(page);
+
+	if (!error || error == AOP_TRUNCATED_PAGE)
+		goto retry_find;
+
+	/* Things didn't work out */
+	return VM_FAULT_SIGBUS;
+
+out_retry:
+	/*
+	 * We dropped the mmap_sem, we need to return to the fault handler to
+	 * re-find the vma and come back and find our hopefully still populated
+	 * page.
+	 */
+	if (page)
+		put_page(page);
+	if (fpin)
+		fput(fpin);
+	return ret | VM_FAULT_RETRY;
+}
+EXPORT_SYMBOL(filemap_huge_fault);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 void filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
-- 
2.23.0

