Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128015958C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiHPKpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiHPKo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:44:58 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AA43AE44;
        Tue, 16 Aug 2022 02:54:44 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oNt3q-00FxfB-Qg;
        Tue, 16 Aug 2022 11:41:45 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/4] Display inflated memory to users
Date:   Tue, 16 Aug 2022 12:41:16 +0300
Message-Id: <20220816094117.3144881-4-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add InflatedTotal and InflatedFree to /proc/meminfo

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 Documentation/filesystems/proc.rst |  6 ++++++
 fs/proc/meminfo.c                  | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e7aafc82be99..690e1b90ffee 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -991,6 +991,8 @@ Example output. You may not have all of these fields.
     VmallocUsed:       40444 kB
     VmallocChunk:          0 kB
     Percpu:            29312 kB
+    InflatedTotal:   2097152 kB
+    InflatedFree:          0 kB
     HardwareCorrupted:     0 kB
     AnonHugePages:   4149248 kB
     ShmemHugePages:        0 kB
@@ -1138,6 +1140,10 @@ VmallocChunk
 Percpu
               Memory allocated to the percpu allocator used to back percpu
               allocations. This stat excludes the cost of metadata.
+InflatedTotal and InflatedFree
+               Amount of memory that is inflated by the balloon driver.
+               Due to differences among the drivers inflated memory
+               is subtracted from TotalRam or from MemFree.
 HardwareCorrupted
               The amount of RAM/memory in KB, the kernel identifies as
               corrupted.
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6e89f0e2fd20..f72af204151a 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -16,6 +16,9 @@
 #ifdef CONFIG_CMA
 #include <linux/cma.h>
 #endif
+#ifdef CONFIG_MEMORY_BALLOON
+#include <linux/balloon_common.h>
+#endif
 #include <asm/page.h>
 #include "internal.h"
 
@@ -153,6 +156,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 		    global_zone_page_state(NR_FREE_CMA_PAGES));
 #endif
 
+#ifdef CONFIG_MEMORY_BALLOON
+	seq_printf(m,  "InflatedTotal:  %8ld kB\n",
+		atomic_long_read(&mem_balloon_inflated_total_kb));
+	seq_printf(m,  "InflatedFree:   %8ld kB\n",
+		atomic_long_read(&mem_balloon_inflated_free_kb));
+#endif
+
 	hugetlb_report_meminfo(m);
 
 	arch_report_meminfo(m);
-- 
2.31.1

