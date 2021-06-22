Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DC43B033A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhFVLwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFVLwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:52:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DD5C061756;
        Tue, 22 Jun 2021 04:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+FkUfWQyyMVMvhh6fObefiME8esW5i3w7bwxnYHqe1I=; b=QYrn/79+nnHbwYmEAGfqUqeQs2
        tjeyvBQJIVmUxSfMdfCEiJDteeQoRfLGq8tjSRQCOkOplPj9TIrhJpbjJW3wnfvbWZX3OkuaBpUVG
        Nj3CHzg3wxZQyVOAX0+rV+49bRVhvWAcO7Xz8SbKeiqH0zXGCkKsVAW4FQ6P/Z5EHaR/jAmArLq1C
        fMhO4MYSalj8w8h7JgeG5GBj3KCSoe4n0epcI20TucEunG1sbw1cYyPNxq51PoUMwV1PUipY3mc7E
        3vDYEmFCbvL39owCoTYVC0rqhNtkevpR4g1etk2bKT6bzJOb/pZOhDoows0aDXkqrGX6E12QwW6Da
        UxZXCcMg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvesZ-00EDsO-5z; Tue, 22 Jun 2021 11:47:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 09/33] mm: Add folio_try_get_rcu()
Date:   Tue, 22 Jun 2021 12:40:54 +0100
Message-Id: <20210622114118.3388190-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the equivalent of page_cache_get_speculative().  Also add
folio_ref_try_add_rcu (the equivalent of page_cache_add_speculative)
and folio_get_unless_zero() (the equivalent of get_page_unless_zero()).

The new kernel-doc attempts to explain from the user's point of view
when to use folio_try_get_rcu() and when to use folio_get_unless_zero(),
because there seems to be some confusion currently between the users of
page_cache_get_speculative() and get_page_unless_zero().

Reimplement page_cache_add_speculative() and page_cache_get_speculative()
as wrappers around the folio equivalents, but leave get_page_unless_zero()
alone for now.  This commit reduces text size by 3 bytes due to slightly
different register allocation & instruction selections.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/page_ref.h | 66 +++++++++++++++++++++++++++++++
 include/linux/pagemap.h  | 84 ++--------------------------------------
 mm/filemap.c             | 20 ++++++++++
 3 files changed, 90 insertions(+), 80 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 717d53c9ddf1..2e677e6ad09f 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -247,6 +247,72 @@ static inline bool folio_ref_add_unless(struct folio *folio, int nr, int u)
 	return page_ref_add_unless(&folio->page, nr, u);
 }
 
+/**
+ * folio_try_get - Attempt to increase the refcount on a folio.
+ * @folio: The folio.
+ *
+ * If you do not already have a reference to a folio, you can attempt to
+ * get one using this function.  It may fail if, for example, the folio
+ * has been freed since you found a pointer to it, or it is frozen for
+ * the purposes of splitting or migration.
+ *
+ * Return: True if the reference count was successfully incremented.
+ */
+static inline bool folio_try_get(struct folio *folio)
+{
+	return folio_ref_add_unless(folio, 1, 0);
+}
+
+static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
+{
+#ifdef CONFIG_TINY_RCU
+	/*
+	 * The caller guarantees the folio will not be freed from interrupt
+	 * context, so (on !SMP) we only need preemption to be disabled
+	 * and TINY_RCU does that for us.
+	 */
+# ifdef CONFIG_PREEMPT_COUNT
+	VM_BUG_ON(!in_atomic() && !irqs_disabled());
+# endif
+	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
+	folio_ref_add(folio, count);
+#else
+	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
+		/* Either the folio has been freed, or will be freed. */
+		return false;
+	}
+#endif
+	return true;
+}
+
+/**
+ * folio_try_get_rcu - Attempt to increase the refcount on a folio.
+ * @folio: The folio.
+ *
+ * This is a version of folio_try_get() optimised for non-SMP kernels.
+ * If you are still holding the rcu_read_lock() after looking up the
+ * page and know that the page cannot have its refcount decreased to
+ * zero in interrupt context, you can use this instead of folio_try_get().
+ *
+ * Example users include get_user_pages_fast() (as pages are not unmapped
+ * from interrupt context) and the page cache lookups (as pages are not
+ * truncated from interrupt context).  We also know that pages are not
+ * frozen in interrupt context for the purposes of splitting or migration.
+ *
+ * You can also use this function if you're holding a lock that prevents
+ * pages being frozen & removed; eg the i_pages lock for the page cache
+ * or the mmap_sem or page table lock for page tables.  In this case,
+ * it will always succeed, and you could have used a plain folio_get(),
+ * but it's sometimes more convenient to have a common function called
+ * from both locked and RCU-protected contexts.
+ *
+ * Return: True if the reference count was successfully incremented.
+ */
+static inline bool folio_try_get_rcu(struct folio *folio)
+{
+	return folio_ref_try_add_rcu(folio, 1);
+}
+
 static inline int page_ref_freeze(struct page *page, int count)
 {
 	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cc45d734f427..0a90c4821a54 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -172,91 +172,15 @@ static inline struct address_space *page_mapping_file(struct page *page)
 	return page_mapping(page);
 }
 
-/*
- * speculatively take a reference to a page.
- * If the page is free (_refcount == 0), then _refcount is untouched, and 0
- * is returned. Otherwise, _refcount is incremented by 1 and 1 is returned.
- *
- * This function must be called inside the same rcu_read_lock() section as has
- * been used to lookup the page in the pagecache radix-tree (or page table):
- * this allows allocators to use a synchronize_rcu() to stabilize _refcount.
- *
- * Unless an RCU grace period has passed, the count of all pages coming out
- * of the allocator must be considered unstable. page_count may return higher
- * than expected, and put_page must be able to do the right thing when the
- * page has been finished with, no matter what it is subsequently allocated
- * for (because put_page is what is used here to drop an invalid speculative
- * reference).
- *
- * This is the interesting part of the lockless pagecache (and lockless
- * get_user_pages) locking protocol, where the lookup-side (eg. find_get_page)
- * has the following pattern:
- * 1. find page in radix tree
- * 2. conditionally increment refcount
- * 3. check the page is still in pagecache (if no, goto 1)
- *
- * Remove-side that cares about stability of _refcount (eg. reclaim) has the
- * following (with the i_pages lock held):
- * A. atomically check refcount is correct and set it to 0 (atomic_cmpxchg)
- * B. remove page from pagecache
- * C. free the page
- *
- * There are 2 critical interleavings that matter:
- * - 2 runs before A: in this case, A sees elevated refcount and bails out
- * - A runs before 2: in this case, 2 sees zero refcount and retries;
- *   subsequently, B will complete and 1 will find no page, causing the
- *   lookup to return NULL.
- *
- * It is possible that between 1 and 2, the page is removed then the exact same
- * page is inserted into the same position in pagecache. That's OK: the
- * old find_get_page using a lock could equally have run before or after
- * such a re-insertion, depending on order that locks are granted.
- *
- * Lookups racing against pagecache insertion isn't a big problem: either 1
- * will find the page or it will not. Likewise, the old find_get_page could run
- * either before the insertion or afterwards, depending on timing.
- */
-static inline int __page_cache_add_speculative(struct page *page, int count)
+static inline bool page_cache_add_speculative(struct page *page, int count)
 {
-#ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
-	/*
-	 * Preempt must be disabled here - we rely on rcu_read_lock doing
-	 * this for us.
-	 *
-	 * Pagecache won't be truncated from interrupt context, so if we have
-	 * found a page in the radix tree here, we have pinned its refcount by
-	 * disabling preempt, and hence no need for the "speculative get" that
-	 * SMP requires.
-	 */
-	VM_BUG_ON_PAGE(page_count(page) == 0, page);
-	page_ref_add(page, count);
-
-#else
-	if (unlikely(!page_ref_add_unless(page, count, 0))) {
-		/*
-		 * Either the page has been freed, or will be freed.
-		 * In either case, retry here and the caller should
-		 * do the right thing (see comments above).
-		 */
-		return 0;
-	}
-#endif
 	VM_BUG_ON_PAGE(PageTail(page), page);
-
-	return 1;
-}
-
-static inline int page_cache_get_speculative(struct page *page)
-{
-	return __page_cache_add_speculative(page, 1);
+	return folio_ref_try_add_rcu((struct folio *)page, count);
 }
 
-static inline int page_cache_add_speculative(struct page *page, int count)
+static inline bool page_cache_get_speculative(struct page *page)
 {
-	return __page_cache_add_speculative(page, count);
+	return page_cache_add_speculative(page, 1);
 }
 
 /**
diff --git a/mm/filemap.c b/mm/filemap.c
index 66f7e9fdfbc4..817a47059bd0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1746,6 +1746,26 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 
+/*
+ * Lockless page cache protocol:
+ * On the lookup side:
+ * 1. Load the folio from i_pages
+ * 2. Increment the refcount if it's not zero
+ * 3. If the folio is not found by xas_reload(), put the refcount and retry
+ *
+ * On the removal side:
+ * A. Freeze the page (by zeroing the refcount if nobody else has a reference)
+ * B. Remove the page from i_pages
+ * C. Return the page to the page allocator
+ *
+ * This means that any page may have its reference count temporarily
+ * increased by a speculative page cache (or fast GUP) lookup as it can
+ * be allocated by another user before the RCU grace period expires.
+ * Because the refcount temporarily acquired here may end up being the
+ * last refcount on the page, any page allocation must be freeable by
+ * put_folio().
+ */
+
 /*
  * mapping_get_entry - Get a page cache entry.
  * @mapping: the address_space to search
-- 
2.30.2

