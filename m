Return-Path: <linux-fsdevel+bounces-49664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09276AC0824
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 11:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA253AB88B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164E4287505;
	Thu, 22 May 2025 09:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE62874FA;
	Thu, 22 May 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904589; cv=none; b=Uv3c/J/+J1T4RNk0F2qSW36ilmn6vavVF3xj4GgXoZPNiZbx7Fzhskd2bEKEwIONIoyGncXJlFvXE03v8YBXhoEFSFPq+mn2IZW62mpjrPQXZw6+dGqY8XpiBL9dcPVXnyokrhUsUBPIFN679RQixrGL9GhkExqm+7r8NWO8unY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904589; c=relaxed/simple;
	bh=N8AnvZ6bkNUoFEjqD/FmJwkOEekfKsIRvChCjR7Bvh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5l0IyWn+zyPtBeiOY8oaYnU4huEVkTFc7zRBmmkE+He5//4MLz5y1FqQZy5WIxOpzDngGbSoByTKrTZF4+SGj1obv5ZjPaYKn+ma9WRNYRABU0eVi2JSiq45IiC+TIuK5WyNFOqiwdkVRqPQm+ewH/yzu/hBXNRuPdwcUnLRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b32Pf4dHZz9scV;
	Thu, 22 May 2025 11:03:02 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
	Zi Yan <ziy@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	x86@kernel.org,
	mcgrof@kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC v2 1/2] mm: add THP_HUGE_ZERO_PAGE_ALWAYS config option
Date: Thu, 22 May 2025 11:02:42 +0200
Message-ID: <20250522090243.758943-2-p.raghav@samsung.com>
In-Reply-To: <20250522090243.758943-1-p.raghav@samsung.com>
References: <20250522090243.758943-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Add a config option THP_HUGE_ZERO_PAGE_ALWAYS that will always allocate
the huge_zero_folio, and it will never be freed. This makes using the
huge_zero_folio without having to pass any mm struct and call put_folio
in the destructor.

We can enable it by default for x86_64 where the PMD size is 2M.
It is good compromise between the memory and efficiency.
As a THP zero page might be wasteful for architectures with bigger page
sizes, let's not enable it for them.

[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/
[2] https://lore.kernel.org/linux-xfs/ZitIK5OnR7ZNY0IG@infradead.org/

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 arch/x86/Kconfig |  1 +
 mm/Kconfig       | 12 +++++++++
 mm/huge_memory.c | 63 ++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 63 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 055204dc211d..2e1527580746 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -152,6 +152,7 @@ config X86
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_WANTS_THP_ZERO_PAGE_ALWAYS	if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
diff --git a/mm/Kconfig b/mm/Kconfig
index bd08e151fa1b..a2994e7d55ba 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -823,6 +823,9 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARCH_WANTS_THP_SWAP
 	def_bool n
 
+config ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
+	def_bool n
+
 config MM_ID
 	def_bool n
 
@@ -895,6 +898,15 @@ config READ_ONLY_THP_FOR_FS
 	  support of file THPs will be developed in the next few release
 	  cycles.
 
+config THP_ZERO_PAGE_ALWAYS
+	def_bool y
+	depends on TRANSPARENT_HUGEPAGE && ARCH_WANTS_THP_ZERO_PAGE_ALWAYS
+	help
+	  Typically huge_zero_folio, which is a THP of zeroes, is allocated
+	  on demand and deallocated when not in use. This option will always
+	  allocate huge_zero_folio for zeroing and it is never deallocated.
+	  Not suitable for memory constrained systems.
+
 config NO_PAGE_MAPCOUNT
 	bool "No per-page mapcount (EXPERIMENTAL)"
 	help
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a..1a0556ca3839 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -247,9 +247,16 @@ static void put_huge_zero_page(void)
 	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
 }
 
+/*
+ * If THP_ZERO_PAGE_ALWAYS is enabled, @mm can be NULL, i.e, the huge_zero_folio
+ * is not associated with any mm_struct.
+ */
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
 {
-	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
+	if (!IS_ENABLED(CONFIG_THP_ZERO_PAGE_ALWAYS) && !mm)
+		return NULL;
+
+	if (IS_ENABLED(CONFIG_THP_ZERO_PAGE_ALWAYS) || test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
 		return READ_ONCE(huge_zero_folio);
 
 	if (!get_huge_zero_page())
@@ -263,6 +270,9 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
 
 void mm_put_huge_zero_folio(struct mm_struct *mm)
 {
+	if (IS_ENABLED(CONFIG_THP_ZERO_PAGE_ALWAYS))
+		return;
+
 	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
 		put_huge_zero_page();
 }
@@ -274,14 +284,21 @@ static unsigned long shrink_huge_zero_page_count(struct shrinker *shrink,
 	return atomic_read(&huge_zero_refcount) == 1 ? HPAGE_PMD_NR : 0;
 }
 
+static void _put_huge_zero_folio(void)
+{
+	struct folio *zero_folio;
+
+	zero_folio = xchg(&huge_zero_folio, NULL);
+	BUG_ON(zero_folio == NULL);
+	WRITE_ONCE(huge_zero_pfn, ~0UL);
+	folio_put(zero_folio);
+}
+
 static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 				       struct shrink_control *sc)
 {
 	if (atomic_cmpxchg(&huge_zero_refcount, 1, 0) == 1) {
-		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
-		BUG_ON(zero_folio == NULL);
-		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		folio_put(zero_folio);
+		_put_huge_zero_folio();
 		return HPAGE_PMD_NR;
 	}
 
@@ -850,10 +867,6 @@ static inline void hugepage_exit_sysfs(struct kobject *hugepage_kobj)
 
 static int __init thp_shrinker_init(void)
 {
-	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
-	if (!huge_zero_page_shrinker)
-		return -ENOMEM;
-
 	deferred_split_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
 						 SHRINKER_MEMCG_AWARE |
 						 SHRINKER_NONSLAB,
@@ -863,14 +876,21 @@ static int __init thp_shrinker_init(void)
 		return -ENOMEM;
 	}
 
-	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
-	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
-	shrinker_register(huge_zero_page_shrinker);
-
 	deferred_split_shrinker->count_objects = deferred_split_count;
 	deferred_split_shrinker->scan_objects = deferred_split_scan;
 	shrinker_register(deferred_split_shrinker);
 
+	if (IS_ENABLED(CONFIG_THP_ZERO_PAGE_ALWAYS))
+		return 0;
+
+	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
+	if (!huge_zero_page_shrinker)
+		return -ENOMEM;
+
+	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
+	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
+	shrinker_register(huge_zero_page_shrinker);
+
 	return 0;
 }
 
@@ -880,6 +900,17 @@ static void __init thp_shrinker_exit(void)
 	shrinker_free(deferred_split_shrinker);
 }
 
+static int __init huge_zero_page_init(void) {
+
+	if (!IS_ENABLED(CONFIG_THP_ZERO_PAGE_ALWAYS))
+		return 0;
+
+	if (!get_huge_zero_page()) {
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static int __init hugepage_init(void)
 {
 	int err;
@@ -903,6 +934,10 @@ static int __init hugepage_init(void)
 	if (err)
 		goto err_slab;
 
+	err = huge_zero_page_init();
+	if (err)
+		goto err_huge_zero_page;
+
 	err = thp_shrinker_init();
 	if (err)
 		goto err_shrinker;
@@ -925,6 +960,8 @@ static int __init hugepage_init(void)
 err_khugepaged:
 	thp_shrinker_exit();
 err_shrinker:
+	_put_huge_zero_folio();
+err_huge_zero_page:
 	khugepaged_destroy();
 err_slab:
 	hugepage_exit_sysfs(hugepage_kobj);
-- 
2.47.2


