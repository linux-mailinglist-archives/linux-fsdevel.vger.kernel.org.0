Return-Path: <linux-fsdevel+bounces-70286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0947C95914
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 03:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D47B84E0268
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 02:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0AF1A5B8B;
	Mon,  1 Dec 2025 02:08:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C41A3179;
	Mon,  1 Dec 2025 02:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554887; cv=none; b=GFXGeL6vFAmPxGU0fYQ48Rr0EZPPPDVQVFE33XAmlDVZJJFBkLBG4QpinHhDykbVidA/sZCDwFIEDEGAUhY6gi4VPZNTUWEXu9bjFFGQXAx4hbco4nLfAt5Lur3LlSupSeruryPrHeZ/gzs34dBfXERHL/babRkC2KvA2agKLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554887; c=relaxed/simple;
	bh=34BZQdkmk7cRBZOwMeopX9D7UYopRvGYZS4O2T3YZxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrK5U+m5h/GMngU8QrQu6T7G3XwK3kPzjvfw7z33naseuvOeGk6XwidfW16UKX89mbKvQAY1n1mKbnH/Zy6wx5cDCr8yU1Oi2k+o4IrOI26Hje4V3tCDJbpgeuKAmiL3F1vZ0FwvN+ihERjuV6Q2sUo92ZkPMGG9jQZszbrxLXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dKS2r2wTvzKHMLr;
	Mon,  1 Dec 2025 10:07:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 174D41A07BB;
	Mon,  1 Dec 2025 10:08:02 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP2 (Coremail) with SMTP id Syh0CgCnhU+A+Cxp0DS5AA--.50428S3;
	Mon, 01 Dec 2025 10:08:01 +0800 (CST)
Message-ID: <32d0a330-5f14-4c1f-8706-1301a1b66864@huaweicloud.com>
Date: Mon, 1 Dec 2025 10:08:00 +0800
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
 Zizhi Wo <wozizhi@huaweicloud.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
 <3d590a6d-07d1-433c-add1-8b7d53018854@huaweicloud.com>
 <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnhU+A+Cxp0DS5AA--.50428S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww13AFW7tryftw17Wr4Durg_yoW8trWfpF
	yj9wsakrW8AryIyF97Ja1kAaySkFn5Zr4UGFy5trykua90vFySvw4SqryYyrWqqrnY9a1I
	qw4UXr1Uu3WDtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/11/29 9:35, Linus Torvalds 写道:
> On Fri, 28 Nov 2025 at 17:01, Zizhi Wo <wozizhi@huaweicloud.com> wrote:
>>
>> Thank you for your answer. In fact, this solution is similar to the one
>> provided by Al.
> 
> Hmm. I'm not seeing the replies from Al for some reason. Maybe he didn't cc me.
> 
>> It has an additional check to determine reg:
>>
>> if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
>>          goto no_context;
>>
>> I'd like to ask if this "regs" examination also needs to be brought
>> along?
> 
> That seems unnecessary.
> 
> Yes, in this case the original problem you reported with sleeping in
> an RCU region was triggered by a kernel access, and a user-space
> access would never have caused any such issues.
> 
> So checking for !user_mode(regs) isn't exactly *wrong*.
> 
> But while it isn't wrong, I think it's also kind of pointless.
> 
> Because regardless of whether it's a kernel or user space access, an
> access outside TASK_SIZE shouldn't be associated with a valid user
> space context, so the code might as well just go to the "no_context"
> label directly.
> 
> That said, somebody should  definitely double-check me - because I
> think arm also did the vdso trick at high addresses that i386 used to
> do, so there is the fake VDSO thing up there.
> 
> But if you get a page fault on that, it's not going to be fixed up, so
> even if user space can access it, there's no point in looking that
> fake vm area up for page faults.
> 
> I think.
> 
>> I'm even thinking if we directly have the corresponding processing
>> replaced by do_translation_fault(), is that also correct?
>>
>> ```
>> -       { do_page_fault,        SIGSEGV, SEGV_MAPERR,   "page
>> translation fault"           },
>> +       { do_translation_fault, SIGSEGV, SEGV_MAPERR,   "page
>> translation fault"           },
> 
> I think that might break kprobes.
> 
> Looking around, I think my patch might also be a bit broken: I think
> it might be better to move it further down to below the check for
> FSR_LNX_PF.
> 
> But somebody who knows the exact arm page fault handling better than
> me should verify both that and my VDSO gate page thinking.
> 
>             Linus
> 

Thank you for your reply! Regarding the existing discussions in the
community, I will re-examine the logic in this regard and digest it.

Thanks,
Zizhi Wo


