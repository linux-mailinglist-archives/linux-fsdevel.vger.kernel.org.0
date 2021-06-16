Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB903A9E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbhFPPIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:08:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35332 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234432AbhFPPIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:08:17 -0400
X-UUID: 366ce3d2231f4516a17a0529016fd6c6-20210616
X-UUID: 366ce3d2231f4516a17a0529016fd6c6-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yt.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2027821186; Wed, 16 Jun 2021 23:06:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 23:06:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 23:06:02 +0800
From:   YT Chang <yt.chang@mediatek.com>
To:     YT Chang <yt.chang@mediatek.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paul Turner <pjt@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH 1/1] sched: Add tunable capacity margin for fis_capacity
Date:   Wed, 16 Jun 2021 23:05:54 +0800
Message-ID: <1623855954-6970-1-git-send-email-yt.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the margin of cpu frequency raising and cpu overutilized are
hard-coded as 25% (1280/1024). Make the margin tunable
to control the aggressive for placement and frequency control. Such as
for power tuning framework could adjust smaller margin to slow down
frequency raising speed and let task stay in smaller cpu.

For light loading scenarios, like beach buggy blitz and messaging apps,
the app threads are moved big core with 25% margin and causing
unnecessary power.
With 0% capacity margin (1024/1024), the app threads could be kept in
little core and deliver better power results without any fps drop.

capacity margin        0%          10%          20%          30%
                     current        current       current      current
                  Fps  (mA)    Fps    (mA)   Fps   (mA)    Fps  (mA)
Beach buggy blitz  60 198.164  60   203.211  60   209.984  60  213.374
Yahoo browser      60 232.301 59.97 237.52  59.95 248.213  60  262.809

Change-Id: Iba48c556ed1b73c9a2699e9e809bc7d9333dc004
Signed-off-by: YT Chang <yt.chang@mediatek.com>
---
 include/linux/sched/cpufreq.h | 19 +++++++++++++++++++
 include/linux/sched/sysctl.h  |  1 +
 include/linux/sysctl.h        |  1 +
 kernel/sched/fair.c           |  4 +++-
 kernel/sysctl.c               | 15 +++++++++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index 6205578..8a6c23a1 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -23,6 +23,23 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 void cpufreq_remove_update_util_hook(int cpu);
 bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
 
+#ifdef CONFIG_SMP
+extern unsigned int sysctl_sched_capacity_margin;
+
+static inline unsigned long map_util_freq(unsigned long util,
+					  unsigned long freq, unsigned long cap)
+{
+	freq = freq * util / cap;
+	freq = freq * sysctl_sched_capacity_margin / SCHED_CAPACITY_SCALE;
+
+	return freq;
+}
+
+static inline unsigned long map_util_perf(unsigned long util)
+{
+	return util * sysctl_sched_capacity_margin / SCHED_CAPACITY_SCALE;
+}
+#else
 static inline unsigned long map_util_freq(unsigned long util,
 					unsigned long freq, unsigned long cap)
 {
@@ -33,6 +50,8 @@ static inline unsigned long map_util_perf(unsigned long util)
 {
 	return util + (util >> 2);
 }
+#endif
+
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index db2c0f3..5dee024 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -10,6 +10,7 @@
 
 #ifdef CONFIG_SMP
 extern unsigned int sysctl_hung_task_all_cpu_backtrace;
+extern unsigned int sysctl_sched_capacity_margin;
 #else
 #define sysctl_hung_task_all_cpu_backtrace 0
 #endif /* CONFIG_SMP */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index d99ca99..af6d70f 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -41,6 +41,7 @@
 #define SYSCTL_ZERO	((void *)&sysctl_vals[0])
 #define SYSCTL_ONE	((void *)&sysctl_vals[1])
 #define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
+#define SCHED_CAPACITY_MARGIN_MIN   1024
 
 extern const int sysctl_vals[];
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20aa234..609b431 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -111,7 +111,9 @@ int __weak arch_asym_cpu_priority(int cpu)
  *
  * (default: ~20%)
  */
-#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
+unsigned int sysctl_sched_capacity_margin = 1280;
+EXPORT_SYMBOL_GPL(sysctl_sched_capacity_margin);
+#define fits_capacity(cap, max)	((cap) * sysctl_sched_capacity_margin < (max) * 1024)
 
 /*
  * The margin used when comparing CPU capacities.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 14edf84..d6d2b84 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -127,6 +127,11 @@
 static int six_hundred_forty_kb = 640 * 1024;
 #endif
 
+/* this is needed for the proc of sysctl_sched_capacity_margin */
+#ifdef CONFIG_SMP
+static int min_sched_capacity_margin = 1024;
+#endif /* CONFIG_SMP */
+
 /* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
 static unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
 
@@ -1716,6 +1721,16 @@ int proc_do_static_key(struct ctl_table *table, int write,
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+#ifdef CONFIG_SMP
+	{
+		.procname	= "sched_capcity_margin",
+		.data		= &sysctl_sched_capacity_margin,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_sched_capacity_margin,
+	},
+#endif
 #ifdef CONFIG_SCHEDSTATS
 	{
 		.procname	= "sched_schedstats",
-- 
1.9.1

