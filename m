Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25047452B16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 07:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbhKPGky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 01:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhKPGkj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:40:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC568C061766;
        Mon, 15 Nov 2021 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S/CnjLRmgrSJADzeSbJCuEHmdmqJFE1veuDvGJX4T0w=; b=liU1ijFWSLfKahYQGg2gMlonlg
        Bg7Rint2QOON83r70iUvpcTYk6ZZidEU2FvzFtr2hG9LYfdOceXdjlbOGv8cswIjaWg3CoUBkUgAO
        lWQReuAm9M/kdt8Iysm3EX/HmxRblzBwnarqHkzV/mVYcpUhS70o/SQFQVOGcsik20hTGpqlkO7ob
        Y0pToIKtTdiVxsZAnyiDY9DNHiMm41JV3k/b6Gez3tJFTqAQ09y9/wa3zZDLQFgqeKKfr+wYoR0/8
        LrKOzfKpwPayVkSNF6m88QTZ5sg9dCybVrgm5i9SgAy40EM+SIE2v1x5CMvM4iPUyHr0BFU5rGViR
        rRi6yiyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mms1d-000Qnz-6c; Tue, 16 Nov 2021 06:33:01 +0000
Date:   Mon, 15 Nov 2021 22:33:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 01/28] csky,sparc: Declare flush_dcache_folio()
Message-ID: <YZNQnd887/TcPH7H@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-2-willy@infradead.org>
 <YYozKaEXemjKwEar@infradead.org>
 <YZKCx1cwBXOZcTA4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZKCx1cwBXOZcTA4@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 03:54:47PM +0000, Matthew Wilcox wrote:
> There are three ways to implement flush_dcache_folio().  The first is
> as a noop (this is what xtensa does, which is the only architecture
> to define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO; it's also done
> automatically by asm-generic if the architecture doesn't define
> ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE).  The second is as a loop which calls
> flush_dcache_page() for each page in the folio.  That's the default
> implementation which you found in mm/util.c.  The third way, which I
> hope architecture maintainers actually implement, is to just set the
> needs-flush bit on the head page.  But that requires knowledge of each
> architecture; they need to check the needs-flush bit on the head page
> instead of the precise page.  So I've done the safe, slow thing for
> all architectures.  The only reason that csky and sparc are "special"
> is that they don't include asm-generic/cacheflush.h and the buildbots
> didn't catch that before the merge window.
> 
> I'm doing the exact same thing for csky and sparc that I did for
> arc/arm/m68k/mips/nds32/nios2/parisc/sh.  Nothing more, nothing less.

I see how this works no, but it is pretty horrible.  Why not something
simple like the patch below?  If/when an architecture actually
wants to override flush_dcache_folio we can find out how to best do
it:

diff --git a/arch/arc/include/asm/cacheflush.h b/arch/arc/include/asm/cacheflush.h
index e8c2c7469e107..e201b4b1655af 100644
--- a/arch/arc/include/asm/cacheflush.h
+++ b/arch/arc/include/asm/cacheflush.h
@@ -36,7 +36,6 @@ void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 
 void dma_cache_wback_inv(phys_addr_t start, unsigned long sz);
 void dma_cache_inv(phys_addr_t start, unsigned long sz);
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index e68fb879e4f9d..5e56288e343bb 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -290,7 +290,6 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  */
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
-void flush_dcache_folio(struct folio *folio);
 
 #define ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE 1
 static inline void flush_kernel_vmap_range(void *addr, int size)
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index 432aef1f1dc23..ed62e2066ba76 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -9,7 +9,6 @@
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
-void flush_dcache_folio(struct folio *folio);
 
 #define flush_cache_mm(mm)			dcache_wbinv_all()
 #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index 7e8bef60958c6..a565e00c3f70b 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -25,8 +25,6 @@ static inline void flush_dcache_page(struct page *page)
 		clear_bit(PG_dcache_clean, &page->flags);
 }
 
-void flush_dcache_folio(struct folio *folio);
-
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)		do { } while (0)
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index 8ab46625ddd32..1ac55e7b47f01 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -250,7 +250,6 @@ static inline void __flush_page_to_ram(void *vaddr)
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 #define flush_dcache_page(page)		__flush_page_to_ram(page_address(page))
-void flush_dcache_folio(struct folio *folio);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index f207388541d50..b3dc9c589442a 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -61,8 +61,6 @@ static inline void flush_dcache_page(struct page *page)
 		SetPageDcacheDirty(page);
 }
 
-void flush_dcache_folio(struct folio *folio);
-
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 3fc0bb7d6487c..c2a222ebfa2af 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -27,7 +27,6 @@ void flush_cache_vunmap(unsigned long start, unsigned long end);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long vaddr, void *dst, void *src, int len);
 void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
index 1999561b22aa5..d0b71dd712872 100644
--- a/arch/nios2/include/asm/cacheflush.h
+++ b/arch/nios2/include/asm/cacheflush.h
@@ -29,7 +29,6 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long vmaddr,
 	unsigned long pfn);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 
 extern void flush_icache_range(unsigned long start, unsigned long end);
 extern void flush_icache_page(struct vm_area_struct *vma, struct page *page);
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index da0cd4b3a28f2..859b8a34adcfb 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -50,7 +50,6 @@ void invalidate_kernel_vmap_range(void *vaddr, int size);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index c7a97f32432fb..481a664287e2e 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -43,7 +43,6 @@ extern void flush_cache_range(struct vm_area_struct *vma,
 				 unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 extern void flush_icache_range(unsigned long start, unsigned long end);
 #define flush_icache_user_range flush_icache_range
 extern void flush_icache_page(struct vm_area_struct *vma,
diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 9991c18f4980c..41c6d734a4741 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -37,7 +37,6 @@
 
 void sparc_flush_page_to_ram(struct page *page);
 
-void flush_dcache_folio(struct folio *folio);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 #define flush_dcache_page(page)			sparc_flush_page_to_ram(page)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index 9ab59a73c28b1..b9341836597ec 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -47,7 +47,6 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
 void __flush_dcache_range(unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 
 #define flush_icache_page(vma, pg)	do { } while(0)
 
diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index a8a041609c5d0..7b4359312c257 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -121,7 +121,6 @@ void flush_cache_page(struct vm_area_struct*,
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *);
-void flush_dcache_folio(struct folio *);
 
 void local_flush_cache_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end);
@@ -138,9 +137,7 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 #define flush_cache_vunmap(start,end)			do { } while (0)
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
 #define flush_dcache_page(page)				do { } while (0)
-static inline void flush_dcache_folio(struct folio *folio) { }
 
 #define flush_icache_range local_flush_icache_range
 #define flush_cache_page(vma, addr, pfn)		do { } while (0)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 265c7f8e71342..218df77641802 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2016-2019 Christoph Hellwig.
  */
 #include <linux/module.h>
+#include <linux/cacheflush.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
 #include <linux/iomap.h>
@@ -658,6 +659,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
+
 	flush_dcache_folio(folio);
 
 	/*
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index fedc0dfa4877c..eeaea7bd97bbf 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -49,14 +49,7 @@ static inline void flush_cache_page(struct vm_area_struct *vma,
 static inline void flush_dcache_page(struct page *page)
 {
 }
-
-static inline void flush_dcache_folio(struct folio *folio) { }
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
-#endif
-
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
-void flush_dcache_folio(struct folio *folio);
 #endif
 
 #ifndef flush_dcache_mmap_lock
diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
new file mode 100644
index 0000000000000..c28359bac8aa5
--- /dev/null
+++ b/include/linux/cacheflush.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CACHEFLUSH_H
+#define _LINUX_CACHEFLUSH_H
+
+#include <asm/cacheflush.h>
+
+#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+void flush_dcache_folio(struct folio *folio);
+#else
+static inline void flush_dcache_folio(struct folio *folio)
+{
+}
+#endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
+
+#endif /* _LINUX_CACHEFLUSH_H */
diff --git a/mm/util.c b/mm/util.c
index e58151a612555..61ffa71adb644 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1090,7 +1090,7 @@ void page_offline_end(void)
 }
 EXPORT_SYMBOL(page_offline_end);
 
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
 void flush_dcache_folio(struct folio *folio)
 {
 	long i, nr = folio_nr_pages(folio);
@@ -1098,5 +1098,4 @@ void flush_dcache_folio(struct folio *folio)
 	for (i = 0; i < nr; i++)
 		flush_dcache_page(folio_page(folio, i));
 }
-EXPORT_SYMBOL(flush_dcache_folio);
 #endif
