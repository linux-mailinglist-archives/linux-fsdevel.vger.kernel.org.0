Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2AC3C41D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhGLD31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhGLD30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F4C0613DD;
        Sun, 11 Jul 2021 20:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Hzd335Ag+ayCqdQrtUoVggNp2H/a7Ca0++VzF2umYOo=; b=v06vg4X+R3nqnQNsfnkO486cqL
        TFtJJdioSUOC1EOQ8KUNt07Yam8QFETKM0qk/1f/+qMNIT5QCgcv4FkJXAhVoyR747kp/aPICLtIS
        8PqF4JshhUYpqqFfFvnB+s7wIUJcsmgp5fFKFpoYIw8sXy1SXSqpZT9wBXewuGlzMa8KDCJfYtJP0
        7OqAFv8u2hgCvOwdyylnzuGKi2HZKkUuXem9llvsVH6UDhxBKUr1b/tyByLx1lrrTko71GEN4n2+0
        9stNaZxbI6bDD6tDONxVuvAmsRtFhFh36mvzPRdemz3VKWgpth0xDlXWbITVYdqHjorsJKJRnXDct
        z884nyKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mZN-00Go3T-0A; Mon, 12 Jul 2021 03:25:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v13 034/137] mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics()
Date:   Mon, 12 Jul 2021 04:05:18 +0100
Message-Id: <20210712030701.4000097-35-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The last use of 'page' was removed by commit 468c398233da ("mm:
memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
the parameter from the function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1f5d0cb581..ee892daecb8b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -831,7 +831,6 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 }
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
-					 struct page *page,
 					 int nr_pages)
 {
 	/* pagein of a big page is an event. So, ignore page size */
@@ -5692,9 +5691,9 @@ static int mem_cgroup_move_account(struct page *page,
 	ret = 0;
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(to, page, nr_pages);
+	mem_cgroup_charge_statistics(to, nr_pages);
 	memcg_check_events(to, page);
-	mem_cgroup_charge_statistics(from, page, -nr_pages);
+	mem_cgroup_charge_statistics(from, -nr_pages);
 	memcg_check_events(from, page);
 	local_irq_enable();
 out_unlock:
@@ -6715,7 +6714,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 	commit_charge(page, memcg);
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, page, nr_pages);
+	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 out:
@@ -7006,7 +7005,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	commit_charge(newpage, memcg);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
+	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
 }
@@ -7236,7 +7235,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
 	VM_BUG_ON(!irqs_disabled());
-	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
+	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_check_events(memcg, page);
 
 	css_put(&memcg->css);
-- 
2.30.2

