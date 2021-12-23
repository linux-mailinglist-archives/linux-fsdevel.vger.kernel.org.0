Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7270C47E345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348270AbhLWMa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:30:26 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49897 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243453AbhLWMaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:30:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V.XmPDo_1640262604;
Received: from AliYun.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0V.XmPDo_1640262604)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 20:30:20 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     adobriyan@gmail.com, CruzZhao@linux.alibaba.com,
        joshdon@google.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] sched/core: Uncookied force idle accounting per cpu
Date:   Thu, 23 Dec 2021 20:30:03 +0800
Message-Id: <1640262603-19339-3-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Forced idle can be divided into two types, forced idle with cookie'd task
running on it SMT sibling, and forced idle with uncookie'd task running
on it SMT sibling, which should be accounting to measure the cost of
enabling core scheduling too.

This patch accounts the forced idle time with uncookie'd task, and the
sum of both.

A few details:
 - Uncookied forceidle time and total forceidle time is displayed via
   the last two columns of /proc/stat.
 - Uncookied forceidle time is ony accounted when this cpu is forced
   idle and a sibling hyperthread is running with an uncookie'd task.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 fs/proc/stat.c              | 13 ++++++++++++-
 include/linux/kernel_stat.h |  1 +
 kernel/sched/core.c         |  3 +--
 kernel/sched/core_sched.c   |  7 ++++---
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 3a2fbc9..21607cf 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -110,7 +110,7 @@ static int show_stat(struct seq_file *p, void *v)
 	int i, j;
 	u64 user, nice, system, idle, iowait, irq, softirq, steal;
 #ifdef CONFIG_SCHED_CORE
-	u64 cookied_forceidle = 0;
+	u64 cookied_forceidle, uncookied_forceidle, forceidle;
 #endif
 	u64 guest, guest_nice;
 	u64 sum = 0;
@@ -121,6 +121,9 @@ static int show_stat(struct seq_file *p, void *v)
 	user = nice = system = idle = iowait =
 		irq = softirq = steal = 0;
 	guest = guest_nice = 0;
+#ifdef CONFIG_SCHED_CORE
+	cookied_forceidle = uncookied_forceidle = forceidle = 0;
+#endif
 	getboottime64(&boottime);
 	/* shift boot timestamp according to the timens offset */
 	timens_sub_boottime(&boottime);
@@ -145,6 +148,8 @@ static int show_stat(struct seq_file *p, void *v)
 		sum		+= arch_irq_stat_cpu(i);
 #ifdef CONFIG_SCHED_CORE
 		cookied_forceidle	+= cpustat[CPUTIME_COOKIED_FORCEIDLE];
+		uncookied_forceidle	+= cpustat[CPUTIME_UNCOOKIED_FORCEIDLE];
+		forceidle		= cookied_forceidle + uncookied_forceidle;
 #endif
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
@@ -168,6 +173,8 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
 #ifdef CONFIG_SCHED_CORE
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(cookied_forceidle));
+	seq_put_decimal_ull(p, " ", nsec_to_clock_t(uncookied_forceidle));
+	seq_put_decimal_ull(p, " ", nsec_to_clock_t(forceidle));
 #endif
 	seq_putc(p, '\n');
 
@@ -190,6 +197,8 @@ static int show_stat(struct seq_file *p, void *v)
 		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
 #ifdef CONFIG_SCHED_CORE
 		cookied_forceidle	= cpustat[CPUTIME_COOKIED_FORCEIDLE];
+		uncookied_forceidle	= cpustat[CPUTIME_UNCOOKIED_FORCEIDLE];
+		forceidle		= cookied_forceidle + uncookied_forceidle;
 #endif
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
@@ -204,6 +213,8 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
 #ifdef CONFIG_SCHED_CORE
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(cookied_forceidle));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(uncookied_forceidle));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(forceidle));
 #endif
 		seq_putc(p, '\n');
 	}
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index a21b065..23945c1 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -30,6 +30,7 @@ enum cpu_usage_stat {
 	CPUTIME_GUEST_NICE,
 #ifdef CONFIG_SCHED_CORE
 	CPUTIME_COOKIED_FORCEIDLE,
+	CPUTIME_UNCOOKIED_FORCEIDLE,
 #endif
 	NR_STATS,
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f4f4b24..16d937e4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5822,8 +5822,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	}
 
 	if (rq->core->core_forceidle_count) {
-		if (cookie)
-			rq->core->core_forceidle_start = rq_clock(rq->core);
+		rq->core->core_forceidle_start = rq_clock(rq->core);
 		rq->core->core_forceidle_occupation = occ;
 	}
 
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index bc5f45f..89bd49d 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -265,11 +265,12 @@ void sched_core_account_forceidle(struct rq *rq)
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick ?: rq_i->curr;
 
-		if (!rq->core->core_cookie)
-			continue;
 		if (p == rq_i->idle && rq_i->nr_running) {
 			cpustat = kcpustat_cpu(i).cpustat;
-			cpustat[CPUTIME_COOKIED_FORCEIDLE] += delta;
+			if (rq->core->core_cookie)
+				cpustat[CPUTIME_COOKIED_FORCEIDLE] += delta;
+			else
+				cpustat[CPUTIME_UNCOOKIED_FORCEIDLE] += delta;
 		}
 	}
 
-- 
1.8.3.1

