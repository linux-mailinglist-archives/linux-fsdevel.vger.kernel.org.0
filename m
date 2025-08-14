Return-Path: <linux-fsdevel+bounces-57826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82CB25A1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EEC5C1221
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 03:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E4D194C96;
	Thu, 14 Aug 2025 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hL3R8q5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4C2836F;
	Thu, 14 Aug 2025 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755143659; cv=none; b=DKWoIGpTnXhkvmFjP+vh8p7sBEjaZVysA7T7OrcP+agwT4/ZiFbJWfygTvUDQ/oqc8+nOw4F81YaTUGIw6WfFTMW3ZjMcvHw4tNcPLo6APLir8XANz7uXo5q1tgqdg3mgE++0jwcyN7Aid23CdcA6pcfdZ0m2rFp0tmbdZ6wA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755143659; c=relaxed/simple;
	bh=wDK0eX+KK2+SpbwmEPed0XoHN6lDNAQFA8XExzq50lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsmGXGoSJfAI/7ZTlKcg7Ku9LKMzaEMQouPoZdPCRUzkyXPyAye2d2hw3M1ghz0/LYrxAWahGIwwt0oJhbUuTdNyofqQlWY5iuhw6A2/TnOhRrXZMp0mvViK9PDePjGCe2auA0hngKpqFc1qbF4xshChArTnF9anLeOcPTXLd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hL3R8q5f; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755143654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T+Ym3fZ+AnHT9AvQuTJapbVedXNyrAy6w7aioM5SVPQ=;
	b=hL3R8q5fyaVCwRv4/J/7aidX4LXVJPL979TL+ylHcsN/Ybo/MMMFQ+VyGGTLvRPS3xR7z2
	b/nz976ZzX4MrN3BpVyxbrL7fQ0e3Wga2aVkeLga4Xp7W3T9jhfDuP+WGDJhcoFTt/BMV2
	p1KykZjtwIc0Y82cuHimwtiHYiik1Q8=
From: David Dai <david.dai@linux.dev>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	david.dai@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH] cputime, proc/stat: Fix cputime reporting in /proc/stat
Date: Wed, 13 Aug 2025 20:54:00 -0700
Message-ID: <20250814035400.4104403-1-david.dai@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Due to the tick based time accounting found in cputime where it
attributes an entire tick's worth of time to a cpustat bucket everytime
it samples based on the current CPU state, significant artifacts can
occur on system wide cpustats which can cascade into large accounting
errors.

In workloads running erlang, we observed that userspace threads such as
"erts_sched" wake up every 1ms to do ~50us of work that can line up with
the scheduler's tick(1000HZ) boundary. This resulted in a much larger
amount of time being attributed to the user bucket, and in CPUs
appearing to be ~30% busy while the task itself only took up ~5% of CPU
time.

In addition to the inaccuracies from tick-based accounting, /proc/stat
reports using a combination of tick-based for some buckets and more
precise time accounting methods such as get_cpu_sleep_time_us() for idle
which results in further discrepancies. As an example, this can be
easily reproduced by spinning up a periodic workload with a 50% duty
cycle that wakes every 1ms and then reading out /proc/stat every 1
second to compare the delta.

On a 1000HZ system, time delta per sec read out (converted to ms):
user: 990 nice: 0 system: 0 idle: 480 irq: 0 softirq: 0 ...

When more accurate time accounting is available for tracking idle time,
we can determine non-idle time to split between the various buckets
using ratios from tick based accounting. This is a similar technique
used in cputime_adjust for cgroup and per task cputime accounting.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: David Dai <david.dai@linux.dev>
---
 fs/proc/stat.c              |  19 ++++++
 include/linux/kernel_stat.h |  34 +++++++++++
 kernel/sched/cputime.c      | 119 +++++++++++++++++++++++++++++++++++-
 3 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 8b444e862319..6ecef606b07f 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -12,6 +12,7 @@
 #include <linux/time.h>
 #include <linux/time_namespace.h>
 #include <linux/irqnr.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
 
@@ -22,6 +23,10 @@
 #define arch_irq_stat() 0
 #endif
 
+#ifdef CONFIG_NO_HZ_COMMON
+DEFINE_PER_CPU(struct prev_kcpustat, prev_cpustat);
+#endif
+
 u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 idle, idle_usecs = -1ULL;
@@ -102,6 +107,10 @@ static int show_stat(struct seq_file *p, void *v)
 
 		kcpustat_cpu_fetch(&kcpustat, i);
 
+#ifdef CONFIG_NO_HZ_COMMON
+		split_cputime_using_ticks(cpustat, &per_cpu(prev_cpustat, i),
+					  sched_clock_cpu(i), i);
+#endif
 		user		+= cpustat[CPUTIME_USER];
 		nice		+= cpustat[CPUTIME_NICE];
 		system		+= cpustat[CPUTIME_SYSTEM];
@@ -142,6 +151,10 @@ static int show_stat(struct seq_file *p, void *v)
 
 		kcpustat_cpu_fetch(&kcpustat, i);
 
+#ifdef CONFIG_NO_HZ_COMMON
+		split_cputime_using_ticks(cpustat, &per_cpu(prev_cpustat, i),
+					  sched_clock_cpu(i), i);
+#endif
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user		= cpustat[CPUTIME_USER];
 		nice		= cpustat[CPUTIME_NICE];
@@ -210,6 +223,12 @@ static const struct proc_ops stat_proc_ops = {
 
 static int __init proc_stat_init(void)
 {
+#ifdef CONFIG_NO_HZ_COMMON
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		prev_kcpustat_init(&per_cpu(prev_cpustat, cpu));
+#endif
 	proc_create("stat", 0, NULL, &stat_proc_ops);
 	return 0;
 }
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index b97ce2df376f..d649bbd3635d 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -42,6 +42,11 @@ struct kernel_stat {
 	unsigned int softirqs[NR_SOFTIRQS];
 };
 
+struct prev_kcpustat {
+	u64 cpustat[NR_STATS];
+	raw_spinlock_t lock;
+};
+
 DECLARE_PER_CPU(struct kernel_stat, kstat);
 DECLARE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
 
@@ -51,6 +56,9 @@ DECLARE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
 #define kstat_cpu(cpu) per_cpu(kstat, cpu)
 #define kcpustat_cpu(cpu) per_cpu(kernel_cpustat, cpu)
 
+#define for_each_cpustat(cpustat)	\
+	for ((cpustat) = 0; (cpustat) < NR_STATS; (cpustat)++)
+
 extern unsigned long long nr_context_switches_cpu(int cpu);
 extern unsigned long long nr_context_switches(void);
 
@@ -141,4 +149,30 @@ extern void account_idle_ticks(unsigned long ticks);
 extern void __account_forceidle_time(struct task_struct *tsk, u64 delta);
 #endif
 
+extern void split_cputime_using_ticks(u64 *cpustat, struct prev_kcpustat *prev_kcpustat,
+				      u64 now, int cpu);
+static inline void prev_kcpustat_init(struct prev_kcpustat *prev)
+{
+#ifdef CONFIG_NO_HZ_COMMON
+	int i;
+
+	for_each_cpustat(i)
+		prev->cpustat[i] = 0;
+	raw_spin_lock_init(&prev->lock);
+#endif
+}
+
+static inline bool exec_cputime(int idx)
+{
+	switch (idx) {
+	case CPUTIME_USER:
+	case CPUTIME_NICE:
+	case CPUTIME_SYSTEM:
+	case CPUTIME_GUEST:
+	case CPUTIME_GUEST_NICE:
+		return true;
+	default:
+		return false;
+	}
+}
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..50c710f81df7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1092,5 +1092,122 @@ void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 	}
 }
 EXPORT_SYMBOL_GPL(kcpustat_cpu_fetch);
-
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
+
+#ifdef CONFIG_NO_HZ_COMMON
+/*
+ * Split precisely tracked exec wall time using tick based buckets
+ *
+ * Use a similar technique to cputime_adjust to split the total exec wall time
+ * used by the CPU to its respective buckets by scaling these tick based values
+ * against the total wall time accounted. Similar to cputime_adjust, this
+ * function guarantees monotonicity for the various buckets and total time
+ * delta distributed does not exceed exec time passed.
+ *
+ * This is only useful when idle time can be accounted for accurately.
+ *
+ * Due to various imprecisions in tick accounting/other time accounting and
+ * rounding errors, this is a best effort at distributing time to their
+ * respective buckets.
+ *
+ */
+void split_cputime_using_ticks(u64 *cpustat, struct prev_kcpustat *prev_kcpustat, u64 now, int cpu)
+{
+	u64 exec_ticks, exec_time, prev_exec_time, deficit, idle = -1ULL, iowait = -1ULL;
+	u64 *prev_cpustat;
+	unsigned long flags;
+	int i;
+
+	raw_spin_lock_irqsave(&prev_kcpustat->lock, flags);
+	prev_cpustat = prev_kcpustat->cpustat;
+
+	if (cpu_online(cpu)) {
+		idle = get_cpu_idle_time_us(cpu, NULL);
+		iowait = get_cpu_iowait_time_us(cpu, NULL);
+	}
+
+	/*
+	 * If the cpu is offline, we still need to update prev_kcpustat as the
+	 * accounting changes between non-ticked vs tick based to ensure
+	 * monotonicity for future adjustments.
+	 */
+	if (idle == -1ULL || iowait == -1ULL)
+		goto update;
+
+	prev_exec_time = 0;
+	for_each_cpustat(i) {
+		if (!exec_cputime(i))
+			continue;
+		prev_exec_time += prev_cpustat[i];
+	}
+
+	exec_time = now - (idle + iowait) * NSEC_PER_USEC -
+		cpustat[CPUTIME_IRQ] - cpustat[CPUTIME_SOFTIRQ] -
+		cpustat[CPUTIME_STEAL];
+
+	if (prev_exec_time >= exec_time) {
+		for_each_cpustat(i) {
+			if (!exec_cputime(i))
+				continue;
+			cpustat[i] = prev_cpustat[i];
+		}
+		goto out;
+	}
+
+	exec_ticks = 0;
+	for_each_cpustat(i) {
+		if (!exec_cputime(i))
+			continue;
+		 exec_ticks += cpustat[i];
+	}
+
+	/*
+	 * To guarantee monotonicity for all buckets and to ensure we don't
+	 * over allocate time, we keep track of deficits in the first pass to
+	 * subtract from surpluses in the second.
+	 */
+	deficit = 0;
+	for_each_cpustat(i) {
+		if (!exec_cputime(i))
+			continue;
+
+		cpustat[i] = mul_u64_u64_div_u64(cpustat[i], exec_time, exec_ticks);
+		if (cpustat[i] < prev_cpustat[i]) {
+			deficit += prev_cpustat[i] - cpustat[i];
+			cpustat[i] = prev_cpustat[i];
+		}
+	}
+
+	/*
+	 * Subtract from the time buckets that have a surplus. The way this is
+	 * distributed isn't fair, but for simplicity's sake just go down the
+	 * list of buckets and take time away until we balance the deficit.
+	 */
+	for_each_cpustat(i) {
+		if (!exec_cputime(i))
+			continue;
+		if (!deficit)
+			break;
+		if (cpustat[i] > prev_cpustat[i]) {
+			u64 delta = min_t(u64, cpustat[i] - prev_cpustat[i], deficit);
+
+			cpustat[i] -= delta;
+			deficit -= delta;
+		}
+	}
+
+update:
+	for_each_cpustat(i) {
+		if (!exec_cputime(i))
+			continue;
+		prev_cpustat[i] = cpustat[i];
+	}
+out:
+	raw_spin_unlock_irqrestore(&prev_kcpustat->lock, flags);
+}
+#else
+void split_cputime_using_ticks(u64 *cpustat, struct prev_kcpustat *prev_kcpustat, u64 now, int cpu)
+{
+	/* Do nothing since accurate idle time accounting isn't available. */
+}
+#endif
-- 
2.47.3


