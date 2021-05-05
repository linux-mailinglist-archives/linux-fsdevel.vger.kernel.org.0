Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15C373F3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhEEQIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhEEQIv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:08:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE456C061574;
        Wed,  5 May 2021 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t0QlzoFd0QiNmq5B8FtNYx04t/JISN6ijPTDbIUQEDc=; b=MyGaRXkUbZUWmkwJCkO0kFGrzg
        JbogxK5aEgKC7PEMXdz658WP2QrRfIR1IVbD9Gid/7aVKU4kJTiUY0zv7wf6ZJqS8WR53c7vPvHdg
        AyIhcTysQsxn/Dj7CYcV5+nXUf71+ld2PwtOi51/rOEp+ukHBy/vXIvu/EQRI9SlYDZsNf9XZ5AaI
        2NUrJMsMp658T2HWQAPFuxNjeXM4WdT5kabsJKQM1KKSEsSDL09iinxAVSNjEviKpfkXDRjlytjif
        G2Ps24dkYUUGMRrfZJGgV5D7OMFlvBO01Ti2Ed2uFC+DuGENBdxqnrYTbLV2wSSWzfN0e4DCLh9jF
        KLjTs3qA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leK1w-000Z2U-OK; Wed, 05 May 2021 16:06:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 48/96] mm/memcg: Remove 'page' parameter to mem_cgroup_charge_statistics
Date:   Wed,  5 May 2021 16:05:40 +0100
Message-Id: <20210505150628.111735-49-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The last use of 'page' was removed by commit 468c398233da ("mm:
memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
the parameter from the function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memcontrol.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..1204c6a0c671 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -814,7 +814,6 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 }
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
-					 struct page *page,
 					 int nr_pages)
 {
 	/* pagein of a big page is an event. So, ignore page size */
@@ -5504,9 +5503,9 @@ static int mem_cgroup_move_account(struct page *page,
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
@@ -6527,7 +6526,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 	commit_charge(page, memcg);
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, page, nr_pages);
+	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 out:
@@ -6814,7 +6813,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	commit_charge(newpage, memcg);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
+	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
 }
@@ -7044,7 +7043,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
 	VM_BUG_ON(!irqs_disabled());
-	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
+	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_check_events(memcg, page);
 
 	css_put(&memcg->css);
-- 
2.30.2

