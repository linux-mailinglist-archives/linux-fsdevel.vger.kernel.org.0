Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE526DB9D4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Apr 2023 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDHJ3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Apr 2023 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHJ3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:29:01 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F12BDE5;
        Sat,  8 Apr 2023 02:28:44 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Ptqfx5SkPz4xq1K;
        Sat,  8 Apr 2023 17:28:41 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl2.zte.com.cn with SMTP id 3389SW78058724;
        Sat, 8 Apr 2023 17:28:32 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 8 Apr 2023 17:28:35 +0800 (CST)
Date:   Sat, 8 Apr 2023 17:28:35 +0800 (CST)
X-Zmail-TransId: 2b05643133c3037-ddf59
X-Mailer: Zmail v1.0
Message-ID: <202304081728353557233@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <bsingharora@gmail.com>, <akpm@linux-foundation.org>,
        <mingo@redhat.com>
Cc:     <corbet@lwn.net>, <juri.lelli@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdwqBkZWxheWFjY3Q6IHRyYWNrIGRlbGF5cyBmcm9tIElSUS9TT0ZUSVJR?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3389SW78058724
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 643133C9.002/4Ptqfx5SkPz4xq1K
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang19@zte.com.cn>

Delay accounting does not track the delay of IRQ/SOFTIRQ.  While
IRQ/SOFTIRQ could have obvious impact on some workloads productivity,
such as when workloads are running on system which is busy handling
network IRQ/SOFTIRQ.

Get the delay of IRQ/SOFTIRQ could help users to reduce such delay.
Such as setting interrupt affinity or task affinity, using kernel thread for
NAPI etc. This is inspired by "sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
pressure"[1]. Also fix some code indent problems of older code.

And update tools/accounting/getdelays.c:
    / # ./getdelays -p 156 -di
    print delayacct stats ON
    printing IO accounting
    PID     156

    CPU             count     real total  virtual total    delay total  delay average
                       15       15836008       16218149      275700790         18.380ms
    IO              count    delay total  delay average
                        0              0          0.000ms
    SWAP            count    delay total  delay average
                        0              0          0.000ms
    RECLAIM         count    delay total  delay average
                        0              0          0.000ms
    THRASHING       count    delay total  delay average
                        0              0          0.000ms
    COMPACT         count    delay total  delay average
                        0              0          0.000ms
    WPCOPY          count    delay total  delay average
                       36        7586118          0.211ms
    IRQ             count    delay total  delay average
                       42         929161          0.022ms

[1] commit 52b1364ba0b1("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
Cc: wangyong <wang.yong12@zte.com.cn>
Cc: junhua huang <huang.junhua@zte.com.cn>
---
 Documentation/accounting/delay-accounting.rst |  7 +++--
 include/linux/delayacct.h                     | 15 ++++++++++
 include/uapi/linux/taskstats.h                |  6 +++-
 kernel/delayacct.c                            | 14 +++++++++
 kernel/sched/core.c                           |  1 +
 tools/accounting/getdelays.c                  | 30 +++++++++++--------
 6 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 79f537c9f160..f61c01fc376e 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -16,6 +16,7 @@ d) memory reclaim
 e) thrashing
 f) direct compact
 g) write-protect copy
+h) IRQ/SOFTIRQ

 and makes these statistics available to userspace through
 the taskstats interface.
@@ -49,7 +50,7 @@ this structure. See
 for a description of the fields pertaining to delay accounting.
 It will generally be in the form of counters returning the cumulative
 delay seen for cpu, sync block I/O, swapin, memory reclaim, thrash page
-cache, direct compact, write-protect copy etc.
+cache, direct compact, write-protect copy, IRQ/SOFTIRQ etc.

 Taking the difference of two successive readings of a given
 counter (say cpu_delay_total) for a task will give the delay
@@ -118,7 +119,9 @@ Get sum of delays, since system boot, for all pids with tgid 5::
                        0              0          0.000ms
 	COMPACT         count    delay total  delay average
                        0              0          0.000ms
-   WPCOPY          count    delay total  delay average
+	WPCOPY          count    delay total  delay average
+                       0              0          0.000ms
+	IRQ             count    delay total  delay average
                        0              0          0.000ms

 Get IO accounting for pid 1, it works only with -p::
diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 0da97dba9ef8..6639f48dac36 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -48,10 +48,13 @@ struct task_delay_info {
 	u64 wpcopy_start;
 	u64 wpcopy_delay;	/* wait for write-protect copy */

+	u64 irq_delay;	/* wait for IRQ/SOFTIRQ */
+
 	u32 freepages_count;	/* total count of memory reclaim */
 	u32 thrashing_count;	/* total count of thrash waits */
 	u32 compact_count;	/* total count of memory compact */
 	u32 wpcopy_count;	/* total count of write-protect copy */
+	u32 irq_count;	/* total count of IRQ/SOFTIRQ */
 };
 #endif

@@ -81,6 +84,7 @@ extern void __delayacct_compact_start(void);
 extern void __delayacct_compact_end(void);
 extern void __delayacct_wpcopy_start(void);
 extern void __delayacct_wpcopy_end(void);
+extern void __delayacct_irq(struct task_struct *task, u32 delta);

 static inline void delayacct_tsk_init(struct task_struct *tsk)
 {
@@ -215,6 +219,15 @@ static inline void delayacct_wpcopy_end(void)
 		__delayacct_wpcopy_end();
 }

+static inline void delayacct_irq(struct task_struct *task, u32 delta)
+{
+	if (!static_branch_unlikely(&delayacct_key))
+		return;
+
+	if (task->delays)
+		__delayacct_irq(task, delta);
+}
+
 #else
 static inline void delayacct_init(void)
 {}
@@ -253,6 +266,8 @@ static inline void delayacct_wpcopy_start(void)
 {}
 static inline void delayacct_wpcopy_end(void)
 {}
+static inline void delayacct_irq(struct task_struct *task, u32 delta)
+{}

 #endif /* CONFIG_TASK_DELAY_ACCT */

diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskstats.h
index a7f5b11a8f1b..b50b2eb257a0 100644
--- a/include/uapi/linux/taskstats.h
+++ b/include/uapi/linux/taskstats.h
@@ -34,7 +34,7 @@
  */


-#define TASKSTATS_VERSION	13
+#define TASKSTATS_VERSION	14
 #define TS_COMM_LEN		32	/* should be >= TASK_COMM_LEN
 					 * in linux/sched.h */

@@ -198,6 +198,10 @@ struct taskstats {
 	/* v13: Delay waiting for write-protect copy */
 	__u64    wpcopy_count;
 	__u64    wpcopy_delay_total;
+
+	/* v14: Delay waiting for IRQ/SOFTIRQ */
+	__u64    irq_count;
+	__u64    irq_delay_total;
 };


diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index e39cb696cfbd..6f0c358e73d8 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -179,12 +179,15 @@ int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->compact_delay_total = (tmp < d->compact_delay_total) ? 0 : tmp;
 	tmp = d->wpcopy_delay_total + tsk->delays->wpcopy_delay;
 	d->wpcopy_delay_total = (tmp < d->wpcopy_delay_total) ? 0 : tmp;
+	tmp = d->irq_delay_total + tsk->delays->irq_delay;
+	d->irq_delay_total = (tmp < d->irq_delay_total) ? 0 : tmp;
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
 	d->thrashing_count += tsk->delays->thrashing_count;
 	d->compact_count += tsk->delays->compact_count;
 	d->wpcopy_count += tsk->delays->wpcopy_count;
+	d->irq_count += tsk->delays->irq_count;
 	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);

 	return 0;
@@ -274,3 +277,14 @@ void __delayacct_wpcopy_end(void)
 		      &current->delays->wpcopy_delay,
 		      &current->delays->wpcopy_count);
 }
+
+void __delayacct_irq(struct task_struct *task, u32 delta)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&task->delays->lock, flags);
+	task->delays->irq_delay += delta;
+	task->delays->irq_count++;
+	raw_spin_unlock_irqrestore(&task->delays->lock, flags);
+}
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a380f34789a2..8127fa8dfde7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -704,6 +704,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
 	psi_account_irqtime(rq->curr, irq_delta);
+	delayacct_irq(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 23a15d8f2bf4..1334214546d7 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -198,17 +198,19 @@ static void print_delayacct(struct taskstats *t)
 	printf("\n\nCPU   %15s%15s%15s%15s%15s\n"
 	       "      %15llu%15llu%15llu%15llu%15.3fms\n"
 	       "IO    %15s%15s%15s\n"
-          "      %15llu%15llu%15.3fms\n"
+	       "      %15llu%15llu%15.3fms\n"
 	       "SWAP  %15s%15s%15s\n"
-          "      %15llu%15llu%15.3fms\n"
+	       "      %15llu%15llu%15.3fms\n"
 	       "RECLAIM  %12s%15s%15s\n"
-          "      %15llu%15llu%15.3fms\n"
+	       "      %15llu%15llu%15.3fms\n"
 	       "THRASHING%12s%15s%15s\n"
-          "      %15llu%15llu%15.3fms\n"
+	       "      %15llu%15llu%15.3fms\n"
 	       "COMPACT  %12s%15s%15s\n"
-          "      %15llu%15llu%15.3fms\n"
+	       "      %15llu%15llu%15.3fms\n"
 	       "WPCOPY   %12s%15s%15s\n"
-          "      %15llu%15llu%15.3fms\n",
+	       "      %15llu%15llu%15.3fms\n"
+	       "IRQ   %15s%15s%15s\n"
+	       "      %15llu%15llu%15.3fms\n",
 	       "count", "real total", "virtual total",
 	       "delay total", "delay average",
 	       (unsigned long long)t->cpu_count,
@@ -219,27 +221,31 @@ static void print_delayacct(struct taskstats *t)
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->blkio_count,
 	       (unsigned long long)t->blkio_delay_total,
-          average_ms((double)t->blkio_delay_total, t->blkio_count),
+	       average_ms((double)t->blkio_delay_total, t->blkio_count),
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->swapin_count,
 	       (unsigned long long)t->swapin_delay_total,
-          average_ms((double)t->swapin_delay_total, t->swapin_count),
+	       average_ms((double)t->swapin_delay_total, t->swapin_count),
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->freepages_count,
 	       (unsigned long long)t->freepages_delay_total,
-          average_ms((double)t->freepages_delay_total, t->freepages_count),
+	       average_ms((double)t->freepages_delay_total, t->freepages_count),
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->thrashing_count,
 	       (unsigned long long)t->thrashing_delay_total,
-          average_ms((double)t->thrashing_delay_total, t->thrashing_count),
+	       average_ms((double)t->thrashing_delay_total, t->thrashing_count),
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->compact_count,
 	       (unsigned long long)t->compact_delay_total,
-          average_ms((double)t->compact_delay_total, t->compact_count),
+	       average_ms((double)t->compact_delay_total, t->compact_count),
 	       "count", "delay total", "delay average",
 	       (unsigned long long)t->wpcopy_count,
 	       (unsigned long long)t->wpcopy_delay_total,
-          average_ms((double)t->wpcopy_delay_total, t->wpcopy_count));
+	       average_ms((double)t->wpcopy_delay_total, t->wpcopy_count),
+	       "count", "delay total", "delay average",
+	       (unsigned long long)t->irq_count,
+	       (unsigned long long)t->irq_delay_total,
+	       average_ms((double)t->irq_delay_total, t->irq_count));
 }

 static void task_context_switch_counts(struct taskstats *t)
-- 
2.25.1
