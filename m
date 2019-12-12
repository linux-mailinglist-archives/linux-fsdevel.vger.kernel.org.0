Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47AF11CA54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfLLKOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:14:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38562 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfLLKOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K6jZFAg3+p0myI/G02qDuSlT1qkjA4IZ0q8Ttj/RQVY=; b=ga+Evak3G5IkAduI0yvP2RS5z
        NzpaFvANNgvlv6NGFLsuNM/1H0kCLNGb8dK1VRlQPKvethOn1+KO3VeABT1XsfhYqt7wNr3P+/0MV
        2jzfJiYEtk5REBp01Muj4fS3+D+A4rVgeLiSKFAzUdejgBwblxQ9Og/3N4rwEo9zXw9EU3Hf/878z
        D+giTsqspKO/GGG41yoUOXwrGZyjJEfNXvxAywdP9+bqlfQsEwBiJZpFktUz532lsH83pzMnmvM1U
        tc5hwe65dyjwvzLR/0l1PvOkCbCg3bvo0sGDrwyX44JtC2bHwGtEYUdkXNZP+ybIcIg4DhUhqxBfS
        pENgyza3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifLUH-0007Cv-Vs; Thu, 12 Dec 2019 10:14:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85515300F29;
        Thu, 12 Dec 2019 11:13:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCCBD2012196F; Thu, 12 Dec 2019 11:14:24 +0100 (CET)
Date:   Thu, 12 Dec 2019 11:14:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4] sched/core: Preempt current task in favour of bound
 kthread
Message-ID: <20191212101424.GH2871@hirez.programming.kicks-ass.net>
References: <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
 <20191210172307.GD9139@linux.vnet.ibm.com>
 <20191211173829.GB21797@linux.vnet.ibm.com>
 <20191211224617.GE19256@dread.disaster.area>
 <20191212101031.GV2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212101031.GV2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:10:31AM +0100, Peter Zijlstra wrote:
> @@ -4156,13 +4159,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	if (delta_exec < sysctl_sched_min_granularity)
>  		return;
>  
> -	se = __pick_first_entity(cfs_rq);
> +	se = __pick_next_entity(cfs_rq, NULL);
>  	delta = curr->vruntime - se->vruntime;
>  
>  	if (delta < 0)
>  		return;

What I mean with the below comment is, when this isn't enough, try
something like:

	if (se == cfs_rq->next)
		ideal_runtime /= 2;

to make it yield sooner to 'next' buddies. Sadly, due to the whole
cgroup mess, we can't say what actual task is on the end of it (without
doing a full hierarchy pick, which is more expensive still).

> -	if (delta > ideal_runtime)
> +	if (delta > ideal_runtime) // maybe frob this too ?
>  		resched_curr(rq_of(cfs_rq));
>  }
