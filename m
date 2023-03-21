Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604CE6C2B11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 08:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCUHLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 03:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCUHLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:11:51 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502EA3BD8D;
        Tue, 21 Mar 2023 00:11:47 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PgjTC5G9gz8RV7L;
        Tue, 21 Mar 2023 15:11:43 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 32L7BTdq057573;
        Tue, 21 Mar 2023 15:11:29 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 21 Mar 2023 15:11:31 +0800 (CST)
Date:   Tue, 21 Mar 2023 15:11:31 +0800 (CST)
X-Zmail-TransId: 2afa641958a30e8-bba8c
X-Mailer: Zmail v1.0
Message-ID: <202303211511314414538@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mcgrof@kernel.org>
Cc:     <keescook@chromium.org>, <yzaikin@google.com>,
        <akpm@linux-foundation.org>, <chi.minghao@zte.com.cn>,
        <linmiaohe@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: =?UTF-8?B?W1BBVENIIFY0IDEvMl0gbW06IGNvbXBhY3Rpb246IG1vdmUgY29tcGFjdGlvbiBzeXNjdGwgdG8gaXRzIG93biBmaWxl?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 32L7BTdq057573
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 641958AF.003 by FangMail milter!
X-FangMail-Envelope: 1679382703/4PgjTC5G9gz8RV7L/641958AF.003/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641958AF.003/4PgjTC5G9gz8RV7L
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

This moves all compaction sysctls to its own file.

Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 include/linux/compaction.h |  7 ----
 kernel/sysctl.c            | 58 -------------------------------
 mm/compaction.c            | 70 ++++++++++++++++++++++++++++++++++----
 3 files changed, 64 insertions(+), 71 deletions(-)

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
index ce0297acf97c..49a405447c77 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -746,27 +746,6 @@ int proc_dointvec(struct ctl_table *table, int write, void *buffer,
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
@@ -2157,43 +2136,6 @@ static struct ctl_table vm_table[] = {
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
index e689d66cedf4..f56b3dc4563b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1728,7 +1728,7 @@ typedef enum {
  * Allow userspace to control policy on scanning the unevictable LRU for
  * compactable pages.
  */
-int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
+static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;

 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
@@ -2052,7 +2052,7 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)

 	return score;
 }
-
+unsigned int sysctl_compaction_proactiveness;
 static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
 {
 	unsigned int wmark_low;
@@ -2228,7 +2228,7 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,

 	return COMPACT_CONTINUE;
 }
-
+static int sysctl_extfrag_threshold = 500;
 /*
  * compaction_suitable: Is this suitable to run compaction on this zone now?
  * Returns
@@ -2584,7 +2584,6 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 	return ret;
 }

-int sysctl_extfrag_threshold = 500;

 /**
  * try_to_compact_pages - Direct compact to satisfy a high-order allocation
@@ -2749,7 +2748,7 @@ static void compact_nodes(void)
  */
 unsigned int __read_mostly sysctl_compaction_proactiveness = 20;

-int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
+static int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc, nid;
@@ -2779,7 +2778,7 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
  * This is the entry point for compacting all nodes via
  * /proc/sys/vm/compact_memory
  */
-int sysctl_compaction_handler(struct ctl_table *table, int write,
+static int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos)
 {
 	if (write)
@@ -3074,7 +3073,63 @@ static int kcompactd_cpu_online(unsigned int cpu)
 	}
 	return 0;
 }
+static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, old;

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
 static int __init kcompactd_init(void)
 {
 	int nid;
@@ -3090,6 +3145,9 @@ static int __init kcompactd_init(void)

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
