Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF02A2004
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgKARGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 12:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgKARGI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:06:08 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF32E22242;
        Sun,  1 Nov 2020 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604250367;
        bh=OfpKWBGiLOquFTLJJ06mrlODlaGrj9G30w52BIJJUiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+zeK6esFOXeJjXShE2mSBl/eil3qQxoqinWIwPmIAJJGXnbq5UKpOLadb459svdj
         +ooI7OAbJOWVsm3i57meHAKCTp1ZpUTrBSCjp6R/jZuKFvzSdqYxSRRGE5tCmLBRcn
         9CubILxH+0Pde7zV+7gnHY9YxRT8jaXgzAKgNVus=
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
Subject: [PATCH v2 10/13] arc: use FLATMEM with freeing of unused memory map instead of DISCONTIGMEM
Date:   Sun,  1 Nov 2020 19:04:51 +0200
Message-Id: <20201101170454.9567-11-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101170454.9567-1-rppt@kernel.org>
References: <20201101170454.9567-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Currently ARC uses DISCONTIGMEM to cope with sparse physical memory address
space on systems with 2 memory banks. While DISCONTIGMEM avoids wasting
memory on unpopulated memory map, it adds both memory and CPU overhead
relatively to FLATMEM. Moreover, DISCONTINGMEM is generally considered
deprecated.

The obvious replacement for DISCONTIGMEM would be SPARSEMEM, but it is also
less efficient than FLATMEM in pfn_to_page() and page_to_pfn() conversions.
Besides it requires tuning of SECTION_SIZE which is not trivial for
possible ARC memory configuration.

Since the memory map for both banks is always allocated from the "lowmem"
bank, it is possible to use FLATMEM for two-bank configuration and simply
free the unused hole in the memory map. All is required for that is to
provide ARC-specific pfn_valid() that will take into account actual
physical memory configuration and define HAVE_ARCH_PFN_VALID.

The resulting kernel image configured with defconfig + HIGHMEM=y is
smaller:

$ size a/vmlinux b/vmlinux
   text    data     bss     dec     hex filename
4673503 1245456  279756 6198715  5e95bb a/vmlinux
4658706 1246864  279756 6185326  5e616e b/vmlinux

$ ./scripts/bloat-o-meter a/vmlinux b/vmlinux
add/remove: 28/30 grow/shrink: 42/399 up/down: 10986/-29025 (-18039)
...
Total: Before=4709315, After=4691276, chg -0.38%

Booting nSIM with haps_ns.dts results in the following memory usage
reports:

a:
Memory: 1559104K/1572864K available (3531K kernel code, 595K rwdata, 752K rodata, 136K init, 275K bss, 13760K reserved, 0K cma-reserved, 1048576K highmem)

b:
Memory: 1559112K/1572864K available (3519K kernel code, 594K rwdata, 752K rodata, 136K init, 280K bss, 13752K reserved, 0K cma-reserved, 1048576K highmem)

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/Kconfig            |  3 ++-
 arch/arc/include/asm/page.h | 20 +++++++++++++++++---
 arch/arc/mm/init.c          | 29 ++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 0a89cc9def65..c874f8ab0341 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -67,6 +67,7 @@ config GENERIC_CSUM
 
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool n
+	depends on BROKEN
 
 config ARCH_FLATMEM_ENABLE
 	def_bool y
@@ -506,7 +507,7 @@ config LINUX_RAM_BASE
 
 config HIGHMEM
 	bool "High Memory Support"
-	select ARCH_DISCONTIGMEM_ENABLE
+	select HAVE_ARCH_PFN_VALID
 	help
 	  With ARC 2G:2G address split, only upper 2G is directly addressable by
 	  kernel. Enable this to potentially allow access to rest of 2G and PAE
diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index b0dfed0f12be..23e41e890eda 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -82,11 +82,25 @@ typedef pte_t * pgtable_t;
  */
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 
-#define ARCH_PFN_OFFSET		virt_to_pfn(CONFIG_LINUX_RAM_BASE)
+/*
+ * When HIGHMEM is enabled we have holes in the memory map so we need
+ * pfn_valid() that takes into account the actual extents of the physical
+ * memory
+ */
+#ifdef CONFIG_HIGHMEM
+
+extern unsigned long arch_pfn_offset;
+#define ARCH_PFN_OFFSET		arch_pfn_offset
+
+extern int pfn_valid(unsigned long pfn);
+#define pfn_valid		pfn_valid
 
-#ifdef CONFIG_FLATMEM
+#else /* CONFIG_HIGHMEM */
+
+#define ARCH_PFN_OFFSET		virt_to_pfn(CONFIG_LINUX_RAM_BASE)
 #define pfn_valid(pfn)		(((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
-#endif
+
+#endif /* CONFIG_HIGHMEM */
 
 /*
  * __pa, __va, virt_to_page (ALERT: deprecated, don't use them)
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 3a35b82a718e..ce07e697916c 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -28,6 +28,8 @@ static unsigned long low_mem_sz;
 static unsigned long min_high_pfn, max_high_pfn;
 static phys_addr_t high_mem_start;
 static phys_addr_t high_mem_sz;
+unsigned long arch_pfn_offset;
+EXPORT_SYMBOL(arch_pfn_offset);
 #endif
 
 #ifdef CONFIG_DISCONTIGMEM
@@ -98,16 +100,11 @@ void __init setup_arch_memory(void)
 	init_mm.brk = (unsigned long)_end;
 
 	/* first page of system - kernel .vector starts here */
-	min_low_pfn = ARCH_PFN_OFFSET;
+	min_low_pfn = virt_to_pfn(CONFIG_LINUX_RAM_BASE);
 
 	/* Last usable page of low mem */
 	max_low_pfn = max_pfn = PFN_DOWN(low_mem_start + low_mem_sz);
 
-#ifdef CONFIG_FLATMEM
-	/* pfn_valid() uses this */
-	max_mapnr = max_low_pfn - min_low_pfn;
-#endif
-
 	/*------------- bootmem allocator setup -----------------------*/
 
 	/*
@@ -153,7 +150,9 @@ void __init setup_arch_memory(void)
 	 * DISCONTIGMEM in turns requires multiple nodes. node 0 above is
 	 * populated with normal memory zone while node 1 only has highmem
 	 */
+#ifdef CONFIG_DISCONTIGMEM
 	node_set_online(1);
+#endif
 
 	min_high_pfn = PFN_DOWN(high_mem_start);
 	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
@@ -161,8 +160,15 @@ void __init setup_arch_memory(void)
 	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
 
 	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
+
+	arch_pfn_offset = min(min_low_pfn, min_high_pfn);
 	kmap_init();
-#endif
+
+#else /* CONFIG_HIGHMEM */
+	/* pfn_valid() uses this when FLATMEM=y and HIGHMEM=n */
+	max_mapnr = max_low_pfn - min_low_pfn;
+
+#endif /* CONFIG_HIGHMEM */
 
 	free_area_init(max_zone_pfn);
 }
@@ -190,3 +196,12 @@ void __init mem_init(void)
 	highmem_init();
 	mem_init_print_info(NULL);
 }
+
+#ifdef CONFIG_HIGHMEM
+int pfn_valid(unsigned long pfn)
+{
+	return (pfn >= min_high_pfn && pfn <= max_high_pfn) ||
+		(pfn >= min_low_pfn && pfn <= max_low_pfn);
+}
+EXPORT_SYMBOL(pfn_valid);
+#endif
-- 
2.28.0

