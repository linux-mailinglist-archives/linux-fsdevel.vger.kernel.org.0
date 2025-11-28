Return-Path: <linux-fsdevel+bounces-70092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30EC90797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7423A8E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1E224B0E;
	Fri, 28 Nov 2025 01:17:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685C6A33B;
	Fri, 28 Nov 2025 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292638; cv=none; b=OMtqXMPUX7VpWPVDA6q+U1xq8EGA7jUF1aw5k8BgSX2GvSWB14IO7ai+LZpZSj17Tl06hEuCJuTYYjslvnmyzvjIghN9ACO/2rqGBTuUWin3B+0lWv2hMgzbmIT1IbKW0/AP3STXFHU/Zyl2Y3SdJFkL+l2/1qAdJl5fFSreWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292638; c=relaxed/simple;
	bh=KqZWIKWsIx7r3XjGU+st7kD8YQyuIwp43ppIoz1dE4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhyANPMnAYR4lyDjCTC3ThfTrkwlV08b8l+J8z8phtKxJCCfkbNd1WH9GxnO5hMIRYAIB0wXwox3Xg6Ho3/MFbwhmYtgo2vqWQkK8O1BKRQEXCQ4NDx/l0SF4wImeUIJ2/6rr5M/KXMd0SlbvOAyKUQbQ+U3Ty2Xc8X2ze5z1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dHb3j3bRhzKHMPw;
	Fri, 28 Nov 2025 09:16:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8FEA21A1123;
	Fri, 28 Nov 2025 09:17:14 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXsY+ChphOEICQ--.36213S3;
	Fri, 28 Nov 2025 09:17:14 +0800 (CST)
Message-ID: <9ff0d134-2c64-4204-bbac-9fdf0867ac46@huaweicloud.com>
Date: Fri, 28 Nov 2025 09:17:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Will Deacon <will@kernel.org>, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: jack@suse.com, brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
 linux@armlinux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com,
 wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, xieyuanbin1@huawei.com
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <aShLKpTBr9akSuUG@willie-the-truck>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <aShLKpTBr9akSuUG@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHpXsY+ChphOEICQ--.36213S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WryrWw45uw1fKw17tw4rAFb_yoW7Zr18pr
	Wjk3W2krZIgrWak3yIqanxWFyrJa4Iqr4UGr9rGr1kuw47Xryjga1kK39Yk347Xw1kW3yF
	vr4Fvr1Uuw1DC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/11/27 20:59, Will Deacon 写道:
> On Wed, Nov 26, 2025 at 05:05:05PM +0800, Zizhi Wo wrote:
>> We're running into the following issue on an ARM32 platform with the linux
>> 5.10 kernel:
>>
>> [<c0300b78>] (__dabt_svc) from [<c0529cb8>] (link_path_walk.part.7+0x108/0x45c)
>> [<c0529cb8>] (link_path_walk.part.7) from [<c052a948>] (path_openat+0xc4/0x10ec)
>> [<c052a948>] (path_openat) from [<c052cf90>] (do_filp_open+0x9c/0x114)
>> [<c052cf90>] (do_filp_open) from [<c0511e4c>] (do_sys_openat2+0x418/0x528)
>> [<c0511e4c>] (do_sys_openat2) from [<c0513d98>] (do_sys_open+0x88/0xe4)
>> [<c0513d98>] (do_sys_open) from [<c03000c0>] (ret_fast_syscall+0x0/0x58)
>> ...
>> [<c0315e34>] (unwind_backtrace) from [<c030f2b0>] (show_stack+0x20/0x24)
>> [<c030f2b0>] (show_stack) from [<c14239f4>] (dump_stack+0xd8/0xf8)
>> [<c14239f4>] (dump_stack) from [<c038d188>] (___might_sleep+0x19c/0x1e4)
>> [<c038d188>] (___might_sleep) from [<c031b6fc>] (do_page_fault+0x2f8/0x51c)
>> [<c031b6fc>] (do_page_fault) from [<c031bb44>] (do_DataAbort+0x90/0x118)
>> [<c031bb44>] (do_DataAbort) from [<c0300b78>] (__dabt_svc+0x58/0x80)
>> ...
>>
>> During the execution of hash_name()->load_unaligned_zeropad(), a potential
>> memory access beyond the PAGE boundary may occur. For example, when the
>> filename length is near the PAGE_SIZE boundary. This triggers a page fault,
>> which leads to a call to do_page_fault()->mmap_read_trylock(). If we can't
>> acquire the lock, we have to fall back to the mmap_read_lock() path, which
>> calls might_sleep(). This breaks RCU semantics because path lookup occurs
>> under an RCU read-side critical section. In linux-mainline, arm/arm64
>> do_page_fault() still has this problem:
>>
>> lock_mm_and_find_vma->get_mmap_lock_carefully->mmap_read_lock_killable.
>>
>> And before commit bfcfaa77bdf0 ("vfs: use 'unsigned long' accesses for
>> dcache name comparison and hashing"), hash_name accessed the name byte by
>> byte.
>>
>> To prevent load_unaligned_zeropad() from accessing beyond the valid memory
>> region, we would need to intercept such cases beforehand? But doing so
>> would require replicating the internal logic of load_unaligned_zeropad(),
>> including handling endianness and constructing the correct value manually.
>> Given that load_unaligned_zeropad() is used in many places across the
>> kernel, we currently haven't found a good solution to address this cleanly.
>>
>> What would be the recommended way to handle this situation? Would
>> appreciate any feedback and guidance from the community. Thanks!
> 
> Does it help if you bodge the translation fault handler along the lines
> of the untested diff below?

Thank you for the solution you provided. However, I seem to have
encountered a bit of a problem.

> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index bf1577216ffa..b3c81e448798 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -407,7 +407,7 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
>          if (addr < TASK_SIZE)
>                  return do_page_fault(addr, fsr, regs);
>   
> -       if (user_mode(regs))
> +       if (user_mode(regs) || fsr_fs(fsr) == FSR_FS_INVALID_PAGE)
>                  goto bad_area;



I'm getting an "FSR_FS_INVALID_PAGE undeclared" error during
compilation...

In which kernel or FSR version was this macro or constant defined?

>   
>          index = pgd_index(addr);
> diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
> index 9ecc2097a87a..8fb26f85e361 100644
> --- a/arch/arm/mm/fault.h
> +++ b/arch/arm/mm/fault.h
> @@ -12,6 +12,8 @@
>   #define FSR_FS3_0              (15)
>   #define FSR_FS5_0              (0x3f)
>   
> +#define FSR_FS_INVALID_PAGE    7
> +
>   #ifdef CONFIG_ARM_LPAE
>   #define FSR_FS_AEA             17
>   
> diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
> index f2be95197265..c7060da345df 100644
> --- a/arch/arm/mm/fsr-2level.c
> +++ b/arch/arm/mm/fsr-2level.c
> @@ -11,7 +11,7 @@ static struct fsr_info fsr_info[] = {
>          { do_bad,               SIGBUS,  0,             "external abort on linefetch"      },
>          { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "section translation fault"        },
>          { do_bad,               SIGBUS,  0,             "external abort on linefetch"      },
> -       { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "page translation fault"           },
> +       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "page translation fault"           },
>          { do_bad,               SIGBUS,  0,             "external abort on non-linefetch"  },
>          { do_bad,               SIGSEGV, SEGV_ACCERR,   "section domain fault"             },
>          { do_bad,               SIGBUS,  0,             "external abort on non-linefetch"  },
> diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
> index d0ae2963656a..19df4af828bd 100644
> --- a/arch/arm/mm/fsr-3level.c
> +++ b/arch/arm/mm/fsr-3level.c
> @@ -7,7 +7,7 @@ static struct fsr_info fsr_info[] = {
>          { do_bad,               SIGBUS,  0,             "reserved translation fault"    },
>          { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level 1 translation fault"     },
>          { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level 2 translation fault"     },
> -       { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "level 3 translation fault"     },
> +       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "level 3 translation fault"     },
>          { do_bad,               SIGBUS,  0,             "reserved access flag fault"    },
>          { do_bad,               SIGSEGV, SEGV_ACCERR,   "level 1 access flag fault"     },
>          { do_page_fault,        SIGSEGV, SEGV_ACCERR,   "level 2 access flag fault"     },
> 
> 

By the way, I tried Al's solution, and this problem didn't reproduce.

Thanks,
Zizhi Wo


