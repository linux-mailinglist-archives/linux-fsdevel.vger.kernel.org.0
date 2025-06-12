Return-Path: <linux-fsdevel+bounces-51434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76774AD6E45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D3E178E57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033D23C51C;
	Thu, 12 Jun 2025 10:51:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6D223339;
	Thu, 12 Jun 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725487; cv=none; b=oBlDTvljS9xVZrAbXVqKG5x9oUrXEMRvmBAELOCa6jK3gMpCzDlv5V/Ehh+kkL/zIc/2QCt88RRjzY6t88UHc7odAPYmb1uuDTu2rBRH0amgcH4Zle9xEwsGlM32T/QG/vmBhYrP/NOXzK6/71gusFdxSK3hxNtN3Cfd1mWiiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725487; c=relaxed/simple;
	bh=UZzeclDY+t72LopZhOCsfPtxy3MhuMyLEdOTtIboqBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB3mCco8f0yhpITBLibB5BwjDkKc/Wwebte0AwVeXfXow3tnO8d84XXma62rOLSAaVLfYJ/V2LNeQ38Iea3JIRFhL6vZCpUEdzmTK8HauunO+rUC6ZBpU7pcYpg/7Ldu5PpLlR4pSpzi7X3uCf04ku0kD2uB/48IZB8LeEmJBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bHzpr5vwHz9tGC;
	Thu, 12 Jun 2025 12:51:16 +0200 (CEST)
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
Subject: [PATCH 1/5] mm: move huge_zero_page declaration from huge_mm.h to mm.h
Date: Thu, 12 Jun 2025 12:50:56 +0200
Message-ID: <20250612105100.59144-2-p.raghav@samsung.com>
In-Reply-To: <20250612105100.59144-1-p.raghav@samsung.com>
References: <20250612105100.59144-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the declaration associated with huge_zero_page from huge_mm.h to
mm.h. This patch is in preparation for adding static PMD zero page.

No functional changes.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/huge_mm.h | 31 -------------------------------
 include/linux/mm.h      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..3e887374892c 100644
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
@@ -631,21 +615,6 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	return 0;
 }
 
-static inline bool is_huge_zero_folio(const struct folio *folio)
-{
-	return false;
-}
-
-static inline bool is_huge_zero_pmd(pmd_t pmd)
-{
-	return false;
-}
-
-static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
-{
-	return;
-}
-
 static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
 	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ef2ba0c667a..c8fbeaacf896 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4018,6 +4018,40 @@ static inline bool vma_is_special_huge(const struct vm_area_struct *vma)
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_HUGETLBFS */
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
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
+#else
+static inline bool is_huge_zero_folio(const struct folio *folio)
+{
+	return false;
+}
+
+static inline bool is_huge_zero_pmd(pmd_t pmd)
+{
+	return false;
+}
+
+static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
+{
+	return;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 #if MAX_NUMNODES > 1
 void __init setup_nr_node_ids(void);
 #else
-- 
2.49.0


