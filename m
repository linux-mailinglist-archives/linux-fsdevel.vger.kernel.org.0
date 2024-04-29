Return-Path: <linux-fsdevel+bounces-18068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC18B5245
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7061F21BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004E15AE0;
	Mon, 29 Apr 2024 07:24:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CA1400B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375479; cv=none; b=oypTWEarfs695o0YlA0rvABwW54+lNHBxqiZ18v+2vSgecuPRlypKS0VpnYuP9kJI6C4Cw4hxD+mvLdxlLHEdb+MesIhco4cWZUUugylqMPbjsiIMFYmICxtjWcYveUiH6vPDVxVN0Rwy7MorUhYgx+htsphjMDFk6Rx1fXM6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375479; c=relaxed/simple;
	bh=HOn0hP7loLDuh/+awVrLeLlxQP2i9iVFIlgJ7HdvlVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooRht4DDJrGcp4tyTZ00sMQKwh97z4MDuszRp9wxmrx1NSVRum+kWXRWiGObXg1bKjb4VQUGmajwXKx3AOm/I0pEw75UqFTGJ8M+k2R3jnwyNuATS2XPf2gFTt3nJmiHwuggmvp6OjZTz7AGEDEW70iLrzXaNiH2tjRlX/lVhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VSZWN5QPRzvPrW;
	Mon, 29 Apr 2024 15:21:20 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id CBA76140429;
	Mon, 29 Apr 2024 15:24:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 15:24:28 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 1/4] mm: memory: add prepare_range_pte_entry()
Date: Mon, 29 Apr 2024 15:24:14 +0800
Message-ID: <20240429072417.2146732-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
References: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)

This is prepare for a separate filemap_set_pte_range(), add a
prepare_range_pte_entry(), no functional changes.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 33 ++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9849dfda44d4..bcbeb8a4cd43 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1372,6 +1372,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 }
 
 vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
+pte_t prepare_range_pte_entry(struct vm_fault *vmf, bool write, struct folio *folio,
+		struct page *page, unsigned int nr, unsigned long addr);
 void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		struct page *page, unsigned int nr, unsigned long addr);
 
diff --git a/mm/memory.c b/mm/memory.c
index 6647685fd3c4..ccbeb58fa136 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4652,19 +4652,11 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 }
 #endif
 
-/**
- * set_pte_range - Set a range of PTEs to point to pages in a folio.
- * @vmf: Fault decription.
- * @folio: The folio that contains @page.
- * @page: The first page to create a PTE for.
- * @nr: The number of PTEs to create.
- * @addr: The first address to create a PTE for.
- */
-void set_pte_range(struct vm_fault *vmf, struct folio *folio,
-		struct page *page, unsigned int nr, unsigned long addr)
+pte_t prepare_range_pte_entry(struct vm_fault *vmf, bool write,
+			      struct folio *folio, struct page *page,
+			      unsigned int nr, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = in_range(vmf->address, addr, nr * PAGE_SIZE);
 	pte_t entry;
 
@@ -4680,6 +4672,25 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
 		entry = pte_mkuffd_wp(entry);
+
+	return entry;
+}
+
+/**
+ * set_pte_range - Set a range of PTEs to point to pages in a folio.
+ * @vmf: Fault description.
+ * @folio: The folio that contains @page.
+ * @page: The first page to create a PTE for.
+ * @nr: The number of PTEs to create.
+ * @addr: The first address to create a PTE for.
+ */
+void set_pte_range(struct vm_fault *vmf, struct folio *folio,
+		struct page *page, unsigned int nr, unsigned long addr)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	pte_t entry = prepare_range_pte_entry(vmf, write, folio, page, nr, addr);
+
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		VM_BUG_ON_FOLIO(nr != 1, folio);
-- 
2.27.0


