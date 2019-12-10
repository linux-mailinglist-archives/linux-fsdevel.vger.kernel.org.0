Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE911837A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfLJJ0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 04:26:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJ0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HnoPtgDyyEf84ZWb/qymyd1fNl04iBZY3/x7YWhBuy8=; b=du4OR0LwfqnYS24MzA+8qk22K
        ww7jdnZ7F5lymBuvVfjwdS4X/9q1flzgkvLLm0Qw1m/yMZ8RY93MaWAmixCw9xhyNHSq/uKjRLlJT
        PPuVM/mHsbLpkzniD0IAth0h+2hP0iulbN7HBZMPMeg/YxuMfw1w4dBPZe+lAc/eQKRV2afp8XYr2
        hT24hxLfBGdN9pq2oahlKlkcRYq9VKn7XgIAhESiiCBZdwF6wy7AH2NpbE1l6v3CcGliN3sXSluRS
        vHI0Ju0Elox8AjwmMO1rY7YwAlMTfmLMtx9EssBvX/YaTmFDLCoORALz3wQS6wOdX7yY9t1ILaKgN
        fwzpq7K1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iebmN-0002pk-NM; Tue, 10 Dec 2019 09:26:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7096300596;
        Tue, 10 Dec 2019 10:24:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E45D2010F142; Tue, 10 Dec 2019 10:26:01 +0100 (CET)
Date:   Tue, 10 Dec 2019 10:26:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Dave Chinner <david@fromorbit.com>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] sched/core: Preempt current task in favour of bound
 kthread
Message-ID: <20191210092601.GK2844@hirez.programming.kicks-ass.net>
References: <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210054330.GF27253@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:13:30AM +0530, Srikar Dronamraju wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44123b4d14e8..82126cbf62cd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2664,7 +2664,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   */
>  int wake_up_process(struct task_struct *p)
>  {
> -	return try_to_wake_up(p, TASK_NORMAL, 0);
> +	int wake_flags = 0;
> +
> +	if (is_per_cpu_kthread(p))
> +		wake_flags = WF_KTHREAD;
> +
> +	return try_to_wake_up(p, TASK_NORMAL, wake_flags);
>  }
>  EXPORT_SYMBOL(wake_up_process);

Why wake_up_process() and not try_to_wake_up() ? This way
wake_up_state(.state = TASK_NORMAL() is no longer the same as
wake_up_process(), and that's weird!

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a81a5709ff..36486f71e59f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6660,6 +6660,27 @@ static void set_skip_buddy(struct sched_entity *se)
>  		cfs_rq_of(se)->skip = se;
>  }
>  
> +static int kthread_wakeup_preempt(struct rq *rq, struct task_struct *p, int wake_flags)
> +{
> +	struct task_struct *curr = rq->curr;
> +	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
> +
> +	if (!(wake_flags & WF_KTHREAD))
> +		return 0;
> +
> +	if (p->nr_cpus_allowed != 1 || curr->nr_cpus_allowed == 1)
> +		return 0;

Per the above, WF_KTHREAD already implies p->nr_cpus_allowed == 1.

> +	if (cfs_rq->nr_running > 2)
> +		return 0;
> +
> +	/*
> +	 * Don't preempt, if the waking kthread is more CPU intensive than
> +	 * the current thread.
> +	 */
> +	return p->nvcsw * curr->nivcsw >= p->nivcsw * curr->nvcsw;

Both these conditions seem somewhat arbitrary. The number of context
switch does not correspond to CPU usage _at_all_.

vtime OTOH does reflect exactly that, if it runs a lot, it will be ahead
in the tree.

> +}
> +
>  /*
>   * Preempt the current task with a newly woken task if needed:
>   */
> @@ -6716,7 +6737,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>  	find_matching_se(&se, &pse);
>  	update_curr(cfs_rq_of(se));
>  	BUG_ON(!pse);
> -	if (wakeup_preempt_entity(se, pse) == 1) {
> +	if (wakeup_preempt_entity(se, pse) == 1 || kthread_wakeup_preempt(rq, p, wake_flags)) {
>  		/*
>  		 * Bias pick_next to pick the sched entity that is
>  		 * triggering this preemption.

How about something like:

	if (wakeup_preempt_entity(se, pse) >= 1-!!(wake_flags & WF_KTHREAD))

instead? Then we allow kthreads a little more preemption room.
