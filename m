Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBB1E8306
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgE2QEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 12:04:31 -0400
Received: from foss.arm.com ([217.140.110.172]:38674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgE2QEb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 12:04:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 094EF55D;
        Fri, 29 May 2020 09:04:30 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519713F718;
        Fri, 29 May 2020 09:04:27 -0700 (PDT)
Date:   Fri, 29 May 2020 17:04:24 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <20200529160423.qsrbzxtcx2jslljk@e107158-lin>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529100806.GA3070@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/29/20 11:08, Mel Gorman wrote:
> On Thu, May 28, 2020 at 06:11:12PM +0200, Peter Zijlstra wrote:
> > > FWIW, I think you're referring to Mel's notice in OSPM regarding the overhead.
> > > Trying to see what goes on in there.
> > 
> > Indeed, that one. The fact that regular distros cannot enable this
> > feature due to performance overhead is unfortunate. It means there is a
> > lot less potential for this stuff.
> 
> During that talk, I was a vague about the cost, admitted I had not looked
> too closely at mainline performance and had since deleted the data given
> that the problem was first spotted in early April. If I heard someone
> else making statements like I did at the talk, I would consider it a bit
> vague, potentially FUD, possibly wrong and worth rechecking myself. In
> terms of distributions "cannot enable this", we could but I was unwilling
> to pay the cost for a feature no one has asked for yet. If they had, I
> would endevour to put it behind static branches and disable it by default
> (like what happened for PSI). I was contacted offlist about my comments
> at OSPM and gathered new data to respond properly. For the record, here
> is an editted version of my response;

I had this impression too that's why I had a rather humble attempt.

[...]

> # Event 'cycles:ppp'
> #
> # Baseline  Delta Abs  Shared Object             Symbol
> # ........  .........  ........................  ..............................................
> #
>      9.59%     -2.87%  [kernel.vmlinux]          [k] poll_idle
>      0.19%     +1.85%  [kernel.vmlinux]          [k] activate_task
>                +1.17%  [kernel.vmlinux]          [k] dequeue_task
>                +0.89%  [kernel.vmlinux]          [k] update_rq_clock.part.73
>      3.88%     +0.73%  [kernel.vmlinux]          [k] try_to_wake_up
>      3.17%     +0.68%  [kernel.vmlinux]          [k] __schedule
>      1.16%     -0.60%  [kernel.vmlinux]          [k] __update_load_avg_cfs_rq
>      2.20%     -0.54%  [kernel.vmlinux]          [k] resched_curr
>      2.08%     -0.29%  [kernel.vmlinux]          [k] _raw_spin_lock_irqsave
>      0.44%     -0.29%  [kernel.vmlinux]          [k] cpus_share_cache
>      1.13%     +0.23%  [kernel.vmlinux]          [k] _raw_spin_lock_bh
> 
> A lot of the uclamp functions appear to be inlined so it is not be
> particularly obvious from a raw profile but it shows up in the annotated
> profile in activate_task and dequeue_task for example. In the case of
> dequeue_task, uclamp_rq_dec_id() is extremely expensive according to the
> annotated profile.
> 
> I'm afraid I did not dig into this deeply once I knew I could just disable
> it even within the distribution.

Could by any chance the vmlinux (with debug symbols hopefully) and perf.dat are
still lying around to share?

I could send you a link to drop them somewhere.

Thanks

--
Qais Yousef
