Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA513B473
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 22:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgANVeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 16:34:10 -0500
Received: from foss.arm.com ([217.140.110.172]:57628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANVeI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:34:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D492D1435;
        Tue, 14 Jan 2020 13:34:07 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7F3F3F534;
        Tue, 14 Jan 2020 13:34:05 -0800 (PST)
Date:   Tue, 14 Jan 2020 21:34:03 +0000
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
Message-ID: <20200114213403.cur6gydan6kmplqb@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108185650.GA9635@darkstar>
 <026e46e4-5d09-6260-0fa7-e365b0795c9a@arm.com>
 <20200109092137.GA2811@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109092137.GA2811@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/09/20 10:21, Patrick Bellasi wrote:
> That's not entirely true. In that patch we introduce cgroup support
> but, if you look at the code before that patch, for CFS tasks there is
> only:
>  - CFS task-specific values (min,max)=(0,1024) by default
>  - CFS system-wide tunables (min,max)=(1024,1024) by default
> and a change on the system-wide tunable allows for example to enforce
> a uclamp_max=200 on all tasks.
> 
> A similar solution can be implemented for RT tasks, where we have:
>  - RT task-specific values (min,max)=(1024,1024) by default
>  - RT system-wide tunables (min,max)=(1024,1024) by default
>  and a change on the system-wide tunable allows for example to enforce
>  a uclamp_min=200 on all tasks.

I feel I'm already getting lost in the complexity of the interaction here. Do
we really need to go that path?

So we will end up with a default system wide for all tasks + a CFS system wide
default + an RT system wide default?

As I understand it, we have a single system wide default now.

>  
> > (Would we need CONFIG_RT_GROUP_SCHED for this? IIRC there's a few pain points
> > when turning it on, but I think we don't have to if we just want things like
> > uclamp value propagation?)
> 
> No, the current design for CFS tasks works also on !CONFIG_CFS_GROUP_SCHED.
> That's because in this case:
>   - uclamp_tg_restrict() returns just the task requested value
>   - uclamp_eff_get() _always_ restricts the requested value considering
>     the system defaults
>  
> > It's quite more work than the simple thing Qais is introducing (and on both
> > user and kernel side).
> 
> But if in the future we will want to extend CGroups support to RT then
> we will feel the pains because we do the effective computation in two
> different places.

Hmm what you're suggesting here is that we want to have
cpu.rt.uclamp.{min,max}? I'm not sure I can agree this is a good idea.

It makes more sense to create a special group for all rt tasks rather than
treat rt tasks in a cgroup differently.

> 
> Do note that a proper CGroup support requires that the system default
> values defines the values for the root group and are consistently
> propagated down the hierarchy. Thus we need to add a dedicated pair of
> cgroup attributes, e.g. cpu.util.rt.{min.max}.
> 
> To recap, we don't need CGROUP support right now but just to add a new
> default tracking similar to what we do for CFS.
> 
> We already proposed such a support in one of the initial versions of
> the uclamp series:
>    Message-ID: <20190115101513.2822-10-patrick.bellasi@arm.com>
>    https://lore.kernel.org/lkml/20190115101513.2822-10-patrick.bellasi@arm.com/

IIUC what you're suggesting is:

	1. Use the sysctl to specify the default_rt_uclamp_min
	2. Enforce this value in uclamp_eff_get() rather than my sync logic
	3. Remove the current hack to always set
	   rt_task->uclamp_min = uclamp_none(UCLAMP_MAX)

If I got it correctly I'd be happy to experiment with it if this is what
you're suggesting. Otherwise I'm afraid I'm failing to see the crust of the
problem you're trying to highlight.

Thanks

--
Qais Yousef
