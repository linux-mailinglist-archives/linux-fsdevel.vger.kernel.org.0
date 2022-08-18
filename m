Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A05598083
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbiHRJFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243743AbiHRJFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:05:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B35A5C968;
        Thu, 18 Aug 2022 02:05:01 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M7f7K71KfzGpYJ;
        Thu, 18 Aug 2022 17:03:25 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 17:04:59 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 17:04:58 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <osalvador@suse.de>,
        <surenb@google.com>, <mawupeng1@huawei.com>, <rppt@kernel.org>,
        <charante@codeaurora.org>, <jsavitz@redhat.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 2/2] mm: sysctl: Introduce per zone watermark_scale_factor
Date:   Thu, 18 Aug 2022 17:04:30 +0800
Message-ID: <20220818090430.2859992-3-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818090430.2859992-1-mawupeng1@huawei.com>
References: <20220818090430.2859992-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

System may have little normal zone memory and huge movable memory in the
following situations:
  - for system with kernelcore=nn% or kernelcore=mirror, movable zone will
  be added and movable zone is bigger than normal zone in most cases.
  - system with movable nodes, they will have multiple numa nodes with
  only movable zone and movable zone will have plenty of memory.

Since kernel/driver can only use memory from non-movable zone in most
cases, normal zone need to increase its watermark to reserve more memory.

However, current watermark_scale_factor is used to control all zones
at once and can't be set separately. To reserve memory in non-movable
zones, the watermark is increased in movable zones as well. Which will
lead to inefficient kswapd.

To solve this problem, per zone watermark is introduced to tune each zone's
watermark separately. This can bring the following advantages:
  - each zone can set its own watermark which bring flexibility
  - lead to more efficient kswapd if this watermark is set fine

Here is real watermark data in my qemu machine(with THP disabled).

With watermark_scale_factor = 10, there is only 1440(772-68+807-71)
pages(5.76M) reserved for a system with 96G of memory. However if the
watermark is set to 100, the movable zone's watermark increased to
231908(93M), which is too much.
This situation is even worse with 32G of normal zone memory and 1T of
movable zone memory.

       Modified        | Vanilla wm_factor = 10 | Vanilla wm_factor = 30
Node 0, zone      DMA  | Node 0, zone      DMA  | Node 0, zone      DMA
        min      68    |         min      68    |         min      68
        low      7113  |         low      772   |         low      7113
        high **14158** |         high **1476**  |         high **14158**
Node 0, zone   Normal  | Node 0, zone   Normal  | Node 0, zone   Normal
        min      71    |         min      71    |         min      71
        low      7438  |         low      807   |         low      7438
        high     14805 |         high     1543  |         high     14805
Node 0, zone  Movable  | Node 0, zone  Movable  | Node 0, zone  Movable
        min      1455  |         min      1455  |         min      1455
        low      16388 |         low      16386 |         low      150787
        high **31321** |         high **31317** |         high **300119**
Node 1, zone  Movable  | Node 1, zone  Movable  | Node 1, zone  Movable
        min      804   |         min      804   |         min      804
        low      9061  |         low      9061  |         low      83379
        high **17318** |         high **17318** |         high **165954**

With the modified per zone watermark_scale_factor, only dma/normal zone
will increase its watermark via the following command which the huge
movable zone stay the same.

  % echo 100 100 100 10 > /proc/sys/vm/watermark_scale_factor

The reason to disable THP is khugepaged_min_free_kbytes_update() will
update min watermark.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 Documentation/admin-guide/sysctl/vm.rst |  6 ++++
 include/linux/mm.h                      |  2 +-
 include/linux/mmzone.h                  |  4 +--
 kernel/sysctl.c                         |  2 --
 mm/page_alloc.c                         | 37 ++++++++++++++++++++-----
 5 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 9b833e439f09..ec240aa45322 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -1002,6 +1002,12 @@ that the number of free pages kswapd maintains for latency reasons is
 too small for the allocation bursts occurring in the system. This knob
 can then be used to tune kswapd aggressiveness accordingly.
 
+The watermark_scale_factor is an array. You can set each zone's watermark
+separately and can be seen by reading this file::
+
+	% cat /proc/sys/vm/watermark_scale_factor
+	10	10	10	10
+
 
 zone_reclaim_mode
 =================
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3bedc449c14d..7f1eba1541f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2525,7 +2525,7 @@ extern void setup_per_cpu_pageset(void);
 /* page_alloc.c */
 extern int min_free_kbytes;
 extern int watermark_boost_factor;
-extern int watermark_scale_factor;
+extern int watermark_scale_factor[MAX_NR_ZONES];
 extern bool arch_has_descending_max_zone_pfns(void);
 
 /* nommu.c */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aa712aa35744..8e6258186d3c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1173,8 +1173,8 @@ struct ctl_table;
 
 int min_free_kbytes_sysctl_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
-int watermark_scale_factor_sysctl_handler(struct ctl_table *, int, void *,
-		size_t *, loff_t *);
+int watermark_scale_factor_sysctl_handler(struct ctl_table *table, int write,
+		void *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, void *,
 		size_t *, loff_t *);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 205d605cacc5..d16d06c71e5a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2251,8 +2251,6 @@ static struct ctl_table vm_table[] = {
 		.maxlen		= sizeof(watermark_scale_factor),
 		.mode		= 0644,
 		.proc_handler	= watermark_scale_factor_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_THREE_THOUSAND,
 	},
 	{
 		.procname	= "percpu_pagelist_high_fraction",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4f62e3d74bf2..b81dcda9f702 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -421,7 +421,6 @@ compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
 int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
 int watermark_boost_factor __read_mostly = 15000;
-int watermark_scale_factor = 10;
 
 static unsigned long nr_kernel_pages __initdata;
 static unsigned long nr_all_pages __initdata;
@@ -449,6 +448,20 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 int page_group_by_mobility_disabled __read_mostly;
 
+int watermark_scale_factor[MAX_NR_ZONES] = {
+#ifdef CONFIG_ZONE_DMA
+	[ZONE_DMA] = 10,
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	[ZONE_DMA32] = 10,
+#endif
+	[ZONE_NORMAL] = 10,
+#ifdef CONFIG_HIGHMEM
+	[ZONE_HIGHMEM] = 10,
+#endif
+	[ZONE_MOVABLE] = 10,
+};
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 /*
  * During boot we initialize deferred pages on-demand, as needed, but once
@@ -8643,6 +8656,7 @@ static void __setup_per_zone_wmarks(void)
 	}
 
 	for_each_zone(zone) {
+		int zone_wm_factor;
 		u64 tmp;
 
 		spin_lock_irqsave(&zone->lock, flags);
@@ -8676,9 +8690,10 @@ static void __setup_per_zone_wmarks(void)
 		 * scale factor in proportion to available memory, but
 		 * ensure a minimum size on small systems.
 		 */
+		zone_wm_factor = watermark_scale_factor[zone_idx(zone)];
 		tmp = max_t(u64, tmp >> 2,
-			    mult_frac(zone_managed_pages(zone),
-				      watermark_scale_factor, 10000));
+			    mult_frac(zone_managed_pages(zone), zone_wm_factor,
+				      10000));
 
 		zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
@@ -8795,14 +8810,22 @@ int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
+/*
+ * watermark_scale_factor_sysctl_handler - just a wrapper around
+ *	proc_dointvec() so that we can call setup_per_zone_wmarks()
+ *	whenever watermark_scale_factor changes.
+ */
 int watermark_scale_factor_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
-	int rc;
+	int i;
 
-	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
-	if (rc)
-		return rc;
+	proc_dointvec_minmax(table, write, buffer, length, ppos);
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		watermark_scale_factor[i] =
+			clamp(watermark_scale_factor[i], 1,
+			      *(int *)SYSCTL_THREE_THOUSAND);
 
 	if (write)
 		setup_per_zone_wmarks();
-- 
2.25.1

