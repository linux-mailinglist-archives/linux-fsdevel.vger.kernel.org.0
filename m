Return-Path: <linux-fsdevel+bounces-56639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1EB1A100
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 14:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DF1189C14F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640A25A344;
	Mon,  4 Aug 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="kng33P8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450D2580F7;
	Mon,  4 Aug 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309674; cv=none; b=EbIRPBrSp+kLn1mfiiRIcgzsOHRMsWZJsuuYuipTCTGdljnpAbwHqOXVdSyf95CuTAxFDJL6ef7Qb1Iauh9FmfxTATQzuzHbSELGHZTDRdNpfXbKiZ2nAbeNin89Hvx70zbQ1KGifp0zlUDwxRRQzVsSVjJN6FnE9yY53dEL5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309674; c=relaxed/simple;
	bh=LOWusdy/tgbd374PucOt+i12ZWi01OrqnWhG5hl6yoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hav332dyLV1rqcfQgbutQDZq3qk9OgSvh/9ePBszuNEamMMYjHpvivajZ00VXptxBFswS4nbkz2zp44Qyt/bqcaxfZG/1Cbc96JUWld8UtygrwizDwLtIjNuyGmcEQ9GTNMeUmwGCUO9L13aSVjCFsFVtaQ6UAtlg2VZ/7mkkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=kng33P8J; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bwb8N5XPnz9t4V;
	Mon,  4 Aug 2025 14:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1754309668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lJsTh+ri0GWL7AJeRsPrPgXU3IEK6w18AYWDMyJ55E=;
	b=kng33P8JYjLm434SEri9Gmt25PK/1/+YsynuwJvQWoLTeFnmhKrwcZGBPx4fXxBLoSlgRm
	m0MEq5k/IvpBw03o9qS6PkuettM1qUNoWyrhrs6SiZbVu/FN+hVTsIJRFyxDwMwFFuc51Z
	UIBv0TvGYKXO6IfIp4/X3sMEMMyO2x0MNzzNVtLiKfkjUmDp3sfhvT/cIsWRvgffbgK1C1
	i2/W3REQarIhCtlBCCbFF1NTMxAN8lPUz2Phjt8kxIG0aAe42nx0sTPiKLxr9CeKWryhyg
	e3ZH6LfD2EuIs74dKyNHP9mbuMYJYUwh4G9Tu9B2KshUiIPAoaUOcIg7kuDsvg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
	willy@infradead.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 3/5] mm: add static huge zero folio
Date: Mon,  4 Aug 2025 14:13:54 +0200
Message-ID: <20250804121356.572917-4-kernel@pankajraghav.com>
In-Reply-To: <20250804121356.572917-1-kernel@pankajraghav.com>
References: <20250804121356.572917-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

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
deallocated by the shrinker if there are no users of it left. At moment,
huge_zero_folio infrastructure refcount is tied to the process lifetime
that created it. This might not work for bio layer as the completions
can be async and the process that created the huge_zero_folio might no
longer be alive. And, one of the main point that came during discussion
is to have something bigger than zero page as a drop-in replacement.

Add a config option STATIC_HUGE_ZERO_FOLIO that will result in allocating
the huge zero folio on first request, if not already allocated, and turn
it static such that it can never get freed. This makes using the
huge_zero_folio without having to pass any mm struct and does not tie the
lifetime of the zero folio to anything, making it a drop-in replacement
for ZERO_PAGE.

If STATIC_HUGE_ZERO_FOLIO config option is enabled, then
mm_get_huge_zero_folio() will simply return this page instead of
dynamically allocating a new PMD page.

This option can waste memory in small systems or systems with 64k base
page size. So make it an opt-in and also add an option from individual
architecture so that we don't enable this feature for larger base page
size systems. Only x86 is enabled as a part of this series. Other
architectures shall be enabled as a follow-up to this series.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 arch/x86/Kconfig        |  1 +
 include/linux/huge_mm.h | 18 ++++++++++++++++
 mm/Kconfig              | 21 +++++++++++++++++++
 mm/huge_memory.c        | 46 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0ce86e14ab5e..8e2aa1887309 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -153,6 +153,7 @@ config X86
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..78ebceb61d0e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -476,6 +476,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
 extern unsigned long huge_zero_pfn;
+extern atomic_t huge_zero_folio_is_static;
 
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
@@ -494,6 +495,18 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
+struct folio *__get_static_huge_zero_folio(void);
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+	if (!IS_ENABLED(CONFIG_STATIC_HUGE_ZERO_FOLIO))
+		return NULL;
+
+	if (likely(atomic_read(&huge_zero_folio_is_static)))
+		return huge_zero_folio;
+
+	return __get_static_huge_zero_folio();
+}
 
 static inline bool thp_migration_supported(void)
 {
@@ -685,6 +698,11 @@ static inline int change_huge_pud(struct mmu_gather *tlb,
 {
 	return 0;
 }
+
+static inline struct folio *get_static_huge_zero_folio(void)
+{
+	return NULL;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline int split_folio_to_list_to_order(struct folio *folio,
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf..366a6d2d771e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -823,6 +823,27 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARCH_WANTS_THP_SWAP
 	def_bool n
 
+config ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO
+	def_bool n
+
+config STATIC_HUGE_ZERO_FOLIO
+	bool "Allocate a PMD sized folio for zeroing"
+	depends on ARCH_WANTS_STATIC_HUGE_ZERO_FOLIO && TRANSPARENT_HUGEPAGE
+	help
+	  Without this config enabled, the huge zero folio is allocated on
+	  demand and freed under memory pressure once no longer in use.
+	  To detect remaining users reliably, references to the huge zero folio
+	  must be tracked precisely, so it is commonly only available for mapping
+	  it into user page tables.
+
+	  With this config enabled, the huge zero folio can also be used
+	  for other purposes that do not implement precise reference counting:
+	  it is still allocated on demand, but never freed, allowing for more
+	  wide-spread use, for example, when performing I/O similar to the
+	  traditional shared zeropage.
+
+	  Not suitable for memory constrained systems.
+
 config MM_ID
 	def_bool n
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index ff06dee213eb..e117b280b38d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -75,6 +75,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
+atomic_t huge_zero_folio_is_static __read_mostly;
 struct folio *huge_zero_folio __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
@@ -266,6 +267,45 @@ void mm_put_huge_zero_folio(struct mm_struct *mm)
 		put_huge_zero_folio();
 }
 
+#ifdef CONFIG_STATIC_HUGE_ZERO_FOLIO
+
+struct folio *__get_static_huge_zero_folio(void)
+{
+	static unsigned long fail_count_clear_timer;
+	static atomic_t huge_zero_static_fail_count __read_mostly;
+
+	if (unlikely(!slab_is_available()))
+		return NULL;
+
+	/*
+	 * If we failed to allocate a huge zero folio, just refrain from
+	 * trying for one minute before retrying to get a reference again.
+	 */
+	if (atomic_read(&huge_zero_static_fail_count) > 1) {
+		if (time_before(jiffies, fail_count_clear_timer))
+			return NULL;
+		atomic_set(&huge_zero_static_fail_count, 0);
+	}
+	/*
+	 * Our raised reference will prevent the shrinker from ever having
+	 * success.
+	 */
+	if (!get_huge_zero_folio()) {
+		int count = atomic_inc_return(&huge_zero_static_fail_count);
+
+		if (count > 1)
+			fail_count_clear_timer = get_jiffies_64() + 60 * HZ;
+
+		return NULL;
+	}
+
+	if (atomic_cmpxchg(&huge_zero_folio_is_static, 0, 1) != 0)
+		put_huge_zero_folio();
+
+	return huge_zero_folio;
+}
+#endif /* CONFIG_STATIC_HUGE_ZERO_FOLIO */
+
 static unsigned long shrink_huge_zero_folio_count(struct shrinker *shrink,
 						  struct shrink_control *sc)
 {
@@ -277,7 +317,11 @@ static unsigned long shrink_huge_zero_folio_scan(struct shrinker *shrink,
 						 struct shrink_control *sc)
 {
 	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
+		struct folio *zero_folio;
+
+		if (WARN_ON_ONCE(atomic_read(&huge_zero_folio_is_static)))
+			return 0;
+		zero_folio = xchg(&huge_zero_folio, NULL);
 		BUG_ON(zero_folio == NULL);
 		WRITE_ONCE(huge_zero_pfn, ~0UL);
 		folio_put(zero_folio);
-- 
2.49.0


