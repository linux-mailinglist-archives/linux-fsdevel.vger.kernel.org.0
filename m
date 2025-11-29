Return-Path: <linux-fsdevel+bounces-70193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 761BAC93572
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 02:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BACB4E18FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0715A85A;
	Sat, 29 Nov 2025 01:01:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EECB67A;
	Sat, 29 Nov 2025 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764378078; cv=none; b=FbsF4cM4XnDjQrg18kGtZM/BFxmA3XWIeFy2q8bLMxeijlhZWKQ7nPxgqpGuxJNCYALG8Fu96ZMZf8144pwL60iMMCzXtAHlgrOQcghH9aZw3IRW7yLNQtFgORS1+GoWlVVh4WxdIvLMLJgoUcL+aFAuhbd4os69pBD1S20VVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764378078; c=relaxed/simple;
	bh=JLmgeXGha3V2iUl0/BUuiVqsViKweVLN8wzwQ2mkX74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H86r/zJyLpD/xqKK3FJlQGLTIaEbBmzUGRcAHHC9qS+QRYtWGGuDLBaDAHdrft7+6JesxCsyE36G2Vo5biS7Dpgob2UlKLGh4pND1comaJvBXukPEtO2+jnBqRGX25WN8SR0Yd+e7s1jc2n7RHJ96UyzFufMq5+DDVysxZU1ERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dJBfk1t0HzKHMMN;
	Sat, 29 Nov 2025 09:00:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CBE5C1A0359;
	Sat, 29 Nov 2025 09:01:12 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP2 (Coremail) with SMTP id Syh0CgCH5XvWRSppIhd8CQ--.54714S3;
	Sat, 29 Nov 2025 09:01:12 +0800 (CST)
Message-ID: <3d590a6d-07d1-433c-add1-8b7d53018854@huaweicloud.com>
Date: Sat, 29 Nov 2025 09:01:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Zizhi Wo <wozizhi@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 jack@suse.com, brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 yangerkun@huawei.com, wangkefeng.wang@huawei.com, pangliyuan1@huawei.com,
 xieyuanbin1@huawei.com, Al Viro <viro@zeniv.linux.org.uk>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
 <CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com>
 <aSgut4QcBsbXDEo9@shell.armlinux.org.uk>
 <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH5XvWRSppIhd8CQ--.54714S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw45Cr1kXry7trWxJF47Jwb_yoW5CFWrpr
	Wjk3ZIk3y7WF1Sya4xAan2vFyxA3Z5Ar45GF90krs5uwsrWrnFgw4Sgws0y3429rnYga10
	vr4YvryUuwn8GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/11/29 1:06, Linus Torvalds 写道:
> On Thu, 27 Nov 2025 at 02:58, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
>>
>> Ha!
>>
>> As said elsewhere, it looks like 32-bit ARM has been missing updates to
>> the fault handler since pre-git history - this was modelled in the dim
>> and distant i386 handling, and it just hasn't kept up.
> 
> I actually have this dim memory of having seen something along these
> lines before, and I just had never realized how it could happen,
> because that call to do_page_fault() in do_translation_fault()
> visually *looks* like the only call-site, and so that
> 
>          if (addr < TASK_SIZE)
>                  return do_page_fault(addr, fsr, regs);
> 
> looks like it does everything correctly. That "do_page_fault()"
> function is static to the arch/arm/mm/fault.c file, and that's the
> only place that appears to call it.
> 
> The operative word being "appears".
> 
> Becuse I had never before realized that that fault.c then also does that
> 
>    #include "fsr-2level.c"
> 
> and then that do_page_fault() function is exposed through those
> fsr_info[] operation arrays.

Yes, it enters through fsr_info.

> 
> Anyway, I don't think that the ARM fault handling is all *that* bad.
> Sure, it might be worth double-checking, but it *has* been converted
> to the generic accounting helpers a few years ago and to the stack
> growing fixes.
> 
> I think the fix here may be as simple as this trivial patch:
> 
>    diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
>    index 2bc828a1940c..27024ec2d46d 100644
>    --- a/arch/arm/mm/fault.c
>    +++ b/arch/arm/mm/fault.c
>    @@ -277,6 +277,10 @@ do_page_fault(unsigned long addr, ...
>          if (interrupts_enabled(regs))
>                  local_irq_enable();
> 
>    +     /* non-user address faults never have context */
>    +     if (addr >= TASK_SIZE)
>    +             goto no_context;
>    +
>          /*
>           * If we're in an interrupt or have no user
>           * context, we must not take the fault..
> 
> but I really haven't thought much about it.
> 
>> I'm debating whether an entire rewrite would be appropriate

Thank you for your answer. In fact, this solution is similar to the one
provided by Al. It has an additional check to determine reg:

```
if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
	goto no_context;
```

I'd like to ask if this "regs" examination also needs to be brought
along?

I'm even thinking if we directly have the corresponding processing
replaced by do_translation_fault(), is that also correct?

```
-       { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "page 
translation fault"           },
+       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "page 
translation fault"           },
```

> 
> I don't think it's necessarily all that big of a deal. Yeah, this is
> old code, and yeah, it could probably be cleaned up a bit, but at the
> same time, "old and crusty" also means "fairly well tested". This
> whole fault on a kernel address is a fairly unusual case, and as
> mentioned, I *think* the above fix is sufficient.
> 
> Zizhi Wo - can you confirm that that patch (whitespace-damaged, but
> simple enough to just do manually) fixes things for your test-case?
> 
>             Linus
> 

I tried it out and it works — thanks!

Thanks,
Zizhi Wo


