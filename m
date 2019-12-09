Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E99F117B53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 00:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfLIXRw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 18:17:52 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:35499 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbfLIXRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:17:52 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9FDC93A1740;
        Tue, 10 Dec 2019 10:17:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ieSHf-000609-Or; Tue, 10 Dec 2019 10:17:43 +1100
Date:   Tue, 10 Dec 2019 10:17:43 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191209231743.GA19256@dread.disaster.area>
References: <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209165122.GA27229@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=-oRCy8-_WFT2JPw6eY8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 09, 2019 at 10:21:22PM +0530, Srikar Dronamraju wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44123b4d14e8..efd740aafa17 100644
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
> +	return try_to_wake_up(p, TASK_NORMAL, WF_KTHREAD);

This is buggy. It always sets WF_KTHREAD, even for non-kernel
processes. I think you meant:

	return try_to_wake_up(p, TASK_NORMAL, wake_flags);

I suspect this bug invalidates the test results presented, too...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
