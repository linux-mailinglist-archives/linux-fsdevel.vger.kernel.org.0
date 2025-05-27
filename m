Return-Path: <linux-fsdevel+bounces-49889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D108AC4764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 07:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C821772F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 05:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462261F3FC8;
	Tue, 27 May 2025 05:05:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB91E5B7E;
	Tue, 27 May 2025 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748322322; cv=none; b=Djx4oAnbMjGkC7lZuCLJFoABh49EIQXz+UXnT9wsJg0Tp/2EgxQVqh2dErXQ+/CxvOSgrZhgo23nNTodJRIiSm8/SvMV9hPJlZi0vhFuvPYzPxdGjiUGnQvuRRZEtzycGlCSgh+cVPzPAGFdmjubOi7N0+c7GiJI3EF/9ZaCG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748322322; c=relaxed/simple;
	bh=rUvi7Mt+AHNe7Yj6bxgf6KQ/SLNM3UWDePEH/EO6Atw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKit1DcTkKQhiY8suTzhfN623U/cpXp1iM3uwkGfI52khDmSzz3osP+Mpum/NFIhdh6VOBQXISQvGuh9liwnJg9ucyuMZhpHmKGPeVzWij29Uy0OJYUisswyZLDQdc2/g55XBVj2G8/Q0f8LHZbZSDcvwqNW4+en+eoo0ufshXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4b60v06QP9z9tNF;
	Tue, 27 May 2025 07:05:16 +0200 (CEST)
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
Subject: [RFC 2/3] mm: add STATIC_PMD_ZERO_PAGE config option
Date: Tue, 27 May 2025 07:04:51 +0200
Message-ID: <20250527050452.817674-3-p.raghav@samsung.com>
In-Reply-To: <20250527050452.817674-1-p.raghav@samsung.com>
References: <20250527050452.817674-1-p.raghav@samsung.com>
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

Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
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
 mm/Kconfig       | 12 ++++++++++++
 mm/memory.c      | 30 ++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 055204dc211d..96f99b4f96ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -152,6 +152,7 @@ config X86
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP	if X86_64
 	select ARCH_WANT_HUGETLB_VMEMMAP_PREINIT if X86_64
 	select ARCH_WANTS_THP_SWAP		if X86_64
+	select ARCH_WANTS_STATIC_PMD_ZERO_PAGE if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
diff --git a/mm/Kconfig b/mm/Kconfig
index bd08e151fa1b..8f50f5c3f7a7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -826,6 +826,18 @@ config ARCH_WANTS_THP_SWAP
 config MM_ID
 	def_bool n
 
+config ARCH_WANTS_STATIC_PMD_ZERO_PAGE
+	bool
+
+config STATIC_PMD_ZERO_PAGE
+	def_bool y
+	depends on ARCH_WANTS_STATIC_PMD_ZERO_PAGE
+	help
+	  Typically huge_zero_folio, which is a PMD page of zeroes, is allocated
+	  on demand and deallocated when not in use. This option will always
+	  allocate huge_zero_folio for zeroing and it is never deallocated.
+	  Not suitable for memory constrained systems.
+
 menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
diff --git a/mm/memory.c b/mm/memory.c
index 11edc4d66e74..ab8c16d04307 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -203,9 +203,17 @@ static void put_huge_zero_page(void)
 	BUG_ON(atomic_dec_and_test(&huge_zero_refcount));
 }
 
+/*
+ * If STATIC_PMD_ZERO_PAGE is enabled, @mm can be NULL, i.e, the huge_zero_folio
+ * is not associated with any mm_struct.
+*/
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
 {
-	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
+	if (!IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE) && !mm)
+		return NULL;
+
+	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE) ||
+	    test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
 		return READ_ONCE(huge_zero_folio);
 
 	if (!get_huge_zero_page())
@@ -219,6 +227,9 @@ struct folio *mm_get_huge_zero_folio(struct mm_struct *mm)
 
 void mm_put_huge_zero_folio(struct mm_struct *mm)
 {
+	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE))
+		return;
+
 	if (test_bit(MMF_HUGE_ZERO_PAGE, &mm->flags))
 		put_huge_zero_page();
 }
@@ -246,15 +257,26 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
 
 static int __init init_huge_zero_page(void)
 {
+	int ret = 0;
+
+	if (IS_ENABLED(CONFIG_STATIC_PMD_ZERO_PAGE)) {
+		if (!get_huge_zero_page())
+			ret = -ENOMEM;
+		goto out;
+	}
+
 	huge_zero_page_shrinker = shrinker_alloc(0, "thp-zero");
-	if (!huge_zero_page_shrinker)
-		return -ENOMEM;
+	if (!huge_zero_page_shrinker) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	huge_zero_page_shrinker->count_objects = shrink_huge_zero_page_count;
 	huge_zero_page_shrinker->scan_objects = shrink_huge_zero_page_scan;
 	shrinker_register(huge_zero_page_shrinker);
 
-	return 0;
+out:
+	return ret;
 }
 early_initcall(init_huge_zero_page);
 
-- 
2.47.2


