Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2622C1DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgGXJQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 05:16:29 -0400
Received: from foss.arm.com ([217.140.110.172]:58284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgGXJQ3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 942FCD6E;
        Fri, 24 Jul 2020 02:16:28 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 298433F66E;
        Fri, 24 Jul 2020 02:16:26 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:16:23 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Doug Anderson <dianders@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200724091623.juqepztp5xtqgzrr@e107158-lin.cambridge.arm.com>
References: <20200716110347.19553-1-qais.yousef@arm.com>
 <20200716110347.19553-2-qais.yousef@arm.com>
 <20200724085405.GW10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724085405.GW10769@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/24/20 10:54, Peter Zijlstra wrote:
> On Thu, Jul 16, 2020 at 12:03:45PM +0100, Qais Yousef wrote:
> 
> Would you mind terribly if I rename things like so?

Nope, the new name is good for me too.

> 
> I tried and failed to come up with a shorter name in general, these
> functions names are somewhat unwieldy. I considered s/_default//.

Can do. Me thinking that maybe we need to sprinkle more comments then. But if
I felt the need for more comments, I can always post another patch on top :-)

If you'd like a shorter name, a slightly shorter one would be

	update_uclamp_min_rt()

Thanks

--
Qais Yousef

> 
> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -914,7 +914,7 @@ unsigned int uclamp_rq_max_value(struct
>  	return uclamp_idle_value(rq, clamp_id, clamp_value);
>  }
>  
> -static void __uclamp_sync_util_min_rt_default_locked(struct task_struct *p)
> +static void __uclamp_update_util_min_rt_default(struct task_struct *p)
>  {
>  	unsigned int default_util_min;
>  	struct uclamp_se *uc_se;
> @@ -931,7 +931,7 @@ static void __uclamp_sync_util_min_rt_de
>  	uclamp_se_set(uc_se, default_util_min, false);
>  }
>  
> -static void __uclamp_sync_util_min_rt_default(struct task_struct *p)
> +static void uclamp_update_util_min_rt_default(struct task_struct *p)
>  {
>  	struct rq_flags rf;
>  	struct rq *rq;
> @@ -941,7 +941,7 @@ static void __uclamp_sync_util_min_rt_de
>  
>  	/* Protect updates to p->uclamp_* */
>  	rq = task_rq_lock(p, &rf);
> -	__uclamp_sync_util_min_rt_default_locked(p);
> +	__uclamp_update_util_min_rt_default(p);
>  	task_rq_unlock(rq, p, &rf);
>  }
>  
> @@ -968,7 +968,7 @@ static void uclamp_sync_util_min_rt_defa
>  
>  	rcu_read_lock();
>  	for_each_process_thread(g, p)
> -		__uclamp_sync_util_min_rt_default(p);
> +		uclamp_update_util_min_rt_default(p);
>  	rcu_read_unlock();
>  }
>  
> @@ -1360,7 +1360,7 @@ static void __setscheduler_uclamp(struct
>  		 * at runtime.
>  		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			__uclamp_sync_util_min_rt_default_locked(p);
> +			__uclamp_update_util_min_rt_default(p);
>  		else
>  			uclamp_se_set(uc_se, uclamp_none(clamp_id), false);
>  
> @@ -1404,7 +1404,7 @@ static void uclamp_fork(struct task_stru
>  
>  static void uclamp_post_fork(struct task_struct *p)
>  {
> -	__uclamp_sync_util_min_rt_default(p);
> +	uclamp_update_util_min_rt_default(p);
>  }
>  
>  static void __init init_uclamp_rq(struct rq *rq)
