Return-Path: <linux-fsdevel+bounces-73361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350FD16301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3664C30285C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049D274B40;
	Tue, 13 Jan 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQdsLnNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1106157480
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 01:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768268529; cv=none; b=Kd0EuZEnlMqNqQ/pDFYRqRoMfWLX9fbc9Xh8i+lyIfEqCOvZ42ZPeQKHlpWoabRqW/PVp98qHVWdzdGK9Ey5Da5lQ/VvcANh0wTReTxUoSfSs7/fX7ua1CHXEIfFdf+VTO2PCcpL2g309QUSl+2a0fNw5upZT68xoKuExs5A6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768268529; c=relaxed/simple;
	bh=aVNLfXxdDxvhVX/V/4QOVKkhNsGsbhUT7XvuFA4ovr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmOdw2YkCsm1cytytGpU7SqjdAGjiMsJ5zsardCNLYjDldE/oohoQ8l5taY8JtUkgu5/u8cKqy8ZT3klpeoAeZbJ+WFXxCzx9uQwHVuIfb3SGCoLzQ2nSfoVZudlnzap8C6UjXw2vfw2qRC1Ab73qGA6PMjRAbL2GNl1ne6Epns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQdsLnNT; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768268522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nSg0Sr0i9/iYvNCth7dJcLGX3q29Co2e1nhK6hxIKwk=;
	b=qQdsLnNTTE+YrJwkG2yOWnHtvAm+Yz6NIIuLvq5zg9JTyNYbGlCgXhoeb5qUBlwb9WF/xf
	OY0BqSuNvMAROtLhxwfgff4ioqYEtWiVQa2DghEqknCoeia4Mzah4p9rNONsa1zMjqlijp
	/fh+8UELvGXP/yEGj7x6BG3MHVAL470=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm: remove redundant page parameter from do_set_pmd()
Date: Tue, 13 Jan 2026 09:41:29 +0800
Message-ID: <20260113014130.922385-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

The page parameter passed to do_set_pmd() was always overwritten with
&folio->page immediately upon function entry (line 5369 in memory.c),
making the parameter completely redundant. This confused callers who
computed different page values only to have them ignored.

Changes:
- Convert page from a function parameter to a local variable
- Update function signature in both implementations and stub
- Remove unnecessary folio_file_page() calculation in filemap.c
- Update all three call sites to remove the page argument

This simplifies the API since folio already contains all the page
information needed. The function still uses &folio->page internally
for cache flushing and rmap operations.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 include/linux/mm.h | 2 +-
 mm/filemap.c       | 3 +--
 mm/khugepaged.c    | 6 +++---
 mm/memory.c        | 7 ++++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 710d20fc954b..cb1fe75575c3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1490,7 +1490,7 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 	return pte;
 }
 
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page);
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio);
 void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..4be5f3f5b8d6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3678,8 +3678,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	}
 
 	if (pmd_none(*vmf->pmd) && folio_test_pmd_mappable(folio)) {
-		struct page *page = folio_file_page(folio, start);
-		vm_fault_t ret = do_set_pmd(vmf, folio, page);
+		vm_fault_t ret = do_set_pmd(vmf, folio);
 		if (!ret) {
 			/* The page is mapped successfully, reference consumed. */
 			folio_unlock(folio);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 9f790ec34400..2d7b23efa11b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1442,7 +1442,7 @@ static void collect_mm_slot(struct mm_slot *slot)
 
 /* folio must be locked, and mmap_lock must be held */
 static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
-				     pmd_t *pmdp, struct folio *folio, struct page *page)
+				     pmd_t *pmdp, struct folio *folio)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_fault vmf = {
@@ -1470,7 +1470,7 @@ static enum scan_result set_huge_pmd(struct vm_area_struct *vma, unsigned long a
 	}
 
 	vmf.pmd = pmdp;
-	if (do_set_pmd(&vmf, folio, page))
+	if (do_set_pmd(&vmf, folio))
 		return SCAN_FAIL;
 
 	folio_get(folio);
@@ -1678,7 +1678,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 maybe_install_pmd:
 	/* step 5: install pmd entry */
 	result = install_pmd
-			? set_huge_pmd(vma, haddr, pmd, folio, &folio->page)
+			? set_huge_pmd(vma, haddr, pmd, folio)
 			: SCAN_SUCCEED;
 	goto drop_folio;
 abort:
diff --git a/mm/memory.c b/mm/memory.c
index 30a897018482..8b29ecbfe7fa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5342,8 +5342,9 @@ static void deposit_prealloc_pte(struct vm_fault *vmf)
 	vmf->prealloc_pte = NULL;
 }
 
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio)
 {
+	struct page *page;
 	struct vm_area_struct *vma = vmf->vma;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
@@ -5418,7 +5419,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	return ret;
 }
 #else
-vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *page)
+vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio)
 {
 	return VM_FAULT_FALLBACK;
 }
@@ -5542,7 +5543,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	if (pmd_none(*vmf->pmd)) {
 		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
-			ret = do_set_pmd(vmf, folio, page);
+			ret = do_set_pmd(vmf, folio);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
 		}
-- 
2.43.0


