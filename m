Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5643737A811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 15:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhEKNuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 09:50:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2702 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhEKNuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 09:50:20 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FffN90WQSz1BLDj;
        Tue, 11 May 2021 21:46:33 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 21:49:03 +0800
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
Subject: [PATCH v3 2/5] mm/huge_memory.c: use page->deferred_list
Date:   Tue, 11 May 2021 21:48:54 +0800
Message-ID: <20210511134857.1581273-3-linmiaohe@huawei.com>
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

Now that we can represent the location of ->deferred_list instead of
->mapping + ->index, make use of it to improve readability.

Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..76ca1eb2a223 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	/* Take pin on all head pages to avoid freeing them under us */
 	list_for_each_safe(pos, next, &ds_queue->split_queue) {
-		page = list_entry((void *)pos, struct page, mapping);
+		page = list_entry((void *)pos, struct page, deferred_list);
 		page = compound_head(page);
 		if (get_page_unless_zero(page)) {
 			list_move(page_deferred_list(page), &list);
@@ -2883,7 +2883,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	list_for_each_safe(pos, next, &list) {
-		page = list_entry((void *)pos, struct page, mapping);
+		page = list_entry((void *)pos, struct page, deferred_list);
 		if (!trylock_page(page))
 			goto next;
 		/* split_huge_page() removes page from list on success */
-- 
2.23.0

