Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B31762D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 03:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGIBcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 21:32:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54914 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfGIBcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:32:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 65E8E9626F508A4C9E8E;
        Tue,  9 Jul 2019 09:32:33 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 9 Jul 2019
 09:32:23 +0800
Subject: Re: [PATCH next v2] softirq: enable MAX_SOFTIRQ_TIME tuning with
 sysctl, max_softirq_time_msecs
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     <tglx@linutronix.de>, <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <manfred@colorfullife.com>, <jwilk@jwilk.net>,
        <dvyukov@google.com>, <feng.tang@intel.com>,
        <sunilmut@microsoft.com>, <quentin.perret@arm.com>,
        <linux@leemhuis.info>, <alex.popov@linux.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <tedheadster@gmail.com>
References: <53770380-053e-70b6-f75e-a0e00bf35c30@huawei.com>
 <64823387-b0f7-a838-01ea-24ae386f2272@huawei.com>
Message-ID: <030c8047-73e1-59c0-772d-d1ca4e1a6fb6@huawei.com>
Date:   Tue, 9 Jul 2019 09:32:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <64823387-b0f7-a838-01ea-24ae386f2272@huawei.com>
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Friendly ping ...

On 2019/6/28 14:52, Zhiqiang Liu wrote:
> Friendly ping ...
> 
> On 2019/6/25 11:13, Zhiqiang Liu wrote:
>> From: Zhiqiang liu <liuzhiqiang26@huawei.com>
>>
>> In __do_softirq func, MAX_SOFTIRQ_TIME was set to 2ms via experimentation by
>> commit c10d73671 ("softirq: reduce latencies") in 2013, which was designed
>> to reduce latencies for various network workloads. The key reason is that the
>> maximum number of microseconds in one NAPI polling cycle in net_rx_action func
>> was set to 2 jiffies, so different HZ settting will lead to different latencies.
>>
>> However, commit 7acf8a1e8 ("Replace 2 jiffies with sysctl netdev_budget_usecs
>> to enable softirq tuning") adopts netdev_budget_usecs to tun maximum number of
>> microseconds in one NAPI polling cycle. So the latencies of net_rx_action can be
>> controlled by sysadmins to copy with hardware changes over time.
>>
>> Correspondingly, the MAX_SOFTIRQ_TIME should be able to be tunned by sysadmins,
>> who knows best about hardware performance, for excepted tradeoff between latence
>> and fairness. Here, we add sysctl variable max_softirq_time_msecs to replace
>> MAX_SOFTIRQ_TIME with 2ms default value.
>>
>> Note: max_softirq_time_msecs will be coverted to jiffies, and any budget
>> value will be rounded up to the next jiffies, which relates to CONFIG_HZ.
>> The time accuracy of jiffies will result in a certain difference
>> between the setting jiffies of max_softirq_time_msecs and the actual
>> value, which is in one jiffies range.
>>
>> Signed-off-by: Zhiqiang liu <liuzhiqiang26@huawei.com>
>> ---
>>  Documentation/sysctl/kernel.txt | 17 +++++++++++++++++
>>  kernel/softirq.c                |  8 +++++---
>>  kernel/sysctl.c                 |  9 +++++++++
>>  3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
>> index f0c86fbb3b48..23b36393f150 100644
>> --- a/Documentation/sysctl/kernel.txt
>> +++ b/Documentation/sysctl/kernel.txt
>> @@ -44,6 +44,7 @@ show up in /proc/sys/kernel:
>>  - kexec_load_disabled
>>  - kptr_restrict
>>  - l2cr                        [ PPC only ]
>> +- max_softirq_time_msecs
>>  - modprobe                    ==> Documentation/debugging-modules.txt
>>  - modules_disabled
>>  - msg_next_id		      [ sysv ipc ]
>> @@ -445,6 +446,22 @@ This flag controls the L2 cache of G3 processor boards. If
>>
>>  ==============================================================
>>
>> +max_softirq_time_msecs:
>> +
>> +Maximum number of milliseconds to break the loop of restarting softirq
>> +processing for at most MAX_SOFTIRQ_RESTART times in __do_softirq().
>> +max_softirq_time_msecs will be coverted to jiffies, and any budget
>> +value will be rounded up to the next jiffies, which relates to CONFIG_HZ.
>> +The time accuracy of jiffies will result in a certain difference
>> +between the setting jiffies of max_softirq_time_msecs and the actual
>> +value, which is in one jiffies range.
>> +
>> +max_softirq_time_msecs is a non-negative integer value, and setting
>> +negative value is meaningless and will return error.
>> +Default: 2
>> +
>> +==============================================================
>> +
>>  modules_disabled:
>>
>>  A toggle value indicating if modules are allowed to be loaded
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index a6b81c6b6bff..1e456db70093 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -199,7 +199,8 @@ EXPORT_SYMBOL(__local_bh_enable_ip);
>>
>>  /*
>>   * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
>> - * but break the loop if need_resched() is set or after 2 ms.
>> + * but break the loop if need_resched() is set or after
>> + * max_softirq_time_msecs msecs.
>>   * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
>>   * certain cases, such as stop_machine(), jiffies may cease to
>>   * increment and so we need the MAX_SOFTIRQ_RESTART limit as
>> @@ -210,7 +211,7 @@ EXPORT_SYMBOL(__local_bh_enable_ip);
>>   * we want to handle softirqs as soon as possible, but they
>>   * should not be able to lock up the box.
>>   */
>> -#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
>> +unsigned int __read_mostly max_softirq_time_msecs = 2;
>>  #define MAX_SOFTIRQ_RESTART 10
>>
>>  #ifdef CONFIG_TRACE_IRQFLAGS
>> @@ -248,7 +249,8 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
>>
>>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>>  {
>> -	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
>> +	unsigned long end = jiffies +
>> +		msecs_to_jiffies(max_softirq_time_msecs);
>>  	unsigned long old_flags = current->flags;
>>  	int max_restart = MAX_SOFTIRQ_RESTART;
>>  	struct softirq_action *h;
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 1beca96fb625..96ff292ce7f6 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -118,6 +118,7 @@ extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
>>  #ifndef CONFIG_MMU
>>  extern int sysctl_nr_trim_pages;
>>  #endif
>> +extern unsigned int max_softirq_time_msecs;
>>
>>  /* Constants used for minimum and  maximum */
>>  #ifdef CONFIG_LOCKUP_DETECTOR
>> @@ -1276,6 +1277,14 @@ static struct ctl_table kern_table[] = {
>>  		.extra2		= &one,
>>  	},
>>  #endif
>> +	{
>> +		.procname	= "max_softirq_time_msecs",
>> +		.data		= &max_softirq_time_msecs,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler   = proc_dointvec_minmax,
>> +		.extra1		= &zero,
>> +	},
>>  	{ }
>>  };
>>
> 
> 
> .
> 

