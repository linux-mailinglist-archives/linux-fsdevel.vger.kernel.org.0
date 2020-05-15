Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72C21D51B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 16:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgEOOje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727851AbgEOOhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 10:37:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53991C061A0C;
        Fri, 15 May 2020 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kQS44H8EzM8k3vQYjLlTfkfNkLQiGixe7Bw6b6gouAo=; b=COBcuw2sMnbx8n6F0r04JzqsVZ
        vhsnRV88QAm1MMvzPpni3bCVqECArdsjrwXjVyJYlm/nGqC1AIEq9cWiMnSp/fzU7XIAXjNKwscfM
        nVXUQU9d8CRR7QapoJ62NVVY23Jeq5tRK5o/GjOPHix1T3p4kQIooNVrQb1lQPjHzkliPq6DWjHvC
        Lp1UMyIIXYjsBXTXQnxmhuVUDUq3DYtlyrQTKrhkom10fZQAQQWcBRxs+tdOnyQeZgEK5bq2Q4fZ5
        CRtCX4IisNVhwlDMiN1J96maNni2cVQK6NLAIVY8S5Pb4KwJ0pbABeKSR0rJnkvQQRk7ExsxRZIgo
        vlL7IhMg==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbSu-0004ga-GD; Fri, 15 May 2020 14:37:33 +0000
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
Subject: [PATCH 15/29] openrisc: use asm-generic/cacheflush.h
Date:   Fri, 15 May 2020 16:36:32 +0200
Message-Id: <20200515143646.3857579-16-hch@lst.de>
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

OpenRISC needs almost no cache flushing routines of its own.  Rely on
asm-generic/cacheflush.h for the defaults.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/cacheflush.h | 31 +++++---------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/openrisc/include/asm/cacheflush.h b/arch/openrisc/include/asm/cacheflush.h
index 79d5d7753fe4b..74d1fce4e8839 100644
--- a/arch/openrisc/include/asm/cacheflush.h
+++ b/arch/openrisc/include/asm/cacheflush.h
@@ -62,31 +62,12 @@ static inline void flush_dcache_page(struct page *page)
 	clear_bit(PG_dc_clean, &page->flags);
 }
 
-/*
- * Other interfaces are not required since we do not have virtually
- * indexed or tagged caches. So we can use the default here.
- */
-#define flush_cache_all()				do { } while (0)
-#define flush_cache_mm(mm)				do { } while (0)
-#define flush_cache_dup_mm(mm)				do { } while (0)
-#define flush_cache_range(vma, start, end)		do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)		do { } while (0)
-#define flush_dcache_mmap_lock(mapping)			do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)		do { } while (0)
-#define flush_icache_range(start, end)			do { } while (0)
-#define flush_icache_page(vma, pg)			do { } while (0)
-#define flush_icache_user_range(vma, pg, adr, len)	do { } while (0)
-#define flush_cache_vmap(start, end)			do { } while (0)
-#define flush_cache_vunmap(start, end)			do { } while (0)
-
-#define copy_to_user_page(vma, page, vaddr, dst, src, len)           \
-	do {                                                         \
-		memcpy(dst, src, len);                               \
-		if (vma->vm_flags & VM_EXEC)                         \
-			sync_icache_dcache(page);                    \
-	} while (0)
+#define flush_icache_user_range(vma, page, addr, len)	\
+do {							\
+	if (vma->vm_flags & VM_EXEC)			\
+		sync_icache_dcache(page);		\
+} while (0)
 
-#define copy_from_user_page(vma, page, vaddr, dst, src, len)         \
-	memcpy(dst, src, len)
+#include <asm-generic/cacheflush.h>
 
 #endif /* __ASM_CACHEFLUSH_H */
-- 
2.26.2

