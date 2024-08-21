Return-Path: <linux-fsdevel+bounces-26538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CC095A554
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFAB1C21F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A916F0EF;
	Wed, 21 Aug 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LpRahv8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBD516DEAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268897; cv=none; b=H0DKBX1Gpt1DLJrfb1hEFdxDmlcNMsRAO8+lrnomOe86ZJWTS4bpKc32LnJjtI8Jpzdvzq8JLEevjtV9HhplfRT/G3epjg+mQ5yzmEo2Ih+79ui2h/6BzxQgR6qxjmyAWMgqzhzcuDNUmuWsVS5m/exM1kNRPfaOYX11QGMDvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268897; c=relaxed/simple;
	bh=PZlGaQMfg63SN72PQLp8ln9M/dpZDGY7AHG2e3uN+pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PleEav4ywL+S0RwtZl+Tt+L5K4Sar4I1iPAcMTMrqUa3Elah9CCXVQ10qaUUNqgIh5qHKWW8JanDi2nFpkOIytuk3ZO7c8rlCnL8Lg156YQ9JllvcsuiRfVgAZLz5T5ids3nX0iMoP8UK/5smAmTUvHKUWh70/zovm146zGrtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LpRahv8d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=aoXvUmQZxLcraskxyzdekmS4BRurnqvUbN7H813e5kc=; b=LpRahv8dh1ob/VeW17tRjYPGpG
	igxvOqSKuTJD3wIFuIWQne6MAKif/tVHp0+fs268oqusqfJAbKjr2vUpV85Caym9W7bQRbzcS9W9m
	oaINq9hAOpBYVA5vUaFii9Rjgr0ynO9qawSf/BiD1Dh3OUp5bAfRI1jLdarXXYjhIFFInPlySpvCO
	O6jBWft+rQho+uQTUDmEAUDY2CYWjW4ONBONFZx5nswQfDpuulqgM447ZndGjnSiDQTM9+JVdOjFO
	ifbPlb5p5ejYZnODgJN790oIjfw2LFPW1RvntCfRzf/4a/pAgv+JUqBATUl0bUJ9U7UpZFfdfcZpk
	b0Ijj6/A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6V-00000009crE-3TtL;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 10/10] x86: Remove PG_uncached
Date: Wed, 21 Aug 2024 20:34:43 +0100
Message-ID: <20240821193445.2294269-11-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert x86 to use PG_arch_2 instead of PG_uncached and remove
PG_uncached.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 .../features/vm/PG_uncached/arch-support.txt  | 30 -------------------
 arch/arm64/Kconfig                            |  3 +-
 arch/x86/Kconfig                              |  5 +---
 arch/x86/mm/pat/memtype.c                     |  8 ++---
 fs/proc/page.c                                |  8 ++---
 include/linux/kernel-page-flags.h             |  1 -
 include/linux/page-flags.h                    | 13 ++------
 include/trace/events/mmflags.h                | 23 +++++++-------
 mm/Kconfig                                    |  9 ++----
 mm/huge_memory.c                              |  4 ++-
 tools/mm/page-types.c                         |  3 +-
 11 files changed, 31 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/features/vm/PG_uncached/arch-support.txt

diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
deleted file mode 100644
index 5a7508b8c967..000000000000
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# Feature name:          PG_uncached
-#         Kconfig:       ARCH_USES_PG_UNCACHED
-#         description:   arch supports the PG_uncached page flag
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: | TODO |
-    |         arm: | TODO |
-    |       arm64: | TODO |
-    |        csky: | TODO |
-    |     hexagon: | TODO |
-    |   loongarch: | TODO |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: | TODO |
-    |       riscv: | TODO |
-    |        s390: | TODO |
-    |          sh: | TODO |
-    |       sparc: | TODO |
-    |          um: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: | TODO |
-    -----------------------
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a2f8ff354ca6..6494848019a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2100,7 +2100,8 @@ config ARM64_MTE
 	depends on ARM64_PAN
 	select ARCH_HAS_SUBPAGE_FAULTS
 	select ARCH_USES_HIGH_VMA_FLAGS
-	select ARCH_USES_PG_ARCH_X
+	select ARCH_USES_PG_ARCH_2
+	select ARCH_USES_PG_ARCH_3
 	help
 	  Memory Tagging (part of the ARMv8.5 Extensions) provides
 	  architectural support for run-time, always-on detection of
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 09f8fbcfe000..42edf11f5166 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1800,6 +1800,7 @@ config X86_PAT
 	def_bool y
 	prompt "x86 PAT support" if EXPERT
 	depends on MTRR
+	select ARCH_USES_PG_ARCH_2
 	help
 	  Use PAT attributes to setup page level cache control.
 
@@ -1811,10 +1812,6 @@ config X86_PAT
 
 	  If unsure, say Y.
 
-config ARCH_USES_PG_UNCACHED
-	def_bool y
-	depends on X86_PAT
-
 config X86_UMIP
 	def_bool y
 	prompt "User Mode Instruction Prevention" if EXPERT
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index bdc2a240c2aa..1fa0bf6ed295 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -104,7 +104,7 @@ __setup("debugpat", pat_debug_setup);
 
 #ifdef CONFIG_X86_PAT
 /*
- * X86 PAT uses page flags arch_1 and uncached together to keep track of
+ * X86 PAT uses page flags arch_1 and arch_2 together to keep track of
  * memory type of pages that have backing page struct.
  *
  * X86 PAT supports 4 different memory types:
@@ -118,9 +118,9 @@ __setup("debugpat", pat_debug_setup);
 
 #define _PGMT_WB		0
 #define _PGMT_WC		(1UL << PG_arch_1)
-#define _PGMT_UC_MINUS		(1UL << PG_uncached)
-#define _PGMT_WT		(1UL << PG_uncached | 1UL << PG_arch_1)
-#define _PGMT_MASK		(1UL << PG_uncached | 1UL << PG_arch_1)
+#define _PGMT_UC_MINUS		(1UL << PG_arch_2)
+#define _PGMT_WT		(1UL << PG_arch_2 | 1UL << PG_arch_1)
+#define _PGMT_MASK		(1UL << PG_arch_2 | 1UL << PG_arch_1)
 #define _PGMT_CLEAR_MASK	(~_PGMT_MASK)
 
 static inline enum page_cache_mode get_page_memtype(struct page *pg)
diff --git a/fs/proc/page.c b/fs/proc/page.c
index e74e639893be..a55f5acefa97 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -206,18 +206,16 @@ u64 stable_page_flags(const struct page *page)
 		u |= kpf_copy_bit(page->flags, KPF_HWPOISON,	PG_hwpoison);
 #endif
 
-#ifdef CONFIG_ARCH_USES_PG_UNCACHED
-	u |= kpf_copy_bit(k, KPF_UNCACHED,	PG_uncached);
-#endif
-
 	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
 	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
 	u |= kpf_copy_bit(k, KPF_PRIVATE,	PG_private);
 	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
 	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
-#ifdef CONFIG_ARCH_USES_PG_ARCH_X
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
 	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
+#endif
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
 	u |= kpf_copy_bit(k, KPF_ARCH_3,	PG_arch_3);
 #endif
 
diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
index 7c587a711be1..196778a087c4 100644
--- a/include/linux/kernel-page-flags.h
+++ b/include/linux/kernel-page-flags.h
@@ -15,7 +15,6 @@
 #define KPF_PRIVATE_2		36
 #define KPF_OWNER_PRIVATE	37
 #define KPF_ARCH		38
-#define KPF_UNCACHED		39
 #define KPF_SOFTDIRTY		40
 #define KPF_ARCH_2		41
 #define KPF_ARCH_3		42
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index c001e3c29c4c..7b90a700b26a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -113,9 +113,6 @@ enum pageflags {
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
-#ifdef CONFIG_ARCH_USES_PG_UNCACHED
-	PG_uncached,		/* Page has been mapped as uncached */
-#endif
 #ifdef CONFIG_MEMORY_FAILURE
 	PG_hwpoison,		/* hardware poisoned page. Don't touch */
 #endif
@@ -123,8 +120,10 @@ enum pageflags {
 	PG_young,
 	PG_idle,
 #endif
-#ifdef CONFIG_ARCH_USES_PG_ARCH_X
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
 	PG_arch_2,
+#endif
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
 	PG_arch_3,
 #endif
 	__NR_PAGEFLAGS,
@@ -602,12 +601,6 @@ FOLIO_FLAG_FALSE(mlocked)
 	FOLIO_TEST_SET_FLAG_FALSE(mlocked)
 #endif
 
-#ifdef CONFIG_ARCH_USES_PG_UNCACHED
-PAGEFLAG(Uncached, uncached, PF_NO_COMPOUND)
-#else
-PAGEFLAG_FALSE(Uncached, uncached)
-#endif
-
 #ifdef CONFIG_MEMORY_FAILURE
 PAGEFLAG(HWPoison, hwpoison, PF_ANY)
 TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 3b51558cdc9b..58f2699331b6 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -71,12 +71,6 @@
 #define IF_HAVE_PG_MLOCK(_name)
 #endif
 
-#ifdef CONFIG_ARCH_USES_PG_UNCACHED
-#define IF_HAVE_PG_UNCACHED(_name) ,{1UL << PG_##_name, __stringify(_name)}
-#else
-#define IF_HAVE_PG_UNCACHED(_name)
-#endif
-
 #ifdef CONFIG_MEMORY_FAILURE
 #define IF_HAVE_PG_HWPOISON(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
@@ -89,10 +83,16 @@
 #define IF_HAVE_PG_IDLE(_name)
 #endif
 
-#ifdef CONFIG_ARCH_USES_PG_ARCH_X
-#define IF_HAVE_PG_ARCH_X(_name) ,{1UL << PG_##_name, __stringify(_name)}
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
+#define IF_HAVE_PG_ARCH_2(_name) ,{1UL << PG_##_name, __stringify(_name)}
+#else
+#define IF_HAVE_PG_ARCH_2(_name)
+#endif
+
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
+#define IF_HAVE_PG_ARCH_3(_name) ,{1UL << PG_##_name, __stringify(_name)}
 #else
-#define IF_HAVE_PG_ARCH_X(_name)
+#define IF_HAVE_PG_ARCH_3(_name)
 #endif
 
 #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
@@ -118,12 +118,11 @@
 	DEF_PAGEFLAG_NAME(swapbacked),					\
 	DEF_PAGEFLAG_NAME(unevictable)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
-IF_HAVE_PG_UNCACHED(uncached)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
 IF_HAVE_PG_IDLE(young)							\
-IF_HAVE_PG_ARCH_X(arch_2)						\
-IF_HAVE_PG_ARCH_X(arch_3)
+IF_HAVE_PG_ARCH_2(arch_2)						\
+IF_HAVE_PG_ARCH_3(arch_3)
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/Kconfig b/mm/Kconfig
index 5946dcdcaeda..8078a4b3c509 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1079,13 +1079,10 @@ config ARCH_USES_HIGH_VMA_FLAGS
 config ARCH_HAS_PKEYS
 	bool
 
-config ARCH_USES_PG_ARCH_X
+config ARCH_USES_PG_ARCH_2
+	bool
+config ARCH_USES_PG_ARCH_3
 	bool
-	help
-	  Enable the definition of PG_arch_x page flags with x > 1. Only
-	  suitable for 64-bit architectures with CONFIG_FLATMEM or
-	  CONFIG_SPARSEMEM_VMEMMAP enabled, otherwise there may not be
-	  enough room for additional bits in page->flags.
 
 config VM_EVENT_COUNTERS
 	default y
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d92f19812c89..389d619845c9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3078,8 +3078,10 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 			 (1L << PG_workingset) |
 			 (1L << PG_locked) |
 			 (1L << PG_unevictable) |
-#ifdef CONFIG_ARCH_USES_PG_ARCH_X
+#ifdef CONFIG_ARCH_USES_PG_ARCH_2
 			 (1L << PG_arch_2) |
+#endif
+#ifdef CONFIG_ARCH_USES_PG_ARCH_3
 			 (1L << PG_arch_3) |
 #endif
 			 (1L << PG_dirty) |
diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
index 8ca41c41105e..fa050d5a48cd 100644
--- a/tools/mm/page-types.c
+++ b/tools/mm/page-types.c
@@ -76,7 +76,7 @@
 #define KPF_PRIVATE_2		36
 #define KPF_OWNER_PRIVATE	37
 #define KPF_ARCH		38
-#define KPF_UNCACHED		39
+#define KPF_UNCACHED		39	/* unused */
 #define KPF_SOFTDIRTY		40
 #define KPF_ARCH_2		41
 
@@ -134,7 +134,6 @@ static const char * const page_flag_names[] = {
 	[KPF_PRIVATE_2]		= "p:private_2",
 	[KPF_OWNER_PRIVATE]	= "O:owner_private",
 	[KPF_ARCH]		= "h:arch",
-	[KPF_UNCACHED]		= "c:uncached",
 	[KPF_SOFTDIRTY]		= "f:softdirty",
 	[KPF_ARCH_2]		= "H:arch_2",
 
-- 
2.43.0


