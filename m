Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB9F342E19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 17:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCTP7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 11:59:38 -0400
Received: from out28-169.mail.aliyun.com ([115.124.28.169]:60187 "EHLO
        out28-169.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhCTP7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:59:18 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436935|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0395052-0.00234668-0.958148;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.JnjPGnq_1616255949;
Received: from 192.168.88.129(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.JnjPGnq_1616255949)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sat, 20 Mar 2021 23:59:10 +0800
Subject: Re: exec error: BUG: Bad rss-counter
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org>
 <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org>
 <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
 <m1r1kwdyo0.fsf@fess.ebiederm.org>
 <CALCv0x0FQN+LSUkJaSsV=MCjpFokfgHeqSTHYOTpzA6cOyvQoA@mail.gmail.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <e52b2625-8d33-c081-adeb-f92f64ca1e8e@wanyeetech.com>
Date:   Sat, 20 Mar 2021 23:59:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALCv0x0FQN+LSUkJaSsV=MCjpFokfgHeqSTHYOTpzA6cOyvQoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ilya,

On 2021/3/3 下午11:55, Ilya Lipnitskiy wrote:
> On Wed, Mar 3, 2021 at 7:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>>
>>> On Tue, Mar 2, 2021 at 11:37 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>>>>
>>>>> On Mon, Mar 1, 2021 at 12:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>>>> Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com> writes:
>>>>>>
>>>>>>> Eric, All,
>>>>>>>
>>>>>>> The following error appears when running Linux 5.10.18 on an embedded
>>>>>>> MIPS mt7621 target:
>>>>>>> [    0.301219] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:1
>>>>>>>
>>>>>>> Being a very generic error, I started digging and added a stack dump
>>>>>>> before the BUG:
>>>>>>> Call Trace:
>>>>>>> [<80008094>] show_stack+0x30/0x100
>>>>>>> [<8033b238>] dump_stack+0xac/0xe8
>>>>>>> [<800285e8>] __mmdrop+0x98/0x1d0
>>>>>>> [<801a6de8>] free_bprm+0x44/0x118
>>>>>>> [<801a86a8>] kernel_execve+0x160/0x1d8
>>>>>>> [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
>>>>>>> [<80003198>] ret_from_kernel_thread+0x14/0x1c
>>>>>>>
>>>>>>> So that's how I got to looking at fs/exec.c and noticed quite a few
>>>>>>> changes last year. Turns out this message only occurs once very early
>>>>>>> at boot during the very first call to kernel_execve. current->mm is
>>>>>>> NULL at this stage, so acct_arg_size() is effectively a no-op.
>>>>>> If you believe this is a new error you could bisect the kernel
>>>>>> to see which change introduced the behavior you are seeing.
>>>>>>
>>>>>>> More digging, and I traced the RSS counter increment to:
>>>>>>> [<8015adb4>] add_mm_counter_fast+0xb4/0xc0
>>>>>>> [<80160d58>] handle_mm_fault+0x6e4/0xea0
>>>>>>> [<80158aa4>] __get_user_pages.part.78+0x190/0x37c
>>>>>>> [<8015992c>] __get_user_pages_remote+0x128/0x360
>>>>>>> [<801a6d9c>] get_arg_page+0x34/0xa0
>>>>>>> [<801a7394>] copy_string_kernel+0x194/0x2a4
>>>>>>> [<801a880c>] kernel_execve+0x11c/0x298
>>>>>>> [<800420f4>] call_usermodehelper_exec_async+0x114/0x194
>>>>>>> [<80003198>] ret_from_kernel_thread+0x14/0x1c
>>>>>>>
>>>>>>> In fact, I also checked vma_pages(bprm->vma) and lo and behold it is set to 1.
>>>>>>>
>>>>>>> How is fs/exec.c supposed to handle implied RSS increments that happen
>>>>>>> due to page faults when discarding the bprm structure? In this case,
>>>>>>> the bug-generating kernel_execve call never succeeded, it returned -2,
>>>>>>> but I didn't trace exactly what failed.
>>>>>> Unless I am mistaken any left over pages should be purged by exit_mmap
>>>>>> which is called by mmput before mmput calls mmdrop.
>>>>> Good to know. Some more digging and I can say that we hit this error
>>>>> when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
>>>>> vm_normal_page returns NULL, zap_pte_range does not decrement
>>>>> MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
>>>>> usable, but special? Or am I totally off the mark here?
>>>> It would be good to know if that is the page that get_user_pages_remote
>>>> returned to copy_string_kernel.  The zero page that is always zero,
>>>> should never be returned when a writable mapping is desired.
>>> Indeed, pfn 0 is returned from get_arg_page: (page is 0x809cf000,
>>> page_to_pfn(page) is 0) and it is the same page that is being freed and not
>>> refcounted in mmput/zap_pte_range. Confirmed with good old printk. Also,
>>> ZERO_PAGE(0)==0x809fc000 -> PFN 5120.
>>>
>>> I think I have found the problem though, after much digging and thanks to all
>>> the information provided. init_zero_pfn() gets called too late (after
>>> the call to
>>> is_zero_pfn(0) from mmput returns true), until then zero_pfn == 0, and after,
>>> zero_pfn == 5120. Boom.
>>>
>>> So PFN 0 is special, but only for a little bit, enough for something
>>> on my system
>>> to call kernel_execve :)
>>>
>>> Question: is my system not supposed to be calling kernel_execve this
>>> early or does
>>> init_zero_pfn() need to happen earlier? init_zero_pfn is currently a
>>> core_initcall.
>> Looking quickly it seems that init_zero_pfn() is in mm/memory.c and is
>> common for both mips and x86.  Further it appears init_zero_pfn() has
>> been that was since 2009 a13ea5b75964 ("mm: reinstate ZERO_PAGE").
>>
>> Given the testing that x86 gets and that nothing like this has been
>> reported it looks like whatever driver is triggering the kernel_execve
>> is doing something wrong.
>> Because honestly.  If the zero page isn't working there is not a chance
>> that anything in userspace is working so it is clearly much too early.
>>
>> I suspect there is some driver that is initialized very early that is
>> doing something that looks innocuous (like triggering a hotplug event)
>> and that happens to cause a call_usermode_helper which then calls
>> kernel_execve.
> I will investigate the offenders more closely. However, I do not
> notice this behavior on the same system based on the 5.4 kernel. Is it


I also encountered this problem on Ingenic X1000 and X1830. This is the 
printed information:

[    0.120715] BUG: Bad rss-counter state mm:(ptrval) 
type:MM_ANONPAGES val:1

I tested kernel 5.9, kernel 5.10, kernel 5.11, and kernel 5.12, only 
kernel 5.9 did not have this problem, so we can know that this problem 
was introduced in kernel 5.10, have you found any effective solution?


Thanks and best regards!


> possible that last year's exec changes have exposed this issue? Not
> blaming exec at all, just making sure I understand the problem better.
>
> Ilya
