Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84B615DA5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgBNPLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 10:11:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNPLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=s9JdTXWZ0Xda8rN1p02Y37deVkj9XnXOSrh2WxBj85E=; b=XmOW4ijskd7BidiCCrgHxhtiwE
        ljqycWpiW1m3T3OM0p0MqTQA3o25Im4l4gkTiI4PhOXC9eK2OxckYmWozQI8h3BcwslXhhJTlHMlS
        cPQOHZ7Rw60ySnVd50dVtVsYhB7w8Oh34LydDkfBDB4u/22ZTQdoX0y9hLsCMixaWNYQEP5NXZtuN
        ky+s2Z7ZOMSgdN+WayN/VLnuEtSPSbj06flTCZALgJMK4/GJbJ5lzG2IEH0lzqFa8zql86Wv24CJ5
        gAxsrA467dMb4nyEJeFiMkkjLE4d8qXgTwjzy8GopzkANXyKTfZn7nk3WBmZYIKjuzl/LODOXjTZz
        xtiak40Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2ccI-0004CC-3q; Fri, 14 Feb 2020 15:10:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBAC0300606;
        Fri, 14 Feb 2020 16:08:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE97720254E63; Fri, 14 Feb 2020 16:10:48 +0100 (CET)
Date:   Fri, 14 Feb 2020 16:10:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
Message-ID: <20200214151048.GL14914@hirez.programming.kicks-ass.net>
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 11:35:30AM +0800, 王贇 wrote:
> Currently there are no good approach to monitoring the per-cgroup NUMA
> efficiency, this could be a trouble especially when groups are sharing
> CPUs, we don't know which one introduced remote-memory accessing.
> 
> Although the per-task NUMA accessing info from PMU is good for further
> debuging, but not light enough for daily monitoring, especial on a box
> with thousands of tasks.
> 
> Fortunately, when NUMA Balancing enabled, it will periodly trigger page
> fault and try to increase the NUMA locality, by tracing the results we
> will be able to estimate the NUMA efficiency.
> 
> On each page fault of NUMA Balancing, when task's executing CPU is from
> the same node of pages, we call this a local page accessing, otherwise
> a remote page accessing.
> 
> By updating task's accessing counter into it's cgroup on ticks, we get
> the per-cgroup numa locality info.
> 
> For example the new entry 'cpu.numa_stat' show:
>   page_access local=1231412 remote=53453
> 
> Here we know the workloads in hierarchy have totally been traced 1284865
> times of page accessing, and 1231412 of them are local page access, which
> imply a good NUMA efficiency.
> 
> By monitoring the increments, we will be able to locate the per-cgroup
> workload which NUMA Balancing can't helpwith (usually caused by wrong
> CPU and memory node bindings), then we got chance to fix that in time.
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>

So here:

  https://lkml.kernel.org/r/20191127101932.GN28938@suse.de

Mel argues that the information exposed is fairly implementation
specific and hard to use without understanding how NUMA balancing works.

By exposing it to userspace, we tie ourselves to these particulars. We
can no longer change these NUMA balancing details if we wanted to, due
to UAPI concerns.

Mel, I suspect you still feel that way, right?

In the document (patch 2/2) you write:

> +However, there are no hardware counters for per-task local/remote accessing
> +info, we don't know how many remote page accesses have occurred for a
> +particular task.

We can of course 'fix' that by adding a tracepoint.

Mel, would you feel better by having a tracepoint in task_numa_fault() ?

Now I'm not really a fan of tracepoints myself, since they also
establish a UAPI, but perhaps it is a lesser evil in this case.
