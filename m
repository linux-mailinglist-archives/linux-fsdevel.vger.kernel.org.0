Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B256178BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 09:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKCIeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCIeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:34:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491C5194
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 01:34:08 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 11so804499iou.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 01:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Oq+O6Y47SDFAKlhB0chB1Q+ihH1iVVVwZ1Mnyqq/3c=;
        b=RCMa416sd+N+H7/6zfSu9DcS7tvcqYyTk7thNsfqy1OUnzywMYOG3khagDoQrEyxd1
         HkSV8bQMKfA4+ptP5biWvTwcXM9/RKjttya06encqfAhIwh74Plb5TF7PMXhdiLusdMT
         JkUOiTjn10IsxhSf1FgoRxYQEtfIGiKHCRuT0yOoql1wYQCssujoVV1WvB+4UF2yzrqr
         gd6JNepfwkI/K0VwiHgUfLOW67wM5rQmoVjOy2k6F3uq6PhBWsnKmVRzontb40N1lGoR
         RPt3vXJ3/vG91Bga+sqgCzGNF88abe651nR4T77h3gliXf3crSLA5DQfwXPfv1cni1yF
         t5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Oq+O6Y47SDFAKlhB0chB1Q+ihH1iVVVwZ1Mnyqq/3c=;
        b=xW+rLlQif7YP90edzlH8xcFpLOie88M8HHlTyeDz/WHjFnv7f/miVTaQIwjFMJgirJ
         WpXXTIt+1f1P2cwWL39urxO4VgCp/7+pR8T/F1gJ4tMnZoE1wz5tiMoV6QLlFq1uzPVw
         4V5DvYflHtG8w6RPKIsVXQ2qESDLchDWv2n418Py0/tEOo80X53CRHGQ0ShQY465krDV
         /KSvad+cfgLfxgAUs+aAJ9BuOOIFYwmZUCzREchIyIxmC/XBS/dD7VRNAfoEk64cPEuT
         3e362+aDhN9Dp85G1fYYM9fnD0uthMA2XsAvUaGRWnIwVwq7mqEWQBGDb6FSUUG/OuXR
         PzzQ==
X-Gm-Message-State: ACrzQf0ITZMCsDGkGI4a0OsbAIum8GBWAapEmStcrCstjALAahwabGY5
        J7rXz4JnkKcAXGnBfR5yqvZpY9r7l/jWm2qSWff0bg==
X-Google-Smtp-Source: AMsMyM4RlfafqvelIHRzdV01sypmXD0mWkZass0TYEGiW7YygSgr7RDmb4wBHXm+0MIwNr3E+8faEsfgR0t99I2bWXc=
X-Received: by 2002:a02:aa91:0:b0:375:4ccf:cf52 with SMTP id
 u17-20020a02aa91000000b003754ccfcf52mr14345528jai.55.1667464447514; Thu, 03
 Nov 2022 01:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221102035301.512892-1-zhangsong34@huawei.com>
 <CAKfTPtCcYySw2ZC_pr8=3KFPmAAVN=1h8=5jWkW5YXyy11sehg@mail.gmail.com> <b45f96b6-e0b2-22bb-eda1-2468d6fbe104@huawei.com>
In-Reply-To: <b45f96b6-e0b2-22bb-eda1-2468d6fbe104@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 3 Nov 2022 09:33:55 +0100
Message-ID: <CAKfTPtDrWCenxtVcunjS3pGD81TdLf2EkhO_YcdfxnUHXpVF3w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Introduce priority load balance for CFS
To:     Song Zhang <zhangsong34@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 3 Nov 2022 at 04:01, Song Zhang <zhangsong34@huawei.com> wrote:
>
> Thanks for your reply!
>
> On 2022/11/3 2:01, Vincent Guittot wrote:
> > On Wed, 2 Nov 2022 at 04:54, Song Zhang <zhangsong34@huawei.com> wrote:
> >>
> >
> > This really looks like a v3 of
> > https://lore.kernel.org/all/20220810015636.3865248-1-zhangsong34@huawei.com/
> >
> > Please keep versioning.
> >
> >> Add a new sysctl interface:
> >> /proc/sys/kernel/sched_prio_load_balance_enabled
> >
> > We don't want to add more sysctl knobs for the scheduler, we even
> > removed some. Knob usually means that you want to fix your use case
> > but the solution doesn't make sense for all cases.
> >
>
> OK, I will remove this knobs later.
>
> >>
> >> 0: default behavior
> >> 1: enable priority load balance for CFS
> >>
> >> For co-location with idle and non-idle tasks, when CFS do load balance,
> >> it is reasonable to prefer migrating non-idle tasks and migrating idle
> >> tasks lastly. This will reduce the interference by SCHED_IDLE tasks
> >> as much as possible.
> >
> > I don't agree that it's always the best choice to migrate a non-idle task 1st.
> >
> > CPU0 has 1 non idle task and CPU1 has 1 non idle task and hundreds of
> > idle task and there is an imbalance between the 2 CPUS: migrating the
> > non idle task from CPU1 to CPU0 is not the best choice
> >
>
> If the non idle task on CPU1 is running or cache hot, it cannot be
> migrated and idle tasks can also be migrated from CPU1 to CPU0. So I
> think it does not matter.

What I mean is that migrating non idle tasks first is not a universal
win and not always what we want.

>
> >>
> >> Testcase:
> >> - Spawn large number of idle(SCHED_IDLE) tasks occupy CPUs
> >
> > What do you mean by a large number ?
> >
> >> - Let non-idle tasks compete with idle tasks for CPU time.
> >>
> >> Using schbench to test non-idle tasks latency:
> >> $ ./schbench -m 1 -t 10 -r 30 -R 200
> >
> > How many CPUs do you have ?
> >
>
> OK, some details may not be mentioned.
> My virtual machine has 8 CPUs running with a schbench process and 5000
> idle tasks. The idle task is a while dead loop process below:

How can you care about latency when you start 10 workers on 8 vCPUs
with 5000 non idle threads ?

>
> $ cat idle_process.c
> int main()
> {
>          int i = 0;
>          while(1) {
>                  usleep(500);
>                  for(i = 0; i < 1000000; i++);
>          }
> }
>
> You can compile and spawn 5000 idle(SCHED_IDLE) tasks occupying 8 CPUs
> and execute schbench command to test it.
>
> >>
> >> Test result:
> >> 1.Default behavior
> >> Latency percentiles (usec) runtime 30 (s) (4562 total samples)
> >>          50.0th: 62528 (2281 samples)
> >>          75.0th: 623616 (1141 samples)
> >>          90.0th: 764928 (687 samples)
> >>          95.0th: 824320 (225 samples)
> >>          *99.0th: 920576 (183 samples)
> >>          99.5th: 953344 (23 samples)
> >>          99.9th: 1008640 (18 samples)
> >>          min=9, max=1074466
> >>
> >> 2.Enable priority load balance
> >> Latency percentiles (usec) runtime 30 (s) (4391 total samples)
> >>          50.0th: 22624 (2204 samples)
> >>          75.0th: 48832 (1092 samples)
> >>          90.0th: 85376 (657 samples)
> >>          95.0th: 113280 (220 samples)
> >>          *99.0th: 182528 (175 samples)
> >>          99.5th: 206592 (22 samples)
> >>          99.9th: 290304 (17 samples)
> >>          min=6, max=351815
> >>
> >>  From percentile details, we see the benefit of priority load balance
> >> that 95% of non-idle tasks latencies stays no more than 113ms, while
> >
> > But even 113ms seems quite a large number if there is anything else
> > but 10 schbench workers and a bunch of idle threads that are running.
> >
> >> non-idle tasks latencies has got almost 50% over 600ms if priority
> >> load balance not enabled.
> >
> > Als have you considered enabling sched_feature LB_MIN ?
> >
>
> I have tried to echo LB_MIN > /sys/kernel/debug/sched/features, but this
> feature seems make no sense.
>
> >>
> >> Signed-off-by: Song Zhang <zhangsong34@huawei.com>
> >> ---
> >>   include/linux/sched/sysctl.h |  4 +++
> >>   init/Kconfig                 | 10 ++++++
> >>   kernel/sched/core.c          |  3 ++
> >>   kernel/sched/fair.c          | 61 +++++++++++++++++++++++++++++++++++-
> >>   kernel/sched/sched.h         |  3 ++
> >>   kernel/sysctl.c              | 11 +++++++
> >>   6 files changed, 91 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> >> index 303ee7dd0c7e..9b3673269ecc 100644
> >> --- a/include/linux/sched/sysctl.h
> >> +++ b/include/linux/sched/sysctl.h
> >> @@ -32,6 +32,10 @@ extern unsigned int sysctl_numa_balancing_promote_rate_limit;
> >>   #define sysctl_numa_balancing_mode     0
> >>   #endif
> >>
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +extern unsigned int sysctl_sched_prio_load_balance_enabled;
> >> +#endif
> >> +
> >>   int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
> >>                  size_t *lenp, loff_t *ppos);
> >>
> >> diff --git a/init/Kconfig b/init/Kconfig
> >> index 694f7c160c9c..b0dfe6701218 100644
> >> --- a/init/Kconfig
> >> +++ b/init/Kconfig
> >> @@ -1026,6 +1026,16 @@ config CFS_BANDWIDTH
> >>            restriction.
> >>            See Documentation/scheduler/sched-bwc.rst for more information.
> >>
> >> +config SCHED_PRIO_LB
> >> +       bool "Priority load balance for CFS"
> >> +       depends on SMP
> >> +       default n
> >> +       help
> >> +         This feature enable CFS priority load balance to reduce
> >> +         non-idle tasks latency interferenced by SCHED_IDLE tasks.
> >> +         It prefer migrating non-idle tasks firstly and
> >> +         migrating SCHED_IDLE tasks lastly.
> >> +
> >>   config RT_GROUP_SCHED
> >>          bool "Group scheduling for SCHED_RR/FIFO"
> >>          depends on CGROUP_SCHED
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 5800b0623ff3..9be35431fdd5 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -9731,6 +9731,9 @@ void __init sched_init(void)
> >>                  rq->max_idle_balance_cost = sysctl_sched_migration_cost;
> >>
> >>                  INIT_LIST_HEAD(&rq->cfs_tasks);
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +               INIT_LIST_HEAD(&rq->cfs_idle_tasks);
> >> +#endif
> >>
> >>                  rq_attach_root(rq, &def_root_domain);
> >>   #ifdef CONFIG_NO_HZ_COMMON
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index e4a0b8bd941c..bdeb04324f0c 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -139,6 +139,10 @@ static int __init setup_sched_thermal_decay_shift(char *str)
> >>   }
> >>   __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
> >>
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +unsigned int sysctl_sched_prio_load_balance_enabled;
> >> +#endif
> >> +
> >>   #ifdef CONFIG_SMP
> >>   /*
> >>    * For asym packing, by default the lower numbered CPU has higher priority.
> >> @@ -3199,6 +3203,21 @@ static inline void update_scan_period(struct task_struct *p, int new_cpu)
> >>
> >>   #endif /* CONFIG_NUMA_BALANCING */
> >>
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +static void
> >> +adjust_rq_cfs_tasks(
> >> +       void (*list_op)(struct list_head *, struct list_head *),
> >> +       struct rq *rq,
> >> +       struct sched_entity *se)
> >> +{
> >> +       if (sysctl_sched_prio_load_balance_enabled &&
> >> +               task_has_idle_policy(task_of(se)))
> >> +               (*list_op)(&se->group_node, &rq->cfs_idle_tasks);
> >> +       else
> >> +               (*list_op)(&se->group_node, &rq->cfs_tasks);
> >> +}
> >> +#endif
> >> +
> >>   static void
> >>   account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >>   {
> >> @@ -3208,7 +3227,11 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >>                  struct rq *rq = rq_of(cfs_rq);
> >>
> >>                  account_numa_enqueue(rq, task_of(se));
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +               adjust_rq_cfs_tasks(list_add, rq, se);
> >> +#else
> >>                  list_add(&se->group_node, &rq->cfs_tasks);
> >> +#endif
> >>          }
> >>   #endif
> >>          cfs_rq->nr_running++;
> >> @@ -7631,7 +7654,11 @@ done: __maybe_unused;
> >>           * the list, so our cfs_tasks list becomes MRU
> >>           * one.
> >>           */
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +       adjust_rq_cfs_tasks(list_move, rq, &p->se);
> >> +#else
> >>          list_move(&p->se.group_node, &rq->cfs_tasks);
> >> +#endif
> >>   #endif
> >>
> >>          if (hrtick_enabled_fair(rq))
> >> @@ -8156,11 +8183,18 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
> >>   static struct task_struct *detach_one_task(struct lb_env *env)
> >>   {
> >>          struct task_struct *p;
> >> +       struct list_head *tasks = &env->src_rq->cfs_tasks;
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +       bool has_detach_idle_tasks = false;
> >> +#endif
> >>
> >>          lockdep_assert_rq_held(env->src_rq);
> >>
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +again:
> >> +#endif
> >>          list_for_each_entry_reverse(p,
> >> -                       &env->src_rq->cfs_tasks, se.group_node) {
> >> +                       tasks, se.group_node) {
> >>                  if (!can_migrate_task(p, env))
> >>                          continue;
> >>
> >> @@ -8175,6 +8209,13 @@ static struct task_struct *detach_one_task(struct lb_env *env)
> >>                  schedstat_inc(env->sd->lb_gained[env->idle]);
> >>                  return p;
> >>          }
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +       if (sysctl_sched_prio_load_balance_enabled && !has_detach_idle_tasks) {
> >> +               has_detach_idle_tasks = true;
> >> +               tasks = &env->src_rq->cfs_idle_tasks;
> >> +               goto again;
> >> +       }
> >> +#endif
> >>          return NULL;
> >>   }
> >>
> >> @@ -8190,6 +8231,9 @@ static int detach_tasks(struct lb_env *env)
> >>          unsigned long util, load;
> >>          struct task_struct *p;
> >>          int detached = 0;
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +       bool has_detach_idle_tasks = false;
> >> +#endif
> >>
> >>          lockdep_assert_rq_held(env->src_rq);
> >>
> >> @@ -8205,6 +8249,9 @@ static int detach_tasks(struct lb_env *env)
> >>          if (env->imbalance <= 0)
> >>                  return 0;
> >>
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +again:
> >> +#endif
> >>          while (!list_empty(tasks)) {
> >>                  /*
> >>                   * We don't want to steal all, otherwise we may be treated likewise,
> >> @@ -8310,6 +8357,14 @@ static int detach_tasks(struct lb_env *env)
> >>                  list_move(&p->se.group_node, tasks);
> >>          }
> >>
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +       if (sysctl_sched_prio_load_balance_enabled &&
> >> +               !has_detach_idle_tasks && env->imbalance > 0) {
> >> +               has_detach_idle_tasks = true;
> >> +               tasks = &env->src_rq->cfs_idle_tasks;
> >> +               goto again;
> >> +       }
> >> +#endif
> >>          /*
> >>           * Right now, this is one of only two places we collect this stat
> >>           * so we can safely collect detach_one_task() stats here rather
> >> @@ -11814,7 +11869,11 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> >>                   * Move the next running task to the front of the list, so our
> >>                   * cfs_tasks list becomes MRU one.
> >>                   */
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +               adjust_rq_cfs_tasks(list_move, rq, se);
> >> +#else
> >>                  list_move(&se->group_node, &rq->cfs_tasks);
> >> +#endif
> >>          }
> >>   #endif
> >>
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index 1644242ecd11..1b831c05ba30 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -1053,6 +1053,9 @@ struct rq {
> >>          int                     online;
> >>
> >>          struct list_head cfs_tasks;
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +       struct list_head cfs_idle_tasks;
> >> +#endif
> >>
> >>          struct sched_avg        avg_rt;
> >>          struct sched_avg        avg_dl;
> >> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> >> index 188c305aeb8b..5fc0f9ffb675 100644
> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -2090,6 +2090,17 @@ static struct ctl_table kern_table[] = {
> >>                  .extra1         = SYSCTL_ONE,
> >>                  .extra2         = SYSCTL_INT_MAX,
> >>          },
> >> +#endif
> >> +#ifdef CONFIG_SCHED_PRIO_LB
> >> +       {
> >> +               .procname       = "sched_prio_load_balance_enabled",
> >> +               .data           = &sysctl_sched_prio_load_balance_enabled,
> >> +               .maxlen         = sizeof(unsigned int),
> >> +               .mode           = 0644,
> >> +               .proc_handler   = proc_dointvec_minmax,
> >> +               .extra1         = SYSCTL_ZERO,
> >> +               .extra2         = SYSCTL_ONE,
> >> +       },
> >>   #endif
> >>          { }
> >>   };
> >> --
> >> 2.27.0
> >>
> > .
