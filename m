Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E22A432C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgKCKhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:37:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37666 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgKCKdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:36 -0500
Message-Id: <20201103095857.375127260@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JvR9SzXGixMUFPGu3hosRygFCRqGpEvX72/eKoksGms=;
        b=iCr3QNsuOQxUbcEWlj16M4LpPvo/Y62uSSvcnN+SAO80o4EphxWAK4hfttSL9gOFt6BaES
        3gd/Ac+UtveRzMYmdP09SH56/GWn1i//q/WK/GmGvz0+JJjJsL9LQKMg/4U5XeM0UwBLqZ
        i+8Zp49HYIrlQG3K57otJmBdk39X9yS+dsPqNiRkB3rIYxUpjNv/cUSYSIbMyKdB7EY0rZ
        ph3bVNQrVGiMwRz6I9crBBsMFvYf7qh/jGpymJtYcPhkMGM5bS7pRLhokf2hu2Po56vCur
        TZ8sOccczZHm/872N+A7yAzzTuIb3tbrhfzZeuoD9s9c+TFaeiqMMzbSwKy9QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JvR9SzXGixMUFPGu3hosRygFCRqGpEvX72/eKoksGms=;
        b=fd5YAdk1NO85mRvSPB+n0kiHRJ8WGsJ4o9+MEF9URxrh98WvJpvYNTGTbIBoDqeTw83kAi
        VxNyrAlak1mehDCQ==
Date:   Tue, 03 Nov 2020 10:27:20 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
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
Subject: [patch V3 08/37] x86/mm/highmem: Use generic kmap atomic implementation
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert X86 to the generic kmap atomic implementation and make the
iomap_atomic() naming convention consistent while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
V3: Remove the kmap_types cruft
---
 arch/x86/Kconfig                      |    3 +
 arch/x86/include/asm/fixmap.h         |    5 +-
 arch/x86/include/asm/highmem.h        |   13 +++++--
 arch/x86/include/asm/iomap.h          |   18 +++++-----
 arch/x86/include/asm/kmap_types.h     |   13 -------
 arch/x86/include/asm/paravirt_types.h |    1 
 arch/x86/mm/highmem_32.c              |   59 ----------------------------------
 arch/x86/mm/init_32.c                 |   15 --------
 arch/x86/mm/iomap_32.c                |   59 ++--------------------------------
 include/linux/highmem.h               |    2 -
 include/linux/io-mapping.h            |    2 -
 mm/highmem.c                          |    2 -
 12 files changed, 31 insertions(+), 161 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,10 +14,11 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
+	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
+	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
-	select GENERIC_VDSO_32
 
 config X86_64
 	def_bool y
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -31,7 +31,7 @@
 #include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #else
 #include <uapi/asm/vsyscall.h>
 #endif
@@ -94,7 +94,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_X86_32
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
@@ -151,7 +151,6 @@ extern void reserve_top_address(unsigned
 
 extern int fixmaps_set;
 
-extern pte_t *kmap_pte;
 extern pte_t *pkmap_page_table;
 
 void __native_set_fixmap(enum fixed_addresses idx, pte_t pte);
--- a/arch/x86/include/asm/highmem.h
+++ b/arch/x86/include/asm/highmem.h
@@ -23,7 +23,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/fixmap.h>
@@ -58,11 +57,17 @@ extern unsigned long highstart_pfn, high
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))
 
-void *kmap_atomic_pfn(unsigned long pfn);
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
-
 #define flush_cache_kmaps()	do { } while (0)
 
+#define	arch_kmap_local_post_map(vaddr, pteval)		\
+	arch_flush_lazy_mmu_mode()
+
+#define	arch_kmap_local_post_unmap(vaddr)		\
+	do {						\
+		flush_tlb_one_kernel((vaddr));		\
+		arch_flush_lazy_mmu_mode();		\
+	} while (0)
+
 extern void add_highpages_with_active_regions(int nid, unsigned long start_pfn,
 					unsigned long end_pfn);
 
--- a/arch/x86/include/asm/iomap.h
+++ b/arch/x86/include/asm/iomap.h
@@ -9,19 +9,21 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot);
+void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot);
 
-void
-iounmap_atomic(void __iomem *kvaddr);
+static inline void iounmap_atomic(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+	pagefault_enable();
+	preempt_enable();
+}
 
-int
-iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
+int iomap_create_wc(resource_size_t base, unsigned long size, pgprot_t *prot);
 
-void
-iomap_free(resource_size_t base, unsigned long size);
+void iomap_free(resource_size_t base, unsigned long size);
 
 #endif /* _ASM_X86_IOMAP_H */
--- a/arch/x86/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_KMAP_TYPES_H
-#define _ASM_X86_KMAP_TYPES_H
-
-#if defined(CONFIG_X86_32) && defined(CONFIG_DEBUG_HIGHMEM)
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_X86_KMAP_TYPES_H */
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -41,7 +41,6 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/desc_defs.h>
-#include <asm/kmap_types.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
 
--- a/arch/x86/mm/highmem_32.c
+++ b/arch/x86/mm/highmem_32.c
@@ -4,65 +4,6 @@
 #include <linux/swap.h> /* for totalram_pages */
 #include <linux/memblock.h>
 
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	BUG_ON(!pte_none(*(kmap_pte-idx)));
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic_prot_pfn(pfn, kmap_prot);
-}
-EXPORT_SYMBOL_GPL(kmap_atomic_pfn);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-		arch_flush_lazy_mmu_mode();
-	}
-#ifdef CONFIG_DEBUG_HIGHMEM
-	else {
-		BUG_ON(vaddr < PAGE_OFFSET);
-		BUG_ON(vaddr >= (unsigned long)high_memory);
-	}
-#endif
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
 void __init set_highmem_pages_init(void)
 {
 	struct zone *zone;
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -394,19 +394,6 @@ kernel_physical_mapping_init(unsigned lo
 	return last_map_addr;
 }
 
-pte_t *kmap_pte;
-
-static void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/*
-	 * Cache the first kmap pte:
-	 */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
-
 #ifdef CONFIG_HIGHMEM
 static void __init permanent_kmaps_init(pgd_t *pgd_base)
 {
@@ -712,8 +699,6 @@ void __init paging_init(void)
 
 	__flush_tlb_all();
 
-	kmap_init();
-
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
 	 */
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -44,28 +44,7 @@ void iomap_free(resource_size_t base, un
 }
 EXPORT_SYMBOL_GPL(iomap_free);
 
-void *kmap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR * smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte - idx, pfn_pte(pfn, prot));
-	arch_flush_lazy_mmu_mode();
-
-	return (void *)vaddr;
-}
-
-/*
- * Map 'pfn' using protections 'prot'
- */
-void __iomem *
-iomap_atomic_prot_pfn(unsigned long pfn, pgprot_t prot)
+void __iomem *iomap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot)
 {
 	/*
 	 * For non-PAT systems, translate non-WB request to UC- just in
@@ -81,36 +60,8 @@ iomap_atomic_prot_pfn(unsigned long pfn,
 	/* Filter out unsupported __PAGE_KERNEL* bits: */
 	pgprot_val(prot) &= __default_kernel_pte_mask;
 
-	return (void __force __iomem *) kmap_atomic_prot_pfn(pfn, prot);
-}
-EXPORT_SYMBOL_GPL(iomap_atomic_prot_pfn);
-
-void
-iounmap_atomic(void __iomem *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-
-	if (vaddr >= __fix_to_virt(FIX_KMAP_END) &&
-	    vaddr <= __fix_to_virt(FIX_KMAP_BEGIN)) {
-		int idx, type;
-
-		type = kmap_atomic_idx();
-		idx = type + KM_TYPE_NR * smp_processor_id();
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-		WARN_ON_ONCE(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-#endif
-		/*
-		 * Force other mappings to Oops if they'll try to access this
-		 * pte without first remap it.  Keeping stale mappings around
-		 * is a bad idea also, in case the page changes cacheability
-		 * attributes or becomes a protected page in a hypervisor.
-		 */
-		kpte_clear_flush(kmap_pte-idx, vaddr);
-		kmap_atomic_idx_pop();
-	}
-
-	pagefault_enable();
-	preempt_enable();
+	preempt_disable();
+	pagefault_disable();
+	return (void __force __iomem *)__kmap_local_pfn_prot(pfn, prot);
 }
-EXPORT_SYMBOL_GPL(iounmap_atomic);
+EXPORT_SYMBOL_GPL(iomap_atomic_pfn_prot);
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -217,7 +217,7 @@ static inline void __kunmap_atomic(void
 #endif /* CONFIG_HIGHMEM */
 
 #if !defined(CONFIG_KMAP_LOCAL)
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
+#if defined(CONFIG_HIGHMEM)
 
 DECLARE_PER_CPU(int, __kmap_atomic_idx);
 
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -69,7 +69,7 @@ io_mapping_map_atomic_wc(struct io_mappi
 
 	BUG_ON(offset >= mapping->size);
 	phys_addr = mapping->base + offset;
-	return iomap_atomic_prot_pfn(PHYS_PFN(phys_addr), mapping->prot);
+	return iomap_atomic_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
 }
 
 static inline void
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -32,7 +32,7 @@
 #include <linux/vmalloc.h>
 
 #ifndef CONFIG_KMAP_LOCAL
-#if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
+#ifdef CONFIG_HIGHMEM
 DEFINE_PER_CPU(int, __kmap_atomic_idx);
 #endif
 #endif

