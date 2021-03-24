Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDD3479C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 14:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhCXNjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 09:39:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235433AbhCXNjV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:39:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAB34AB8A;
        Wed, 24 Mar 2021 13:39:19 +0000 (UTC)
Date:   Wed, 24 Mar 2021 13:39:16 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <20210324133916.GQ15768@suse.de>
References: <20210323035706.572953-1-joshdon@google.com>
 <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
 <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
 <20210324114224.GP15768@suse.de>
 <YFssoD5NDl6dFfg/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YFssoD5NDl6dFfg/@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 01:12:16PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 24, 2021 at 11:42:24AM +0000, Mel Gorman wrote:
> > On Wed, Mar 24, 2021 at 11:54:24AM +0100, Peter Zijlstra wrote:
> > > On Wed, Mar 24, 2021 at 10:37:43AM +0100, Peter Zijlstra wrote:
> > > > Should we perhaps take out all SCHED_DEBUG sysctls and move them to
> > > > /debug/sched/ ? (along with the existing /debug/sched_{debug,features,preemp}
> > > > files)
> > > > 
> > > > Having all that in sysctl and documented gives them far too much sheen
> > > > of ABI.
> > > 
> > > ... a little something like this ...
> > > 
> > 
> > I did not read this particularly carefully or boot it to check but some
> > of the sysctls moved are expected to exist and should never should have
> > been under SCHED_DEBUG.
> > 
> > For example, I'm surprised that numa_balancing is under the SCHED_DEBUG
> > sysctl because there are legimiate reasons to disable that at runtime.
> > For example, HPC clusters running various workloads may disable NUMA
> > balancing globally for particular jobs without wanting to reboot and
> > reenable it when finished.
> 
> Yeah, lets say I was pleasantly surprised to find it there :-)
> 

Minimally, lets move that out before it gets kicked out. Patch below.

> > Moving something like sched_min_granularity_ns will break a number of
> > tuning guides as well as the "tuned" tool which ships by default with
> > some distros and I believe some of the default profiles used for tuned
> > tweak kernel.sched_min_granularity_ns
> 
> Yeah, can't say I care. I suppose some people with PREEMPT=n kernels
> increase that to make their server workloads 'go fast'. But I'll
> absolutely suck rock on anything desktop.
> 

Broadly speaking yes and despite the lack of documentation, enough people
think of that parameter when tuning for throughput vs latency depending on
the expected use of the machine.  kernel.sched_wakeup_granularity_ns might
get tuned if preemption is causing overscheduling. Same potentially with
kernel.sched_min_granularity_ns and kernel.sched_latency_ns. That said, I'm
struggling to think of an instance where I've seen tuning recommendations
properly quantified other than the impact on microbenchmarks but I
think there will be complaining if they disappear. I suspect that some
recommended tuning is based on "I tried a number of different values and
this seemed to work reasonably well".

kernel.sched_schedstats probably should not depend in SCHED_DEBUG because
it has value for workload analysis which is not necessarily about debugging
per-se. It might simply be informing whether another variable should be
tuned or useful for debugging applications rather than the kernel.

The others I'm less concerned with. kernel.sched_tunable_scaling is very
specific. sysctl_sched_migration_cost is subtle because it affects lots
of things including whether tasks are cache hot and load balancing and
is best left alone. I wonder how many people can accurately predict how
workloads will behave when that is tuned? sched_nr_migrate is also a hard
one to tune in a sensible fashion.

As an aside, I wonder how often SCHED_DEBUG has been enabled simply
because LATENCYTOP selects it -- no idea offhand why LATENCYTOP even
needs SCHED_DEBUG.

> These knobs really shouldn't have been as widely available as they are.
> 

Probably not. Worse, some of the tuning is probably based on "this worked
for workload X 10 years ago so I'll just keep doing that"

> And guides, well, the writes have to earn a living too, right.
> 

For most of the guides I've seen they either specify values without
explaining why or just describe roughly what the parameter does and it's
not always that accurate a description.

> > Whether there are legimiate reasons to modify those values or not,
> > removing them may generate fun bug reports.
> 
> Which I'll close with -EDONTCARE, userspace has to cope with
> SCHED_DEBUG=n in any case.

True but removing the throughput vs latency parameters is likely to
generate a lot of noise even if the reasons for tuning are bad ones.
Some definitely should not be depending on SCHED_DEBUG, others may
need to be moved to debugfs one patch at a time so they can be reverted
individually if complaining is excessive and there is a legiminate reason
why it should be tuned. It's possible that complaining will be based on
a workload regression that really depended on tuned changing parameters.

Anyway, I definitely want to save kernel.numa_balancing from the firing
line so....

--8<--
sched/numa: Allow runtime enabling/disabling of NUMA balance without SCHED_DEBUG

From: Mel Gorman <mgorman@suse.de>

The ability to enable/disable NUMA balancing is not a debugging feature
and should not depend on CONFIG_SCHED_DEBUG.  For example, machines within
a HPC cluster may disable NUMA balancing temporarily for some jobs and
re-enable it for other jobs without needing to reboot.

This patch removes the dependency on CONFIG_SCHED_DEBUG for
kernel.numa_balancing sysctl. The other numa balancing related sysctls
are left as-is because if they need to be tuned then it is more likely
that NUMA balancing needs to be fixed instead.

Signed-off-by: Mel Gorman <mgorman@suse.de>
---
 kernel/sysctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09b5dc1..8042098ae080 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1753,6 +1753,9 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+#endif /* CONFIG_NUMA_BALANCING */
+#endif /* CONFIG_SCHED_DEBUG */
+#ifdef CONFIG_NUMA_BALANCING
 	{
 		.procname	= "numa_balancing",
 		.data		= NULL, /* filled in by handler */
@@ -1763,7 +1766,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_SCHED_DEBUG */
 	{
 		.procname	= "sched_rt_period_us",
 		.data		= &sysctl_sched_rt_period,
