Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DEA62B411
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiKPHhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 02:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKPHhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:37:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A88E088;
        Tue, 15 Nov 2022 23:37:21 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBvtp5rqCzJnmQ;
        Wed, 16 Nov 2022 15:34:10 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:37:19 +0800
Received: from [10.174.178.93] (10.174.178.93) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:37:18 +0800
Message-ID: <241e837b-056a-4fde-0673-205bd7400e82@huawei.com>
Date:   Wed, 16 Nov 2022 15:37:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] sched/fair: Introduce priority load balance for CFS
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20221102035301.512892-1-zhangsong34@huawei.com>
 <CAKfTPtCcYySw2ZC_pr8=3KFPmAAVN=1h8=5jWkW5YXyy11sehg@mail.gmail.com>
 <b45f96b6-e0b2-22bb-eda1-2468d6fbe104@huawei.com>
 <CAKfTPtDrWCenxtVcunjS3pGD81TdLf2EkhO_YcdfxnUHXpVF3w@mail.gmail.com>
 <4bad43c0-40a4-dc39-7214-f2c3321a47ee@huawei.com>
 <CAKfTPtCwUvkqnzs9n0G+cyE5h5QdgwoKF-gNu+4A5g4NHNRe9w@mail.gmail.com>
 <7d887171-491a-1d36-0926-d0486aacc9c2@huawei.com>
 <CAKfTPtCHZm2AKemnpE1UvQPsgpB5ycFdjkJa1pHQS-=DYJ2-KA@mail.gmail.com>
 <CAKfTPtAMdQD9S-mbLszeu2pjB4YB2A+1OM5NUV_2xDzCTCc7Qw@mail.gmail.com>
From:   Song Zhang <zhangsong34@huawei.com>
In-Reply-To: <CAKfTPtAMdQD9S-mbLszeu2pjB4YB2A+1OM5NUV_2xDzCTCc7Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.93]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/15 15:18, Vincent Guittot wrote:
> On Mon, 14 Nov 2022 at 17:42, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Sat, 12 Nov 2022 at 03:51, Song Zhang <zhangsong34@huawei.com> wrote:
>>>
>>> Hi, Vincent
>>>
>>> On 2022/11/3 17:22, Vincent Guittot wrote:
>>>> On Thu, 3 Nov 2022 at 10:20, Song Zhang <zhangsong34@huawei.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2022/11/3 16:33, Vincent Guittot wrote:
>>>>>> On Thu, 3 Nov 2022 at 04:01, Song Zhang <zhangsong34@huawei.com> wrote:
>>>>>>>
>>>>>>> Thanks for your reply!
>>>>>>>
>>>>>>> On 2022/11/3 2:01, Vincent Guittot wrote:
>>>>>>>> On Wed, 2 Nov 2022 at 04:54, Song Zhang <zhangsong34@huawei.com> wrote:
>>>>>>>>>
>>>>>>>>
>>>>>>>> This really looks like a v3 of
>>>>>>>> https://lore.kernel.org/all/20220810015636.3865248-1-zhangsong34@huawei.com/
>>>>>>>>
>>>>>>>> Please keep versioning.
>>>>>>>>
>>>>>>>>> Add a new sysctl interface:
>>>>>>>>> /proc/sys/kernel/sched_prio_load_balance_enabled
>>>>>>>>
>>>>>>>> We don't want to add more sysctl knobs for the scheduler, we even
>>>>>>>> removed some. Knob usually means that you want to fix your use case
>>>>>>>> but the solution doesn't make sense for all cases.
>>>>>>>>
>>>>>>>
>>>>>>> OK, I will remove this knobs later.
>>>>>>>
>>>>>>>>>
>>>>>>>>> 0: default behavior
>>>>>>>>> 1: enable priority load balance for CFS
>>>>>>>>>
>>>>>>>>> For co-location with idle and non-idle tasks, when CFS do load balance,
>>>>>>>>> it is reasonable to prefer migrating non-idle tasks and migrating idle
>>>>>>>>> tasks lastly. This will reduce the interference by SCHED_IDLE tasks
>>>>>>>>> as much as possible.
>>>>>>>>
>>>>>>>> I don't agree that it's always the best choice to migrate a non-idle task 1st.
>>>>>>>>
>>>>>>>> CPU0 has 1 non idle task and CPU1 has 1 non idle task and hundreds of
>>>>>>>> idle task and there is an imbalance between the 2 CPUS: migrating the
>>>>>>>> non idle task from CPU1 to CPU0 is not the best choice
>>>>>>>>
>>>>>>>
>>>>>>> If the non idle task on CPU1 is running or cache hot, it cannot be
>>>>>>> migrated and idle tasks can also be migrated from CPU1 to CPU0. So I
>>>>>>> think it does not matter.
>>>>>>
>>>>>> What I mean is that migrating non idle tasks first is not a universal
>>>>>> win and not always what we want.
>>>>>>
>>>>>
>>>>> But migrating online tasks first is mostly a trade-off that
>>>>> non-idle(Latency Sensitive) tasks can obtain more CPU time and minimize
>>>>> the interference caused by IDLE tasks. I think this makes sense in most
>>>>> cases, or you can point out what else I need to think about it ?
>>>>>
>>>>> Best regards.
>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> Testcase:
>>>>>>>>> - Spawn large number of idle(SCHED_IDLE) tasks occupy CPUs
>>>>>>>>
>>>>>>>> What do you mean by a large number ?
>>>>>>>>
>>>>>>>>> - Let non-idle tasks compete with idle tasks for CPU time.
>>>>>>>>>
>>>>>>>>> Using schbench to test non-idle tasks latency:
>>>>>>>>> $ ./schbench -m 1 -t 10 -r 30 -R 200
>>>>>>>>
>>>>>>>> How many CPUs do you have ?
>>>>>>>>
>>>>>>>
>>>>>>> OK, some details may not be mentioned.
>>>>>>> My virtual machine has 8 CPUs running with a schbench process and 5000
>>>>>>> idle tasks. The idle task is a while dead loop process below:
>>>>>>
>>>>>> How can you care about latency when you start 10 workers on 8 vCPUs
>>>>>> with 5000 non idle threads ?
>>>>>>
>>>>>
>>>>> No no no... spawn 5000 idle(SCHED_IDLE) processes not 5000 non-idle
>>>>> threads, and with 10 non-idle schbench workers on 8 vCPUs.
>>>>
>>>> yes spawn 5000 idle tasks but my point remains the same
>>>>
>>>
>>> I am so sorry that I have not received your reply for a long time, and I
>>> am still waiting for it anxiously. In fact, migrating non-idle tasks 1st
>>> works well in most scenarios, so it maybe possible to add a
>>> sched_feat(LB_PRIO) to enable or disable that. Finally, I really hope
>>> you can give me some better advice.
>>
>> I have seen that you posted a v4 5 days ago which is on my list to be reviewed.
>>
>> My concern here remains that selecting non idle task 1st is not always
>> the best choices as for example when you have 1 non idle task per cpu
>> and thousands of idle tasks moving around. Then regarding your use
>> case, the weight of the 5000 idle threads is around twice more than
>> the weight of your non idle bench: sum weight of idle threads is 15k
>> whereas the weight of your bench is around 6k IIUC how RPS run. This
>> also means that the idle threads will take a significant times of the
>> system: 5000 / 7000 ticks. I don't understand how you can care about
>> latency in such extreme case and I'm interested to get the real use
>> case where you can have such situation.
>>
>> All that to say that idle task remains cfs task with a small but not
>> null weight and we should not make them special other than by not
>> preempting at wakeup.
> 
> Also, as mentioned for a previous version, a task with nice prio 19
> has a weight of 15 so if you replace the 5k idle threads with 1k cfs
> w/ nice prio 19 threads, you will face a similar problem. So you can't
> really care only on the idle property of a task
> 

Well, my original idea was to consider interference between tasks of 
different priorities when doing CFS load balancing to ensure that 
non-idle tasks get more CPU scheduler time without changing the native 
CFS load balancing policy.

Consider a simple scenario. Assume that CPU 0 has two non-idle tasks 
whose weight is 1024 * 2 = 2048, also CPU 0 has 1000 idle tasks whose 
weight is 1K x 15 = 15K. CPU 1 is idle. Therefore, IDLE load balance is 
triggered. CPU 1 needs to pull a certain number of tasks from CPU 0. If 
we do not considerate task priorities and interference between tasks, 
more than 600 idle tasks on CPU 0 may be migrated to CPU 1. As a result, 
two non-idle tasks still compete on CPU 0. However, CPU 1 is running 
with all idle but not non-idle tasks.

Let's calculate the percentage of CPU time gained by non-idle tasks in a 
scheduling period:

CPU 1: time_percent(non-idle tasks) = 0
CPU 0: time_percent(non-idle tasks) = 2048 * 2 / (2048 + 15000) = 24%

On the other hand, if we consider the interference between different 
task priorities, we change the migration policy to firstly migrate an 
non-idle task on CPU 0 to CPU 1. Migrating idle tasks on CPU 0 maybe 
interfered with the non-idle task on CPU 1. So we decide to migrate idle 
tasks on CPU 0 after non-idle tasks on CPU 1 are completed or exited.

Now the percentage of the CPU time obtained by the non-idle tasks in a 
scheduling period is as follows:

CPU 1: time_percent(non-idle tasks) = 1024 / 1024 = 100%
CPU 0: time_percent(non-idle tasks) = 1024 / (1024 + 15000) = 6.4%

Obviously, if load balance migration tasks prefer migrate non-idle tasks 
and suppress the interference of idle tasks migration on non-idle tasks, 
the latency of non-idle tasks can be significantly reduced. Although 
this will cause some idle tasks imbalance between different CPUs and 
reduce throughput of idle tasks., I think this strategy is feasible in 
some real-time business scenarios for latency tasks.

>>
>>>
>>> Best regards.
>>>
>>> Song Zhang
> .
