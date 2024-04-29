Return-Path: <linux-fsdevel+bounces-18066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D698B5242
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78C91F21992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4205314A8C;
	Mon, 29 Apr 2024 07:24:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F31401B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375478; cv=none; b=qDJdeuuREBjocsrjChAmjWdzpyd/fpGmnexDznL8LJBiI8GbFw84OlEGyc02DDhVEQeIujoBnRYNwt8OvxYEPm/tcIsW3d6mWHkRMVSglSvL9UmOwSRtEyUmjCqQo194UutmuZ14Zj9UM99atB/lWSyky6XNiCr3lAM7urO9184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375478; c=relaxed/simple;
	bh=18VB/N8axsGCCmU/KRHUYTvPolKhLcxUihjKri8uuCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3fLgfnEbOIFbd0pYdY8YuGKGCOGxzMb4/asg0SW5V6tDoa88SGA/mEAWAiDU87STu69nbGfuwQEkYa/HQdiwmZt6zGU6lqS+xSJH7NCoJ0U27IplLuY0bVp92IZXuMhDOKC2Nb873dUPDB5J9aFG+F3iZzZdfh1Vg98AQpzcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VSZWP0vXzzvQsT;
	Mon, 29 Apr 2024 15:21:21 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 316A7140444;
	Mon, 29 Apr 2024 15:24:29 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 15:24:28 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 2/4] mm: filemap: add filemap_set_pte_range()
Date: Mon, 29 Apr 2024 15:24:15 +0800
Message-ID: <20240429072417.2146732-3-wangkefeng.wang@huawei.com>
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

Adding filemap_set_pte_range() independent of set_pte_range() to unify
the rss and folio reference update for small folio and large folio, which
also is prepare for the upcoming lruvec stat batch updating.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/filemap.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ec273b00ce5f..7019692daddd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3499,6 +3499,25 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 	return NULL;
 }
 
+static void filemap_set_pte_range(struct vm_fault *vmf, struct folio *folio,
+			struct page *page, unsigned int nr, unsigned long addr,
+			unsigned long *rss)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	pte_t entry;
+
+	entry = prepare_range_pte_entry(vmf, false, folio, page, nr, addr);
+
+	folio_add_file_rmap_ptes(folio, page, nr, vma);
+	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
+
+	/* no need to invalidate: a not-present page won't be cached */
+	update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr);
+
+	*rss += nr;
+	folio_ref_add(folio, nr);
+}
+
 /*
  * Map page range [start_page, start_page + nr_pages) of folio.
  * start_page is gotten from start by folio_page(folio, start)
@@ -3539,9 +3558,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		continue;
 skip:
 		if (count) {
-			set_pte_range(vmf, folio, page, count, addr);
-			*rss += count;
-			folio_ref_add(folio, count);
+			filemap_set_pte_range(vmf, folio, page, count, addr, rss);
 			if (in_range(vmf->address, addr, count * PAGE_SIZE))
 				ret = VM_FAULT_NOPAGE;
 		}
@@ -3554,9 +3571,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	} while (--nr_pages > 0);
 
 	if (count) {
-		set_pte_range(vmf, folio, page, count, addr);
-		*rss += count;
-		folio_ref_add(folio, count);
+		filemap_set_pte_range(vmf, folio, page, count, addr, rss);
 		if (in_range(vmf->address, addr, count * PAGE_SIZE))
 			ret = VM_FAULT_NOPAGE;
 	}
@@ -3591,9 +3606,7 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	if (vmf->address == addr)
 		ret = VM_FAULT_NOPAGE;
 
-	set_pte_range(vmf, folio, page, 1, addr);
-	(*rss)++;
-	folio_ref_inc(folio);
+	filemap_set_pte_range(vmf, folio, page, 1, addr, rss);
 
 	return ret;
 }
-- 
2.27.0


