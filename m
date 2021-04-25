Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD43036A3E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 03:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhDYBWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Apr 2021 21:22:13 -0400
Received: from [119.249.100.101] ([119.249.100.101]:10939 "EHLO
        mx425.baidu.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229687AbhDYBWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Apr 2021 21:22:13 -0400
Received: from unknown.domain.tld (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx425.baidu.com (Postfix) with ESMTP id 1B87C125810A7;
        Sun, 25 Apr 2021 09:21:02 +0800 (CST)
From:   chukaiping <chukaiping@baidu.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nigupta@nvidia.com,
        bhe@redhat.com, khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com,
        mateusznosek0@gmail.com, sh_def@163.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3] mm/compaction:let proactive compaction order configurable
Date:   Sun, 25 Apr 2021 09:21:02 +0800
Message-Id: <1619313662-30356-1-git-send-email-chukaiping@baidu.com>
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
 mm/compaction.c            |    9 ++++++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index ed4070e..151ccd1 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int order)
 #ifdef CONFIG_COMPACTION
 extern int sysctl_compact_memory;
 extern unsigned int sysctl_compaction_proactiveness;
+extern unsigned int sysctl_compaction_order;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_extfrag_threshold;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09..e50f7d2 100644
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
+		.procname       = "compaction_order",
+		.data           = &sysctl_compaction_order,
+		.maxlen         = sizeof(sysctl_compaction_order),
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
index e04f447..70c0acd 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1925,16 +1925,16 @@ static bool kswapd_is_running(pg_data_t *pgdat)
 
 /*
  * A zone's fragmentation score is the external fragmentation wrt to the
- * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
+ * sysctl_compaction_order. It returns a value in the range [0, 100].
  */
 static unsigned int fragmentation_score_zone(struct zone *zone)
 {
-	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
+	return extfrag_for_order(zone, sysctl_compaction_order);
 }
 
 /*
  * A weighted zone's fragmentation score is the external fragmentation
- * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
+ * wrt to the sysctl_compaction_order scaled by the zone's size. It
  * returns a value in the range [0, 100].
  *
  * The scaling factor ensures that proactive compaction focuses on larger
@@ -2666,6 +2666,7 @@ static void compact_nodes(void)
  * background. It takes values in the range [0, 100].
  */
 unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
+unsigned int __read_mostly sysctl_compaction_order;
 
 /*
  * This is the entry point for compacting all nodes via
@@ -2958,6 +2959,8 @@ static int __init kcompactd_init(void)
 	int nid;
 	int ret;
 
+	sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
+
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"mm/compaction:online",
 					kcompactd_cpu_online, NULL);
-- 
1.7.1

