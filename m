Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4F447930
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhKHEPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhKHEPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:15:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437DFC061570;
        Sun,  7 Nov 2021 20:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CbvDYGxzFUFa2QFzUNKPHRpvgK6he53Nd2mJrxXO6ZM=; b=djcWJU6tZZk9PcxNgfvI5hDVEw
        a9WYSd3IcUOAEqtOgT9HGt3C+imBCAMprGoWbWS3jWWir/QXYrXFAhrY0WmLU1N5mgpz2Xxhe1tes
        UiNAQLtX2kVs++vFImHwyLLUJdFxSAKNMTED+1f+vyyROyzwL2lgvQyn3Hv9B/3IdrCYD9nDyBstG
        MgSXJGmgvW63sW5tj1XpvfR2cL7MaRcfEwO53tzWIhxdyZEP3TnQAc6ZMt4m08P7+5gqYtoTBkx7M
        8DKHtYPE4x4EiOjDLNsoISvx64nmy7pbDOSKe7ScKAxkSqVVnwa3IDy9PhAzA6tWKSx16V2ot7Szs
        /mKgYRkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjvwl-0089Rp-KM; Mon, 08 Nov 2021 04:08:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 01/28] csky,sparc: Declare flush_dcache_folio()
Date:   Mon,  8 Nov 2021 04:05:24 +0000
Message-Id: <20211108040551.1942823-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These architectures do not include asm-generic/cacheflush.h so need
to declare it themselves.

Fixes: 08b0b0059bf1 ("mm: Add flush_dcache_folio()")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/csky/abiv1/inc/abi/cacheflush.h   | 1 +
 arch/csky/abiv2/inc/abi/cacheflush.h   | 2 ++
 arch/sparc/include/asm/cacheflush_32.h | 1 +
 arch/sparc/include/asm/cacheflush_64.h | 1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index ed62e2066ba7..432aef1f1dc2 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -9,6 +9,7 @@
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
+void flush_dcache_folio(struct folio *folio);
 
 #define flush_cache_mm(mm)			dcache_wbinv_all()
 #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index a565e00c3f70..7e8bef60958c 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -25,6 +25,8 @@ static inline void flush_dcache_page(struct page *page)
 		clear_bit(PG_dcache_clean, &page->flags);
 }
 
+void flush_dcache_folio(struct folio *folio);
+
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)		do { } while (0)
diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index 41c6d734a474..9991c18f4980 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -37,6 +37,7 @@
 
 void sparc_flush_page_to_ram(struct page *page);
 
+void flush_dcache_folio(struct folio *folio);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 #define flush_dcache_page(page)			sparc_flush_page_to_ram(page)
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index b9341836597e..9ab59a73c28b 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -47,6 +47,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
 void __flush_dcache_range(unsigned long start, unsigned long end);
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 void flush_dcache_page(struct page *page);
+void flush_dcache_folio(struct folio *folio);
 
 #define flush_icache_page(vma, pg)	do { } while(0)
 
-- 
2.33.0

