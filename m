Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB41C5A31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgEEO4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 10:56:43 -0400
Received: from foss.arm.com ([217.140.110.172]:42444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgEEO4n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 10:56:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C7AA1FB;
        Tue,  5 May 2020 07:56:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB0CE3F68F;
        Tue,  5 May 2020 07:56:39 -0700 (PDT)
Date:   Tue, 5 May 2020 15:56:37 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <derkling@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Documentation/sysctl: Document uclamp sysctl knobs
Message-ID: <20200505145637.5daqhatsm5bjsok7@e107158-lin.cambridge.arm.com>
References: <20200501114927.15248-1-qais.yousef@arm.com>
 <20200501114927.15248-2-qais.yousef@arm.com>
 <87d07krjyk.derkling@matbug.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d07krjyk.derkling@matbug.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Patrick

On 05/03/20 19:45, Patrick Bellasi wrote:
> > +sched_util_clamp_min:
> > +=====================
> > +
> > +Max allowed *minimum* utilization.
> > +
> > +Default value is SCHED_CAPACITY_SCALE (1024), which is the maximum possible
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Mmm... I feel one of the two is an implementation detail which should
> probably not be exposed?
> 
> The user perhaps needs to know the value (1024) but we don't need to
> expose the internal representation.

Okay.

> 
> 
> > +value.
> > +
> > +It means that any requested uclamp.min value cannot be greater than
> > +sched_util_clamp_min, i.e., it is restricted to the range
> > +[0:sched_util_clamp_min].
> > +
> > +sched_util_clamp_max:
> > +=====================
> > +
> > +Max allowed *maximum* utilization.
> > +
> > +Default value is SCHED_CAPACITY_SCALE (1024), which is the maximum possible
> > +value.
> > +
> > +It means that any requested uclamp.max value cannot be greater than
> > +sched_util_clamp_max, i.e., it is restricted to the range
> > +[0:sched_util_clamp_max].
> > +
> > +sched_util_clamp_min_rt_default:
> > +================================
> > +
> > +By default Linux is tuned for performance. Which means that RT tasks always run
> > +at the highest frequency and most capable (highest capacity) CPU (in
> > +heterogeneous systems).
> > +
> > +Uclamp achieves this by setting the requested uclamp.min of all RT tasks to
> > +SCHED_CAPACITY_SCALE (1024) by default, which effectively boosts the tasks to
> > +run at the highest frequency and biases them to run on the biggest CPU.
> > +
> > +This knob allows admins to change the default behavior when uclamp is being
> > +used. In battery powered devices particularly, running at the maximum
> > +capacity and frequency will increase energy consumption and shorten the battery
> > +life.
> > +
> > +This knob is only effective for RT tasks which the user hasn't modified their
> > +requested uclamp.min value via sched_setattr() syscall.
> > +
> > +This knob will not escape the constraint imposed by sched_util_clamp_min
> > +defined above.
> 
> Perhaps it's worth to specify that this value is going to be clamped by
> the values above? Otherwise it's a bit ambiguous to know what happen
> when it's bigger than schedu_util_clamp_min.

Hmm for me that sentence says exactly what you're asking for.

So what you want is

	s/will not escape the constraint imposed by/will be clamped by/

?

I'm not sure if this will help if the above is already ambiguous. Maybe if
I explicitly say

	..will not escape the *range* constrained imposed by..

sched_util_clamp_min is already defined as a range constraint, so hopefully it
should hit the mark better now?

> 
> > +Any modification is applied lazily on the next opportunity the scheduler needs
> > +to calculate the effective value of uclamp.min of the task.
>                     ^^^^^^^^^
> 
> This is also an implementation detail, I would remove it.

The idea is that this value is not updated 'immediately'/synchronously. So
currently RUNNING tasks will not see the effect, which could generate confusion
when users trip over it. IMO giving an idea of how it's updated will help with
expectation of the users. I doubt any will care, but I think it's an important
behavior element that is worth conveying and documenting. I'd be happy to
reword it if necessary.

I have this now

"""
 984 This knob will not escape the range constraint imposed by sched_util_clamp_min
 985 defined above.
 986
 987 For example if
 988
 989         sched_util_clamp_min_rt_default = 800
 990         sched_util_clamp_min = 600
 991
 992 Then the boost will be clamped to 600 because 800 is outside of the permissible
 993 range of [0:600]. This could happen for instance if a powersave mode will
 994 restrict all boosts temporarily by modifying sched_util_clamp_min. As soon as
 995 this restriction is lifted, the requested sched_util_clamp_min_rt_default
 996 will take effect.
 997
 998 Any modification is applied lazily to currently running tasks and should be
 999 visible by the next wakeup.
"""

Thanks

--
Qais Yousef
