Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A214D5006A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 06:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfFXEB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 00:01:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfFXEB2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:01:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A030B2BC4CFD26FB6995;
        Mon, 24 Jun 2019 12:01:24 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 12:01:13 +0800
Subject: Re: [PATCH next] softirq: enable MAX_SOFTIRQ_TIME tuning with sysctl
 max_softirq_time_usecs
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, <akpm@linux-foundation.org>,
        <manfred@colorfullife.com>, <jwilk@jwilk.net>,
        <dvyukov@google.com>, <feng.tang@intel.com>,
        <sunilmut@microsoft.com>, <quentin.perret@arm.com>,
        <linux@leemhuis.info>, <alex.popov@linux.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <tedheadster@gmail.com>,
        Eric Dumazet <edumazet@google.com>
References: <f274f85a-bbb6-3e32-b293-1d5d7f27a98f@huawei.com>
 <alpine.DEB.2.21.1906231820470.32342@nanos.tec.linutronix.de>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <0099726a-ead3-bdbe-4c66-c8adc9a4f11b@huawei.com>
Date:   Mon, 24 Jun 2019 12:01:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906231820470.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


ÔÚ 2019/6/24 0:38, Thomas Gleixner Ð´µÀ:
> Zhiqiang,
>> controlled by sysadmins to copy with hardware changes over time.
> 
> So much for the theory. See below.

Thanks for your reply.
> 
>> Correspondingly, the MAX_SOFTIRQ_TIME should be able to be tunned by sysadmins,
>> who knows best about hardware performance, for excepted tradeoff between latence
>> and fairness.
>>
>> Here, we add sysctl variable max_softirq_time_usecs to replace MAX_SOFTIRQ_TIME
>> with 2ms default value.
> 
> ...
> 
>>   */
>> -#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
>> +unsigned int __read_mostly max_softirq_time_usecs = 2000;
>>  #define MAX_SOFTIRQ_RESTART 10
>>
>>  #ifdef CONFIG_TRACE_IRQFLAGS
>> @@ -248,7 +249,8 @@ static inline void lockdep_softirq_end(bool in_hardirq) { }
>>
>>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>>  {
>> -	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
>> +	unsigned long end = jiffies +
>> +		usecs_to_jiffies(max_softirq_time_usecs);
> 
> That's still jiffies based and therefore depends on CONFIG_HZ. Any budget
> value will be rounded up to the next jiffie. So in case of HZ=100 and
> time=1000us this will still result in 10ms of allowed loop time.
> 
> I'm not saying that we must use a more fine grained time source, but both
> the changelog and the sysctl documentation are misleading.
> 
> If we keep it jiffies based, then microseconds do not make any sense. They
> just give a false sense of controlability.
> 
> Keep also in mind that with jiffies the accuracy depends also on the
> distance to the next tick when 'end' is evaluated. The next tick might be
> imminent.
> 
> That's all information which needs to be in the documentation.
> 

Thanks again for your detailed advice.
As your said, the max_softirq_time_usecs setting without explaining the
relationship with CONFIG_HZ will give a false sense of controlability. And
the time accuracy of jiffies will result in a certain difference between the
max_softirq_time_usecs set value and the actual value, which is in one jiffies
range.

I will add these infomation in the sysctl documentation and changelog in v2 patch.

>> +	{
>> +		.procname	= "max_softirq_time_usecs",
>> +		.data		= &max_softirq_time_usecs,
>> +		.maxlen		= sizeof(unsigned int),
>> +		.mode		= 0644,
>> +		.proc_handler   = proc_dointvec_minmax,
>> +		.extra1		= &zero,
>> +	},
> 
> Zero as the lower limit? That means it allows a single loop. Fine, but
> needs to be documented as well.
> 
> Thanks,
> 
> 	tglx
> 
> .
> 

