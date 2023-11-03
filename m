Return-Path: <linux-fsdevel+bounces-1900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424757DFF66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 08:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C08281E1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D279EE;
	Fri,  3 Nov 2023 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CB6FCE
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 07:29:14 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7518E;
	Fri,  3 Nov 2023 00:29:12 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SMC1p61SqzPnmj;
	Fri,  3 Nov 2023 15:25:02 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 15:29:09 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>, David Hildenbrand
	<david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/5] mm: task_mmu: use a folio in smaps_account()
Date: Fri, 3 Nov 2023 15:29:03 +0800
Message-ID: <20231103072906.2000381-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
References: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected

Replace seven implicit calls to compound_head() with one page_folio().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/task_mmu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..5ec06fee1f14 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -445,23 +445,25 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 {
 	int i, nr = compound ? compound_nr(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
+	struct folio *folio = page_folio(page);
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
 	 * of the compound page.
 	 */
-	if (PageAnon(page)) {
+	if (folio_test_anon(folio)) {
 		mss->anonymous += size;
-		if (!PageSwapBacked(page) && !dirty && !PageDirty(page))
+		if (!folio_test_swapbacked(folio) && !dirty &&
+		    !folio_test_dirty(folio))
 			mss->lazyfree += size;
 	}
 
-	if (PageKsm(page))
+	if (folio_test_ksm(folio))
 		mss->ksm += size;
 
 	mss->resident += size;
 	/* Accumulate the size in pages that have been accessed. */
-	if (young || page_is_young(page) || PageReferenced(page))
+	if (young || folio_test_young(folio) || folio_test_referenced(folio))
 		mss->referenced += size;
 
 	/*
@@ -479,7 +481,7 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	 * especially for migration entries.  Treat regular migration entries
 	 * as mapcount == 1.
 	 */
-	if ((page_count(page) == 1) || migration) {
+	if ((folio_ref_count(folio) == 1) || migration) {
 		smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
 			locked, true);
 		return;
-- 
2.27.0


