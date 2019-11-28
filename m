Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3D10C9B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1Nme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 08:42:34 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47041 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbfK1Nmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:42:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TjJZTYN_1574948497;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjJZTYN_1574948497)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Nov 2019 21:41:38 +0800
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
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <e008fef6-06d2-28d3-f4d3-229f4b181b4f@linux.alibaba.com>
Date:   Thu, 28 Nov 2019 21:41:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128123924.GD831@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/11/28 下午8:39, Michal Koutný wrote:
> Hello.
> 
> My primary concern is still the measuring of per-NUMA node execution
> time.
> 
> First, I think exposing the aggregated data into the numa_stat file is
> loss of information. The data are collected per-CPU and then summed over
> NUMA nodes -- this could be easily done by the userspace consumer of the
> data, keeping the per-CPU data available.
> 
> Second, comparing with the cpuacct implementation, yours has only jiffy
> granularity (I may have overlooked something or I miss some context,
> then it's a non-concern).

There are used to be a discussion on this, Peter mentioned we no longer
expose raw ticks into userspace and micro seconds could be fine.

Basically we use this to calculate percentages, for which jiffy could be
accurate enough :-)

> 
> IOW, to me it sounds like duplicating cpuacct job and if that is deemed
> useful for cgroup v2, I think it should be done (only once) and at
> proper place (i.e. how cputime is measured in the default hierarchy).

But still, what if folks don't use v2... any good suggestions?

> 
> The previous two are design/theoretical remarks, however, your patch
> misses measuring of other than fair_sched_class policy tasks. Is that
> intentional?

Yes, since they don't have NUMA balancing to do optimization, and
generally they are not that much.

> 
> My last two comments are to locality measurement but are based on no
> experience or specific knowledge.
> 
> The seven percentile groups seem quite arbitrary to me, I find it
> strange that the ratio of cache-line size and u64 leaks and is fixed in
> the generally visible file. Wouldn't such a form be better hidden under
> a _DEBUG config option?

Sorry but I don't get it... at first it was 10 regions, as Peter suggested
we pick 8, but now to insert member 'jiffies' it become 7, the address of
'jiffies' is cache aligned, so we pick u64 * 8 == 64Bytes to make sure the
whole thing could be load in cache once a time, or did I misunderstand
something?

> 
> 
> On Thu, Nov 28, 2019 at 10:09:13AM +0800, 王贇 <yun.wang@linux.alibaba.com> wrote:
>> Consider it as load_1/5/15 which not accurate but tell the trend of system
> I understood your patchset provides cumulative data over time, i.e. if
> a user wants to see an immediate trend, they have to calculate
> differences. Have I overlooked some back-off or regular zeroing?

Yes, here what I try to highlight is the similar usage, but not the way of
monitoring ;-) as the docs tell, we monitoring increments.

Regards,
Michale Wang

> 
> Michal
> 
