Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1441A34769E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 11:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhCXK4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 06:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhCXK4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:56:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5DBC061763;
        Wed, 24 Mar 2021 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fP3aEc3qJZvK1mSlymQf5f8BgQPUcAaTLL39osjfb70=; b=kDMMV7M+dCBA6F1GZiTcLrMZm7
        gE4/xqQ9esO6XrvZGNLTNb4EEL+0KIKg34eFZDzFUsrgjbhOafxqJulbAd3YPtZ4lg+Qpoe+AFiPJ
        KnIZvSTVFBchVNu/zsRXs+sQGvo9SKvwXkx0ZomtBh+MEw68S6wanECbBNI66n6lsl10KN+rf762S
        YGAJ89rpIdy9aGto7m/Dr39bBTmVp6zdsCc44w7+0ptsQA2MhpVb0BlinIfT54b2Y1YSLPz9MYa/q
        EDumI4YHdyAHJKjLiqoi/7KaCXElCPAkCWRJwcM9EhAB01fcyw4Y2On+OyCPAZ2DosfAKHuhZhY2f
        HE+Z1ROA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP19d-00BGEv-Rc; Wed, 24 Mar 2021 10:54:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8796F306099;
        Wed, 24 Mar 2021 11:54:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65AD928B290CC; Wed, 24 Mar 2021 11:54:24 +0100 (CET)
Date:   Wed, 24 Mar 2021 11:54:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
References: <20210323035706.572953-1-joshdon@google.com>
 <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 10:37:43AM +0100, Peter Zijlstra wrote:
> Should we perhaps take out all SCHED_DEBUG sysctls and move them to
> /debug/sched/ ? (along with the existing /debug/sched_{debug,features,preemp}
> files)
> 
> Having all that in sysctl and documented gives them far too much sheen
> of ABI.

... a little something like this ...

---
Subject: sched: Move SCHED_DEBUG to debugfs
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 24 11:43:21 CET 2021

Stop polluting sysctl with undocumented knobs that really are debug
only, move them all to /debug/sched/.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/sysctl.h |   12 ---
 kernel/sched/core.c          |   48 +-----------
 kernel/sched/debug.c         |  169 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/fair.c          |    9 --
 kernel/sysctl.c              |  116 -----------------------------
 5 files changed, 174 insertions(+), 180 deletions(-)

--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -26,10 +26,11 @@ int proc_dohung_task_timeout_secs(struct
 enum { sysctl_hung_task_timeout_secs = 0 };
 #endif
 
+extern unsigned int sysctl_sched_child_runs_first;
+
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
-extern unsigned int sysctl_sched_child_runs_first;
 
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
@@ -37,7 +38,7 @@ enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_LINEAR,
 	SCHED_TUNABLESCALING_END,
 };
-extern enum sched_tunable_scaling sysctl_sched_tunable_scaling;
+extern unsigned int sysctl_sched_tunable_scaling;
 
 extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
@@ -47,9 +48,6 @@ extern unsigned int sysctl_numa_balancin
 #ifdef CONFIG_SCHED_DEBUG
 extern __read_mostly unsigned int sysctl_sched_migration_cost;
 extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-
-int sched_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
 /*
@@ -87,10 +85,6 @@ int sched_rt_handler(struct ctl_table *t
 		size_t *lenp, loff_t *ppos);
 int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
-int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern unsigned int sysctl_sched_energy_aware;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3612,27 +3612,6 @@ void set_numabalancing_state(bool enable
 		static_branch_disable(&sched_numa_balancing);
 }
 
-#ifdef CONFIG_PROC_SYSCTL
-int sysctl_numa_balancing(struct ctl_table *table, int write,
-			  void *buffer, size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table t;
-	int err;
-	int state = static_branch_likely(&sched_numa_balancing);
-
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	t = *table;
-	t.data = &state;
-	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
-	if (err < 0)
-		return err;
-	if (write)
-		set_numabalancing_state(state);
-	return err;
-}
-#endif
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
@@ -3640,7 +3619,7 @@ int sysctl_numa_balancing(struct ctl_tab
 DEFINE_STATIC_KEY_FALSE(sched_schedstats);
 static bool __initdata __sched_schedstats = false;
 
-static void set_schedstats(bool enabled)
+void set_schedstats(bool enabled)
 {
 	if (enabled)
 		static_branch_enable(&sched_schedstats);
@@ -3687,27 +3666,6 @@ static void __init init_schedstats(void)
 	set_schedstats(__sched_schedstats);
 }
 
-#ifdef CONFIG_PROC_SYSCTL
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos)
-{
-	struct ctl_table t;
-	int err;
-	int state = static_branch_likely(&sched_schedstats);
-
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	t = *table;
-	t.data = &state;
-	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
-	if (err < 0)
-		return err;
-	if (write)
-		set_schedstats(state);
-	return err;
-}
-#endif /* CONFIG_PROC_SYSCTL */
 #else  /* !CONFIG_SCHEDSTATS */
 static inline void init_schedstats(void) {}
 #endif /* CONFIG_SCHEDSTATS */
@@ -5504,9 +5462,11 @@ static const struct file_operations sche
 	.release	= single_release,
 };
 
+extern struct dentry *debugfs_sched;
+
 static __init int sched_init_debug_dynamic(void)
 {
-	debugfs_create_file("sched_preempt", 0644, NULL, NULL, &sched_dynamic_fops);
+	debugfs_create_file("sched_preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 	return 0;
 }
 late_initcall(sched_init_debug_dynamic);
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -169,15 +169,176 @@ static const struct file_operations sche
 	.release	= single_release,
 };
 
+#ifdef CONFIG_SMP
+
+extern int sched_update_scaling(void);
+
+static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	if (kstrtouint(buf, 10, &sysctl_sched_tunable_scaling))
+		return -EINVAL;
+
+	if (sched_update_scaling())
+		return -EINVAL;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_scaling_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", sysctl_sched_tunable_scaling);
+	return 0;
+}
+
+static int sched_scaling_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_scaling_show, NULL);
+}
+
+static const struct file_operations sched_scaling_fops = {
+	.open		= sched_scaling_open,
+	.write		= sched_scaling_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#ifdef CONFIG_SCHEDSTATS
+
+extern void set_schedstats(bool enabled);
+
+static ssize_t sched_stats_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	bool enabled;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	if (kstrtobool(buf, &enabled))
+		return -EINVAL;
+
+	set_schedstats(enabled);
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_stats_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", static_key_enabled(&sched_schedstats));
+	return 0;
+}
+
+static int sched_stats_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_stats_show, NULL);
+}
+
+static const struct file_operations sched_stats_fops = {
+	.open		= sched_stats_open,
+	.write		= sched_stats_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif /* SCHEDSTATS */
+#endif /* SMP */
+
+#ifdef CONFIG_NUMA_BALANCING
+
+static ssize_t sched_numa_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	bool enabled;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	if (kstrtobool(buf, &enabled))
+		return -EINVAL;
+
+	set_numabalancing_state(enabled);
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_numa_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", static_key_enabled(&sched_numa_balancing));
+	return 0;
+}
+
+static int sched_numa_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_numa_show, NULL);
+}
+
+static const struct file_operations sched_numa_fops = {
+	.open		= sched_numa_open,
+	.write		= sched_numa_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+#endif
+
 __read_mostly bool sched_debug_enabled;
 
+struct dentry *debugfs_sched;
+
 static __init int sched_init_debug(void)
 {
-	debugfs_create_file("sched_features", 0644, NULL, NULL,
-			&sched_feat_fops);
+	struct dentry __maybe_unused *numa;
+
+	debugfs_sched = debugfs_create_dir("sched", NULL);
+
+	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
+	debugfs_create_bool("debug", 0644, debugfs_sched, &sched_debug_enabled);
+
+	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
+	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
+
+#ifdef CONFIG_SMP
+	debugfs_create_file("tunable_scaling", 0644, debugfs_sched, NULL, &sched_scaling_fops);
+	debugfs_create_u32("migration_cost_ns", 0644, debugfs_sched, &sysctl_sched_migration_cost);
+	debugfs_create_u32("nr_migrate", 0644, debugfs_sched, &sysctl_sched_nr_migrate);
+#ifdef CONFIG_SCHEDSTATS
+	debugfs_create_file("stats", 0644, debugfs_sched, NULL, &sched_stats_fops);
+#endif
+#endif
+
+#ifdef CONFIG_NUMA_BALANCING
+	numa = debugfs_create_dir("numa", debugfs_sched);
 
-	debugfs_create_bool("sched_debug", 0644, NULL,
-			&sched_debug_enabled);
+	debugfs_create_file("balancing", 0644, numa, NULL, &sched_numa_fops);
+	debugfs_create_u32("balancing_scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
+	debugfs_create_u32("balancing_scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
+	debugfs_create_u32("balancing_scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
+	debugfs_create_u32("balancing_scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+#endif
 
 	return 0;
 }
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -49,7 +49,7 @@ static unsigned int normalized_sysctl_sc
  *
  * (default SCHED_TUNABLESCALING_LOG = *(1+ilog(ncpus))
  */
-enum sched_tunable_scaling sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
+unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 
 /*
  * Minimal preemption granularity for CPU-bound tasks:
@@ -627,15 +627,10 @@ struct sched_entity *__pick_last_entity(
  * Scheduling class statistics methods:
  */
 
-int sched_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+int sched_update_scaling(void)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	unsigned int factor = get_update_sysctl_factor();
 
-	if (ret || !write)
-		return ret;
-
 	sched_nr_latency = DIV_ROUND_UP(sysctl_sched_latency,
 					sysctl_sched_min_granularity);
 
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -184,17 +184,6 @@ static enum sysctl_writes_mode sysctl_wr
 int sysctl_legacy_va_layout;
 #endif
 
-#ifdef CONFIG_SCHED_DEBUG
-static int min_sched_granularity_ns = 100000;		/* 100 usecs */
-static int max_sched_granularity_ns = NSEC_PER_SEC;	/* 1 second */
-static int min_wakeup_granularity_ns;			/* 0 usecs */
-static int max_wakeup_granularity_ns = NSEC_PER_SEC;	/* 1 second */
-#ifdef CONFIG_SMP
-static int min_sched_tunable_scaling = SCHED_TUNABLESCALING_NONE;
-static int max_sched_tunable_scaling = SCHED_TUNABLESCALING_END-1;
-#endif /* CONFIG_SMP */
-#endif /* CONFIG_SCHED_DEBUG */
-
 #ifdef CONFIG_COMPACTION
 static int min_extfrag_threshold;
 static int max_extfrag_threshold = 1000;
@@ -1659,111 +1648,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-#ifdef CONFIG_SCHED_DEBUG
-	{
-		.procname	= "sched_min_granularity_ns",
-		.data		= &sysctl_sched_min_granularity,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_granularity_ns,
-		.extra2		= &max_sched_granularity_ns,
-	},
-	{
-		.procname	= "sched_latency_ns",
-		.data		= &sysctl_sched_latency,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_granularity_ns,
-		.extra2		= &max_sched_granularity_ns,
-	},
-	{
-		.procname	= "sched_wakeup_granularity_ns",
-		.data		= &sysctl_sched_wakeup_granularity,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_wakeup_granularity_ns,
-		.extra2		= &max_wakeup_granularity_ns,
-	},
-#ifdef CONFIG_SMP
-	{
-		.procname	= "sched_tunable_scaling",
-		.data		= &sysctl_sched_tunable_scaling,
-		.maxlen		= sizeof(enum sched_tunable_scaling),
-		.mode		= 0644,
-		.proc_handler	= sched_proc_update_handler,
-		.extra1		= &min_sched_tunable_scaling,
-		.extra2		= &max_sched_tunable_scaling,
-	},
-	{
-		.procname	= "sched_migration_cost_ns",
-		.data		= &sysctl_sched_migration_cost,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "sched_nr_migrate",
-		.data		= &sysctl_sched_nr_migrate,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#ifdef CONFIG_SCHEDSTATS
-	{
-		.procname	= "sched_schedstats",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_schedstats,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SCHEDSTATS */
-#endif /* CONFIG_SMP */
-#ifdef CONFIG_NUMA_BALANCING
-	{
-		.procname	= "numa_balancing_scan_delay_ms",
-		.data		= &sysctl_numa_balancing_scan_delay,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_period_min_ms",
-		.data		= &sysctl_numa_balancing_scan_period_min,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_period_max_ms",
-		.data		= &sysctl_numa_balancing_scan_period_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "numa_balancing_scan_size_mb",
-		.data		= &sysctl_numa_balancing_scan_size,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "numa_balancing",
-		.data		= NULL, /* filled in by handler */
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_numa_balancing,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
 		.data		= &sysctl_sched_rt_period,
