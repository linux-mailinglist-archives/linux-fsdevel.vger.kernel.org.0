Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27985EF0C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiI2Ipa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiI2Ip3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:45:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CAC52808;
        Thu, 29 Sep 2022 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xQdE/lPTJ2jBPVcsNpjFprsT4OeqEjkOkOH4rvRyf30=; b=frh80iUfjKRc38gJF+SKPbPSGP
        zV5Lm/FDZwYKF8We0s48A1H72pDczCFu5YFYDn2fK0w8DtmWrbX6qT0nRWf8CWTz7O7xkfwo6m5Tt
        oOoDLuOjdTQHA2uaTLRTIJDlRV+rDfeIc33/leIOZdh6yOAwGjk9f8CZjto7x00TbAEdWoeVW01GL
        4rjLk/TFz6C8OPIa6AhTaF7Ubutl5foH7RQL3Msq6kVF16v++Hwe2X4zcCaQ17O9aDzAqx8lCp3QR
        0s6m12uYx8FoQudNdXQBiKtigOqFJr9vCuRRRyQDAEt8+bJ2WiMmq0vnU4wcOeMF63clulgmDbsD3
        r9WP292A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odpAF-00GrD2-G3; Thu, 29 Sep 2022 08:45:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2EF330008D;
        Thu, 29 Sep 2022 10:45:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B422D203E4E80; Thu, 29 Sep 2022 10:45:01 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:45:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] sched/numa: add per-process numa_balancing
Message-ID: <YzVbDbLOYUVNnWRu@hirez.programming.kicks-ass.net>
References: <20220929064359.46932-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929064359.46932-1-ligang.bdlg@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The alternative to this is ofcourse to have your latency critical
applications use mbind()/set_mempolicy() etc.., because surely, them
being timing critical, they have the infrastructure to do this right?

Because timing critical software doesn't want it's memory spread
randomly, because well random is bad for performance, hmm?

And once numa balancing sees all the memory has an expliciy policy, it
won't touch it.

On Thu, Sep 29, 2022 at 02:43:58PM +0800, Gang Li wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ef0e6b3e08ff..87215b3776c9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2818,6 +2818,24 @@ void task_numa_free(struct task_struct *p, bool final)
>  	}
>  }
>  
> +inline bool numa_balancing_enabled(struct task_struct *p)

Does this want to be static?

> +{
> +	if (p->mm) {
> +		int numab = p->mm->numab_enabled;
> +
> +		switch (numab) {
> +		case NUMAB_ENABLED:
> +			return true;
> +		case NUMAB_DISABLED:
> +			return false;
> +		case NUMAB_DEFAULT:
> +			break;
> +		}
> +	}
> +
> +	return static_branch_unlikely(&sched_numa_balancing);
> +}

Blergh, this sucks. Now you have the unconditional pointer chasing and
cache-misses. The advantage of sched_numa_balancing was that there is no
overhead when disabled.

Also, "numab" is a weird word.

What about something like:

static inline bool numa_balancing_enabled(struct task_struct *p)
{
	if (!static_branch_unlikely(&sched_numa_balancing))
		return false;

	if (p->mm) switch (p->mm->numa_balancing_mode) {
	case NUMA_BALANCING_ENABLED:
		return true;
	case NUMA_BALANCING_DISABLED:
		return false
	default:
		break;
	}

	return sysctl_numa_balancing_mode;
}

( Note how that all following the existing 'numa_balancing' wording
  without inventing weird new words. )

And then you frob the sysctl and prctl such that sched_numa_balancing
and sysctl_numa_balancing_mode are not tied together just so.
Specifically, I'm thinking you should use static_branch_inc() to count
how many enables you have, one for the default and one for each prctl().
Then it all just works.

> @@ -11581,8 +11599,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  		entity_tick(cfs_rq, se, queued);
>  	}
>  
> -	if (static_branch_unlikely(&sched_numa_balancing))
> +#ifdef CONFIG_NUMA_BALANCING
> +	if (numa_balancing_enabled(curr))
>  		task_tick_numa(rq, curr);
> +#endif
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));

Surely you can make that #ifdef go away without much effort.

> diff --git a/kernel/sys.c b/kernel/sys.c
> index 8a6432465dc5..11720a35455a 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -59,6 +59,7 @@
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/sched/numa_balancing.h>
>  #include <linux/rcupdate.h>
>  #include <linux/uidgid.h>
>  #include <linux/cred.h>
> @@ -2101,6 +2102,23 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +static int prctl_pid_numa_balancing_write(int numa_balancing)
> +{
> +	if (numa_balancing != PR_SET_NUMAB_DEFAULT
> +	    && numa_balancing != PR_SET_NUMAB_DISABLED
> +	    && numa_balancing != PR_SET_NUMAB_ENABLED)
> +		return -EINVAL;

Operators go at the end of the line.

> +	current->mm->numab_enabled = numa_balancing;
> +	return 0;
> +}
