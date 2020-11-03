Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B992A42F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgKCKfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:35:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgKCKd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:57 -0500
Message-Id: <20201103095858.827582066@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qu2FJTZMTpHUjCQFQy2+FTKDqdLbW4HE91kk/7iTh0M=;
        b=iS2Z8GDPyJ5ppHC/Yf9cW5uFCDh+JFJW8GE2rxGliavv10yWptogtGJMc8wLgolBUL2goj
        nAFFMLBa1WJ07pMOhpD3fZgV7MrKwca6kHkRSwNanDpmqIou4474i+k9Ibt1K85/UZXdH9
        uNXnD/ZyOU/vd3oPn9vVu09LTzfnftVDtd0ExKiZeGwgz3af8CmAPx0JD/eDdrxWsHaB3H
        s/8GN0SrM6LbkHOl7xTxt91HC0bh5KMFVDwu1kRQwgR7q8LLeKp2+1t/yJGEbX8VCLpZx+
        y+gcgiPkSPQyT5M369QIRWKxESoTbZGJ78dco2C5aXZ7spNEvCYBItOQTyfLNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qu2FJTZMTpHUjCQFQy2+FTKDqdLbW4HE91kk/7iTh0M=;
        b=ZjYRVQ4hxcPV5RJ3LepIMFZJxD4sXFxStQqUrgdZ2XJb4yKVlZ1Xg0PKWqcfTuRDO41c8K
        lNvierDRkolMZ4BQ==
Date:   Tue, 03 Nov 2020 10:27:34 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [patch V3 22/37] highmem: High implementation details and document API
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the gory details of kmap & al into a private header and only document
the interfaces which are usable by drivers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 include/linux/highmem-internal.h |  174 +++++++++++++++++++++++++
 include/linux/highmem.h          |  270 ++++++++++++++-------------------------
 mm/highmem.c                     |   11 -
 3 files changed, 276 insertions(+), 179 deletions(-)

--- /dev/null
+++ b/include/linux/highmem-internal.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_HIGHMEM_INTERNAL_H
+#define _LINUX_HIGHMEM_INTERNAL_H
+
+/*
+ * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
+ */
+#ifdef CONFIG_KMAP_LOCAL
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
+void kunmap_local_indexed(void *vaddr);
+#endif
+
+#ifdef CONFIG_HIGHMEM
+#include <asm/highmem.h>
+
+#ifndef ARCH_HAS_KMAP_FLUSH_TLB
+static inline void kmap_flush_tlb(unsigned long addr) { }
+#endif
+
+#ifndef kmap_prot
+#define kmap_prot PAGE_KERNEL
+#endif
+
+void *kmap_high(struct page *page);
+void kunmap_high(struct page *page);
+void __kmap_flush_unused(void);
+struct page *__kmap_to_page(void *addr);
+
+static inline void *kmap(struct page *page)
+{
+	void *addr;
+
+	might_sleep();
+	if (!PageHighMem(page))
+		addr = page_address(page);
+	else
+		addr = kmap_high(page);
+	kmap_flush_tlb((unsigned long)addr);
+	return addr;
+}
+
+static inline void kunmap(struct page *page)
+{
+	might_sleep();
+	if (!PageHighMem(page))
+		return;
+	kunmap_high(page);
+}
+
+static inline struct page *kmap_to_page(void *addr)
+{
+	return __kmap_to_page(addr);
+}
+
+static inline void kmap_flush_unused(void)
+{
+	__kmap_flush_unused();
+}
+
+static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+{
+	preempt_disable();
+	pagefault_disable();
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_atomic(struct page *page)
+{
+	return kmap_atomic_prot(page, kmap_prot);
+}
+
+static inline void *kmap_atomic_pfn(unsigned long pfn)
+{
+	preempt_disable();
+	pagefault_disable();
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_atomic(void *addr)
+{
+	kunmap_local_indexed(addr);
+	pagefault_enable();
+	preempt_enable();
+}
+
+unsigned int __nr_free_highpages(void);
+extern atomic_long_t _totalhigh_pages;
+
+static inline unsigned int nr_free_highpages(void)
+{
+	return __nr_free_highpages();
+}
+
+static inline unsigned long totalhigh_pages(void)
+{
+	return (unsigned long)atomic_long_read(&_totalhigh_pages);
+}
+
+static inline void totalhigh_pages_inc(void)
+{
+	atomic_long_inc(&_totalhigh_pages);
+}
+
+static inline void totalhigh_pages_add(long count)
+{
+	atomic_long_add(count, &_totalhigh_pages);
+}
+
+#else /* CONFIG_HIGHMEM */
+
+static inline struct page *kmap_to_page(void *addr)
+{
+	return virt_to_page(addr);
+}
+
+static inline void *kmap(struct page *page)
+{
+	might_sleep();
+	return page_address(page);
+}
+
+static inline void kunmap_high(struct page *page) { }
+static inline void kmap_flush_unused(void) { }
+
+static inline void kunmap(struct page *page)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(page_address(page));
+#endif
+}
+
+static inline void *kmap_atomic(struct page *page)
+{
+	preempt_disable();
+	pagefault_disable();
+	return page_address(page);
+}
+
+static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_atomic(page);
+}
+
+static inline void *kmap_atomic_pfn(unsigned long pfn)
+{
+	return kmap_atomic(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_atomic(void *addr)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
+	pagefault_enable();
+	preempt_enable();
+}
+
+static inline unsigned int nr_free_highpages(void) { return 0; }
+static inline unsigned long totalhigh_pages(void) { return 0UL; }
+
+#endif /* CONFIG_HIGHMEM */
+
+/*
+ * Prevent people trying to call kunmap_atomic() as if it were kunmap()
+ * kunmap_atomic() should get the return value of kmap_atomic, not the page.
+ */
+#define kunmap_atomic(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_atomic(__addr);				\
+} while (0)
+
+#endif
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -11,199 +11,125 @@
 
 #include <asm/cacheflush.h>
 
-#ifndef ARCH_HAS_FLUSH_ANON_PAGE
-static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
-{
-}
-#endif
+#include "highmem-internal.h"
 
-#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
-static inline void flush_kernel_dcache_page(struct page *page)
-{
-}
-static inline void flush_kernel_vmap_range(void *vaddr, int size)
-{
-}
-static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
-{
-}
-#endif
-
-/*
- * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
+/**
+ * kmap - Map a page for long term usage
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Can only be invoked from preemptible task context because on 32bit
+ * systems with CONFIG_HIGHMEM enabled this function might sleep.
+ *
+ * For systems with CONFIG_HIGHMEM=n and for pages in the low memory area
+ * this returns the virtual address of the direct kernel mapping.
+ *
+ * The returned virtual address is globally visible and valid up to the
+ * point where it is unmapped via kunmap(). The pointer can be handed to
+ * other contexts.
+ *
+ * For highmem pages on 32bit systems this can be slow as the mapping space
+ * is limited and protected by a global lock. In case that there is no
+ * mapping slot available the function blocks until a slot is released via
+ * kunmap().
  */
-#ifdef CONFIG_KMAP_LOCAL
-void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
-void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
-void kunmap_local_indexed(void *vaddr);
-#endif
-
-#ifdef CONFIG_HIGHMEM
-#include <asm/highmem.h>
+static inline void *kmap(struct page *page);
 
-#ifndef ARCH_HAS_KMAP_FLUSH_TLB
-static inline void kmap_flush_tlb(unsigned long addr) { }
-#endif
-
-#ifndef kmap_prot
-#define kmap_prot PAGE_KERNEL
-#endif
-
-void *kmap_high(struct page *page);
-static inline void *kmap(struct page *page)
-{
-	void *addr;
-
-	might_sleep();
-	if (!PageHighMem(page))
-		addr = page_address(page);
-	else
-		addr = kmap_high(page);
-	kmap_flush_tlb((unsigned long)addr);
-	return addr;
-}
-
-void kunmap_high(struct page *page);
-
-static inline void kunmap(struct page *page)
-{
-	might_sleep();
-	if (!PageHighMem(page))
-		return;
-	kunmap_high(page);
-}
-
-/*
- * kmap_atomic/kunmap_atomic is significantly faster than kmap/kunmap because
- * no global lock is needed and because the kmap code must perform a global TLB
- * invalidation when the kmap pool wraps.
- *
- * However when holding an atomic kmap it is not legal to sleep, so atomic
- * kmaps are appropriate for short, tight code paths only.
- *
- * The use of kmap_atomic/kunmap_atomic is discouraged - kmap/kunmap
- * gives a more generic (and caching) interface. But kmap_atomic can
- * be used in IRQ contexts, so in some (very limited) cases we need
- * it.
+/**
+ * kunmap - Unmap the virtual address mapped by kmap()
+ * @addr:	Virtual address to be unmapped
+ *
+ * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
+ * pages in the low memory area.
  */
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
-{
-	preempt_disable();
-	pagefault_disable();
-	return __kmap_local_page_prot(page, prot);
-}
-
-static inline void *kmap_atomic(struct page *page)
-{
-	return kmap_atomic_prot(page, kmap_prot);
-}
-
-static inline void *kmap_atomic_pfn(unsigned long pfn)
-{
-	preempt_disable();
-	pagefault_disable();
-	return __kmap_local_pfn_prot(pfn, kmap_prot);
-}
-
-static inline void __kunmap_atomic(void *addr)
-{
-	kunmap_local_indexed(addr);
-}
-
-/* declarations for linux/mm/highmem.c */
-unsigned int nr_free_highpages(void);
-extern atomic_long_t _totalhigh_pages;
-static inline unsigned long totalhigh_pages(void)
-{
-	return (unsigned long)atomic_long_read(&_totalhigh_pages);
-}
+static inline void kunmap(struct page *page);
 
-static inline void totalhigh_pages_inc(void)
-{
-	atomic_long_inc(&_totalhigh_pages);
-}
-
-static inline void totalhigh_pages_add(long count)
-{
-	atomic_long_add(count, &_totalhigh_pages);
-}
-
-void kmap_flush_unused(void);
-
-struct page *kmap_to_page(void *addr);
-
-#else /* CONFIG_HIGHMEM */
+/**
+ * kmap_to_page - Get the page for a kmap'ed address
+ * @addr:	The address to look up
+ *
+ * Returns: The page which is mapped to @addr.
+ */
+static inline struct page *kmap_to_page(void *addr);
 
-static inline unsigned int nr_free_highpages(void) { return 0; }
+/**
+ * kmap_flush_unused - Flush all unused kmap mappings in order to
+ *		       remove stray mappings
+ */
+static inline void kmap_flush_unused(void);
 
-static inline struct page *kmap_to_page(void *addr)
-{
-	return virt_to_page(addr);
-}
+/**
+ * kmap_atomic - Atomically map a page for temporary usage
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Side effect: On return pagefaults and preemption are disabled.
+ *
+ * Can be invoked from any context.
+ *
+ * Requires careful handling when nesting multiple mappings because the map
+ * management is stack based. The unmap has to be in the reverse order of
+ * the map operation:
+ *
+ * addr1 = kmap_atomic(page1);
+ * addr2 = kmap_atomic(page2);
+ * ...
+ * kunmap_atomic(addr2);
+ * kunmap_atomic(addr1);
+ *
+ * Unmapping addr1 before addr2 is invalid and causes malfunction.
+ *
+ * Contrary to kmap() mappings the mapping is only valid in the context of
+ * the caller and cannot be handed to other contexts.
+ *
+ * On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
+ * virtual address of the direct mapping. Only real highmem pages are
+ * temporarily mapped.
+ *
+ * While it is significantly faster than kmap() it comes with restrictions
+ * about the pointer validity and the side effects of disabling page faults
+ * and preemption. Use it only when absolutely necessary, e.g. from non
+ * preemptible contexts.
+ */
+static inline void *kmap_atomic(struct page *page);
 
-static inline unsigned long totalhigh_pages(void) { return 0UL; }
+/**
+ * kunmap_atomic - Unmap the virtual address mapped by kmap_atomic()
+ * @addr:	Virtual address to be unmapped
+ *
+ * Counterpart to kmap_atomic().
+ *
+ * Undoes the side effects of kmap_atomic(), i.e. reenabling pagefaults and
+ * preemption.
+ *
+ * Other than that a NOOP for CONFIG_HIGHMEM=n and for mappings of pages
+ * in the low memory area. For real highmen pages the mapping which was
+ * established with kmap_atomic() is destroyed.
+ */
 
-static inline void *kmap(struct page *page)
-{
-	might_sleep();
-	return page_address(page);
-}
+/* Highmem related interfaces for management code */
+static inline unsigned int nr_free_highpages(void);
+static inline unsigned long totalhigh_pages(void);
 
-static inline void kunmap_high(struct page *page)
+#ifndef ARCH_HAS_FLUSH_ANON_PAGE
+static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr)
 {
 }
-
-static inline void kunmap(struct page *page)
-{
-#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(page_address(page));
 #endif
-}
 
-static inline void *kmap_atomic(struct page *page)
+#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+static inline void flush_kernel_dcache_page(struct page *page)
 {
-	preempt_disable();
-	pagefault_disable();
-	return page_address(page);
 }
-
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void flush_kernel_vmap_range(void *vaddr, int size)
 {
-	return kmap_atomic(page);
 }
-
-static inline void *kmap_atomic_pfn(unsigned long pfn)
+static inline void invalidate_kernel_vmap_range(void *vaddr, int size)
 {
-	return kmap_atomic(pfn_to_page(pfn));
 }
-
-static inline void __kunmap_atomic(void *addr)
-{
-	/*
-	 * Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
-	 * handles re-enabling faults and preemption
-	 */
-#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
-	kunmap_flush_on_unmap(addr);
 #endif
-}
-
-#define kmap_flush_unused()	do {} while(0)
-
-
-#endif /* CONFIG_HIGHMEM */
-
-/*
- * Prevent people trying to call kunmap_atomic() as if it were kunmap()
- * kunmap_atomic() should get the return value of kmap_atomic, not the page.
- */
-#define kunmap_atomic(__addr)					\
-do {								\
-	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
-	__kunmap_atomic(__addr);				\
-	pagefault_enable();					\
-	preempt_enable();					\
-} while (0)
 
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 #ifndef clear_user_highpage
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -104,7 +104,7 @@ static inline wait_queue_head_t *get_pkm
 atomic_long_t _totalhigh_pages __read_mostly;
 EXPORT_SYMBOL(_totalhigh_pages);
 
-unsigned int nr_free_highpages (void)
+unsigned int __nr_free_highpages (void)
 {
 	struct zone *zone;
 	unsigned int pages = 0;
@@ -141,7 +141,7 @@ pte_t * pkmap_page_table;
 		do { spin_unlock(&kmap_lock); (void)(flags); } while (0)
 #endif
 
-struct page *kmap_to_page(void *vaddr)
+struct page *__kmap_to_page(void *vaddr)
 {
 	unsigned long addr = (unsigned long)vaddr;
 
@@ -152,7 +152,7 @@ struct page *kmap_to_page(void *vaddr)
 
 	return virt_to_page(addr);
 }
-EXPORT_SYMBOL(kmap_to_page);
+EXPORT_SYMBOL(__kmap_to_page);
 
 static void flush_all_zero_pkmaps(void)
 {
@@ -194,10 +194,7 @@ static void flush_all_zero_pkmaps(void)
 		flush_tlb_kernel_range(PKMAP_ADDR(0), PKMAP_ADDR(LAST_PKMAP));
 }
 
-/**
- * kmap_flush_unused - flush all unused kmap mappings in order to remove stray mappings
- */
-void kmap_flush_unused(void)
+void __kmap_flush_unused(void)
 {
 	lock_kmap();
 	flush_all_zero_pkmaps();

