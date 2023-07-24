Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7875F821
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGXNXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGXNXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:23:48 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC58DA;
        Mon, 24 Jul 2023 06:23:47 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R8gph6cbxz4f3nyk;
        Mon, 24 Jul 2023 21:23:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LNbe75kcavTOg--.2237S6;
        Mon, 24 Jul 2023 21:23:43 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] softirq: redefine the type of kernel_stat.softirqs[] as unsigned long
Date:   Mon, 24 Jul 2023 21:22:24 +0800
Message-Id: <20230724132224.916-3-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230724132224.916-1-thunder.leizhen@huaweicloud.com>
References: <20230724132224.916-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LNbe75kcavTOg--.2237S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43tF48KF13JF1UJryUAwb_yoW7Jw17pF
        yqkFy7Kw4UGa4jvas7JF4DuryUJwn5Ga4akwsxt34fta45Jr1FgFn3u34qqrWjgrW8Ga1S
        yFWayrWjg3yDW3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yEEUUUUUU=
        =
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

As commit aa0ce5bbc2db ("softirq: introduce statistics for softirq")
mentioned, the number of one softirq can exceed 100 per second. At this
rate, the 32-bit sum will overflow after 1.5 years. This problem can be
avoided if the type of 'softirqs[]' is changed to u64, but the atomicity
of the counting operation cannot be guaranteed on 32-bit processors.
Changing to unsigned long can safely solve the problem on 64-bit
processors, and it is the same as the type of 'irqs_sum'.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/proc/softirqs.c          | 2 +-
 fs/proc/stat.c              | 2 +-
 include/linux/kernel_stat.h | 8 ++++----
 kernel/rcu/tree.h           | 2 +-
 kernel/rcu/tree_stall.h     | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index f4616083faef3bb..985be6904d748ab 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -20,7 +20,7 @@ static int show_softirqs(struct seq_file *p, void *v)
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		seq_printf(p, "%12s:", softirq_to_name[i]);
 		for_each_possible_cpu(j)
-			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
+			seq_printf(p, " %10lu", kstat_softirqs_cpu(i, j));
 		seq_putc(p, '\n');
 	}
 	return 0;
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 84aac577a50cabb..7d40d98471d5ab2 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -116,7 +116,7 @@ static int show_stat(struct seq_file *p, void *v)
 		sum		+= arch_irq_stat_cpu(i);
 
 		for (j = 0; j < NR_SOFTIRQS; j++) {
-			unsigned int softirq_stat = kstat_softirqs_cpu(j, i);
+			unsigned long softirq_stat = kstat_softirqs_cpu(j, i);
 
 			per_softirq_sums[j] += softirq_stat;
 			sum_softirq += softirq_stat;
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7ecbfb9e31..b6c5723a1149cd6 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -40,7 +40,7 @@ struct kernel_cpustat {
 
 struct kernel_stat {
 	unsigned long irqs_sum;
-	unsigned int softirqs[NR_SOFTIRQS];
+	unsigned long softirqs[NR_SOFTIRQS];
 };
 
 DECLARE_PER_CPU(struct kernel_stat, kstat);
@@ -63,15 +63,15 @@ static inline void kstat_incr_softirqs_this_cpu(unsigned int irq)
 	__this_cpu_inc(kstat.softirqs[irq]);
 }
 
-static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
+static inline unsigned long kstat_softirqs_cpu(unsigned int irq, int cpu)
 {
        return kstat_cpu(cpu).softirqs[irq];
 }
 
-static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
+static inline unsigned long kstat_cpu_softirqs_sum(int cpu)
 {
 	int i;
-	unsigned int sum = 0;
+	unsigned long sum = 0;
 
 	for (i = 0; i < NR_SOFTIRQS; i++)
 		sum += kstat_softirqs_cpu(i, cpu);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a607..ce51640cd34f66b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -268,7 +268,7 @@ struct rcu_data {
 	unsigned long rcuc_activity;
 
 	/* 7) Diagnostic data, including RCU CPU stall warnings. */
-	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
+	unsigned long softirq_snap;	/* Snapshot of softirq activity. */
 	/* ->rcu_iw* fields protected by leaf rcu_node ->lock. */
 	struct irq_work rcu_iw;		/* Check for non-irq activity. */
 	bool rcu_iw_pending;		/* Is ->rcu_iw pending? */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0ade7f9dcaa18da..d5b22700abcc385 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -446,7 +446,7 @@ static void print_cpu_stat_info(int cpu)
 	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
 
 	pr_err("\t         hardirqs   softirqs   csw/system\n");
-	pr_err("\t number: %8ld %10d %12lld\n",
+	pr_err("\t number: %8ld %10ld %12lld\n",
 		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
 		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
 		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
@@ -498,7 +498,7 @@ static void print_cpu_stall_info(int cpu)
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
 		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%lu/%lu fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -575,7 +575,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
 		       data_race(READ_ONCE(gpk->__state)));
-		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
+		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%lu\n",
 		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
 	}
 }
-- 
2.25.1

