Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFCC5FE868
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 07:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJNFcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 01:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJNFcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:32:17 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4EF1946FF;
        Thu, 13 Oct 2022 22:32:14 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 29E5V9aI065718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 14 Oct 2022 13:31:09 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 14 Oct 2022 13:31:08 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <steve.kang@unisoc.com>, <baocong.liu@unisoc.com>,
        <linux-fsdevel@vger.kernel.org>
Subject: [RFC PATCH] mm: move xa forward when run across zombie page
Date:   Fri, 14 Oct 2022 13:30:48 +0800
Message-ID: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 29E5V9aI065718
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
superblock's inode list. The direct reason is zombie page keeps staying on the
xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
and supposed could be an xa update without synchronize_rcu etc. I would like to
suggest skip this page to break the live lock as a workaround.

[167222.620296] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167285.640296] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167348.660296] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167411.680296] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167474.700296] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167537.720299] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167600.740296] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167663.760298] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167726.780298] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167789.800297] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[167726.780305] rcu: Tasks blocked on level-0 rcu_node (CPUs 0-7): P155
[167726.780319] (detected by 3, t=17256977 jiffies, g=19883597, q=2397394)
[167726.780325] task:kswapd0         state:R  running task     stack:   24 pid:  155 ppid:     2 flags:0x00000008
[167789.800308] rcu: Tasks blocked on level-0 rcu_node (CPUs 0-7): P155
[167789.800322] (detected by 3, t=17272732 jiffies, g=19883597, q=2397470)
[167789.800328] task:kswapd0         state:R  running task     stack:   24 pid:  155 ppid:     2 flags:0x00000008
[167789.800339] Call trace:
[167789.800342]  dump_backtrace.cfi_jt+0x0/0x8
[167789.800355]  show_stack+0x1c/0x2c
[167789.800363]  sched_show_task+0x1ac/0x27c
[167789.800370]  print_other_cpu_stall+0x314/0x4dc
[167789.800377]  check_cpu_stall+0x1c4/0x36c
[167789.800382]  rcu_sched_clock_irq+0xe8/0x388
[167789.800389]  update_process_times+0xa0/0xe0
[167789.800396]  tick_sched_timer+0x7c/0xd4
[167789.800404]  __run_hrtimer+0xd8/0x30c
[167789.800408]  hrtimer_interrupt+0x1e4/0x2d0
[167789.800414]  arch_timer_handler_phys+0x5c/0xa0
[167789.800423]  handle_percpu_devid_irq+0xbc/0x318
[167789.800430]  handle_domain_irq+0x7c/0xf0
[167789.800437]  gic_handle_irq+0x54/0x12c
[167789.800445]  call_on_irq_stack+0x40/0x70
[167789.800451]  do_interrupt_handler+0x44/0xa0
[167789.800457]  el1_interrupt+0x34/0x64
[167789.800464]  el1h_64_irq_handler+0x1c/0x2c
[167789.800470]  el1h_64_irq+0x7c/0x80
[167789.800474]  xas_find+0xb4/0x28c
[167789.800481]  find_get_entry+0x3c/0x178
[167789.800487]  find_lock_entries+0x98/0x2f8
[167789.800492]  __invalidate_mapping_pages.llvm.3657204692649320853+0xc8/0x224
[167789.800500]  invalidate_mapping_pages+0x18/0x28
[167789.800506]  inode_lru_isolate+0x140/0x2a4
[167789.800512]  __list_lru_walk_one+0xd8/0x204
[167789.800519]  list_lru_walk_one+0x64/0x90
[167789.800524]  prune_icache_sb+0x54/0xe0
[167789.800529]  super_cache_scan+0x160/0x1ec
[167789.800535]  do_shrink_slab+0x20c/0x5c0
[167789.800541]  shrink_slab+0xf0/0x20c
[167789.800546]  shrink_node_memcgs+0x98/0x320
[167789.800553]  shrink_node+0xe8/0x45c
[167789.800557]  balance_pgdat+0x464/0x814
[167789.800563]  kswapd+0xfc/0x23c
[167789.800567]  kthread+0x164/0x1c8
[167789.800573]  ret_from_fork+0x10/0x20

Signed-off-by: Baocong Liu <baocong.liu@unisoc.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/filemap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334..25b0a2e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2019,8 +2019,10 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 	if (!folio || xa_is_value(folio))
 		return folio;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get_rcu(folio)) {
+		xas_advance(xas, folio->index + folio_nr_pages(folio) - 1);
 		goto reset;
+	}
 
 	if (unlikely(folio != xas_reload(xas))) {
 		folio_put(folio);
-- 
1.9.1

