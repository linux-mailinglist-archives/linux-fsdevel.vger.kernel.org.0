Return-Path: <linux-fsdevel+bounces-16679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B619F8A14D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE9828BDFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D33A1C2;
	Thu, 11 Apr 2024 12:42:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DA40C09
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839364; cv=none; b=rj9dfN9Ru3QVlDAoT9/X7Ogw+Wp5jswOmURXz3hoWW89+62BhZJT9Z23KZsuyMy5rJXQhl9E+XlsHEGj5vFpyGgsS9+zCmiI4EoHN8n8nmUb3BO5wImA8ThlehWXI7+IVHm85sRcXsOw2Vlo0u786kyegV9yMDUljZiOfdObLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839364; c=relaxed/simple;
	bh=f8gwdgYnF09rjD0vU+T8pxLkwVLsy/6GLrfRfYRExbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htuz+zZV4GtCafXvuRfIdxdkb8x9NyGO3uA7uCD9+ymyp4G815T0kKi7YGDznxyU+VFlQq4SfqeNEDzsJ4Q8M2LzYGxh4cbs+QIg85ehnnGA5a8yvHdA45ieZDsidYmG7UvxyDDokrMXTzlsA7Oy0zPTMuuiCPzJPoRrfG0QfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VFfRp4M65z1yn4d;
	Thu, 11 Apr 2024 20:40:22 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 768A71400D9;
	Thu, 11 Apr 2024 20:42:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 20:42:39 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] mm: move mm counter updating out of set_pte_range()
Date: Thu, 11 Apr 2024 21:09:49 +0800
Message-ID: <20240411130950.73512-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411130950.73512-1-wangkefeng.wang@huawei.com>
References: <20240411130950.73512-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

In order to support batch mm counter updating in filemap_map_pages(),
make set_pte_range() return the type of MM_COUNTERS and move mm counter
updating out of set_pte_range().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h |  4 ++--
 mm/filemap.c       | 10 +++++++---
 mm/memory.c        | 16 +++++++++++-----
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b4046b1e63d..6ad440ac3706 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1366,8 +1366,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 }
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
-void set_pte_range(struct vm_fault *vmf, struct folio *folio,
-		struct page *page, unsigned int nr, unsigned long addr);
+int set_pte_range(struct vm_fault *vmf, struct folio *folio,
+		  struct page *page, unsigned int nr, unsigned long addr);
 
 vm_fault_t finish_fault(struct vm_fault *vmf);
 #endif
diff --git a/mm/filemap.c b/mm/filemap.c
index 92e2d43e4c9d..2274e590bab4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3512,6 +3512,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	struct page *page = folio_page(folio, start);
 	unsigned int count = 0;
 	pte_t *old_ptep = vmf->pte;
+	int type;
 
 	do {
 		if (PageHWPoison(page + count))
@@ -3539,7 +3540,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		continue;
 skip:
 		if (count) {
-			set_pte_range(vmf, folio, page, count, addr);
+			type = set_pte_range(vmf, folio, page, count, addr);
+			add_mm_counter(vmf->vma->vm_mm, type, count);
 			folio_ref_add(folio, count);
 			if (in_range(vmf->address, addr, count * PAGE_SIZE))
 				ret = VM_FAULT_NOPAGE;
@@ -3553,7 +3555,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	} while (--nr_pages > 0);
 
 	if (count) {
-		set_pte_range(vmf, folio, page, count, addr);
+		type = set_pte_range(vmf, folio, page, count, addr);
+		add_mm_counter(vmf->vma->vm_mm, type, count);
 		folio_ref_add(folio, count);
 		if (in_range(vmf->address, addr, count * PAGE_SIZE))
 			ret = VM_FAULT_NOPAGE;
@@ -3589,7 +3592,8 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	if (vmf->address == addr)
 		ret = VM_FAULT_NOPAGE;
 
-	set_pte_range(vmf, folio, page, 1, addr);
+	add_mm_counter(vmf->vma->vm_mm,
+		       set_pte_range(vmf, folio, page, 1, addr), 1);
 	folio_ref_inc(folio);
 
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 78422d1c7381..485ffec9d4c7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4661,15 +4661,18 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
  * @page: The first page to create a PTE for.
  * @nr: The number of PTEs to create.
  * @addr: The first address to create a PTE for.
+ *
+ * Return: type of MM_COUNTERS to be updated
  */
-void set_pte_range(struct vm_fault *vmf, struct folio *folio,
-		struct page *page, unsigned int nr, unsigned long addr)
+int set_pte_range(struct vm_fault *vmf, struct folio *folio,
+		  struct page *page, unsigned int nr, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = in_range(vmf->address, addr, nr * PAGE_SIZE);
 	pte_t entry;
+	int type;
 
 	flush_icache_pages(vma, page, nr);
 	entry = mk_pte(page, vma->vm_page_prot);
@@ -4685,18 +4688,20 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
-		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr);
+		type = MM_ANONPAGES;
 		VM_BUG_ON_FOLIO(nr != 1, folio);
 		folio_add_new_anon_rmap(folio, vma, addr);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		add_mm_counter(vma->vm_mm, mm_counter_file(folio), nr);
+		type = mm_counter_file(folio);
 		folio_add_file_rmap_ptes(folio, page, nr, vma);
 	}
 	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
 
 	/* no need to invalidate: a not-present page won't be cached */
 	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr);
+
+	return type;
 }
 
 static bool vmf_pte_changed(struct vm_fault *vmf)
@@ -4765,8 +4770,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	/* Re-check under ptl */
 	if (likely(!vmf_pte_changed(vmf))) {
 		struct folio *folio = page_folio(page);
+		int type = set_pte_range(vmf, folio, page, 1, vmf->address);
 
-		set_pte_range(vmf, folio, page, 1, vmf->address);
+		add_mm_counter(vmf->vma->vm_mm, type, 1);
 		ret = 0;
 	} else {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
-- 
2.41.0


