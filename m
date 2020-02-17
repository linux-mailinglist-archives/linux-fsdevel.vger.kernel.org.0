Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2ADA16133F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgBQNYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:24:14 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35205 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728124AbgBQNYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:24:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TqAk0uJ_1581945832;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TqAk0uJ_1581945832)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Feb 2020 21:23:53 +0800
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
To:     Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
Date:   Mon, 17 Feb 2020 21:23:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217115810.GA3420@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/2/17 下午7:58, Mel Gorman wrote:
[snip]
>> Mel, I suspect you still feel that way, right?
>>
> 
> Yes, I still think it would be a struggle to interpret the data
> meaningfully without very specific knowledge of the implementation. If
> the scan rate was constant, it would be easier but that would make NUMA
> balancing worse overall. Similarly, the stat might get very difficult to
> interpret when NUMA balancing is failing because of a load imbalance,
> pages are shared and being interleaved or NUMA groups span multiple
> active nodes.

Hi, Mel, appreciated to have you back on the table :-)

IMHO the scan period changing should not be a problem now, since the
maximum period is defined by user, so monitoring at maximum period
on the accumulated page accessing counters is always meaningful, correct?

FYI, by monitoring locality, we found that the kvm vcpu thread is not
covered by NUMA Balancing, whatever how many maximum period passed, the
counters are not increasing, or very slowly, although inside guest we are
copying memory.

Later we found such task rarely exit to user space to trigger task
work callbacks, and NUMA Balancing scan depends on that, which help us
realize the importance to enable NUMA Balancing inside guest, with the
correct NUMA topo, a big performance risk I'll say :-P

Maybe not a good example, but we just try to highlight that NUMA Balancing
could have issue in some cases, and we want them to be exposed, somehow,
maybe by the locality.

Regards,
Michael Wang

> 
> For example, the series that reconciles NUMA and CPU balancers may look
> worse in these stats even though the overall performance may be better.
> 
>> In the document (patch 2/2) you write:
>>
>>> +However, there are no hardware counters for per-task local/remote accessing
>>> +info, we don't know how many remote page accesses have occurred for a
>>> +particular task.
>>
>> We can of course 'fix' that by adding a tracepoint.
>>
>> Mel, would you feel better by having a tracepoint in task_numa_fault() ?
>>
> 
> A bit, although interpreting the data would still be difficult and the
> tracepoint would have to include information about the cgroup. While
> I've never tried, this seems like the type of thing that would be suited
> to a BPF script that probes task_numa_fault and extract the information
> it needs.

> 
