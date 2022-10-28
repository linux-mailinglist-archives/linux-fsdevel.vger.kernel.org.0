Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23336115A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 17:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ1PQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJ1PQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:16:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949E1C19F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iHo0dXYsbgANrVfcUqE3Pj13Q6JiA9ERSsXw+Ir/P94=; b=ZIPz155/TgaAnxkWjnlin75+ms
        s6pJfHadSYXZsRaq7yCZ0nYG0ggNKifdPTHJ2NlZ6wZsi5VrMhxgPGnKpzPNt1/ysrIzlzExK4WqX
        wr9Al8lR99lPNfj9M+ZRalOzc9xo4nsQWx5xN4JO0yRTsUp93l8LDFyw/furcAUW1MjpLmRr6iFnL
        Oh4v9O9CZ6owIvp6DmMjHUsMjiCR5StDVSiQTPRCaMikCJoaPuKazc7cGECOPouxOH3/iJe3i6SIX
        P64c38VIgCEUUwm/AlHdM4CerYb4dF1LpELIjyEhEPO4kx2UOjRlSbIj6vs65jp2DLH/Vg1Q7DIuX
        Gnjp6n8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooR4x-001LAK-PP; Fri, 28 Oct 2022 15:15:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/1] mm: Add folio_map_local()
Date:   Fri, 28 Oct 2022 16:15:26 +0100
Message-Id: <20221028151526.319681-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221028151526.319681-1-willy@infradead.org>
References: <20221028151526.319681-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystems benefit from being able to map the entire folio.
On 32-bit platforms with HIGHMEM, we fall back to using vmap, which
will be slow.  If it proves to be a performance problem, we can look at
optimising it in a number of ways.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 40 ++++++++++++++++++++++++++++++++-
 include/linux/vmalloc.h |  6 +++--
 mm/vmalloc.c            | 50 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index e9912da5441b..e8159243d88d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
+#include <linux/vmalloc.h>
 
 #include "highmem-internal.h"
 
@@ -132,6 +133,44 @@ static inline void *kmap_local_page(struct page *page);
  */
 static inline void *kmap_local_folio(struct folio *folio, size_t offset);
 
+/**
+ * folio_map_local - Map an entire folio.
+ * @folio: The folio to map.
+ *
+ * Unlike kmap_local_folio(), map an entire folio.  This should be undone
+ * with folio_unmap_local().  The address returned should be treated as
+ * stack-based, and local to this CPU, like kmap_local_folio().
+ *
+ * Context: May allocate memory using GFP_KERNEL if it takes the vmap path.
+ * Return: A kernel virtual address which can be used to access the folio,
+ * or NULL if the mapping fails.
+ */
+static inline __must_check void *folio_map_local(struct folio *folio)
+{
+	might_alloc(GFP_KERNEL);
+
+	if (!IS_ENABLED(CONFIG_HIGHMEM))
+		return folio_address(folio);
+	if (folio_test_large(folio))
+		return vm_map_folio(folio);
+	return kmap_local_page(&folio->page);
+}
+
+/**
+ * folio_unmap_local - Unmap an entire folio.
+ * @addr: Address returned from folio_map_local()
+ *
+ * Undo the result of a previous call to folio_map_local().
+ */
+static inline void folio_unmap_local(const void *addr)
+{
+	if (!IS_ENABLED(CONFIG_HIGHMEM))
+		return;
+	if (is_vmalloc_addr(addr))
+		vunmap(addr);
+	kunmap_local(addr);
+}
+
 /**
  * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
  * @page:	Pointer to the page to be mapped
@@ -426,5 +465,4 @@ static inline void folio_zero_range(struct folio *folio,
 {
 	zero_user_segments(&folio->page, start, start + length, 0, 0);
 }
-
 #endif /* _LINUX_HIGHMEM_H */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48aa3437..4bb34c939c01 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -13,6 +13,7 @@
 #include <asm/vmalloc.h>
 
 struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
+struct folio;			/* also mm_types.h */
 struct notifier_block;		/* in notifier.h */
 
 /* bits in flags of vmalloc's vm_struct below */
@@ -163,8 +164,9 @@ extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
-extern void *vmap(struct page **pages, unsigned int count,
-			unsigned long flags, pgprot_t prot);
+void *vmap(struct page **pages, unsigned int count, unsigned long flags,
+		pgprot_t prot);
+void *vm_map_folio(struct folio *folio);
 void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
 extern void vunmap(const void *addr);
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaa461998f3..265b860c9550 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2283,6 +2283,56 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 }
 EXPORT_SYMBOL(vm_map_ram);
 
+#ifdef CONFIG_HIGHMEM
+/**
+ * vm_map_folio() - Map an entire folio into virtually contiguous space.
+ * @folio: The folio to map.
+ *
+ * Maps all pages in @folio into contiguous kernel virtual space.  This
+ * function is only available in HIGHMEM builds; for !HIGHMEM, use
+ * folio_address().  The pages are mapped with PAGE_KERNEL permissions.
+ *
+ * Return: The address of the area or %NULL on failure
+ */
+void *vm_map_folio(struct folio *folio)
+{
+	size_t size = folio_size(folio);
+	unsigned long addr;
+	void *mem;
+
+	might_sleep();
+
+	if (likely(folio_nr_pages(folio) <= VMAP_MAX_ALLOC)) {
+		mem = vb_alloc(size, GFP_KERNEL);
+		if (IS_ERR(mem))
+			return NULL;
+		addr = (unsigned long)mem;
+	} else {
+		struct vmap_area *va;
+		va = alloc_vmap_area(size, PAGE_SIZE, VMALLOC_START,
+				VMALLOC_END, NUMA_NO_NODE, GFP_KERNEL);
+		if (IS_ERR(va))
+			return NULL;
+
+		addr = va->va_start;
+		mem = (void *)addr;
+	}
+
+	if (vmap_range_noflush(addr, addr + size,
+				folio_pfn(folio) << PAGE_SHIFT,
+				PAGE_KERNEL, folio_shift(folio))) {
+		vm_unmap_ram(mem, folio_nr_pages(folio));
+		return NULL;
+	}
+	flush_cache_vmap(addr, addr + size);
+
+	mem = kasan_unpoison_vmalloc(mem, size, KASAN_VMALLOC_PROT_NORMAL);
+
+	return mem;
+}
+EXPORT_SYMBOL(vm_map_folio);
+#endif
+
 static struct vm_struct *vmlist __initdata;
 
 static inline unsigned int vm_area_page_order(struct vm_struct *vm)
-- 
2.35.1

