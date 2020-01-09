Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60A135812
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 12:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgAILga (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 06:36:30 -0500
Received: from foss.arm.com ([217.140.110.172]:57584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgAILga (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:36:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0A0831B;
        Thu,  9 Jan 2020 03:36:27 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A80053F703;
        Thu,  9 Jan 2020 03:36:25 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:36:23 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200109113623.jk4yth6koyq2wwh7@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200107134234.GA158998@google.com>
 <8bb17e84-d43f-615f-d04d-c36bb6ede5e0@arm.com>
 <20200108095108.GA153171@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108095108.GA153171@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/08/20 09:51, Quentin Perret wrote:
> On Tuesday 07 Jan 2020 at 20:30:36 (+0100), Dietmar Eggemann wrote:
> > On 07/01/2020 14:42, Quentin Perret wrote:
> > > Hi Qais,
> > > 
> > > On Friday 20 Dec 2019 at 16:48:38 (+0000), Qais Yousef wrote:
> > 
> > [...]
> > 
> > >> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > >> index e591d40fd645..19572dfc175b 100644
> > >> --- a/kernel/sched/rt.c
> > >> +++ b/kernel/sched/rt.c
> > >> @@ -2147,6 +2147,12 @@ static void pull_rt_task(struct rq *this_rq)
> > >>   */
> > >>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
> > >>  {
> > >> +	/*
> > >> +	 * When sysctl_sched_rt_uclamp_util_min value is changed by the user,
> > >> +	 * we apply any new value on the next wakeup, which is here.
> > >> +	 */
> > >> +	uclamp_rt_sync_default_util_min(p);
> > > 
> > > The task has already been enqueued and sugov has been called by then I
> > > think, so this is a bit late. You could do that in uclamp_rq_inc() maybe?
> > 
> > That's probably better.
> > Just to be sure ...we want this feature (an existing rt task gets its
> > UCLAMP_MIN value set when the sysctl changes) because there could be rt
> > tasks running before the sysctl is set?
> 
> Yeah, I was wondering the same thing, but I'd expect sysadmin to want
> this. We could change the min clamp of existing RT tasks in userspace
> instead, but given how simple Qais' lazy update code is, the in-kernel
> looks reasonable to me. No strong opinion, though.

The way I see this being used is set in init.rc. If any RT tasks were created
(most likely kthreads) before that they'll just be updated on the next
wakeup.

Of course this approach allows the value to change any point of time when the
system is running without having to do a reboot/recompile or kick a special
script/app to modify all existing RT tasks and continuously monitor new ones.

Another advantage is that apps that have special requirement (like professional
audio) can use the per-task uclamp API to bump their uclamp_min without
conflicting with the desired generic value for all other RT tasks.

IOW, we can easily at run time control the baseline performance for RT tasks
with a single knob without interfering with RT tasks that opt-in to modify
their own uclamp values.

--
Qais Yousef
