Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C71D3648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 18:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgENQSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 12:18:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4785 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbgENQSX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 12:18:23 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EEAEA8ABD276537A7522;
        Fri, 15 May 2020 00:18:17 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 15 May 2020
 00:17:57 +0800
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        <yzaikin@google.com>, <linux-fsdevel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, <gregkh@linuxfoundation.org>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
 <20200512172413.GC11244@42.do-not-panic.com>
 <87k11hrqzc.fsf@x220.int.ebiederm.org>
 <20200512220341.GE11244@42.do-not-panic.com>
 <3ccd08a5-cac6-3ca1-ed33-3cb62c982443@huawei.com>
 <20200513125057.GM11244@42.do-not-panic.com>
 <2f8363b3-781e-b065-82f4-f84e6e787fad@huawei.com>
Message-ID: <aaae0a1e-8b80-7d31-d747-a2e350e3b247@huawei.com>
Date:   Fri, 15 May 2020 00:17:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2f8363b3-781e-b065-82f4-f84e6e787fad@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/5/14 14:05, Xiaoming Ni wrote:
> On 2020/5/13 20:50, Luis Chamberlain wrote:
>> On Wed, May 13, 2020 at 12:04:02PM +0800, Xiaoming Ni wrote:
>>> On 2020/5/13 6:03, Luis Chamberlain wrote:
>>>> On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
>>>>> Luis Chamberlain <mcgrof@kernel.org> writes:
>>>>>
>>>>>> On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
>>>>>>> Luis Chamberlain <mcgrof@kernel.org> writes:
>>>>>>>
>>>>>>>> +static struct ctl_table fs_base_table[] = {
>>>>>>>> +    {
>>>>>>>> +        .procname    = "fs",
>>>>>>>> +        .mode        = 0555,
>>>>>>>> +        .child        = fs_table,
>>>>>>>> +    },
>>>>>>>> +    { }
>>>>>>>> +};
>>>>>>>     ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
>>>>>>>>> +static int __init fs_procsys_init(void)
>>>>>>>> +{
>>>>>>>> +    struct ctl_table_header *hdr;
>>>>>>>> +
>>>>>>>> +    hdr = register_sysctl_table(fs_base_table);
>>>>>>>                 ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl 
>>>>>>> instead.
>>>>>>>     AKA
>>>>>>>           hdr = register_sysctl("fs", fs_table);
>>>>>>
>>>>>> Ah, much cleaner thanks!
>>>>>
>>>>> It is my hope you we can get rid of register_sysctl_table one of these
>>>>> days.  It was the original interface but today it is just a
>>>>> compatibility wrapper.
>>>>>
>>>>> I unfortunately ran out of steam last time before I finished 
>>>>> converting
>>>>> everything over.
>>>>
>>>> Let's give it one more go. I'll start with the fs stuff.
>>>>
>>>>     Luis
>>>>
>>>> .
>>>>
>>>
>>> If we register each feature in its own feature code file using 
>>> register() to
>>> register the sysctl interface. To avoid merge conflicts when different
>>> features modify sysctl.c at the same time.
>>> that is, try to Avoid mixing code with multiple features in the same 
>>> code
>>> file.
>>>
>>> For example, the multiple file interfaces defined in sysctl.c by the
>>> hung_task feature can  be moved to hung_task.c.
>>>
>>> Perhaps later, without centralized sysctl.c ?
>>> Is this better?
>>>
>>> Thanks
>>> Xiaoming Ni
>>>
>>> ---
>>>   include/linux/sched/sysctl.h |  8 +----
>>>   kernel/hung_task.c           | 78
>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>   kernel/sysctl.c              | 50 ----------------------------
>>>   3 files changed, 78 insertions(+), 58 deletions(-)
>>>
>>> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
>>> index d4f6215..bb4e0d3 100644
>>> --- a/include/linux/sched/sysctl.h
>>> +++ b/include/linux/sched/sysctl.h
>>> @@ -7,14 +7,8 @@
>>>   struct ctl_table;
>>>
>>>   #ifdef CONFIG_DETECT_HUNG_TASK
>>> -extern int         sysctl_hung_task_check_count;
>>> -extern unsigned int  sysctl_hung_task_panic;
>>> +/* used for block/ */
>>>   extern unsigned long sysctl_hung_task_timeout_secs;
>>> -extern unsigned long sysctl_hung_task_check_interval_secs;
>>> -extern int sysctl_hung_task_warnings;
>>> -extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int
>>> write,
>>> -                     void __user *buffer,
>>> -                     size_t *lenp, loff_t *ppos);
>>>   #else
>>>   /* Avoid need for ifdefs elsewhere in the code */
>>>   enum { sysctl_hung_task_timeout_secs = 0 };
>>> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
>>> index 14a625c..53589f2 100644
>>> --- a/kernel/hung_task.c
>>> +++ b/kernel/hung_task.c
>>> @@ -20,10 +20,10 @@
>>>   #include <linux/utsname.h>
>>>   #include <linux/sched/signal.h>
>>>   #include <linux/sched/debug.h>
>>> +#include <linux/kmemleak.h>
>>>   #include <linux/sched/sysctl.h>
>>>
>>>   #include <trace/events/sched.h>
>>> -
>>>   /*
>>>    * The number of tasks checked:
>>>    */
>>> @@ -296,8 +296,84 @@ static int watchdog(void *dummy)
>>>       return 0;
>>>   }
>>>
>>> +/*
>>> + * This is needed for proc_doulongvec_minmax of
>>> sysctl_hung_task_timeout_secs
>>> + * and hung_task_check_interval_secs
>>> + */
>>> +static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
>>
>> This is not generic so it can stay in this file.
>>
>>> +static int __maybe_unused neg_one = -1;
>>
>> This is generic so we can share it, I suggest we just rename this
>> for now to sysctl_neg_one, export it to a symbol namespace,
>> EXPORT_SYMBOL_NS_GPL(sysctl_neg_one, SYSCTL) and then import it with
>> MODULE_IMPORT_NS(SYSCTL)

When I made the patch, I found that only sysctl_writes_strict and 
hung_task_warnings use the neg_one variable, so is it necessary to merge 
and generate the SYSCTL_NEG_ONE variable?

In addition, the SYSCTL symbol namespace has not been created yet. Do I 
just need to add a new member -1 to the sysctl_vals array?

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b6f5d45..acae1fa 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -23,7 +23,7 @@
  static const struct inode_operations proc_sys_dir_operations;

  /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, INT_MAX };
+const int sysctl_vals[] = { 0, 1, INT_MAX, -1 };
  EXPORT_SYMBOL(sysctl_vals);

  /* Support for permanently empty directories */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 02fa844..6d741d6 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -41,6 +41,7 @@
  #define SYSCTL_ZERO    ((void *)&sysctl_vals[0])
  #define SYSCTL_ONE     ((void *)&sysctl_vals[1])
  #define SYSCTL_INT_MAX ((void *)&sysctl_vals[2])
+#define SYSCTL_NEG_ONE       ((void *)&sysctl_vals[3])

  extern const int sysctl_vals[];

Thanks
Xiaoming Ni


>>
>>
>>> +static struct ctl_table hung_task_sysctls[] = {
>>
>> We want to wrap this around with CONFIG_SYSCTL, so a cleaner solution
>> is something like this:
>>
>> diff --git a/kernel/Makefile b/kernel/Makefile
>> index a42ac3a58994..689718351754 100644
>> --- a/kernel/Makefile
>> +++ b/kernel/Makefile
>> @@ -88,7 +88,9 @@ obj-$(CONFIG_KCOV) += kcov.o
>>   obj-$(CONFIG_KPROBES) += kprobes.o
>>   obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
>>   obj-$(CONFIG_KGDB) += debug/
>> -obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
>> +obj-$(CONFIG_DETECT_HUNG_TASK) += hung_tasks.o
>> +hung_tasks-y := hung_task.o
>> +hung_tasks-$(CONFIG_SYSCTL) += hung_task_sysctl.o
>>   obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
>>   obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
>>   obj-$(CONFIG_SECCOMP) += seccomp.o
>>
>>> +/* get /proc/sys/kernel root */
>>> +static struct ctl_table sysctls_root[] = {
>>> +    {
>>> +        .procname       = "kernel",
>>> +        .mode           = 0555,
>>> +        .child          = hung_task_sysctls,
>>> +    },
>>> +    {}
>>> +};
>>> +
>>
>> And as per Eric, this is not needed, we can simplify this more, as noted
>> below.
>>
>>> +static int __init hung_task_sysctl_init(void)
>>> +{
>>> +    struct ctl_table_header *srt = register_sysctl_table(sysctls_root);
>>
>> You want instead something like::
>>
>>          struct ctl_table_header *srt;
>>
>>     srt = register_sysctl("kernel", hung_task_sysctls);
>>> +
>>> +    if (!srt)
>>> +        return -ENOMEM;
>>> +    kmemleak_not_leak(srt);
>>> +    return 0;
>>> +}
>>> +
>>
>>>   static int __init hung_task_init(void)
>>>   {
>>> +    int ret = hung_task_sysctl_init();
>>> +
>>> +    if (ret != 0)
>>> +        return ret;
>>> +
>>
>> And just #ifdef this around CONFIG_SYSCTL.
>>
>>    Luis
>>
>> .
>>
> 
> Thank you for your guidance, I will send the patch later
> 
> Xiaoming Ni
> 


