Return-Path: <linux-fsdevel+bounces-51436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC0AD6E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CA7189341B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEBD239E62;
	Thu, 12 Jun 2025 10:51:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA61239570;
	Thu, 12 Jun 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725495; cv=none; b=Ls/7+TyW9c6a/giKMCmhKSwPlNZCtcmXar0gyy3+mmxYKZqOEHE1dnceEkVTBljSIOqFDlEgZCfMNhQLb3+uV7YvRiKEeXid0iIoSDsBsNSg6peLIjyHKVAYMzImGqIFz2rOPSTqQrex1xuBIS/Jvb53eBI2mIFSGeoE4HtWagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725495; c=relaxed/simple;
	bh=Yu3zq6evcS3iRIzSO3AOHAbZ4FI9g5mt/47mh+3hLAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VetgYPgIwJo7SqFzXv/Pi7miIZYCMSYQWmvt6SC2DRi/wbhQ0n8L8KxizbWY8dHjHNJR/3XUo6khc+QAkImAnn5M94V5xPLO3ow3n3DQOOhD3v3rNOSz18QmTKRgHmdQ4Uivl7c+mTx8GAl/nk8k6PTt23+YYV6JXk7Hy/4szxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bHzq5122sz9sx5;
	Thu, 12 Jun 2025 12:51:29 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 3/5] mm: add static PMD zero page
Date: Thu, 12 Jun 2025 12:50:58 +0200
Message-ID: <20250612105100.59144-4-p.raghav@samsung.com>
In-Reply-To: <20250612105100.59144-1-p.raghav@samsung.com>
References: <20250612105100.59144-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bHzq5122sz9sx5

There are many places in the kernel where we need to zeroout larger
chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
is limited by PAGE_SIZE.

This is especially annoying in block devices and filesystems where we
attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
bvec support in block layer, it is much more efficient to send out
larger zero pages as a part of single bvec.

This concern was raised during the review of adding LBS support to
XFS[1][2].

Usually huge_zero_folio is allocated on demand, and it will be
deallocated by the shrinker if there are no users of it left.

Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
the huge_zero_folio in .bss, and it will never be freed. This makes using the
huge_zero_folio without having to pass any mm struct and call put_folio
in the destructor.

As STATIC_PMD_ZERO_PAGE does not depend on THP, declare huge_zero_folio
and huge_zero_pfn outside of the THP ifdef.

It can only be enabled from x86_64, but it is an optional config. We
could expand it more architectures in the future.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Questions:
- Can we call __split_huge_zero_page_pmd() on static PMD page?

 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/pgtable.h |  8 ++++++++
 arch/x86/kernel/head_64.S      |  8 ++++++++
 include/linux/mm.h             | 16 +++++++++++++++-
 mm/Kconfig                     | 13 +++++++++++++
 mm/huge_memory.c               | 24 ++++++++++++++++++++----
 mm/memory.c                    | 19 +++++++++++++++++++
 7 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 340e5468980e..c3a9d136ec0a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_HAS_STATIC_PMD_ZERO_PAGE	if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 774430c3abff..7013a7d26da5 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -47,6 +47,14 @@ void ptdump_walk_user_pgd_level_checkwx(void);
 #define debug_checkwx_user()	do { } while (0)
 #endif
 
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+/*
+ * PMD_ZERO_PAGE is a global shared PMD page that is always zero.
+ */
+extern unsigned long empty_pmd_zero_page[(PMD_SIZE) / sizeof(unsigned long)]
+	__visible;
+#endif
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3e9b3a3bd039..86aaa53fd619 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -714,6 +714,14 @@ EXPORT_SYMBOL(phys_base)
 #include "../xen/xen-head.S"
 
 	__PAGE_ALIGNED_BSS
+
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+SYM_DATA_START_PAGE_ALIGNED(empty_pmd_zero_page)
+	.skip PMD_SIZE
+SYM_DATA_END(empty_pmd_zero_page)
+EXPORT_SYMBOL(empty_pmd_zero_page)
+#endif
+
 SYM_DATA_START_PAGE_ALIGNED(empty_zero_page)
 	.skip PAGE_SIZE
 SYM_DATA_END(empty_zero_page)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c8fbeaacf896..b20d60d68b3c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4018,10 +4018,10 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct folio *huge_zero_folio;
 extern unsigned long huge_zero_pfn;
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
 	return READ_ONCE(huge_zero_folio) == folio;
@@ -4032,9 +4032,23 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
 }
 
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+static inline struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
+{
+	return READ_ONCE(huge_zero_folio);
+}
+
+static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
+{
+	return;
+}
+
+#else
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
 
+#endif /* CONFIG_STATIC_PMD_ZERO_PAGE */
+
 #else
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
diff --git a/mm/Kconfig b/mm/Kconfig
index 781be3240e21..fd1c51995029 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -826,6 +826,19 @@ config ARCH_WANTS_THP_SWAP
 config MM_ID
 	def_bool n
 
+config ARCH_HAS_STATIC_PMD_ZERO_PAGE
+	def_bool n
+
+config STATIC_PMD_ZERO_PAGE
+	bool "Allocate a PMD page for zeroing"
+	depends on ARCH_HAS_STATIC_PMD_ZERO_PAGE
+	help
+	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
+	  on demand and deallocated when not in use. This option will
+	  allocate a PMD sized zero page in .bss and huge_zero_folio will
+	  use it instead allocating dynamically.
+	  Not suitable for memory constrained systems.
+
 menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 101b67ab2eb6..c12ca7134e88 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -75,9 +75,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
 static bool split_underused_thp = true;
 
-static atomic_t huge_zero_refcount;
-struct folio *huge_zero_folio __read_mostly;
-unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
@@ -208,6 +205,23 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+static int huge_zero_page_shrinker_init(void)
+{
+	return 0;
+}
+
+static void huge_zero_page_shrinker_exit(void)
+{
+	return;
+}
+#else
+
+static struct shrinker *huge_zero_page_shrinker;
+static atomic_t huge_zero_refcount;
+struct folio *huge_zero_folio __read_mostly;
+unsigned long huge_zero_pfn __read_mostly = ~0UL;
+
 static bool get_huge_zero_page(void)
 {
 	struct folio *zero_folio;
@@ -288,7 +302,6 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 	return 0;
 }
 
-static struct shrinker *huge_zero_page_shrinker;
 static int huge_zero_page_shrinker_init(void)
 {
 	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
@@ -307,6 +320,7 @@ static void huge_zero_page_shrinker_exit(void)
 	return;
 }
 
+#endif
 
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
@@ -2843,6 +2857,8 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	pte_t *pte;
 	int i;
 
+	// FIXME: can this be called with static zero page?
+	VM_BUG_ON(IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE));
 	/*
 	 * Leave pmd empty until pte is filled note that it is fine to delay
 	 * notification until mmu_notifier_invalidate_range_end() as we are
diff --git a/mm/memory.c b/mm/memory.c
index 8eba595056fe..77721f5ae043 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -159,6 +159,25 @@ static int __init init_zero_pfn(void)
 }
 early_initcall(init_zero_pfn);
 
+#ifdef CONFIG_STATIC_PMD_ZERO_PAGE
+struct folio *huge_zero_folio __read_mostly;
+unsigned long huge_zero_pfn __read_mostly = ~0UL;
+
+static int __init init_pmd_zero_pfn(void)
+{
+	huge_zero_folio = virt_to_folio(empty_pmd_zero_page);
+	huge_zero_pfn = page_to_pfn(virt_to_page(empty_pmd_zero_page));
+
+	__folio_set_head(huge_zero_folio);
+	prep_compound_head((struct page *)huge_zero_folio, PMD_ORDER);
+	/* Ensure zero folio won't have large_rmappable flag set. */
+	folio_clear_large_rmappable(huge_zero_folio);
+
+	return 0;
+}
+early_initcall(init_pmd_zero_pfn);
+#endif
+
 void mm_trace_rss_stat(struct mm_struct *mm, int member)
 {
 	trace_rss_stat(mm, member);
-- 
2.49.0


