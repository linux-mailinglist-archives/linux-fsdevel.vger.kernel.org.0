Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0AB161E9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 02:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgBRBjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 20:39:41 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36215 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbgBRBjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:39:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TqCOUvS_1581989975;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TqCOUvS_1581989975)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Feb 2020 09:39:36 +0800
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
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <114519ab-4e9e-996a-67b8-4f5fcecba72a@linux.alibaba.com>
Date:   Tue, 18 Feb 2020 09:39:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217141616.GB3420@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/2/17 下午10:16, Mel Gorman wrote:
> On Mon, Feb 17, 2020 at 09:23:52PM +0800, ?????? wrote:
[snip]
>>
>> IMHO the scan period changing should not be a problem now, since the
>> maximum period is defined by user, so monitoring at maximum period
>> on the accumulated page accessing counters is always meaningful, correct?
>>
> 
> It has meaning but the scan rate drives the fault rate which is the basis
> for the stats you accumulate. If the scan rate is high when accesses
> are local, the stats can be skewed making it appear the task is much
> more local than it may really is at a later point in time. The scan rate
> affects the accuracy of the information. The counters have meaning but
> they needs careful interpretation.

Yeah, to zip so many information from NUMA Balancing to some statistics
is a challenge itself, the locality still not so easy to be understood by
NUMA newbie :-P

> 
>> FYI, by monitoring locality, we found that the kvm vcpu thread is not
>> covered by NUMA Balancing, whatever how many maximum period passed, the
>> counters are not increasing, or very slowly, although inside guest we are
>> copying memory.
>>
>> Later we found such task rarely exit to user space to trigger task
>> work callbacks, and NUMA Balancing scan depends on that, which help us
>> realize the importance to enable NUMA Balancing inside guest, with the
>> correct NUMA topo, a big performance risk I'll say :-P
>>
> 
> Which is a very interesting corner case in itself but also one that
> could have potentially have been inferred from monitoring /proc/vmstat
> numa_pte_updates or on a per-task basis by monitoring /proc/PID/sched and
> watching numa_scan_seq and total_numa_faults. Accumulating the information
> on a per-cgroup basis would require a bit more legwork.

That's not working for daily monitoring...

Besides, compared with locality, this require much more deeper understand
on the implementation, which could even be tough for NUMA developers to
assemble all these statistics together.

> 
>> Maybe not a good example, but we just try to highlight that NUMA Balancing
>> could have issue in some cases, and we want them to be exposed, somehow,
>> maybe by the locality.
>>
> 
> Again, I'm somewhat neutral on the patch simply because I would not use
> the information for debugging problems with NUMA balancing. I would try
> using tracepoints and if the tracepoints were not good enough, I'd add or
> fix them -- similar to what I had to do with sched_stick_numa recently.
> The caveat is that I mostly look at this sort of problem as a developer.
> Sysadmins have very different requirements, especially simplicity even
> if the simplicity in this case is an illusion.

Fair enough, but I guess PeterZ still want your Ack, so neutral means
refuse in this case :-(

BTW, how do you think about the documentation in second patch?

Do you think it's necessary to have a doc to explain NUMA related statistics?

Regards,
Michael Wang

> 
