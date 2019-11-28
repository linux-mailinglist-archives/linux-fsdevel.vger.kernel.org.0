Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8ED10C229
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 03:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfK1CJW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 21:09:22 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46117 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729239AbfK1CJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:09:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TjGOkbY_1574906953;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjGOkbY_1574906953)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Nov 2019 10:09:14 +0800
Subject: Re: [PATCH v2 1/3] sched/numa: advanced per-cgroup numa statistic
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <9354ffe8-81ba-9e76-e0b3-222bc942b3fc@linux.alibaba.com>
 <20191127101932.GN28938@suse.de>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <3ff78d18-fa29-13f3-81e5-a05537a2e344@linux.alibaba.com>
Date:   Thu, 28 Nov 2019 10:09:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127101932.GN28938@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/11/27 下午6:19, Mel Gorman wrote:
> On Wed, Nov 27, 2019 at 09:49:34AM +0800, ?????? wrote:
>> Currently there are no good approach to monitoring the per-cgroup
>> numa efficiency, this could be a trouble especially when groups
>> are sharing CPUs, it's impossible to tell which one caused the
>> remote-memory access by reading hardware counter since multiple
>> workloads could sharing the same CPU, which make it painful when
>> one want to find out the root cause and fix the issue>>
> 
> It's already possible to identify specific tasks triggering PMU events
> so this is not exactly true.

Should fix the description regarding this...

I think you mean tools like numatop which showing per task local/remote
accessing info from PMU, correct?

It's a good one for debugging, but when we talking about monitoring over
cluster sharing by multiple users, still not very practical... compared
to the workloads classified historical data.

I'm not sure about the overhead and limitation of this PMU approach, or
whether there are any platform it's not yet supported, worth a survey.

> 
>> In order to address this, we introduced new per-cgroup statistic
>> for numa:
>>   * the numa locality to imply the numa balancing efficiency
>>   * the numa execution time on each node
>>
[snip]
>> +#ifdef CONFIG_PROC_SYSCTL
>> +int sysctl_cg_numa_stat(struct ctl_table *table, int write,
>> +			 void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	struct ctl_table t;
>> +	int err;
>> +	int state = static_branch_likely(&sched_cg_numa_stat);
>> +
>> +	if (write && !capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	t = *table;
>> +	t.data = &state;
>> +	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
>> +	if (err < 0 || !write)
>> +		return err;
>> +
>> +	if (state)
>> +		static_branch_enable(&sched_cg_numa_stat);
>> +	else
>> +		static_branch_disable(&sched_cg_numa_stat);
>> +
>> +	return err;
>> +}
>> +#endif
>> +
> 
> Why is this implemented as a toggle? I'm finding it hard to make sense
> of this. The numa_stat should not even exist if the feature is disabled.

numa_stat will not exist if CONFIG is not enabled, do you mean it should
also disappear when dynamically turn off?

> 
> Assuming that is fixed then the runtime overhead is fine but the same
> issues with the quality of the information relying on NUMA balancing
> limits the usefulness of this. Disabling NUMA balancing or the scan rate
> dropping to a very low frequency would lead in misleading conclusions as
> well as false positives if the CPU and memory policies force remote memory
> usage. Similarly, the timing of the information available is variable du
> to how numa_faults_locality gets reset so sometimes the information is
> fine-grained and sometimes it's coarse grained. It will also pretend to
> display useful information even if NUMA balancing is disabled.

The data just represent what we traced on NUMA balancing PF, so yes folks
need some understanding on NUMA balancing to figure out the real meaning
behind locality.

We want it to tell the real story, if NUMA balancing disabled or scan rate
dropped very low, the locality increments should be very small, when it
keep failing for memory policy or CPU binding reason, we want it to tell how
bad it is, locality just show us how NUMA Balancing is performing, the data
could contains many information since how OS dealing with NUMA could be
complicated...

> 
> I find it hard to believe it would be useful in practice and I think users
> would have real trouble interpreting the data given how much it relies on
> internal implementation details of NUMA balancing. I cannot be certain
> as clearly something motivated the creation of this patch although it's
> unclear if it has ever been used to debug and fix an actual problem in
> the field. Hence, I'm neutral on the patch and will neither ack or nack
> it and will defer to the scheduler maintainers but if I was pushed on it,
> I would be disinclined to merge the patch due to the potential confusion
> caused by users who believe it provides accurate information when at best
> it gives a rough approximation with variable granularity.

We have our cluster enabled this feature already, an old version though but
still helpful, when we want to debug NUMA issues, this could give good hints.

Consider it as load_1/5/15 which not accurate but tell the trend of system
behavior, locality giving the trend of NUMA Balancing as long as it's working,
when increasing slowly it means locality already good enough or no more memory
to adjust, and that's fine, for those who disabled the NUMA Balancing, they do
their own NUMA optimization and find their own ways to estimate the results.

Anyway, we thanks for all those good inputs from your side :-)

Regards,
Michael Wang

