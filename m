Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E01EF900
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgFEN2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 09:28:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39775 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFEN2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:28:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id g1so7458575edv.6;
        Fri, 05 Jun 2020 06:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=fZMKNXMn7eOtu1zXlNbmSogdJetbjxreWCBo52VDs60=;
        b=mPH20Fey0CAg1OAujcl5B7Q5BdVZumOOfo+WUz9XHtg+qYxlNm3b3ZwxYdOUoE30cu
         0xJ7DAk+rny0BFgOvdXB+Fdtc4TZ3LgYJL30CvpWO72Xu31YdBd70DstnrfcUTCcZKHJ
         yGheY6Es1QQcc6Zk1/m22qPD1qCVYjDQ63euO6NiRuSsM67VO1x7d7l+VWPlPzWBn3Xp
         sHs2mphreRFBfSM6qV1O5UGkwE1MNRS09HrGl+v0fPFbUV6TCc6W1qqTwr0cQcuvTq3O
         kA6RsF1KiBFfpvGRA1NOCf/K1BZ3HYX4jpgqBcxKvefhvmYKJTI6eSrmKc64XWiO9TBU
         BV4g==
X-Gm-Message-State: AOAM531FYup6y6zaUQXIXxLCfLqObHZ0WAnZHmECUuxeDvgVUAxDOGfG
        wNSwuYCP5FKKJ8ihtlXvLYu22uDIJLA=
X-Google-Smtp-Source: ABdhPJx1sGPU9QCW2RWcJs1ctSPiOiHE5crh0SLl2c0gQncQGJKsZAEkLRkPwMwoCeUb+r/vxiPRqA==
X-Received: by 2002:a05:6402:943:: with SMTP id h3mr9572643edz.89.1591363681877;
        Fri, 05 Jun 2020 06:28:01 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:6574:5ece:b8f6:310e])
        by smtp.gmail.com with ESMTPSA id ox27sm4373617ejb.101.2020.06.05.06.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jun 2020 06:28:00 -0700 (PDT)
References: <20200528132327.GB706460@hirez.programming.kicks-ass.net> <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com> <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200529100806.GA3070@suse.de> <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com> <87v9k84knx.derkling@matbug.net> <20200603101022.GG3070@suse.de> <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com> <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com> <875zc60ww2.derkling@matbug.net> <20200605113204.srskjrunz2ezkcuj@e107158-lin.cambridge.arm.com>
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
In-reply-to: <20200605113204.srskjrunz2ezkcuj@e107158-lin.cambridge.arm.com>
Message-ID: <871rmt1w2p.derkling@matbug.net>
Date:   Fri, 05 Jun 2020 15:27:58 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Fri, Jun 05, 2020 at 13:32:04 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

> On 06/05/20 09:55, Patrick Bellasi wrote:
>> On Wed, Jun 03, 2020 at 18:52:00 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index 0464569f26a7..9f48090eb926 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -1063,10 +1063,12 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>> >          * e.g. due to future modification, warn and fixup the expected value.
>> >          */
>> >         SCHED_WARN_ON(bucket->value > rq_clamp);
>> > +#if 0
>> >         if (bucket->value >= rq_clamp) {
>> >                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
>> >                 WRITE_ONCE(uc_rq->value, bkt_clamp);
>> >         }
>> > +#endif
>> 
>> Yep, that's likely where we have most of the overhead at dequeue time,
>> sine _sometimes_ we need to update the cpu's clamp value.
>> 
>> However, while running perf sched pipe, I expect:
>>  - all tasks to have the same clamp value
>>  - all CPUs to have _always_ at least one RUNNABLE task
>> 
>> Given these two conditions above, if the CPU is never "CFS idle" (i.e.
>> without RUNNABLE CFS tasks), the code above should never be triggered.
>> More on that later...
>
> So the cost is only incurred by idle cpus is what you're saying.

Not really, you pay the cost every time you need to reduce the CPU clamp
value. This can happen also on a busy CPU but only when you dequeue the
last task defining the current uclamp(cpu) value and the remaining
RUNNABLE tasks have a lower value.

>> >  }
>> >
>> >  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>> >
>> >
>> >
>> > uclamp_rq_max_value() could be expensive as it loops over all buckets.
>> 
>> It loops over UCLAMP_CNT values which are defined to fit into a single
>
> I think you meant to say UCLAMP_BUCKETS which is defined 5 by default.

Right, UCLAMP_BUCKETS.

>> $L. That was the optimal space/time complexity compromise we found to
>> get the MAX of a set of values.
>
> It actually covers two cachelines, see below and my other email to
> Mel.

The two cache lines are covered if you consider both min and max clamps.
One single CLAMP_ID has a _size_ which fits into a single cache line.

However, to be precise:
- while uclamp_min spans a single cache line, uclamp_max is likely
  across two
- at enqueue/dequeue time we update both min/max, thus we can touch
  both cache lines

>> > Commenting this whole path out strangely doesn't just 'fix' it,
>> > but produces  better results to no-uclamp kernel :-/
>> >
>> > # ./perf bench -r 20 sched pipe -T -l 50000
>> > Without uclamp:		5039
>> > With uclamp:		4832
>> > With uclamp+patch:	5729
>> 
>> I explain it below: with that code removed you never decrease the CPU's
>> uclamp value. Thus, the first time you schedule an RT task you go to MAX
>> OPP and stay there forever.
>
> Okay.
>
>> 
>> > It might be because schedutil gets biased differently by uclamp..? If I move to
>> > performance governor these numbers almost double.
>> >
>> > I don't know. But this promoted me to look closer and
>> 
>> Just to resume, when a task is dequeued we can have only these cases:
>> 
>> - uclamp(task) < uclamp(cpu):
>>   this happens when the task was co-scheduled with other tasks with
>>   higher clamp values which are still RUNNABLE.
>>   In this case there are no uclamp(cpu) updates.
>> 
>> - uclamp(task) == uclamp(cpu):
>>   this happens when the task was one of the tasks defining the current
>>   uclamp(cpu) value, which is defined to track the MAX of the RUNNABLE
>>   tasks clamp values.
>> 
>> In this last case we _not_ always need to do a uclamp(cpu) update.
>> Indeed the update is required _only_ when that task was _the last_ task
>> defining the current uclamp(cpu) value.
>> 
>> In this case we use uclamp_rq_max_value() to do a linear scan of
>> UCLAMP_CNT values which fits into a single cache line.
>
> Again, I think you mean UCLAMP_BUCKETS here. Unless I missed something, they
> span 2 cahcelines on 64bit machines and 64b cacheline size.

Correct:
- s/UCLAMP_CNT/UCLAMP_BUCLKETS/
- 1 cacheline per CLAMP_ID
- the array scan works on 1 CLAMP_ID:
  - spanning 1 cache line for uclamp_min
  - spanning 2 cache lines for uclamp_max


> To be specific, I am referring to struct uclamp_rq, which defines an array of
> size UCLAMP_BUCKETS of type struct uclamp_bucket.
>
> uclamp_rq_max_value() scans the buckets for a given clamp_id (UCLAMP_MIN or
> UCLAMP_MAX).
>
> So sizeof(struct uclamp_rq) = 8 * 5 + 4 = 44; on 64bit machines.
>
> And actually the compiler introduces a 4 bytes hole, so we end up with a total
> of 48 bytes.
>
> In struct rq, we define struct uclamp_rq as an array of UCLAMP_CNT which is 2.
>
> So by default we have 2 * sizeof(struct uclamp_rq) = 96 bytes.

Right, here is the layout we get on x86 (with some context before/after):

---8<---
        /* XXX 4 bytes hole, try to pack */

        long unsigned int          nr_load_updates;      /*    32     8 */
        u64                        nr_switches;          /*    40     8 */

        /* XXX 16 bytes hole, try to pack */

        /* --- cacheline 1 boundary (64 bytes) --- */
        struct uclamp_rq           uclamp[2];            /*    64    96 */
        /* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
        unsigned int               uclamp_flags;         /*   160     4 */

        /* XXX 28 bytes hole, try to pack */

        /* --- cacheline 3 boundary (192 bytes) --- */
        struct cfs_rq              cfs;                  /*   192   384 */

        /* XXX last struct has 40 bytes of padding */

        /* --- cacheline 9 boundary (576 bytes) --- */
        struct rt_rq               rt;                   /*   576  1704 */
        /* --- cacheline 35 boundary (2240 bytes) was 40 bytes ago --- */
        struct dl_rq               dl;                   /*  2280   104 */
---8<---

Considering that:

  struct uclamp_rq {                                                                                                                 
      unsigned int value;
      struct uclamp_bucket bucket[UCLAMP_BUCKETS];
    };

perhaps we can experiment by adding some padding at the end of this
struct to get also uclamp_max spanning only one cache line.

But, considering that at enqueue/dequeue we update both min and max
clamp task's counters, I don't think we get much.


>> > I think I spotted a bug where in the if condition we check for '>='
>> > instead of '>', causing us to take the supposedly impossible fail safe
>> > path.
>> 
>> The fail safe path is when the '>' condition matches, which is what the
>> SCHED_WARN_ON tell us. Indeed, we never expect uclamp(cpu) to be bigger
>> than one of its RUNNABLE tasks. If that should happen we WARN and fix
>> the cpu clamp value for the best.
>> 
>> The normal path is instead '=' and, according to by previous resume,
>> it's expected to be executed _only_ when we dequeue the last task of the
>> clamp group defining the current uclamp(cpu) value.
>
> Okay. I was mislead by the comment then. Thanks for clarifying.
>
> Can this function be broken down to deal with '=' separately from the '>' case?

The '=' case is there just for defensive programming. If something is
wrong and is not catastrophic: fix it and report. The comment tells
exactly this, perhaps we can extend it by saying that something like:
 "Normally we expect MAX to be updated only to a smaller value"
?

> IIUC, for the common '=', we always want to return uclamp_idle_value() hence
> skip the potentially expensive scan?

No, for the '=' case we want to return the new max.

In uclamp_rq_max_value() we check if there are other RUNNABLE tasks,
which will have by definition a smaller uclamp value. If we find one we
want to return their clamp value.

If there are not, we could have avoided the scan, true.
But, since uclamp tracks both RT and CFS tasks, we know that we will be
going idle thus the scan overhead should not be a big deal.

> Anyway, based on Vincent results, it doesn't seem this path is an issue for him
> and the real problem is lurking somewhere else.

Yes, likely.

The only thing perhaps worth trying is the usage of unsigned instead of
long unsigned you proposed before. With the aim to fit everything in a
single cache line. But honestly, I'm still quite sceptical about that
being the root cause. Worth a try tho.
We would need to cache stats to proof it.

