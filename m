Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484F41EF28A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgFEHzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 03:55:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36295 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFEHzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:55:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id q13so6724741edi.3;
        Fri, 05 Jun 2020 00:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=eTH1N7IkZRLD3Bqd3SU/Y/GzgXBHOouBSsmg2M4E14k=;
        b=cVYjliO1PEz3vD/xjOII6DkG5XejgGkk17NgO4OakvIKZRxc2+sHF637PkCrXYz7ri
         9ss8qGqg1PQn7Ej9MUrxnWUGqduI6TNS4TrAoJ8mgEPdKnGJQ5v1qezJePDDe4collKv
         c7RukORKqLHfgNZon+VhK2PD0YygZpV6dtE/3MRyJoqh17s+6WqiUD8p6SIQ62KH2doE
         Q17nny8g/xixwf9o59fONmHADLpTVS+B7+jOy+/9i5cUhNm0k2br+eRQtDZz7uONXRh9
         yzzjZ18PHw6jYyVSPFSHhz1iCuZWP5azWqjhFft1r9Y31JoDHUI7+xi4JC00G7S8TmCJ
         D9pw==
X-Gm-Message-State: AOAM530ahXTCWq9r1+Hj4Hswg3P50XV/Vhg9L2nJ2b4uMbWd2jDpz+G0
        3P0bBiA3ToABDOc9AIbd12hteAXdOkQ=
X-Google-Smtp-Source: ABdhPJxL/AmKiDUSdx1nEvMhreC0ntJaev0XcTQZyJQ2wc0NY9Va3KeHu0Dts89OqK8Sc6iuhNnghg==
X-Received: by 2002:a05:6402:1434:: with SMTP id c20mr7787100edx.27.1591343745210;
        Fri, 05 Jun 2020 00:55:45 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:6574:5ece:b8f6:310e])
        by smtp.gmail.com with ESMTPSA id x7sm3692196ejc.58.2020.06.05.00.55.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jun 2020 00:55:43 -0700 (PDT)
References: <20200511154053.7822-1-qais.yousef@arm.com> <20200528132327.GB706460@hirez.programming.kicks-ass.net> <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com> <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200529100806.GA3070@suse.de> <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com> <87v9k84knx.derkling@matbug.net> <20200603101022.GG3070@suse.de> <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com> <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
User-agent: mu4e 1.4.3; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
In-reply-to: <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
Message-ID: <875zc60ww2.derkling@matbug.net>
Date:   Fri, 05 Jun 2020 09:55:41 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Qais,

On Wed, Jun 03, 2020 at 18:52:00 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

> On 06/03/20 16:59, Vincent Guittot wrote:
>> When I want to stress the fast path i usually use "perf bench sched pipe -T "
>> The tip/sched/core on my arm octo core gives the following results for
>> 20 iterations of perf bench sched pipe -T -l 50000
>> 
>> all uclamp config disabled  50035.4(+/- 0.334%)
>> all uclamp config enabled  48749.8(+/- 0.339%)   -2.64%

I use to run the same test but I don't remember such big numbers :/

>> It's quite easy to reproduce and probably easier to study the impact
>
> Thanks Vincent. This is very useful!
>
> I could reproduce that on my Juno.
>
> One of the codepath I was suspecting seems to affect it.
>
>
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0464569f26a7..9f48090eb926 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1063,10 +1063,12 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>          * e.g. due to future modification, warn and fixup the expected value.
>          */
>         SCHED_WARN_ON(bucket->value > rq_clamp);
> +#if 0
>         if (bucket->value >= rq_clamp) {
>                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
>                 WRITE_ONCE(uc_rq->value, bkt_clamp);
>         }
> +#endif

Yep, that's likely where we have most of the overhead at dequeue time,
sine _sometimes_ we need to update the cpu's clamp value.

However, while running perf sched pipe, I expect:
 - all tasks to have the same clamp value
 - all CPUs to have _always_ at least one RUNNABLE task

Given these two conditions above, if the CPU is never "CFS idle" (i.e.
without RUNNABLE CFS tasks), the code above should never be triggered.
More on that later...

>  }
>
>  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>
>
>
> uclamp_rq_max_value() could be expensive as it loops over all buckets.

It loops over UCLAMP_CNT values which are defined to fit into a single
$L. That was the optimal space/time complexity compromise we found to
get the MAX of a set of values.

> Commenting this whole path out strangely doesn't just 'fix' it,
> but produces  better results to no-uclamp kernel :-/
>
> # ./perf bench -r 20 sched pipe -T -l 50000
> Without uclamp:		5039
> With uclamp:		4832
> With uclamp+patch:	5729

I explain it below: with that code removed you never decrease the CPU's
uclamp value. Thus, the first time you schedule an RT task you go to MAX
OPP and stay there forever.

> It might be because schedutil gets biased differently by uclamp..? If I move to
> performance governor these numbers almost double.
>
> I don't know. But this promoted me to look closer and

Just to resume, when a task is dequeued we can have only these cases:

- uclamp(task) < uclamp(cpu):
  this happens when the task was co-scheduled with other tasks with
  higher clamp values which are still RUNNABLE.
  In this case there are no uclamp(cpu) updates.

- uclamp(task) == uclamp(cpu):
  this happens when the task was one of the tasks defining the current
  uclamp(cpu) value, which is defined to track the MAX of the RUNNABLE
  tasks clamp values.

In this last case we _not_ always need to do a uclamp(cpu) update.
Indeed the update is required _only_ when that task was _the last_ task
defining the current uclamp(cpu) value.

In this case we use uclamp_rq_max_value() to do a linear scan of
UCLAMP_CNT values which fits into a single cache line.

> I think I spotted a bug where in the if condition we check for '>='
> instead of '>', causing us to take the supposedly impossible fail safe
> path.

The fail safe path is when the '>' condition matches, which is what the
SCHED_WARN_ON tell us. Indeed, we never expect uclamp(cpu) to be bigger
than one of its RUNNABLE tasks. If that should happen we WARN and fix
the cpu clamp value for the best.

The normal path is instead '=' and, according to by previous resume,
it's expected to be executed _only_ when we dequeue the last task of the
clamp group defining the current uclamp(cpu) value.

> Mind trying with the below patch please?
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0464569f26a7..50d66d4016ff 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1063,7 +1063,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>          * e.g. due to future modification, warn and fixup the expected value.
>          */
>         SCHED_WARN_ON(bucket->value > rq_clamp);
> -       if (bucket->value >= rq_clamp) {
> +       if (bucket->value > rq_clamp) {
>                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
>                 WRITE_ONCE(uc_rq->value, bkt_clamp);
>         }

This patch is thus bogus, since we never expect to have uclamp(cpu)
bigger than uclamp(task) and thus we will never reset the clamp value of
a cpu.

