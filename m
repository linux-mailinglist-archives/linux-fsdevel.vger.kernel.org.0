Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0162A4243
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgKCKdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:33:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37666 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgKCKdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:42 -0500
Message-Id: <20201103095857.885321106@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kIU8mE8cIMxt7HdcaYjAxqCl6OgglnUDNaPoJJkieik=;
        b=3vRHayQH6aMh+hAkR5udU6nvhLSigt/vofHCpg28n6tJ7ncJLkKSX/+B0fY+KHlPQTxHBM
        Z5oZvM1+yr17K88jGTZjKl9HfvKiw5paOIqhEJXDcaTQ4spL/1kJpkm2339FbE+6JNWLTR
        MeHd6e0o23EHfV6kEyc2kAqbqhhCVgio8/SYL5GgFQrlW7kRDNJZxtjYUqpBu01I4JlaOq
        5fiMSnibVKdZD3iEI+V5SnV+lSsoiI36LHud/O3JrZkiIg1+L2hMYbBu0B1D2NifwMJIfQ
        0x4GMxcIJdc3/yItQhHmHiZQAIXkRAwQZd4p0ANPvVTseAqvd3AGpoALeG6IiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kIU8mE8cIMxt7HdcaYjAxqCl6OgglnUDNaPoJJkieik=;
        b=cMpwA14tnMdsPseMKHpm31g8L4mhbGqu6Qa8dh2fFxqo+adO15rx0TWaTsfp9yg3/fl1iJ
        gOg1e1DIUFkpsICQ==
Date:   Tue, 03 Nov 2020 10:27:25 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
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
        Nick Hu <nickhu@andestech.com>,
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
Subject: [patch V3 13/37] mips/mm/highmem: Switch to generic kmap atomic
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No reason having the same code in every architecture

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
V3: Remove the kmap types cruft
---
 arch/mips/Kconfig                  |    1 
 arch/mips/include/asm/fixmap.h     |    4 -
 arch/mips/include/asm/highmem.h    |    6 +-
 arch/mips/include/asm/kmap_types.h |   13 ------
 arch/mips/mm/highmem.c             |   77 -------------------------------------
 arch/mips/mm/init.c                |    4 -
 6 files changed, 6 insertions(+), 99 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2719,6 +2719,7 @@ config WAR_MIPS34K_MISSED_ITLB
 config HIGHMEM
 	bool "High Memory Support"
 	depends on 32BIT && CPU_SUPPORTS_HIGHMEM && SYS_SUPPORTS_HIGHMEM && !CPU_MIPS32_3_5_EVA
+	select KMAP_LOCAL
 
 config CPU_SUPPORTS_HIGHMEM
 	bool
--- a/arch/mips/include/asm/fixmap.h
+++ b/arch/mips/include/asm/fixmap.h
@@ -17,7 +17,7 @@
 #include <spaces.h>
 #ifdef CONFIG_HIGHMEM
 #include <linux/threads.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 #endif
 
 /*
@@ -52,7 +52,7 @@ enum fixed_addresses {
 #ifdef CONFIG_HIGHMEM
 	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_BEGIN = FIX_CMAP_END + 1,
-	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #endif
 	__end_of_fixed_addresses
 };
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
 #include <asm/cpu-features.h>
-#include <asm/kmap_types.h>
+#include <asm/kmap_size.h>
 
 /* declarations for highmem.c */
 extern unsigned long highstart_pfn, highend_pfn;
@@ -48,11 +48,11 @@ extern pte_t *pkmap_page_table;
 
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
-extern void *kmap_atomic_pfn(unsigned long pfn);
 
 #define flush_cache_kmaps()	BUG_ON(cpu_has_dc_aliases)
 
-extern void kmap_init(void);
+#define arch_kmap_local_post_map(vaddr, pteval)	local_flush_tlb_one(vaddr)
+#define arch_kmap_local_post_unmap(vaddr)	local_flush_tlb_one(vaddr)
 
 #endif /* __KERNEL__ */
 
--- a/arch/mips/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define	 __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -8,8 +8,6 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
-static pte_t *kmap_pte;
-
 unsigned long highstart_pfn, highend_pfn;
 
 void kmap_flush_tlb(unsigned long addr)
@@ -17,78 +15,3 @@ void kmap_flush_tlb(unsigned long addr)
 	flush_tlb_one(addr);
 }
 EXPORT_SYMBOL(kmap_flush_tlb);
-
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-#ifdef CONFIG_DEBUG_HIGHMEM
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
-#endif
-	set_pte(kmap_pte-idx, mk_pte(page, prot));
-	local_flush_tlb_one((unsigned long)vaddr);
-
-	return (void*) vaddr;
-}
-EXPORT_SYMBOL(kmap_atomic_high_prot);
-
-void kunmap_atomic_high(void *kvaddr)
-{
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	int type __maybe_unused;
-
-	if (vaddr < FIXADDR_START)
-		return;
-
-	type = kmap_atomic_idx();
-#ifdef CONFIG_DEBUG_HIGHMEM
-	{
-		int idx = type + KM_TYPE_NR * smp_processor_id();
-
-		BUG_ON(vaddr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
-
-		/*
-		 * force other mappings to Oops if they'll try to access
-		 * this pte without first remap it
-		 */
-		pte_clear(&init_mm, vaddr, kmap_pte-idx);
-		local_flush_tlb_one(vaddr);
-	}
-#endif
-	kmap_atomic_idx_pop();
-}
-EXPORT_SYMBOL(kunmap_atomic_high);
-
-/*
- * This is the same as kmap_atomic() but can map memory that doesn't
- * have a struct page associated with it.
- */
-void *kmap_atomic_pfn(unsigned long pfn)
-{
-	unsigned long vaddr;
-	int idx, type;
-
-	preempt_disable();
-	pagefault_disable();
-
-	type = kmap_atomic_idx_push();
-	idx = type + KM_TYPE_NR*smp_processor_id();
-	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	set_pte(kmap_pte-idx, pfn_pte(pfn, PAGE_KERNEL));
-	flush_tlb_one(vaddr);
-
-	return (void*) vaddr;
-}
-
-void __init kmap_init(void)
-{
-	unsigned long kmap_vstart;
-
-	/* cache the first kmap pte */
-	kmap_vstart = __fix_to_virt(FIX_KMAP_BEGIN);
-	kmap_pte = virt_to_kpte(kmap_vstart);
-}
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -36,7 +36,6 @@
 #include <asm/cachectl.h>
 #include <asm/cpu.h>
 #include <asm/dma.h>
-#include <asm/kmap_types.h>
 #include <asm/maar.h>
 #include <asm/mmu_context.h>
 #include <asm/sections.h>
@@ -402,9 +401,6 @@ void __init paging_init(void)
 
 	pagetable_init();
 
-#ifdef CONFIG_HIGHMEM
-	kmap_init();
-#endif
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
 #endif

