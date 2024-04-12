Return-Path: <linux-fsdevel+bounces-16762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EA48A23C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 04:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F357C1C226B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C87DDC3;
	Fri, 12 Apr 2024 02:30:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05BDDA5
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889001; cv=none; b=EFkZgrkt6wY2Iv0XHzrfesy4SVgx4LEcASMvVU4z+bLmGt6nnzBR8ECPcrECY8xXu9lT1t7NEcxO9aRJykUOKzrkRW+bTmF2vLJPpLXjS6s3BtGdrhjASizYybxJrCIqNX48Xn7Z1ckyRlrR8eRVgiiHUP3j3YuAtWxNOJmpuA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889001; c=relaxed/simple;
	bh=tyiP1cp340Iml1NvxSG/1j7p4cX8iGABaILKIpW6lBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Git7G87u9cE1dPS0ub2lkljf1f9SPaorRtFJhjkq4CKwHwBNC27J55W449+cgr/kMC5UrXdmiAnNCAjnQnwFPWh7OZYGBv9PPcZgXB2n1uPwFpGvUVI1wKY5h6pND4ErPU3kPtCpNyFFtW1UbHrTyXgbwBw9iAdOemOFTpDInPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VG0pM4JXZz1ynHs;
	Fri, 12 Apr 2024 10:27:39 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 19E5B140410;
	Fri, 12 Apr 2024 10:29:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:29:56 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] mm: move mm counter updating out of set_pte_range()
Date: Fri, 12 Apr 2024 10:57:03 +0800
Message-ID: <20240412025704.53245-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
References: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)

In order to support batch mm counter updating in filemap_map_pages(),
move mm counter updating out of set_pte_range(), the folios are file
from filemap, and distinguish folios type by vmf->flags and vma->vm_flags
from another caller finish_fault().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/filemap.c | 4 ++++
 mm/memory.c  | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 92e2d43e4c9d..04b813f0146c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3540,6 +3540,8 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 skip:
 		if (count) {
 			set_pte_range(vmf, folio, page, count, addr);
+			add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio),
+				       count);
 			folio_ref_add(folio, count);
 			if (in_range(vmf->address, addr, count * PAGE_SIZE))
 				ret = VM_FAULT_NOPAGE;
@@ -3554,6 +3556,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 
 	if (count) {
 		set_pte_range(vmf, folio, page, count, addr);
+		add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio), count);
 		folio_ref_add(folio, count);
 		if (in_range(vmf->address, addr, count * PAGE_SIZE))
 			ret = VM_FAULT_NOPAGE;
@@ -3590,6 +3593,7 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 		ret = VM_FAULT_NOPAGE;
 
 	set_pte_range(vmf, folio, page, 1, addr);
+	add_mm_counter(vmf->vma->vm_mm, mm_counter_file(folio), 1);
 	folio_ref_inc(folio);
 
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index 78422d1c7381..69bc63a5d6c8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4685,12 +4685,10 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		entry = pte_mkuffd_wp(entry);
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
-		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr);
 		VM_BUG_ON_FOLIO(nr != 1, folio);
 		folio_add_new_anon_rmap(folio, vma, addr);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		add_mm_counter(vma->vm_mm, mm_counter_file(folio), nr);
 		folio_add_file_rmap_ptes(folio, page, nr, vma);
 	}
 	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
@@ -4727,9 +4725,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	vm_fault_t ret;
+	int is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
+		     !(vma->vm_flags & VM_SHARED);
 
 	/* Did we COW the page? */
-	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED))
+	if (is_cow)
 		page = vmf->cow_page;
 	else
 		page = vmf->page;
@@ -4765,8 +4765,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	/* Re-check under ptl */
 	if (likely(!vmf_pte_changed(vmf))) {
 		struct folio *folio = page_folio(page);
+		int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
 
 		set_pte_range(vmf, folio, page, 1, vmf->address);
+		add_mm_counter(vma->vm_mm, type, 1);
 		ret = 0;
 	} else {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
-- 
2.41.0


