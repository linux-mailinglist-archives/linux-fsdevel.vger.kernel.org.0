Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282CDFB336
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 16:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKMPJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 10:09:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:48940 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfKMPJQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:09:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 710685A0;
        Wed, 13 Nov 2019 15:09:14 +0000 (UTC)
Date:   Wed, 13 Nov 2019 08:09:12 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 3/3] sched/numa: documentation for per-cgroup numa stat
Message-ID: <20191113080912.041918ce@lwn.net>
In-Reply-To: <896a7da3-f139-32e7-8a64-b3562df1a091@linux.alibaba.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
        <896a7da3-f139-32e7-8a64-b3562df1a091@linux.alibaba.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Nov 2019 11:45:59 +0800
王贇 <yun.wang@linux.alibaba.com> wrote:

> Add the description for 'cg_numa_stat', also a new doc to explain
> the details on how to deal with the per-cgroup numa statistics.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  Documentation/admin-guide/cg-numa-stat.rst      | 161 ++++++++++++++++++++++++
>  Documentation/admin-guide/kernel-parameters.txt |   4 +
>  Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
>  3 files changed, 174 insertions(+)
>  create mode 100644 Documentation/admin-guide/cg-numa-stat.rst

Thanks for adding documentation for your new feature!  When you add a new
RST file, though, you should also add it to index.rst so that it becomes a
part of the docs build.

A couple of nits below...

> diff --git a/Documentation/admin-guide/cg-numa-stat.rst b/Documentation/admin-guide/cg-numa-stat.rst
> new file mode 100644
> index 000000000000..87b716c51e16
> --- /dev/null
> +++ b/Documentation/admin-guide/cg-numa-stat.rst
> @@ -0,0 +1,161 @@
> +===============================
> +Per-cgroup NUMA statistics
> +===============================
> +
> +Background
> +----------
> +
> +On NUMA platforms, remote memory accessing always has a performance penalty,
> +although we have NUMA balancing working hard to maximum the local accessing
> +proportion, there are still situations it can't helps.
> +
> +This could happen in modern production environment, using bunch of cgroups
> +to classify and control resources which introduced complex configuration on
> +memory policy, CPUs and NUMA node, NUMA balancing could facing the wrong
> +memory policy or exhausted local NUMA node, lead into the low local page
> +accessing proportion.
> +
> +We need to perceive such cases, figure out which workloads from which cgroup
> +has introduced the issues, then we got chance to do adjustment to avoid
> +performance damages.
> +
> +However, there are no hardware counter for per-task local/remote accessing
> +info, we don't know how many remote page accessing has been done for a
> +particular task.
> +
> +Statistics
> +----------
> +
> +Fortunately, we have NUMA Balancing which scan task's mapping and trigger PF
> +periodically, give us the opportunity to record per-task page accessing info.
> +
> +By "echo 1 > /proc/sys/kernel/cg_numa_stat" on runtime or add boot parameter
> +'cg_numa_stat', we will enable the accounting of per-cgroup numa statistics,
> +the 'cpu.numa_stat' entry of CPU cgroup will show statistics:
> +
> +  locality -- execution time sectioned by task NUMA locality (in ms)
> +  exectime -- execution time sectioned by NUMA node (in ms)
> +
> +We define 'task NUMA locality' as:
> +
> +  nr_local_page_access * 100 / (nr_local_page_access + nr_remote_page_access)
> +
> +this per-task percentage value will be updated on the ticks for current task,
> +and the access counter will be updated on task's NUMA balancing PF, so only
> +the pages which NUMA Balancing paid attention to will be accounted.
> +
> +On each tick, we acquire the locality of current task on that CPU, accumulating
> +the ticks into the counter of corresponding locality region, tasks from the
> +same group sharing the counters, becoming the group locality.
> +
> +Similarly, we acquire the NUMA node of current CPU where the current task is
> +executing on, accumulating the ticks into the counter of corresponding node,
> +becoming the per-cgroup node execution time.
> +
> +To be noticed, the accounting is in a hierarchy way, which means the numa
> +statistics representing not only the workload of this group, but also the
> +workloads of all it's descendants.
> +
> +For example the 'cpu.numa_stat' show:
> +  locality 39541 60962 36842 72519 118605 721778 946553
> +  exectime 1220127 1458684

You almost certainly want that rendered as a literal block, so say
"show::".  There are other places where you'll want to do that as well. 

> +The locality is sectioned into 7 regions, closely as:
> +  0-13% 14-27% 28-42% 43-56% 57-71% 72-85% 86-100%
> +
> +And exectime is sectioned into 2 nodes, 0 and 1 in this case.
> +
> +Thus we know the workload of this group and it's descendants have totally
> +executed 1220127ms on node_0 and 1458684ms on node_1, tasks with locality
> +around 0~13% executed for 39541 ms, and tasks with locality around 87~100%
> +executed for 946553 ms, which imply most of the memory access are local.
> +
> +Monitoring
> +-----------------

A slightly long underline :)

I'll stop here; thanks again for adding documentation.

jon
