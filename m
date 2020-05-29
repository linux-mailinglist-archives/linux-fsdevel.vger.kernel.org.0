Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A521B1E769C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 09:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgE2H1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 03:27:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgE2H1f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 03:27:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4C47CEE2736375FBA807;
        Fri, 29 May 2020 15:27:33 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 15:27:22 +0800
Subject: Re: [PATCH v4 1/4] sysctl: Add register_sysctl_init() interface
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>,
        <gpiccoli@canonical.com>, <rdna@fb.com>, <patrick.bellasi@arm.com>,
        <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <penguin-kernel@i-love.sakura.ne.jp>,
        <vbabka@suse.cz>, <tglx@linutronix.de>, <peterz@infradead.org>,
        <Jisheng.Zhang@synaptics.com>, <khlebnikov@yandex-team.ru>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <1589859071-25898-2-git-send-email-nixiaoming@huawei.com>
 <20200529070903.GV11244@42.do-not-panic.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <3d2d4b2e-db9e-aa91-dd29-e15d24028964@huawei.com>
Date:   Fri, 29 May 2020 15:27:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200529070903.GV11244@42.do-not-panic.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/29 15:09, Luis Chamberlain wrote:
> On Tue, May 19, 2020 at 11:31:08AM +0800, Xiaoming Ni wrote:
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -3358,6 +3358,25 @@ int __init sysctl_init(void)
>>   	kmemleak_not_leak(hdr);
>>   	return 0;
>>   }
>> +
>> +/*
>> + * The sysctl interface is used to modify the interface value,
>> + * but the feature interface has default values. Even if register_sysctl fails,
>> + * the feature body function can also run. At the same time, malloc small
>> + * fragment of memory during the system initialization phase, almost does
>> + * not fail. Therefore, the function return is designed as void
>> + */
> 
> Let's use kdoc while at it. Can you convert this to proper kdoc?
> 
Sorry, I do n¡¯t know the format requirements of Kdoc, can you give me 
some tips for writing?


>> +void __init register_sysctl_init(const char *path, struct ctl_table *table,
>> +				 const char *table_name)
>> +{
>> +	struct ctl_table_header *hdr = register_sysctl(path, table);
>> +
>> +	if (unlikely(!hdr)) {
>> +		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
>> +		return;
> 
> table_name is only used for this, however we can easily just make
> another _register_sysctl_init() helper first, and then use a macro
> which will concatenate this to something useful if you want to print
> a string. I see no point in the description for this, specially since
> the way it was used was not to be descriptive, but instead just a name
> followed by some underscore and something else.
> 
Good idea, I will fix and send the patch to you as soon as possible

>> +	}
>> +	kmemleak_not_leak(hdr);
> 
> Is it *wrong* to run kmemleak_not_leak() when hdr was not allocated?
> If so, can you fix the sysctl __init call itself?
I don't understand here, do you mean that register_sysctl_init () does 
not need to call kmemleak_not_leak (hdr), or does it mean to add check 
hdr before calling kmemleak_not_leak (hdr) in sysctl_init ()?


> PS. Since you have given me your series, feel free to send me a patch
> as a follow up to this in privae and I can integrate it into my tree.
> 
>    Luis
> 

Thanks
Xiaoming Ni


