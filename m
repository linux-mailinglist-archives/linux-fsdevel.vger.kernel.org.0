Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A19915514B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgBGDhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:37:38 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43789 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGDhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:37:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TpJudFf_1581046646;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TpJudFf_1581046646)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Feb 2020 11:37:27 +0800
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
Message-ID: <00c2e7dc-8ac4-7daf-d589-5f64273e5057@linux.alibaba.com>
Date:   Fri, 7 Feb 2020 11:37:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Forwarded:

Hi, Peter, Ingo

Could you give some comments please?

As Mel replied previously, he won't disagree the idea, so we're looking
forward the opinion from the maintainers.

Please allow me to highlight the necessary of monitoring NUMA Balancing
again, this feature is critical to the performance on NUMA platform,
it cost and benefit -- lot or less, however there are not enough
information for an admin to analysis the trade-off, while locality could
be the missing piece.

Regards,
Michael Wang

On 2020/2/7 上午11:35, 王贇 wrote:
> Currently there are no good approach to monitoring the per-cgroup NUMA
> efficiency, this could be a trouble especially when groups are sharing
> CPUs, we don't know which one introduced remote-memory accessing.
> 
> Although the per-task NUMA accessing info from PMU is good for further
> debuging, but not light enough for daily monitoring, especial on a box
> with thousands of tasks.
> 
> Fortunately, when NUMA Balancing enabled, it will periodly trigger page
> fault and try to increase the NUMA locality, by tracing the results we
> will be able to estimate the NUMA efficiency.
> 
> On each page fault of NUMA Balancing, when task's executing CPU is from
> the same node of pages, we call this a local page accessing, otherwise
> a remote page accessing.
> 
> By updating task's accessing counter into it's cgroup on ticks, we get
> the per-cgroup numa locality info.
> 
> For example the new entry 'cpu.numa_stat' show:
>   page_access local=1231412 remote=53453
> 
> Here we know the workloads in hierarchy have totally been traced 1284865
> times of page accessing, and 1231412 of them are local page access, which
> imply a good NUMA efficiency.
> 
> By monitoring the increments, we will be able to locate the per-cgroup
> workload which NUMA Balancing can't helpwith (usually caused by wrong
> CPU and memory node bindings), then we got chance to fix that in time.
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  include/linux/sched.h        | 15 +++++++++
>  include/linux/sched/sysctl.h |  6 ++++
>  init/Kconfig                 |  9 ++++++
>  kernel/sched/core.c          | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c          | 62 ++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h         | 12 +++++++
>  kernel/sysctl.c              | 11 +++++++
>  7 files changed, 190 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a6c924fa1c77..74bf234bae53 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1128,6 +1128,21 @@ struct task_struct {
>  	unsigned long			numa_pages_migrated;
>  #endif /* CONFIG_NUMA_BALANCING */
> 
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +	/*
> +	 * Counter index stand for:
> +	 * 0 -- remote page accessing
> +	 * 1 -- local page accessing
> +	 * 2 -- remote page accessing updated to cgroup
> +	 * 3 -- local page accessing updated to cgroup
> +	 *
> +	 * We record the counter before the end of task_numa_fault(), this
> +	 * is based on the fact that after page fault is handled, the task
> +	 * will access the page on the CPU where it triggered the PF.
> +	 */
> +	unsigned long			numa_page_access[4];
> +#endif
> +
>  #ifdef CONFIG_RSEQ
>  	struct rseq __user *rseq;
>  	u32 rseq_sig;
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d4f6215ee03f..bb3721cf48e0 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -101,4 +101,10 @@ extern int sched_energy_aware_handler(struct ctl_table *table, int write,
>  				 loff_t *ppos);
>  #endif
> 
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +extern int sysctl_numa_locality(struct ctl_table *table, int write,
> +				 void __user *buffer, size_t *lenp,
> +				 loff_t *ppos);
> +#endif
> +
>  #endif /* _LINUX_SCHED_SYSCTL_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 322fd2c65304..63c6b90a515d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -813,6 +813,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>  	  machine.
> 
> +config CGROUP_NUMA_LOCALITY
> +	bool "per-cgroup NUMA Locality"
> +	default n
> +	depends on CGROUP_SCHED && NUMA_BALANCING
> +	help
> +	  This option enables the collection of per-cgroup NUMA locality info,
> +	  to tell whether NUMA Balancing is working well for a particular
> +	  workload, also imply the NUMA efficiency.
> +
>  menuconfig CGROUPS
>  	bool "Control Group support"
>  	select KERNFS
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e7b08d52db93..40dd6b221eef 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7657,6 +7657,68 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  }
>  #endif /* CONFIG_RT_GROUP_SCHED */
> 
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +DEFINE_STATIC_KEY_FALSE(sched_numa_locality);
> +
> +#ifdef CONFIG_PROC_SYSCTL
> +int sysctl_numa_locality(struct ctl_table *table, int write,
> +			 void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ctl_table t;
> +	int err;
> +	int state = static_branch_likely(&sched_numa_locality);
> +
> +	if (write && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	t = *table;
> +	t.data = &state;
> +	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
> +	if (err < 0 || !write)
> +		return err;
> +
> +	if (state)
> +		static_branch_enable(&sched_numa_locality);
> +	else
> +		static_branch_disable(&sched_numa_locality);
> +
> +	return err;
> +}
> +#endif
> +
> +static inline struct cfs_rq *tg_cfs_rq(struct task_group *tg, int cpu)
> +{
> +	return tg == &root_task_group ? &cpu_rq(cpu)->cfs : tg->cfs_rq[cpu];
> +}
> +
> +static int cpu_numa_stat_show(struct seq_file *sf, void *v)
> +{
> +	int cpu;
> +	u64 local = 0, remote = 0;
> +	struct task_group *tg = css_tg(seq_css(sf));
> +
> +	if (!static_branch_likely(&sched_numa_locality))
> +		return 0;
> +
> +	for_each_possible_cpu(cpu) {
> +		local += tg_cfs_rq(tg, cpu)->local_page_access;
> +		remote += tg_cfs_rq(tg, cpu)->remote_page_access;
> +	}
> +
> +	seq_printf(sf, "page_access local=%llu remote=%llu\n", local, remote);
> +
> +	return 0;
> +}
> +
> +static __init int numa_locality_setup(char *opt)
> +{
> +	static_branch_enable(&sched_numa_locality);
> +
> +	return 0;
> +}
> +__setup("numa_locality", numa_locality_setup);
> +#endif
> +
>  static struct cftype cpu_legacy_files[] = {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	{
> @@ -7706,6 +7768,12 @@ static struct cftype cpu_legacy_files[] = {
>  		.seq_show = cpu_uclamp_max_show,
>  		.write = cpu_uclamp_max_write,
>  	},
> +#endif
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +	{
> +		.name = "numa_stat",
> +		.seq_show = cpu_numa_stat_show,
> +	},
>  #endif
>  	{ }	/* Terminate */
>  };
> @@ -7887,6 +7955,13 @@ static struct cftype cpu_files[] = {
>  		.seq_show = cpu_uclamp_max_show,
>  		.write = cpu_uclamp_max_write,
>  	},
> +#endif
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +	{
> +		.name = "numa_stat",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = cpu_numa_stat_show,
> +	},
>  #endif
>  	{ }	/* terminate */
>  };
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2d170b5da0e3..eb838557bae2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1049,7 +1049,63 @@ update_stats_curr_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
>   * Scheduling class queueing methods:
>   */
> 
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +/*
> + * We want to record the real local/remote page access statistic
> + * here, so 'pnid' should be pages's real residential node after
> + * migrate_misplaced_page(), and 'cnid' should be the node of CPU
> + * where triggered the PF.
> + */
> +static inline void
> +update_task_locality(struct task_struct *p, int pnid, int cnid, int pages)
> +{
> +	if (!static_branch_unlikely(&sched_numa_locality))
> +		return;
> +
> +	/*
> +	 * pnid != cnid --> remote idx 0
> +	 * pnid == cnid --> local idx 1
> +	 */
> +	p->numa_page_access[!!(pnid == cnid)] += pages;
> +}
> +
> +static inline void update_group_locality(struct cfs_rq *cfs_rq)
> +{
> +	unsigned long ldiff, rdiff;
> +
> +	if (!static_branch_unlikely(&sched_numa_locality))
> +		return;
> +
> +	rdiff = current->numa_page_access[0] - current->numa_page_access[2];
> +	ldiff = current->numa_page_access[1] - current->numa_page_access[3];
> +	if (!ldiff && !rdiff)
> +		return;
> +
> +	cfs_rq->local_page_access += ldiff;
> +	cfs_rq->remote_page_access += rdiff;
> +
> +	/*
> +	 * Consider updated when reach root cfs_rq, no NUMA Balancing PF
> +	 * should happen on current task during the hierarchical updating.
> +	 */
> +	if (&cfs_rq->rq->cfs == cfs_rq) {
> +		current->numa_page_access[2] = current->numa_page_access[0];
> +		current->numa_page_access[3] = current->numa_page_access[1];
> +	}
> +}
> +#else
> +static inline void
> +update_task_locality(struct task_struct *p, int pnid, int cnid, int pages)
> +{
> +}
> +
> +static inline void update_group_locality(struct cfs_rq *cfs_rq)
> +{
> +}
> +#endif /* CONFIG_CGROUP_NUMA_LOCALITY */
> +
>  #ifdef CONFIG_NUMA_BALANCING
> +
>  /*
>   * Approximate time to scan a full NUMA task in ms. The task scan period is
>   * calculated based on the tasks virtual memory size and
> @@ -2465,6 +2521,8 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
>  	p->numa_faults[task_faults_idx(NUMA_MEMBUF, mem_node, priv)] += pages;
>  	p->numa_faults[task_faults_idx(NUMA_CPUBUF, cpu_node, priv)] += pages;
>  	p->numa_faults_locality[local] += pages;
> +
> +	update_task_locality(p, mem_node, numa_node_id(), pages);
>  }
> 
>  static void reset_ptenuma_scan(struct task_struct *p)
> @@ -2650,6 +2708,9 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
>  	p->last_sum_exec_runtime	= 0;
> 
>  	init_task_work(&p->numa_work, task_numa_work);
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +	memset(p->numa_page_access, 0, sizeof(p->numa_page_access));
> +#endif
> 
>  	/* New address space, reset the preferred nid */
>  	if (!(clone_flags & CLONE_VM)) {
> @@ -4313,6 +4374,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  	 */
>  	update_load_avg(cfs_rq, curr, UPDATE_TG);
>  	update_cfs_group(curr);
> +	update_group_locality(cfs_rq);
> 
>  #ifdef CONFIG_SCHED_HRTICK
>  	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1a88dc8ad11b..66b4e581b6ed 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -575,6 +575,14 @@ struct cfs_rq {
>  	struct list_head	throttled_list;
>  #endif /* CONFIG_CFS_BANDWIDTH */
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +	/*
> +	 * The local/remote page access info collected from all
> +	 * the tasks in hierarchy.
> +	 */
> +	u64			local_page_access;
> +	u64			remote_page_access;
> +#endif
>  };
> 
>  static inline int rt_bandwidth_enabled(void)
> @@ -1601,6 +1609,10 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>  extern struct static_key_false sched_numa_balancing;
>  extern struct static_key_false sched_schedstats;
> 
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +extern struct static_key_false sched_numa_locality;
> +#endif
> +
>  static inline u64 global_rt_period(void)
>  {
>  	return (u64)sysctl_sched_rt_period * NSEC_PER_USEC;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index d396aaaf19a3..a8f5951f92b3 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -428,6 +428,17 @@ static struct ctl_table kern_table[] = {
>  		.extra2		= SYSCTL_ONE,
>  	},
>  #endif /* CONFIG_NUMA_BALANCING */
> +#ifdef CONFIG_CGROUP_NUMA_LOCALITY
> +	{
> +		.procname	= "numa_locality",
> +		.data		= NULL, /* filled in by handler */
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= sysctl_numa_locality,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +#endif /* CONFIG_CGROUP_NUMA_LOCALITY */
>  #endif /* CONFIG_SCHED_DEBUG */
>  	{
>  		.procname	= "sched_rt_period_us",
> 
