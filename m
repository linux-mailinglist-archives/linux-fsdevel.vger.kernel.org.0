Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1767D6E7946
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 14:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjDSMDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 08:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjDSMDK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:03:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01C1A4;
        Wed, 19 Apr 2023 05:03:07 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q1fTH1PBlzSqnc;
        Wed, 19 Apr 2023 19:58:59 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 20:03:05 +0800
Message-ID: <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
Date:   Wed, 19 Apr 2023 20:03:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/19 15:25, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Apr 18, 2023 at 05:45:06PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2023/4/18 11:13, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Mon, Apr 17, 2023 at 12:53:23PM +0800, Kefeng Wang wrote:
>>>> The dump_user_range() is used to copy the user page to a coredump file,
>>>> but if a hardware memory error occurred during copy, which called from
>>>> __kernel_write_iter() in dump_user_range(), it crashes,
>>>>
>>>>     CPU: 112 PID: 7014 Comm: mca-recover Not tainted 6.3.0-rc2 #425
>>>>     pc : __memcpy+0x110/0x260
>>>>     lr : _copy_from_iter+0x3bc/0x4c8
>>>>     ...
>>>>     Call trace:
>>>>      __memcpy+0x110/0x260
>>>>      copy_page_from_iter+0xcc/0x130
>>>>      pipe_write+0x164/0x6d8
>>>>      __kernel_write_iter+0x9c/0x210
>>>>      dump_user_range+0xc8/0x1d8
>>>>      elf_core_dump+0x308/0x368
>>>>      do_coredump+0x2e8/0xa40
>>>>      get_signal+0x59c/0x788
>>>>      do_signal+0x118/0x1f8
>>>>      do_notify_resume+0xf0/0x280
>>>>      el0_da+0x130/0x138
>>>>      el0t_64_sync_handler+0x68/0xc0
>>>>      el0t_64_sync+0x188/0x190
>>>>
>>>> Generally, the '->write_iter' of file ops will use copy_page_from_iter()
>>>> and copy_page_from_iter_atomic(), change memcpy() to copy_mc_to_kernel()
>>>> in both of them to handle #MC during source read, which stop coredump
>>>> processing and kill the task instead of kernel panic, but the source
>>>> address may not always a user address, so introduce a new copy_mc flag in
>>>> struct iov_iter{} to indicate that the iter could do a safe memory copy,
>>>> also introduce the helpers to set/cleck the flag, for now, it's only
>>>> used in coredump's dump_user_range(), but it could expand to any other
>>>> scenarios to fix the similar issue.
>>>>
>>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>>> Cc: Christian Brauner <brauner@kernel.org>
>>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>> Cc: Tong Tiangen <tongtiangen@huawei.com>
>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>> v2:
>>>> - move the helper functions under pre-existing CONFIG_ARCH_HAS_COPY_MC
>>>> - reposition the copy_mc in struct iov_iter for easy merge, suggested
>>>>     by Andrew Morton
>>>> - drop unnecessary clear flag helper
>>>> - fix checkpatch warning
>>>>    fs/coredump.c       |  1 +
>>>>    include/linux/uio.h | 16 ++++++++++++++++
>>>>    lib/iov_iter.c      | 17 +++++++++++++++--
>>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>>
>>> ...
>>>> @@ -371,6 +372,14 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>>>>    EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
>>>>    #endif /* CONFIG_ARCH_HAS_COPY_MC */
>>>> +static void *memcpy_from_iter(struct iov_iter *i, void *to, const void *from,
>>>> +				 size_t size)
>>>> +{
>>>> +	if (iov_iter_is_copy_mc(i))
>>>> +		return (void *)copy_mc_to_kernel(to, from, size);
>>>
>>> Is it helpful to call memory_failure_queue() if copy_mc_to_kernel() fails
>>> due to a memory error?
>>
>> For dump_user_range(), the task is dying, if copy incomplete size, the
>> coredump will fail and task will exit, also memory_failure will
>> be called by kill_me_maybe(),
>>
>>   CPU: 0 PID: 1418 Comm: test Tainted: G   M               6.3.0-rc5 #29
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x37/0x50
>>    memory_failure+0x51/0x970
>>    kill_me_maybe+0x5b/0xc0
>>    task_work_run+0x5a/0x90
>>    exit_to_user_mode_prepare+0x194/0x1a0
>>    irqentry_exit_to_user_mode+0x9/0x30
>>    noist_exc_machine_check+0x40/0x80
>>    asm_exc_machine_check+0x33/0x40
> 
> Is this call trace printed out when copy_mc_to_kernel() failed by finding
> a memory error (or in some testcase using error injection)?

I add dump_stack() into memory_failure() to check whether the poisoned
memory is called or not, and the call trace shows it do call
memory_failure()， but I get confused when do the test.

> In my understanding, an MCE should not be triggered when MC-safe copy tries
> to access to a memory error.  So I feel that we might be talking about
> different scenarios.
> 
> When I questioned previously, I thought about the following scenario:
> 
>    - a process terminates abnormally for any reason like segmentation fault,
>    - then, kernel tries to create a coredump,
>    - during this, the copying routine accesses to corrupted page to read.
> 
Yes, we tested like your described,

1) inject memory error into a process
2) send a SIGABT/SIGBUS to process to trigger the coredump

Without patch, the system panic, and with patch only process exits.

> In this case the corrupted page should not be handled by memory_failure()
> yet (because otherwise properly handled hwpoisoned page should be ignored
> by coredump process).  The coredump process would exit with failure with
> your patch, but then, the corrupted page is still left unhandled and can
> be reused, so any other thread can easily access to it again.

As shown above, the corrupted page will be handled by memory_failure(), 
but what I'm wondering,
1) memory_failure() is not always called
2) look at the above call trace, it looks like from asynchronous
    interrupt, not from synchronous exception, right?

> 
> You can find a few other places (like __wp_page_copy_user and ksm_might_need_to_copy)
> to call memory_failure_queue() to cope with such unhandled error pages.
> So does memcpy_from_iter() do the same?

I add some debug print in do_machine_check() on x86:

1) COW,
   m.kflags: MCE_IN_KERNEL_RECOV
   fixup_type: EX_TYPE_DEFAULT_MCE_SAFE

   CPU: 11 PID: 2038 Comm: einj_mem_uc
   Call Trace:
    <#MC>
    dump_stack_lvl+0x37/0x50
    do_machine_check+0x7ad/0x840
    exc_machine_check+0x5a/0x90
    asm_exc_machine_check+0x1e/0x40
   RIP: 0010:copy_mc_fragile+0x35/0x62

   if (m.kflags & MCE_IN_KERNEL_RECOV) {
           if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
                   mce_panic("Failed kernel mode recovery", &m, msg);
   }

   if (m.kflags & MCE_IN_KERNEL_COPYIN)
           queue_task_work(&m, msg, kill_me_never);

There is no memory_failure() called when
EX_TYPE_DEFAULT_MCE_SAFE, also EX_TYPE_FAULT_MCE_SAFE too,
so we manually add a memory_failure_queue() to handle with
the poisoned page.

2） Coredump,  nothing print about m.kflags and fixup_type,
with above check, add a memory_failure_queue() or memory_failure() seems
to be needed for memcpy_from_iter(), but it is totally different from
the COW scenario


Another question, other copy_mc_to_kernel() callers, eg,
nvdimm/dm-writecache/dax, there are not call memory_failure_queue(),
should they need a memory_failure_queue(), if so, why not add it into
do_machine_check() ?

Thanks.



> 
> Thanks,
> Naoya Horiguchi
