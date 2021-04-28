Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5907E36D089
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 04:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhD1C3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 22:29:35 -0400
Received: from [119.249.100.105] ([119.249.100.105]:14841 "EHLO
        mx425.baidu.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235901AbhD1C3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 22:29:34 -0400
Received: from unknown.domain.tld (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx425.baidu.com (Postfix) with ESMTP id 528BB12580FBF;
        Wed, 28 Apr 2021 10:28:21 +0800 (CST)
From:   chukaiping <chukaiping@baidu.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        bhe@redhat.com, khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com,
        mateusznosek0@gmail.com, sh_def@163.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4] mm/compaction: let proactive compaction order configurable
Date:   Wed, 28 Apr 2021 10:28:21 +0800
Message-Id: <1619576901-9531-1-git-send-email-chukaiping@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the proactive compaction order is fixed to
COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of
normal 4KB memory, but it's too high for the machines with small
normal memory, for example the machines with most memory configured
as 1GB hugetlbfs huge pages. In these machines the max order of
free pages is often below 9, and it's always below 9 even with hard
compaction. This will lead to proactive compaction be triggered very
frequently. In these machines we only care about order of 3 or 4.
This patch export the oder to proc and let it configurable
by user, and the default value is still COMPACTION_HPAGE_ORDER.

Signed-off-by: chukaiping <chukaiping@baidu.com>
Reported-by: kernel test robot <lkp@intel.com>
---

Changes in v4:
    - change the sysctl file name to proactive_compation_order

Changes in v3:
    - change the min value of compaction_order to 1 because the fragmentation
      index of order 0 is always 0
    - move the definition of max_buddy_zone into #ifdef CONFIG_COMPACTION

Changes in v2:
    - fix the compile error in ia64 and powerpc, move the initialization
      of sysctl_compaction_order to kcompactd_init because
      COMPACTION_HPAGE_ORDER is a variable in these architectures
    - change the hard coded max order number from 10 to MAX_ORDER - 1

 include/linux/compaction.h |    1 +
 kernel/sysctl.c            |   10 ++++++++++
 mm/compaction.c            |   12 ++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index ed4070e..a0226b1 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
 #ifdef CONFIG_COMPACTION
 extern int sysctl_compact_memory;
 extern unsigned int sysctl_compaction_proactiveness;
+extern unsigned int sysctl_proactive_compaction_order;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_extfrag_threshold;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09..ed9012e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -196,6 +196,7 @@ enum sysctl_writes_mode {
 #endif /* CONFIG_SCHED_DEBUG */
 
 #ifdef CONFIG_COMPACTION
+static int max_buddy_zone = MAX_ORDER - 1;
 static int min_extfrag_threshold;
 static int max_extfrag_threshold = 1000;
 #endif
@@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.extra2		= &one_hundred,
 	},
 	{
+		.procname       = "proactive_compation_order",
+		.data           = &sysctl_proactive_compaction_order,
+		.maxlen         = sizeof(sysctl_proactive_compaction_order),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ONE,
+		.extra2         = &max_buddy_zone,
+	},
+	{
 		.procname	= "extfrag_threshold",
 		.data		= &sysctl_extfrag_threshold,
 		.maxlen		= sizeof(int),
diff --git a/mm/compaction.c b/mm/compaction.c
index e04f447..171436e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1925,17 +1925,18 @@ static bool kswapd_is_running(pg_data_t *pgdat)
 
 /*
  * A zone's fragmentation score is the external fragmentation wrt to the
- * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
+ * sysctl_proactive_compaction_order. It returns a value in the range
+ * [0, 100].
  */
 static unsigned int fragmentation_score_zone(struct zone *zone)
 {
-	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
+	return extfrag_for_order(zone, sysctl_proactive_compaction_order);
 }
 
 /*
  * A weighted zone's fragmentation score is the external fragmentation
- * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
- * returns a value in the range [0, 100].
+ * wrt to the sysctl_proactive_compaction_order scaled by the zone's size.
+ * It returns a value in the range [0, 100].
  *
  * The scaling factor ensures that proactive compaction focuses on larger
  * zones like ZONE_NORMAL, rather than smaller, specialized zones like
@@ -2666,6 +2667,7 @@ static void compact_nodes(void)
  * background. It takes values in the range [0, 100].
  */
 unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
+unsigned int __read_mostly sysctl_proactive_compaction_order;
 
 /*
  * This is the entry point for compacting all nodes via
@@ -2958,6 +2960,8 @@ static int __init kcompactd_init(void)
 	int nid;
 	int ret;
 
+	sysctl_proactive_compaction_order = COMPACTION_HPAGE_ORDER;
+
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"mm/compaction:online",
 					kcompactd_cpu_online, NULL);
-- 
1.7.1

