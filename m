Return-Path: <linux-fsdevel+bounces-49888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED46AC4760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 07:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2121E1772EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 05:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D681DF244;
	Tue, 27 May 2025 05:05:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24E6DCE1;
	Tue, 27 May 2025 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748322318; cv=none; b=ipq2b/xo6i4xXdTxnMhin1TbA7Tj4JpoDMYs0sD6IhcjNl6UZdfAoFA7Z26ShPj/wc0f7eHCSIL5rWY3tuT2Is9gt13KBGgPuC/tKSa++S4Wk7WyEISJBt5ugi0TMW/oViooFSNKcbGQmiNH9UHERkqz/CIgBAOPKjvLWlXF9s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748322318; c=relaxed/simple;
	bh=E9jmb+XDhXxm1C81tUhUKNpzz6Ez9Inxwibg117dTRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzVukYgoUBbPeFgi27PHR4kP6FJdICnORQIHgFED0jijGUnOW82tIca+B5iFHjMuHLSTI631fWfEhX49nWBzG8kdyppGVDl4EQROqqAweIaizuc7FGY1uIwJeV/XgN0IZUJzKOvzfQ/aOCEzPoiA60huxFQ0HieTCKEqm4JxD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4b60tv5BxNz9tX0;
	Tue, 27 May 2025 07:05:11 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nico Pache <npache@redhat.com>,
	Dev Jain <dev.jain@arm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	willy@infradead.org,
	x86@kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 1/3] mm: move huge_zero_folio from huge_memory.c to memory.c
Date: Tue, 27 May 2025 07:04:50 +0200
Message-ID: <20250527050452.817674-2-p.raghav@samsung.com>
In-Reply-To: <20250527050452.817674-1-p.raghav@samsung.com>
References: <20250527050452.817674-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4b60tv5BxNz9tX0

The huge_zero_folio was initially placed in huge_memory.c as most of the
users were in that file. But it does not depend on THP, so it could very
well be a part of memory.c file.

As huge_zero_folio is going to be exposed to more users outside of mm,
let's move it to memory.c file.

This is a prep patch to add CONFIG_STATIC_PMD_ZERO_PAGE. No functional
changes.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h |  16 ------
 include/linux/mm.h      |  16 ++++++
 mm/huge_memory.c        | 105 +---------------------------------------
 mm/memory.c             |  99 +++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 119 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..d48973a6bd0f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -478,22 +478,6 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
-extern struct folio *huge_zero_folio;
-extern unsigned long huge_zero_pfn;
-
-static inline bool is_huge_zero_folio(const struct folio *folio)
-{
-	return READ_ONCE(huge_zero_folio) == folio;
-}
-
-static inline bool is_huge_zero_pmd(pmd_t pmd)
-{
-	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
-}
-
-struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
-void mm_put_huge_zero_folio(struct mm_struct *mm);
-
 static inline bool thp_migration_supported(void)
 {
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd2e513189d6..58d150dfc2da 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -69,6 +69,22 @@ static inline void totalram_pages_add(long count)
 
 extern void * high_memory;
 
+extern struct folio *huge_zero_folio;
+extern unsigned long huge_zero_pfn;
+
+static inline bool is_huge_zero_folio(const struct folio *folio)
+{
+	return READ_ONCE(huge_zero_folio) == folio;
+}
+
+static inline bool is_huge_zero_pmd(pmd_t pmd)
+{
+	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
+}
+
+struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
+void mm_put_huge_zero_folio(struct mm_struct *mm);
+
 #ifdef CONFIG_SYSCTL
 extern int sysctl_legacy_va_layout;
 #else
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..c6e203abb2de 100644
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
@@ -208,88 +205,6 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
-static bool get_huge_zero_page(void)
-{
-	struct folio *zero_folio;
-retry:
-	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
-		return true;
-
-	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO) & ~__GFP_MOVABLE,
-			HPAGE_PMD_ORDER);
-	if (!zero_folio) {
-		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
-		return false;
-	}
-	/* Ensure zero folio won't have large_rmappable flag set. */
-	folio_clear_large_rmappable(zero_folio);
-	preempt_disable();
-	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
-		preempt_enable();
-		folio_put(zero_folio);
-		goto retry;
-	}
-	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
-
-	/* We take additional reference here. It will be put back by shrinker */
-	atomic_set(&huge_zero_refcount, 2);
-	preempt_enable();
-	count_vm_event(THP_ZERO_PAGE_ALLOC);
-	return true;
-}
-
-static void put_huge_zero_page(void)
-{
-	/*
-	 * Counter should never go to zero here. Only shrinker can put
-	 * last reference.
-	 */
-	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
-}
-
-struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
-{
-	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
-		return READ_ONCE(huge_zero_folio);
-
-	if (!get_huge_zero_page())
-		return NULL;
-
-	if (test_and_set_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
-		put_huge_zero_page();
-
-	return READ_ONCE(huge_zero_folio);
-}
-
-void mm_put_huge_zero_folio(struct mm_struct *mm)
-{
-	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
-		put_huge_zero_page();
-}
-
-static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
-					struct shrink_control *sc)
-{
-	/* we can free zero page only if last reference remains */
-	return atomic_read(&huge_zero_refcount) == 1 ? HPAGE_PMD_NR : 0;
-}
-
-static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
-				       struct shrink_control *sc)
-{
-	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
-		BUG_ON(zero_folio == NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		folio_put(zero_folio);
-		return HPAGE_PMD_NR;
-	}
-
-	return 0;
-}
-
-static struct shrinker *huge_zero_page_shrinker;
-
 #ifdef CONFIG_SYSFS
 static ssize_t enabled_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *buf)
@@ -850,22 +765,12 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 
 static int __init thp_shrinker_init(void)
 {
-	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
-	if (!huge_zero_page_shrinker)
-		return -ENOMEM;
-
 	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
 						 SHRINKER_MEMCG_AWARE |
 						 SHRINKER_NONSLAB,
 						 "thp-deferred_split");
-	if (!deferred_split_shrinker) {
-		shrinker_free(huge_zero_page_shrinker);
+	if (!deferred_split_shrinker)
 		return -ENOMEM;
-	}
-
-	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
-	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
-	shrinker_register(huge_zero_page_shrinker);
 
 	deferred_split_shrinker->count_objects = deferred_split_count;
 	deferred_split_shrinker->scan_objects = deferred_split_scan;
@@ -874,12 +779,6 @@ static int __init thp_shrinker_init(void)
 	return 0;
 }
 
-static void __init thp_shrinker_exit(void)
-{
-	shrinker_free(huge_zero_page_shrinker);
-	shrinker_free(deferred_split_shrinker);
-}
-
 static int __init hugepage_init(void)
 {
 	int err;
@@ -923,7 +822,7 @@ static int __init hugepage_init(void)
 
 	return 0;
 err_khugepaged:
-	thp_shrinker_exit();
+	shrinker_free(deferred_split_shrinker);
 err_shrinker:
 	khugepaged_destroy();
 err_slab:
diff --git a/mm/memory.c b/mm/memory.c
index 5cb48f262ab0..11edc4d66e74 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -159,6 +159,105 @@ static int __init init_zero_pfn(void)
 }
 early_initcall(init_zero_pfn);
 
+static atomic_t huge_zero_refcount;
+struct folio *huge_zero_folio __read_mostly;
+unsigned long huge_zero_pfn __read_mostly = ~0UL;
+static struct shrinker *huge_zero_page_shrinker;
+
+static bool get_huge_zero_page(void)
+{
+	struct folio *zero_folio;
+retry:
+	if (likely(atomic_inc_not_zero(&huge_zero_refcount)))
+		return true;
+
+	zero_folio = folio_alloc((GFP_TRANSHUGE | __GFP_ZERO) & ~__GFP_MOVABLE,
+			HPAGE_PMD_ORDER);
+	if (!zero_folio) {
+		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
+		return false;
+	}
+	/* Ensure zero folio won't have large_rmappable flag set. */
+	folio_clear_large_rmappable(zero_folio);
+	preempt_disable();
+	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
+		preempt_enable();
+		folio_put(zero_folio);
+		goto retry;
+	}
+	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
+
+	/* We take additional reference here. It will be put back by shrinker */
+	atomic_set(&huge_zero_refcount, 2);
+	preempt_enable();
+	count_vm_event(THP_ZERO_PAGE_ALLOC);
+	return true;
+}
+
+static void put_huge_zero_page(void)
+{
+	/*
+	 * Counter should never go to zero here. Only shrinker can put
+	 * last reference.
+	 */
+	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
+}
+
+struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
+{
+	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
+		return READ_ONCE(huge_zero_folio);
+
+	if (!get_huge_zero_page())
+		return NULL;
+
+	if (test_and_set_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
+		put_huge_zero_page();
+
+	return READ_ONCE(huge_zero_folio);
+}
+
+void mm_put_huge_zero_folio(struct mm_struct *mm)
+{
+	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
+		put_huge_zero_page();
+}
+
+static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
+					struct shrink_control *sc)
+{
+	/* we can free zero page only if last reference remains */
+	return atomic_read(&huge_zero_refcount) == 1 ? HPAGE_PMD_NR : 0;
+}
+
+static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
+				       struct shrink_control *sc)
+{
+	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
+		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
+		BUG_ON(zero_folio == NULL);
+		WRITE_ONCE(huge_zero_pfn, ~0UL);
+		folio_put(zero_folio);
+		return HPAGE_PMD_NR;
+	}
+
+	return 0;
+}
+
+static int __init init_huge_zero_page(void)
+{
+	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
+	if (!huge_zero_page_shrinker)
+		return -ENOMEM;
+
+	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
+	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
+	shrinker_register(huge_zero_page_shrinker);
+
+	return 0;
+}
+early_initcall(init_huge_zero_page);
+
 void mm_trace_rss_stat(struct mm_struct *mm, int member)
 {
 	trace_rss_stat(mm, member);
-- 
2.47.2


