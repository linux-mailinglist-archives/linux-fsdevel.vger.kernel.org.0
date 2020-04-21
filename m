Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EBA1B24FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDULX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 07:23:57 -0400
Received: from foss.arm.com ([217.140.110.172]:33512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDULX4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:23:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBA3CC14;
        Tue, 21 Apr 2020 04:23:55 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CFE03F73D;
        Tue, 21 Apr 2020 04:23:53 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:23:51 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200421112350.4hzqdc3vd3aen2ba@e107158-lin.cambridge.arm.com>
References: <20200403123020.13897-1-qais.yousef@arm.com>
 <20200414182152.GB20442@darkstar>
 <54ac2709-54e5-7a33-a6af-0a07e272365c@arm.com>
 <20200420151941.47ualxul5seqwdgh@e107158-lin.cambridge.arm.com>
 <20200420205210.7217651c@oasis.local.home>
 <1abbe4a5-61e6-a918-ff89-3dea0c7a277c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1abbe4a5-61e6-a918-ff89-3dea0c7a277c@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/21/20 13:16, Dietmar Eggemann wrote:
> On 21/04/2020 02:52, Steven Rostedt wrote:
> > On Mon, 20 Apr 2020 16:19:42 +0100
> > Qais Yousef <qais.yousef@arm.com> wrote:
> > 
> >>> root@h960:~# find / -name "*util_clamp*"
> >>> /proc/sys/kernel/sched_rt_default_util_clamp_min
> >>> /proc/sys/kernel/sched_util_clamp_max
> >>> /proc/sys/kernel/sched_util_clamp_min
> >>>
> >>> IMHO, keeping the common 'sched_util_clamp_' would be helpful here, e.g.
> >>>
> >>> /proc/sys/kernel/sched_util_clamp_rt_default_min  
> >>
> >> All RT related knobs are prefixed with 'sched_rt'. I kept the 'util_clamp_min'
> >> coherent with the current sysctl (sched_util_clamp_min). Quentin suggested
> >> adding 'default' to be more obvious, so I ended up with
> >>
> >> 	'sched_rt' + '_default' + '_util_clamp_min'.
> >>
> >> I think this is the logical and most consistent form. Given that Patrick seems
> >> to be okay with the 'default' now, does this look good to you too?
> > 
> > There's only two files with "sched_rt" and they are tightly coupled
> > (they define how much an RT task may use the CPU).
> > 
> > My question is, is this "sched_rt_default_util_clamp_min" related in
> > any way to those other two files that start with "sched_rt", or is it
> > more related to the files that start with "sched_util_clamp"?
> > 
> > If the latter, then I would suggest using
> > "sched_util_clamp_min_rt_default", as it looks to be more related to
> > the "sched_util_clamp_min" than to anything else.
> 
> For me it's the latter.

The way I see it is that 'sched_rt' define an rt class property. And running at
max performance level is an RT class property that uclamp honoured and has an
extra side effect that it allows us to tune.

That said, I'm fine with whatever.

Patrick, Quentin, is sched_util_clamp_min_rt_default fine with you too?

Thanks

--
Qais Yousef
