Return-Path: <linux-fsdevel+bounces-18065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4A8B5241
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8570C1C20E2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829BB13FE7;
	Mon, 29 Apr 2024 07:24:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2CA8472
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375476; cv=none; b=MuXZ/9DHJHua6Ww9/SRWPTHmNfp9XAHPeOOS2vygDhp7MXpCq/jSaBF0kU+yki1rvXCCydR6vCG2CFxd45sxPF9kt7Jx8UKR5damn09tjrDq5SNFrihc9HkQkXsp/sU7ldfkUogYiXkQ7hdl+Eugf/isD2Rmixs8xA0dDfPehuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375476; c=relaxed/simple;
	bh=2Yxdzpfe3AmZ9M/v8fUgfJj7hU18v8KZ0QnqcdasQfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GV8EvsxrENuNzI9E25nQUVmsSyFWw+iwVXOQ5giEfnqBy/YNgvks+tOEx1L15vkzRD8/qNkSbFDCjT+jjbME2MIS5Ax4Qdza7PzvdmW1TbrPHfuauQI5Btod9JGUO/2pciwfWr3ymzGVULsYoQ7a+DnsltdhfbJY1eLUDy73HyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VSZYl0X6Pzcb0R;
	Mon, 29 Apr 2024 15:23:23 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E866E14035F;
	Mon, 29 Apr 2024 15:24:29 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 15:24:29 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 4/4] mm: filemap: try to batch lruvec stat updating
Date: Mon, 29 Apr 2024 15:24:17 +0800
Message-ID: <20240429072417.2146732-5-wangkefeng.wang@huawei.com>
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

The filemap_map_pages() tries to map few pages(eg, 16 pages), but the
lruvec stat updating is called on each mapping, since the updating is
time-consuming, especially with memcg, so try to batch it when the memcg
and pgdat are same during the mapping, if luckily, we could save most of
time of lruvec stat updating, the lat_pagefault shows 3~4% improvement.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/filemap.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3966b6616d02..b27281707098 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3615,6 +3615,20 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	return ret;
 }
 
+static void filemap_lruvec_stat_update(struct mem_cgroup *memcg,
+				       pg_data_t *pgdat, int nr)
+{
+	struct lruvec *lruvec;
+
+	if (!memcg) {
+		__mod_node_page_state(pgdat, NR_FILE_MAPPED, nr);
+		return;
+	}
+
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	__mod_lruvec_state(lruvec, NR_FILE_MAPPED, nr);
+}
+
 vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			     pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
@@ -3628,6 +3642,9 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	vm_fault_t ret = 0;
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
+	struct mem_cgroup *memcg, *memcg_cur;
+	pg_data_t *pgdat, *pgdat_cur;
+	int nr_mapped = 0;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
@@ -3648,9 +3665,20 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	}
 
 	folio_type = mm_counter_file(folio);
+	memcg = folio_memcg(folio);
+	pgdat = folio_pgdat(folio);
 	do {
 		unsigned long end;
-		int nr_mapped = 0;
+
+		memcg_cur = folio_memcg(folio);
+		pgdat_cur = folio_pgdat(folio);
+
+		if (unlikely(memcg != memcg_cur || pgdat != pgdat_cur)) {
+			filemap_lruvec_stat_update(memcg, pgdat, nr_mapped);
+			nr_mapped = 0;
+			memcg = memcg_cur;
+			pgdat = pgdat_cur;
+		}
 
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
@@ -3668,11 +3696,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 					nr_pages, &rss, &nr_mapped,
 					&mmap_miss);
 
-		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr_mapped);
-
 		folio_unlock(folio);
 		folio_put(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
+	filemap_lruvec_stat_update(memcg, pgdat, nr_mapped);
 	add_mm_counter(vma->vm_mm, folio_type, rss);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
-- 
2.27.0


