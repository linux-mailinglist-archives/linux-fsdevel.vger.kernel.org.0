Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8C4161185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 12:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgBQL6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 06:58:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:38340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgBQL6R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:58:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7594CAAC2;
        Mon, 17 Feb 2020 11:58:15 +0000 (UTC)
Date:   Mon, 17 Feb 2020 11:58:10 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     ?????? <yun.wang@linux.alibaba.com>,
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
Message-ID: <20200217115810.GA3420@suse.de>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214151048.GL14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:10:48PM +0100, Peter Zijlstra wrote:
> On Fri, Feb 07, 2020 at 11:35:30AM +0800, ?????? wrote:
> > By monitoring the increments, we will be able to locate the per-cgroup
> > workload which NUMA Balancing can't helpwith (usually caused by wrong
> > CPU and memory node bindings), then we got chance to fix that in time.
> > 
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Michal Koutný <mkoutny@suse.com>
> > Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> 
> So here:
> 
>   https://lkml.kernel.org/r/20191127101932.GN28938@suse.de
> 
> Mel argues that the information exposed is fairly implementation
> specific and hard to use without understanding how NUMA balancing works.
> 
> By exposing it to userspace, we tie ourselves to these particulars. We
> can no longer change these NUMA balancing details if we wanted to, due
> to UAPI concerns.
> 
> Mel, I suspect you still feel that way, right?
> 

Yes, I still think it would be a struggle to interpret the data
meaningfully without very specific knowledge of the implementation. If
the scan rate was constant, it would be easier but that would make NUMA
balancing worse overall. Similarly, the stat might get very difficult to
interpret when NUMA balancing is failing because of a load imbalance,
pages are shared and being interleaved or NUMA groups span multiple
active nodes.

For example, the series that reconciles NUMA and CPU balancers may look
worse in these stats even though the overall performance may be better.

> In the document (patch 2/2) you write:
> 
> > +However, there are no hardware counters for per-task local/remote accessing
> > +info, we don't know how many remote page accesses have occurred for a
> > +particular task.
> 
> We can of course 'fix' that by adding a tracepoint.
> 
> Mel, would you feel better by having a tracepoint in task_numa_fault() ?
> 

A bit, although interpreting the data would still be difficult and the
tracepoint would have to include information about the cgroup. While
I've never tried, this seems like the type of thing that would be suited
to a BPF script that probes task_numa_fault and extract the information
it needs.

-- 
Mel Gorman
SUSE Labs
