Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB53626682
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 03:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiKLCvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 21:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKLCvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 21:51:16 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96064A3E;
        Fri, 11 Nov 2022 18:51:14 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N8Kns1051z15MV3;
        Sat, 12 Nov 2022 10:50:57 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:51:13 +0800
Received: from [10.174.178.93] (10.174.178.93) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 10:51:12 +0800
Message-ID: <7d887171-491a-1d36-0926-d0486aacc9c2@huawei.com>
Date:   Sat, 12 Nov 2022 10:51:11 +0800
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
From:   Song Zhang <zhangsong34@huawei.com>
In-Reply-To: <CAKfTPtCwUvkqnzs9n0G+cyE5h5QdgwoKF-gNu+4A5g4NHNRe9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.93]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi, Vincent

On 2022/11/3 17:22, Vincent Guittot wrote:
> On Thu, 3 Nov 2022 at 10:20, Song Zhang <zhangsong34@huawei.com> wrote:
>>
>>
>>
>> On 2022/11/3 16:33, Vincent Guittot wrote:
>>> On Thu, 3 Nov 2022 at 04:01, Song Zhang <zhangsong34@huawei.com> wrote:
>>>>
>>>> Thanks for your reply!
>>>>
>>>> On 2022/11/3 2:01, Vincent Guittot wrote:
>>>>> On Wed, 2 Nov 2022 at 04:54, Song Zhang <zhangsong34@huawei.com> wrote:
>>>>>>
>>>>>
>>>>> This really looks like a v3 of
>>>>> https://lore.kernel.org/all/20220810015636.3865248-1-zhangsong34@huawei.com/
>>>>>
>>>>> Please keep versioning.
>>>>>
>>>>>> Add a new sysctl interface:
>>>>>> /proc/sys/kernel/sched_prio_load_balance_enabled
>>>>>
>>>>> We don't want to add more sysctl knobs for the scheduler, we even
>>>>> removed some. Knob usually means that you want to fix your use case
>>>>> but the solution doesn't make sense for all cases.
>>>>>
>>>>
>>>> OK, I will remove this knobs later.
>>>>
>>>>>>
>>>>>> 0: default behavior
>>>>>> 1: enable priority load balance for CFS
>>>>>>
>>>>>> For co-location with idle and non-idle tasks, when CFS do load balance,
>>>>>> it is reasonable to prefer migrating non-idle tasks and migrating idle
>>>>>> tasks lastly. This will reduce the interference by SCHED_IDLE tasks
>>>>>> as much as possible.
>>>>>
>>>>> I don't agree that it's always the best choice to migrate a non-idle task 1st.
>>>>>
>>>>> CPU0 has 1 non idle task and CPU1 has 1 non idle task and hundreds of
>>>>> idle task and there is an imbalance between the 2 CPUS: migrating the
>>>>> non idle task from CPU1 to CPU0 is not the best choice
>>>>>
>>>>
>>>> If the non idle task on CPU1 is running or cache hot, it cannot be
>>>> migrated and idle tasks can also be migrated from CPU1 to CPU0. So I
>>>> think it does not matter.
>>>
>>> What I mean is that migrating non idle tasks first is not a universal
>>> win and not always what we want.
>>>
>>
>> But migrating online tasks first is mostly a trade-off that
>> non-idle(Latency Sensitive) tasks can obtain more CPU time and minimize
>> the interference caused by IDLE tasks. I think this makes sense in most
>> cases, or you can point out what else I need to think about it ?
>>
>> Best regards.
>>
>>>>
>>>>>>
>>>>>> Testcase:
>>>>>> - Spawn large number of idle(SCHED_IDLE) tasks occupy CPUs
>>>>>
>>>>> What do you mean by a large number ?
>>>>>
>>>>>> - Let non-idle tasks compete with idle tasks for CPU time.
>>>>>>
>>>>>> Using schbench to test non-idle tasks latency:
>>>>>> $ ./schbench -m 1 -t 10 -r 30 -R 200
>>>>>
>>>>> How many CPUs do you have ?
>>>>>
>>>>
>>>> OK, some details may not be mentioned.
>>>> My virtual machine has 8 CPUs running with a schbench process and 5000
>>>> idle tasks. The idle task is a while dead loop process below:
>>>
>>> How can you care about latency when you start 10 workers on 8 vCPUs
>>> with 5000 non idle threads ?
>>>
>>
>> No no no... spawn 5000 idle(SCHED_IDLE) processes not 5000 non-idle
>> threads, and with 10 non-idle schbench workers on 8 vCPUs.
> 
> yes spawn 5000 idle tasks but my point remains the same
> 

I am so sorry that I have not received your reply for a long time, and I 
am still waiting for it anxiously. In fact, migrating non-idle tasks 1st 
works well in most scenarios, so it maybe possible to add a 
sched_feat(LB_PRIO) to enable or disable that. Finally, I really hope 
you can give me some better advice.

Best regards.

Song Zhang
