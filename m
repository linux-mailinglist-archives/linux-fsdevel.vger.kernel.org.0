Return-Path: <linux-fsdevel+bounces-70095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75EC90827
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E28514E39FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2E24886E;
	Fri, 28 Nov 2025 01:39:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1323F41A;
	Fri, 28 Nov 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764293993; cv=none; b=Uw3sumSk/e/UsfGCDfjZwdACyPHUeqq9mh4HHFp1u0t6yiHSw0ulJwhnS0+vHfVBHbUq0hrDUUQteQoqeB/BphrN5i0+TFh5RqOe32NK3tSowO9iA7kAg0lzz2xLzP2R5CvQz3nD83OOBX6VQkNdST0AoF6is/LpzVYfdXa//M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764293993; c=relaxed/simple;
	bh=SAiq0GtSQbWnxZVlE11sfhFJ1QLRloNrcVj94VL94W8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UwkgTKQ5IHUYwEnSFtK6LTFnwAE43WyutVwBprflipdmYweqqDN9wmqbU6fw6dGjP72tjTIjDyWSmzSv1KbcffwXtta1SGhtwIFcyF7MMFr/zszrAEuvx5HlhPUWEU9ux0P5lOl2iMGRQfyeVjtsFZBN0g81VWiouTyeMCZMQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dHbYk4wkmzKHMJy;
	Fri, 28 Nov 2025 09:39:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C13761A084E;
	Fri, 28 Nov 2025 09:39:47 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP2 (Coremail) with SMTP id Syh0CgA3lHph_ShpgLYKCQ--.13716S3;
	Fri, 28 Nov 2025 09:39:47 +0800 (CST)
Message-ID: <61757d05-ffce-476d-9b07-88332e5db1b9@huaweicloud.com>
Date: Fri, 28 Nov 2025 09:39:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: Will Deacon <will@kernel.org>
Cc: jack@suse.com, brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
 linux@armlinux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com,
 wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, xieyuanbin1@huawei.com
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <aShLKpTBr9akSuUG@willie-the-truck>
 <9ff0d134-2c64-4204-bbac-9fdf0867ac46@huaweicloud.com>
 <39d99c56-3c2f-46bd-933f-2aef69d169f3@huaweicloud.com>
In-Reply-To: <39d99c56-3c2f-46bd-933f-2aef69d169f3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3lHph_ShpgLYKCQ--.13716S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XrW8WryxuF4kGFW5ZFW7CFg_yoW3Zw4fpr
	18Ca4UJFW5Wr18A3yjqw17JFyrta4UJw4UWr1DtF1UXr42vr1jgr40q3yv9w1UXr48Xw4U
	Xr15Jr17Zr1UJFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/11/28 9:18, Zizhi Wo 写道:
> 
> 
> 在 2025/11/28 9:17, Zizhi Wo 写道:
>>
>>
>> 在 2025/11/27 20:59, Will Deacon 写道:
>>> On Wed, Nov 26, 2025 at 05:05:05PM +0800, Zizhi Wo wrote:
>>>> We're running into the following issue on an ARM32 platform with the 
>>>> linux
>>>> 5.10 kernel:
>>>>
>>>> [<c0300b78>] (__dabt_svc) from [<c0529cb8>] 
>>>> (link_path_walk.part.7+0x108/0x45c)
>>>> [<c0529cb8>] (link_path_walk.part.7) from [<c052a948>] 
>>>> (path_openat+0xc4/0x10ec)
>>>> [<c052a948>] (path_openat) from [<c052cf90>] (do_filp_open+0x9c/0x114)
>>>> [<c052cf90>] (do_filp_open) from [<c0511e4c>] 
>>>> (do_sys_openat2+0x418/0x528)
>>>> [<c0511e4c>] (do_sys_openat2) from [<c0513d98>] (do_sys_open+0x88/0xe4)
>>>> [<c0513d98>] (do_sys_open) from [<c03000c0>] 
>>>> (ret_fast_syscall+0x0/0x58)
>>>> ...
>>>> [<c0315e34>] (unwind_backtrace) from [<c030f2b0>] 
>>>> (show_stack+0x20/0x24)
>>>> [<c030f2b0>] (show_stack) from [<c14239f4>] (dump_stack+0xd8/0xf8)
>>>> [<c14239f4>] (dump_stack) from [<c038d188>] 
>>>> (___might_sleep+0x19c/0x1e4)
>>>> [<c038d188>] (___might_sleep) from [<c031b6fc>] 
>>>> (do_page_fault+0x2f8/0x51c)
>>>> [<c031b6fc>] (do_page_fault) from [<c031bb44>] 
>>>> (do_DataAbort+0x90/0x118)
>>>> [<c031bb44>] (do_DataAbort) from [<c0300b78>] (__dabt_svc+0x58/0x80)
>>>> ...
>>>>
>>>> During the execution of hash_name()->load_unaligned_zeropad(), a 
>>>> potential
>>>> memory access beyond the PAGE boundary may occur. For example, when the
>>>> filename length is near the PAGE_SIZE boundary. This triggers a page 
>>>> fault,
>>>> which leads to a call to do_page_fault()->mmap_read_trylock(). If we 
>>>> can't
>>>> acquire the lock, we have to fall back to the mmap_read_lock() path, 
>>>> which
>>>> calls might_sleep(). This breaks RCU semantics because path lookup 
>>>> occurs
>>>> under an RCU read-side critical section. In linux-mainline, arm/arm64
>>>> do_page_fault() still has this problem:
>>>>
>>>> lock_mm_and_find_vma->get_mmap_lock_carefully->mmap_read_lock_killable.
>>>>
>>>> And before commit bfcfaa77bdf0 ("vfs: use 'unsigned long' accesses for
>>>> dcache name comparison and hashing"), hash_name accessed the name 
>>>> byte by
>>>> byte.
>>>>
>>>> To prevent load_unaligned_zeropad() from accessing beyond the valid 
>>>> memory
>>>> region, we would need to intercept such cases beforehand? But doing so
>>>> would require replicating the internal logic of 
>>>> load_unaligned_zeropad(),
>>>> including handling endianness and constructing the correct value 
>>>> manually.
>>>> Given that load_unaligned_zeropad() is used in many places across the
>>>> kernel, we currently haven't found a good solution to address this 
>>>> cleanly.
>>>>
>>>> What would be the recommended way to handle this situation? Would
>>>> appreciate any feedback and guidance from the community. Thanks!
>>>
>>> Does it help if you bodge the translation fault handler along the lines
>>> of the untested diff below?

I tried it out and it works — thank you for the solution you provided.

At the same time, since I’m a beginner in this area, I’d like to ask a
question.

The comment above do_translation_fault() says:
“We enter here because the first level page table doesn't contain a
valid entry for the address.”

However, after modifying the code, it seems that when encountering
FSR_FS_INVALID_PAGE, the kernel no longer creates a page table entry,
but instead directly jumps to bad_area.

I'd like to ask — could this change potentially cause any other side
effects?

Thanks,
Zizhi Wo


>>
>> Thank you for the solution you provided. However, I seem to have
>> encountered a bit of a problem.
>>
>>>
>>> Will
>>>
>>> --->8
>>>
>>> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>>> index bf1577216ffa..b3c81e448798 100644
>>> --- a/arch/arm/mm/fault.c
>>> +++ b/arch/arm/mm/fault.c
>>> @@ -407,7 +407,7 @@ do_translation_fault(unsigned long addr, unsigned 
>>> int fsr,
>>>          if (addr < TASK_SIZE)
>>>                  return do_page_fault(addr, fsr, regs);
>>> -       if (user_mode(regs))
>>> +       if (user_mode(regs) || fsr_fs(fsr) == FSR_FS_INVALID_PAGE)
>>>                  goto bad_area;
>>
>>
>>
>> I'm getting an "FSR_FS_INVALID_PAGE undeclared" error during
>> compilation...
>>
>> In which kernel or FSR version was this macro or constant defined
> 
> Sorry, I didn't see this "#define FSR_FS_INVALID_PAGE". I'll try again
> right away.
> 
> Please ignore my previous reply.
> 
>>
>>>          index = pgd_index(addr);
>>> diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
>>> index 9ecc2097a87a..8fb26f85e361 100644
>>> --- a/arch/arm/mm/fault.h
>>> +++ b/arch/arm/mm/fault.h
>>> @@ -12,6 +12,8 @@
>>>   #define FSR_FS3_0              (15)
>>>   #define FSR_FS5_0              (0x3f)
>>> +#define FSR_FS_INVALID_PAGE    7
>>> +
>>>   #ifdef CONFIG_ARM_LPAE
>>>   #define FSR_FS_AEA             17
>>> diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
>>> index f2be95197265..c7060da345df 100644
>>> --- a/arch/arm/mm/fsr-2level.c
>>> +++ b/arch/arm/mm/fsr-2level.c
>>> @@ -11,7 +11,7 @@ static struct fsr_info fsr_info[] = {
>>>          { do_bad,               SIGBUS,  0,             "external 
>>> abort on linefetch"      },
>>>          { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "section 
>>> translation fault"        },
>>>          { do_bad,               SIGBUS,  0,             "external 
>>> abort on linefetch"      },
>>> -       { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "page 
>>> translation fault"           },
>>> +       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "page 
>>> translation fault"           },
>>>          { do_bad,               SIGBUS,  0,             "external 
>>> abort on non-linefetch"  },
>>>          { do_bad,               SIGSEGV, SEGV_ACCERR,   "section 
>>> domain fault"             },
>>>          { do_bad,               SIGBUS,  0,             "external 
>>> abort on non-linefetch"  },
>>> diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
>>> index d0ae2963656a..19df4af828bd 100644
>>> --- a/arch/arm/mm/fsr-3level.c
>>> +++ b/arch/arm/mm/fsr-3level.c
>>> @@ -7,7 +7,7 @@ static struct fsr_info fsr_info[] = {
>>>          { do_bad,               SIGBUS,  0,             "reserved 
>>> translation fault"    },
>>>          { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level 1 
>>> translation fault"     },
>>>          { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level 2 
>>> translation fault"     },
>>> -       { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "level 3 
>>> translation fault"     },
>>> +       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level 3 
>>> translation fault"     },
>>>          { do_bad,               SIGBUS,  0,             "reserved 
>>> access flag fault"    },
>>>          { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 1 
>>> access flag fault"     },
>>>          { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 2 
>>> access flag fault"     },
>>>
>>>
>>
>> By the way, I tried Al's solution, and this problem didn't reproduce.
>>
>> Thanks,
>> Zizhi Wo
> 
> 


