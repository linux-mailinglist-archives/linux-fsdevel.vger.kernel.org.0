Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCCE1F19A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgFHNGZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 09:06:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgFHNGY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:06:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9C231B;
        Mon,  8 Jun 2020 06:06:23 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A25B73F52E;
        Mon,  8 Jun 2020 06:06:20 -0700 (PDT)
References: <20200528132327.GB706460@hirez.programming.kicks-ass.net> <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com> <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200529100806.GA3070@suse.de> <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com> <87v9k84knx.derkling@matbug.net> <20200603101022.GG3070@suse.de> <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com> <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com> <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com> <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
In-reply-to: <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
Date:   Mon, 08 Jun 2020 14:06:13 +0100
Message-ID: <jhjzh9d3dx6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 08/06/20 13:31, Qais Yousef wrote:
> With uclamp enabled but no fair group I get
>
> *** uclamp enabled/fair group disabled ***
>
>       # Executed 50000 pipe operations between two threads
>            Total time: 0.856 [sec]
>
>            17.125740 usecs/op
>                58391 ops/sec
>
> The drop is 5.5% in ops/sec. Or 1 usecs/op.
>
> I don't know what's the expectation here. 1 us could be a lot, but I don't
> think we expect the new code to take more than few 100s of ns anyway. If you
> add potential caching effects, reaching 1 us wouldn't be that hard.
>

I don't think it's fair to look at the absolute delta. This being a very
hot path, cumulative overhead gets scary real quick. A drop of 5.5% work
done is a big hour lost over a full processing day.

> Note that in my runs I chose performance governor and use `taskset 0x2` to
> force running on a big core to make sure the runs are repeatable.
>
> On Juno-r2 I managed to scrap most of the 1 us with the below patch. It seems
> there was weird branching behavior that affects the I$ in my case. It'd be good
> to try it out to see if it makes a difference for you.
>
> The I$ effect is my best educated guess. Perf doesn't catch this path and
> I couldn't convince it to look at cache and branch misses between 2 specific
> points.
>
> Other subtle code shuffling did have weird effect on the result too. One worthy
> one is making uclamp_rq_dec() noinline gains back ~400 ns. Making
> uclamp_rq_inc() noinline *too* cancels this gain out :-/
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0464569f26a7..0835ee20a3c7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1071,13 +1071,11 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>
>  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>  {
> -	enum uclamp_id clamp_id;
> -
>       if (unlikely(!p->sched_class->uclamp_enabled))
>               return;
>
> -	for_each_clamp_id(clamp_id)
> -		uclamp_rq_inc_id(rq, p, clamp_id);
> +	uclamp_rq_inc_id(rq, p, UCLAMP_MIN);
> +	uclamp_rq_inc_id(rq, p, UCLAMP_MAX);
>
>       /* Reset clamp idle holding when there is one RUNNABLE task */
>       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> @@ -1086,13 +1084,11 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
>  {
> -	enum uclamp_id clamp_id;
> -
>       if (unlikely(!p->sched_class->uclamp_enabled))
>               return;
>
> -	for_each_clamp_id(clamp_id)
> -		uclamp_rq_dec_id(rq, p, clamp_id);
> +	uclamp_rq_dec_id(rq, p, UCLAMP_MIN);
> +	uclamp_rq_dec_id(rq, p, UCLAMP_MAX);
>  }
>

That's... Surprising. Did you look at the difference in generated code?

>  static inline void
>
>
> FWIW I fail to see activate/deactivate_task in perf record. They don't show up
> on the list which means this micro benchmark doesn't stress them as Mel's test
> does.
>

You're not going to see it them perf on the Juno. They're in IRQ
disabled sections, so AFAICT it won't get sampled as you don't have
NMIs. You can turn on ARM64_PSEUDO_NMI, but you'll need a GICv3 (Ampere
eMAG, Cavium ThunderX2).
