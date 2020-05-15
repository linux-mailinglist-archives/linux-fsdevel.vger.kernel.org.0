Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CEB1D519D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 16:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgEOOjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgEOOiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 10:38:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B6C061A0C;
        Fri, 15 May 2020 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=971EDWqpKFf5KtnSgV+IM+eZfvzl2xsbTBBk8JYJJRs=; b=g89s0R8Kgf8uVzQyJkextH6Q/Q
        3CSAqPpPq/5rRHioxLVC5G5CrX6gbEhf0d5jWeeKHIrTBkpnLWpH16nuVQksuGLDyWLT/IRhamBwc
        waV8nQeWmQnN4FhEzochA2pTcvmEPJy13j8xQx0jKVxTuaGqFLLoeaVsY8+W+L8Q3wYsuO80BrFtE
        18Lcf+VLK62XazZ0K0JDMB6Sjc6nmtI0pPQHRrzLAgRd6IdCbuQDDUZflGkG23AzOjRhjR+k2ibQq
        E4+WnlXtAh9yduuNHvcYVaVqIg2IsLnXcHB2v5uvB7PdY3iFn032ftZuDjVQc++Pog8VW9fTRC1sh
        uUvFeM5Q==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbT6-0004rc-AV; Fri, 15 May 2020 14:37:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 19/29] mm: rename flush_icache_user_range to flush_icache_user_page
Date:   Fri, 15 May 2020 16:36:36 +0200
Message-Id: <20200515143646.3857579-20-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function currently known as flush_icache_user_range only operates
on a single page.  Rename it to flush_icache_user_page as we'll need
the name flush_icache_user_range for something else soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/alpha/include/asm/cacheflush.h    | 10 +++++-----
 arch/alpha/kernel/smp.c                |  2 +-
 arch/ia64/include/asm/cacheflush.h     |  2 +-
 arch/m68k/include/asm/cacheflush_mm.h  |  4 ++--
 arch/m68k/mm/cache.c                   |  2 +-
 arch/nds32/include/asm/cacheflush.h    |  4 ++--
 arch/nds32/mm/cacheflush.c             |  2 +-
 arch/openrisc/include/asm/cacheflush.h |  2 +-
 arch/powerpc/include/asm/cacheflush.h  |  4 ++--
 arch/powerpc/mm/mem.c                  |  2 +-
 arch/riscv/include/asm/cacheflush.h    |  3 ++-
 include/asm-generic/cacheflush.h       |  6 +++---
 kernel/events/uprobes.c                |  2 +-
 13 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/include/asm/cacheflush.h b/arch/alpha/include/asm/cacheflush.h
index 636d7ca0d05f6..9945ff483eaf7 100644
--- a/arch/alpha/include/asm/cacheflush.h
+++ b/arch/alpha/include/asm/cacheflush.h
@@ -35,7 +35,7 @@ extern void smp_imb(void);
 
 extern void __load_new_mm_context(struct mm_struct *);
 static inline void
-flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			unsigned long addr, int len)
 {
 	if (vma->vm_flags & VM_EXEC) {
@@ -46,16 +46,16 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 			mm->context[smp_processor_id()] = 0;
 	}
 }
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
 #else /* CONFIG_SMP */
-extern void flush_icache_user_range(struct vm_area_struct *vma,
+extern void flush_icache_user_page(struct vm_area_struct *vma,
 		struct page *page, unsigned long addr, int len);
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
 #endif /* CONFIG_SMP */
 
 /* This is used only in __do_fault and do_swap_page.  */
 #define flush_icache_page(vma, page) \
-	flush_icache_user_range((vma), (page), 0, 0)
+	flush_icache_user_page((vma), (page), 0, 0)
 
 #include <asm-generic/cacheflush.h>
 
diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 5f90df30be20a..52995bf413fea 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -740,7 +740,7 @@ ipi_flush_icache_page(void *x)
 }
 
 void
-flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			unsigned long addr, int len)
 {
 	struct mm_struct *mm = vma->vm_mm;
diff --git a/arch/ia64/include/asm/cacheflush.h b/arch/ia64/include/asm/cacheflush.h
index a8f1c86ac242a..708c0fa5d975e 100644
--- a/arch/ia64/include/asm/cacheflush.h
+++ b/arch/ia64/include/asm/cacheflush.h
@@ -22,7 +22,7 @@ extern void flush_icache_range(unsigned long start, unsigned long end);
 #define flush_icache_range flush_icache_range
 extern void clflush_cache_range(void *addr, int size);
 
-#define flush_icache_user_range(vma, page, user_addr, len)					\
+#define flush_icache_user_page(vma, page, user_addr, len)					\
 do {												\
 	unsigned long _addr = (unsigned long) page_address(page) + ((user_addr) & ~PAGE_MASK);	\
 	flush_icache_range(_addr, _addr + (len));						\
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index 1e2544ecaf88c..95376bf84faa5 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -254,7 +254,7 @@ static inline void __flush_page_to_ram(void *vaddr)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
 
-extern void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+extern void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 				    unsigned long addr, int len);
 extern void flush_icache_range(unsigned long address, unsigned long endaddr);
 
@@ -264,7 +264,7 @@ static inline void copy_to_user_page(struct vm_area_struct *vma,
 {
 	flush_cache_page(vma, vaddr, page_to_pfn(page));
 	memcpy(dst, src, len);
-	flush_icache_user_range(vma, page, vaddr, len);
+	flush_icache_user_page(vma, page, vaddr, len);
 }
 static inline void copy_from_user_page(struct vm_area_struct *vma,
 				       struct page *page, unsigned long vaddr,
diff --git a/arch/m68k/mm/cache.c b/arch/m68k/mm/cache.c
index 079e64898e6a5..99057cd5ff7f1 100644
--- a/arch/m68k/mm/cache.c
+++ b/arch/m68k/mm/cache.c
@@ -106,7 +106,7 @@ void flush_icache_range(unsigned long address, unsigned long endaddr)
 }
 EXPORT_SYMBOL(flush_icache_range);
 
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			     unsigned long addr, int len)
 {
 	if (CPU_IS_COLDFIRE) {
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index caddded56e77f..7d6824f7c0e8d 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -44,9 +44,9 @@ void invalidate_kernel_vmap_range(void *addr, int size);
 #define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
 
 #else
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 	                     unsigned long addr, int len);
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
 
 #include <asm-generic/cacheflush.h>
 #endif
diff --git a/arch/nds32/mm/cacheflush.c b/arch/nds32/mm/cacheflush.c
index 8f168b33065fa..6eb98a7ad27d2 100644
--- a/arch/nds32/mm/cacheflush.c
+++ b/arch/nds32/mm/cacheflush.c
@@ -36,7 +36,7 @@ void flush_icache_page(struct vm_area_struct *vma, struct page *page)
 	local_irq_restore(flags);
 }
 
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 	                     unsigned long addr, int len)
 {
 	unsigned long kaddr;
diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
index 74d1fce4e8839..eeac40d4a8547 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -62,7 +62,7 @@ static inline void flush_dcache_page(struct page *page)
 	clear_bit(PG_dc_clean, &page->flags);
 }
 
-#define flush_icache_user_range(vma, page, addr, len)	\
+#define flush_icache_user_page(vma, page, addr, len)	\
 do {							\
 	if (vma->vm_flags & VM_EXEC)			\
 		sync_icache_dcache(page);		\
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index e682c8e10e903..de600b915a3c5 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -28,9 +28,9 @@ extern void flush_dcache_page(struct page *page);
 void flush_icache_range(unsigned long start, unsigned long stop);
 #define flush_icache_range flush_icache_range
 
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 		unsigned long addr, int len);
-#define flush_icache_user_range flush_icache_user_range
+#define flush_icache_user_page flush_icache_user_page
 
 void flush_dcache_icache_page(struct page *page);
 void __flush_dcache_icache(void *page);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f0d1bf0a8e14f..d1ad0b9b19281 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -578,7 +578,7 @@ void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
 	flush_dcache_page(pg);
 }
 
-void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
+void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			     unsigned long addr, int len)
 {
 	unsigned long maddr;
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index a167b4fbdf007..23ff703509926 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -27,7 +27,8 @@ static inline void flush_dcache_page(struct page *page)
  * so instead we just flush the whole thing.
  */
 #define flush_icache_range(start, end) flush_icache_all()
-#define flush_icache_user_range(vma, pg, addr, len) flush_icache_mm(vma->vm_mm, 0)
+#define flush_icache_user_page(vma, pg, addr, len) \
+	flush_icache_mm(vma->vm_mm, 0)
 
 #ifndef CONFIG_SMP
 
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index bbbb4d4ef6516..2c9686fefb715 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -73,8 +73,8 @@ static inline void flush_icache_page(struct vm_area_struct *vma,
 }
 #endif
 
-#ifndef flush_icache_user_range
-static inline void flush_icache_user_range(struct vm_area_struct *vma,
+#ifndef flush_icache_user_page
+static inline void flush_icache_user_page(struct vm_area_struct *vma,
 					   struct page *page,
 					   unsigned long addr, int len)
 {
@@ -97,7 +97,7 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 #define copy_to_user_page(vma, page, vaddr, dst, src, len)	\
 	do { \
 		memcpy(dst, src, len); \
-		flush_icache_user_range(vma, page, vaddr, len); \
+		flush_icache_user_page(vma, page, vaddr, len); \
 	} while (0)
 #endif
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4ac..2e5effbda86b0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1674,7 +1674,7 @@ void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	copy_to_page(page, vaddr, src, len);
 
 	/*
-	 * We probably need flush_icache_user_range() but it needs vma.
+	 * We probably need flush_icache_user_page() but it needs vma.
 	 * This should work on most of architectures by default. If
 	 * architecture needs to do something different it can define
 	 * its own version of the function.
-- 
2.26.2

