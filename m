Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03C21E67D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405212AbgE1Qvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 12:51:38 -0400
Received: from foss.arm.com ([217.140.110.172]:55284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405162AbgE1Qvg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 12:51:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AB8030E;
        Thu, 28 May 2020 09:51:36 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82DA13F6C4;
        Thu, 28 May 2020 09:51:33 -0700 (PDT)
Date:   Thu, 28 May 2020 17:51:31 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528161112.GI2483@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/28/20 18:11, Peter Zijlstra wrote:
> On Thu, May 28, 2020 at 04:58:01PM +0100, Qais Yousef wrote:
> > On 05/28/20 15:23, Peter Zijlstra wrote:
> 
> > > So afaict this is directly added to the enqueue/dequeue path, and we've
> > > recently already had complaints that uclamp is too slow.
> > 
> > I wanted to keep this function simpler.
> 
> Right; I appreciate that, but as always it's a balance between simple
> and performance :-)

Sure :-)

In my head, the simpler version of

	if (rt_task(p) && !uc->user_defined)
		// update_uclamp_min

Is a single branch and write to cache, so should be fast. I'm failing to see
how this could generate an overhead tbh, but will not argue about it :-)

> 
> > > Is there really no other way?
> > 
> > There is my first attempt which performs the sync @ task_woken_rt().
> > 
> > https://lore.kernel.org/lkml/20191220164838.31619-1-qais.yousef@arm.com/
> > 
> > I can revert the sync function to the simpler version defined in that patch
> > too.
> > 
> > I can potentially move this to uclamp_eff_value() too. Will need to think more
> > if this is enough. If task_woken_rt() is good for you, I'd say that's more
> > obviously correct and better to go with it.
> 
> task_woken_rt() is better, because that only slows down RT tasks, but
> I'm thinking we can do even better by simply setting the default such
> that new tasks pick it up and then (rcu) iterating all existing tasks
> and modiying them.
> 
> It's more code, but it is all outside of the normal paths where we care
> about performance.

I am happy to take that direction if you think it's worth it. I'm thinking
task_woken_rt() is good. But again, maybe I am missing something.

> 
> > FWIW, I think you're referring to Mel's notice in OSPM regarding the overhead.
> > Trying to see what goes on in there.
> 
> Indeed, that one. The fact that regular distros cannot enable this
> feature due to performance overhead is unfortunate. It means there is a
> lot less potential for this stuff.

I had a humble try to catch the overhead but wasn't successful. The observation
wasn't missed by us too then.

On my Ubuntu 18.04 machine uclamp is enabled by default by the way. 5.3 kernel
though, so uclamp task group stuff not there yet. Should check how their server
distro looks like.

We don't want to lose that potential!

Thanks

--
Qais Yousef
