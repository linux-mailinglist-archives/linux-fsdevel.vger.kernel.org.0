Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1065526E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfFYOrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 10:47:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:19110 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730505AbfFYOrD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:47:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 94D0D86399F050714BE1;
        Tue, 25 Jun 2019 22:46:57 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Jun 2019
 22:46:47 +0800
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
 <0099726a-ead3-bdbe-4c66-c8adc9a4f11b@huawei.com>
 <alpine.DEB.2.21.1906241141370.32342@nanos.tec.linutronix.de>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <c1b7a345-fa22-e52a-4db8-1f1288e7ad15@huawei.com>
Date:   Tue, 25 Jun 2019 22:46:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906241141370.32342@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Thomas,

On 2019/6/24 17:45, Thomas Gleixner wrote:
> Zhiqiang,
> 
> On Mon, 24 Jun 2019, Zhiqiang Liu wrote:
>>
>> Thanks again for your detailed advice.
>> As your said, the max_softirq_time_usecs setting without explaining the
>> relationship with CONFIG_HZ will give a false sense of controlability. And
>> the time accuracy of jiffies will result in a certain difference between the
>> max_softirq_time_usecs set value and the actual value, which is in one jiffies
>> range.
>>
>> I will add these infomation in the sysctl documentation and changelog in v2 patch.
> 
> Please make the sysctl milliseconds based. That's the closest approximation
> of useful units for this. This still has the same issues as explained
> before but it's not off by 3 orders of magitude anymore.
>

I have a doubt about _msecs_to_jiffies funcs, especially when input m is equal to 0.

For different HZ setttings, different _msecs_to_jiffies funcs will be chosen for
msecs_to_jiffies func. However, the performance of different _msecs_to_jiffies is
inconsistent with input m is equal to 0.
If HZ satisfies the condition: HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ), the return
value of _msecs_to_jiffies func with m=0 is different with different HZ setting.
------------------------------------
| HZ |	MSEC_PER_SEC / HZ | return |
------------------------------------
|1000|		1	  |   0	   |
|500 |		2	  |   1	   |
|200 |		5	  |   1	   |
|100 |		10	  |   1	   |
------------------------------------

Why only the return value of HZ=1000 is equal to 0 with m=0 ?

Codes are given as follows,
    #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
    static inline unsigned long _msecs_to_jiffies(const unsigned int m)
    {
            return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
    }
    #elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
    static inline unsigned long _msecs_to_jiffies(const unsigned int m)
    {
            if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
                    return MAX_JIFFY_OFFSET;
            return m * (HZ / MSEC_PER_SEC);
    }
    #else
    static inline unsigned long _msecs_to_jiffies(const unsigned int m)
    {
            if (HZ > MSEC_PER_SEC && m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
                    return MAX_JIFFY_OFFSET;

            return (MSEC_TO_HZ_MUL32 * m + MSEC_TO_HZ_ADJ32) >> MSEC_TO_HZ_SHR32;
    }








> Thanks,
> 
> 	tglx
> 

