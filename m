Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C663D470EF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbhLJXyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 18:54:23 -0500
Received: from mail.loongson.cn ([114.242.206.163]:33572 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233117AbhLJXyU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:54:20 -0500
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKsjC57NhGAMGAA--.13314S3;
        Sat, 11 Dec 2021 07:50:27 +0800 (CST)
Subject: Re: [PATCH 1/2] kdump: vmcore: move copy_to() from vmcore.c to
 uaccess.h
To:     Andrew Morton <akpm@linux-foundation.org>
References: <1639143361-17773-1-git-send-email-yangtiezhu@loongson.cn>
 <1639143361-17773-2-git-send-email-yangtiezhu@loongson.cn>
 <20211210085903.e7820815e738d7dc6da06050@linux-foundation.org>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <249b17ea-171a-49f7-b438-488c03fa1f9b@loongson.cn>
Date:   Sat, 11 Dec 2021 07:50:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20211210085903.e7820815e738d7dc6da06050@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxKsjC57NhGAMGAA--.13314S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fuF47Zr17JryxKry5CFg_yoW8Kryxpr
        1UJrZIkr4IgFWUJFyqywn3X34rXw43CF1UJ393KF18A3WDXrn2vFnYvFyYgay8J3sIkF10
        ya4kXryfCr4qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_uwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUubyJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/2021 12:59 AM, Andrew Morton wrote:
> On Fri, 10 Dec 2021 21:36:00 +0800 Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> In arch/*/kernel/crash_dump*.c, there exist similar code about
>> copy_oldmem_page(), move copy_to() from vmcore.c to uaccess.h,
>> and then we can use copy_to() to simplify the related code.
>>
>> ...
>>
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -238,20 +238,6 @@ copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
>>  	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
>>  }
>>
>> -/*
>> - * Copy to either kernel or user space
>> - */
>> -static int copy_to(void *target, void *src, size_t size, int userbuf)
>> -{
>> -	if (userbuf) {
>> -		if (copy_to_user((char __user *) target, src, size))
>> -			return -EFAULT;
>> -	} else {
>> -		memcpy(target, src, size);
>> -	}
>> -	return 0;
>> -}
>> -
>>  #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
>>  static int vmcoredd_copy_dumps(void *dst, u64 start, size_t size, int userbuf)
>>  {
>> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
>> index ac03940..4a6c3e4 100644
>> --- a/include/linux/uaccess.h
>> +++ b/include/linux/uaccess.h
>> @@ -201,6 +201,20 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
>>  	return n;
>>  }
>>
>> +/*
>> + * Copy to either kernel or user space
>> + */
>> +static inline int copy_to(void *target, void *src, size_t size, int userbuf)
>> +{
>> +	if (userbuf) {
>> +		if (copy_to_user((char __user *) target, src, size))
>> +			return -EFAULT;
>> +	} else {
>> +		memcpy(target, src, size);
>> +	}
>> +	return 0;
>> +}
>> +
>
> Ordinarily I'd say "this is too large to be inlined".  But the function
> has only a single callsite per architecture so inlining it won't cause
> bloat at present.
>
> But hopefully copy_to() will get additional callers in the future, in
> which case it shouldn't be inlined.  So I'm thinking it would be best
> to start out with this as a regular non-inlined function, in
> lib/usercopy.c.
>
> Also, copy_to() is a very poor name for a globally-visible helper
> function.  Better would be copy_to_user_or_kernel(), although that's
> perhaps a bit long.
>
> And the `userbuf' arg should have type bool, yes?
>

Hi Andrew,

Thank you very much for your reply and suggestion, I agree with you,
I will send v2 later.

Thanks,
Tiezhu

