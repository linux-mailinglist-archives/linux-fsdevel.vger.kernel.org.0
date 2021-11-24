Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E955A45B4DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 08:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbhKXHIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 02:08:24 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27290 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbhKXHIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:08:17 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HzX803JTQzbj5m;
        Wed, 24 Nov 2021 15:05:04 +0800 (CST)
Received: from dggema774-chm.china.huawei.com (10.1.198.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 15:05:06 +0800
Received: from [10.67.102.197] (10.67.102.197) by
 dggema774-chm.china.huawei.com (10.1.198.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 24 Nov 2021 15:05:05 +0800
Subject: Re: [PATCH v2 2/9] sysctl: Move some boundary constants from sysctl.c
 to sysctl_vals
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <peterz@infradead.org>,
        <gregkh@linuxfoundation.org>, <pjt@google.com>,
        <liu.hailong6@zte.com.cn>, <andriy.shevchenko@linux.intel.com>,
        <sre@kernel.org>, <penguin-kernel@i-love.sakura.ne.jp>,
        <pmladek@suse.com>, <senozhatsky@chromium.org>,
        <wangqing@vivo.com>, <bcrl@kvack.org>, <viro@zeniv.linux.org.uk>,
        <jack@suse.cz>, <amir73il@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
 <20211123202347.818157-3-mcgrof@kernel.org>
 <87k0gygnq4.fsf@email.froward.int.ebiederm.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <a2d657e4-617a-ff4b-1334-928560701589@huawei.com>
Date:   Wed, 24 Nov 2021 15:05:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <87k0gygnq4.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema774-chm.china.huawei.com (10.1.198.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/11/24 12:51, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
>> From: Xiaoming Ni <nixiaoming@huawei.com>
>>
>> sysctl has helpers which let us specify boundary values for a min or
>> max int value. Since these are used for a boundary check only they don't
>> change, so move these variables to sysctl_vals to avoid adding duplicate
>> variables. This will help with our cleanup of kernel/sysctl.c.
> 
> Ouch.
> 
> I kind of, sort of, have to protest.
> 
> Where the macros that use sysctl_vals don't have a type they have caused
> mysterious code breakage because people did not realize they can not be
> used with sysctls that take a long instead of an int.
> 
> This came up with when the internal storage for ucounts see
> kernel/ucount.c changed from an int to a long.  We were quite a while
> tracking what was going on until we realized that the code could not use
> SYSCTL_ZERO and SYSCTL_INT_MAX and that we had to defined our own thatSYSCTL_ZERO and SYSCTL_ZERO involve dozens of files and are used in hundreds of places.
> were long.
> 
static unsigned long zero_ul;
static unsigned long one_ul = 1;
static unsigned long long_max = LONG_MAX;
EXPORT_SYMBOL(proc_doulongvec_minmax);

Yes, min/max of type unsigned long is used in multiple sysctl 
interfaces. It is necessary to add an unsigned long sysctl_val array to 
avoid repeated definitions in different .c files.

> So before we extend something like this can we please change the
> macro naming convention so that it includes the size of the type
> we want.
>
The int type is the most widely used type. By default, numeric constants 
are also of the int type. SYSCTL_ZERO and SYSCTL_ZERO involve dozens of 
files and are used in hundreds of places. Whether only non-int macros 
need to be named with their type size?

> 
> I am also not a fan of sysctl_vals living in proc_sysctl.  They
> have nothing to do with the code in that file.  They would do much
> better in kernel/sysctl.c close to the helpers that use them.
> 
yes

Thanks
Xiaoming Ni


> Eric
> 
> 
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> [mcgrof: major rebase]
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   fs/proc/proc_sysctl.c  |  2 +-
>>   include/linux/sysctl.h | 12 +++++++++---
>>   kernel/sysctl.c        | 44 ++++++++++++++++++------------------------
>>   3 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index b4950843d90a..6d462644bb00 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_file_operations;
>>   static const struct inode_operations proc_sys_dir_operations;
>>   
>>   /* shared constants to be used in various sysctls */
>> -const int sysctl_vals[] = { 0, 1, INT_MAX };
>> +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, INT_MAX };
>>   EXPORT_SYMBOL(sysctl_vals);
>>   
>>   /* Support for permanently empty directories */
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index d3ab7969b6b5..718492057c70 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -38,9 +38,15 @@ struct ctl_table_header;
>>   struct ctl_dir;
>>   
>>   /* Keep the same order as in fs/proc/proc_sysctl.c */
>> -#define SYSCTL_ZERO	((void *)&sysctl_vals[0])
>> -#define SYSCTL_ONE	((void *)&sysctl_vals[1])
>> -#define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
>> +#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[0])
>> +#define SYSCTL_ZERO			((void *)&sysctl_vals[1])
>> +#define SYSCTL_ONE			((void *)&sysctl_vals[2])
>> +#define SYSCTL_TWO			((void *)&sysctl_vals[3])
>> +#define SYSCTL_FOUR			((void *)&sysctl_vals[4])
>> +#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
>> +#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
>> +#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
>> +#define SYSCTL_INT_MAX			((void *)&sysctl_vals[8])
>>   
>>   extern const int sysctl_vals[];
>>   
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 857c1ccad9e8..3097f0286504 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -113,15 +113,9 @@
>>   static int sixty = 60;
>>   #endif
>>   
>> -static int __maybe_unused neg_one = -1;
>> -static int __maybe_unused two = 2;
>> -static int __maybe_unused four = 4;
>>   static unsigned long zero_ul;
>>   static unsigned long one_ul = 1;
>>   static unsigned long long_max = LONG_MAX;
>> -static int one_hundred = 100;
>> -static int two_hundred = 200;
>> -static int one_thousand = 1000;
>>   #ifdef CONFIG_PRINTK
>>   static int ten_thousand = 10000;
>>   #endif
>> @@ -1962,7 +1956,7 @@ static struct ctl_table kern_table[] = {
>>   		.maxlen		= sizeof(int),
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= &neg_one,
>> +		.extra1		= SYSCTL_NEG_ONE,
>>   		.extra2		= SYSCTL_ONE,
>>   	},
>>   #endif
>> @@ -2304,7 +2298,7 @@ static struct ctl_table kern_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax_sysadmin,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two,
>> +		.extra2		= SYSCTL_TWO,
>>   	},
>>   #endif
>>   	{
>> @@ -2564,7 +2558,7 @@ static struct ctl_table kern_table[] = {
>>   		.maxlen		= sizeof(int),
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax,
>> -		.extra1		= &neg_one,
>> +		.extra1		= SYSCTL_NEG_ONE,
>>   	},
>>   #endif
>>   #ifdef CONFIG_RT_MUTEXES
>> @@ -2626,7 +2620,7 @@ static struct ctl_table kern_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= perf_cpu_time_max_percent_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &one_hundred,
>> +		.extra2		= SYSCTL_ONE_HUNDRED,
>>   	},
>>   	{
>>   		.procname	= "perf_event_max_stack",
>> @@ -2644,7 +2638,7 @@ static struct ctl_table kern_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= perf_event_max_stack_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &one_thousand,
>> +		.extra2		= SYSCTL_ONE_THOUSAND,
>>   	},
>>   #endif
>>   	{
>> @@ -2675,7 +2669,7 @@ static struct ctl_table kern_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= bpf_unpriv_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two,
>> +		.extra2		= SYSCTL_TWO,
>>   	},
>>   	{
>>   		.procname	= "bpf_stats_enabled",
>> @@ -2729,7 +2723,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= overcommit_policy_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two,
>> +		.extra2		= SYSCTL_TWO,
>>   	},
>>   	{
>>   		.procname	= "panic_on_oom",
>> @@ -2738,7 +2732,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two,
>> +		.extra2		= SYSCTL_TWO,
>>   	},
>>   	{
>>   		.procname	= "oom_kill_allocating_task",
>> @@ -2783,7 +2777,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= dirty_background_ratio_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &one_hundred,
>> +		.extra2		= SYSCTL_ONE_HUNDRED,
>>   	},
>>   	{
>>   		.procname	= "dirty_background_bytes",
>> @@ -2800,7 +2794,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= dirty_ratio_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &one_hundred,
>> +		.extra2		= SYSCTL_ONE_HUNDRED,
>>   	},
>>   	{
>>   		.procname	= "dirty_bytes",
>> @@ -2840,7 +2834,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two_hundred,
>> +		.extra2		= SYSCTL_TWO_HUNDRED,
>>   	},
>>   #ifdef CONFIG_HUGETLB_PAGE
>>   	{
>> @@ -2897,7 +2891,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0200,
>>   		.proc_handler	= drop_caches_sysctl_handler,
>>   		.extra1		= SYSCTL_ONE,
>> -		.extra2		= &four,
>> +		.extra2		= SYSCTL_FOUR,
>>   	},
>>   #ifdef CONFIG_COMPACTION
>>   	{
>> @@ -2914,7 +2908,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= compaction_proactiveness_sysctl_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &one_hundred,
>> +		.extra2		= SYSCTL_ONE_HUNDRED,
>>   	},
>>   	{
>>   		.procname	= "extfrag_threshold",
>> @@ -2959,7 +2953,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= watermark_scale_factor_sysctl_handler,
>>   		.extra1		= SYSCTL_ONE,
>> -		.extra2		= &one_thousand,
>> +		.extra2		= SYSCTL_ONE_THOUSAND,
>>   	},
>>   	{
>>   		.procname	= "percpu_pagelist_high_fraction",
>> @@ -3038,7 +3032,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &one_hundred,
>> +		.extra2		= SYSCTL_ONE_HUNDRED,
>>   	},
>>   	{
>>   		.procname	= "min_slab_ratio",
>> @@ -3047,7 +3041,7 @@ static struct ctl_table vm_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &one_hundred,
>> +		.extra2		= SYSCTL_ONE_HUNDRED,
>>   	},
>>   #endif
>>   #ifdef CONFIG_SMP
>> @@ -3337,7 +3331,7 @@ static struct ctl_table fs_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two,
>> +		.extra2		= SYSCTL_TWO,
>>   	},
>>   	{
>>   		.procname	= "protected_regular",
>> @@ -3346,7 +3340,7 @@ static struct ctl_table fs_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two,
>> +		.extra2		= SYSCTL_TWO,
>>   	},
>>   	{
>>   		.procname	= "suid_dumpable",
>> @@ -3355,7 +3349,7 @@ static struct ctl_table fs_table[] = {
>>   		.mode		= 0644,
>>   		.proc_handler	= proc_dointvec_minmax_coredump,
>>   		.extra1		= SYSCTL_ZERO,
>> -		.extra2		= &two,
>> +		.extra2		= SYSCTL_TWO,
>>   	},
>>   #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
>>   	{
> .
> 

