Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865C6169C80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 04:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBXDF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 22:05:56 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37547 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgBXDF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:05:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TqheseS_1582513549;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TqheseS_1582513549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Feb 2020 11:05:51 +0800
Subject: Re: [PATCH RESEND v8 1/2] sched/numa: introduce per-cgroup NUMA
 locality info
To:     Mel Gorman <mgorman@suse.de>
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
References: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
 <cde13472-46c0-7e17-175f-4b2ba4d8148a@linux.alibaba.com>
 <20200214151048.GL14914@hirez.programming.kicks-ass.net>
 <20200217115810.GA3420@suse.de>
 <881deb50-163e-442a-41ec-b375cc445e4d@linux.alibaba.com>
 <20200217141616.GB3420@suse.de>
 <114519ab-4e9e-996a-67b8-4f5fcecba72a@linux.alibaba.com>
 <20200221142010.GT3420@suse.de>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <2def511f-4eb4-4c70-cd68-415fa63453eb@linux.alibaba.com>
Date:   Mon, 24 Feb 2020 11:05:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221142010.GT3420@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/2/21 下午10:20, Mel Gorman wrote:
[snip]
>>>
>>> Which is a very interesting corner case in itself but also one that
>>> could have potentially have been inferred from monitoring /proc/vmstat
>>> numa_pte_updates or on a per-task basis by monitoring /proc/PID/sched and
>>> watching numa_scan_seq and total_numa_faults. Accumulating the information
>>> on a per-cgroup basis would require a bit more legwork.
>>
>> That's not working for daily monitoring...
>>
> 
> Indeed although at least /proc/vmstat is cheap to monitor and it could
> at least be tracked if the number of NUMA faults are abnormally low or
> the ratio of remote to local hints are problematic.
> 
>> Besides, compared with locality, this require much more deeper understand
>> on the implementation, which could even be tough for NUMA developers to
>> assemble all these statistics together.
>>
> 
> My point is that even with the patch, the definition of locality is
> subtle. At a single point in time, the locality might appear to be low
> but it's due to an event that happened far in the past.

Agree, the locality's meaning just keep changing... only those who
understand the implementation can figure out the useful information.

> 
>>>
>>>> Maybe not a good example, but we just try to highlight that NUMA Balancing
>>>> could have issue in some cases, and we want them to be exposed, somehow,
>>>> maybe by the locality.
>>>>
>>>
>>> Again, I'm somewhat neutral on the patch simply because I would not use
>>> the information for debugging problems with NUMA balancing. I would try
>>> using tracepoints and if the tracepoints were not good enough, I'd add or
>>> fix them -- similar to what I had to do with sched_stick_numa recently.
>>> The caveat is that I mostly look at this sort of problem as a developer.
>>> Sysadmins have very different requirements, especially simplicity even
>>> if the simplicity in this case is an illusion.
>>
>> Fair enough, but I guess PeterZ still want your Ack, so neutral means
>> refuse in this case :-(
>>
> 
> I think the patch is functionally harmless and can be disabled but I also
> would be wary of dealing with a bug report that was based on the numbers
> provided by the locality metric. The bulk of the work related to the bug
> would likely be spent on trying to explain the metric and I've dealt with
> quite a few bugs that were essentially "We don't like this number and think
> something is wrong because of it -- fix it". Even then, I would want the
> workload isolated and then vmstat recorded over time to determine it's
> a persistent problem or not. That's the reason why I'm relucant to ack it.
> 
> I fully acknowledge that this may have value for sysadmins and may be a
> good enough reason to merge it for environments that typically build and
> configure their own kernels. I doubt that general distributions would
> enable it but that's a guess.

Thanks for the kindly explain, I get the point.

False alarm maybe fine to admin, but could be nightmare if the user keep
asking why, I suppose those who want to do some improvement on NUMA may be
interested :-P

Anyway, I understand there is a gap between general requirement and this
locality idea, and it's really hard to be fulfill...

> 
>> BTW, how do you think about the documentation in second patch?
>>
> 
> I think the documentation is great, it's clear and explains itself well.
> 
>> Do you think it's necessary to have a doc to explain NUMA related statistics?
>>
> 
> It would be nice but AFAIK, the stats in vmstats are not documented.
> They are there because recording them over time can be very useful when
> dealing with user bug reports.

Another TODO then :-)

Regards,
Michael Wang

> 
