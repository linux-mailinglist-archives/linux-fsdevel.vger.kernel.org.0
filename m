Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF42129AAD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 12:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411070AbgJ0Lbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 07:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410941AbgJ0Lb3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:31:29 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD87122281;
        Tue, 27 Oct 2020 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603798287;
        bh=C96/Yri0OpcfVOV1K/D1OQZYc09J0deYEZYDY/R242k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RO9w86ZlWcBO3seuK5eFu0P2uHFkfcLlrAbPpLsunaUHodYQ3Drj7EioUxxYpgdfn
         p3JtpqO0uBUP1PRzqijnlt/zHUT0wz4w2dKzUEzVBfQz9BTODh6dEaA1JnbOgeD4lN
         VIdUhU32rcODYbCtB1hDzAnX2L1R5dhx9g6xBprY=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: [PATCH 12/13] m68k/mm: enable use of generic memory_model.h for !DISCONTIGMEM
Date:   Tue, 27 Oct 2020 13:29:54 +0200
Message-Id: <20201027112955.14157-13-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027112955.14157-1-rppt@kernel.org>
References: <20201027112955.14157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The pg_data_map and pg_data_table arrays as well as page_to_pfn() and
pfn_to_page() are required only for DISCONTIGMEM. Other memory models can
use the generic definitions in asm-generic/memory_model.h.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/include/asm/page.h        | 2 ++
 arch/m68k/include/asm/page_mm.h     | 5 +++++
 arch/m68k/include/asm/virtconvert.h | 2 +-
 arch/m68k/mm/init.c                 | 6 +++---
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 2614a1206f2f..6116d7094292 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -62,8 +62,10 @@ extern unsigned long _ramend;
 #include <asm/page_no.h>
 #endif
 
+#ifdef CONFIG_DISCONTIGMEM
 #define __phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
 #define __pfn_to_phys(pfn)	PFN_PHYS(pfn)
+#endif
 
 #include <asm-generic/getorder.h>
 
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index 0e794051d3bb..7f5912af2a52 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -153,6 +153,7 @@ static inline __attribute_const__ int __virt_to_node_shift(void)
 	pfn_to_virt(page_to_pfn(page));					\
 })
 
+#ifdef CONFIG_DISCONTIGMEM
 #define pfn_to_page(pfn) ({						\
 	unsigned long __pfn = (pfn);					\
 	struct pglist_data *pgdat;					\
@@ -165,6 +166,10 @@ static inline __attribute_const__ int __virt_to_node_shift(void)
 	pgdat = &pg_data_map[page_to_nid(__p)];				\
 	((__p) - pgdat->node_mem_map) + pgdat->node_start_pfn;		\
 })
+#else
+#define ARCH_PFN_OFFSET (m68k_memory[0].addr)
+#include <asm-generic/memory_model.h>
+#endif
 
 #define virt_addr_valid(kaddr)	((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
diff --git a/arch/m68k/include/asm/virtconvert.h b/arch/m68k/include/asm/virtconvert.h
index dfe43083b579..751bb6f4aaf6 100644
--- a/arch/m68k/include/asm/virtconvert.h
+++ b/arch/m68k/include/asm/virtconvert.h
@@ -31,7 +31,7 @@ static inline void *phys_to_virt(unsigned long address)
 /* Permanent address of a page. */
 #if defined(CONFIG_MMU) && defined(CONFIG_SINGLE_MEMORY_CHUNK)
 #define page_to_phys(page) \
-	__pa(PAGE_OFFSET + (((page) - pg_data_map[0].node_mem_map) << PAGE_SHIFT))
+	__pa(PAGE_OFFSET + (((page) - mem_map) << PAGE_SHIFT))
 #else
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 #endif
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 4b46ceace3d3..14c1e541451c 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -42,12 +42,12 @@ EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_MMU
 
-pg_data_t pg_data_map[MAX_NUMNODES];
-EXPORT_SYMBOL(pg_data_map);
-
 int m68k_virt_to_node_shift;
 
 #ifdef CONFIG_DISCONTIGMEM
+pg_data_t pg_data_map[MAX_NUMNODES];
+EXPORT_SYMBOL(pg_data_map);
+
 pg_data_t *pg_data_table[65];
 EXPORT_SYMBOL(pg_data_table);
 #endif
-- 
2.28.0

