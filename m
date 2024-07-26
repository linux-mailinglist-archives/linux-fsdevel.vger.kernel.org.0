Return-Path: <linux-fsdevel+bounces-24328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0F293D59E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ED91F22FFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EE144D0A;
	Fri, 26 Jul 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZu8Weuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555121EB31
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006481; cv=none; b=I5PEbg3aTTDNIT0alXbQ3R7WHbrQR/hBSZEWr4dZcHWe1UjcvoP2NGoIlVw6bcHwZnyhLM90cg76OUxN0V/RGQHnFlO/U1yftzhP+NM+FfBCUDj3fejW9HImIakB5yaMNDNgosXvSZOjPBhhJ2l/l0AFcxK/56WH8dPE+YtPs7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006481; c=relaxed/simple;
	bh=KjmopehcDIzw1FnJ5egxCzXY/9FmBhpJcNQJfW7rVNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFPCzR6ZCHry5RorOHa3oRe6IfGHPzEZCghX4JUlmAtv8Qv+pmZtmDGG72sbD9pnIX8Jdb+m4HjyQalepH7OfuPasp5N9OOR9nbZmEULFmC94eC5goujwUv8Y+rvhu+/hh73yVlBfX0j6FFIiDUxS1FMcCHwmnMfNnVDYQgfBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZu8Weuq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722006478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMo8fPcevHXuY+AOXboYttXTm4mmJMhIiWopBrN6CAw=;
	b=RZu8Weuqb3hL24oTAFtChz91K+a59RIgiD+eKRjhlmydLUIL0zf+5GUhKPkk0TO+Y3n5eM
	X/gjjHnBaSX48nvfZk7TnM9BRcE5QW6oOGjXS/AUvHb9jf0BCEpNKsJqxgtREhC91HKodg
	vsTfOpvf++zXOCvU4Qs/2veMH/0fuYM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-UZOl2F6gMmGTdFJuxLRNgg-1; Fri,
 26 Jul 2024 11:07:54 -0400
X-MC-Unique: UZOl2F6gMmGTdFJuxLRNgg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 911FC1956046;
	Fri, 26 Jul 2024 15:07:50 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70DC71955D4C;
	Fri, 26 Jul 2024 15:07:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 1/3] mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options
Date: Fri, 26 Jul 2024 17:07:26 +0200
Message-ID: <20240726150728.3159964-2-david@redhat.com>
In-Reply-To: <20240726150728.3159964-1-david@redhat.com>
References: <20240726150728.3159964-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Let's clean that up a bit and prepare for depending on
CONFIG_SPLIT_PMD_PTLOCKS in other Kconfig options.

More cleanups would be reasonable (like the arch-specific "depends on"
for CONFIG_SPLIT_PTE_PTLOCKS), but we'll leave that for another day.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm/mm/fault-armv.c      |  6 +++---
 arch/x86/xen/mmu_pv.c         |  7 ++++---
 include/linux/mm.h            |  8 ++++----
 include/linux/mm_types.h      |  2 +-
 include/linux/mm_types_task.h |  3 ---
 kernel/fork.c                 |  4 ++--
 mm/Kconfig                    | 18 +++++++++++-------
 mm/memory.c                   |  2 +-
 8 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 2286c2ea60ec4..831793cd6ff94 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -61,7 +61,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	return ret;
 }
 
-#if USE_SPLIT_PTE_PTLOCKS
+#if defined(CONFIG_SPLIT_PTE_PTLOCKS)
 /*
  * If we are using split PTE locks, then we need to take the page
  * lock here.  Otherwise we are using shared mm->page_table_lock
@@ -80,10 +80,10 @@ static inline void do_pte_unlock(spinlock_t *ptl)
 {
 	spin_unlock(ptl);
 }
-#else /* !USE_SPLIT_PTE_PTLOCKS */
+#else /* !defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 static inline void do_pte_lock(spinlock_t *ptl) {}
 static inline void do_pte_unlock(spinlock_t *ptl) {}
-#endif /* USE_SPLIT_PTE_PTLOCKS */
+#endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	unsigned long pfn)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index f1ce39d6d32cb..f4a316894bbb4 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -665,7 +665,7 @@ static spinlock_t *xen_pte_lock(struct page *page, struct mm_struct *mm)
 {
 	spinlock_t *ptl = NULL;
 
-#if USE_SPLIT_PTE_PTLOCKS
+#if defined(CONFIG_SPLIT_PTE_PTLOCKS)
 	ptl = ptlock_ptr(page_ptdesc(page));
 	spin_lock_nest_lock(ptl, &mm->page_table_lock);
 #endif
@@ -1553,7 +1553,8 @@ static inline void xen_alloc_ptpage(struct mm_struct *mm, unsigned long pfn,
 
 		__set_pfn_prot(pfn, PAGE_KERNEL_RO);
 
-		if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS && !pinned)
+		if (level == PT_PTE && IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS) &&
+		    !pinned)
 			__pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);
 
 		xen_mc_issue(XEN_LAZY_MMU);
@@ -1581,7 +1582,7 @@ static inline void xen_release_ptpage(unsigned long pfn, unsigned level)
 	if (pinned) {
 		xen_mc_batch();
 
-		if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
+		if (level == PT_PTE && IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS))
 			__pin_pagetable_pfn(MMUEXT_UNPIN_TABLE, pfn);
 
 		__set_pfn_prot(pfn, PAGE_KERNEL);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0472a5090b180..dff43101572ec 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2843,7 +2843,7 @@ static inline void pagetable_free(struct ptdesc *pt)
 	__free_pages(page, compound_order(page));
 }
 
-#if USE_SPLIT_PTE_PTLOCKS
+#if defined(CONFIG_SPLIT_PTE_PTLOCKS)
 #if ALLOC_SPLIT_PTLOCKS
 void __init ptlock_cache_init(void);
 bool ptlock_alloc(struct ptdesc *ptdesc);
@@ -2895,7 +2895,7 @@ static inline bool ptlock_init(struct ptdesc *ptdesc)
 	return true;
 }
 
-#else	/* !USE_SPLIT_PTE_PTLOCKS */
+#else	/* !defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
  */
@@ -2906,7 +2906,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pte_t *pte)
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
-#endif /* USE_SPLIT_PTE_PTLOCKS */
+#endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
 
 static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
@@ -2966,7 +2966,7 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
 		NULL: pte_offset_kernel(pmd, address))
 
-#if USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
 
 static inline struct page *pmd_pgtable_page(pmd_t *pmd)
 {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4854249792545..165c58b12ccc9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -947,7 +947,7 @@ struct mm_struct {
 #ifdef CONFIG_MMU_NOTIFIER
 		struct mmu_notifier_subscriptions *notifier_subscriptions;
 #endif
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index a2f6179b672b8..bff5706b76e14 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -16,9 +16,6 @@
 #include <asm/tlbbatch.h>
 #endif
 
-#define USE_SPLIT_PTE_PTLOCKS	(NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
-#define USE_SPLIT_PMD_PTLOCKS	(USE_SPLIT_PTE_PTLOCKS && \
-		IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
 #define ALLOC_SPLIT_PTLOCKS	(SPINLOCK_SIZE > BITS_PER_LONG/8)
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index a8362c26ebcb0..216ce9ba4f4e6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -832,7 +832,7 @@ static void check_mm(struct mm_struct *mm)
 		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
 				mm_pgtables_bytes(mm));
 
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
 #endif
 }
@@ -1276,7 +1276,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	mm->pmd_huge_pte = NULL;
 #endif
 	mm_init_uprobes_state(mm);
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f789..7b716ac802726 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -585,17 +585,21 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 # at the same time (e.g. copy_page_range()).
 # DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC spinlock_t also enlarge struct page.
 #
-config SPLIT_PTLOCK_CPUS
-	int
-	default "999999" if !MMU
-	default "999999" if ARM && !CPU_CACHE_VIPT
-	default "999999" if PARISC && !PA20
-	default "999999" if SPARC32
-	default "4"
+config SPLIT_PTE_PTLOCKS
+	def_bool y
+	depends on MMU
+	depends on NR_CPUS >= 4
+	depends on !ARM || CPU_CACHE_VIPT
+	depends on !PARISC || PA20
+	depends on !SPARC32
 
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	bool
 
+config SPLIT_PMD_PTLOCKS
+	def_bool y
+	depends on SPLIT_PTE_PTLOCKS && ARCH_ENABLE_SPLIT_PMD_PTLOCK
+
 #
 # support for memory balloon
 config MEMORY_BALLOON
diff --git a/mm/memory.c b/mm/memory.c
index 833d2cad6eb29..714589582fe15 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6559,7 +6559,7 @@ long copy_folio_from_user(struct folio *dst_folio,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
-#if USE_SPLIT_PTE_PTLOCKS && ALLOC_SPLIT_PTLOCKS
+#if defined(CONFIG_SPLIT_PTE_PTLOCKS) && ALLOC_SPLIT_PTLOCKS
 
 static struct kmem_cache *page_ptl_cachep;
 
-- 
2.45.2


