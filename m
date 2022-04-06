Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2047A4F6558
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiDFQXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiDFQW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:22:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A3A2300A7;
        Tue,  5 Apr 2022 19:28:43 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KY7jC4CTwz1HBTX;
        Wed,  6 Apr 2022 10:28:15 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 10:28:40 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <liaochang1@huawei.com>, <tglx@linutronix.de>, <nitesh@redhat.com>,
        <edumazet@google.com>, <clg@kaod.org>, <tannerlove@google.com>,
        <peterz@infradead.org>, <joshdon@google.com>,
        <masahiroy@kernel.org>, <nathan@kernel.org>, <vbabka@suse.cz>,
        <akpm@linux-foundation.org>, <gustavoars@kernel.org>,
        <arnd@arndb.de>, <chris@chrisdown.name>,
        <dmitry.torokhov@gmail.com>, <linux@rasmusvillemoes.dk>,
        <daniel@iogearbox.net>, <john.ogness@linutronix.de>,
        <will@kernel.org>, <dave@stgolabs.net>, <frederic@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <heying24@huawei.com>, <guohanjun@huawei.com>,
        <weiyongjun1@huawei.com>
Subject: [RFC 3/3] softirq: Introduce statistics about softirq throttling
Date:   Wed, 6 Apr 2022 10:27:49 +0800
Message-ID: <20220406022749.184807-4-liaochang1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406022749.184807-1-liaochang1@huawei.com>
References: <20220406022749.184807-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces counting the number of time spent on softirqs for
each CPU and the number of time that softirqs has been throttled for
each CPU, which are reported in /proc/softirqs, for example:

$cat /proc/softirqs
                    CPU0       CPU1       CPU2       CPU3
          HI:          0          0          0          0
       TIMER:       1088        855        197       4862
      NET_TX:          0          0          0          0
      NET_RX:         15          1          0          0
       BLOCK:         14         11         86         75
    IRQ_POLL:          0          0          0          0
     TASKLET:    5926026    6133070    5646523    6149053
       SCHED:      18061      15939      15746      16004
     HRTIMER:          0          0          0          0
         RCU:        668        778        939        720
                    CPU0       CPU1       CPU2       CPU3
 DURATION_MS:      91556      69888      66784      73772
 THROTTLE_MS:      77820       7328       5828       8904

Row starts with "DURATION_MS:" indicates how many milliseconds used for
softirqs on each CPU. Row starts with "THROTTLE_MS:" indicates how many
milliseconds softirq throttling lasted on each CPU.

Notice: the rate of "THROTTLE_MS" increase is controlled by parameter
"kernel.softirq_period_ms" and "kernel.softirq_runtime_ms", generally
speaking, the smaller softirq CPU bandwidth is, the faster "THROTTLE_MS"
increase, especially when pending softirq workload is very heavy.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 fs/proc/softirqs.c          | 18 ++++++++++++++++++
 include/linux/kernel_stat.h | 27 +++++++++++++++++++++++++++
 kernel/softirq.c            | 15 +++++++++++++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index 12901dcf57e2..5ea3ede9833e 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -22,6 +22,24 @@ static int show_softirqs(struct seq_file *p, void *v)
 			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
 		seq_putc(p, '\n');
 	}
+
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+	seq_puts(p, "                    ");
+	for_each_possible_cpu(i)
+		seq_printf(p, "CPU%-8d", i);
+	seq_putc(p, '\n');
+
+	seq_printf(p, "%12s:", "DURATION_MS");
+	for_each_possible_cpu(j)
+		seq_printf(p, " %10lu", kstat_softirq_duration(j));
+	seq_putc(p, '\n');
+
+	seq_printf(p, "%12s:", "THROTTLE_MS");
+	for_each_possible_cpu(j)
+		seq_printf(p, " %10lu", kstat_softirq_throttle(j));
+	seq_putc(p, '\n');
+#endif
+
 	return 0;
 }
 
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 69ae6b278464..bbb52c55aad4 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -38,6 +38,11 @@ struct kernel_cpustat {
 struct kernel_stat {
 	unsigned long irqs_sum;
 	unsigned int softirqs[NR_SOFTIRQS];
+
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+	unsigned long softirq_duration;
+	unsigned long softirq_throttle;
+#endif
 };
 
 DECLARE_PER_CPU(struct kernel_stat, kstat);
@@ -64,6 +69,28 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
        return kstat_cpu(cpu).softirqs[irq];
 }
 
+#ifdef CONFIG_SOFTIRQ_THROTTLE
+static inline unsigned long kstat_softirq_duration(int cpu)
+{
+	return jiffies_to_msecs(kstat_cpu(cpu).softirq_duration);
+}
+
+static inline unsigned long kstat_softirq_throttle(int cpu)
+{
+	return jiffies_to_msecs(kstat_cpu(cpu).softirq_throttle);
+}
+
+static inline unsigned long kstat_incr_softirq_duration(unsigned long delta)
+{
+	return kstat_this_cpu->softirq_duration += delta;
+}
+
+static inline unsigned long kstat_incr_softirq_throttle(unsigned long delta)
+{
+	return kstat_this_cpu->softirq_throttle += delta;
+}
+#endif
+
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6de6db794ac5..7fc0dc39f788 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -79,6 +79,7 @@ struct softirq_runtime {
 	bool	throttled;
 	unsigned long	duration;
 	unsigned long	expires;
+	unsigned long	throttled_ts;
 	raw_spinlock_t lock;
 };
 static DEFINE_PER_CPU(struct softirq_runtime, softirq_runtime);
@@ -94,12 +95,16 @@ static void forward_softirq_expires(struct softirq_runtime *si_runtime)
 static void update_softirq_runtime(unsigned long duration)
 {
 	struct softirq_runtime *si_runtime = this_cpu_ptr(&softirq_runtime);
+	unsigned long now = jiffies;
+
+	kstat_incr_softirq_duration(duration);
 
 	raw_spin_lock(&si_runtime->lock);
 	si_runtime->duration += jiffies_to_msecs(duration);
 	if ((si_runtime->duration >= si_throttle.runtime) &&
-		time_before(jiffies, si_runtime->expires)) {
+		time_before(now, si_runtime->expires)) {
 		si_runtime->throttled = true;
+		si_runtime->throttled_ts = now;
 	}
 	raw_spin_unlock(&si_runtime->lock);
 }
@@ -107,13 +112,17 @@ static void update_softirq_runtime(unsigned long duration)
 static bool softirq_runtime_exceeded(void)
 {
 	struct softirq_runtime *si_runtime = this_cpu_ptr(&softirq_runtime);
+	unsigned long now = jiffies;
 
 	if ((unsigned int)si_throttle.runtime >= si_throttle.period)
 		return false;
 
 	raw_spin_lock(&si_runtime->lock);
-	if (!time_before(jiffies, si_runtime->expires))
+	if (!time_before(now, si_runtime->expires)) {
+		if (si_runtime->throttled)
+			kstat_incr_softirq_throttle(now - si_runtime->throttled_ts);
 		forward_softirq_expires(si_runtime);
+	}
 	raw_spin_unlock(&si_runtime->lock);
 	return si_runtime->throttled;
 }
@@ -140,6 +149,8 @@ static void softirq_throttle_update(void)
 	for_each_possible_cpu(cpu, &) {
 		si_runtime = per_cpu_ptr(&softirq_runtime, cpu);
 		raw_spin_lock(&si_runtime->lock);
+		if (si_runtime->throttled)
+			kstat_incr_softirq_throttle(jiffies - si_runtime->throttled_ts);
 		forward_softirq_expires(si_runtime);
 		raw_spin_unlock(&si_runtime->lock);
 	}
-- 
2.17.1

