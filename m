Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1154B347753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhCXL2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:28:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhCXL1o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:27:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2283DAD6D;
        Wed, 24 Mar 2021 11:27:43 +0000 (UTC)
Date:   Wed, 24 Mar 2021 11:27:39 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <20210324112739.GO15768@suse.de>
References: <20210323035706.572953-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210323035706.572953-1-joshdon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:57:06PM -0700, Josh Don wrote:
> From: Paul Turner <pjt@google.com>
> 
> CPU scheduler marks need_resched flag to signal a schedule() on a
> particular CPU. But, schedule() may not happen immediately in cases
> where the current task is executing in the kernel mode (no
> preemption state) for extended periods of time.
> 
> This patch adds a warn_on if need_resched is pending for more than the
> time specified in sysctl resched_latency_warn_ms. If it goes off, it is
> likely that there is a missing cond_resched() somewhere. Monitoring is
> done via the tick and the accuracy is hence limited to jiffy scale. This
> also means that we won't trigger the warning if the tick is disabled.
> 
> This feature is default disabled. It can be toggled on using sysctl
> resched_latency_warn_enabled.
> 
> Signed-off-by: Paul Turner <pjt@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
> Delta from v1:
> - separate sysctl for enabling/disabling and triggering warn_once
>   behavior
> - add documentation
> - static branch for the enable
>  Documentation/admin-guide/sysctl/kernel.rst | 23 ++++++
>  include/linux/sched/sysctl.h                |  4 ++
>  kernel/sched/core.c                         | 78 ++++++++++++++++++++-
>  kernel/sched/debug.c                        | 10 +++
>  kernel/sched/sched.h                        | 10 +++
>  kernel/sysctl.c                             | 24 +++++++
>  6 files changed, 148 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 1d56a6b73a4e..2d4a21d3b79f 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1077,6 +1077,29 @@ ROM/Flash boot loader. Maybe to tell it what to do after
>  rebooting. ???
>  
>  
> +resched_latency_warn_enabled
> +============================
> +
> +Enables/disables a warning that will trigger if need_resched is set for
> +longer than sysctl ``resched_latency_warn_ms``. This warning likely
> +indicates a kernel bug, such as a failure to call cond_resched().
> +
> +Requires ``CONFIG_SCHED_DEBUG``.
> +

I'm not a fan of the name. I know other sysctls have _enabled in the
name but it's redundant. If you say the name out loud, it sounds weird.
I would suggest an alternative but see below.

> +
> +resched_latency_warn_ms
> +=======================
> +
> +See ``resched_latency_warn_enabled``.
> +
> +
> +resched_latency_warn_once
> +=========================
> +
> +If set, ``resched_latency_warn_enabled`` will only trigger one warning
> +per boot.
> +

I suggest semantics and naming similar to hung_task_warnings
because it's sortof similar. resched_latency_warnings would combine
resched_latency_warn_enabled and resched_latency_warn_once. 0 would mean
"never warn", -1 would mean always warn and any positive value means
"warn X number of times".

Internally, you could still use the static label
resched_latency_warn_enabled, it would simply be false if
resched_latency_warnings == 0.

Obviously though sysctl_resched_latency_warn_once would need to change.

> +
>  sched_energy_aware
>  ==================
>  
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 3c31ba88aca5..43a1f5ab819a 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -48,6 +48,10 @@ extern unsigned int sysctl_numa_balancing_scan_size;
>  extern __read_mostly unsigned int sysctl_sched_migration_cost;
>  extern __read_mostly unsigned int sysctl_sched_nr_migrate;
>  
> +extern struct static_key_false resched_latency_warn_enabled;
> +extern int sysctl_resched_latency_warn_ms;
> +extern int sysctl_resched_latency_warn_once;
> +
>  int sched_proc_update_handler(struct ctl_table *table, int write,
>  		void *buffer, size_t *length, loff_t *ppos);
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 98191218d891..d69ae342b450 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -58,7 +58,21 @@ const_debug unsigned int sysctl_sched_features =
>  #include "features.h"
>  	0;
>  #undef SCHED_FEAT
> -#endif
> +
> +/*
> + * Print a warning if need_resched is set for the given duration (if
> + * resched_latency_warn_enabled is set).
> + *
> + * If sysctl_resched_latency_warn_once is set, only one warning will be shown
> + * per boot.
> + *
> + * Resched latency will be ignored for the first resched_boot_quiet_sec, to
> + * reduce false alarms.
> + */
> +int sysctl_resched_latency_warn_ms = 100;
> +int sysctl_resched_latency_warn_once = 1;

Use __read_mostly

> +const long resched_boot_quiet_sec = 600;

This seems arbitrary but could also be a #define. More on this later

> +#endif /* CONFIG_SCHED_DEBUG */
>  


>  /*
>   * Number of tasks to iterate in a single balance run.
> @@ -4520,6 +4534,58 @@ unsigned long long task_sched_runtime(struct task_struct *p)
>  	return ns;
>  }
>  
> +#ifdef CONFIG_SCHED_DEBUG
> +static u64 resched_latency_check(struct rq *rq)
> +{
> +	int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
> +	u64 need_resched_latency, now = rq_clock(rq);
> +	static bool warned_once;
> +
> +	if (sysctl_resched_latency_warn_once && warned_once)
> +		return 0;
> +

That is a global variable that can be modified in parallel and I do not
think it's properly locked (scheduler_tick is holding rq lock which does
not protect this).

Consider making resched_latency_warnings atomic and use
atomic_dec_if_positive. If it drops to zero in this path, disable the
static branch.

That said, it may be overkill. hung_task_warnings does not appear to have
special protection that prevents it going to -1 or lower values by accident
either. Maybe it can afford to be a bit more relaxed because a system that
is spamming hung task warnings is probably dead or might as well be dead.

> +	if (!need_resched() || WARN_ON_ONCE(latency_warn_ms < 2))
> +		return 0;
> +

Why is 1ms special? Regardless of the answer, if the sysctl should not
be 1 then the user should not be able to set it to 1.

> +	/* Disable this warning for the first few mins after boot */
> +	if (now < resched_boot_quiet_sec * NSEC_PER_SEC)
> +		return 0;
> +

Check system_state == SYSTEM_BOOTING instead?

> +	if (!rq->last_seen_need_resched_ns) {
> +		rq->last_seen_need_resched_ns = now;
> +		rq->ticks_without_resched = 0;
> +		return 0;
> +	}
> +
> +	rq->ticks_without_resched++;
> +	need_resched_latency = now - rq->last_seen_need_resched_ns;
> +	if (need_resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
> +		return 0;
> +

The naming need_resched_latency implies it's a boolean but it's not.
Maybe just resched_latency?

Similarly, resched_latency_check implies it returns a boolean but it
returns an excessive latency value. At this point I've been reading the
patch for a long time so I've ran out of naming suggestions :)

> +	warned_once = true;
> +
> +	return need_resched_latency;
> +}
> +

I note that you split when a warning is needed and printing the warning
but it's not clear why. Sure you are under the RQ lock but there are other
places that warn under the RQ lock. I suppose for consistency it could
use SCHED_WARN_ON even though all this code is under SCHED_DEBUG already.

> +static int __init setup_resched_latency_warn_ms(char *str)
> +{
> +	long val;
> +
> +	if ((kstrtol(str, 0, &val))) {
> +		pr_warn("Unable to set resched_latency_warn_ms\n");
> +		return 1;
> +	}
> +
> +	sysctl_resched_latency_warn_ms = val;
> +	return 1;
> +}
> +__setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
> +#else
> +static inline u64 resched_latency_check(struct rq *rq) { return 0; }
> +#endif /* CONFIG_SCHED_DEBUG */
> +
> +DEFINE_STATIC_KEY_FALSE(resched_latency_warn_enabled);
> +
>  /*
>   * This function gets called by the timer code, with HZ frequency.
>   * We call it with interrupts disabled.
> @@ -4531,6 +4597,7 @@ void scheduler_tick(void)
>  	struct task_struct *curr = rq->curr;
>  	struct rq_flags rf;
>  	unsigned long thermal_pressure;
> +	u64 resched_latency = 0;
>  
>  	arch_scale_freq_tick();
>  	sched_clock_tick();
> @@ -4541,11 +4608,17 @@ void scheduler_tick(void)
>  	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
>  	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
>  	curr->sched_class->task_tick(rq, curr, 0);
> +	if (static_branch_unlikely(&resched_latency_warn_enabled))
> +		resched_latency = resched_latency_check(rq);
>  	calc_global_load_tick(rq);
>  	psi_task_tick(rq);
>  
>  	rq_unlock(rq, &rf);
>  
> +	if (static_branch_unlikely(&resched_latency_warn_enabled) &&
> +	    resched_latency)
> +		resched_latency_warn(cpu, resched_latency);
> +
>  	perf_event_task_tick();
>  

I don't see the need to split latency detection with the display of the
warning. As resched_latency_check is static with a single caller, it should
be inlined so you can move all the logic, including the static branch
check there. Maybe to be on the safe side, explicitly mark it inline.

That allows you to delete resched_latency_warn and avoid advertising it
through sched.h

-- 
Mel Gorman
SUSE Labs
