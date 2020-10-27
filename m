Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7C29AAC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 12:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750050AbgJ0Law (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 07:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750041AbgJ0Las (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:30:48 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC5E22263;
        Tue, 27 Oct 2020 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603798246;
        bh=XipFZ9Gk+9MwwOjLDX33Y4z9wXHWMYFSkxcbyoqGVRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VqGyMUObvYgG5PnyEd2PUuzKEpLUyHmZb03SGMWoV/7usxrLDwp1bw65SRHW2FXjw
         5KB8xvl9vLXg/L228UtF6r5gwXIywW1768rLUuAN1W+p2s4PbsBoKYIXUHrJuEp0Iu
         GHIgAs+oZyd7B99QQVGwK4MZhf1tnDgWSL3fhPK8=
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
Subject: [PATCH 06/13] ia64: forbid using VIRTUAL_MEM_MAP with FLATMEM
Date:   Tue, 27 Oct 2020 13:29:48 +0200
Message-Id: <20201027112955.14157-7-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027112955.14157-1-rppt@kernel.org>
References: <20201027112955.14157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Virtual memory map was intended to avoid wasting memory on the memory map
on systems with large holes in the physical memory layout. Long ago it been
superseded first by DISCONTIGMEM and then by SPARSEMEM. Moreover,
SPARSEMEM_VMEMMAP provide the same functionality in much more portable way.

As the first step to removing the VIRTUAL_MEM_MAP forbid it's usage with
FLATMEM and panic on systems with large holes in the physical memory
layout that try to run FLATMEM kernels.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/Kconfig               |  2 +-
 arch/ia64/include/asm/meminit.h |  2 --
 arch/ia64/mm/contig.c           | 48 +++++++++++++++------------------
 arch/ia64/mm/init.c             | 14 ----------
 4 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 12aae706cb27..83de0273d474 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -329,7 +329,7 @@ config NODES_SHIFT
 # VIRTUAL_MEM_MAP has been retained for historical reasons.
 config VIRTUAL_MEM_MAP
 	bool "Virtual mem map"
-	depends on !SPARSEMEM
+	depends on !SPARSEMEM && !FLATMEM
 	default y
 	help
 	  Say Y to compile the kernel with support for a virtual mem map.
diff --git a/arch/ia64/include/asm/meminit.h b/arch/ia64/include/asm/meminit.h
index 092f1c91b36c..e789c0818edb 100644
--- a/arch/ia64/include/asm/meminit.h
+++ b/arch/ia64/include/asm/meminit.h
@@ -59,10 +59,8 @@ extern int reserve_elfcorehdr(u64 *start, u64 *end);
 extern int register_active_ranges(u64 start, u64 len, int nid);
 
 #ifdef CONFIG_VIRTUAL_MEM_MAP
-# define LARGE_GAP	0x40000000 /* Use virtual mem map if hole is > than this */
   extern unsigned long VMALLOC_END;
   extern struct page *vmem_map;
-  extern int find_largest_hole(u64 start, u64 end, void *arg);
   extern int create_mem_map_page_table(u64 start, u64 end, void *arg);
   extern int vmemmap_find_next_valid_pfn(int, int);
 #else
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index ba81d8cb0059..bfc4ecd0a2ab 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -19,15 +19,12 @@
 #include <linux/mm.h>
 #include <linux/nmi.h>
 #include <linux/swap.h>
+#include <linux/sizes.h>
 
 #include <asm/meminit.h>
 #include <asm/sections.h>
 #include <asm/mca.h>
 
-#ifdef CONFIG_VIRTUAL_MEM_MAP
-static unsigned long max_gap;
-#endif
-
 /* physical address where the bootmem map is located */
 unsigned long bootmap_start;
 
@@ -166,33 +163,30 @@ find_memory (void)
 	alloc_per_cpu_data();
 }
 
-static void __init virtual_map_init(void)
+static int __init find_largest_hole(u64 start, u64 end, void *arg)
 {
-#ifdef CONFIG_VIRTUAL_MEM_MAP
-	efi_memmap_walk(find_largest_hole, (u64 *)&max_gap);
-	if (max_gap < LARGE_GAP) {
-		vmem_map = (struct page *) 0;
-	} else {
-		unsigned long map_size;
+	u64 *max_gap = arg;
 
-		/* allocate virtual_mem_map */
+	static u64 last_end = PAGE_OFFSET;
 
-		map_size = PAGE_ALIGN(ALIGN(max_low_pfn, MAX_ORDER_NR_PAGES) *
-			sizeof(struct page));
-		VMALLOC_END -= map_size;
-		vmem_map = (struct page *) VMALLOC_END;
-		efi_memmap_walk(create_mem_map_page_table, NULL);
+	/* NOTE: this algorithm assumes efi memmap table is ordered */
 
-		/*
-		 * alloc_node_mem_map makes an adjustment for mem_map
-		 * which isn't compatible with vmem_map.
-		 */
-		NODE_DATA(0)->node_mem_map = vmem_map +
-			find_min_pfn_with_active_regions();
+	if (*max_gap < (start - last_end))
+		*max_gap = start - last_end;
+	last_end = end;
+	return 0;
+}
 
-		printk("Virtual mem_map starts at 0x%p\n", mem_map);
-	}
-#endif /* !CONFIG_VIRTUAL_MEM_MAP */
+static void __init verify_gap_absence(void)
+{
+	unsigned long max_gap;
+
+	/* Forbid FLATMEM if hole is > than 1G */
+	efi_memmap_walk(find_largest_hole, (u64 *)&max_gap);
+	if (max_gap >= SZ_1G)
+		panic("Cannot use FLATMEM with %ldMB hole\n"
+		      "Please switch over to SPARSEMEM\n",
+		      (max_gap >> 20));
 }
 
 /*
@@ -210,7 +204,7 @@ paging_init (void)
 	max_zone_pfns[ZONE_DMA32] = max_dma;
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
-	virtual_map_init();
+	verify_gap_absence();
 
 	free_area_init(max_zone_pfns);
 	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index ef12e097f318..9b5acf8fb092 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -574,20 +574,6 @@ ia64_pfn_valid (unsigned long pfn)
 }
 EXPORT_SYMBOL(ia64_pfn_valid);
 
-int __init find_largest_hole(u64 start, u64 end, void *arg)
-{
-	u64 *max_gap = arg;
-
-	static u64 last_end = PAGE_OFFSET;
-
-	/* NOTE: this algorithm assumes efi memmap table is ordered */
-
-	if (*max_gap < (start - last_end))
-		*max_gap = start - last_end;
-	last_end = end;
-	return 0;
-}
-
 #endif /* CONFIG_VIRTUAL_MEM_MAP */
 
 int __init register_active_ranges(u64 start, u64 len, int nid)
-- 
2.28.0

