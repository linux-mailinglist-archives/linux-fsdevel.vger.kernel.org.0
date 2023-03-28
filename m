Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD67A6CB384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 04:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjC1CC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 22:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC1CC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:02:28 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B765213B;
        Mon, 27 Mar 2023 19:02:25 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PltH32qj7z6FK2R;
        Tue, 28 Mar 2023 10:02:23 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 32S223RI070586;
        Tue, 28 Mar 2023 10:02:03 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 28 Mar 2023 10:02:04 +0800 (CST)
Date:   Tue, 28 Mar 2023 10:02:04 +0800 (CST)
X-Zmail-TransId: 2afa64224a9cffffffff949-5d18a
X-Mailer: Zmail v1.0
Message-ID: <202303281002046981494@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mcgrof@kernel.org>
Cc:     <keescook@chromium.org>, <yzaikin@google.com>,
        <akpm@linux-foundation.org>, <chi.minghao@zte.com.cn>,
        <linmiaohe@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: =?UTF-8?B?W1BBVENIIFY3IDEvMl0gbW06IGNvbXBhY3Rpb246IG1vdmUgY29tcGFjdGlvbiBzeXNjdGwgdG8gaXRzIG93biBmaWxl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 32S223RI070586
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64224AAF.000/4PltH32qj7z6FK2R
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

This moves all compaction sysctls to its own file.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 include/linux/compaction.h |  7 ----
 kernel/sysctl.c            | 59 --------------------------
 mm/compaction.c            | 84 ++++++++++++++++++++++++++++++++------
 3 files changed, 72 insertions(+), 78 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 52a9ff65faee..a6e512cfb670 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -81,13 +81,6 @@ static inline unsigned long compact_gap(unsigned int order)
 }

 #ifdef CONFIG_COMPACTION
-extern unsigned int sysctl_compaction_proactiveness;
-extern int sysctl_compaction_handler(struct ctl_table *table, int write,
-			void *buffer, size_t *length, loff_t *ppos);
-extern int compaction_proactiveness_sysctl_handler(struct ctl_table *table,
-		int write, void *buffer, size_t *length, loff_t *ppos);
-extern int sysctl_extfrag_threshold;
-extern int sysctl_compact_unevictable_allowed;

 extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
 extern int fragmentation_index(struct zone *zone, unsigned int order);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ce0297acf97c..e23061f33237 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -42,7 +42,6 @@
 #include <linux/highuid.h>
 #include <linux/writeback.h>
 #include <linux/ratelimit.h>
-#include <linux/compaction.h>
 #include <linux/hugetlb.h>
 #include <linux/initrd.h>
 #include <linux/key.h>
@@ -746,27 +745,6 @@ int proc_dointvec(struct ctl_table *table, int write, void *buffer,
 	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
 }

-#ifdef CONFIG_COMPACTION
-static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int ret, old;
-
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
-		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-
-	old = *(int *)table->data;
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret)
-		return ret;
-	if (old != *(int *)table->data)
-		pr_warn_once("sysctl attribute %s changed by %s[%d]\n",
-			     table->procname, current->comm,
-			     task_pid_nr(current));
-	return ret;
-}
-#endif
-
 /**
  * proc_douintvec - read a vector of unsigned integers
  * @table: the sysctl table
@@ -2157,43 +2135,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
-#ifdef CONFIG_COMPACTION
-	{
-		.procname	= "compact_memory",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0200,
-		.proc_handler	= sysctl_compaction_handler,
-	},
-	{
-		.procname	= "compaction_proactiveness",
-		.data		= &sysctl_compaction_proactiveness,
-		.maxlen		= sizeof(sysctl_compaction_proactiveness),
-		.mode		= 0644,
-		.proc_handler	= compaction_proactiveness_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "extfrag_threshold",
-		.data		= &sysctl_extfrag_threshold,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_THOUSAND,
-	},
-	{
-		.procname	= "compact_unevictable_allowed",
-		.data		= &sysctl_compact_unevictable_allowed,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-
-#endif /* CONFIG_COMPACTION */
 	{
 		.procname	= "min_free_kbytes",
 		.data		= &min_free_kbytes,
diff --git a/mm/compaction.c b/mm/compaction.c
index e689d66cedf4..3dfdb84b9c98 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1728,7 +1728,14 @@ typedef enum {
  * Allow userspace to control policy on scanning the unevictable LRU for
  * compactable pages.
  */
-int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
+static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
+/*
+ * Tunable for proactive compaction. It determines how
+ * aggressively the kernel should compact memory in the
+ * background. It takes values in the range [0, 100].
+ */
+static unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
+static int sysctl_extfrag_threshold = 500;

 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
@@ -2584,8 +2591,6 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 	return ret;
 }

-int sysctl_extfrag_threshold = 500;
-
 /**
  * try_to_compact_pages - Direct compact to satisfy a high-order allocation
  * @gfp_mask: The GFP mask of the current allocation
@@ -2742,14 +2747,7 @@ static void compact_nodes(void)
 		compact_node(nid);
 }

-/*
- * Tunable for proactive compaction. It determines how
- * aggressively the kernel should compact memory in the
- * background. It takes values in the range [0, 100].
- */
-unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
-
-int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
+static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc, nid;
@@ -2779,7 +2777,7 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
  */
-int sysctl_compaction_handler(struct ctl_table *table, int write,
+static int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
 	if (write)
@@ -3075,6 +3073,65 @@ static int kcompactd_cpu_online(unsigned int cpu)
 	return 0;
 }

+static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, old;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
+		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	old = *(int *)table->data;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+	if (old != *(int *)table->data)
+		pr_warn_once("sysctl attribute %s changed by %s[%d]\n",
+			     table->procname, current->comm,
+			     task_pid_nr(current));
+	return ret;
+}
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table vm_compaction[] = {
+	{
+		.procname	= "compact_memory",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0200,
+		.proc_handler	= sysctl_compaction_handler,
+	},
+	{
+		.procname	= "compaction_proactiveness",
+		.data		= &sysctl_compaction_proactiveness,
+		.maxlen		= sizeof(sysctl_compaction_proactiveness),
+		.mode		= 0644,
+		.proc_handler	= compaction_proactiveness_sysctl_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+	{
+		.procname	= "extfrag_threshold",
+		.data		= &sysctl_extfrag_threshold,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_THOUSAND,
+	},
+	{
+		.procname	= "compact_unevictable_allowed",
+		.data		= &sysctl_compact_unevictable_allowed,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax_warn_RT_change,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+#endif
+
 static int __init kcompactd_init(void)
 {
 	int nid;
@@ -3090,6 +3147,9 @@ static int __init kcompactd_init(void)

 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", vm_compaction);
+#endif
 	return 0;
 }
 subsys_initcall(kcompactd_init)
-- 
2.25.1
