Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF8216B82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGLay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 07:30:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGGLay (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:30:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BF831FB;
        Tue,  7 Jul 2020 04:30:53 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F6D3F71E;
        Tue,  7 Jul 2020 04:30:50 -0700 (PDT)
References: <20200706142839.26629-1-qais.yousef@arm.com> <20200706142839.26629-2-qais.yousef@arm.com> <jhj8sfw8wzk.mognet@arm.com> <20200707093447.4t6eqjy4fkt747fo@e107158-lin.cambridge.arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
In-reply-to: <20200707093447.4t6eqjy4fkt747fo@e107158-lin.cambridge.arm.com>
Date:   Tue, 07 Jul 2020 12:30:48 +0100
Message-ID: <jhj36638suv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 07/07/20 10:34, Qais Yousef wrote:
> On 07/06/20 16:49, Valentin Schneider wrote:
>>
>> On 06/07/20 15:28, Qais Yousef wrote:
>> > CC: linux-fsdevel@vger.kernel.org
>> > ---
>> >
>> > Peter
>> >
>> > I didn't do the
>> >
>> >       read_lock(&taslist_lock);
>> >       smp_mb__after_spinlock();
>> >       read_unlock(&tasklist_lock);
>> >
>> > dance you suggested on IRC as it didn't seem necessary. But maybe I missed
>> > something.
>> >
>>
>> So the annoying bit with just uclamp_fork() is that it happens *before* the
>> task is appended to the tasklist. This means without too much care we
>> would have (if we'd do a sync at uclamp_fork()):
>>
>>   CPU0 (sysctl write)                                CPU1 (concurrent forker)
>>
>>                                                        copy_process()
>>                                                          uclamp_fork()
>>                                                            p.uclamp_min = state
>>     state = foo
>>
>>     for_each_process_thread(p, t)
>>       update_state(t);
>>                                                          list_add(p)
>>
>> i.e. that newly forked process would entirely sidestep the update. Now,
>> with Peter's suggested approach we can be in a much better situation. If we
>> have this in the sysctl update:
>>
>>   state = foo;
>>
>>   read_lock(&taslist_lock);
>>   smp_mb__after_spinlock();
>>   read_unlock(&tasklist_lock);
>>
>>   for_each_process_thread(p, t)
>>     update_state(t);
>>
>> While having this in the fork:
>>
>>   write_lock(&tasklist_lock);
>>   list_add(p);
>>   write_unlock(&tasklist_lock);
>>
>>   sched_post_fork(p); // state re-read here; probably wants an mb first
>>
>> Then we can no longer miss an update. If the forked p doesn't see the new
>> value, it *must* have been added to the tasklist before the updater loops
>> over it, so the loop will catch it. If it sees the new value, we're done.
>
> uclamp_fork() has nothing to do with the race. If copy_process() duplicates the
> task_struct of an RT task, it'll copy the old value.
>

Quite so; my point was if we were to use uclamp_fork() as to re-read the value.

> I'd expect the newly introduced sched_post_fork() (also in copy_process() after
> the list update) to prevent this race altogether.
>
> Now we could end up with a problem if for_each_process_thread() doesn't see the
> newly forked task _after_ sched_post_fork(). Hence my question to Peter.
>


>>
>> AIUI, the above strategy doesn't require any use of RCU. The update_state()
>> and sched_post_fork() can race, but as per the above they should both be
>> writing the same value.
>
> for_each_process_thread() must be protected by either tasklist_lock or
> rcu_read_lock().
>

Right

> The other RCU logic I added is not to protect against the race above. I
> describe the other race condition in a comment.

I take it that's the one in uclamp_sync_util_min_rt_default()?

__setscheduler_uclamp() can't be preempted as we hold task_rq_lock(). It
can indeed race with the sync though, but again with the above suggested
setup it would either:
- see the old value, but be guaranteed to be iterated over later by the
  updater
- see the new value

sched_post_fork() being preempted out is a bit more annoying, but what
prevents us from making that bit preempt-disabled?

I have to point out I'm assuming here updaters are serialized, which does
seem to be see the case (cf. uclamp_mutex).


> Basically another updater on a
> different cpu via fork() and sched_setattr() might read an old value and get
> preempted. The rcu synchronization will ensure concurrent updaters have
> finished before iterating the list.
>

> Thanks
