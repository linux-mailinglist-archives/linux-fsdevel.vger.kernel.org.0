Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D098D1D5103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgEOOhp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 10:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727799AbgEOOhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 10:37:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45619C05BD09;
        Fri, 15 May 2020 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aVQ1xLZiwZwftiaH3jhCNlEcJ33SLJz0PSYci41Jgd4=; b=OZZbKqQS7yRJ9ydeXAseXDrGPR
        pCqtvpuNCx4h0c+Kutl3MBL/FRJAKV1XNxx0NGunIFjUln9zHcpS19ogGzj5Z6lkeIHcy2Io0MHs5
        vzmFw9UizVw8q38+CxQ4klLHCYhZiIV+2NcqyeXFoeBHLUMSvZ1vTdGBBhoDSkp9aNrXq8rCDjxju
        BJC34ZsMp2go3jzsikwk4bWdY128y85jVQVtOvd5CbXvkF9hISoRVHqZIlat0xeveRmNV2PQnKYFP
        j3R6GevPGnLNNPVmlBIFC9wcp9FcuWg45rYfky2q0sROWnH7kIBgWP3rKOknfe6d8k1QCZA5b9qY5
        jb3BFk5g==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbSh-0004MA-75; Fri, 15 May 2020 14:37:19 +0000
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
Subject: [PATCH 11/29] hexagon: use asm-generic/cacheflush.h
Date:   Fri, 15 May 2020 16:36:28 +0200
Message-Id: <20200515143646.3857579-12-hch@lst.de>
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

Hexagon needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/cacheflush.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
index fb447de45d54c..6eff0730e6efd 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -25,29 +25,17 @@
 #define LINESIZE	32
 #define LINEBITS	5
 
-#define flush_cache_all()			do { } while (0)
-#define flush_cache_mm(mm)			do { } while (0)
-#define flush_cache_dup_mm(mm)			do { } while (0)
-#define flush_cache_range(vma, start, end)	do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-#define flush_dcache_page(page)			do { } while (0)
-#define flush_dcache_mmap_lock(mapping)		do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
-#define flush_icache_page(vma, pg)		do { } while (0)
-#define flush_icache_user_range(vma, pg, adr, len)	do { } while (0)
-#define flush_cache_vmap(start, end)		do { } while (0)
-#define flush_cache_vunmap(start, end)		do { } while (0)
-
 /*
  * Flush Dcache range through current map.
  */
 extern void flush_dcache_range(unsigned long start, unsigned long end);
+#define flush_dcache_range flush_dcache_range
 
 /*
  * Flush Icache range through current map.
  */
 extern void flush_icache_range(unsigned long start, unsigned long end);
+#define flush_icache_range flush_icache_range
 
 /*
  * Memory-management related flushes are there to ensure in non-physically
@@ -78,6 +66,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long vaddr, void *dst, void *src, int len);
+#define copy_to_user_page copy_to_user_page
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
 	memcpy(dst, src, len)
@@ -85,4 +74,6 @@ void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 extern void hexagon_inv_dcache_range(unsigned long start, unsigned long end);
 extern void hexagon_clean_dcache_range(unsigned long start, unsigned long end);
 
+#include <asm-generic/cacheflush.h>
+
 #endif
-- 
2.26.2

