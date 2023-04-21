Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8C6EA34A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 07:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjDUFnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDUFnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:43:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC04D1;
        Thu, 20 Apr 2023 22:43:42 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q2k2H41Cpz8xD2;
        Fri, 21 Apr 2023 13:42:47 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 13:43:40 +0800
Message-ID: <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
Date:   Fri, 21 Apr 2023 13:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     Jane Chu <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
 <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
 <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
 <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
 <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
 <7d0c38a9-ed2a-a221-0c67-4a2f3945d48b@oracle.com>
 <6dc1b117-020e-be9e-7e5e-a349ffb7d00a@huawei.com>
 <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/21 11:13, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Apr 20, 2023 at 11:05:12PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2023/4/20 10:59, Kefeng Wang wrote:
>>>
>>>
>>> On 2023/4/20 10:03, Jane Chu wrote:
>>>>
>>>> On 4/19/2023 5:03 AM, Kefeng Wang wrote:
>>>>>
>>>>>
>>>>> On 2023/4/19 15:25, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>>>> On Tue, Apr 18, 2023 at 05:45:06PM +0800, Kefeng Wang wrote:
>>>>>>>
>>>>>>>
>>> ...
>>>>>>>>> @@ -371,6 +372,14 @@ size_t
>>>>>>>>> _copy_mc_to_iter(const void *addr, size_t bytes,
>>>>>>>>> struct iov_iter *i)
>>>>>>>>>     EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
>>>>>>>>>     #endif /* CONFIG_ARCH_HAS_COPY_MC */
>>>>>>>>> +static void *memcpy_from_iter(struct iov_iter
>>>>>>>>> *i, void *to, const void *from,
>>>>>>>>> +                 size_t size)
>>>>>>>>> +{
>>>>>>>>> +    if (iov_iter_is_copy_mc(i))
>>>>>>>>> +        return (void *)copy_mc_to_kernel(to, from, size);
>>>>>>>>
>>>>>>>> Is it helpful to call memory_failure_queue() if
>>>>>>>> copy_mc_to_kernel() fails
>>>>>>>> due to a memory error?
>>>>>>>
>>>>>>> For dump_user_range(), the task is dying, if copy incomplete size, the
>>>>>>> coredump will fail and task will exit, also memory_failure will
>>>>>>> be called by kill_me_maybe(),
>>>>>>>
>>>>>>>    CPU: 0 PID: 1418 Comm: test Tainted: G   M
>>>>>>> 6.3.0-rc5 #29
>>>>>>>    Call Trace:
>>>>>>>     <TASK>
>>>>>>>     dump_stack_lvl+0x37/0x50
>>>>>>>     memory_failure+0x51/0x970
>>>>>>>     kill_me_maybe+0x5b/0xc0
>>>>>>>     task_work_run+0x5a/0x90
>>>>>>>     exit_to_user_mode_prepare+0x194/0x1a0
>>>>>>>     irqentry_exit_to_user_mode+0x9/0x30
>>>>>>>     noist_exc_machine_check+0x40/0x80
>>>>>>>     asm_exc_machine_check+0x33/0x40
>>>>>>
>>>>>> Is this call trace printed out when copy_mc_to_kernel()
>>>>>> failed by finding
>>>>>> a memory error (or in some testcase using error injection)?
>>>>>
>>>>> I add dump_stack() into memory_failure() to check whether the poisoned
>>>>> memory is called or not, and the call trace shows it do call
>>>>> memory_failure()， but I get confused when do the test.
>>>>>
>>>>>> In my understanding, an MCE should not be triggered when
>>>>>> MC-safe copy tries
>>>>>> to access to a memory error.  So I feel that we might be talking about
>>>>>> different scenarios.
>>>>>>
>>>>>> When I questioned previously, I thought about the following scenario:
>>>>>>
>>>>>>     - a process terminates abnormally for any reason like
>>>>>> segmentation fault,
>>>>>>     - then, kernel tries to create a coredump,
>>>>>>     - during this, the copying routine accesses to corrupted
>>>>>> page to read.
>>>>>>
>>>>> Yes, we tested like your described,
>>>>>
>>>>> 1) inject memory error into a process
>>>>> 2) send a SIGABT/SIGBUS to process to trigger the coredump
>>>>>
>>>>> Without patch, the system panic, and with patch only process exits.
>>>>>
>>>>>> In this case the corrupted page should not be handled by
>>>>>> memory_failure()
>>>>>> yet (because otherwise properly handled hwpoisoned page
>>>>>> should be ignored
>>>>>> by coredump process).  The coredump process would exit with
>>>>>> failure with
>>>>>> your patch, but then, the corrupted page is still left
>>>>>> unhandled and can
>>>>>> be reused, so any other thread can easily access to it again.
>>>>>
>>>>> As shown above, the corrupted page will be handled by
>>>>> memory_failure(), but what I'm wondering,
>>>>> 1) memory_failure() is not always called
>>>>> 2) look at the above call trace, it looks like from asynchronous
>>>>>      interrupt, not from synchronous exception, right?
>>>>>
>>>>>>
>>>>>> You can find a few other places (like __wp_page_copy_user
>>>>>> and ksm_might_need_to_copy)
>>>>>> to call memory_failure_queue() to cope with such unhandled error pages.
>>>>>> So does memcpy_from_iter() do the same?
>>>>>
>>>>> I add some debug print in do_machine_check() on x86:
>>>>>
>>>>> 1) COW,
>>>>>     m.kflags: MCE_IN_KERNEL_RECOV
>>>>>     fixup_type: EX_TYPE_DEFAULT_MCE_SAFE
>>>>>
>>>>>     CPU: 11 PID: 2038 Comm: einj_mem_uc
>>>>>     Call Trace:
>>>>>      <#MC>
>>>>>      dump_stack_lvl+0x37/0x50
>>>>>      do_machine_check+0x7ad/0x840
>>>>>      exc_machine_check+0x5a/0x90
>>>>>      asm_exc_machine_check+0x1e/0x40
>>>>>     RIP: 0010:copy_mc_fragile+0x35/0x62
>>>>>
>>>>>     if (m.kflags & MCE_IN_KERNEL_RECOV) {
>>>>>             if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
>>>>>                     mce_panic("Failed kernel mode recovery", &m, msg);
>>>>>     }
>>>>>
>>>>>     if (m.kflags & MCE_IN_KERNEL_COPYIN)
>>>>>             queue_task_work(&m, msg, kill_me_never);
>>>>>
>>>>> There is no memory_failure() called when
>>>>> EX_TYPE_DEFAULT_MCE_SAFE, also EX_TYPE_FAULT_MCE_SAFE too,
>>>>> so we manually add a memory_failure_queue() to handle with
>>>>> the poisoned page.
>>>>>
>>>>> 2） Coredump,  nothing print about m.kflags and fixup_type,
>>
>> Sorry，I forget to set coredump file size :(
>>
>> The coredump do trigger the do_machine_check() with same m.kflags and
>> fixup_type like cow
>>
>>
>>>>> with above check, add a memory_failure_queue() or memory_failure() seems
>>>>> to be needed for memcpy_from_iter(), but it is totally different from
>>>>> the COW scenario
>>>>>
>>
>> so the memcpy_from_iter() from coredump is same as cow scenario.
> 
> Okay, thank you for confirmation.
> 
>>
>>>>>
>>>>> Another question, other copy_mc_to_kernel() callers, eg,
>>>>> nvdimm/dm-writecache/dax, there are not call memory_failure_queue(),
>>>>> should they need a memory_failure_queue(), if so, why not add it into
>>>>> do_machine_check() ?
>>>>
>>>
>>> What I mean is that EX_TYPE_DEFAULT_MCE_SAFE/EX_TYPE_FAULT_MCE_SAFE
>>> is designed to identify fixups which allow in kernel #MC recovery,
>>> that is, the caller of copy_mc_to_kernel() must know the source
>>> is a user address, so we could add a MCE_IN_KERNEL_COPYIN fro
>>> the MCE_SAFE type.
>>
>> And I think we need the following change for MCE_SAFE copy to set
>> MCE_IN_KERNEL_COPYIN.
>>
>>>
>>> diff --git a/arch/x86/kernel/cpu/mce/severity.c
>>> b/arch/x86/kernel/cpu/mce/severity.c
>>> index c4477162c07d..63e94484c5d6 100644
>>> --- a/arch/x86/kernel/cpu/mce/severity.c
>>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>>> @@ -293,12 +293,11 @@ static noinstr int error_context(struct mce *m,
>>> struct pt_regs *regs)
>>>           case EX_TYPE_COPY:
>>>                   if (!copy_user)
>>>                           return IN_KERNEL;
>>> -               m->kflags |= MCE_IN_KERNEL_COPYIN;
> 
> This change seems to not related to what you try to fix.
> Could this break some other workloads like copying from user address?
> 

Yes, this move MCE_IN_KERNEL_COPYIN set into next case, both COPY and
MCE_SAFE type will set MCE_IN_KERNEL_COPYIN, for EX_TYPE_COPY, we don't
break it.


>>>                   fallthrough;
>>>
>>>           case EX_TYPE_FAULT_MCE_SAFE:
>>>           case EX_TYPE_DEFAULT_MCE_SAFE:
>>> -               m->kflags |= MCE_IN_KERNEL_RECOV;
>>> +               m->kflags |= MCE_IN_KERNEL_RECOV | MCE_IN_KERNEL_COPYIN;
>>>                   return IN_KERNEL_RECOV;
>>>
>>>           default:
>>>
>>> then we could drop memory_failure_queue(pfn, flags) from cow/ksm copy,
>>> or every Machine Check safe memory copy will need a memory_failure_xx()
>>> call.
>>
>> which help use to kill unneeded memory_failure_queue() call, any comments?
> 
> I'm not 100% sure that we can safely use queue_task_work() instead of
> memory_failure_queue() (due to the difference between workqueue and task
> work, which should be recently discussed in thread [1]).  So I prefer to
> keep the approach of memory_failure_queue() to keep the impact minimum.
> 

+tony for x86 mce

The x86 call queue_task_work() for EX_TYPE_COPY, so EX_TYPE_FAULT_MCE_SAFE
and EX_TYPE_DEFAULT_MCE_SAFE should be similar to EX_TYPE_COPY,
memcpy_mc_xxx return bytes not copied, let the task to decide
what to do next, and call memory_failure(pfn, 0) to isolate
the poisoned page.

1) queue_task_work() will make the memory_failure() called before 
return-to-user
2) memory_failure_queue() called in COW will put the work on a specific
cpu(current task is running), and memory_failure() will be called in
the work. see more from commit d302c2398ba2 ("mm, hwpoison: when copy-
on-write hits poison, take page offline"),  "It is important, but not 
urgent, to mark the source page as h/w poisoned and unmap it from other
tasks."

Both of them just wants to isolate memory, they shouldn't add action,
they set flag=0 for memory_failure(). so preliminarily, there are not 
different.



> [1] https://lore.kernel.org/lkml/20230417011407.58319-1-xueshuai@linux.alibaba.com/T/#u
> 

The COPY_MC support on arm64 is still under review[1],  xueshuai's patch
is only trying to fix the uncorrected si_code of synchronous exceptions
when memory error occurred, so I think it is not involved the COPY_MC.


[1] 
https://lore.kernel.org/lkml/20221219120008.3818828-1-tongtiangen@huawei.com/


Thanks

> Thanks,
> Naoya Horiguchi
> 
>>
>>
>>>
>>> +Thomas，who add the two types, could you share some comments about
>>> this,thanks.
>>>
>>>> In the dax case, if the source address is poisoned, and we do follow
>>>> up with memory_failure_queue(pfn, flags), what should the value of
>>>> the 'flags' be ?
>>>
>>
>> With above diff change, we don't add a memory_failure_queue() into dax too.
