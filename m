Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330433EABCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhHLUcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhHLUcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:32:19 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733AAC0613D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 13:31:53 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id s16-20020a05620a0810b02903d250dfc6a7so4403625qks.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zD3YqN3uKrjqq7dXEXETUikzHIusIdXQADNng2MRWg0=;
        b=k0zAa1liZuKENSSN0W4s5uib7EonBbTNvp/dQ9cPRlx2IJwJ0H6qU972+G8uODGSXZ
         lRATx42r4Z7mdMj4OaGnd4kzU/TvFMKH2tWVGub3E6MN7VgscyZ7Na55GeJGA0BkYuJQ
         PMKLMZZiQJKVEUl8eDgzWD2FSVqH7qc9izOka2DbQAI7JLAy3LXQiTw+/HAxnF1l94ac
         BI3Kb+uiRQRgc5ktQkKKO/oWg4sMQxCXKl+Advsc8iorvoBLAiRiUjb0qbe/MPrgT5Hp
         mjBpZBSnAWsm7ZeZIwC7CpEPPhK3ergL2pvG7jIaqI3qWnc0n9XGO4srUXP1DZtN3VFp
         1qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zD3YqN3uKrjqq7dXEXETUikzHIusIdXQADNng2MRWg0=;
        b=lgbmM9c3l89XT8nbxv2+GkDsQ2GvxkYvkmvmI8v54ug72LjtcIgie1mmNponG81m+C
         sjjEAN0yI4zswWcEt5ZVspXtjqdhpwfsJ1x9XUdQRowFPRYexOSf1Duz0Y2iG8vZ+aMD
         WplkPXbVzj49UUUSqw4J3u/V0J/NNM0setrgRAR1FFu2F5NNLoSphWlvJUgVCh9mEG/8
         zIacjyIEJ1q5gLTtyog4uc6sTsqV3GZYagb29eYJbKKUF71khkKdbchNHoPqq9qPr7yP
         zpntUNBD5GphT62yn4Yb/bgNQwImjB/QF4cxM2f/PmkLsPdhHxlkom0CZDMCF9GBWUgD
         Mr5g==
X-Gm-Message-State: AOAM533h32Xi9b+ax0KszIrChrzEn81x66k3v/kbxHCwbkimagdCUA+h
        IBtS/YCy0KLoEkaBK2VU7RD7Owyr80Cr
X-Google-Smtp-Source: ABdhPJxPrujZoCKXu0Y0JWTKDXJbusKVULjrqEkfyGMlUiS7SCtxgy6kV+FIsrpHAX9hDYwMaqEW19T065RI
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:d977:cec1:ae4a:f50e])
 (user=joshdon job=sendgmr) by 2002:a05:6214:4a8:: with SMTP id
 w8mr3939270qvz.25.1628800312377; Thu, 12 Aug 2021 13:31:52 -0700 (PDT)
Date:   Thu, 12 Aug 2021 13:31:37 -0700
Message-Id: <20210812203137.2880834-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH] fs/proc/uptime.c: fix idle time reporting in /proc/uptime
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josh Don <joshdon@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

/proc/uptime reports idle time by reading the CPUTIME_IDLE field from
the per-cpu kcpustats. However, on NO_HZ systems, idle time is not
continually updated on idle cpus, leading this value to appear
incorrectly small.

/proc/stat performs an accounting update when reading idle time; we can
use the same approach for uptime.

With this patch, /proc/stat and /proc/uptime now agree on idle time.
Additionally, the following shows idle time tick up consistently on an
idle machine:
(while true; do cat /proc/uptime; sleep 1; done) | awk '{print $2-prev; prev=$2}'

Reported-by: Luigi Rizzo <lrizzo@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 fs/proc/stat.c              | 26 --------------------------
 fs/proc/uptime.c            | 13 ++++++++-----
 include/linux/kernel_stat.h |  1 +
 kernel/sched/cputime.c      | 28 ++++++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 6561a06ef905..99796a8a5223 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -24,16 +24,6 @@
 
 #ifdef arch_idle_time
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
-{
-	u64 idle;
-
-	idle = kcs->cpustat[CPUTIME_IDLE];
-	if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
-		idle += arch_idle_time(cpu);
-	return idle;
-}
-
 static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 iowait;
@@ -46,22 +36,6 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 
 #else
 
-static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
-{
-	u64 idle, idle_usecs = -1ULL;
-
-	if (cpu_online(cpu))
-		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
-
-	if (idle_usecs == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
-		idle = kcs->cpustat[CPUTIME_IDLE];
-	else
-		idle = idle_usecs * NSEC_PER_USEC;
-
-	return idle;
-}
-
 static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
 {
 	u64 iowait, iowait_usecs = -1ULL;
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index 5a1b228964fb..c900f354ef93 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -12,18 +12,21 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 {
 	struct timespec64 uptime;
 	struct timespec64 idle;
-	u64 nsec;
+	const struct kernel_cpustat *kcs;
+	u64 idle_nsec;
 	u32 rem;
 	int i;
 
-	nsec = 0;
-	for_each_possible_cpu(i)
-		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
+	idle_nsec = 0;
+	for_each_possible_cpu(i) {
+		kcs = &kcpustat_cpu(i);
+		idle_nsec += get_idle_time(kcs, i);
+	}
 
 	ktime_get_boottime_ts64(&uptime);
 	timens_add_boottime(&uptime);
 
-	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
+	idle.tv_sec = div_u64_rem(idle_nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
 			(unsigned long) uptime.tv_sec,
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 44ae1a7eb9e3..9a5f5c6239c7 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -102,6 +102,7 @@ extern void account_system_index_time(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
 extern void account_idle_time(u64);
+extern u64 get_idle_time(const struct kernel_cpustat *kcs, int cpu);
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 static inline void account_process_tick(struct task_struct *tsk, int user)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 872e481d5098..9d7629e21164 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -227,6 +227,34 @@ void account_idle_time(u64 cputime)
 		cpustat[CPUTIME_IDLE] += cputime;
 }
 
+/*
+ * Returns the total idle time for the given cpu.
+ * @kcs: The kernel_cpustat for the desired cpu.
+ * @cpu: The desired cpu.
+ */
+u64 get_idle_time(const struct kernel_cpustat *kcs, int cpu)
+{
+	u64 idle;
+	u64 __maybe_unused idle_usecs = -1ULL;
+
+#ifdef arch_idle_time
+	idle = kcs->cpustat[CPUTIME_IDLE];
+	if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
+		idle += arch_idle_time(cpu);
+#else
+	if (cpu_online(cpu))
+		idle_usecs = get_cpu_idle_time_us(cpu, NULL);
+
+	if (idle_usecs == -1ULL)
+		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
+		idle = kcs->cpustat[CPUTIME_IDLE];
+	else
+		idle = idle_usecs * NSEC_PER_USEC;
+#endif
+
+	return idle;
+}
+
 /*
  * When a guest is interrupted for a longer amount of time, missed clock
  * ticks are not redelivered later. Due to that, this function may on
-- 
2.33.0.rc1.237.g0d66db33f3-goog

