Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995702A423C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgKCKde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgKCKdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78C4C0613D1;
        Tue,  3 Nov 2020 02:33:31 -0800 (PST)
Message-Id: <20201103095857.175939340@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6KiTGILz6soJrbo7GlRIgkJ5aAbGNdOKbdY3aydNDS8=;
        b=IVuNgycF/k0HeK2iqaevLVvCdn/uwmOEuricCsEv/Skp8B0r1F9iUisxKFDQpuRW6+v9ql
        mq1KE7Zs+BZ//bB2PvsfMcfqtsajZO6zbw3Lx4SI1U7Qz2r1Mdfndu3NsHY/YSgfeo/XNy
        p9mYIPYIahtusEsmCJ25KWkTQ2bQ7GrTrDP2j5tzdCyYlMe9N68noXMjJRl7XUcXjTYtqa
        RFV85g0sxGP36heCwWP+Bbb+qrMt/O65qHCVrSrDU8XAXsrwQIJkXwTzy99nwTFQbus/7R
        AJinXvganQGSwRnWmZWEiFnnITCTiLqjvrkNlagYzjDuTTSMA91SyzzLPYpPyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=6KiTGILz6soJrbo7GlRIgkJ5aAbGNdOKbdY3aydNDS8=;
        b=nUGcsaeOaBx+Ezp0Ej9zQUSoKZKq5BvaRnkvGw7gMRW3Qe+hUX/T60+Br44uloVIZYeJJB
        9QsRj3Xu+6mP5hAw==
Date:   Tue, 03 Nov 2020 10:27:18 +0100
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
Subject: [patch V3 06/37] highmem: Provide generic variant of kmap_atomic*
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kmap_atomic* interfaces in all architectures are pretty much the same
except for post map operations (flush) and pre- and post unmap operations.

Provide a generic variant for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
V3: Do not reuse the kmap_atomic_idx pile and use kmap_size.h right away
V2: Address review comments from Christoph (style and EXPORT variant)
---
 include/linux/highmem.h |   82 ++++++++++++++++++++++-----
 mm/Kconfig              |    3 +
 mm/highmem.c            |  144 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 211 insertions(+), 18 deletions(-)

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -31,9 +31,16 @@ static inline void invalidate_kernel_vma
 
 #include <asm/kmap_types.h>
 
+/*
+ * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
+ */
+#ifdef CONFIG_KMAP_LOCAL
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
+void kunmap_local_indexed(void *vaddr);
+#endif
+
 #ifdef CONFIG_HIGHMEM
-extern void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
-extern void kunmap_atomic_high(void *kvaddr);
 #include <asm/highmem.h>
 
 #ifndef ARCH_HAS_KMAP_FLUSH_TLB
@@ -81,6 +88,11 @@ static inline void kunmap(struct page *p
  * be used in IRQ contexts, so in some (very limited) cases we need
  * it.
  */
+
+#ifndef CONFIG_KMAP_LOCAL
+void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
+void kunmap_atomic_high(void *kvaddr);
+
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	preempt_disable();
@@ -89,7 +101,38 @@ static inline void *kmap_atomic_prot(str
 		return page_address(page);
 	return kmap_atomic_high_prot(page, prot);
 }
-#define kmap_atomic(page)	kmap_atomic_prot(page, kmap_prot)
+
+static inline void __kunmap_atomic(void *vaddr)
+{
+	kunmap_atomic_high(vaddr);
+}
+#else /* !CONFIG_KMAP_LOCAL */
+
+static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+{
+	preempt_disable();
+	pagefault_disable();
+	return __kmap_local_page_prot(page, prot);
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
+}
+
+#endif /* CONFIG_KMAP_LOCAL */
+
+static inline void *kmap_atomic(struct page *page)
+{
+	return kmap_atomic_prot(page, kmap_prot);
+}
 
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
@@ -147,25 +190,33 @@ static inline void *kmap_atomic(struct p
 	pagefault_disable();
 	return page_address(page);
 }
-#define kmap_atomic_prot(page, prot)	kmap_atomic(page)
 
-static inline void kunmap_atomic_high(void *addr)
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
 {
 	/*
 	 * Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
-	 * handles re-enabling faults + preemption
+	 * handles re-enabling faults and preemption
 	 */
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
 	kunmap_flush_on_unmap(addr);
 #endif
 }
 
-#define kmap_atomic_pfn(pfn)	kmap_atomic(pfn_to_page(pfn))
-
 #define kmap_flush_unused()	do {} while(0)
 
 #endif /* CONFIG_HIGHMEM */
 
+#if !defined(CONFIG_KMAP_LOCAL)
 #if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
 
 DECLARE_PER_CPU(int, __kmap_atomic_idx);
@@ -196,22 +247,21 @@ static inline void kmap_atomic_idx_pop(v
 	__this_cpu_dec(__kmap_atomic_idx);
 #endif
 }
-
+#endif
 #endif
 
 /*
  * Prevent people trying to call kunmap_atomic() as if it were kunmap()
  * kunmap_atomic() should get the return value of kmap_atomic, not the page.
  */
-#define kunmap_atomic(addr)                                     \
-do {                                                            \
-	BUILD_BUG_ON(__same_type((addr), struct page *));       \
-	kunmap_atomic_high(addr);                                  \
-	pagefault_enable();                                     \
-	preempt_enable();                                       \
+#define kunmap_atomic(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_atomic(__addr);				\
+	pagefault_enable();					\
+	preempt_enable();					\
 } while (0)
 
-
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 #ifndef clear_user_highpage
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -872,4 +872,7 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config KMAP_LOCAL
+	bool
+
 endmenu
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -31,9 +31,11 @@
 #include <asm/tlbflush.h>
 #include <linux/vmalloc.h>
 
+#ifndef CONFIG_KMAP_LOCAL
 #if defined(CONFIG_HIGHMEM) || defined(CONFIG_X86_32)
 DEFINE_PER_CPU(int, __kmap_atomic_idx);
 #endif
+#endif
 
 /*
  * Virtual_count is not a pure "count".
@@ -365,9 +367,147 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
-
 EXPORT_SYMBOL(kunmap_high);
-#endif	/* CONFIG_HIGHMEM */
+#endif /* CONFIG_HIGHMEM */
+
+#ifdef CONFIG_KMAP_LOCAL
+
+#include <asm/kmap_size.h>
+
+static DEFINE_PER_CPU(int, __kmap_local_idx);
+
+static inline int kmap_local_idx_push(void)
+{
+	int idx = __this_cpu_inc_return(__kmap_local_idx) - 1;
+
+	WARN_ON_ONCE(in_irq() && !irqs_disabled());
+	BUG_ON(idx >= KM_MAX_IDX);
+	return idx;
+}
+
+static inline int kmap_local_idx(void)
+{
+	return __this_cpu_read(__kmap_local_idx) - 1;
+}
+
+static inline void kmap_local_idx_pop(void)
+{
+	int idx = __this_cpu_dec_return(__kmap_local_idx);
+
+	BUG_ON(idx < 0);
+}
+
+#ifndef arch_kmap_local_post_map
+# define arch_kmap_local_post_map(vaddr, pteval)	do { } while (0)
+#endif
+#ifndef arch_kmap_local_pre_unmap
+# define arch_kmap_local_pre_unmap(vaddr)		do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_post_unmap
+# define arch_kmap_local_post_unmap(vaddr)		do { } while (0)
+#endif
+
+#ifndef arch_kmap_local_map_idx
+#define arch_kmap_local_map_idx(idx, pfn)	kmap_local_calc_idx(idx)
+#endif
+
+#ifndef arch_kmap_local_unmap_idx
+#define arch_kmap_local_unmap_idx(idx, vaddr)	kmap_local_calc_idx(idx)
+#endif
+
+#ifndef arch_kmap_local_high_get
+static inline void *arch_kmap_local_high_get(struct page *page)
+{
+	return NULL;
+}
+#endif
+
+/* Unmap a local mapping which was obtained by kmap_high_get() */
+static inline void kmap_high_unmap_local(unsigned long vaddr)
+{
+#ifdef ARCH_NEEDS_KMAP_HIGH_GET
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP))
+		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+#endif
+}
+
+static inline int kmap_local_calc_idx(int idx)
+{
+	return idx + KM_MAX_IDX * smp_processor_id();
+}
+
+static pte_t *__kmap_pte;
+
+static pte_t *kmap_get_pte(void)
+{
+	if (!__kmap_pte)
+		__kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
+	return __kmap_pte;
+}
+
+void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
+{
+	pte_t pteval, *kmap_pte = kmap_get_pte();
+	unsigned long vaddr;
+	int idx;
+
+	preempt_disable();
+	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	BUG_ON(!pte_none(*(kmap_pte - idx)));
+	pteval = pfn_pte(pfn, prot);
+	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
+	arch_kmap_local_post_map(vaddr, pteval);
+	preempt_enable();
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
+
+void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	void *kmap;
+
+	if (!PageHighMem(page))
+		return page_address(page);
+
+	/* Try kmap_high_get() if architecture has it enabled */
+	kmap = arch_kmap_local_high_get(page);
+	if (kmap)
+		return kmap;
+
+	return __kmap_local_pfn_prot(page_to_pfn(page), prot);
+}
+EXPORT_SYMBOL(__kmap_local_page_prot);
+
+void kunmap_local_indexed(void *vaddr)
+{
+	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
+	pte_t *kmap_pte = kmap_get_pte();
+	int idx;
+
+	if (addr < __fix_to_virt(FIX_KMAP_END) ||
+	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
+		WARN_ON_ONCE(addr < PAGE_OFFSET);
+
+		/* Handle mappings which were obtained by kmap_high_get() */
+		kmap_high_unmap_local(addr);
+		return;
+	}
+
+	preempt_disable();
+	idx = arch_kmap_local_unmap_idx(kmap_local_idx(), addr);
+	WARN_ON_ONCE(addr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
+
+	arch_kmap_local_pre_unmap(addr);
+	pte_clear(&init_mm, addr, kmap_pte - idx);
+	arch_kmap_local_post_unmap(addr);
+	kmap_local_idx_pop();
+	preempt_enable();
+}
+EXPORT_SYMBOL(kunmap_local_indexed);
+#endif
 
 #if defined(HASHED_PAGE_VIRTUAL)
 

