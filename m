Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93C13C96EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhGOELA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhGOELA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:11:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F22C06175F;
        Wed, 14 Jul 2021 21:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CxY08Ev5uWlF/WW7yp4XrHQ+Z+LsImiejgZH8Eqdor0=; b=RKrbLkVFivA1/kX9kMTQh7qVP/
        fmpA4Vbu25qCarcS9FXuAGD5ITwznDdH3orb2GMY//TAMSbFDvs2OaNRb1cP03tUhBdOakxUwe0m6
        AJc9UArs3jC9rRErAgTuyC2aGXZ6jZSozojNQkHmMemtq9R4CwA1UOWYgWaNJuUGJeJAtdUgOso5i
        faUSnnS0gTDIkO6EjGzYA4dwd4Dl+HSbh55CQTCMUQmzknXDYzRHlwkY9PblC5O9HS//VXm0QALA3
        lX7VbWjGkXfEK7N9Am5bJMegqBsWJebTIXpy4EnLXcZFcvmQS17cfmikf51E0/tI3+JUW6S8EdmKO
        2JXxHlqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sdc-002w2d-Iw; Thu, 15 Jul 2021 04:06:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 037/138] mm/memcg: Convert memcg_check_events to take a node ID
Date:   Thu, 15 Jul 2021 04:35:23 +0100
Message-Id: <20210715033704.692967-38-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memcg_check_events only uses the page's nid, so call page_to_nid in the
callers to make the interface easier to understand.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/memcontrol.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f70e33d691aa..1a049bfa0e0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -851,7 +851,7 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
  * Check events in order.
  *
  */
-static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
+static void memcg_check_events(struct mem_cgroup *memcg, int nid)
 {
 	/* threshold event is triggered in finer grain than soft limit */
 	if (unlikely(mem_cgroup_event_ratelimit(memcg,
@@ -862,7 +862,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 						MEM_CGROUP_TARGET_SOFTLIMIT);
 		mem_cgroup_threshold(memcg);
 		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, page_to_nid(page));
+			mem_cgroup_update_tree(memcg, nid);
 	}
 }
 
@@ -5578,7 +5578,7 @@ static int mem_cgroup_move_account(struct page *page,
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
 	unsigned int nr_pages = compound ? thp_nr_pages(page) : 1;
-	int ret;
+	int nid, ret;
 
 	VM_BUG_ON(from == to);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -5667,12 +5667,13 @@ static int mem_cgroup_move_account(struct page *page,
 	__unlock_page_memcg(from);
 
 	ret = 0;
+	nid = page_to_nid(page);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
-	memcg_check_events(to, page);
+	memcg_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
-	memcg_check_events(from, page);
+	memcg_check_events(from, nid);
 	local_irq_enable();
 out_unlock:
 	unlock_page(page);
@@ -6693,7 +6694,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, page);
+	memcg_check_events(memcg, page_to_nid(page));
 	local_irq_enable();
 out:
 	return ret;
@@ -6801,7 +6802,7 @@ struct uncharge_gather {
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
-	struct page *dummy_page;
+	int nid;
 };
 
 static inline void uncharge_gather_clear(struct uncharge_gather *ug)
@@ -6825,7 +6826,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->dummy_page);
+	memcg_check_events(ug->memcg, ug->nid);
 	local_irq_restore(flags);
 
 	/* drop reference from uncharge_page */
@@ -6866,7 +6867,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = memcg;
-		ug->dummy_page = page;
+		ug->nid = page_to_nid(page);
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&memcg->css);
@@ -6984,7 +6985,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, newpage);
+	memcg_check_events(memcg, page_to_nid(newpage));
 	local_irq_restore(flags);
 }
 
@@ -7214,7 +7215,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 */
 	VM_BUG_ON(!irqs_disabled());
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
-	memcg_check_events(memcg, page);
+	memcg_check_events(memcg, page_to_nid(page));
 
 	css_put(&memcg->css);
 }
-- 
2.30.2

