Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0C1388C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 00:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgALXfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jan 2020 18:35:34 -0500
Received: from foss.arm.com ([217.140.110.172]:33038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgALXfe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jan 2020 18:35:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FB7B30E;
        Sun, 12 Jan 2020 15:35:31 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F7D13F534;
        Sun, 12 Jan 2020 15:35:29 -0800 (PST)
Date:   Sun, 12 Jan 2020 23:35:27 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, qperret@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200112233526.wmrq5i6hqqez4oby@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108134448.GG2844@hirez.programming.kicks-ass.net>
 <20200109130052.feebuwuuvwvm324w@e107158-lin.cambridge.arm.com>
 <20200110133956.GL2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110133956.GL2844@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/10/20 14:39, Peter Zijlstra wrote:
> On Thu, Jan 09, 2020 at 01:00:58PM +0000, Qais Yousef wrote:
> > On 01/08/20 14:44, Peter Zijlstra wrote:
> > > On Fri, Dec 20, 2019 at 04:48:38PM +0000, Qais Yousef wrote:
> > > > RT tasks by default try to run at the highest capacity/performance
> > > > level. When uclamp is selected this default behavior is retained by
> > > > enforcing the uclamp_util_min of the RT tasks to be
> > > > uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> > > > value.
> > > > 
> > > > See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> > > > 
> > > > On battery powered devices, this default behavior could consume more
> > > > power, and it is desired to be able to tune it down. While uclamp allows
> > > > tuning this by changing the uclamp_util_min of the individual tasks, but
> > > > this is cumbersome and error prone.
> > > > 
> > > > To control the default behavior globally by system admins and device
> > > > integrators, introduce the new sysctl_sched_rt_uclamp_util_min to
> > > > change the default uclamp_util_min value of the RT tasks.
> > > > 
> > > > Whenever the new default changes, it'd be applied on the next wakeup of
> > > > the RT task, assuming that it still uses the system default value and
> > > > not a user applied one.
> > > 
> > > This is because these RT tasks are not in a cgroup or not affected by
> > > cgroup settings? I feel the justification is a little thin here.
> > 
> > The uclamp_min for RT tasks is always hardcoded to 1024 at the moment. So even
> > if they belong to a cgroup->uclamp_min = 0, they'll still run at max frequency,
> > no?
> 
> Argh, this is that counter intuitive max aggregate nonsense biting me.

Yeah I thought we already have a mechanism to control this, until you try to do
it then you find out we don't. Not conveniently at least.

Are you okay with the sysctl to tune this behavior then?

Thanks

--
Qais Yousef
