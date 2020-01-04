Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4351300D7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 05:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgADEvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 23:51:46 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36249 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgADEvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 23:51:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TmmVgCV_1578113497;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TmmVgCV_1578113497)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jan 2020 12:51:38 +0800
Subject: Re: [PATCH v6 1/2] sched/numa: introduce per-cgroup NUMA locality
 info
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
 <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
 <443641e7-f968-0954-5ff6-3b7e7fed0e83@linux.alibaba.com>
 <d2c4cace-623a-9317-c957-807e3875aa4a@linux.alibaba.com>
 <275a98ed-35b8-b65f-3600-64ab722dd836@linux.alibaba.com>
 <20200103151449.GA25747@blackbody.suse.cz>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <b32569f2-3f5c-06f3-dba7-67351a019c42@linux.alibaba.com>
Date:   Sat, 4 Jan 2020 12:51:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200103151449.GA25747@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/1/3 下午11:14, Michal Koutný wrote:
> Hi.
> 
> On Fri, Dec 13, 2019 at 09:47:36AM +0800, 王贇 <yun.wang@linux.alibaba.com> wrote:
>> By monitoring the increments, we will be able to locate the per-cgroup
>> workload which NUMA Balancing can't helpwith (usually caused by wrong
>> CPU and memory node bindings), then we got chance to fix that in time.
> I just wonder do the data based on increments match with those you
> obtained previously?

They have different meaning, since now it's just the accumulation of
local/remote page access counter, we have to increasing the sample
period into the maximum NUMA balancing scan period, to my system it's
1 minute.

We still get useful information from the increments, for example:
  local 100 remote 1000 <-- bad locality in last period
  local 0 remote 0 <-- no scan or NUMA PF happened in last period
  local 100 remote 0 <-- good locality but not much PF happened

So I won't say they are matched, they tell the story in different way :-P

> 
>> +static inline void
>> +update_task_locality(struct task_struct *p, int pnid, int cnid, int pages)
>> +{
>> +	if (!static_branch_unlikely(&sched_numa_locality))
>> +		return;
>> +
>> +	/*
>> +	 * pnid != cnid --> remote idx 0
>> +	 * pnid == cnid --> local idx 1
>> +	 */
>> +	p->numa_page_access[!!(pnid == cnid)] += pages;
> If the per-task information isn't used anywhere, why not accumulate
> directly into task's cfs_rq->{local,remote}_page_access?
> 

This is try to avoid hierarchy update in each PF, accumulate the counter
and update together should cost less.

Besides, as they won't be reset now, maybe we could expose them too.

>> @@ -4298,6 +4359,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>>  	 */
>>  	update_load_avg(cfs_rq, curr, UPDATE_TG);
>>  	update_cfs_group(curr);
>> +	update_group_locality(cfs_rq);
> With the per-NUMA node time tracked separately, isn't it unnecessary
> doing group updates inside entity_tick? 

The hierarchy update can't be saved, and this is a good place where we
already holding rq lock, iterate cfs_rq in hierarchy for current task.

Regards,
Michael Wang

> 
> 
> Regards,
> Michal
> 
