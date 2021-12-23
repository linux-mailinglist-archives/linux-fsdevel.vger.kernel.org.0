Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6ED47E342
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbhLWMaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:30:23 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:57702 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348242AbhLWMaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:30:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V.XmPDo_1640262604;
Received: from AliYun.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0V.XmPDo_1640262604)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 20:30:19 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     adobriyan@gmail.com, CruzZhao@linux.alibaba.com,
        joshdon@google.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
Date:   Thu, 23 Dec 2021 20:30:02 +0800
Message-Id: <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds accounting for "forced idle" time per cpu, which is time where a
cpu is forced to idle by a cookie'd task running on its SMT sibling.

Josh Don's patch 4feee7d12603 ("sched/core: Forced idle accounting")
provides one means to measure the cost of enabling core scheduling
from the perspective of the task, and this patch provides another
means to do that from the perspective of the cpu.

A few details:
 - Cookied forceidle time is displayed via the last column of
   /proc/stat.
 - Cookied forceidle time is ony accounted when this cpu is forced
   idle and a sibling hyperthread is running with a cookie'd task.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 fs/proc/stat.c              | 15 +++++++++++++++
 include/linux/kernel_stat.h |  3 +++
 kernel/sched/core.c         |  4 ++--
 kernel/sched/core_sched.c   | 20 ++++++++++++++++++--
 kernel/sched/sched.h        | 10 ++--------
 5 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 4fb8729..3a2fbc9 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -109,6 +109,9 @@ static int show_stat(struct seq_file *p, void *v)
 {
 	int i, j;
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
+#ifdef CONFIG_SCHED_CORE
+	u64 cookied_forceidle = 0;
+#endif
 	u64 guest, guest_nice;
 	u64 sum = 0;
 	u64 sum_softirq = 0;
@@ -140,6 +143,9 @@ static int show_stat(struct seq_file *p, void *v)
 		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
+#ifdef CONFIG_SCHED_CORE
+		cookied_forceidle	+= cpustat[CPUTIME_COOKIED_FORCEIDLE];
+#endif
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
 			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
@@ -160,6 +166,9 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
+#ifdef CONFIG_SCHED_CORE
+	seq_put_decimal_ull(p, " ", nsec_to_clock_t(cookied_forceidle));
+#endif
 	seq_putc(p, '\n');
 
 	for_each_online_cpu(i) {
@@ -179,6 +188,9 @@ static int show_stat(struct seq_file *p, void *v)
 		steal		= cpustat[CPUTIME_STEAL];
 		guest		= cpustat[CPUTIME_GUEST];
 		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
+#ifdef CONFIG_SCHED_CORE
+		cookied_forceidle	= cpustat[CPUTIME_COOKIED_FORCEIDLE];
+#endif
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
@@ -190,6 +202,9 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
+#ifdef CONFIG_SCHED_CORE
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cookied_forceidle));
+#endif
 		seq_putc(p, '\n');
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 69ae6b2..a21b065 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -28,6 +28,9 @@ enum cpu_usage_stat {
 	CPUTIME_STEAL,
 	CPUTIME_GUEST,
 	CPUTIME_GUEST_NICE,
+#ifdef CONFIG_SCHED_CORE
+	CPUTIME_COOKIED_FORCEIDLE,
+#endif
 	NR_STATS,
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 956d699..f4f4b24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5723,7 +5723,6 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	need_sync = !!rq->core->core_cookie;
 
 	/* reset state */
-	rq->core->core_cookie = 0UL;
 	if (rq->core->core_forceidle_count) {
 		if (!core_clock_updated) {
 			update_rq_clock(rq->core);
@@ -5737,6 +5736,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 		need_sync = true;
 		fi_before = true;
 	}
+	rq->core->core_cookie = 0UL;
 
 	/*
 	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
@@ -5821,7 +5821,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 		}
 	}
 
-	if (schedstat_enabled() && rq->core->core_forceidle_count) {
+	if (rq->core->core_forceidle_count) {
 		if (cookie)
 			rq->core->core_forceidle_start = rq_clock(rq->core);
 		rq->core->core_forceidle_occupation = occ;
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1fb4567..bc5f45f 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -239,13 +239,14 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 #ifdef CONFIG_SCHEDSTATS
 
 /* REQUIRES: rq->core's clock recently updated. */
-void __sched_core_account_forceidle(struct rq *rq)
+void sched_core_account_forceidle(struct rq *rq)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
 	u64 delta, now = rq_clock(rq->core);
 	struct rq *rq_i;
 	struct task_struct *p;
 	int i;
+	u64 *cpustat;
 
 	lockdep_assert_rq_held(rq);
 
@@ -260,6 +261,21 @@ void __sched_core_account_forceidle(struct rq *rq)
 
 	rq->core->core_forceidle_start = now;
 
+	for_each_cpu(i, smt_mask) {
+		rq_i = cpu_rq(i);
+		p = rq_i->core_pick ?: rq_i->curr;
+
+		if (!rq->core->core_cookie)
+			continue;
+		if (p == rq_i->idle && rq_i->nr_running) {
+			cpustat = kcpustat_cpu(i).cpustat;
+			cpustat[CPUTIME_COOKIED_FORCEIDLE] += delta;
+		}
+	}
+
+	if (!schedstat_enabled())
+		return;
+
 	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
 		/* can't be forced idle without a running task */
 	} else if (rq->core->core_forceidle_count > 1 ||
@@ -292,7 +308,7 @@ void __sched_core_tick(struct rq *rq)
 	if (rq != rq->core)
 		update_rq_clock(rq->core);
 
-	__sched_core_account_forceidle(rq);
+	sched_core_account_forceidle(rq);
 }
 
 #endif /* CONFIG_SCHEDSTATS */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be9..09cb1f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1858,19 +1858,13 @@ static inline void flush_smp_call_function_from_idle(void) { }
 
 #if defined(CONFIG_SCHED_CORE) && defined(CONFIG_SCHEDSTATS)
 
-extern void __sched_core_account_forceidle(struct rq *rq);
-
-static inline void sched_core_account_forceidle(struct rq *rq)
-{
-	if (schedstat_enabled())
-		__sched_core_account_forceidle(rq);
-}
+extern void sched_core_account_forceidle(struct rq *rq);
 
 extern void __sched_core_tick(struct rq *rq);
 
 static inline void sched_core_tick(struct rq *rq)
 {
-	if (sched_core_enabled(rq) && schedstat_enabled())
+	if (sched_core_enabled(rq))
 		__sched_core_tick(rq);
 }
 
-- 
1.8.3.1

