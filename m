Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AD348C651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242913AbiALOoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbiALOoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:44:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD34DC06173F;
        Wed, 12 Jan 2022 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qlFlkECPRVUfbaXMoD/8vlzFEq0cbbwMCSchJ4LcKmA=; b=ETiOH3cX3l64g4+xs3cWHLUrdN
        7WR6s0Q0zlVj69t0YQ65pnGYn4EismXW1LBUlOOvnE31JkoIkXUv5M63Zyy4bapawDeqbgov6qqwK
        X45/FT76S+b9mdv8iiwlis1MZ8pMQeWw4Ku9VGsU9qKu9kao7NpElqX+qFDoLwn1QshZn/sdewSVI
        kl0pN1N86BrdV8X6dVgNvb7J4DmbHj5WCJuxwRBTbrBrmmaemjQMG2jIj5WMxdPkj8mc6mCUgjQAN
        EiUugVc26avg9zr1YZVanW80LAZGRExwd/Yq337LmHGZ7OY7c95K81iGaYey7WzRcKrst8+gdw02p
        wUopTTpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7eqz-000ocW-2C; Wed, 12 Jan 2022 14:43:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB48B3001CD;
        Wed, 12 Jan 2022 15:43:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 660E82006F92B; Wed, 12 Jan 2022 15:43:54 +0100 (CET)
Date:   Wed, 12 Jan 2022 15:43:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] sched/numa: add per-process numa_balancing
Message-ID: <Yd7pKuvjayH4q14L@hirez.programming.kicks-ass.net>
References: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206024530.11336-1-ligang.bdlg@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:45:28AM +0800, Gang Li wrote:
> This patch add a new api PR_NUMA_BALANCING in prctl.
> 
> A large number of page faults will cause performance loss when numa
> balancing is performing. Thus those processes which care about worst-case
> performance need numa balancing disabled. Others, on the contrary, allow a
> temporary performance loss in exchange for higher average performance, so
> enable numa balancing is better for them.
> 
> Numa balancing can only be controlled globally by
> /proc/sys/kernel/numa_balancing. Due to the above case, we want to
> disable/enable numa_balancing per-process instead.
> 
> Add numa_balancing under mm_struct. Then use it in task_tick_fair.
> 
> Set per-process numa balancing:
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DISABLE); //disable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_ENABLE);  //enable
> 	prctl(PR_NUMA_BALANCING, PR_SET_NUMAB_DEFAULT); //follow global

This seems to imply you can prctl(ENABLE) even if the global is
disabled, IOW sched_numa_balancing is off.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 884f29d07963..2980f33ac61f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11169,8 +11169,12 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  		entity_tick(cfs_rq, se, queued);
>  	}
>  
> -	if (static_branch_unlikely(&sched_numa_balancing))
> +#ifdef CONFIG_NUMA_BALANCING
> +	if (curr->mm && (curr->mm->numab_enabled == NUMAB_ENABLED
> +	    || (static_branch_unlikely(&sched_numa_balancing)
> +	    && curr->mm->numab_enabled == NUMAB_DEFAULT)))
>  		task_tick_numa(rq, curr);
> +#endif
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));

There's just about everything wrong there... not least of all the
horrific coding style.
