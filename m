Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66EE16145A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgBQOQY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 09:16:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:51760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgBQOQX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:16:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22183B3C2;
        Mon, 17 Feb 2020 14:16:21 +0000 (UTC)
Date:   Mon, 17 Feb 2020 14:16:16 +0000
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
Message-ID: <20200217141616.GB3420@suse.de>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
 <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:23:52PM +0800, ?????? wrote:
> 
> 
> On 2020/2/17 ??????7:58, Mel Gorman wrote:
> [snip]
> >> Mel, I suspect you still feel that way, right?
> >>
> > 
> > Yes, I still think it would be a struggle to interpret the data
> > meaningfully without very specific knowledge of the implementation. If
> > the scan rate was constant, it would be easier but that would make NUMA
> > balancing worse overall. Similarly, the stat might get very difficult to
> > interpret when NUMA balancing is failing because of a load imbalance,
> > pages are shared and being interleaved or NUMA groups span multiple
> > active nodes.
> 
> Hi, Mel, appreciated to have you back on the table :-)
> 
> IMHO the scan period changing should not be a problem now, since the
> maximum period is defined by user, so monitoring at maximum period
> on the accumulated page accessing counters is always meaningful, correct?
> 

It has meaning but the scan rate drives the fault rate which is the basis
for the stats you accumulate. If the scan rate is high when accesses
are local, the stats can be skewed making it appear the task is much
more local than it may really is at a later point in time. The scan rate
affects the accuracy of the information. The counters have meaning but
they needs careful interpretation.

> FYI, by monitoring locality, we found that the kvm vcpu thread is not
> covered by NUMA Balancing, whatever how many maximum period passed, the
> counters are not increasing, or very slowly, although inside guest we are
> copying memory.
> 
> Later we found such task rarely exit to user space to trigger task
> work callbacks, and NUMA Balancing scan depends on that, which help us
> realize the importance to enable NUMA Balancing inside guest, with the
> correct NUMA topo, a big performance risk I'll say :-P
> 

Which is a very interesting corner case in itself but also one that
could have potentially have been inferred from monitoring /proc/vmstat
numa_pte_updates or on a per-task basis by monitoring /proc/PID/sched and
watching numa_scan_seq and total_numa_faults. Accumulating the information
on a per-cgroup basis would require a bit more legwork.

> Maybe not a good example, but we just try to highlight that NUMA Balancing
> could have issue in some cases, and we want them to be exposed, somehow,
> maybe by the locality.
> 

Again, I'm somewhat neutral on the patch simply because I would not use
the information for debugging problems with NUMA balancing. I would try
using tracepoints and if the tracepoints were not good enough, I'd add or
fix them -- similar to what I had to do with sched_stick_numa recently.
The caveat is that I mostly look at this sort of problem as a developer.
Sysadmins have very different requirements, especially simplicity even
if the simplicity in this case is an illusion.

-- 
Mel Gorman
SUSE Labs
