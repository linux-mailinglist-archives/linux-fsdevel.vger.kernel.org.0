Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D517D2A4306
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgKCKgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:36:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbgKCKdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:51 -0500
Message-Id: <20201103095858.516281567@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dYx1Yl6wgjFDzL4d7wpy+MQ/ca4VbI4dshzY4C94zCg=;
        b=4QvDGqKVKPFjYTZiH7xhv8zBsxgNw5ucuOWpbKZ18rMtaNCpT4m1fIgg7d42Pf4ttY8gnQ
        j6STlpHNZtb54KQolCEvAOtfIBn6Zvac5eoLzhR1q+EBZQKhuxC69WReFFoUfX3tPRPCts
        2HTD6Fl5QJuJ5QyiXhkDQiJfASqZgrTfuQJiZK0MqskHi6zDD6EHlpfZpwHaxGhXXwPr9X
        Vb4k2kb3SczzsSlpmpaZ3L8Dy/cZbHaEz0VgKRZkMQL3dGerZvWCuwHHNLPkfinWQIFB0j
        gsmyZDxZFqomNDAg2jzR8z96x8DEnYsbXhV7JtsOk/xYyutDKygozbXhq2uhKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dYx1Yl6wgjFDzL4d7wpy+MQ/ca4VbI4dshzY4C94zCg=;
        b=nHEOgyol8j2FfkUQAHNBZiJ0Vnv+JbHd05D8vSpMEVgHoPEClg1kXmC2+PGwuxytijKdb7
        OO86HAY7UU5tfdBw==
Date:   Tue, 03 Nov 2020 10:27:31 +0100
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
Subject: [patch V3 19/37] mm/highmem: Remove the old kmap_atomic cruft
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All users gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/highmem.h |   63 +++---------------------------------------------
 mm/highmem.c            |    7 -----
 2 files changed, 5 insertions(+), 65 deletions(-)

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -86,31 +86,16 @@ static inline void kunmap(struct page *p
  * be used in IRQ contexts, so in some (very limited) cases we need
  * it.
  */
-
-#ifndef CONFIG_KMAP_LOCAL
-void *kmap_atomic_high_prot(struct page *page, pgprot_t prot);
-void kunmap_atomic_high(void *kvaddr);
-
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	preempt_disable();
 	pagefault_disable();
-	if (!PageHighMem(page))
-		return page_address(page);
-	return kmap_atomic_high_prot(page, prot);
-}
-
-static inline void __kunmap_atomic(void *vaddr)
-{
-	kunmap_atomic_high(vaddr);
+	return __kmap_local_page_prot(page, prot);
 }
-#else /* !CONFIG_KMAP_LOCAL */
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic(struct page *page)
 {
-	preempt_disable();
-	pagefault_disable();
-	return __kmap_local_page_prot(page, prot);
+	return kmap_atomic_prot(page, kmap_prot);
 }
 
 static inline void *kmap_atomic_pfn(unsigned long pfn)
@@ -125,13 +110,6 @@ static inline void __kunmap_atomic(void
 	kunmap_local_indexed(addr);
 }
 
-#endif /* CONFIG_KMAP_LOCAL */
-
-static inline void *kmap_atomic(struct page *page)
-{
-	return kmap_atomic_prot(page, kmap_prot);
-}
-
 /* declarations for linux/mm/highmem.c */
 unsigned int nr_free_highpages(void);
 extern atomic_long_t _totalhigh_pages;
@@ -212,41 +190,8 @@ static inline void __kunmap_atomic(void
 
 #define kmap_flush_unused()	do {} while(0)
 
-#endif /* CONFIG_HIGHMEM */
-
-#if !defined(CONFIG_KMAP_LOCAL)
-#if defined(CONFIG_HIGHMEM)
-
-DECLARE_PER_CPU(int, __kmap_atomic_idx);
-
-static inline int kmap_atomic_idx_push(void)
-{
-	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_TYPE_NR);
-#endif
-	return idx;
-}
-
-static inline int kmap_atomic_idx(void)
-{
-	return __this_cpu_read(__kmap_atomic_idx) - 1;
-}
 
-static inline void kmap_atomic_idx_pop(void)
-{
-#ifdef CONFIG_DEBUG_HIGHMEM
-	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
-
-	BUG_ON(idx < 0);
-#else
-	__this_cpu_dec(__kmap_atomic_idx);
-#endif
-}
-#endif
-#endif
+#endif /* CONFIG_HIGHMEM */
 
 /*
  * Prevent people trying to call kunmap_atomic() as if it were kunmap()
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -31,12 +31,6 @@
 #include <asm/tlbflush.h>
 #include <linux/vmalloc.h>
 
-#ifndef CONFIG_KMAP_LOCAL
-#ifdef CONFIG_HIGHMEM
-DEFINE_PER_CPU(int, __kmap_atomic_idx);
-#endif
-#endif
-
 /*
  * Virtual_count is not a pure "count".
  *  0 means that it is not mapped, and has not been mapped
@@ -410,6 +404,7 @@ static inline void kmap_local_idx_pop(vo
 #ifndef arch_kmap_local_post_map
 # define arch_kmap_local_post_map(vaddr, pteval)	do { } while (0)
 #endif
+
 #ifndef arch_kmap_local_pre_unmap
 # define arch_kmap_local_pre_unmap(vaddr)		do { } while (0)
 #endif

