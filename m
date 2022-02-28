Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533284C60AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 02:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiB1Blo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 20:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiB1Blo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 20:41:44 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55933A2B;
        Sun, 27 Feb 2022 17:41:05 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K6NMm1nFwzBrL4;
        Mon, 28 Feb 2022 09:39:16 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 09:41:03 +0800
Received: from [10.67.109.84] (10.67.109.84) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 09:41:03 +0800
Message-ID: <5cbe7a03-5e11-d6fd-2693-4db732675e85@huawei.com>
Date:   Mon, 28 Feb 2022 09:41:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls
 into its own file
To:     Baoquan He <bhe@redhat.com>
CC:     <ebiederm@xmission.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <zengweilin@huawei.com>,
        <chenjianguo3@huawei.com>, <nixiaoming@huawei.com>,
        <qiuguorui1@huawei.com>, <young.liuyang@huawei.com>
References: <20220223030318.213093-1-yingelin@huawei.com>
 <YhXwkTCwt3a4Dn9T@MiWiFi-R3L-srv>
 <c60419f8-422b-660d-8254-291182a06cbe@huawei.com> <Yhbu6UxoYXFtDyFk@fedora>
From:   yingelin <yingelin@huawei.com>
In-Reply-To: <Yhbu6UxoYXFtDyFk@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.84]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/2/24 10:35, Baoquan He 写道:
> On 02/24/22 at 09:04am, yingelin wrote:
>> 在 2022/2/23 16:30, Baoquan He 写道:
>>> On 02/23/22 at 11:03am, yingelin wrote:
>>>> This move the kernel/kexec_core.c respective sysctls to its own file.
>>> Hmm, why is the move needed?
>>>
>>> With my understanding, sysctls are all put in kernel/sysctl.c,
>>> why is kexec special?
>> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty dishes,
>>
>> this makes it very difficult to maintain. The proc sysctl maintainers do not
>> want to
>>
>> know what sysctl knobs you wish to add for your own piece of code, we
>>
>> just care about the core logic.
>>
>> This patch moves the kexec sysctls to the place where they actually belong
>> to help
> That seems to be an issue everything related to sysctl are all added to
> kernel/sysctl.c. Do you have a pointer that someone complained about it
> and people agree to scatter them into their own component code?

I'm sorry to reply you too late, the link is

https://lkml.kernel.org/r/20220226031054.47DF8C340E7@smtp.kernel.org

> I understand your concern now, I am personally not confused by that
> maybe because I haven't got stuff adding or changing into sysctls. My
> concern is if we only care and move kexec knob, or we have plan to try
> to move all of them. If there's some background information or
> discussion with a link, that would be helpful.

Yeah, we are going to move all sysctls to their own places, in fact, all 
the filesystem

sysctls are moved out already. I'm sorry I didn't express it clearly. 
I'll fix it in v2 patch.

>
> Thanks
> Baoquan
>
>> with this maintenance.
>>
>>>> Signed-off-by: yingelin <yingelin@huawei.com>
>>>> ---
>>>>    kernel/kexec_core.c | 20 ++++++++++++++++++++
>>>>    kernel/sysctl.c     | 13 -------------
>>>>    2 files changed, 20 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>> index 68480f731192..e57339d49439 100644
>>>> --- a/kernel/kexec_core.c
>>>> +++ b/kernel/kexec_core.c
>>>> @@ -936,6 +936,26 @@ int kimage_load_segment(struct kimage *image,
>>>>    struct kimage *kexec_image;
>>>>    struct kimage *kexec_crash_image;
>>>>    int kexec_load_disabled;
>>>> +static struct ctl_table kexec_core_sysctls[] = {
>>>> +	{
>>>> +		.procname	= "kexec_load_disabled",
>>>> +		.data		= &kexec_load_disabled,
>>>> +		.maxlen		= sizeof(int),
>>>> +		.mode		= 0644,
>>>> +		/* only handle a transition from default "0" to "1" */
>>>> +		.proc_handler	= proc_dointvec_minmax,
>>>> +		.extra1		= SYSCTL_ONE,
>>>> +		.extra2		= SYSCTL_ONE,
>>>> +	},
>>>> +	{ }
>>>> +};
>>>> +
>>>> +static int __init kexec_core_sysctl_init(void)
>>>> +{
>>>> +	register_sysctl_init("kernel", kexec_core_sysctls);
>>>> +	return 0;
>>>> +}
>>>> +late_initcall(kexec_core_sysctl_init);
>>>>    /*
>>>>     * No panic_cpu check version of crash_kexec().  This function is called
>>>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>>>> index ae5e59396b5d..00e97c6d6576 100644
>>>> --- a/kernel/sysctl.c
>>>> +++ b/kernel/sysctl.c
>>>> @@ -61,7 +61,6 @@
>>>>    #include <linux/capability.h>
>>>>    #include <linux/binfmts.h>
>>>>    #include <linux/sched/sysctl.h>
>>>> -#include <linux/kexec.h>
>>>>    #include <linux/bpf.h>
>>>>    #include <linux/mount.h>
>>>>    #include <linux/userfaultfd_k.h>
>>>> @@ -1839,18 +1838,6 @@ static struct ctl_table kern_table[] = {
>>>>    		.proc_handler	= tracepoint_printk_sysctl,
>>>>    	},
>>>>    #endif
>>>> -#ifdef CONFIG_KEXEC_CORE
>>>> -	{
>>>> -		.procname	= "kexec_load_disabled",
>>>> -		.data		= &kexec_load_disabled,
>>>> -		.maxlen		= sizeof(int),
>>>> -		.mode		= 0644,
>>>> -		/* only handle a transition from default "0" to "1" */
>>>> -		.proc_handler	= proc_dointvec_minmax,
>>>> -		.extra1		= SYSCTL_ONE,
>>>> -		.extra2		= SYSCTL_ONE,
>>>> -	},
>>>> -#endif
>>>>    #ifdef CONFIG_MODULES
>>>>    	{
>>>>    		.procname	= "modprobe",
>>>> -- 
>>>> 2.26.2
>>>>
>>> .
> .
