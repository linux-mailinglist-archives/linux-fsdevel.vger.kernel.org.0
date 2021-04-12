Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A535C119
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbhDLJVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 05:21:43 -0400
Received: from [119.249.100.41] ([119.249.100.41]:28474 "EHLO
        dbl-sys-mailin02.dbl01.baidu.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S240354AbhDLJTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:19:37 -0400
X-Greylist: delayed 809 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 05:19:36 EDT
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by dbl-sys-mailin02.dbl01.baidu.com (Postfix) with ESMTP id 057A72F00C0A;
        Mon, 12 Apr 2021 17:05:31 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id ECB9693B61;
        Mon, 12 Apr 2021 17:05:30 +0800 (CST)
From:   chukaiping <chukaiping@baidu.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/compaction:let proactive compaction order configurable
Date:   Mon, 12 Apr 2021 17:05:30 +0800
Message-Id: <1618218330-50591-1-git-send-email-chukaiping@baidu.com>
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
---
 include/linux/compaction.h |    1 +
 kernel/sysctl.c            |   10 ++++++++++
 mm/compaction.c            |    7 ++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

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
index 62fbd09..277df31 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -114,6 +114,7 @@
 static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
+static int __maybe_unused ten = 10;
 static unsigned long zero_ul;
 static unsigned long one_ul = 1;
 static unsigned long long_max = LONG_MAX;
@@ -2871,6 +2872,15 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.extra2		= &one_hundred,
 	},
 	{
+		.procname       = "compaction_order",
+		.data           = &sysctl_compaction_order,
+		.maxlen         = sizeof(sysctl_compaction_order),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = &ten,
+	},
+	{
 		.procname	= "extfrag_threshold",
 		.data		= &sysctl_extfrag_threshold,
 		.maxlen		= sizeof(int),
diff --git a/mm/compaction.c b/mm/compaction.c
index e04f447..a192996 100644
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
+unsigned int __read_mostly sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
 
 /*
  * This is the entry point for compacting all nodes via
-- 
1.7.1

