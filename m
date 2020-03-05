Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D18179E22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 04:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCEDL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 22:11:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCEDL0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 22:11:26 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF24520866;
        Thu,  5 Mar 2020 03:11:24 +0000 (UTC)
Date:   Wed, 4 Mar 2020 22:11:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xi Wang <xii@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Paul Turner <pjt@google.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
Message-ID: <20200304221123.7cef48d7@oasis.local.home>
In-Reply-To: <20200304213941.112303-1-xii@google.com>
References: <20200304213941.112303-1-xii@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed,  4 Mar 2020 13:39:41 -0800
Xi Wang <xii@google.com> wrote:

> The main purpose of kernel watchdog is to test whether scheduler can
> still schedule tasks on a cpu. In order to reduce latency from
> periodically invoking watchdog reset in thread context, we can simply
> touch watchdog from pick_next_task in scheduler. Compared to actually
> resetting watchdog from cpu stop / migration threads, we lose coverage
> on: a migration thread actually get picked and we actually context
> switch to the migration thread. Both steps are heavily protected by
> kernel locks and unlikely to silently fail. Thus the change would
> provide the same level of protection with less overhead.

Have any measurements showing the drop in overhead?

> 
> The new way vs the old way to touch the watchdogs is configurable
> from:
> 
> /proc/sys/kernel/watchdog_touch_in_thread_interval
> 
> The value means:
> 0: Always touch watchdog from pick_next_task
> 1: Always touch watchdog from migration thread
> N (N>0): Touch watchdog from migration thread once in every N
>          invocations, and touch watchdog from pick_next_task for
>          other invocations.
> 
> Suggested-by: Paul Turner <pjt@google.com>
> Signed-off-by: Xi Wang <xii@google.com>
> ---
>  kernel/sched/core.c | 36 ++++++++++++++++++++++++++++++++++--
>  kernel/sysctl.c     | 11 ++++++++++-
>  kernel/watchdog.c   | 39 ++++++++++++++++++++++++++++++++++-----
>  3 files changed, 78 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a9983da4408..9d8e00760d1c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3898,6 +3898,27 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>  	schedstat_inc(this_rq()->sched_count);
>  }
>  
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR
> +
> +DEFINE_PER_CPU(bool, sched_should_touch_watchdog);
> +
> +void touch_watchdog_from_sched(void);
> +
> +/* Helper called by watchdog code */
> +void resched_for_watchdog(void)
> +{
> +	unsigned long flags;
> +	struct rq *rq = this_rq();
> +
> +	this_cpu_write(sched_should_touch_watchdog, true);

Perhaps we should have a preempt_disable, otherwise it is possible
to get preempted here.

-- Steve

> +	raw_spin_lock_irqsave(&rq->lock, flags);
> +	/* Trigger resched for code in pick_next_task to touch watchdog */
> +	resched_curr(rq);
> +	raw_spin_unlock_irqrestore(&rq->lock, flags);
> +}
> +
> +#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
> +

