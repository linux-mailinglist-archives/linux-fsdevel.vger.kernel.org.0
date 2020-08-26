Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA7252865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 09:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHZHYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 03:24:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbgHZHYz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:24:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02F4CECA6B47EDD70B14;
        Wed, 26 Aug 2020 15:24:50 +0800 (CST)
Received: from [127.0.0.1] (10.67.76.251) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 15:24:43 +0800
Subject: Re: [PATCH RESEND] fs: Move @f_count to different cacheline with
 @f_mode
To:     Will Deacon <will@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Yuqi Jin <jinyuqi@huawei.com>
References: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200821160252.GC21517@willie-the-truck>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <a75e514c-7e2d-54ed-45d4-327b2a514e67@hisilicon.com>
Date:   Wed, 26 Aug 2020 15:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200821160252.GC21517@willie-the-truck>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.76.251]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Will£¬

ÔÚ 2020/8/22 0:02, Will Deacon Ð´µÀ:
> On Wed, Jun 24, 2020 at 04:32:28PM +0800, Shaokun Zhang wrote:
>> get_file_rcu_many, which is called by __fget_files, has used
>> atomic_try_cmpxchg now and it can reduce the access number of the global
>> variable to improve the performance of atomic instruction compared with
>> atomic_cmpxchg. 
>>
>> __fget_files does check the @f_mode with mask variable and will do some
>> atomic operations on @f_count, but both are on the same cacheline.
>> Many CPU cores do file access and it will cause much conflicts on @f_count. 
>> If we could make the two members into different cachelines, it shall relax
>> the siutations.
>>
>> We have tested this on ARM64 and X86, the result is as follows:
>> Syscall of unixbench has been run on Huawei Kunpeng920 with this patch:
>> 24 x System Call Overhead  1
>>
>> System Call Overhead                    3160841.4 lps   (10.0 s, 1 samples)
>>
>> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
>> System Call Overhead                          15000.0    3160841.4   2107.2
>>                                                                    ========
>> System Benchmarks Index Score (Partial Only)                         2107.2
>>
>> Without this patch:
>> 24 x System Call Overhead  1
>>
>> System Call Overhead                    2222456.0 lps   (10.0 s, 1 samples)
>>
>> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
>> System Call Overhead                          15000.0    2222456.0   1481.6
>>                                                                    ========
>> System Benchmarks Index Score (Partial Only)                         1481.6
>>
>> And on Intel 6248 platform with this patch:
>> 40 CPUs in system; running 24 parallel copies of tests
>>
>> System Call Overhead                        4288509.1 lps   (10.0 s, 1 samples)
>>
>> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
>> System Call Overhead                          15000.0    4288509.1   2859.0
>>                                                                    ========
>> System Benchmarks Index Score (Partial Only)                         2859.0
>>
>> Without this patch:
>> 40 CPUs in system; running 24 parallel copies of tests
>>
>> System Call Overhead                        3666313.0 lps   (10.0 s, 1 samples)
>>
>> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
>> System Call Overhead                          15000.0    3666313.0   2444.2
>>                                                                    ========
>> System Benchmarks Index Score (Partial Only)                         2444.2
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Yuqi Jin <jinyuqi@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>  include/linux/fs.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 3f881a892ea7..0faeab5622fb 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -955,7 +955,6 @@ struct file {
>>  	 */
>>  	spinlock_t		f_lock;
>>  	enum rw_hint		f_write_hint;
>> -	atomic_long_t		f_count;
>>  	unsigned int 		f_flags;
>>  	fmode_t			f_mode;
>>  	struct mutex		f_pos_lock;
>> @@ -979,6 +978,7 @@ struct file {
>>  	struct address_space	*f_mapping;
>>  	errseq_t		f_wb_err;
>>  	errseq_t		f_sb_err; /* for syncfs */
>> +	atomic_long_t		f_count;
>>  } __randomize_layout
>>    __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
> 
> Hmm. So the microbenchmark numbers look lovely, but:

Thanks,

> 
>   - What impact does it actually have for real workloads?

It is exposed by we do the unixbench test. About the real workloads, if it has many
threads and open the same file, it shall be useful like unixbench.
If not the scenes, it should not be regression with the patch because we only change
the poistion of @f_count with @f_mode.

>   - How do we avoid regressing performance by innocently changing the struct
>     again later on?

It shall be commented this change on the @f_count, I'm not sure it is enough.

>   - This thing is tagged with __randomize_layout, so it doesn't help anybody
>     using that crazy plugin

This patch isolated the @f_count with @f_mode absolutely and we don't care the
base address of the structure, or I may miss something what you said.

>   - What about all the other atomics and locks that share cachelines?

An interesting question, to be honest, about this issue, we did performance
profile using unixbench and found it, then we want to relax the conflicts.
For other scenes, this method may be useful if it is debugged by the same
conflicts, but it can't be detected automatically.

Thanks,
Shaokun

> 
> Will
> 
> .
> 

