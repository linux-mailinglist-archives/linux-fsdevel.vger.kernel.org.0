Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A637A810
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 15:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhEKNuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 09:50:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2701 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhEKNuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 09:50:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FffN85TG3z1BKnT;
        Tue, 11 May 2021 21:46:32 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 21:49:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <hughd@google.com>, <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 4/5] mm/huge_memory.c: remove unnecessary tlb_remove_page_size() for huge zero pmd
Date:   Tue, 11 May 2021 21:48:56 +0800
Message-ID: <20210511134857.1581273-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210511134857.1581273-1-linmiaohe@huawei.com>
References: <20210511134857.1581273-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit aa88b68c3b1d ("thp: keep huge zero page pinned until tlb flush")
introduced tlb_remove_page() for huge zero page to keep it pinned until
flush is complete and prevents the page from being split under us. But
huge zero page is kept pinned until all relevant mm_users reach zero since
the commit 6fcb52a56ff6 ("thp: reduce usage of huge zero page's atomic
counter"). So tlb_remove_page_size() for huge zero pmd is unnecessary now.

Reviewed-by: Yang Shi <shy828301@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f37867eed12..b8e67332806f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1683,12 +1683,9 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (arch_needs_pgtable_deposit())
 			zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
-		if (is_huge_zero_pmd(orig_pmd))
-			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else if (is_huge_zero_pmd(orig_pmd)) {
 		zap_deposited_table(tlb->mm, pmd);
 		spin_unlock(ptl);
-		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
 	} else {
 		struct page *page = NULL;
 		int flush_needed = 1;
-- 
2.23.0

