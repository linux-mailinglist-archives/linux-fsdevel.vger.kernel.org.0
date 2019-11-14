Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9822FBDD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 03:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNCXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 21:23:00 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:8569 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfKNCXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 21:23:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Ti0gV7v_1573698164;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Ti0gV7v_1573698164)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Nov 2019 10:22:46 +0800
Subject: Re: [PATCH 3/3] sched/numa: documentation for per-cgroup numa stat
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <896a7da3-f139-32e7-8a64-b3562df1a091@linux.alibaba.com>
 <CAAXuY3qsckZurUHy5kJUQcmrbn-bmGHnjtPPus5=PrQ+MmJX+g@mail.gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <b1106697-da56-ad5d-82c9-1461df0f2e35@linux.alibaba.com>
Date:   Thu, 14 Nov 2019 10:22:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAAXuY3qsckZurUHy5kJUQcmrbn-bmGHnjtPPus5=PrQ+MmJX+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Iurii

On 2019/11/14 上午2:28, Iurii Zaikin wrote:
> Since the documentation talks about fairly advanced concepts, every little bit
> of readability improvement helps. I tried to make suggestions that I feel make
> it easier to read, hopefully my nitpicking is not too annoying.

Any comments are welcomed :-)

> On Tue, Nov 12, 2019 at 7:46 PM 王贇 <yun.wang@linux.alibaba.com> wrote:
>> +On NUMA platforms, remote memory accessing always has a performance penalty,
>> +although we have NUMA balancing working hard to maximum the local accessing
>> +proportion, there are still situations it can't helps.
> Nit: working hard to maximize the access locality...
> can't helps -> can't help>> +
>> +This could happen in modern production environment, using bunch of cgroups
>> +to classify and control resources which introduced complex configuration on
>> +memory policy, CPUs and NUMA node, NUMA balancing could facing the wrong
>> +memory policy or exhausted local NUMA node, lead into the low local page
>> +accessing proportion.
> I find the below a bit easier to read.
> This could happen in modern production environment. When a large
> number of cgroups
> are used to classify and control resources, this creates a complex
> memory policy configuration
> for CPUs and NUMA nodes. In such cases NUMA balancing could end up
> with the wrong
> memory policy or exhausted local NUMA node, which would lead to low
> percentage of local page
> accesses.

Sounds better, just for the configuration part, since memory policy, CPUs
and NUMA nodes are configured by different approach, maybe we should still
separate them like:

This could happen in modern production environment. When a large
number of cgroups are used to classify and control resources, this
creates a complex configuration for memory policy, CPUs and NUMA nodes.
In such cases NUMA balancing could end up with the wrong memory policy
or exhausted local NUMA node, which would lead to low percentage of local
page accesses.

> 
>> +We need to perceive such cases, figure out which workloads from which cgroup
>> +has introduced the issues, then we got chance to do adjustment to avoid
>> +performance damages.
> Nit: perceive -> detect, got-> get, damages-> degradation
> 
>> +However, there are no hardware counter for per-task local/remote accessing
>> +info, we don't know how many remote page accessing has been done for a
>> +particular task.
> Nit: counters.
> Nit: we don't know how many remote page accesses have occurred for a
> 
>> +
>> +Statistics
>> +----------
>> +
>> +Fortunately, we have NUMA Balancing which scan task's mapping and trigger PF
>> +periodically, give us the opportunity to record per-task page accessing info.
> Nit: scans, triggers, gives.
> 
>> +By "echo 1 > /proc/sys/kernel/cg_numa_stat" on runtime or add boot parameter
> Nit: at runtime or adding boot parameter
>> +To be noticed, the accounting is in a hierarchy way, which means the numa
>> +statistics representing not only the workload of this group, but also the
>> +workloads of all it's descendants.
> Note that the accounting is hierarchical, which means the numa
> statistics for a given group represents not only the workload of this
> group, but also the
> workloads of all it's descendants.
>> +
>> +For example the 'cpu.numa_stat' show:
>> +  locality 39541 60962 36842 72519 118605 721778 946553
>> +  exectime 1220127 1458684
>> +
>> +The locality is sectioned into 7 regions, closely as:
>> +  0-13% 14-27% 28-42% 43-56% 57-71% 72-85% 86-100%
> Nit: closely -> approximately?
> 
>> +we can draw a line for region_bad_percent, when the line close to 0 things
> nit: we can plot?
>> +are good, when getting close to 100% something is wrong, we can pick a proper
>> +watermark to trigger warning message.
> 
>> +You may want to drop the data if the region_all is too small, which imply
> Nit: implies
>> +there are not much available pages for NUMA Balancing, just ignore would be
> Nit: not many... ingoring
>> +fine since most likely the workload is insensitive to NUMA.
>> +Monitoring root group help you control the overall situation, while you may
> Nit: helps
>> +also want to monitoring all the leaf groups which contain the workloads, this
> Nit: monitor
>> +help to catch the mouse.
> Nit: helps
>> +become too small, for NUMA node X we have:
> Nit: becomes
>> +try put your workload into a memory cgroup which providing per-node memory
> Nit: try to put
>> +These two percentage are usually matched on each node, workload should execute
> Nit: percentages
>> +Depends on which part of the memory accessed mostly by the workload, locality> Depending on which part of the memory is accessed.
> "mostly by the workload" - not sure what you mean here, the majority
> of accesses from the
> workload fall into this part of memory or that accesses from processes
> other than the workload
> are rare?

The prev one actually, sometime the workload only access part of it's
memory, could be a small part but as long as this part is local, things
could be fine.

>> +could still be good with just a little piece of memory locally.
> ?

whatabout:

workload may only access a small part of it's memory, in such cases, although
the majority of memory are remotely, locality could still be good.

>> +Thus to tell if things are find or not depends on the understanding of system
> are fine
>> +After locate which workloads introduced the bad locality, check:
> locate -> indentifying
>> +
>> +1). Is the workloads bind into a particular NUMA node?
> bind into -> bound to
>> +2). Is there any NUMA node run out of resources?
> Has any .. run out of resources
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 5e27d74e2b74..220df1f0beb8 100644
>> +                       lot's of per-cgroup workloads.
> lots

Thanks for point out all these issues, very helpful :-)

Should apply them in next version.

Regards,
Michael Wang

> 
