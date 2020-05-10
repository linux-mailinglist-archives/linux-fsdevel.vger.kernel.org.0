Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2231CC814
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgEJH4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgEJH4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:56:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A31C061A0C;
        Sun, 10 May 2020 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0vCVbab8LqnKZMFTDjGS9z17LyCubzzTTEgfa/2l87E=; b=rAiC/Hd8WPxcdGaIK+YBLYo+Go
        2gdb6jgo+qIX00NX0gZ0E+3b3c5nv/Dy3HV4HYwpBO687h4Jo4Ltc0/42GPCymSSypI+qfueG7jRN
        EjPY1/bZA2gpsMgGxph2x0ffB30PGYC9WDHVgo5V8UbC6iLbsl8NLNBugNIL6HdA1DXxEBmVLxofZ
        o6CCGkpWdTkJS/zcOZKpp/pR9nF8jp8S78k9CzBYNa5xIIlcLYmup1VX0Tj4aLywsF3GAmpXO7bXb
        VDpmIrif9kqxg1zp3WDOuB4HrEZ5UDdkvHo/lV/KxLTQBo3jDoSl1xCgsc9x4txt/7k7TYHvSLC5t
        KgFSbZ+g==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXgoa-0000I5-Dh; Sun, 10 May 2020 07:56:00 +0000
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
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/31] microblaze: use asm-generic/cacheflush.h
Date:   Sun, 10 May 2020 09:54:54 +0200
Message-Id: <20200510075510.987823-16-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Microblaze needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/cacheflush.h | 29 ++----------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
index 11f56c85056bb..39f8fb6768d8b 100644
--- a/arch/microblaze/include/asm/cacheflush.h
+++ b/arch/microblaze/include/asm/cacheflush.h
@@ -57,9 +57,6 @@ void microblaze_cache_init(void);
 #define invalidate_icache()				mbc->iin();
 #define invalidate_icache_range(start, end)		mbc->iinr(start, end);
 
-#define flush_icache_user_range(vma, pg, adr, len)	flush_icache();
-#define flush_icache_page(vma, pg)			do { } while (0)
-
 #define enable_dcache()					mbc->de();
 #define disable_dcache()				mbc->dd();
 /* FIXME for LL-temac driver */
@@ -77,27 +74,9 @@ do { \
 	flush_dcache_range((unsigned) (addr), (unsigned) (addr) + PAGE_SIZE); \
 } while (0);
 
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-
-#define flush_cache_dup_mm(mm)				do { } while (0)
-#define flush_cache_vmap(start, end)			do { } while (0)
-#define flush_cache_vunmap(start, end)			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-
 #define flush_cache_page(vma, vmaddr, pfn) \
 	flush_dcache_range(pfn << PAGE_SHIFT, (pfn << PAGE_SHIFT) + PAGE_SIZE);
 
-/* MS: kgdb code use this macro, wrong len with FLASH */
-#if 0
-#define flush_cache_range(vma, start, len)	{	\
-	flush_icache_range((unsigned) (start), (unsigned) (start) + (len)); \
-	flush_dcache_range((unsigned) (start), (unsigned) (start) + (len)); \
-}
-#endif
-
-#define flush_cache_range(vma, start, len) do { } while (0)
-
 static inline void copy_to_user_page(struct vm_area_struct *vma,
 				     struct page *page, unsigned long vaddr,
 				     void *dst, void *src, int len)
@@ -109,12 +88,8 @@ static inline void copy_to_user_page(struct vm_area_struct *vma,
 		flush_dcache_range(addr, addr + PAGE_SIZE);
 	}
 }
+#define copy_to_user_page copy_to_user_page
 
-static inline void copy_from_user_page(struct vm_area_struct *vma,
-				       struct page *page, unsigned long vaddr,
-				       void *dst, void *src, int len)
-{
-	memcpy(dst, src, len);
-}
+#include <asm-generic/cacheflush.h>
 
 #endif /* _ASM_MICROBLAZE_CACHEFLUSH_H */
-- 
2.26.2

