Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F81183DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLJJoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 04:44:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41507 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:44:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so13136136lfp.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 01:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVprmkX04/ZA2Ox8rlDXhtYrH8Cdrulho+SeNeN/8to=;
        b=M3jycdhtLFPex3L2spBWypQ+mK6nzf31bl4Gqd6sV7LltjwgcUk+7tKuPRbipf0QT8
         DUdNjLvxx+OlIZd/SEXYZwssHKB/+1igQw9UrcPIS1qNYoNdnTC+BuYqHJpWChzAQPu2
         C1lwwQpvn1z208nDPbeiFhqGpcYTxdwZuFeQbx3A85Shke5cSZsT35JEHWBc7zFn4Ibt
         whbcBTPlXYZk+JQ0IbTt8BzAU7SLpAM8BLQ0piJQrYs2FT7c7kwKHBRxtvCggR22S/Os
         ToNBOf5X7zXI3Vd3I/zKmsH6MavzavFu3q2pyJV1DXQk5Mr3cQ7XG3N4IBT5bAIqTTH5
         u78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVprmkX04/ZA2Ox8rlDXhtYrH8Cdrulho+SeNeN/8to=;
        b=DFi8Z77H/xpw3xcmImw+KgfhPXcHD2PlsTP43/G6ZOisj+t0ykEoyhZffLgjyqonrh
         HVrWibO2Qv1OiahKVCsBbGaEg+icJgN74w/yqMMVgEzRTEvJfm5f34+u8ZzA5fnZDjcD
         zodx6IrXlfs3VxYHQ7SWlPWYIO2QPASwdNswPMt2muBjMGgq6StWQsq3cvl2OQNlJuSV
         1ihQFk05upnO8I/g6MX6TTBlF50mrRsRL+XQ8YoxQRwU6R1W+R17YcMIrSx+HcXmX0tC
         FrtiXm6xvPhLd8RT8hSCFnkWdANyn99Ty7fkBiA+/zpGKR0FkxIYcbQsI70wrNrxcbcx
         7q1A==
X-Gm-Message-State: APjAAAWeWOJBfxU0soFlakMiWOPPxguTkP81GKYWImc00p0aZs7WU1Jb
        39ZokPhh3QUR8WR7pcE4EGYVH7Fe8krs/EzpAglp1g==
X-Google-Smtp-Source: APXvYqwU6TvB7JcE/3RASUPFThxDiWpcs5rUTJFNuWlv+3cPwgOkF4im9S52I4IaK/gV84FJf6KuxUd7LyOYLmW+s08=
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr10053401lfa.151.1575971038660;
 Tue, 10 Dec 2019 01:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20191115045634.GN4614@dread.disaster.area> <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area> <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area> <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb> <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com> <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
In-Reply-To: <20191210054330.GF27253@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 10 Dec 2019 10:43:46 +0100
Message-ID: <CAKfTPtCBxV+az30n8E9fRv_HweN_QPJn_ni961OsKp5xUWUD2A@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: Preempt current task in favour of bound kthread
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 Dec 2019 at 06:43, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> A running task can wake-up a per CPU bound kthread on the same CPU.
> If the current running task doesn't yield the CPU before the next load
> balance operation, the scheduler would detect load imbalance and try to
> balance the load. However this load balance would fail as the waiting
> task is CPU bound, while the running task cannot be moved by the regular
> load balancer. Finally the active load balancer would kick in and move
> the task to a different CPU/Core. Moving the task to a different
> CPU/core can lead to loss in cache affinity leading to poor performance.
>
> This is more prone to happen if the current running task is CPU
> intensive and the sched_wake_up_granularity is set to larger value.
> When the sched_wake_up_granularity was relatively small, it was observed
> that the bound thread would complete before the load balancer would have
> chosen to move the cache hot task to a different CPU.
>
> To deal with this situation, the current running task would yield to a
> per CPU bound kthread, provided kthread is not CPU intensive.
>
> /pboffline/hwcct_prg_old/lib/fsperf -t overwrite --noclean -f 5g -b 4k /pboffline
>
> (With sched_wake_up_granularity set to 15ms)

So you increase sched_wake_up_granularity to a high level to ensure
that current is no preempted by waking thread but then you add a way
to finally preempt it which is somewhat weird IMO

Have you tried to increase the priority of workqueue thread  (decrease
nice priority) ? This is the right way to reduce the impact of the
sched_wake_up_granularity on the wakeup of your specific kthread.
Because what you want at the end is keeping a low wakeup granularity
for these io workqueues

>
> Performance counter stats for 'system wide' (5 runs):
> event                                        v5.4                               v5.4 + patch(v2)
> probe:active_load_balance_cpu_stop       1,919  ( +-  2.89% )                   5  ( +- 12.56% )
> sched:sched_waking                     441,535  ( +-  0.17% )             901,174  ( +-  0.25% )
> sched:sched_wakeup                     441,533  ( +-  0.17% )             901,172  ( +-  0.25% )
> sched:sched_wakeup_new                   2,436  ( +-  8.08% )                 525  ( +-  2.57% )
> sched:sched_switch                     797,007  ( +-  0.26% )           1,458,463  ( +-  0.24% )
> sched:sched_migrate_task                20,998  ( +-  1.04% )               2,279  ( +-  3.47% )
> sched:sched_process_free                 2,436  ( +-  7.90% )                 527  ( +-  2.30% )
> sched:sched_process_exit                 2,451  ( +-  7.85% )                 542  ( +-  2.24% )
> sched:sched_wait_task                        7  ( +- 21.20% )                   1  ( +- 77.46% )
> sched:sched_process_wait                 3,951  ( +-  9.14% )                 816  ( +-  3.52% )
> sched:sched_process_fork                 2,435  ( +-  8.09% )                 524  ( +-  2.58% )
> sched:sched_process_exec                 1,023  ( +- 12.21% )                 198  ( +-  3.23% )
> sched:sched_wake_idle_without_ipi      187,794  ( +-  1.14% )             348,565  ( +-  0.34% )
>
> Elasped time in seconds          289.43 +- 1.42 ( +-  0.49% )    72.6013 +- 0.0417 ( +-  0.06% )
> Throughput results
>
> v5.4
> Trigger time:................... 0.842679 s   (Throughput:     6075.86 MB/s)
> Asynchronous submit time:.......   1.0184 s   (Throughput:     5027.49 MB/s)
> Synchronous submit time:........        0 s   (Throughput:           0 MB/s)
> I/O time:.......................   263.17 s   (Throughput:      19.455 MB/s)
> Ratio trigger time to I/O time:.0.00320202
>
> v5.4 + patch(v2)
> Trigger time:................... 0.853973 s   (Throughput:      5995.5 MB/s)
> Asynchronous submit time:....... 0.768092 s   (Throughput:     6665.86 MB/s)
> Synchronous submit time:........        0 s   (Throughput:           0 MB/s)
> I/O time:.......................  44.0267 s   (Throughput:     116.292 MB/s)
> Ratio trigger time to I/O time:.0.0193966
>
> (With sched_wake_up_granularity set to 4ms)
>
> Performance counter stats for 'system wide' (5 runs):
> event                                         v5.4                              v5.4 + patch(v2)
> probe:active_load_balance_cpu_stop               6  ( +-  6.03% )                   5  ( +- 23.20% )
> sched:sched_waking                         899,880  ( +-  0.38% )             899,737  ( +-  0.41% )
> sched:sched_wakeup                         899,878  ( +-  0.38% )             899,736  ( +-  0.41% )
> sched:sched_wakeup_new                         622  ( +- 11.95% )                 499  ( +-  1.08% )
> sched:sched_switch                       1,458,214  ( +-  0.40% )           1,451,374  ( +-  0.32% )
> sched:sched_migrate_task                     3,120  ( +- 10.00% )               2,500  ( +- 10.86% )
> sched:sched_process_free                       608  ( +- 12.18% )                 484  ( +-  1.19% )
> sched:sched_process_exit                       623  ( +- 11.91% )                 499  ( +-  1.15% )
> sched:sched_wait_task                            1  ( +- 31.18% )                   1  ( +- 31.18% )
> sched:sched_process_wait                       998  ( +- 13.22% )                 765  ( +-  0.16% )
> sched:sched_process_fork                       622  ( +- 11.95% )                 498  ( +-  1.08% )
> sched:sched_process_exec                       242  ( +- 13.81% )                 183  ( +-  0.48% )
> sched:sched_wake_idle_without_ipi          349,165  ( +-  0.35% )             347,773  ( +-  0.43% )
>
> Elasped time in seconds           72.8560 +- 0.0768 ( +-  0.11% )     72.4327 +- 0.0797 ( +-  0.11% )
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
> Changelog:
> v1 : http://lore.kernel.org/lkml/20191209165122.GA27229@linux.vnet.ibm.com
> v1->v2: Pass the the right params to try_to_wake_up as correctly pointed out
> by Dave Chinner
>
>
>  kernel/sched/core.c  |  7 ++++++-
>  kernel/sched/fair.c  | 23 ++++++++++++++++++++++-
>  kernel/sched/sched.h |  3 ++-
>  3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44123b4d14e8..82126cbf62cd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2664,7 +2664,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   */
>  int wake_up_process(struct task_struct *p)
>  {
> -       return try_to_wake_up(p, TASK_NORMAL, 0);
> +       int wake_flags = 0;
> +
> +       if (is_per_cpu_kthread(p))
> +               wake_flags = WF_KTHREAD;
> +
> +       return try_to_wake_up(p, TASK_NORMAL, wake_flags);
>  }
>  EXPORT_SYMBOL(wake_up_process);
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 69a81a5709ff..36486f71e59f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6660,6 +6660,27 @@ static void set_skip_buddy(struct sched_entity *se)
>                 cfs_rq_of(se)->skip = se;
>  }
>
> +static int kthread_wakeup_preempt(struct rq *rq, struct task_struct *p, int wake_flags)
> +{
> +       struct task_struct *curr = rq->curr;
> +       struct cfs_rq *cfs_rq = task_cfs_rq(curr);
> +
> +       if (!(wake_flags & WF_KTHREAD))
> +               return 0;
> +
> +       if (p->nr_cpus_allowed != 1 || curr->nr_cpus_allowed == 1)
> +               return 0;
> +
> +       if (cfs_rq->nr_running > 2)
> +               return 0;
> +
> +       /*
> +        * Don't preempt, if the waking kthread is more CPU intensive than
> +        * the current thread.
> +        */
> +       return p->nvcsw * curr->nivcsw >= p->nivcsw * curr->nvcsw;
> +}
> +
>  /*
>   * Preempt the current task with a newly woken task if needed:
>   */
> @@ -6716,7 +6737,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>         find_matching_se(&se, &pse);
>         update_curr(cfs_rq_of(se));
>         BUG_ON(!pse);
> -       if (wakeup_preempt_entity(se, pse) == 1) {
> +       if (wakeup_preempt_entity(se, pse) == 1 || kthread_wakeup_preempt(rq, p, wake_flags)) {
>                 /*
>                  * Bias pick_next to pick the sched entity that is
>                  * triggering this preemption.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c8870c5bd7df..23d4284ad1e3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1643,7 +1643,8 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>   */
>  #define WF_SYNC                        0x01            /* Waker goes to sleep after wakeup */
>  #define WF_FORK                        0x02            /* Child wakeup after fork */
> -#define WF_MIGRATED            0x4             /* Internal use, task got migrated */
> +#define WF_MIGRATED            0x04            /* Internal use, task got migrated */
> +#define WF_KTHREAD             0x08            /* Per CPU Kthread*/
>
>  /*
>   * To aid in avoiding the subversion of "niceness" due to uneven distribution
> --
> 2.18.1
>
