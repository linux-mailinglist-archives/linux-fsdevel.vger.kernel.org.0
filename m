Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669D347D08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhCXPxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:53:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:36888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236733AbhCXPwf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:52:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A54D0AD9F;
        Wed, 24 Mar 2021 15:52:27 +0000 (UTC)
Date:   Wed, 24 Mar 2021 15:52:24 +0000
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
Message-ID: <20210324155224.GR15768@suse.de>
References: <20210323035706.572953-1-joshdon@google.com>
 <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
 <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
 <20210324114224.GP15768@suse.de>
 <YFssoD5NDl6dFfg/@hirez.programming.kicks-ass.net>
 <20210324133916.GQ15768@suse.de>
 <YFtOXpl1vWp47Qud@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YFtOXpl1vWp47Qud@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:36:14PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 24, 2021 at 01:39:16PM +0000, Mel Gorman wrote:
> 
> > > Yeah, lets say I was pleasantly surprised to find it there :-)
> > > 
> > 
> > Minimally, lets move that out before it gets kicked out. Patch below.
> 
> OK, stuck that in front.
> 

Thanks.

> > > > Moving something like sched_min_granularity_ns will break a number of
> > > > tuning guides as well as the "tuned" tool which ships by default with
> > > > some distros and I believe some of the default profiles used for tuned
> > > > tweak kernel.sched_min_granularity_ns
> > > 
> > > Yeah, can't say I care. I suppose some people with PREEMPT=n kernels
> > > increase that to make their server workloads 'go fast'. But I'll
> > > absolutely suck rock on anything desktop.
> > > 
> > 
> > Broadly speaking yes and despite the lack of documentation, enough people
> > think of that parameter when tuning for throughput vs latency depending on
> > the expected use of the machine.  kernel.sched_wakeup_granularity_ns might
> > get tuned if preemption is causing overscheduling. Same potentially with
> > kernel.sched_min_granularity_ns and kernel.sched_latency_ns. That said, I'm
> > struggling to think of an instance where I've seen tuning recommendations
> > properly quantified other than the impact on microbenchmarks but I
> > think there will be complaining if they disappear. I suspect that some
> > recommended tuning is based on "I tried a number of different values and
> > this seemed to work reasonably well".
> 
> Right, except that due to that scaling thing, you'd have to re-evaluate
> when you change machine.
> 

Yes although in practice I've rarely seen that happen. What I have seen
is tuning parameters being copied across machines or kernel versions that
turned out to be the source of the "regression" because something changed
in the scheduler that invalidated the tuning.

> Also, do you have any inclination on the perf difference we're talking
> about? (I should probably ask Google and not you...)
> 

I don't have good data on hand and I don't trust Google for performance
data. However, I know for certain that there are "Enterprise Applications"
whose tuning relies on modifying kernel.sched_min_granularity_ns and
kernel.sched_wakeup_granularity_ns at the very least (might be others,
I'd have to check). The issue was severe enough to fail acceptance testing
for OS upgrades and it generated bugs.

I did not see the raw data but even if I had, it would have been based on
a battery of tests across multiple platforms and generations so at best I
would have a vague range. For the vendors in question, it is unlikely they
would release detailed information because it can be seen as commercially
sensitive. I don't really agree that this is useful behaviour but it is
the reality so don't shoot the messenger :(

The last I checked, hackbench figures could be changed in the 10-15%
range either direction depending on group counts but in itself, that is
not useful.

> > kernel.sched_schedstats probably should not depend in SCHED_DEBUG because
> > it has value for workload analysis which is not necessarily about debugging
> > per-se. It might simply be informing whether another variable should be
> > tuned or useful for debugging applications rather than the kernel.
> 
> Dubious, if you're that far down the rabit hole, you're dang near
> debugging.
> 

Yes, but not necessarily the kernel. For example, the workload analysis
might be to see if the maximum number of threads in a worker pool should
be tuned (either up or down).

> > As an aside, I wonder how often SCHED_DEBUG has been enabled simply
> > because LATENCYTOP selects it -- no idea offhand why LATENCYTOP even
> > needs SCHED_DEBUG.
> 
> Perhaps schedstats used to rely on debug? I can't remember. I don't
> think I've used latencytop in at least 10 years. ftrace and perf sorta
> killed the need for it.
> 

I don't think schedstats used to rely on SCHED_DEBUG. LATENCYTOP appears
to build even if SCHED_DEBUG is disabled so it was either was an
accident or it's no longer necessary.

> > > These knobs really shouldn't have been as widely available as they are.
> > > 
> > 
> > Probably not. Worse, some of the tuning is probably based on "this worked
> > for workload X 10 years ago so I'll just keep doing that"
> 
> That sounds like an excellent reason to disrupt ;-)
> 

The same logic applies for all tuning unfortunately :P

> > > > Whether there are legimiate reasons to modify those values or not,
> > > > removing them may generate fun bug reports.
> > > 
> > > Which I'll close with -EDONTCARE, userspace has to cope with
> > > SCHED_DEBUG=n in any case.
> > 
> > True but removing the throughput vs latency parameters is likely to
> > generate a lot of noise even if the reasons for tuning are bad ones.
> > Some definitely should not be depending on SCHED_DEBUG, others may
> > need to be moved to debugfs one patch at a time so they can be reverted
> > individually if complaining is excessive and there is a legiminate reason
> > why it should be tuned. It's possible that complaining will be based on
> > a workload regression that really depended on tuned changing parameters.
> 
> The way I've done it, you can simply re-instate the systl table entry
> and it'll work again, except for the entries that had a custom handler.
> 

True.

> I'm ready to disrupt :-)

I'm not going to NAK because I do not have hard data that shows they must
exist. However, I won't ACK either because I bet a lot of tasty beverages
the next time we meet that the following parameters will generate reports
if removed.

kernel.sched_latency_ns
kernel.sched_migration_cost_ns
kernel.sched_min_granularity_ns
kernel.sched_wakeup_granularity_ns

I know they are altered by tuned for different profiles and some people do
go the effort to create custom profiles for specific applications. They
also show up in "Official Benchmarking" such as SPEC CPU 2017 and
some vendors put a *lot* of effort into SPEC CPU results for bragging
rights. They show up in technical books and best practice guids for
applications.  Finally they show up in Google when searching for "tuning
sched_foo". I'm not saying that any of these are even accurate or a good
idea, just that they show up near the top of the results and they are
sufficiently popular that they might as well be an ABI.

kernel.sched_latency_ns
 https://www.scylladb.com/2016/06/10/read-latency-and-scylla-jmx-process/
 https://github.com/tikv/tikv/issues/2473

kernel.sched_migration_cost_ns
 https://developer.ibm.com/technologies/systems/tutorials/postgresql-experiences-tuning-recomendations-linux-on-ibm-z/
 https://hunleyd.github.io/posts/tuned-PG-and-you/
 https://www.postgresql.org/message-id/50E4AAB1.9040902@optionshouse.com

kernel.sched_min_granularity_ns
https://community.mellanox.com/s/article/rivermax-linux-performance-tuning-guide--1-x

kernel.sched_wakeup_granularity_ns
https://www.droidviews.com/boost-performance-on-android-kernels-task-scheduler-part-1/

-- 
Mel Gorman
SUSE Labs
