Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE95710D06D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 02:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfK2BwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 20:52:15 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46262 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbfK2BwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 20:52:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TjLLnsg_1574992327;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjLLnsg_1574992327)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Nov 2019 09:52:09 +0800
Subject: Re: [PATCH v2 1/3] sched/numa: advanced per-cgroup numa statistic
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
 <20191127101932.GN28938@suse.de>
 <3ff78d18-fa29-13f3-81e5-a05537a2e344@linux.alibaba.com>
 <20191128123924.GD831@blackbody.suse.cz>
 <e008fef6-06d2-28d3-f4d3-229f4b181b4f@linux.alibaba.com>
 <20191128155818.GE831@blackbody.suse.cz>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <b97ce489-c5c5-0670-a553-0e45d593de2c@linux.alibaba.com>
Date:   Fri, 29 Nov 2019 09:52:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128155818.GE831@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019/11/28 下午11:58, Michal Koutný wrote:
> On Thu, Nov 28, 2019 at 09:41:37PM +0800, 王贇 <yun.wang@linux.alibaba.com> wrote:
>> There are used to be a discussion on this, Peter mentioned we no longer
>> expose raw ticks into userspace and micro seconds could be fine.
> I don't mean the unit presented but the precision.
> 
>> Basically we use this to calculate percentages, for which jiffy could be
>> accurate enough :-)
> You also report the raw times.>
> Ad percentages (or raw times precision), on average, it should be fine
> but can't there be any "aliasing" artifacts when only an unimportant
> task is regularly sampled, hence not capturing the real pattern on the
> CPU? (Again, I'm not confident I'm not missing anything that prevents
> that behavior.)

Hmm.. I think I get your point now, so the concern is about the missing
situation between each ticks, correct?

It could be, like one tick hit task A running, then A switched to B, B
switched back to A before next tick, then we missing the exectime of B
in next tick, since it hit A again.

Actually we have the same issue for those data in /proc/stat too, don't
we? The user, sys, iowait was sampled in the similar way.

So if we have to pick a precision, I may still pick jiffy since the
exectime is some thing similar to user/sys time IMHO.

> 
>> But still, what if folks don't use v2... any good suggestions?
> (Note this applies to exectimes not locality.) On v1, they can add up
> per CPU values from cpuacct. (So it's v2 that's missing the records.)

Whatabout move the whole stuff into cpuacct cgroup?

I'm not sure but maybe we could use some data there to save the sample
of jiffies, for those v1 user who need these statistics, they should have
cpuacct enabled.

> 
> 
>> Yes, since they don't have NUMA balancing to do optimization, and
>> generally they are not that much.
> Aha, I didn't realize that.
> 
>> Sorry but I don't get it... at first it was 10 regions, as Peter suggested
>> we pick 8, but now to insert member 'jiffies' it become 7,
> See, there are various arguments for different values :-)
> 
> I meant that the currently chosen one is imprinted into the API file.
> That is IMO fixable by documenting (e.g. the number of bands may change,
> assume uniform division) or making all this just a debug API. Or, see
> below.
> 
>> Yes, here what I try to highlight is the similar usage, but not the way of
>> monitoring ;-) as the docs tell, we monitoring increments.
> I see, the docs give me an idea what's the supposed use case.
> 
> What about exposing only the counters for local, remote and let the user
> do their monitoring based on Δlocal/(Δlocal + Δremote)?
> 
> That would avoid the partitioning question completely, exposed values
> would be simple numbers and provided information should be equal. A
> drawback is that such a sampling would be slower (but sufficient for the
> illustrating example).

You mean the cgroup numa stat just give the accumulated local/remote access?

As long as the counter won't overflow, maybe... sounds easier to explain too.

So user tracing locality will then get just one percentage (calculated on
their own) from a cgroup, but one should be enough to represent the situation.

Sounds like a good idea to me :-) will try to do that in next version.

Regards,
Michael Wang

> 
> Michal
> 
