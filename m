Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E111453FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 12:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAVLpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 06:45:46 -0500
Received: from foss.arm.com ([217.140.110.172]:55452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgAVLpo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:45:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545001FB;
        Wed, 22 Jan 2020 03:45:44 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F0CF3F52E;
        Wed, 22 Jan 2020 03:45:42 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:45:39 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        qperret@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200122114539.jbk6txpbezva2swv@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108185650.GA9635@darkstar>
 <026e46e4-5d09-6260-0fa7-e365b0795c9a@arm.com>
 <20200109092137.GA2811@darkstar>
 <20200114213403.cur6gydan6kmplqb@e107158-lin.cambridge.arm.com>
 <20200122101944.GA12533@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200122101944.GA12533@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/22/20 11:19, Patrick Bellasi wrote:
> On 14-Jan 21:34, Qais Yousef wrote:
> > On 01/09/20 10:21, Patrick Bellasi wrote:
> > > That's not entirely true. In that patch we introduce cgroup support
> > > but, if you look at the code before that patch, for CFS tasks there is
> > > only:
> > >  - CFS task-specific values (min,max)=(0,1024) by default
> > >  - CFS system-wide tunables (min,max)=(1024,1024) by default
> > > and a change on the system-wide tunable allows for example to enforce
> > > a uclamp_max=200 on all tasks.
> > > 
> > > A similar solution can be implemented for RT tasks, where we have:
> > >  - RT task-specific values (min,max)=(1024,1024) by default
> > >  - RT system-wide tunables (min,max)=(1024,1024) by default
> > >  and a change on the system-wide tunable allows for example to enforce
> > >  a uclamp_min=200 on all tasks.
> > 
> > I feel I'm already getting lost in the complexity of the interaction here. Do
> > we really need to go that path?
> > 
> > So we will end up with a default system wide for all tasks + a CFS system wide
> > default + an RT system wide default?
> > 
> > As I understand it, we have a single system wide default now.
> 
> Right now we have one system wide default and that's both for all
> CFS/RT tasks, when cgroups are not in use, or for root group and
> autogroup CFS/RT tasks, when cgroups are in use.
> 
> What I'm proposing is to limit the usage of the current system wide
> default to CFS tasks only, while we add a similar new one specifically
> for RT tasks.

This change of behavior will be user-visible. I doubt anyone depends on it yet,
so if we want to change it now is the time.

The main issue I see here is that the system wide are *always* enforced. They
guarantee a global restriction. Which you're proposing to split into CFS and RT
system wide global restrictions.

But what I am proposing here is setting the *default* fork value of RT uclamp
min. Which is currently hardcoded to uclamp_none(UCLAMP_MAX) = 1024.

I think the 2 concepts are different to a system wide RT control. Or I am still
confused about your vision of how this should really work. I don't see how what
you propose could solve my problem.

For example:

	sysctl_sched_uclamp_util_min = 1024

means that tasks can set their uclamp_min to [0:1024], but

	sysctl_sched_uclamp_util_min = 800

means that tasks can set their uclamp_min to [0:800]

Which when splitting this to CFS and RT controls, they'd still mean control
the possible range the tasks can use.

But what I want here is that

	sysctl_sched_rt_default_uclamp_util_min = 800

Will set p->uclamp_min = 800 when a new RT task is forked and will stay like
this until the user modifies it. And update all current RT tasks that are still
using the default value to the new one when ever this changes.

If this value is outside the system wide allowed range; it'll be clamped
correctly by uclamp_eff_get().

Note that the default fork values for CFS are (0, 1024) and we don't have a way
to change this at the moment. Can be easily done if someone comes up with a use
case for it.

> 
> At the end we will have two system wide defaults, not three.
> 
> > > > (Would we need CONFIG_RT_GROUP_SCHED for this? IIRC there's a few pain points
> > > > when turning it on, but I think we don't have to if we just want things like
> > > > uclamp value propagation?)
> > > 
> > > No, the current design for CFS tasks works also on !CONFIG_CFS_GROUP_SCHED.
> > > That's because in this case:
> > >   - uclamp_tg_restrict() returns just the task requested value
> > >   - uclamp_eff_get() _always_ restricts the requested value considering
> > >     the system defaults
> > >  
> > > > It's quite more work than the simple thing Qais is introducing (and on both
> > > > user and kernel side).
> > > 
> > > But if in the future we will want to extend CGroups support to RT then
> > > we will feel the pains because we do the effective computation in two
> > > different places.
> > 
> > Hmm what you're suggesting here is that we want to have
> > cpu.rt.uclamp.{min,max}? I'm not sure I can agree this is a good idea.
> 
> That's exactly what we already do for other controllers. For example,
> if you look at the bandwidth controller, we have separate knobs for
> CFS and RT tasks.
> 
> > It makes more sense to create a special group for all rt tasks rather than
> > treat rt tasks in a cgroup differently.
> 
> Don't see why that should make more sense. This can work of course but
> it would enforce a more strict configuration and usage of cgroups to
> userspace.

It makes sense to me because cgroups offer a logical separation, and if tasks
within the same group need to be treated differently then they're logically
separated and need to be grouped differently consequently.

The uclamp values are not RT only properties.

I can see the convenience of doing it the way you propose though. Not sure
I agree about the added complexity worth it.

> 
> I also have some doubths about this approach matching the delegation
> model principles.

I don't know about that TBH.

> 
> > > Do note that a proper CGroup support requires that the system default
> > > values defines the values for the root group and are consistently
> > > propagated down the hierarchy. Thus we need to add a dedicated pair of
> > > cgroup attributes, e.g. cpu.util.rt.{min.max}.
> > > 
> > > To recap, we don't need CGROUP support right now but just to add a new
> > > default tracking similar to what we do for CFS.
> > >
> > > We already proposed such a support in one of the initial versions of
> > > the uclamp series:
> > >    Message-ID: <20190115101513.2822-10-patrick.bellasi@arm.com>
> > >    https://lore.kernel.org/lkml/20190115101513.2822-10-patrick.bellasi@arm.com/
> > 
> > IIUC what you're suggesting is:
> > 
> > 	1. Use the sysctl to specify the default_rt_uclamp_min
> > 	2. Enforce this value in uclamp_eff_get() rather than my sync logic
> > 	3. Remove the current hack to always set
> > 	   rt_task->uclamp_min = uclamp_none(UCLAMP_MAX)
> 
> Right, that's the essence...
> 
> > If I got it correctly I'd be happy to experiment with it if this is what
> > you're suggesting. Otherwise I'm afraid I'm failing to see the crust of the
> > problem you're trying to highlight.
> 
> ... from what your write above I think you got it right.
> 
> In my previous posting:
> 
>    Message-ID: <20200109092137.GA2811@darkstar>
>    https://lore.kernel.org/lkml/20200109092137.GA2811@darkstar/
> 
> there is also the code snippet which should be good enough to extend
> uclamp_eff_get(). Apart from that, what remains is:

I still have my doubts this will achieve what I want, but hopefully will have
time to experiment with this today. My worry is that this function enforces
restrictions, but what I want to do is set a default. I still can't see how
they are the same; which your answers hints they are.

> - to add the two new sysfs knobs for sysctl_sched_uclamp_util_{min,max}_rt

See my answer above.

> - make a call about how rt tasks in cgroups are clamped, a simple
>   proposal is in the second snippet of my message above.

I'm not keen on changing how this works and it is outside of the scope of this
patch anyway. Or at least I don't see how they are related yet.

Thanks!

--
Qais Yousef
