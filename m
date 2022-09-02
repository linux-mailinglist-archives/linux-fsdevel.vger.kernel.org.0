Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81B5AAC23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiIBKN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiIBKNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:13:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC933CAC64
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 03:12:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h188so1535078pgc.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Sep 2022 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3JVroPxTcJOCN2o2XA3WnSR5tC+xoLxrSL/gfmOhIRU=;
        b=zI95h6sekpVe20vXGieCyawXKPx9nvdc79NfYppL9QuorTJLM/PLN0qDTtMlbMCEJa
         AWjPyKL86CfWa3tXf9O7SstUJ5RCjn/5vLSbypHrjPuJmmOCQYP4de/6kxoh+HWcdP1U
         BTujz57FAzIJgnxNhYSU1v7mtjpckSRqaHJ6bDJ5Q0rwgZRQWMhOtGE+MmcdyKcGGUG0
         kZj5NxSfUM1srmRmOJq0jLgTdV9w2rxy+9JYVJupY1pRcDAyO+BXB1C55qN5lM/UZob2
         oXZoB/8Wx5b5T2plUiXahXUJopUpV0KIV/keIO6jIheBjzNUnr/n1gvraqEP8vXelTCI
         jpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3JVroPxTcJOCN2o2XA3WnSR5tC+xoLxrSL/gfmOhIRU=;
        b=J472zgUSdeNvUyT3Y7EW/GNnnD0YJyFgnehde5ptJZkfATNEQ7/EyRCg+bfghe4Fvd
         pfKaElMPvECM7n4L9U1alf7aPGpKS3pBZ3BKrb/sOnFGyE5x0hpl9mldalfIuF01ok7C
         iSM+TOAgyY5AWmUcTPUKDD38pEfDlpL9uoXsTeIc4xMklN+lVH7YhTjoc9fiODmItAoc
         mO0UirhlFYvUhAGJGFvWdqRLlaZ0g3LLBVWobsvTfiUB/w5z+gXKUxr0kI5F8AgqnC8U
         vpYjUZ6XU7YCye6V//qvaFU6Avs3rJIUhc5ms3xEWgesatcpt0LWT+mwCbHUW2x/Psww
         uupw==
X-Gm-Message-State: ACgBeo24lntHEPkmoqDbtMPMWAngnUlZEMjdaH3T/Gg8iwEW3iIgxsXo
        8OsiQnFGaH+TJFcjIq7KafAldA==
X-Google-Smtp-Source: AA6agR6yXjurVloXhqlHPjiqZgE2GPmuzrOFdXC1xZLpi2Bq07HI/s+8bJNdp87p95N8e2rk1sGUoA==
X-Received: by 2002:a63:564b:0:b0:42c:414a:95fd with SMTP id g11-20020a63564b000000b0042c414a95fdmr18641373pgm.5.1662113573395;
        Fri, 02 Sep 2022 03:12:53 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s7-20020a625e07000000b005381d037d07sm1300927pfb.217.2022.09.02.03.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:12:53 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     corbet@lwn.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
        mail@christoph.anton.mitterer.name, ccross@google.com,
        cuiyunhui@bytedance.com, vincent.whitchurch@axis.com,
        paul.gortmaker@windriver.com, peterz@infradead.org,
        edumazet@google.com, joshdon@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] bpf: added the account of BPF running time
Date:   Fri,  2 Sep 2022 18:12:17 +0800
Message-Id: <20220902101217.1419-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following high CPU usage problem is caused by BPF, We found it through
the perf tools.
Children Self 	SharedObject 	Symbol
45.52%	45.51%	[kernel]	[k] native_queued_spin_lock_slowpath
45.35%	0.10%	[kernel]	[k] _raw_spin_lock_irqsave
45.29%	0.01%	[kernel]	[k] bpf_map_update_elem
45.29%	0.02%	[kernel]	[k] htab_map_update_elem

The above problem is caught when bpf_prog is executed, but we cannot
get the load on the system from bpf_progs executed before, and we
cannot monitor the occupancy rate of cpu by BPF all the time.

Currently only the running time of a single bpf_prog is counted in the
/proc/$pid/fdinfo/$fd file. It's impossible to count the occupancy rate
of all bpf_progs on the CPU, because we can't know which processes, and
it is possible that the process has exited.

With the increasing use of BPF function modules, all running bpf_progs may
occupy high CPU usage. So we need to add an item to the /proc/stat file to
observe the CPU usage of BPF from a global perspective.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 Documentation/filesystems/proc.rst |  1 +
 fs/proc/stat.c                     | 25 +++++++++++++++++++++++--
 include/linux/filter.h             | 17 +++++++++++++++--
 kernel/bpf/core.c                  |  1 +
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e7aafc82be99..353f41c3e4eb 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1477,6 +1477,7 @@ second).  The meanings of the columns are as follows, from left to right:
 - steal: involuntary wait
 - guest: running a normal guest
 - guest_nice: running a niced guest
+- bpf: running in bpf_programs
 
 The "intr" line gives counts of interrupts  serviced since boot time, for each
 of the  possible system interrupts.   The first  column  is the  total of  all
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 4fb8729a68d4..ff8ef959fb4f 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -14,6 +14,8 @@
 #include <linux/irqnr.h>
 #include <linux/sched/cputime.h>
 #include <linux/tick.h>
+#include <linux/filter.h>
+#include <linux/u64_stats_sync.h>
 
 #ifndef arch_irq_stat_cpu
 #define arch_irq_stat_cpu(cpu) 0
@@ -22,6 +24,20 @@
 #define arch_irq_stat() 0
 #endif
 
+DECLARE_PER_CPU(struct bpf_account, bpftime);
+
+static void get_bpf_time(u64 *ns, int cpu)
+{
+	unsigned int start = 0;
+	const struct bpf_account *bact;
+
+	bact = per_cpu_ptr(&bpftime, cpu);
+	do {
+		start = u64_stats_fetch_begin_irq(&bact->syncp);
+		*ns = u64_stats_read(&bact->nsecs);
+	} while (u64_stats_fetch_retry_irq(&bact->syncp, start));
+}
+
 #ifdef arch_idle_time
 
 u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
@@ -112,11 +128,12 @@ static int show_stat(struct seq_file *p, void *v)
 	u64 guest, guest_nice;
 	u64 sum = 0;
 	u64 sum_softirq = 0;
+	u64 bpf_sum, bpf;
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec64 boottime;
 
 	user = nice = system = idle = iowait =
-		irq = softirq = steal = 0;
+		irq = softirq = steal = bpf = bpf_sum = 0;
 	guest = guest_nice = 0;
 	getboottime64(&boottime);
 	/* shift boot timestamp according to the timens offset */
@@ -127,6 +144,7 @@ static int show_stat(struct seq_file *p, void *v)
 		u64 *cpustat = kcpustat.cpustat;
 
 		kcpustat_cpu_fetch(&kcpustat, i);
+		get_bpf_time(&bpf, i);
 
 		user		+= cpustat[CPUTIME_USER];
 		nice		+= cpustat[CPUTIME_NICE];
@@ -138,6 +156,7 @@ static int show_stat(struct seq_file *p, void *v)
 		steal		+= cpustat[CPUTIME_STEAL];
 		guest		+= cpustat[CPUTIME_GUEST];
 		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
+		bpf_sum		+= bpf;
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
 
@@ -160,6 +179,7 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
 	seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
+	seq_put_decimal_ull(p, " ", nsec_to_clock_t(bpf_sum));
 	seq_putc(p, '\n');
 
 	for_each_online_cpu(i) {
@@ -167,7 +187,7 @@ static int show_stat(struct seq_file *p, void *v)
 		u64 *cpustat = kcpustat.cpustat;
 
 		kcpustat_cpu_fetch(&kcpustat, i);
-
+		get_bpf_time(&bpf, i);
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user		= cpustat[CPUTIME_USER];
 		nice		= cpustat[CPUTIME_NICE];
@@ -190,6 +210,7 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
+		seq_put_decimal_ull(p, " ", nsec_to_clock_t(bpf));
 		seq_putc(p, '\n');
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a5f21dc3c432..9cb072f9e32b 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -565,6 +565,12 @@ struct sk_filter {
 	struct bpf_prog	*prog;
 };
 
+struct bpf_account {
+	u64_stats_t nsecs;
+	struct u64_stats_sync syncp;
+};
+DECLARE_PER_CPU(struct bpf_account, bpftime);
+
 DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
 
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
@@ -577,12 +583,14 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  bpf_dispatcher_fn dfunc)
 {
 	u32 ret;
+	struct bpf_account *bact;
+	unsigned long flags;
+	u64 start = 0;
 
 	cant_migrate();
+	start = sched_clock();
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		struct bpf_prog_stats *stats;
-		u64 start = sched_clock();
-		unsigned long flags;
 
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
 		stats = this_cpu_ptr(prog->stats);
@@ -593,6 +601,11 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 	} else {
 		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
 	}
+	bact = this_cpu_ptr(&bpftime);
+	flags = u64_stats_update_begin_irqsave(&bact->syncp);
+	u64_stats_add(&bact->nsecs, sched_clock() - start);
+	u64_stats_update_end_irqrestore(&bact->syncp, flags);
+
 	return ret;
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c1e10d088dbb..445ac1c6c01a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -618,6 +618,7 @@ static const struct latch_tree_ops bpf_tree_ops = {
 	.comp	= bpf_tree_comp,
 };
 
+DEFINE_PER_CPU(struct bpf_account, bpftime);
 static DEFINE_SPINLOCK(bpf_lock);
 static LIST_HEAD(bpf_kallsyms);
 static struct latch_tree_root bpf_tree __cacheline_aligned;
-- 
2.20.1

