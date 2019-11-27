Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90E7310AD6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 11:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfK0KTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 05:19:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:43110 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbfK0KTk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:19:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F09BB209;
        Wed, 27 Nov 2019 10:19:36 +0000 (UTC)
Date:   Wed, 27 Nov 2019 10:19:32 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     ?????? <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal Koutn? <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] sched/numa: advanced per-cgroup numa statistic
Message-ID: <20191127101932.GN28938@suse.de>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 09:49:34AM +0800, ?????? wrote:
> Currently there are no good approach to monitoring the per-cgroup
> numa efficiency, this could be a trouble especially when groups
> are sharing CPUs, it's impossible to tell which one caused the
> remote-memory access by reading hardware counter since multiple
> workloads could sharing the same CPU, which make it painful when
> one want to find out the root cause and fix the issue.
> 

It's already possible to identify specific tasks triggering PMU events
so this is not exactly true.

> In order to address this, we introduced new per-cgroup statistic
> for numa:
>   * the numa locality to imply the numa balancing efficiency
>   * the numa execution time on each node
> 
> The task locality is the local page accessing ratio traced on numa
> balancing PF, and the group locality is the topology of task execution
> time, sectioned by the locality into 7 regions.
> 
> For example the new entry 'cpu.numa_stat' show:
>   locality 39541 60962 36842 72519 118605 721778 946553
>   exectime 1220127 1458684
> 
> Here we know the workloads in hierarchy executed 1220127ms on node_0
> and 1458684ms on node_1 in total, tasks with locality around 0~13%
> executed for 39541 ms, and tasks with locality around 86~100% executed
> for 946553 ms, which imply most of the memory access are local access.
> 
> By monitoring the new statistic, we will be able to know the numa
> efficiency of each per-cgroup workloads on machine, whatever they
> sharing the CPUs or not, we will be able to find out which one
> introduced the remote access mostly.
> 
> Besides, per-node memory topology from 'memory.numa_stat' become
> more useful when we have the per-node execution time, workloads
> always executing on node_0 while it's memory is all on node_1 is
> usually a bad case.
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  include/linux/sched.h        | 18 ++++++++-
>  include/linux/sched/sysctl.h |  6 +++
>  init/Kconfig                 |  9 +++++
>  kernel/sched/core.c          | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c          | 33 ++++++++++++++++
>  kernel/sched/sched.h         | 17 +++++++++
>  kernel/sysctl.c              | 11 ++++++
>  7 files changed, 184 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8f6607cd40ac..505b041594ef 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1118,9 +1118,25 @@ struct task_struct {
>  	 * numa_faults_locality tracks if faults recorded during the last
>  	 * scan window were remote/local or failed to migrate. The task scan
>  	 * period is adapted based on the locality of the faults with different
> -	 * weights depending on whether they were shared or private faults
> +	 * weights depending on whether they were shared or private faults.
> +	 *
> +	 * Counter id stand for:
> +	 * 0 -- remote faults
> +	 * 1 -- local faults
> +	 * 2 -- page migration failure
> +	 *
> +	 * Extra counters when CONFIG_CGROUP_NUMA_STAT enabled:
> +	 * 3 -- remote page accessing
> +	 * 4 -- local page accessing
> +	 *
> +	 * The 'remote/local faults' records the cpu-page relationship before
> +	 * page migration, while the 'remote/local page accessing' is after.
>  	 */
> +#ifndef CONFIG_CGROUP_NUMA_STAT
>  	unsigned long			numa_faults_locality[3];
> +#else
> +	unsigned long			numa_faults_locality[5];
> +#endif
> 
>  	unsigned long			numa_pages_migrated;
>  #endif /* CONFIG_NUMA_BALANCING */
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 89f55e914673..2d6a515df544 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -102,4 +102,10 @@ extern int sched_energy_aware_handler(struct ctl_table *table, int write,
>  				 loff_t *ppos);
>  #endif
> 
> +#ifdef CONFIG_CGROUP_NUMA_STAT
> +extern int sysctl_cg_numa_stat(struct ctl_table *table, int write,
> +				 void __user *buffer, size_t *lenp,
> +				 loff_t *ppos);
> +#endif
> +
>  #endif /* _LINUX_SCHED_SYSCTL_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 4d8d145c41d2..b31d2b560493 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -817,6 +817,15 @@ config NUMA_BALANCING_DEFAULT_ENABLED
>  	  If set, automatic NUMA balancing will be enabled if running on a NUMA
>  	  machine.
> 
> +config CGROUP_NUMA_STAT
> +	bool "Advanced per-cgroup NUMA statistics"
> +	default n
> +	depends on CGROUP_SCHED && NUMA_BALANCING
> +	help
> +	  This option adds support for per-cgroup NUMA locality/execution
> +	  statistics, for monitoring NUMA efficiency of per-cgroup workloads
> +	  on NUMA platforms with NUMA Balancing enabled.
> +
>  menuconfig CGROUPS
>  	bool "Control Group support"
>  	select KERNFS
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index aaa1740e6497..eabcab25be50 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7657,6 +7657,84 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  }
>  #endif /* CONFIG_RT_GROUP_SCHED */
> 
> +#ifdef CONFIG_CGROUP_NUMA_STAT
> +DEFINE_STATIC_KEY_FALSE(sched_cg_numa_stat);
> +
> +#ifdef CONFIG_PROC_SYSCTL
> +int sysctl_cg_numa_stat(struct ctl_table *table, int write,
> +			 void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ctl_table t;
> +	int err;
> +	int state = static_branch_likely(&sched_cg_numa_stat);
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
> +		static_branch_enable(&sched_cg_numa_stat);
> +	else
> +		static_branch_disable(&sched_cg_numa_stat);
> +
> +	return err;
> +}
> +#endif
> +

Why is this implemented as a toggle? I'm finding it hard to make sense
of this. The numa_stat should not even exist if the feature is disabled.

Assuming that is fixed then the runtime overhead is fine but the same
issues with the quality of the information relying on NUMA balancing
limits the usefulness of this. Disabling NUMA balancing or the scan rate
dropping to a very low frequency would lead in misleading conclusions as
well as false positives if the CPU and memory policies force remote memory
usage. Similarly, the timing of the information available is variable du
to how numa_faults_locality gets reset so sometimes the information is
fine-grained and sometimes it's coarse grained. It will also pretend to
display useful information even if NUMA balancing is disabled.

I find it hard to believe it would be useful in practice and I think users
would have real trouble interpreting the data given how much it relies on
internal implementation details of NUMA balancing. I cannot be certain
as clearly something motivated the creation of this patch although it's
unclear if it has ever been used to debug and fix an actual problem in
the field. Hence, I'm neutral on the patch and will neither ack or nack
it and will defer to the scheduler maintainers but if I was pushed on it,
I would be disinclined to merge the patch due to the potential confusion
caused by users who believe it provides accurate information when at best
it gives a rough approximation with variable granularity.

-- 
Mel Gorman
SUSE Labs
