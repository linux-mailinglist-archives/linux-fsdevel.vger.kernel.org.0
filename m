Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E762C1F6612
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 12:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgFKK6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 06:58:19 -0400
Received: from foss.arm.com ([217.140.110.172]:50430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgFKK6T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:58:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7C531B;
        Thu, 11 Jun 2020 03:58:17 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD6AF3F66F;
        Thu, 11 Jun 2020 03:58:14 -0700 (PDT)
Date:   Thu, 11 Jun 2020 11:58:12 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200611105811.5q5rga2cmy6ypq7e@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <20200603094036.GF3070@suse.de>
 <20200603124112.w5stb7v2z3kzcze3@e107158-lin.cambridge.arm.com>
 <20200604134042.GJ3070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604134042.GJ3070@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/04/20 14:40, Mel Gorman wrote:
> On Wed, Jun 03, 2020 at 01:41:13PM +0100, Qais Yousef wrote:
> > > > netperf-udp
> > > >                                 ./5.7.0-rc7            ./5.7.0-rc7            ./5.7.0-rc7
> > > >                               without-clamp             with-clamp      with-clamp-tskgrp
> > > > 
> > > > Hmean     send-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> > > > Hmean     send-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> > > > Hmean     send-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> > > > Hmean     send-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> > > > Hmean     send-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.96 *   1.24%*
> > > > Hmean     send-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> > > > Hmean     send-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> > > > Hmean     send-8192     14961.77 (   0.00%)    14418.92 *  -3.63%*    14908.36 *  -0.36%*
> > > > Hmean     send-16384    25799.50 (   0.00%)    25025.64 *  -3.00%*    25831.20 *   0.12%*
> > > > Hmean     recv-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> > > > Hmean     recv-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> > > > Hmean     recv-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> > > > Hmean     recv-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> > > > Hmean     recv-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.95 *   1.24%*
> > > > Hmean     recv-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> > > > Hmean     recv-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> > > > Hmean     recv-8192     14961.61 (   0.00%)    14418.88 *  -3.63%*    14908.30 *  -0.36%*
> > > > Hmean     recv-16384    25799.39 (   0.00%)    25025.49 *  -3.00%*    25831.00 *   0.12%*
> > > > 
> > > > netperf-tcp
> > > >  
> > > > Hmean     64              818.65 (   0.00%)      812.98 *  -0.69%*      826.17 *   0.92%*
> > > > Hmean     128            1569.55 (   0.00%)     1555.79 *  -0.88%*     1586.94 *   1.11%*
> > > > Hmean     256            2952.86 (   0.00%)     2915.07 *  -1.28%*     2968.15 *   0.52%*
> > > > Hmean     1024          10425.91 (   0.00%)    10296.68 *  -1.24%*    10418.38 *  -0.07%*
> > > > Hmean     2048          17454.51 (   0.00%)    17369.57 *  -0.49%*    17419.24 *  -0.20%*
> > > > Hmean     3312          22509.95 (   0.00%)    22229.69 *  -1.25%*    22373.32 *  -0.61%*
> > > > Hmean     4096          25033.23 (   0.00%)    24859.59 *  -0.69%*    24912.50 *  -0.48%*
> > > > Hmean     8192          32080.51 (   0.00%)    31744.51 *  -1.05%*    31800.45 *  -0.87%*
> > > > Hmean     16384         36531.86 (   0.00%)    37064.68 *   1.46%*    37397.71 *   2.37%*
> > > > 
> > > > The diffs are smaller than on openSUSE Leap 15.1 and some of the
> > > > uclamp taskgroup results are better?
> > > > 
> > > 
> > > I don't see the stddev and coeff but these look close to borderline.
> > > Sure, they are marked with a * so it passed a significant test but it's
> > > still a very marginal difference for netperf. It's possible that the
> > > systemd configurations differ in some way that is significant for uclamp
> > > but I don't know what that is.
> > 
> > Hmm so what you're saying is that Dietmar didn't reproduce the same problem
> > you're observing? I was hoping to use that to dig more into it.
> > 
> 
> Not as such, I'm saying that for whatever reason the problem is not as
> visible with Dietmar's setup. It may be machine-specific or distribution
> specific. There are alternative suggestions for testing just the fast
> paths with a pipe test that may be clearer.

I have regained access to the same machine Dietmar ran his tests on. And I got
some weird results to share..

First I tried with `perf bench -r 20 sched pipe -T` command to identify the
cause of the overhead. And indeed I do see the activate/deactivate_task
overhead going up when uclamp is enabled

With uclamp run #1:

   2.44%  sched-pipe  [kernel.vmlinux]  [k] activate_task
   1.59%  sched-pipe  [kernel.vmlinux]  [k] deactivate_task

With uclamp run #2:

   4.55%  sched-pipe  [kernel.vmlinux]  [k] deactivate_task
   2.34%  sched-pipe  [kernel.vmlinux]  [k] activate_task

Without uclamp run #1:

   0.12%  sched-pipe  [kernel.vmlinux]  [k] activate_task
   0.11%  sched-pipe  [kernel.vmlinux]  [k] deactivate_task

Without uclamp run #2:

   0.11%  sched-pipe  [kernel.vmlinux]  [k] activate_task
   0.07%  sched-pipe  [kernel.vmlinux]  [k] deactivate_task

Looking at the annotation I see in the enqueue

  0.08 │ c5:   mov    %ecx,%esi                                                                                           ▒
  0.99 │       and    $0xfffff800,%r9d                                                                                    ▒
       │       and    $0x7ff,%eax                                                                                         ▒
       │       lea    0xd4(%rsi),%r13                                                                                     ▒
  0.10 │       or     %r9d,%eax                                                                                           ▒
       │     bucket->tasks++;                                                                                             ▒
  0.03 │       lea    (%rsi,%rsi,1),%r11                                                                                  ▒
       │     p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);                                                           ▒
  0.02 │       mov    %eax,0x358(%rbx,%rdi,4)                                                                             ▒
       │     bucket = &uc_rq->bucket[uc_se->bucket_id];                                                                   ▒
  0.02 │       movzbl 0x9(%rbx,%r13,4),%ecx                                                                               ▒
       │     bucket->tasks++;                                                                                             ▒
  0.74 │       add    %rsi,%r11                                                                                           ▒
       │     bucket = &uc_rq->bucket[uc_se->bucket_id];                                                                   ▒
  0.02 │       shr    $0x3,%cl                                                                                            ▒
       │     bucket->tasks++;                                                                                             ▒
       │       and    $0x7,%ecx                                                                                           ◆
  0.05 │       lea    0x8(%rcx,%r11,2),%rax                                                                               ▒
  3.52 │       addq   $0x800,0x8(%r12,%rax,8)                                                                             ▒
       │     uc_se->active = true;                                                                                        ▒
       │       orb    $0x40,0x9(%rbx,%r13,4)                                                                              ▒
       │     uclamp_idle_reset(rq, clamp_id, uc_se->value);                                                               ▒
 73.34 │       movzwl 0x8(%rbx,%r13,4),%eax                     <--- XXXXX                                                ▒
       │     uclamp_idle_reset():                                                                                         ▒
       │     if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))                                                                  ▒
       │       mov    0xa0(%r12),%r9d                                                                                     ▒
       │       mov    %r9d,%r10d                                                                                          ▒
       │     uclamp_rq_inc_id():                                                                                          ▒
       │     uclamp_idle_reset(rq, clamp_id, uc_se->value)

and at the dequeue

  0.07 │       mov    0x8(%rax),%ecx                                                                                      ▒
       │       test   %ecx,%ecx                                                                                           ▒
       │     ↑ je     60                                                                                                  ▒
  0.30 │       xor    %r14d,%r14d                                                                                         ▒
       │     uclamp_rq_dec_id():                                                                                          ▒
       │     bucket->tasks--;                                                                                             ▒
       │       mov    $0xfffffffffffff800,%r15                                                                            ▒
       │     bucket = &uc_rq->bucket[uc_se->bucket_id];                                                                   ▒
  0.07 │ 90:   mov    %r14d,%ecx                                                                                          ▒
       │       mov    %r14d,%r12d                                                                                         ▒
  0.04 │       lea    0xd4(%rcx),%rax                                                                                     ▒
 20.06 │       movzbl 0x9(%rsi,%rax,4),%r13d                     <--- XXXXX                                               ▒
       │     SCHED_WARN_ON(!bucket->tasks);                                                                               ▒
       │       lea    (%rcx,%rcx,1),%rax                                                                                  ▒
       │       add    %rcx,%rax                                                                                           ▒
       │     bucket = &uc_rq->bucket[uc_se->bucket_id];                                                                   ▒
  0.07 │       shr    $0x3,%r13b                                                                                          ▒
       │     SCHED_WARN_ON(!bucket->tasks);                                                                               ▒
  0.07 │       and    $0x7,%r13d                                                                                          ▒
  0.17 │       lea    0x8(%r13,%rax,2),%rax                                                                               ▒
 24.52 │       testq  $0xfffffffffffff800,0x8(%rbx,%rax,8)       <--- XXXXX                                               ▒
  0.34 │     ↓ je     172
.
.
.
  0.14 │       mov    %ecx,0x40(%rax)                                                                                     ▒
       │     ↑ jmpq   f8                                                                                                  ▒
  1.25 │250:   sub    $0x8,%rcx                                                                                           ▒
       │     uclamp_rq_max_value():                                                                                       ▒
       │     for ( ; bucket_id >= 0; bucket_id--) {                                                                       ▒
  4.97 │       cmp    %rcx,%rax                                                                                           ▒
       │     ↑ jne    22b                                                                                                 ▒
       │     uclamp_idle_value():                                                                                         ▒
       │     return uclamp_none(UCLAMP_MIN);                                                                              ▒
       │       xor    %ecx,%ecx                                                                                           ▒
       │     if (clamp_id == UCLAMP_MAX) {                                                                                ▒
  0.74 │       cmp    $0x1,%r14                                                                                           ▒
       │     ↑ jne    23d                                                                                                 ▒
       │     uclamp_rq_dec_id():                                                                                          ▒
       │     bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);                                                 ▒
 20.10 │       movzwl 0x35c(%rsi),%ecx                           <--- XXXXXX                                              ▒
       │     uclamp_idle_value():                                                                                         ▒
       │     rq->uclamp_flags |= UCLAMP_FLAG_IDLE;                                                                        ▒
       │       orl    $0x1,0xa0(%rbx)                                                                                     ▒
       │     uclamp_rq_dec_id():                                                                                          ▒
       │     bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);                                                 ▒
  0.14 │       and    $0x7ff,%ecx                                                                                         ▒
       │     ↑ jmp    23d


Which I interpreted as accesses to rq->uclamp[].bucket and p->uclamp[] structs.

The movzwl shanangians promoted me to remove the bitfields in case this is
causing some weird effect, and I shortend struct uclamp_bucket to reduce the
potential cache pressure to make it all fit in a single cache line


diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..7d0acf250573 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -601,10 +601,10 @@ struct sched_dl_entity {
  * default boost can still drop its own boosting to 0%.
  */
 struct uclamp_se {
-	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
-	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
-	unsigned int active		: 1;
-	unsigned int user_defined	: 1;
+	unsigned int value;
+	unsigned int bucket_id;
+	unsigned int active;
+	unsigned int user_defined;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..a1e7080c48e8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -833,8 +833,8 @@ extern void rto_push_irq_work_func(struct irq_work *work);
  * clamp value.
  */
 struct uclamp_bucket {
-	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
-	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
+	unsigned short value;
+	unsigned short tasks;
 };
 
 /*


This make the perf output look like this now

With patch run #1:

   1.34%  sched-pipe  [kernel.vmlinux]  [k] deactivate_task
   0.44%  sched-pipe  [kernel.vmlinux]  [k] activate_task

with patch run #2:

   2.41%  sched-pipe  [kernel.vmlinux]  [k] deactivate_task
   0.32%  sched-pipe  [kernel.vmlinux]  [k] activate_task


So it seems to help the activate_task path a lot, but not as much for the
deactivate_task path. Note that activate_task path was hotter than
deactivate_task without this patch.

Further, I have tried adding a static key like you suggested for psi

With static key disabling uclamp:

   0.13%  sched-pipe  [kernel.vmlinux]  [k] activate_task
   0.07%  sched-pipe  [kernel.vmlinux]  [k] deactivate_task



diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..1814baa95c81 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -84,6 +84,9 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
 extern int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				       void __user *buffer, size_t *lenp,
 				       loff_t *ppos);
+extern int sysctl_sched_uclamp_disabled(struct ctl_table *table, int write,
+				        void __user *buffer, size_t *lenp,
+				        loff_t *ppos);
 #endif
 
 extern int sysctl_numa_balancing(struct ctl_table *table, int write,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..8d932b3922c9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -793,6 +793,8 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
+DEFINE_STATIC_KEY_FALSE(sched_uclamp_disabled);
+
 /* Integer rounded range for each bucket */
 #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
 
@@ -1020,6 +1022,9 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	if (static_branch_likely(&sched_uclamp_disabled))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1035,6 +1040,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
 	enum uclamp_id clamp_id;
 
+	if (static_branch_likely(&sched_uclamp_disabled))
+		return;
+
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
@@ -1164,6 +1172,30 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	return result;
 }
 
+int sysctl_sched_uclamp_disabled(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table t;
+	int err;
+	int state = static_branch_likely(&sched_uclamp_disabled);
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	t = *table;
+	t.data = &state;
+	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
+	if (err < 0)
+		return err;
+	if (write) {
+		if (state)
+			static_branch_enable(&sched_uclamp_disabled);
+		else
+			static_branch_disable(&sched_uclamp_disabled);
+	}
+	return err;
+}
+
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..ef842cbf1f91 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -453,6 +453,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
+	{
+		.procname	= "sched_uclamp_disabled",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_disabled,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{



I stopped over here and decided to run with your netperf test to see what
effect this has, and this is where things gets weird.


Running with uclamp gives better results than without uclamp :-/


The nouclamp column is with uclamp disabled at the config level.

The '.disabled' postfix is uclamp disabled via sysctl patch (static key).

uclamp-opt is with the above patch that improved the D$ performance for perf
bench.

I ran uclamp and uclamp-opt with the static key patch applied. I ran them twice
as after noticing the nouclamp is worse than with uclamp I wanted to see how
the numbers differ between runs.

                                    nouclam               nouclamp                  uclam                 uclamp         uclamp.disable                 uclamp                 uclamp                 uclamp
                                   nouclamp              recompile                 uclamp                uclamp2        uclamp.disabled                    opt                   opt2           opt.disabled
Hmean     send-64         158.07 (   0.00%)      156.99 *  -0.68%*      163.83 *   3.65%*      160.97 *   1.83%*      163.93 *   3.71%*      159.62 *   0.98%*      161.79 *   2.36%*      161.14 *   1.94%*
Hmean     send-128        314.86 (   0.00%)      314.41 *  -0.14%*      329.05 *   4.51%*      322.88 *   2.55%*      327.88 *   4.14%*      317.56 *   0.86%*      320.72 *   1.86%*      319.62 *   1.51%*
Hmean     send-256        629.98 (   0.00%)      625.78 *  -0.67%*      652.67 *   3.60%*      639.98 *   1.59%*      643.99 *   2.22%*      631.96 *   0.31%*      635.75 *   0.92%*      644.10 *   2.24%*
Hmean     send-1024      2465.04 (   0.00%)     2452.29 *  -0.52%*     2554.66 *   3.64%*     2509.60 *   1.81%*     2540.71 *   3.07%*     2495.82 *   1.25%*     2490.50 *   1.03%*     2509.86 *   1.82%*
Hmean     send-2048      4717.57 (   0.00%)     4713.17 *  -0.09%*     4923.98 *   4.38%*     4811.01 *   1.98%*     4881.87 *   3.48%*     4793.82 *   1.62%*     4820.28 *   2.18%*     4824.60 *   2.27%*
Hmean     send-3312      7412.33 (   0.00%)     7433.42 *   0.28%*     7717.76 *   4.12%*     7522.97 *   1.49%*     7620.99 *   2.82%*     7522.89 *   1.49%*     7614.51 *   2.73%*     7568.51 *   2.11%*
Hmean     send-4096      9021.55 (   0.00%)     8988.71 *  -0.36%*     9337.62 *   3.50%*     9075.49 *   0.60%*     9258.34 *   2.62%*     9117.17 *   1.06%*     9175.85 *   1.71%*     9079.50 *   0.64%*
Hmean     send-8192     15370.36 (   0.00%)    15467.63 *   0.63%*    15999.52 *   4.09%*    15467.80 *   0.63%*    15978.69 *   3.96%*    15619.84 *   1.62%*    15395.09 *   0.16%*    15779.73 *   2.66%*
Hmean     send-16384    26512.35 (   0.00%)    26498.18 *  -0.05%*    26931.86 *   1.58%*    26513.18 *   0.00%*    26873.98 *   1.36%*    26456.38 *  -0.21%*    26467.77 *  -0.17%*    26975.04 *   1.75%*


Happy to try more things if you have any suggestions. I am getting a bit
stumped by the netperf results, but haven't tried to profile them. I might try
that but thought I'll report this first as it's time consuming.

Thanks

--
Qais Yousef
