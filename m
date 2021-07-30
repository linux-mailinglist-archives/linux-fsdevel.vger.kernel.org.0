Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507ED3DC052
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhG3Vg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhG3Vg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 17:36:56 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287DEC06175F;
        Fri, 30 Jul 2021 14:36:51 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x3so10818265qkl.6;
        Fri, 30 Jul 2021 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTEoCnqEjGI0zpgZZPEn8lvTuTO5b+OavbyIb98WYF8=;
        b=dHVcy0IuH/eMXkoMAs4c+WElnZzjNpemi1u6DGBd/Bmyw40Lure1+D/9m9/wup1vab
         jVgNrPEh7RLDQC4RBn9Z37Ol2PH98NTezv7JH8VJb96hhWHOhx4V1Fy5P6+ZcDIUOptZ
         C1gmxIZc4rC2Rp6tkCsh8qse9Un3veM7BJ6PfCKrLgjRNl+TkgddnN0l2ihw1qOQLubJ
         ZPSPa2TW67GDe7HI/6Bv+RnUoUnRAF9yrVI3G86ZacKUH6VWWwoaZcfm3T5IoHm/e+rx
         sFjo5HR38pX7lPnraVl2Jv5cNx0EXWo4LkDldNAy1yS9r1Ps5ke1AP3yp83qvZionEAm
         G29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eTEoCnqEjGI0zpgZZPEn8lvTuTO5b+OavbyIb98WYF8=;
        b=dimoWtmFaqicgdbrbHwnQ9BwLKk7T4tr9fxnPSA+15DN3Wa/UI3Io2urC6/kYpQdVN
         a9Si3MgXvKZoCEpr5OIHYrN+SfUVI9TEXNcn8Gtar9o9gvXU7YvGKRmUXz3O+CSVe/Fe
         JsOsf0EtJQFafrj7c7u9rV4I5AiXpyxUeqYdlPguB3LxXImO13Fh2kbwi+/6+QzbB/ty
         Og3RBojyHZUODtmHZNwgMDDB2nTpOhVcFPU7LFuVTN1/+/WIgA9HywLcxj6lKk9KosBY
         hpxmDMxuwiuPBKfqG/LJgbuXx2DXPctbPDitkPP+JZXxfsXyO/B/vmjRPtEPk5mguMk+
         Onug==
X-Gm-Message-State: AOAM5301Bjzp/Z8Ldt8QRgnqjwMKXCcBozcom2toX358NbimmvEVGMIf
        eSngznVeJQsrJBrFQL4uMZQ=
X-Google-Smtp-Source: ABdhPJwfssLh5pTdPVXJwVx3OzAsml4h2+uXRElMeuZcmeklixlHxZWw5/DTwPYp6X5EVoU8BvQ5XA==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr4440302qkm.80.1627681010048;
        Fri, 30 Jul 2021 14:36:50 -0700 (PDT)
Received: from vismoola-instance-bm.osdevelopmeniad.oraclevcn.com ([209.17.40.40])
        by smtp.gmail.com with ESMTPSA id g4sm1476639qkk.104.2021.07.30.14.36.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jul 2021 14:36:49 -0700 (PDT)
From:   Vishal Moola <vishal.moola@gmail.com>
To:     vishal.moola@gmail.c, willy@infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vishal Moola <vishal.moola@gmail.com>
Subject: [RFC PATCH] Page Cache Allowing Hard Interrupts
Date:   Fri, 30 Jul 2021 21:36:30 +0000
Message-Id: <20210730213630.44891-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202ad
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, the page cache would disable ALL interrupts when making any
modifications. This forces the kernel to wait for the page cache to finish
its task(s) before the interrupts could be serviced. The page cache does
not necessarily need to disable hard interrupts only soft interrupts.

We can change the locks from _irq to _bh, so we only disable soft
interrupts and allow hard interrupts. This also means we do not need to
keep track of the flags for hard irq states. This should improve the kernel
interrupt latency as the kernel can handle hard interrupts as they come in
instead of waiting for the page cache to finish its tasks.

This patch is a non-exhaustive list of changes to locks relating to the page
cache. All of these changes yielded no issues with interrupt context locking
conflicts, and should contribute to a better interrupt latency.

Also to accomplish the above, additional functions were added to list_lru to
allow locking only soft irqs for the i_pages lock. Additionally, in
mm/workingset.c the lru lock was changed to be nested bh instead of nested irq.

Also fixed some bugs that arose going from hard to soft locks
This has only been tested on virtio block devices so far.

Signed-off-by: Vishal Moola <vishal.moola@gmail.com>
---
 arch/arm/include/asm/cacheflush.h    |  4 +-
 arch/csky/abiv1/inc/abi/cacheflush.h |  4 +-
 arch/nds32/include/asm/cacheflush.h  |  4 +-
 arch/nios2/include/asm/cacheflush.h  |  4 +-
 arch/parisc/include/asm/cacheflush.h |  4 +-
 fs/btrfs/extent_io.c                 |  4 +-
 fs/dax.c                             | 60 ++++++++++++++--------------
 fs/f2fs/data.c                       |  5 +--
 fs/fs-writeback.c                    |  4 +-
 fs/gfs2/glops.c                      |  4 +-
 fs/inode.c                           |  6 +--
 fs/nilfs2/btnode.c                   |  8 ++--
 fs/nilfs2/page.c                     | 14 +++----
 include/linux/backing-dev.h          |  4 +-
 include/linux/list_lru.h             | 17 ++++++++
 mm/filemap.c                         | 19 ++++-----
 mm/khugepaged.c                      | 28 ++++++-------
 mm/list_lru.c                        | 15 +++++++
 mm/memfd.c                           | 16 ++++----
 mm/migrate.c                         | 18 ++++-----
 mm/page-writeback.c                  | 23 +++++------
 mm/shmem.c                           | 12 +++---
 mm/swap_slots.c                      |  6 +--
 mm/swap_state.c                      | 14 +++----
 mm/truncate.c                        | 19 +++++----
 mm/vmscan.c                          |  9 ++---
 mm/workingset.c                      | 12 +++---
 27 files changed, 178 insertions(+), 159 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 2e24e765e6d3..1feab3ef87e5 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -315,8 +315,8 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 extern void flush_kernel_dcache_page(struct page *);
 
-#define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
-#define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock(mapping)		xa_lock_bh(&mapping->i_pages)
+#define flush_dcache_mmap_unlock(mapping)	xa_unlock_bh(&mapping->i_pages)
 
 /*
  * We don't appear to need to do anything here.  In fact, if we did, we'd
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index 6cab7afae962..bea1d1d8cb49 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -17,8 +17,8 @@ extern void flush_dcache_page(struct page *);
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 extern void flush_kernel_dcache_page(struct page *);
 
-#define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
-#define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock(mapping)		xa_lock_bh(&mapping->i_pages)
+#define flush_dcache_mmap_unlock(mapping)	xa_unlock_bh(&mapping->i_pages)
 
 static inline void flush_kernel_vmap_range(void *addr, int size)
 {
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 7d6824f7c0e8..38d1c23fca43 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -40,8 +40,8 @@ void flush_anon_page(struct vm_area_struct *vma,
 void flush_kernel_dcache_page(struct page *page);
 void flush_kernel_vmap_range(void *addr, int size);
 void invalidate_kernel_vmap_range(void *addr, int size);
-#define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
-#define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
+#define flush_dcache_mmap_lock(mapping)   xa_lock_bh(&(mapping)->i_pages)
+#define flush_dcache_mmap_unlock(mapping) xa_unlock_bh(&(mapping)->i_pages)
 
 #else
 void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
index 18eb9f69f806..816754cc0c4a 100644
--- a/arch/nios2/include/asm/cacheflush.h
+++ b/arch/nios2/include/asm/cacheflush.h
@@ -46,7 +46,7 @@ extern void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
 extern void flush_dcache_range(unsigned long start, unsigned long end);
 extern void invalidate_dcache_range(unsigned long start, unsigned long end);
 
-#define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
-#define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock(mapping)		xa_lock_bh(&mapping->i_pages)
+#define flush_dcache_mmap_unlock(mapping)	xa_unlock_bh(&mapping->i_pages)
 
 #endif /* _ASM_NIOS2_CACHEFLUSH_H */
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 99663fc1f997..ac74ca0dd6c3 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -55,8 +55,8 @@ void invalidate_kernel_vmap_range(void *vaddr, int size);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *page);
 
-#define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
-#define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
+#define flush_dcache_mmap_lock(mapping)		xa_lock_bh(&mapping->i_pages)
+#define flush_dcache_mmap_unlock(mapping)	xa_unlock_bh(&mapping->i_pages)
 
 #define flush_icache_page(vma,page)	do { 		\
 	flush_kernel_dcache_page(page);			\
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9e81d25dea70..add1c04ed784 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6209,11 +6209,11 @@ static void btree_clear_page_dirty(struct page *page)
 	ASSERT(PageDirty(page));
 	ASSERT(PageLocked(page));
 	clear_page_dirty_for_io(page);
-	xa_lock_irq(&page->mapping->i_pages);
+	xa_lock_bh(&page->mapping->i_pages);
 	if (!PageDirty(page))
 		__xa_clear_mark(&page->mapping->i_pages,
 				page_index(page), PAGECACHE_TAG_DIRTY);
-	xa_unlock_irq(&page->mapping->i_pages);
+	xa_unlock_bh(&page->mapping->i_pages);
 }
 
 static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
diff --git a/fs/dax.c b/fs/dax.c
index da41f9363568..9fcb5a0caa20 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -241,11 +241,11 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
 		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
 		prepare_to_wait_exclusive(wq, &ewait.wait,
 					  TASK_UNINTERRUPTIBLE);
-		xas_unlock_irq(xas);
+		xas_unlock_bh(xas);
 		xas_reset(xas);
 		schedule();
 		finish_wait(wq, &ewait.wait);
-		xas_lock_irq(xas);
+		xas_lock_bh(xas);
 	}
 }
 
@@ -270,7 +270,7 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
 	 * never successfully performs its own wake up.
 	 */
 	prepare_to_wait(wq, &ewait.wait, TASK_UNINTERRUPTIBLE);
-	xas_unlock_irq(xas);
+	xas_unlock_bh(xas);
 	schedule();
 	finish_wait(wq, &ewait.wait);
 }
@@ -293,9 +293,9 @@ static void dax_unlock_entry(struct xa_state *xas, void *entry)
 
 	BUG_ON(dax_is_locked(entry));
 	xas_reset(xas);
-	xas_lock_irq(xas);
+	xas_lock_bh(xas);
 	old = xas_store(xas, entry);
-	xas_unlock_irq(xas);
+	xas_unlock_bh(xas);
 	BUG_ON(!dax_is_locked(old));
 	dax_wake_entry(xas, entry, WAKE_NEXT);
 }
@@ -423,9 +423,9 @@ dax_entry_t dax_lock_page(struct page *page)
 			break;
 
 		xas.xa = &mapping->i_pages;
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		if (mapping != page->mapping) {
-			xas_unlock_irq(&xas);
+			xas_unlock_bh(&xas);
 			continue;
 		}
 		xas_set(&xas, page->index);
@@ -437,7 +437,7 @@ dax_entry_t dax_lock_page(struct page *page)
 			continue;
 		}
 		dax_lock_entry(&xas, entry);
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		break;
 	}
 	rcu_read_unlock();
@@ -493,7 +493,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 retry:
 	pmd_downgrade = false;
-	xas_lock_irq(xas);
+	xas_lock_bh(xas);
 	entry = get_unlocked_entry(xas, order);
 
 	if (entry) {
@@ -526,12 +526,12 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		 * unmapped.
 		 */
 		if (dax_is_zero_entry(entry)) {
-			xas_unlock_irq(xas);
+			xas_unlock_bh(xas);
 			unmap_mapping_pages(mapping,
 					xas->xa_index & ~PG_PMD_COLOUR,
 					PG_PMD_NR, false);
 			xas_reset(xas);
-			xas_lock_irq(xas);
+			xas_lock_bh(xas);
 		}
 
 		dax_disassociate_entry(entry, mapping, false);
@@ -557,7 +557,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 	}
 
 out_unlock:
-	xas_unlock_irq(xas);
+	xas_unlock_bh(xas);
 	if (xas_nomem(xas, mapping_gfp_mask(mapping) & ~__GFP_HIGHMEM))
 		goto retry;
 	if (xas->xa_node == XA_ERROR(-ENOMEM))
@@ -566,7 +566,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		return xa_mk_internal(VM_FAULT_SIGBUS);
 	return entry;
 fallback:
-	xas_unlock_irq(xas);
+	xas_unlock_bh(xas);
 	return xa_mk_internal(VM_FAULT_FALLBACK);
 }
 
@@ -626,7 +626,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	 */
 	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1, 0);
 
-	xas_lock_irq(&xas);
+	xas_lock_bh(&xas);
 	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
@@ -641,11 +641,11 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 			continue;
 
 		xas_pause(&xas);
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		cond_resched();
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 	}
-	xas_unlock_irq(&xas);
+	xas_unlock_bh(&xas);
 	return page;
 }
 EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
@@ -663,7 +663,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	int ret = 0;
 	void *entry;
 
-	xas_lock_irq(&xas);
+	xas_lock_bh(&xas);
 	entry = get_unlocked_entry(&xas, 0);
 	if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
 		goto out;
@@ -677,7 +677,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	ret = 1;
 out:
 	put_unlocked_entry(&xas, entry, WAKE_ALL);
-	xas_unlock_irq(&xas);
+	xas_unlock_bh(&xas);
 	return ret;
 }
 
@@ -761,7 +761,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 	}
 
 	xas_reset(xas);
-	xas_lock_irq(xas);
+	xas_lock_bh(xas);
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
@@ -786,7 +786,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
-	xas_unlock_irq(xas);
+	xas_unlock_bh(xas);
 	return entry;
 }
 
@@ -924,7 +924,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	 * they will see the entry locked and wait for it to unlock.
 	 */
 	xas_clear_mark(xas, PAGECACHE_TAG_TOWRITE);
-	xas_unlock_irq(xas);
+	xas_unlock_bh(xas);
 
 	/*
 	 * If dax_writeback_mapping_range() was given a wbc->range_start
@@ -946,7 +946,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	 * entry lock.
 	 */
 	xas_reset(xas);
-	xas_lock_irq(xas);
+	xas_lock_bh(xas);
 	xas_store(xas, entry);
 	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
 	dax_wake_entry(xas, entry, WAKE_NEXT);
@@ -984,7 +984,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 
 	tag_pages_for_writeback(mapping, xas.xa_index, end_index);
 
-	xas_lock_irq(&xas);
+	xas_lock_bh(&xas);
 	xas_for_each_marked(&xas, entry, end_index, PAGECACHE_TAG_TOWRITE) {
 		ret = dax_writeback_one(&xas, dax_dev, mapping, entry);
 		if (ret < 0) {
@@ -995,11 +995,11 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 			continue;
 
 		xas_pause(&xas);
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		cond_resched();
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 	}
-	xas_unlock_irq(&xas);
+	xas_unlock_bh(&xas);
 	trace_dax_writeback_range_done(inode, xas.xa_index, end_index);
 	return ret;
 }
@@ -1691,20 +1691,20 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 	void *entry;
 	vm_fault_t ret;
 
-	xas_lock_irq(&xas);
+	xas_lock_bh(&xas);
 	entry = get_unlocked_entry(&xas, order);
 	/* Did we race with someone splitting entry or so? */
 	if (!entry || dax_is_conflict(entry) ||
 	    (order == 0 && !dax_is_pte_entry(entry))) {
 		put_unlocked_entry(&xas, entry, WAKE_NEXT);
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
 						      VM_FAULT_NOPAGE);
 		return VM_FAULT_NOPAGE;
 	}
 	xas_set_mark(&xas, PAGECACHE_TAG_DIRTY);
 	dax_lock_entry(&xas, entry);
-	xas_unlock_irq(&xas);
+	xas_unlock_bh(&xas);
 	if (order == 0)
 		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
 #ifdef CONFIG_FS_DAX_PMD
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d2cf48c5a2e4..b1d6a43d4b1c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4083,12 +4083,11 @@ const struct address_space_operations f2fs_dblock_aops = {
 void f2fs_clear_page_cache_dirty_tag(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_bh(&mapping->i_pages);
 	__xa_clear_mark(&mapping->i_pages, page_index(page),
 						PAGECACHE_TAG_DIRTY);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_bh(&mapping->i_pages);
 }
 
 int __init f2fs_init_post_read_processing(void)
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 06d04a74ab6c..d1ad69bb5296 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -376,7 +376,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	bool switched = false;
 
 	spin_lock(&inode->i_lock);
-	xa_lock_irq(&mapping->i_pages);
+	xa_lock_bh(&mapping->i_pages);
 
 	/*
 	 * Once I_FREEING or I_WILL_FREE are visible under i_lock, the eviction
@@ -447,7 +447,7 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	 */
 	smp_store_release(&inode->i_state, inode->i_state & ~I_WB_SWITCH);
 
-	xa_unlock_irq(&mapping->i_pages);
+	xa_unlock_bh(&mapping->i_pages);
 	spin_unlock(&inode->i_lock);
 
 	return switched;
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 54d3fbeb3002..19d93d6ad67e 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -537,9 +537,9 @@ static void inode_go_dump(struct seq_file *seq, struct gfs2_glock *gl,
 	if (ip == NULL)
 		return;
 
-	xa_lock_irq(&inode->i_data.i_pages);
+	xa_lock_bh(&inode->i_data.i_pages);
 	nrpages = inode->i_data.nrpages;
-	xa_unlock_irq(&inode->i_data.i_pages);
+	xa_unlock_bh(&inode->i_data.i_pages);
 
 	gfs2_print_dbg(seq, "%s I: n:%llu/%llu t:%u f:0x%02lx d:0x%08x s:%llu "
 		       "p:%lu\n", fs_id_buf,
diff --git a/fs/inode.c b/fs/inode.c
index c93500d84264..56b54a13b58c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -368,7 +368,7 @@ EXPORT_SYMBOL(inc_nlink);
 
 static void __address_space_init_once(struct address_space *mapping)
 {
-	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
+	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_BH | XA_FLAGS_ACCOUNT);
 	init_rwsem(&mapping->i_mmap_rwsem);
 	INIT_LIST_HEAD(&mapping->private_list);
 	spin_lock_init(&mapping->private_lock);
@@ -527,7 +527,7 @@ void clear_inode(struct inode *inode)
 	 * process of removing the last page (in __delete_from_page_cache())
 	 * and we must not free the mapping under it.
 	 */
-	xa_lock_irq(&inode->i_data.i_pages);
+	xa_lock_bh(&inode->i_data.i_pages);
 	BUG_ON(inode->i_data.nrpages);
 	/*
 	 * Almost always, mapping_empty(&inode->i_data) here; but there are
@@ -537,7 +537,7 @@ void clear_inode(struct inode *inode)
 	 * or a cleanup function is called here, do not BUG_ON(!mapping_empty),
 	 * nor even WARN_ON(!mapping_empty).
 	 */
-	xa_unlock_irq(&inode->i_data.i_pages);
+	xa_unlock_bh(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.private_list));
 	BUG_ON(!(inode->i_state & I_FREEING));
 	BUG_ON(inode->i_state & I_CLEAR);
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 4391fd3abd8f..3461fad484da 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -178,9 +178,9 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 				       (unsigned long long)oldkey,
 				       (unsigned long long)newkey);
 
-		xa_lock_irq(&btnc->i_pages);
+		xa_lock_bh(&btnc->i_pages);
 		err = __xa_insert(&btnc->i_pages, newkey, opage, GFP_NOFS);
-		xa_unlock_irq(&btnc->i_pages);
+		xa_unlock_bh(&btnc->i_pages);
 		/*
 		 * Note: page->index will not change to newkey until
 		 * nilfs_btnode_commit_change_key() will be called.
@@ -235,10 +235,10 @@ void nilfs_btnode_commit_change_key(struct address_space *btnc,
 				       (unsigned long long)newkey);
 		mark_buffer_dirty(obh);
 
-		xa_lock_irq(&btnc->i_pages);
+		xa_lock_bh(&btnc->i_pages);
 		__xa_erase(&btnc->i_pages, oldkey);
 		__xa_set_mark(&btnc->i_pages, newkey, PAGECACHE_TAG_DIRTY);
-		xa_unlock_irq(&btnc->i_pages);
+		xa_unlock_bh(&btnc->i_pages);
 
 		opage->index = obh->b_blocknr = newkey;
 		unlock_page(opage);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 171fb5cd427f..38669536ce8e 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -321,13 +321,13 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 			struct page *p;
 
 			/* move the page to the destination cache */
-			xa_lock_irq(&smap->i_pages);
+			xa_lock_bh(&smap->i_pages);
 			p = __xa_erase(&smap->i_pages, offset);
 			WARN_ON(page != p);
 			smap->nrpages--;
-			xa_unlock_irq(&smap->i_pages);
+			xa_unlock_bh(&smap->i_pages);
 
-			xa_lock_irq(&dmap->i_pages);
+			xa_lock_bh(&dmap->i_pages);
 			p = __xa_store(&dmap->i_pages, offset, page, GFP_NOFS);
 			if (unlikely(p)) {
 				/* Probably -ENOMEM */
@@ -340,7 +340,7 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 					__xa_set_mark(&dmap->i_pages, offset,
 							PAGECACHE_TAG_DIRTY);
 			}
-			xa_unlock_irq(&dmap->i_pages);
+			xa_unlock_bh(&dmap->i_pages);
 		}
 		unlock_page(page);
 	}
@@ -461,14 +461,14 @@ int __nilfs_clear_page_dirty(struct page *page)
 	struct address_space *mapping = page->mapping;
 
 	if (mapping) {
-		xa_lock_irq(&mapping->i_pages);
+		xa_lock_bh(&mapping->i_pages);
 		if (test_bit(PG_dirty, &page->flags)) {
 			__xa_clear_mark(&mapping->i_pages, page_index(page),
 					     PAGECACHE_TAG_DIRTY);
-			xa_unlock_irq(&mapping->i_pages);
+			xa_unlock_bh(&mapping->i_pages);
 			return clear_page_dirty_for_io(page);
 		}
-		xa_unlock_irq(&mapping->i_pages);
+		xa_unlock_bh(&mapping->i_pages);
 		return 0;
 	}
 	return TestClearPageDirty(page);
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 44df4fcef65c..5535eed4222f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -315,7 +315,7 @@ unlocked_inode_to_wb_begin(struct inode *inode, struct wb_lock_cookie *cookie)
 	cookie->locked = smp_load_acquire(&inode->i_state) & I_WB_SWITCH;
 
 	if (unlikely(cookie->locked))
-		xa_lock_irqsave(&inode->i_mapping->i_pages, cookie->flags);
+		xa_lock_bh(&inode->i_mapping->i_pages);
 
 	/*
 	 * Protected by either !I_WB_SWITCH + rcu_read_lock() or the i_pages
@@ -333,7 +333,7 @@ static inline void unlocked_inode_to_wb_end(struct inode *inode,
 					    struct wb_lock_cookie *cookie)
 {
 	if (unlikely(cookie->locked))
-		xa_unlock_irqrestore(&inode->i_mapping->i_pages, cookie->flags);
+		xa_unlock_bh(&inode->i_mapping->i_pages);
 
 	rcu_read_unlock();
 }
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 1b5fceb565df..4f07f4317169 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -184,6 +184,15 @@ unsigned long list_lru_walk_one_irq(struct list_lru *lru,
 				    int nid, struct mem_cgroup *memcg,
 				    list_lru_walk_cb isolate, void *cb_arg,
 				    unsigned long *nr_to_walk);
+/**
+ * Same as @list_lru_walk_one except that the spinlock is acquired with
+ * spin_lock_bh().
+ */
+unsigned long list_lru_walk_one_bh(struct list_lru *lru,
+				    int nid, struct mem_cgroup *memcg,
+				    list_lru_walk_cb isolate, void *cb_arg,
+				    unsigned long *nr_to_walk);
+
 unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				 list_lru_walk_cb isolate, void *cb_arg,
 				 unsigned long *nr_to_walk);
@@ -204,6 +213,14 @@ list_lru_shrink_walk_irq(struct list_lru *lru, struct shrink_control *sc,
 				     &sc->nr_to_scan);
 }
 
+static inline unsigned long
+list_lru_shrink_walk_bh(struct list_lru *lru, struct shrink_control *sc,
+			 list_lru_walk_cb isolate, void *cb_arg)
+{
+	return list_lru_walk_one_bh(lru, sc->nid, sc->memcg, isolate, cb_arg,
+				     &sc->nr_to_scan);
+}
+
 static inline unsigned long
 list_lru_walk(struct list_lru *lru, list_lru_walk_cb isolate,
 	      void *cb_arg, unsigned long nr_to_walk)
diff --git a/mm/filemap.c b/mm/filemap.c
index d1458ecf2f51..ec1cb9d3d644 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -258,12 +258,11 @@ static void page_cache_free_page(struct address_space *mapping,
 void delete_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
-	unsigned long flags;
 
 	BUG_ON(!PageLocked(page));
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_bh(&mapping->i_pages);
 	__delete_from_page_cache(page, NULL);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_bh(&mapping->i_pages);
 
 	page_cache_free_page(mapping, page);
 }
@@ -335,19 +334,18 @@ void delete_from_page_cache_batch(struct address_space *mapping,
 				  struct pagevec *pvec)
 {
 	int i;
-	unsigned long flags;
 
 	if (!pagevec_count(pvec))
 		return;
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_bh(&mapping->i_pages);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		trace_mm_filemap_delete_from_page_cache(pvec->pages[i]);
 
 		unaccount_page_cache_page(mapping, pvec->pages[i]);
 	}
 	page_cache_delete_batch(mapping, pvec);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_bh(&mapping->i_pages);
 
 	for (i = 0; i < pagevec_count(pvec); i++)
 		page_cache_free_page(mapping, pvec->pages[i]);
@@ -821,7 +819,6 @@ void replace_page_cache_page(struct page *old, struct page *new)
 	void (*freepage)(struct page *) = mapping->a_ops->freepage;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
-	unsigned long flags;
 
 	VM_BUG_ON_PAGE(!PageLocked(old), old);
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
@@ -833,7 +830,7 @@ void replace_page_cache_page(struct page *old, struct page *new)
 
 	mem_cgroup_migrate(old, new);
 
-	xas_lock_irqsave(&xas, flags);
+	xas_lock_bh(&xas);
 	xas_store(&xas, new);
 
 	old->mapping = NULL;
@@ -846,7 +843,7 @@ void replace_page_cache_page(struct page *old, struct page *new)
 		__dec_lruvec_page_state(old, NR_SHMEM);
 	if (PageSwapBacked(new))
 		__inc_lruvec_page_state(new, NR_SHMEM);
-	xas_unlock_irqrestore(&xas, flags);
+	xas_unlock_bh(&xas);
 	if (freepage)
 		freepage(old);
 	put_page(old);
@@ -887,7 +884,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 		if (order > thp_order(page))
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
 			if (!xa_is_value(entry)) {
@@ -917,7 +914,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
 		if (!huge)
 			__inc_lruvec_page_state(page, NR_FILE_PAGES);
 unlock:
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 	} while (xas_nomem(&xas, gfp));
 
 	if (xas_error(&xas)) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b0412be08fa2..eae8e0494de0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1666,11 +1666,11 @@ static void collapse_file(struct mm_struct *mm,
 
 	/* This will be less messy when we use multi-index entries */
 	do {
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		xas_create_range(&xas);
 		if (!xas_error(&xas))
 			break;
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		if (!xas_nomem(&xas, GFP_KERNEL)) {
 			result = SCAN_FAIL;
 			goto out;
@@ -1718,7 +1718,7 @@ static void collapse_file(struct mm_struct *mm,
 			}
 
 			if (xa_is_value(page) || !PageUptodate(page)) {
-				xas_unlock_irq(&xas);
+				xas_unlock_bh(&xas);
 				/* swap in or instantiate fallocated page */
 				if (shmem_getpage(mapping->host, index, &page,
 						  SGP_NOHUGE)) {
@@ -1727,14 +1727,14 @@ static void collapse_file(struct mm_struct *mm,
 				}
 			} else if (trylock_page(page)) {
 				get_page(page);
-				xas_unlock_irq(&xas);
+				xas_unlock_bh(&xas);
 			} else {
 				result = SCAN_PAGE_LOCK;
 				goto xa_locked;
 			}
 		} else {	/* !is_shmem */
 			if (!page || xa_is_value(page)) {
-				xas_unlock_irq(&xas);
+				xas_unlock_bh(&xas);
 				page_cache_sync_readahead(mapping, &file->f_ra,
 							  file, index,
 							  end - index);
@@ -1759,13 +1759,13 @@ static void collapse_file(struct mm_struct *mm,
 				 * This is a one-off situation. We are not
 				 * forcing writeback in loop.
 				 */
-				xas_unlock_irq(&xas);
+				xas_unlock_bh(&xas);
 				filemap_flush(mapping);
 				result = SCAN_FAIL;
 				goto xa_unlocked;
 			} else if (trylock_page(page)) {
 				get_page(page);
-				xas_unlock_irq(&xas);
+				xas_unlock_bh(&xas);
 			} else {
 				result = SCAN_PAGE_LOCK;
 				goto xa_locked;
@@ -1823,7 +1823,7 @@ static void collapse_file(struct mm_struct *mm,
 		if (page_mapped(page))
 			unmap_mapping_pages(mapping, index, 1, false);
 
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		xas_set(&xas, index);
 
 		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
@@ -1837,7 +1837,7 @@ static void collapse_file(struct mm_struct *mm,
 		 */
 		if (!page_ref_freeze(page, 3)) {
 			result = SCAN_PAGE_COUNT;
-			xas_unlock_irq(&xas);
+			xas_unlock_bh(&xas);
 			putback_lru_page(page);
 			goto out_unlock;
 		}
@@ -1885,7 +1885,7 @@ static void collapse_file(struct mm_struct *mm,
 	}
 
 xa_locked:
-	xas_unlock_irq(&xas);
+	xas_unlock_bh(&xas);
 xa_unlocked:
 
 	if (result == SCAN_SUCCEED) {
@@ -1934,7 +1934,7 @@ static void collapse_file(struct mm_struct *mm,
 		struct page *page;
 
 		/* Something went wrong: roll back page cache changes */
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		mapping->nrpages -= nr_none;
 
 		if (is_shmem)
@@ -1960,13 +1960,13 @@ static void collapse_file(struct mm_struct *mm,
 			page_ref_unfreeze(page, 2);
 			xas_store(&xas, page);
 			xas_pause(&xas);
-			xas_unlock_irq(&xas);
+			xas_unlock_bh(&xas);
 			unlock_page(page);
 			putback_lru_page(page);
-			xas_lock_irq(&xas);
+			xas_lock_bh(&xas);
 		}
 		VM_BUG_ON(nr_none);
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 
 		new_page->mapping = NULL;
 	}
diff --git a/mm/list_lru.c b/mm/list_lru.c
index cd58790d0fb3..11556982017b 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -285,6 +285,21 @@ list_lru_walk_one_irq(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	return ret;
 }
 
+unsigned long
+list_lru_walk_one_bh(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
+		      list_lru_walk_cb isolate, void *cb_arg,
+		      unsigned long *nr_to_walk)
+{
+	struct list_lru_node *nlru = &lru->node[nid];
+	unsigned long ret;
+
+	spin_lock_bh(&nlru->lock);
+	ret = __list_lru_walk_one(nlru, memcg_cache_id(memcg), isolate, cb_arg,
+				  nr_to_walk);
+	spin_unlock_bh(&nlru->lock);
+	return ret;
+}
+
 unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 				 list_lru_walk_cb isolate, void *cb_arg,
 				 unsigned long *nr_to_walk)
diff --git a/mm/memfd.c b/mm/memfd.c
index 081dd33e6a61..ef7de2d1035a 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -35,7 +35,7 @@ static void memfd_tag_pins(struct xa_state *xas)
 
 	lru_add_drain();
 
-	xas_lock_irq(xas);
+	xas_lock_bh(xas);
 	xas_for_each(xas, page, ULONG_MAX) {
 		if (xa_is_value(page))
 			continue;
@@ -47,11 +47,11 @@ static void memfd_tag_pins(struct xa_state *xas)
 			continue;
 
 		xas_pause(xas);
-		xas_unlock_irq(xas);
+		xas_unlock_bh(xas);
 		cond_resched();
-		xas_lock_irq(xas);
+		xas_lock_bh(xas);
 	}
-	xas_unlock_irq(xas);
+	xas_unlock_bh(xas);
 }
 
 /*
@@ -84,7 +84,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 			scan = LAST_SCAN;
 
 		xas_set(&xas, 0);
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
 			bool clear = true;
 			if (xa_is_value(page))
@@ -107,11 +107,11 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 				continue;
 
 			xas_pause(&xas);
-			xas_unlock_irq(&xas);
+			xas_unlock_bh(&xas);
 			cond_resched();
-			xas_lock_irq(&xas);
+			xas_lock_bh(&xas);
 		}
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 	}
 
 	return error;
diff --git a/mm/migrate.c b/mm/migrate.c
index 34a9ad3e0a4f..7b9a78ba1bfc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -402,14 +402,14 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	oldzone = page_zone(page);
 	newzone = page_zone(newpage);
 
-	xas_lock_irq(&xas);
+	xas_lock_bh(&xas);
 	if (page_count(page) != expected_count || xas_load(&xas) != page) {
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		return -EAGAIN;
 	}
 
 	if (!page_ref_freeze(page, expected_count)) {
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		return -EAGAIN;
 	}
 
@@ -454,8 +454,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 */
 	page_ref_unfreeze(page, expected_count - nr);
 
-	xas_unlock(&xas);
-	/* Leave irq disabled to prevent preemption while updating stats */
+	xas_unlock_bh(&xas);
 
 	/*
 	 * If moved to a different zone then also account
@@ -494,7 +493,6 @@ int migrate_page_move_mapping(struct address_space *mapping,
 			__mod_zone_page_state(newzone, NR_ZONE_WRITE_PENDING, nr);
 		}
 	}
-	local_irq_enable();
 
 	return MIGRATEPAGE_SUCCESS;
 }
@@ -510,15 +508,15 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, page_index(page));
 	int expected_count;
 
-	xas_lock_irq(&xas);
+	xas_lock_bh(&xas);
 	expected_count = 2 + page_has_private(page);
 	if (page_count(page) != expected_count || xas_load(&xas) != page) {
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		return -EAGAIN;
 	}
 
 	if (!page_ref_freeze(page, expected_count)) {
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		return -EAGAIN;
 	}
 
@@ -531,7 +529,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 	page_ref_unfreeze(page, expected_count - 1);
 
-	xas_unlock_irq(&xas);
+	xas_unlock_bh(&xas);
 
 	return MIGRATEPAGE_SUCCESS;
 }
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9f63548f247c..99221bf264cb 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2122,18 +2122,18 @@ void tag_pages_for_writeback(struct address_space *mapping,
 	unsigned int tagged = 0;
 	void *page;
 
-	xas_lock_irq(&xas);
+	xas_lock_bh(&xas);
 	xas_for_each_marked(&xas, page, end, PAGECACHE_TAG_DIRTY) {
 		xas_set_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		if (++tagged % XA_CHECK_SCHED)
 			continue;
 
 		xas_pause(&xas);
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 		cond_resched();
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 	}
-	xas_unlock_irq(&xas);
+	xas_unlock_bh(&xas);
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
@@ -2475,16 +2475,15 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
 void __set_page_dirty(struct page *page, struct address_space *mapping,
 			     int warn)
 {
-	unsigned long flags;
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_bh(&mapping->i_pages);
 	if (page->mapping) {	/* Race with truncate? */
 		WARN_ON_ONCE(warn && !PageUptodate(page));
 		account_page_dirtied(page, mapping);
 		__xa_set_mark(&mapping->i_pages, page_index(page),
 				PAGECACHE_TAG_DIRTY);
 	}
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_bh(&mapping->i_pages);
 }
 
 /*
@@ -2740,9 +2739,8 @@ int test_clear_page_writeback(struct page *page)
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
-		unsigned long flags;
 
-		xa_lock_irqsave(&mapping->i_pages, flags);
+		xa_lock_bh(&mapping->i_pages);
 		ret = TestClearPageWriteback(page);
 		if (ret) {
 			__xa_clear_mark(&mapping->i_pages, page_index(page),
@@ -2759,7 +2757,7 @@ int test_clear_page_writeback(struct page *page)
 						     PAGECACHE_TAG_WRITEBACK))
 			sb_clear_inode_writeback(mapping->host);
 
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		xa_unlock_bh(&mapping->i_pages);
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
@@ -2782,9 +2780,8 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 		XA_STATE(xas, &mapping->i_pages, page_index(page));
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
-		unsigned long flags;
 
-		xas_lock_irqsave(&xas, flags);
+		xas_lock_bh(&xas);
 		xas_load(&xas);
 		ret = TestSetPageWriteback(page);
 		if (!ret) {
@@ -2809,7 +2806,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 			xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
 		if (!keep_write)
 			xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
-		xas_unlock_irqrestore(&xas, flags);
+		xas_unlock_bh(&xas);
 	} else {
 		ret = TestSetPageWriteback(page);
 	}
diff --git a/mm/shmem.c b/mm/shmem.c
index 70d9ce294bb4..53d5a32aced1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -698,7 +698,7 @@ static int shmem_add_to_page_cache(struct page *page,
 
 	do {
 		void *entry;
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		entry = xas_find_conflict(&xas);
 		if (entry != expected)
 			xas_set_err(&xas, -EEXIST);
@@ -719,7 +719,7 @@ static int shmem_add_to_page_cache(struct page *page,
 		__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
 		__mod_lruvec_page_state(page, NR_SHMEM, nr);
 unlock:
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 	} while (xas_nomem(&xas, gfp));
 
 	if (xas_error(&xas)) {
@@ -744,13 +744,13 @@ static void shmem_delete_from_page_cache(struct page *page, void *radswap)
 
 	VM_BUG_ON_PAGE(PageCompound(page), page);
 
-	xa_lock_irq(&mapping->i_pages);
+	xa_lock_bh(&mapping->i_pages);
 	error = shmem_replace_entry(mapping, page->index, page, radswap);
 	page->mapping = NULL;
 	mapping->nrpages--;
 	__dec_lruvec_page_state(page, NR_FILE_PAGES);
 	__dec_lruvec_page_state(page, NR_SHMEM);
-	xa_unlock_irq(&mapping->i_pages);
+	xa_unlock_bh(&mapping->i_pages);
 	put_page(page);
 	BUG_ON(error);
 }
@@ -1652,14 +1652,14 @@ static int shmem_replace_page(struct page **pagep, gfp_t gfp,
 	 * Our caller will very soon move newpage out of swapcache, but it's
 	 * a nice clean interface for us to replace oldpage by newpage there.
 	 */
-	xa_lock_irq(&swap_mapping->i_pages);
+	xa_lock_bh(&swap_mapping->i_pages);
 	error = shmem_replace_entry(swap_mapping, swap_index, oldpage, newpage);
 	if (!error) {
 		mem_cgroup_migrate(oldpage, newpage);
 		__inc_lruvec_page_state(newpage, NR_FILE_PAGES);
 		__dec_lruvec_page_state(oldpage, NR_FILE_PAGES);
 	}
-	xa_unlock_irq(&swap_mapping->i_pages);
+	xa_unlock_bh(&swap_mapping->i_pages);
 
 	if (unlikely(error)) {
 		/*
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index a66f3e0ec973..e8bd8ec89dec 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -274,10 +274,10 @@ int free_swap_slot(swp_entry_t entry)
 
 	cache = raw_cpu_ptr(&swp_slots);
 	if (likely(use_swap_slot_cache && cache->slots_ret)) {
-		spin_lock_irq(&cache->free_lock);
+		spin_lock_bh(&cache->free_lock);
 		/* Swap slots cache may be deactivated before acquiring lock */
 		if (!use_swap_slot_cache || !cache->slots_ret) {
-			spin_unlock_irq(&cache->free_lock);
+			spin_unlock_bh(&cache->free_lock);
 			goto direct_free;
 		}
 		if (cache->n_ret >= SWAP_SLOTS_CACHE_SIZE) {
@@ -291,7 +291,7 @@ int free_swap_slot(swp_entry_t entry)
 			cache->n_ret = 0;
 		}
 		cache->slots_ret[cache->n_ret++] = entry;
-		spin_unlock_irq(&cache->free_lock);
+		spin_unlock_bh(&cache->free_lock);
 	} else {
 direct_free:
 		swapcache_free_entries(&entry, 1);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c56aa9ac050d..1773d1593b93 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -114,7 +114,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 	SetPageSwapCache(page);
 
 	do {
-		xas_lock_irq(&xas);
+		xas_lock_bh(&xas);
 		xas_create_range(&xas);
 		if (xas_error(&xas))
 			goto unlock;
@@ -134,7 +134,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 		__mod_lruvec_page_state(page, NR_SWAPCACHE, nr);
 		ADD_CACHE_INFO(add_total, nr);
 unlock:
-		xas_unlock_irq(&xas);
+		xas_unlock_bh(&xas);
 	} while (xas_nomem(&xas, gfp));
 
 	if (!xas_error(&xas))
@@ -242,9 +242,9 @@ void delete_from_swap_cache(struct page *page)
 	swp_entry_t entry = { .val = page_private(page) };
 	struct address_space *address_space = swap_address_space(entry);
 
-	xa_lock_irq(&address_space->i_pages);
+	xa_lock_bh(&address_space->i_pages);
 	__delete_from_swap_cache(page, entry, NULL);
-	xa_unlock_irq(&address_space->i_pages);
+	xa_unlock_bh(&address_space->i_pages);
 
 	put_swap_page(page, entry);
 	page_ref_sub(page, thp_nr_pages(page));
@@ -261,13 +261,13 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 		struct address_space *address_space = swap_address_space(entry);
 		XA_STATE(xas, &address_space->i_pages, curr);
 
-		xa_lock_irq(&address_space->i_pages);
+		xa_lock_bh(&address_space->i_pages);
 		xas_for_each(&xas, old, end) {
 			if (!xa_is_value(old))
 				continue;
 			xas_store(&xas, NULL);
 		}
-		xa_unlock_irq(&address_space->i_pages);
+		xa_unlock_bh(&address_space->i_pages);
 
 		/* search the next swapcache until we meet end */
 		curr >>= SWAP_ADDRESS_SPACE_SHIFT;
@@ -679,7 +679,7 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		return -ENOMEM;
 	for (i = 0; i < nr; i++) {
 		space = spaces + i;
-		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_IRQ);
+		xa_init_flags(&space->i_pages, XA_FLAGS_LOCK_BH);
 		atomic_set(&space->i_mmap_writable, 0);
 		space->a_ops = &swap_aops;
 		/* swap cache doesn't use writeback related tags */
diff --git a/mm/truncate.c b/mm/truncate.c
index 234ddd879caa..c5b7fd2360c7 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -45,9 +45,9 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 static void clear_shadow_entry(struct address_space *mapping, pgoff_t index,
 			       void *entry)
 {
-	xa_lock_irq(&mapping->i_pages);
+	xa_lock_bh(&mapping->i_pages);
 	__clear_shadow_entry(mapping, index, entry);
-	xa_unlock_irq(&mapping->i_pages);
+	xa_unlock_bh(&mapping->i_pages);
 }
 
 /*
@@ -74,7 +74,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 
 	dax = dax_mapping(mapping);
 	if (!dax)
-		xa_lock_irq(&mapping->i_pages);
+		xa_lock_bh(&mapping->i_pages);
 
 	for (i = j; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
@@ -94,7 +94,7 @@ static void truncate_exceptional_pvec_entries(struct address_space *mapping,
 	}
 
 	if (!dax)
-		xa_unlock_irq(&mapping->i_pages);
+		xa_unlock_bh(&mapping->i_pages);
 	pvec->nr = j;
 }
 
@@ -452,8 +452,8 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		 * modification that does not see AS_EXITING is
 		 * completed before starting the final truncate.
 		 */
-		xa_lock_irq(&mapping->i_pages);
-		xa_unlock_irq(&mapping->i_pages);
+		xa_lock_bh(&mapping->i_pages);
+		xa_unlock_bh(&mapping->i_pages);
 	}
 
 	/*
@@ -560,7 +560,6 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
 static int
 invalidate_complete_page2(struct address_space *mapping, struct page *page)
 {
-	unsigned long flags;
 
 	if (page->mapping != mapping)
 		return 0;
@@ -568,13 +567,13 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	if (page_has_private(page) && !try_to_release_page(page, GFP_KERNEL))
 		return 0;
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_bh(&mapping->i_pages);
 	if (PageDirty(page))
 		goto failed;
 
 	BUG_ON(page_has_private(page));
 	__delete_from_page_cache(page, NULL);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_bh(&mapping->i_pages);
 
 	if (mapping->a_ops->freepage)
 		mapping->a_ops->freepage(page);
@@ -582,7 +581,7 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
 	put_page(page);	/* pagecache ref */
 	return 1;
 failed:
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_bh(&mapping->i_pages);
 	return 0;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df62f0ff..f59e96f5223a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1049,14 +1049,13 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 static int __remove_mapping(struct address_space *mapping, struct page *page,
 			    bool reclaimed, struct mem_cgroup *target_memcg)
 {
-	unsigned long flags;
 	int refcount;
 	void *shadow = NULL;
 
 	BUG_ON(!PageLocked(page));
 	BUG_ON(mapping != page_mapping(page));
 
-	xa_lock_irqsave(&mapping->i_pages, flags);
+	xa_lock_bh(&mapping->i_pages);
 	/*
 	 * The non racy check for a busy page.
 	 *
@@ -1097,7 +1096,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_swap_cache(page, swap, shadow);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		xa_unlock_bh(&mapping->i_pages);
 		put_swap_page(page, swap);
 	} else {
 		void (*freepage)(struct page *);
@@ -1123,7 +1122,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
 			shadow = workingset_eviction(page, target_memcg);
 		__delete_from_page_cache(page, shadow);
-		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		xa_unlock_bh(&mapping->i_pages);
 
 		if (freepage != NULL)
 			freepage(page);
@@ -1132,7 +1131,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	return 1;
 
 cannot_free:
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
+	xa_unlock_bh(&mapping->i_pages);
 	return 0;
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 5ba3e42446fa..e28cd563bbf2 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -532,12 +532,10 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	 * pin only the address_space of the particular node we want
 	 * to reclaim, take the node off-LRU, and drop the lru_lock.
 	 */
-
 	mapping = container_of(node->array, struct address_space, i_pages);
-
 	/* Coming from the list, invert the lock order */
 	if (!xa_trylock(&mapping->i_pages)) {
-		spin_unlock_irq(lru_lock);
+		spin_unlock_bh(lru_lock);
 		ret = LRU_RETRY;
 		goto out;
 	}
@@ -560,19 +558,19 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	__inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
 
 out_invalid:
-	xa_unlock_irq(&mapping->i_pages);
+	xa_unlock_bh(&mapping->i_pages);
 	ret = LRU_REMOVED_RETRY;
 out:
 	cond_resched();
-	spin_lock_irq(lru_lock);
+	spin_lock_bh(lru_lock);
 	return ret;
 }
 
 static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 				       struct shrink_control *sc)
 {
-	/* list_lru lock nests inside the IRQ-safe i_pages lock */
-	return list_lru_shrink_walk_irq(&shadow_nodes, sc, shadow_lru_isolate,
+	/* list_lru lock nests inside the BH-safe i_pages lock */
+	return list_lru_shrink_walk_bh(&shadow_nodes, sc, shadow_lru_isolate,
 					NULL);
 }
 
-- 
2.32.0.452.g940fe202ad

