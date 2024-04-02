Return-Path: <linux-fsdevel+bounces-15873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E0C895405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D2F1F24364
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04B683CC6;
	Tue,  2 Apr 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqRlYLG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E07F7E2
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062559; cv=none; b=CfY26tsATcPcgw8Q067mH8yuFiWsPG4mnRF0EWu+0bSjiPo1jhUyxoI6iTFwg3TBZD2IWm+19pQ1JAazKhVwCgIEAC1trFTZ99Id0L3VW368tJbI29JXj65qE0clRbBLJEfLOgZU+kZWhsliIfKiIFseiVLW0JjR6olE7Q0T6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062559; c=relaxed/simple;
	bh=v9mkatNzYJqa0aDsv7IqQC4sIWtC4aGOcuHM0jbI/hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIZzJREVjm2kno6NV6UqwBPH45iGeOIRgzn/+nCAEwmLIoLR+l4IGaRYQBgvqqkv3/EXM7bDtsjtdjd3Yd5boqi+iRxinYgDVsYGN9AsDq7Zq9fsRsY2DIVlkvaGUmIfBEaJoLiFGE/jQhDw8XhjuC27cWiJZXu0/NFFhAMPvlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqRlYLG1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712062555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmiZaiwFptHJMHSw9D0x+FrvfCn7jycw2VvcIKklrLE=;
	b=iqRlYLG1O+MvDHLgnM5UhourVBY+AyY0WNr414BcT9T0H9MzlqUo5BJfH5MxkCC5tm13LJ
	A5CezkEVo64Nc+I6qfWGQQyYCap7BfAjOcfo7ghSjYs565n3khLqafamNtCQPJgDa4zT49
	AR7Xc/SxzD4Au0cAypgN8oXFgGCmGdM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-rIpFy6zPP_6Tg6et4qWd4w-1; Tue, 02 Apr 2024 08:55:51 -0400
X-MC-Unique: rIpFy6zPP_6Tg6et4qWd4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBE5A805A65;
	Tue,  2 Apr 2024 12:55:50 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD7A13C21;
	Tue,  2 Apr 2024 12:55:46 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v1 2/3] mm/treewide: rename CONFIG_HAVE_FAST_GUP to CONFIG_HAVE_GUP_FAST
Date: Tue,  2 Apr 2024 14:55:15 +0200
Message-ID: <20240402125516.223131-3-david@redhat.com>
In-Reply-To: <20240402125516.223131-1-david@redhat.com>
References: <20240402125516.223131-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Nowadays, we call it "GUP-fast", the external interface includes
functions like "get_user_pages_fast()", and we renamed all internal
functions to reflect that as well.

Let's make the config option reflect that.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm/Kconfig       |  2 +-
 arch/arm64/Kconfig     |  2 +-
 arch/loongarch/Kconfig |  2 +-
 arch/mips/Kconfig      |  2 +-
 arch/powerpc/Kconfig   |  2 +-
 arch/riscv/Kconfig     |  2 +-
 arch/s390/Kconfig      |  2 +-
 arch/sh/Kconfig        |  2 +-
 arch/x86/Kconfig       |  2 +-
 include/linux/rmap.h   |  8 ++++----
 kernel/events/core.c   |  4 ++--
 mm/Kconfig             |  2 +-
 mm/gup.c               | 10 +++++-----
 mm/internal.h          |  2 +-
 14 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b14aed3a17ab..817918f6635a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -99,7 +99,7 @@ config ARM
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
-	select HAVE_FAST_GUP if ARM_LPAE
+	select HAVE_GUP_FAST if ARM_LPAE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..de076a191e9f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -205,7 +205,7 @@ config ARM64
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_FAST_GUP
+	select HAVE_GUP_FAST
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a5f300ec6f28..cd642eefd9e5 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -119,7 +119,7 @@ config LOONGARCH
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
-	select HAVE_FAST_GUP
+	select HAVE_GUP_FAST
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 516dc7022bd7..f1aa1bf11166 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -68,7 +68,7 @@ config MIPS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if !CPU_MICROMIPS
 	select HAVE_EXIT_THREAD
-	select HAVE_FAST_GUP
+	select HAVE_GUP_FAST
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..e42cc8cd415f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -236,7 +236,7 @@ config PPC
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS	if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_FAST_GUP
+	select HAVE_GUP_FAST
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..3ee60ddef93e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -132,7 +132,7 @@ config RISCV
 	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 	select HAVE_EBPF_JIT if MMU
-	select HAVE_FAST_GUP if MMU
+	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8f01ada6845e..d9aed4c93ee6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -174,7 +174,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_FAST_GUP
+	select HAVE_GUP_FAST
 	select HAVE_FENTRY
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2ad3e29f0ebe..7292542f75e8 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -38,7 +38,7 @@ config SUPERH
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_FAST_GUP if MMU
+	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4fff6ed46e90..222b42941cf3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -221,7 +221,7 @@ config X86
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA
 	select HAVE_EXIT_THREAD
-	select HAVE_FAST_GUP
+	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b7944a833668..9bf9324214fc 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -284,7 +284,7 @@ static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
 	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
 
 	/* Paired with the memory barrier in try_grab_folio(). */
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+	if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
 		smp_mb();
 
 	if (unlikely(folio_maybe_dma_pinned(folio)))
@@ -295,7 +295,7 @@ static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
 	 * This is conceptually a smp_wmb() paired with the smp_rmb() in
 	 * gup_must_unshare().
 	 */
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+	if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
 		smp_mb__after_atomic();
 	return 0;
 }
@@ -541,7 +541,7 @@ static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
 	 */
 
 	/* Paired with the memory barrier in try_grab_folio(). */
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+	if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
 		smp_mb();
 
 	if (unlikely(folio_maybe_dma_pinned(folio)))
@@ -552,7 +552,7 @@ static __always_inline int __folio_try_share_anon_rmap(struct folio *folio,
 	 * This is conceptually a smp_wmb() paired with the smp_rmb() in
 	 * gup_must_unshare().
 	 */
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+	if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
 		smp_mb__after_atomic();
 	return 0;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..c5a0dc1f135f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7539,7 +7539,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 {
 	u64 size = 0;
 
-#ifdef CONFIG_HAVE_FAST_GUP
+#ifdef CONFIG_HAVE_GUP_FAST
 	pgd_t *pgdp, pgd;
 	p4d_t *p4dp, p4d;
 	pud_t *pudp, pud;
@@ -7587,7 +7587,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	if (pte_present(pte))
 		size = pte_leaf_size(pte);
 	pte_unmap(ptep);
-#endif /* CONFIG_HAVE_FAST_GUP */
+#endif /* CONFIG_HAVE_GUP_FAST */
 
 	return size;
 }
diff --git a/mm/Kconfig b/mm/Kconfig
index f0ed3168db00..50df323eaece 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -473,7 +473,7 @@ config ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
-config HAVE_FAST_GUP
+config HAVE_GUP_FAST
 	depends on MMU
 	bool
 
diff --git a/mm/gup.c b/mm/gup.c
index f1ac2c5a7f6d..929eb89c2e04 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -501,7 +501,7 @@ static inline void mm_set_has_pinned_flag(unsigned long *mm_flags)
 
 #ifdef CONFIG_MMU
 
-#if defined(CONFIG_ARCH_HAS_HUGEPD) || defined(CONFIG_HAVE_FAST_GUP)
+#if defined(CONFIG_ARCH_HAS_HUGEPD) || defined(CONFIG_HAVE_GUP_FAST)
 static int record_subpages(struct page *page, unsigned long sz,
 			   unsigned long addr, unsigned long end,
 			   struct page **pages)
@@ -515,7 +515,7 @@ static int record_subpages(struct page *page, unsigned long sz,
 
 	return nr;
 }
-#endif	/* CONFIG_ARCH_HAS_HUGEPD || CONFIG_HAVE_FAST_GUP */
+#endif	/* CONFIG_ARCH_HAS_HUGEPD || CONFIG_HAVE_GUP_FAST */
 
 #ifdef CONFIG_ARCH_HAS_HUGEPD
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
@@ -2785,7 +2785,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  *
  * This code is based heavily on the PowerPC implementation by Nick Piggin.
  */
-#ifdef CONFIG_HAVE_FAST_GUP
+#ifdef CONFIG_HAVE_GUP_FAST
 
 /*
  * Used in the GUP-fast path to determine whether GUP is permitted to work on
@@ -3364,7 +3364,7 @@ static inline void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 		unsigned int flags, struct page **pages, int *nr)
 {
 }
-#endif /* CONFIG_HAVE_FAST_GUP */
+#endif /* CONFIG_HAVE_GUP_FAST */
 
 #ifndef gup_fast_permitted
 /*
@@ -3384,7 +3384,7 @@ static unsigned long gup_fast(unsigned long start, unsigned long end,
 	int nr_pinned = 0;
 	unsigned seq;
 
-	if (!IS_ENABLED(CONFIG_HAVE_FAST_GUP) ||
+	if (!IS_ENABLED(CONFIG_HAVE_GUP_FAST) ||
 	    !gup_fast_permitted(start, end))
 		return 0;
 
diff --git a/mm/internal.h b/mm/internal.h
index 3df06a152ff0..be432314af3e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1249,7 +1249,7 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
 	}
 
 	/* Paired with a memory barrier in folio_try_share_anon_rmap_*(). */
-	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
+	if (IS_ENABLED(CONFIG_HAVE_GUP_FAST))
 		smp_rmb();
 
 	/*
-- 
2.44.0


