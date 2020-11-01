Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F102A1FDC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 18:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgKARFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 12:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgKARFS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:05:18 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD712223F;
        Sun,  1 Nov 2020 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604250317;
        bh=3qystsPnlugjRY8KsORSq7RQeCX5pBKTiAj4xq/mspE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfipbiLxis16LKOs+/8H8quQwf67jPcFkY/51BHi8ZY1ulSLjzMtXTVccN6IgxfzS
         f0MrAY4dvx3b936ttPaYg9GqI0Vtw+EJz1b6sltVQGA4qR6EMh1sjCLjHXbRcudbGL
         yoUQfelsxcjiahnrOuin1zA2l58MzrTQyZvB78GY=
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
Subject: [PATCH v2 02/13] ia64: remove custom __early_pfn_to_nid()
Date:   Sun,  1 Nov 2020 19:04:43 +0200
Message-Id: <20201101170454.9567-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101170454.9567-1-rppt@kernel.org>
References: <20201101170454.9567-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The ia64 implementation of __early_pfn_to_nid() essentially relies on the
same data as the generic implementation.

The correspondence between memory ranges and nodes is set in memblock
during early memory initialization in register_active_ranges() function.

The initialization of sparsemem that requires early_pfn_to_nid() happens
later and it can use the memblock information like the other architectures.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/Kconfig      |  3 ---
 arch/ia64/mm/numa.c    | 30 ------------------------------
 include/linux/mm.h     |  3 ---
 include/linux/mmzone.h | 11 -----------
 mm/page_alloc.c        | 16 ++++++++++++----
 5 files changed, 12 insertions(+), 51 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 39b25a5a591b..12aae706cb27 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -342,9 +342,6 @@ config HOLES_IN_ZONE
 	bool
 	default y if VIRTUAL_MEM_MAP
 
-config HAVE_ARCH_EARLY_PFN_TO_NID
-	def_bool NUMA && SPARSEMEM
-
 config HAVE_ARCH_NODEDATA_EXTENSION
 	def_bool y
 	depends on NUMA
diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
index f34964271101..46b6e5f3a40f 100644
--- a/arch/ia64/mm/numa.c
+++ b/arch/ia64/mm/numa.c
@@ -58,36 +58,6 @@ paddr_to_nid(unsigned long paddr)
 EXPORT_SYMBOL(paddr_to_nid);
 
 #if defined(CONFIG_SPARSEMEM) && defined(CONFIG_NUMA)
-/*
- * Because of holes evaluate on section limits.
- * If the section of memory exists, then return the node where the section
- * resides.  Otherwise return node 0 as the default.  This is used by
- * SPARSEMEM to allocate the SPARSEMEM sectionmap on the NUMA node where
- * the section resides.
- */
-int __meminit __early_pfn_to_nid(unsigned long pfn,
-					struct mminit_pfnnid_cache *state)
-{
-	int i, section = pfn >> PFN_SECTION_SHIFT, ssec, esec;
-
-	if (section >= state->last_start && section < state->last_end)
-		return state->last_nid;
-
-	for (i = 0; i < num_node_memblks; i++) {
-		ssec = node_memblk[i].start_paddr >> PA_SECTION_SHIFT;
-		esec = (node_memblk[i].start_paddr + node_memblk[i].size +
-			((1L << PA_SECTION_SHIFT) - 1)) >> PA_SECTION_SHIFT;
-		if (section >= ssec && section < esec) {
-			state->last_start = ssec;
-			state->last_end = esec;
-			state->last_nid = node_memblk[i].nid;
-			return node_memblk[i].nid;
-		}
-	}
-
-	return -1;
-}
-
 void numa_clear_node(int cpu)
 {
 	unmap_cpu_from_node(cpu, NUMA_NO_NODE);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..ac51b07b9021 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2433,9 +2433,6 @@ static inline int early_pfn_to_nid(unsigned long pfn)
 #else
 /* please see mm/page_alloc.c */
 extern int __meminit early_pfn_to_nid(unsigned long pfn);
-/* there is a per-arch backend function. */
-extern int __meminit __early_pfn_to_nid(unsigned long pfn,
-					struct mminit_pfnnid_cache *state);
 #endif
 
 extern void set_dma_reserve(unsigned long new_dma_reserve);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..876600a6e891 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1428,17 +1428,6 @@ void sparse_init(void);
 #define subsection_map_init(_pfn, _nr_pages) do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
 
-/*
- * During memory init memblocks map pfns to nids. The search is expensive and
- * this caches recent lookups. The implementation of __early_pfn_to_nid
- * may treat start/end as pfns or sections.
- */
-struct mminit_pfnnid_cache {
-	unsigned long last_start;
-	unsigned long last_end;
-	int last_nid;
-};
-
 /*
  * If it is possible to have holes within a MAX_ORDER_NR_PAGES, then we
  * need to check pfn validity within that MAX_ORDER_NR_PAGES block.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..1fdbf8da77af 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1558,14 +1558,23 @@ void __free_pages_core(struct page *page, unsigned int order)
 
 #ifdef CONFIG_NEED_MULTIPLE_NODES
 
-static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
+/*
+ * During memory init memblocks map pfns to nids. The search is expensive and
+ * this caches recent lookups. The implementation of __early_pfn_to_nid
+ * treats start/end as pfns.
+ */
+struct mminit_pfnnid_cache {
+	unsigned long last_start;
+	unsigned long last_end;
+	int last_nid;
+};
 
-#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
+static struct mminit_pfnnid_cache early_pfnnid_cache __meminitdata;
 
 /*
  * Required by SPARSEMEM. Given a PFN, return what node the PFN is on.
  */
-int __meminit __early_pfn_to_nid(unsigned long pfn,
+static int __meminit __early_pfn_to_nid(unsigned long pfn,
 					struct mminit_pfnnid_cache *state)
 {
 	unsigned long start_pfn, end_pfn;
@@ -1583,7 +1592,6 @@ int __meminit __early_pfn_to_nid(unsigned long pfn,
 
 	return nid;
 }
-#endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
 
 int __meminit early_pfn_to_nid(unsigned long pfn)
 {
-- 
2.28.0

