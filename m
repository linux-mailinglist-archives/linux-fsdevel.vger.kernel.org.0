Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0E167FF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 15:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgBUOUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 09:20:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:41524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgBUOUR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:20:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DD6CAB23C;
        Fri, 21 Feb 2020 14:20:14 +0000 (UTC)
Date:   Fri, 21 Feb 2020 14:20:10 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     ?????? <yun.wang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal Koutn? <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
Message-ID: <20200221142010.GT3420@suse.de>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
 <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
 <20200217141616.GB3420@suse.de>
 <114519ab-4e9e-996a-67b8-4f5fcecba72a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <114519ab-4e9e-996a-67b8-4f5fcecba72a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:39:35AM +0800, ?????? wrote:
> On 2020/2/17 ??????10:16, Mel Gorman wrote:
> > On Mon, Feb 17, 2020 at 09:23:52PM +0800, ?????? wrote:
> [snip]
> >>
> >> IMHO the scan period changing should not be a problem now, since the
> >> maximum period is defined by user, so monitoring at maximum period
> >> on the accumulated page accessing counters is always meaningful, correct?
> >>
> > 
> > It has meaning but the scan rate drives the fault rate which is the basis
> > for the stats you accumulate. If the scan rate is high when accesses
> > are local, the stats can be skewed making it appear the task is much
> > more local than it may really is at a later point in time. The scan rate
> > affects the accuracy of the information. The counters have meaning but
> > they needs careful interpretation.
> 
> Yeah, to zip so many information from NUMA Balancing to some statistics
> is a challenge itself, the locality still not so easy to be understood by
> NUMA newbie :-P
> 

Indeed and if they do not take into account historical skew into
account, they still might not understand.

> > 
> >> FYI, by monitoring locality, we found that the kvm vcpu thread is not
> >> covered by NUMA Balancing, whatever how many maximum period passed, the
> >> counters are not increasing, or very slowly, although inside guest we are
> >> copying memory.
> >>
> >> Later we found such task rarely exit to user space to trigger task
> >> work callbacks, and NUMA Balancing scan depends on that, which help us
> >> realize the importance to enable NUMA Balancing inside guest, with the
> >> correct NUMA topo, a big performance risk I'll say :-P
> >>
> > 
> > Which is a very interesting corner case in itself but also one that
> > could have potentially have been inferred from monitoring /proc/vmstat
> > numa_pte_updates or on a per-task basis by monitoring /proc/PID/sched and
> > watching numa_scan_seq and total_numa_faults. Accumulating the information
> > on a per-cgroup basis would require a bit more legwork.
> 
> That's not working for daily monitoring...
> 

Indeed although at least /proc/vmstat is cheap to monitor and it could
at least be tracked if the number of NUMA faults are abnormally low or
the ratio of remote to local hints are problematic.

> Besides, compared with locality, this require much more deeper understand
> on the implementation, which could even be tough for NUMA developers to
> assemble all these statistics together.
> 

My point is that even with the patch, the definition of locality is
subtle. At a single point in time, the locality might appear to be low
but it's due to an event that happened far in the past.

> > 
> >> Maybe not a good example, but we just try to highlight that NUMA Balancing
> >> could have issue in some cases, and we want them to be exposed, somehow,
> >> maybe by the locality.
> >>
> > 
> > Again, I'm somewhat neutral on the patch simply because I would not use
> > the information for debugging problems with NUMA balancing. I would try
> > using tracepoints and if the tracepoints were not good enough, I'd add or
> > fix them -- similar to what I had to do with sched_stick_numa recently.
> > The caveat is that I mostly look at this sort of problem as a developer.
> > Sysadmins have very different requirements, especially simplicity even
> > if the simplicity in this case is an illusion.
> 
> Fair enough, but I guess PeterZ still want your Ack, so neutral means
> refuse in this case :-(
> 

I think the patch is functionally harmless and can be disabled but I also
would be wary of dealing with a bug report that was based on the numbers
provided by the locality metric. The bulk of the work related to the bug
would likely be spent on trying to explain the metric and I've dealt with
quite a few bugs that were essentially "We don't like this number and think
something is wrong because of it -- fix it". Even then, I would want the
workload isolated and then vmstat recorded over time to determine it's
a persistent problem or not. That's the reason why I'm relucant to ack it.

I fully acknowledge that this may have value for sysadmins and may be a
good enough reason to merge it for environments that typically build and
configure their own kernels. I doubt that general distributions would
enable it but that's a guess.

> BTW, how do you think about the documentation in second patch?
> 

I think the documentation is great, it's clear and explains itself well.

> Do you think it's necessary to have a doc to explain NUMA related statistics?
> 

It would be nice but AFAIK, the stats in vmstats are not documented.
They are there because recording them over time can be very useful when
dealing with user bug reports.

-- 
Mel Gorman
SUSE Labs
