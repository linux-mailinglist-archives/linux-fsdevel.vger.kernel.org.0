Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE46E5DCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDRJps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjDRJpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:45:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BD59CC;
        Tue, 18 Apr 2023 02:45:09 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [7.185.36.107])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q0zT06DBtznWsh;
        Tue, 18 Apr 2023 17:41:24 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 17:45:07 +0800
Message-ID: <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
Date:   Tue, 18 Apr 2023 17:45:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
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
Content-Language: en-US
In-Reply-To: <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/18 11:13, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Apr 17, 2023 at 12:53:23PM +0800, Kefeng Wang wrote:
>> The dump_user_range() is used to copy the user page to a coredump file,
>> but if a hardware memory error occurred during copy, which called from
>> __kernel_write_iter() in dump_user_range(), it crashes,
>>
>>    CPU: 112 PID: 7014 Comm: mca-recover Not tainted 6.3.0-rc2 #425
>>   
>>    pc : __memcpy+0x110/0x260
>>    lr : _copy_from_iter+0x3bc/0x4c8
>>    ...
>>    Call trace:
>>     __memcpy+0x110/0x260
>>     copy_page_from_iter+0xcc/0x130
>>     pipe_write+0x164/0x6d8
>>     __kernel_write_iter+0x9c/0x210
>>     dump_user_range+0xc8/0x1d8
>>     elf_core_dump+0x308/0x368
>>     do_coredump+0x2e8/0xa40
>>     get_signal+0x59c/0x788
>>     do_signal+0x118/0x1f8
>>     do_notify_resume+0xf0/0x280
>>     el0_da+0x130/0x138
>>     el0t_64_sync_handler+0x68/0xc0
>>     el0t_64_sync+0x188/0x190
>>
>> Generally, the '->write_iter' of file ops will use copy_page_from_iter()
>> and copy_page_from_iter_atomic(), change memcpy() to copy_mc_to_kernel()
>> in both of them to handle #MC during source read, which stop coredump
>> processing and kill the task instead of kernel panic, but the source
>> address may not always a user address, so introduce a new copy_mc flag in
>> struct iov_iter{} to indicate that the iter could do a safe memory copy,
>> also introduce the helpers to set/cleck the flag, for now, it's only
>> used in coredump's dump_user_range(), but it could expand to any other
>> scenarios to fix the similar issue.
>>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Cc: Tong Tiangen <tongtiangen@huawei.com>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v2:
>> - move the helper functions under pre-existing CONFIG_ARCH_HAS_COPY_MC
>> - reposition the copy_mc in struct iov_iter for easy merge, suggested
>>    by Andrew Morton
>> - drop unnecessary clear flag helper
>> - fix checkpatch warning
>>   fs/coredump.c       |  1 +
>>   include/linux/uio.h | 16 ++++++++++++++++
>>   lib/iov_iter.c      | 17 +++++++++++++++--
>>   3 files changed, 32 insertions(+), 2 deletions(-)
>>
> ...
>> @@ -371,6 +372,14 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>>   EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
>>   #endif /* CONFIG_ARCH_HAS_COPY_MC */
>>   
>> +static void *memcpy_from_iter(struct iov_iter *i, void *to, const void *from,
>> +				 size_t size)
>> +{
>> +	if (iov_iter_is_copy_mc(i))
>> +		return (void *)copy_mc_to_kernel(to, from, size);
> 
> Is it helpful to call memory_failure_queue() if copy_mc_to_kernel() fails
> due to a memory error?

For dump_user_range(), the task is dying, if copy incomplete size, the 
coredump will fail and task will exit, also memory_failure will
be called by kill_me_maybe(),

  CPU: 0 PID: 1418 Comm: test Tainted: G   M               6.3.0-rc5 #29
  Call Trace:
   <TASK>
   dump_stack_lvl+0x37/0x50
   memory_failure+0x51/0x970
   kill_me_maybe+0x5b/0xc0
   task_work_run+0x5a/0x90
   exit_to_user_mode_prepare+0x194/0x1a0
   irqentry_exit_to_user_mode+0x9/0x30
   noist_exc_machine_check+0x40/0x80
   asm_exc_machine_check+0x33/0x40


> 
> Thanks,
> Naoya Horiguchi
> 
>> +	return memcpy(to, from, size);
>> +}
>> +
>>   size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
>>   {
>>   	if (WARN_ON_ONCE(!i->data_source))
