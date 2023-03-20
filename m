Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE96C0B43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 08:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCTHU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 03:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCTHUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:20:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4275CFF3E;
        Mon, 20 Mar 2023 00:20:22 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pg5fz31lxzKs9C;
        Mon, 20 Mar 2023 15:18:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 15:20:18 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] mm: memory-failure: Move memory failure sysctls to its own file
Date:   Mon, 20 Mar 2023 15:40:10 +0800
Message-ID: <20230320074010.50875-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sysctl_memory_failure_early_kill and memory_failure_recovery
are only used in memory-failure.c, move them to its own file.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v3: rebased on sysctl-next, asked by Luis Chamberlain
 include/linux/mm.h  |  2 --
 kernel/sysctl.c     | 20 --------------------
 mm/memory-failure.c | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 716d30d93616..1ab157757906 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3459,8 +3459,6 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
-extern int sysctl_memory_failure_early_kill;
-extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ce0297acf97c..0a8a3c9c82e4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2350,26 +2350,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec,
 		.extra1		= SYSCTL_ZERO,
 	},
-#endif
-#ifdef CONFIG_MEMORY_FAILURE
-	{
-		.procname	= "memory_failure_early_kill",
-		.data		= &sysctl_memory_failure_early_kill,
-		.maxlen		= sizeof(sysctl_memory_failure_early_kill),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "memory_failure_recovery",
-		.data		= &sysctl_memory_failure_recovery,
-		.maxlen		= sizeof(sysctl_memory_failure_recovery),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
 #endif
 	{
 		.procname	= "user_reserve_kbytes",
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c77a9e37e27e..242b6cae0035 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -62,13 +62,14 @@
 #include <linux/page-isolation.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
+#include <linux/sysctl.h>
 #include "swap.h"
 #include "internal.h"
 #include "ras/ras_event.h"
 
-int sysctl_memory_failure_early_kill __read_mostly = 0;
+static int sysctl_memory_failure_early_kill __read_mostly;
 
-int sysctl_memory_failure_recovery __read_mostly = 1;
+static int sysctl_memory_failure_recovery __read_mostly = 1;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
@@ -87,6 +88,36 @@ inline void num_poisoned_pages_sub(unsigned long pfn, long i)
 		memblk_nr_poison_sub(pfn, i);
 }
 
+#ifdef CONFIG_SYSCTL
+static struct ctl_table memory_failure_table[] = {
+	{
+		.procname	= "memory_failure_early_kill",
+		.data		= &sysctl_memory_failure_early_kill,
+		.maxlen		= sizeof(sysctl_memory_failure_early_kill),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "memory_failure_recovery",
+		.data		= &sysctl_memory_failure_recovery,
+		.maxlen		= sizeof(sysctl_memory_failure_recovery),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
+static int __init memory_failure_sysctl_init(void)
+{
+	register_sysctl_init("vm", memory_failure_table);
+	return 0;
+}
+late_initcall(memory_failure_sysctl_init);
+#endif /* CONFIG_SYSCTL */
+
 /*
  * Return values:
  *   1:   the page is dissolved (if needed) and taken off from buddy,
-- 
2.27.0

