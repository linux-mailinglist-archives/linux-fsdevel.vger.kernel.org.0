Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C431F1B37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgFHOo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 10:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgFHOo2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:44:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E75206C3;
        Mon,  8 Jun 2020 14:44:25 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:44:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200608104424.10781990@gandalf.local.home>
In-Reply-To: <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
References: <20200528132327.GB706460@hirez.programming.kicks-ass.net>
        <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
        <20200528161112.GI2483@worktop.programming.kicks-ass.net>
        <20200529100806.GA3070@suse.de>
        <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
        <87v9k84knx.derkling@matbug.net>
        <20200603101022.GG3070@suse.de>
        <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
        <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
        <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
        <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 8 Jun 2020 13:31:03 +0100
Qais Yousef <qais.yousef@arm.com> wrote:

> I admit I don't know how much of these numbers is ftrace overhead. When trying

Note, if you want to get a better idea of how long a function runs, put it
into set_ftrace_filter, and then trace it. That way you remove the overhead
of the function graph tracer when its nesting within a function.

> to capture similar runs for uclamp, the numbers didn't add up compared to
> running the test without ftrace generating the graph. If juno is suffering from
> bad branching costs in this path, then I suspect ftrace will amplify this as
> AFAIU it'll cause extra jumps on entry and exit.
> 
> 
> 
>       sched-pipe-6532  [001]  9407.276302: funcgraph_entry:                   |  deactivate_task() {
>       sched-pipe-6532  [001]  9407.276302: funcgraph_entry:                   |    dequeue_task_fair() {
>       sched-pipe-6532  [001]  9407.276303: funcgraph_entry:                   |      update_curr() {
>       sched-pipe-6532  [001]  9407.276304: funcgraph_entry:        0.780 us   |        update_min_vruntime();
>       sched-pipe-6532  [001]  9407.276306: funcgraph_entry:                   |        cpuacct_charge() {
>       sched-pipe-6532  [001]  9407.276306: funcgraph_entry:        0.820 us   |          __rcu_read_lock();
>       sched-pipe-6532  [001]  9407.276308: funcgraph_entry:        0.740 us   |          __rcu_read_unlock();

The above is more accurate than...

>       sched-pipe-6532  [001]  9407.276309: funcgraph_exit:         3.980 us   |        }

this one. Because this one has nested tracing within it.

-- Steve


>       sched-pipe-6532  [001]  9407.276310: funcgraph_entry:        0.720 us   |        __rcu_read_lock();
>       sched-pipe-6532  [001]  9407.276312: funcgraph_entry:        0.720 us   |        __rcu_read_unlock();
>       sched-pipe-6532  [001]  9407.276313: funcgraph_exit:         9.840 us   |      }
>       sched-pipe-6532  [001]  9407.276314: funcgraph_entry:                   |      __update_load_avg_se() {
>       sched-pipe-6532  [001]  9407.276315: funcgraph_entry:        0.720 us   |        __accumulate_pelt_segments();
>       sched-pipe-6532  [001]  9407.276316: funcgraph_exit:         2.260 us   |      }
>       sched-pipe-6532  [001]  9407.276317: funcgraph_entry:                   |      __update_load_avg_cfs_rq() {
>       sched-pipe-6532  [001]  9407.276318: funcgraph_entry:        0.860 us   |        __accumulate_pelt_segments();
>       sched-pipe-6532  [001]  9407.276319: funcgraph_exit:         2.340 us   |      }
