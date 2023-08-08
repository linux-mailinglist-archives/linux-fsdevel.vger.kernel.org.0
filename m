Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656197735BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 03:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHHBJ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 21:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHHBJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:09:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7CD1995
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 18:09:54 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKZlq6W3Hz1Z1TR;
        Tue,  8 Aug 2023 09:07:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 09:09:52 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Tomas Mudrunka <tomas.mudrunka@gmail.com>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: memtest: convert to memtest_report_meminfo()
Date:   Tue, 8 Aug 2023 09:21:56 +0800
Message-ID: <20230808012156.88924-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is better to not expose too many internal variables of memtest,
add a helper memtest_report_meminfo() to show memtest results.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/proc/meminfo.c        | 12 +-----------
 include/linux/memblock.h | 10 ++++------
 mm/memtest.c             | 19 +++++++++++++++++--
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 74e3c3815696..45af9a989d40 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -133,17 +133,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "VmallocChunk:   ", 0ul);
 	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
 
-#ifdef CONFIG_MEMTEST
-	if (early_memtest_done) {
-		unsigned long early_memtest_bad_size_kb;
-
-		early_memtest_bad_size_kb = early_memtest_bad_size>>10;
-		if (early_memtest_bad_size && !early_memtest_bad_size_kb)
-			early_memtest_bad_size_kb = 1;
-		/* When 0 is reported, it means there actually was a successful test */
-		seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", early_memtest_bad_size_kb);
-	}
-#endif
+	memtest_report_meminfo(m);
 
 #ifdef CONFIG_MEMORY_FAILURE
 	seq_printf(m, "HardwareCorrupted: %5lu kB\n",
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 0d031fbfea25..1c1072e3ca06 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -594,13 +594,11 @@ extern int hashdist;		/* Distribute hashes across NUMA nodes? */
 #endif
 
 #ifdef CONFIG_MEMTEST
-extern phys_addr_t early_memtest_bad_size;	/* Size of faulty ram found by memtest */
-extern bool early_memtest_done;			/* Was early memtest done? */
-extern void early_memtest(phys_addr_t start, phys_addr_t end);
+void early_memtest(phys_addr_t start, phys_addr_t end);
+void memtest_report_meminfo(struct seq_file *m);
 #else
-static inline void early_memtest(phys_addr_t start, phys_addr_t end)
-{
-}
+static inline void early_memtest(phys_addr_t start, phys_addr_t end) { }
+static inline void memtest_report_meminfo(struct seq_file *m) { }
 #endif
 
 
diff --git a/mm/memtest.c b/mm/memtest.c
index 57149dfee438..3b9891431124 100644
--- a/mm/memtest.c
+++ b/mm/memtest.c
@@ -3,9 +3,10 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
+#include <linux/seq_file.h>
 
-bool early_memtest_done;
-phys_addr_t early_memtest_bad_size;
+static bool early_memtest_done;
+static phys_addr_t early_memtest_bad_size;
 
 static u64 patterns[] __initdata = {
 	/* The first entry has to be 0 to leave memtest with zeroed memory */
@@ -117,3 +118,17 @@ void __init early_memtest(phys_addr_t start, phys_addr_t end)
 		do_one_pass(patterns[idx], start, end);
 	}
 }
+
+void memtest_report_meminfo(struct seq_file *m)
+{
+	unsigned long early_memtest_bad_size_kb;
+
+	if (!early_memtest_done)
+		return;
+
+	early_memtest_bad_size_kb = early_memtest_bad_size >> 10;
+	if (early_memtest_bad_size && !early_memtest_bad_size_kb)
+		early_memtest_bad_size_kb = 1;
+	/* When 0 is reported, it means there actually was a successful test */
+	seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", early_memtest_bad_size_kb);
+}
-- 
2.41.0

