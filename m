Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCC453BE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 22:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhKPVwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 16:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhKPVwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:52:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1A7C061570;
        Tue, 16 Nov 2021 13:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k0Jx0lZyit7GgPrACTRTUTWqBfozWFKayPWsmq2Q7SE=; b=bTbEQGuhgQlVmg8K1YPfgdWw8x
        UU8njoCUZjUfiiKlIGUUZYtdoh2E63f7g6j438M7juZsSk9T+jP3Ge0YB3JRUDTnQzps4v/wbioqe
        4zlNObPDfXHx0sndZ955cE6WyNC9ke4+tyj1EWkhUYU36pFpyGM6nHZ1GtdkI3XnbHOlGTAZkoZal
        af88UWhF7xls9oUCTE1JWG3868Kh3CiinBICXKxyoATxXlUIiQDqeqvSEoxwVzDpJrQSsy4k0c4kN
        lScTCcw6gkJdJtvRmNfr+Wu8MFn3lG22dlBlxA+lPLMOpJYyw5MmcF8VfG/ghMYmDjRoDUMuYAZPz
        8Y6Aoaig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mn6KH-00775n-VM; Tue, 16 Nov 2021 21:49:14 +0000
Date:   Tue, 16 Nov 2021 21:49:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong " <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 01/28] csky,sparc: Declare flush_dcache_folio()
Message-ID: <YZQnWU9ABBlXJKa5@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-2-willy@infradead.org>
 <YYozKaEXemjKwEar@infradead.org>
 <YZKCx1cwBXOZcTA4@casper.infradead.org>
 <YZNQnd887/TcPH7H@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZNQnd887/TcPH7H@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:33:01PM -0800, Christoph Hellwig wrote:
> I see how this works no, but it is pretty horrible.  Why not something
> simple like the patch below?  If/when an architecture actually
> wants to override flush_dcache_folio we can find out how to best do
> it:

I'll stick this one into -next and see if anything blows up:

From 14f55de74c68a3eb058cfdbf81414148b9bdaac7 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Sat, 6 Nov 2021 17:13:35 -0400
Subject: [PATCH] Add linux/cacheflush.h

Many architectures do not include asm-generic/cacheflush.h, so turn
the includes on their head and add linux/cacheflush.h which includes
asm/cacheflush.h.

Move the flush_dcache_folio() declaration from asm-generic/cacheflush.h
to linux/cacheflush.h and change linux/highmem.h to include
linux/cacheflush.h instead of asm/cacheflush.h so that all necessary
places will see flush_dcache_folio().

More functions should have their default implementations moved in the
future, but those are for follow-on patches.  This fixes csky, sparc and
sparc64 which were missed in the commit which added flush_dcache_folio().

Fixes: 08b0b0059bf1 ("mm: Add flush_dcache_folio()")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arc/include/asm/cacheflush.h     |  1 -
 arch/arm/include/asm/cacheflush.h     |  1 -
 arch/m68k/include/asm/cacheflush_mm.h |  1 -
 arch/mips/include/asm/cacheflush.h    |  2 --
 arch/nds32/include/asm/cacheflush.h   |  1 -
 arch/nios2/include/asm/cacheflush.h   |  1 -
 arch/parisc/include/asm/cacheflush.h  |  1 -
 arch/sh/include/asm/cacheflush.h      |  1 -
 arch/xtensa/include/asm/cacheflush.h  |  3 ---
 include/asm-generic/cacheflush.h      |  6 ------
 include/linux/cacheflush.h            | 18 ++++++++++++++++++
 include/linux/highmem.h               |  3 +--
 12 files changed, 19 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/cacheflush.h

diff --git a/arch/arc/include/asm/cacheflush.h b/arch/arc/include/asm/cacheflush.h
index e8c2c7469e10..e201b4b1655a 100644
--- a/arch/arc/include/asm/cacheflush.h
+++ b/arch/arc/include/asm/cacheflush.h
@@ -36,7 +36,6 @@ void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 
 void dma_cache_wback_inv(phys_addr_t start, unsigned long sz);
 void dma_cache_inv(phys_addr_t start, unsigned long sz);
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index e68fb879e4f9..5e56288e343b 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -290,7 +290,6 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
  */
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
-void flush_dcache_folio(struct folio *folio);
 
 #define ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE 1
 static inline void flush_kernel_vmap_range(void *addr, int size)
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index 8ab46625ddd3..1ac55e7b47f0 100644
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
index f207388541d5..b3dc9c589442 100644
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
index 3fc0bb7d6487..c2a222ebfa2a 100644
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
index 1999561b22aa..d0b71dd71287 100644
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
index da0cd4b3a28f..859b8a34adcf 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -50,7 +50,6 @@ void invalidate_kernel_vmap_range(void *vaddr, int size);
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
-void flush_dcache_folio(struct folio *folio);
 
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index c7a97f32432f..481a664287e2 100644
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
diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index a8a041609c5d..7b4359312c25 100644
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
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index fedc0dfa4877..4f07afacbc23 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -50,13 +50,7 @@ static inline void flush_dcache_page(struct page *page)
 {
 }
 
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
index 000000000000..fef8b607f97e
--- /dev/null
+++ b/include/linux/cacheflush.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CACHEFLUSH_H
+#define _LINUX_CACHEFLUSH_H
+
+#include <asm/cacheflush.h>
+
+#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+void flush_dcache_folio(struct folio *folio);
+#endif
+#else
+static inline void flush_dcache_folio(struct folio *folio)
+{
+}
+#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO 0
+#endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
+
+#endif /* _LINUX_CACHEFLUSH_H */
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 25aff0f2ed0b..c944b3b70ee7 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -5,12 +5,11 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/cacheflush.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/hardirq.h>
 
-#include <asm/cacheflush.h>
-
 #include "highmem-internal.h"
 
 /**
-- 
2.33.0

