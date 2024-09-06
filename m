Return-Path: <linux-fsdevel+bounces-28826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F54D96E8C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 06:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1331C23765
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175915A79B;
	Fri,  6 Sep 2024 04:53:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997745C1C;
	Fri,  6 Sep 2024 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598412; cv=none; b=uWKj7YGh7x/qh88Nvi5/r7zZT3r9LxIAS1qkgv31lYQnuExbfAcuGlkifsFVI+CiBlMggQEymQMWZvNhsg8AGALa5tf2PGuNpTEFxFht86FFuQRraaX4YVmoGlatXoRsLgREco5QqMcmBgXD2EbGRqAjH9ejXsxkJnfMzguvGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598412; c=relaxed/simple;
	bh=A75lYGrLa/x3ArGAifgM6TS5Vw27r6mpHb5G0N+ZIgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP0iOHUwkvqdCf406EW8DjgA/qvGnQfgtZtmmi2F41i2Ez5o/JR06OZv/VEfrqepLhTNHRvGFFkt02OAuICoj3fWYLFYREh4tOiKT5NuPlhnzh9aVApvXD5sDjwOkTvjZsyuyq+UdcmmioNjn6JL1NC3kieUjyrXWbjrcWzPztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0P4l4sMRz9sRy;
	Fri,  6 Sep 2024 06:53:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cGNa5ow0wQLB; Fri,  6 Sep 2024 06:53:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0P4l3spgz9sRs;
	Fri,  6 Sep 2024 06:53:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 739B98B778;
	Fri,  6 Sep 2024 06:53:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id X35N0C8uKPzN; Fri,  6 Sep 2024 06:53:27 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D03E8B764;
	Fri,  6 Sep 2024 06:53:26 +0200 (CEST)
Message-ID: <45f7170d-a209-4079-9384-274b0c413a4b@csgroup.eu>
Date: Fri, 6 Sep 2024 06:53:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on VDSO32
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
 <ZtnYqZI-nrsNslwy@zx2c4.com> <ZtoXhGYflBNR74g0@zx2c4.com>
 <ZtptfOicjZU3k3ZV@zx2c4.com> <Ztp16FkqG0ALlXnh@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Ztp16FkqG0ALlXnh@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason,

Le 06/09/2024 à 05:24, Jason A. Donenfeld a écrit :
> On Fri, Sep 06, 2024 at 04:48:28AM +0200, Jason A. Donenfeld wrote:
>> On Thu, Sep 05, 2024 at 10:41:40PM +0200, Jason A. Donenfeld wrote:
>>> On Thu, Sep 05, 2024 at 06:13:29PM +0200, Jason A. Donenfeld wrote:
>>>>> +/*
>>>>> + * The macro sets two stack frames, one for the caller and one for the callee
>>>>> + * because there are no requirement for the caller to set a stack frame when
>>>>> + * calling VDSO so it may have omitted to set one, especially on PPC64
>>>>> + */
>>>>> +
>>>>> +.macro cvdso_call funct
>>>>> +  .cfi_startproc
>>>>> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
>>>>> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
>>>>> +	mflr		r0
>>>>> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
>>>>> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
>>>>> +	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
>>>>> +  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
>>>>> +	get_datapage	r8
>>>>> +	addi		r8, r8, VDSO_RNG_DATA_OFFSET
>>>>> +	bl		CFUNC(DOTSYM(\funct))
>>>>> +	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
>>>>> +	cmpwi		r3, 0
>>>>> +	mtlr		r0
>>>>> +	addi		r1, r1, 2 * PPC_MIN_STKFRM
>>>>> +  .cfi_restore lr
>>>>> +  .cfi_def_cfa_offset 0
>>>>> +	crclr		so
>>>>> +	bgelr+
>>>>> +	crset		so
>>>>> +	neg		r3, r3
>>>>> +	blr
>>>>> +  .cfi_endproc
>>>>> +.endm
>>>>
>>>> Can you figure out what's going on and send a fix, which I'll squash
>>>> into this commit?
>>>
>>> This doesn't work, but I wonder if something like it is what we want. I
>>> need to head out for the day, but here's what I've got. It's all wrong
>>> but might be of interest.
>>
>> Oh, I just got one small detail wrong before. The below actually works,
>> and uses the same strategy as on arm64.
>>
>> Let me know if you'd like me to fix up this commit with the below patch,
>> or if you have another way you'd like to go about it.
> 
> And here's the much shorter version in assembly, which maybe you prefer.
> Also works, and is a bit less invasive than the other thing.
> 
> diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
> index a957cd2b2b03..070daba2d547 100644
> --- a/arch/powerpc/kernel/vdso/getrandom.S
> +++ b/arch/powerpc/kernel/vdso/getrandom.S
> @@ -32,6 +32,14 @@
>     .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
>   #endif
>   	get_datapage	r8
> +#ifdef CONFIG_TIME_NS
> +	lis		r10, 0x7fff
> +	ori		r10, r10, 0xffff
> +	lwz		r9, VDSO_DATA_OFFSET + 4(r8)
> +	cmpw		r9, r10
> +	bne		+8
> +	addi		r8, r8, (1 << CONFIG_PAGE_SHIFT)
> +#endif
>   	addi		r8, r8, VDSO_RNG_DATA_OFFSET
>   	bl		CFUNC(DOTSYM(\funct))
>   	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> 

Thanks for looking.

I came to more or less the same solutions thnt you with the following 
that seems to work:

diff --git a/arch/powerpc/kernel/vdso/vgetrandom.c 
b/arch/powerpc/kernel/vdso/vgetrandom.c
index 5f855d45fb7b..9705344d39d0 100644
--- a/arch/powerpc/kernel/vdso/vgetrandom.c
+++ b/arch/powerpc/kernel/vdso/vgetrandom.c
@@ -4,11 +4,19 @@
   *
   * Copyright (C) 2024 Christophe Leroy <christophe.leroy@csgroup.eu>, 
CS GROUP France
   */
+#include <linux/container_of.h>
  #include <linux/time.h>
  #include <linux/types.h>

+#include <asm/vdso_datapage.h>
+
  ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int 
flags, void *opaque_state,
  			     size_t opaque_len, const struct vdso_rng_data *vd)
  {
+	struct vdso_arch_data *arch_data = container_of(vd, struct 
vdso_arch_data, rng_data);
+
+	if (IS_ENABLED(CONFIG_TIME_NS) && arch_data->data[0].clock_mode == 
VDSO_CLOCKMODE_TIMENS)
+		vd = (void *)vd + (1UL << CONFIG_PAGE_SHIFT);
+
  	return __cvdso_getrandom_data(vd, buffer, len, flags, opaque_state, 
opaque_len);
  }


However, if we have this problem with __kernel_getrandom, don't we also 
have it with: ?
		__kernel_get_syscall_map;
		__kernel_get_tbfreq;
		__kernel_sync_dicache;

If they are also affected, then get_page macro is the place to fix.

I will check all of this now and keep you updated before noon (Paris Time).

Christophe

