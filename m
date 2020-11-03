Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8012A4265
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgKCKeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:34:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgKCKeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:34:01 -0500
Message-Id: <20201103095859.132846644@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KHv8YrvJ4tkhO+6KhBO6Ws+mj44XOrWxRR2MIQ6sqkY=;
        b=Jq8gfXxChBjZhD3AOqdMUe01tZh/sJo2B79/wRerMfFXNzYc3FxlQqqhhWoKEyzEnavpy/
        c4I7i4J0s2yg5HNqyEFRyaIIbznGLkA5r+MV4j55el4mWnym900Xp7OjCTsnXkI0TsIxEg
        EV0trFCr23UgNTh5IjbkxjnrZQJOsGoLS1AFtDB3rcgXWHs8wC80JGgogftibxEdTV2en9
        X0dOUqavXqBu7ZXvusmu+7uRS8uvIrOdGhzOc55o28oi/z4lvDPSQnWVXFWgcnZCoxznDK
        +F1J4liAs4f0IbdUne8kTrdI0J0UDDt2IlHgcmZmybJVT+/K5kkkviDLwQCeWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KHv8YrvJ4tkhO+6KhBO6Ws+mj44XOrWxRR2MIQ6sqkY=;
        b=hHhfjzsH/LuWLCxgzabqCGZa+/JVJg4HWhAgqhFWQ0YxJy2t0XpS0Q2KnfH0QQr7mvyj21
        yS0QhwZxRNWSG3CA==
Date:   Tue, 03 Nov 2020 10:27:37 +0100
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
Subject: [patch V3 25/37] mm/highmem: Provide kmap_local*
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the kmap atomic index is stored in task struct provide a
preemptible variant. On context switch the maps of an outgoing task are
removed and the map of the incoming task are restored. That's obviously
slow, but highmem is slow anyway.

The kmap_local.*() functions can be invoked from both preemptible and
atomic context. kmap local sections disable migration to keep the resulting
virtual mapping address correct, but disable neither pagefaults nor
preemption.

A wholesale conversion of kmap_atomic to be fully preemptible is not
possible because some of the usage sites might rely on the preemption
disable for serialization or on the implicit pagefault disable. Needs to be
done on a case by case basis.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Move migrate disable into the actual highmem mapping code so it only
    affects real highmem mappings.
   
V2: Make it more consistent and add commentry
---
 include/linux/highmem-internal.h |   48 +++++++++++++++++++++++++++++++++++++++
 include/linux/highmem.h          |   43 +++++++++++++++++++++-------------
 mm/highmem.c                     |    6 ++++
 3 files changed, 81 insertions(+), 16 deletions(-)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -69,6 +69,26 @@ static inline void kmap_flush_unused(voi
 	__kmap_flush_unused();
 }
 
+static inline void *kmap_local_page(struct page *page)
+{
+	return __kmap_local_page_prot(page, kmap_prot);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return __kmap_local_page_prot(page, prot);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return __kmap_local_pfn_prot(pfn, kmap_prot);
+}
+
+static inline void __kunmap_local(void *vaddr)
+{
+	kunmap_local_indexed(vaddr);
+}
+
 static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
 {
 	preempt_disable();
@@ -141,6 +161,28 @@ static inline void kunmap(struct page *p
 #endif
 }
 
+static inline void *kmap_local_page(struct page *page)
+{
+	return page_address(page);
+}
+
+static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
+{
+	return kmap_local_page(page);
+}
+
+static inline void *kmap_local_pfn(unsigned long pfn)
+{
+	return kmap_local_page(pfn_to_page(pfn));
+}
+
+static inline void __kunmap_local(void *addr)
+{
+#ifdef ARCH_HAS_FLUSH_ON_KUNMAP
+	kunmap_flush_on_unmap(addr);
+#endif
+}
+
 static inline void *kmap_atomic(struct page *page)
 {
 	preempt_disable();
@@ -182,4 +224,10 @@ do {								\
 	__kunmap_atomic(__addr);				\
 } while (0)
 
+#define kunmap_local(__addr)					\
+do {								\
+	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
+	__kunmap_local(__addr);					\
+} while (0)
+
 #endif
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -60,24 +60,22 @@ static inline struct page *kmap_to_page(
 static inline void kmap_flush_unused(void);
 
 /**
- * kmap_atomic - Atomically map a page for temporary usage
+ * kmap_local_page - Map a page for temporary usage
  * @page:	Pointer to the page to be mapped
  *
  * Returns: The virtual address of the mapping
  *
- * Side effect: On return pagefaults and preemption are disabled.
- *
  * Can be invoked from any context.
  *
  * Requires careful handling when nesting multiple mappings because the map
  * management is stack based. The unmap has to be in the reverse order of
  * the map operation:
  *
- * addr1 = kmap_atomic(page1);
- * addr2 = kmap_atomic(page2);
+ * addr1 = kmap_local_page(page1);
+ * addr2 = kmap_local_page(page2);
  * ...
- * kunmap_atomic(addr2);
- * kunmap_atomic(addr1);
+ * kunmap_local(addr2);
+ * kunmap_local(addr1);
  *
  * Unmapping addr1 before addr2 is invalid and causes malfunction.
  *
@@ -88,10 +86,26 @@ static inline void kmap_flush_unused(voi
  * virtual address of the direct mapping. Only real highmem pages are
  * temporarily mapped.
  *
- * While it is significantly faster than kmap() it comes with restrictions
- * about the pointer validity and the side effects of disabling page faults
- * and preemption. Use it only when absolutely necessary, e.g. from non
- * preemptible contexts.
+ * While it is significantly faster than kmap() for the higmem case it
+ * comes with restrictions about the pointer validity. Only use when really
+ * necessary.
+ *
+ * On HIGHMEM enabled systems mapping a highmem page has the side effect of
+ * disabling migration in order to keep the virtual address stable across
+ * preemption. No caller of kmap_local_page() can rely on this side effect.
+ */
+static inline void *kmap_local_page(struct page *page);
+
+/**
+ * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
+ * @page:	Pointer to the page to be mapped
+ *
+ * Returns: The virtual address of the mapping
+ *
+ * Effectively a wrapper around kmap_local_page() which disables pagefaults
+ * and preemption.
+ *
+ * Do not use in new code. Use kmap_local_page() instead.
  */
 static inline void *kmap_atomic(struct page *page);
 
@@ -101,12 +115,9 @@ static inline void *kmap_atomic(struct p
  *
  * Counterpart to kmap_atomic().
  *
- * Undoes the side effects of kmap_atomic(), i.e. reenabling pagefaults and
+ * Effectively a wrapper around kunmap_local() which additionally undoes
+ * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
  * preemption.
- *
- * Other than that a NOOP for CONFIG_HIGHMEM=n and for mappings of pages
- * in the low memory area. For real highmen pages the mapping which was
- * established with kmap_atomic() is destroyed.
  */
 
 /* Highmem related interfaces for management code */
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -450,6 +450,11 @@ void *__kmap_local_pfn_prot(unsigned lon
 	unsigned long vaddr;
 	int idx;
 
+	/*
+	 * Disable migration so resulting virtual address is stable
+	 * accross preemption.
+	 */
+	migrate_disable();
 	preempt_disable();
 	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
@@ -505,6 +510,7 @@ void kunmap_local_indexed(void *vaddr)
 	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
 	kmap_local_idx_pop();
 	preempt_enable();
+	migrate_enable();
 }
 EXPORT_SYMBOL(kunmap_local_indexed);
 

