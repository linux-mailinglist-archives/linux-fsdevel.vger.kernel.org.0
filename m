Return-Path: <linux-fsdevel+bounces-52401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F1FAE30EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FE716ECBE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 17:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783891FA85A;
	Sun, 22 Jun 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBlOTpph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F41A8401;
	Sun, 22 Jun 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612436; cv=none; b=ZzJJzktRTLpjiA7i0s1D1pSRjzc8RpeFb3LlbnwO3jZ4wCIaGBPeY7iITavx9F0paVxnphysBgW7ESqpkz/oyTg+qqFGFv4gH3c39YX8jNWVCutAVEvtsiwb/ClvEoVsTmkOZVEkTqYDO15raq5M8KNzx/Oq/G8mOUEchjMKMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612436; c=relaxed/simple;
	bh=OpB79kb1PN9M9v5bToDJJdSJ0LtdpEetabSVjyQnTXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPTiT1YqVZ4jhpFCI+bw4auTJOWvugHVLt8XpiACPCbIoTYCCq+MDtIGVe2i2N84eQSoVIXk7Pz28cTjwK0VHCWv3QEGJ6bjHcRmGrKrjpSL+uyYr55YihP4RPAqBTO2/zXUGROgqfLuSmeeKig+r7+hENw2g8ljX1A5ZlTMO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBlOTpph; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453634d8609so18110915e9.3;
        Sun, 22 Jun 2025 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750612433; x=1751217233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIZU4ZB8m4d8Bq5Wfwj0E+qHG2zC3SoNULF9eyehTrI=;
        b=kBlOTpph8RbiIWcmzhHW94akG0P9Zc8tv0834m0MSJhzIBW5zNg1qLhD46adqyMcUH
         rRwqeTuam7IFQbUACmmdcpPIP14OSeDXimgv6sxv2tqlurKCS8Wx+gyCYe4pKV5+iBVH
         qFmdXPHQiD7DAs7BrEHATWGepo0SDd8biFgzR3cjYHJT6J4uOXSEe1Qml0Z+A04/PQar
         PadhVUXlyDzr8S7+kxGmAk+vDmqHjHhYUX1QnWD3LdJkSiy/0GAMTRpdo3kKTh5T6qfL
         3TpkWWhFbNYs69d4swtYWEpcDwMyM4m1ZytFdUVxZhR143hx55Hsr2un+C5b0sADBFXg
         B4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750612433; x=1751217233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIZU4ZB8m4d8Bq5Wfwj0E+qHG2zC3SoNULF9eyehTrI=;
        b=LDzVY5I7TXLuY7gsC87oo+EVAJ/1zuXR/R5j84VLbkPz3m9aAKkxbKTdGgjWFplykB
         RmPtoX8rseU1VXmrpzGk4g2b9BDXQCBZmp+xyVjNPIzvBWODyuk72WtLsv4wv7QWXDhR
         ENq1dZssSZyPSbVOE5v0l5f5N+rYUpd0YxndTI4OKGISwUVG8xIjQAFqSdAINKrjn1R3
         iX6zPGkI9PTQtCyvBlayQoaMdqQ5RNwT72fPVwYLwpiood+LWJUXZvMsxKXJB8abFWwN
         Q0B6tSC+Jrex19x1VvQG1R8upvemXzAV7HRW0OK6cr0ZFDAsnGAnMGS12XlSECjW7SRa
         SJxw==
X-Forwarded-Encrypted: i=1; AJvYcCWZAfuuI12eg1B2OBwvXxQ3/124tKfcN6trlLPO1I3Ii3/y6EpG0DbPIov+oobjLFDBjm0XPtqKvpUfDCof@vger.kernel.org, AJvYcCWqWFA5822M1Xe1bFs0YDndqypBPc1J9nU81lQ3+VPBua/lmQMh8d7grTo5s1wutBRVgqdWSgBpymMklv1N@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0mpxEFi7lE3EtWZoEFgiEA8mtPDDHQC+nSfScBCM2SnYQS9b
	d7O9qyVj3f7LpSks8oAOEONowoYYxKrgdx/V6bwGEYq2ve7BrC956dGJ
X-Gm-Gg: ASbGnctAo97SUK1GkB3f9k5mPaUyzzIit8e9J7yuldTAC/Qb3ezr2AECQkyVxYLa93t
	r6VkNyRYVrgicmwxWmUssAfE3aOwh6EB4w0s8Z2DEZSxBM+gFJi//EAozmnukk3c27qwhgQenGX
	Een/hcnO2M1KTqvKW2eQvyAJa8EL953yIv1PyPRJS3rQgk8JG1Ooy0PpXypIG0nwCuVRP1VLUXW
	hPxOro3KgQGJvn2avqhzAuVj67oqlA481d+IeBmvOg+1p5rRs4BjQnV8FbmPyliKpU4K89rTsJ0
	opzmf/6h+1kJPx3PZrhMVJMop2HpYXtnfXXcmur+E+v09+BeiB0+uxC0R+iWIjNRx/o+TS31Ac6
	l+xDJguL56Ut9s+VHrme9xtto
X-Google-Smtp-Source: AGHT+IFxKlVxKCduPVVRwrWdl6NPspLUWEEGe3o0GYO6USWSDesx39FJP/b+Omd3c/6Se1vOl1bWTw==
X-Received: by 2002:a05:600c:5250:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-453653925f1mr79632595e9.6.1750612432858;
        Sun, 22 Jun 2025 10:13:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f10a27sm7621546f8f.14.2025.06.22.10.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 10:13:52 -0700 (PDT)
Date: Sun, 22 Jun 2025 18:13:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, "Andre Almeida" <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 5/5] powerpc: Implement masked user access
Message-ID: <20250622181351.08141b50@pumpkin>
In-Reply-To: <9dfb66c94941e8f778c4cabbf046af2a301dd963.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<9dfb66c94941e8f778c4cabbf046af2a301dd963.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 11:52:43 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Masked user access avoids the address/size verification by access_ok().
> Allthough its main purpose is to skip the speculation in the
> verification of user address and size hence avoid the need of spec
> mitigation, it also has the advantage to reduce the amount of
> instructions needed so it also benefits to platforms that don't
> need speculation mitigation, especially when the size of the copy is
> not know at build time.

Not checking the size is slightly orthogonal.
It really just depends on the accesses being 'reasonably sequential'.
That is probably always true since access_ok() covers a single copy.

> 
> So implement masked user access on powerpc. The only requirement is
> to have memory gap that faults between the top user space and the
> real start of kernel area. On 64 bits platform it is easy, bit 0 is
> always 0 for user addresses and always 1 for kernel addresses and
> user addresses stop long before the end of the area. On 32 bits it
> is more tricky. It theory user space can go up to 0xbfffffff while
> kernel will usually start at 0xc0000000. So a gap needs to be added
> inbetween. Allthough in theory a single 4k page would suffice, it
> is easier and more efficient to enforce a 128k gap below kernel,
> as it simplifies the masking.

The gap isn't strictly necessary - provided the first access is guaranteed
to be at the specified address and the transfer are guaranteed sequential.
But that is hard to guarantee.

Where does the vdso end up?
My guess is 'near the top of userspace' - but maybe not.

> 
> Unlike x86_64 which masks the address to 'all bits set' when the
> user address is invalid, here the address is set to an address is
> the gap. It avoids relying on the zero page to catch offseted
> accesses.

Not true.
Using 'cmov' also removed an instruction.

> 
> e500 has the isel instruction which allows selecting one value or
> the other without branch and that instruction is not speculative, so
> use it. Allthough GCC usually generates code using that instruction,
> it is safer to use inline assembly to be sure. The result is:
> 
>   14:	3d 20 bf fe 	lis     r9,-16386
>   18:	7c 03 48 40 	cmplw   r3,r9
>   1c:	7c 69 18 5e 	iselgt  r3,r9,r3
> 
> On other ones, when kernel space is over 0x80000000 and user space
> is below, the logic in mask_user_address_simple() leads to a
> 3 instruction sequence:
> 
>   14:	7c 69 fe 70 	srawi   r9,r3,31
>   18:	7c 63 48 78 	andc    r3,r3,r9
>   1c:	51 23 00 00 	rlwimi  r3,r9,0,0,0
> 
> This is the default on powerpc 8xx.
> 
> When the limit between user space and kernel space is not 0x80000000,
> mask_user_address_32() is used and a 6 instructions sequence is
> generated:
> 
>   24:	54 69 7c 7e 	srwi    r9,r3,17
>   28:	21 29 57 ff 	subfic  r9,r9,22527
>   2c:	7d 29 fe 70 	srawi   r9,r9,31
>   30:	75 2a b0 00 	andis.  r10,r9,45056
>   34:	7c 63 48 78 	andc    r3,r3,r9
>   38:	7c 63 53 78 	or      r3,r3,r10
> 
> The constraint is that TASK_SIZE be aligned to 128K in order to get
> the most optimal number of instructions.
> 
> When CONFIG_PPC_BARRIER_NOSPEC is not defined, fallback on the
> test-based masking as it is quicker than the 6 instructions sequence
> but not necessarily quicker than the 3 instructions sequences above.

Doesn't that depend on whether the branch is predicted correctly?

I can't read ppc asm well enough to check the above.
And the C is also a bit tortuous.


> 
> On 64 bits, kernel is always above 0x8000000000000000 and user always
> below, which leads to a 4 instructions sequence:
> 
>   80:	7c 69 1b 78 	mr      r9,r3
>   84:	7c 63 fe 76 	sradi   r3,r3,63
>   88:	7d 29 18 78 	andc    r9,r9,r3
>   8c:	79 23 00 4c 	rldimi  r3,r9,0,1
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Kconfig               |   2 +-
>  arch/powerpc/include/asm/uaccess.h | 100 +++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c3e0cc83f120..c26a39b4504a 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -1303,7 +1303,7 @@ config TASK_SIZE
>  	hex "Size of user task space" if TASK_SIZE_BOOL
>  	default "0x80000000" if PPC_8xx
>  	default "0xb0000000" if PPC_BOOK3S_32 && EXECMEM
> -	default "0xc0000000"
> +	default "0xbffe0000"
>  
>  config MODULES_SIZE_BOOL
>  	bool "Set custom size for modules/execmem area"
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 89d53d4c2236..19743ee80523 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -2,6 +2,8 @@
>  #ifndef _ARCH_POWERPC_UACCESS_H
>  #define _ARCH_POWERPC_UACCESS_H
>  
> +#include <linux/sizes.h>
> +
>  #include <asm/processor.h>
>  #include <asm/page.h>
>  #include <asm/extable.h>
> @@ -455,6 +457,104 @@ user_write_access_begin(const void __user *ptr, size_t len)
>  #define user_write_access_begin	user_write_access_begin
>  #define user_write_access_end		prevent_current_write_to_user
>  
> +/*
> + * Masking the user address is an alternative to a conditional
> + * user_access_begin that can avoid the fencing. This only works
> + * for dense accesses starting at the address.

I think you need to say that kernel addresses get converted to an invalid
address between user and kernel addresses.
It works provided accesses are 'reasonably dense'.

	David

> + */
> +static inline void __user *mask_user_address_simple(const void __user *ptr)
> +{
> +	unsigned long addr = (unsigned long)ptr;
> +	unsigned long mask = (unsigned long)((long)addr >> (BITS_PER_LONG - 1));
> +
> +	addr = ((addr & ~mask) & (~0UL >> 1)) | (mask & (1UL << (BITS_PER_LONG - 1)));
> +
> +	return (void __user *)addr;
> +}
> +
> +static inline void __user *mask_user_address_e500(const void __user *ptr)
> +{
> +	unsigned long addr;
> +
> +	asm("cmplw %1, %2; iselgt %0, %2, %1" : "=r"(addr) : "r"(ptr), "r"(TASK_SIZE): "cr0");
> +
> +	return (void __user *)addr;
> +}
> +
> +/* Make sure TASK_SIZE is a multiple of 128K for shifting by 17 to the right */
> +static inline void __user *mask_user_address_32(const void __user *ptr)
> +{
> +	unsigned long addr = (unsigned long)ptr;
> +	unsigned long mask = (unsigned long)((long)((TASK_SIZE >> 17) - 1 - (addr >> 17)) >> 31);
> +
> +	addr = (addr & ~mask) | (TASK_SIZE & mask);
> +
> +	return (void __user *)addr;
> +}
> +
> +static inline void __user *mask_user_address_fallback(const void __user *ptr)
> +{
> +	unsigned long addr = (unsigned long)ptr;
> +
> +	return (void __user *)(addr < TASK_SIZE ? addr : TASK_SIZE);
> +}
> +
> +static inline void __user *mask_user_address(const void __user *ptr)
> +{
> +#ifdef MODULES_VADDR
> +	const unsigned long border = MODULES_VADDR;
> +#else
> +	const unsigned long border = PAGE_OFFSET;
> +#endif
> +	BUILD_BUG_ON(TASK_SIZE_MAX & (SZ_128K - 1));
> +	BUILD_BUG_ON(TASK_SIZE_MAX + SZ_128K > border);
> +	BUILD_BUG_ON(TASK_SIZE_MAX & 0x8000000000000000ULL);
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_PPC64) && !(PAGE_OFFSET & 0x8000000000000000ULL));
> +
> +	if (IS_ENABLED(CONFIG_PPC64))
> +		return mask_user_address_simple(ptr);
> +	if (IS_ENABLED(CONFIG_E500))
> +		return mask_user_address_e500(ptr);
> +	if (TASK_SIZE <= SZ_2G && border >= SZ_2G)
> +		return mask_user_address_simple(ptr);
> +	if (IS_ENABLED(CONFIG_PPC_BARRIER_NOSPEC))
> +		return mask_user_address_32(ptr);
> +	return mask_user_address_fallback(ptr);
> +}
> +
> +static inline void __user *masked_user_access_begin(const void __user *p)
> +{
> +	void __user *ptr = mask_user_address(p);
> +
> +	might_fault();
> +	allow_read_write_user(ptr, ptr);
> +
> +	return ptr;
> +}
> +#define masked_user_access_begin masked_user_access_begin
> +
> +static inline void __user *masked_user_read_access_begin(const void __user *p)
> +{
> +	void __user *ptr = mask_user_address(p);
> +
> +	might_fault();
> +	allow_read_from_user(ptr);
> +
> +	return ptr;
> +}
> +#define masked_user_read_access_begin masked_user_read_access_begin
> +
> +static inline void __user *masked_user_write_access_begin(const void __user *p)
> +{
> +	void __user *ptr = mask_user_address(p);
> +
> +	might_fault();
> +	allow_write_to_user(ptr);
> +
> +	return ptr;
> +}
> +#define masked_user_write_access_begin masked_user_write_access_begin
> +
>  #define unsafe_get_user(x, p, e) do {					\
>  	__long_type(*(p)) __gu_val;				\
>  	__typeof__(*(p)) __user *__gu_addr = (p);		\


