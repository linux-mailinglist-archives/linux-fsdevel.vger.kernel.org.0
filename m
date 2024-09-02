Return-Path: <linux-fsdevel+bounces-28249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E53968876
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FAD1F236AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785320012E;
	Mon,  2 Sep 2024 13:07:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91E746E;
	Mon,  2 Sep 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282431; cv=none; b=b7Au9lD+KLqXB0b21FNYCt6Pppj13AdQ9DKd4S4Byp2vRNLyuDtaj4udKfMZy6Ujvn1zf1LRUnzHj/dnw5bv9xDs3gPmIda70wRIAzBMTtRGaHsUsfKPonXszDsb9dpsdJ6RjHMReCT9+k/6xr54GlejHfFGxMZE+8Za8Q4QaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282431; c=relaxed/simple;
	bh=2i/Z9d1sSqDE7cfUxI+kQhMrLwLVAxUFIvaBcLLxE40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwDAP+ae6nDCuXFWQ015d/CPl3ezYT/7M60CrSgBXbX/hf4P2GnzROcnEEovhMxRST+sU11/vVKknoJWF0u7tcEoRcOnBG4spy6LFTywW9h2Bqoqp1t31YaRlGI5PN5uRkLk3Adc85dUxf+tQ2hK37mn73BUu/DmpMRgEzpGhO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy8DB1TB0z9sSN;
	Mon,  2 Sep 2024 15:07:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pEK_keS0MYWc; Mon,  2 Sep 2024 15:07:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy8DB0STbz9sS7;
	Mon,  2 Sep 2024 15:07:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F114A8B76C;
	Mon,  2 Sep 2024 15:07:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id unc9YceQJHKx; Mon,  2 Sep 2024 15:07:05 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F2E7F8B763;
	Mon,  2 Sep 2024 15:07:04 +0200 (CEST)
Message-ID: <23dcd8ab-592f-4e74-b7a7-99df3ffb9a3a@csgroup.eu>
Date: Mon, 2 Sep 2024 15:07:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC32
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
References: <cover.1725278148.git.christophe.leroy@csgroup.eu>
 <ec4d2919836a9f3a7791c2540ee79067396d701b.1725278148.git.christophe.leroy@csgroup.eu>
 <ZtWw6Wuudqj4IYWL@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtWw6Wuudqj4IYWL@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/09/2024 à 14:34, Jason A. Donenfeld a écrit :
> On Mon, Sep 02, 2024 at 02:04:41PM +0200, Christophe Leroy wrote:
>> This first patch adds support for PPC32. As selftests cannot easily
>> be generated only for PPC32, and because the following patch brings
>> support for PPC64 anyway, this patch opts out all code in
>> __arch_chacha20_blocks_nostack() so that vdso_test_chacha will not
>> fail to compile and will not crash on PPC64/PPC64LE, allthough the
>> selftest itself will fail. This patch also adds a dummy
>> __kernel_getrandom() function that returns ENOSYS on PPC64 so that
>> vdso_test_getrandom returns KSFT_SKIP instead of KSFT_FAIL.
> 
> Why not just wire up the selftests in the next patch like you did for
> v3? This seems like extra stuff for no huge reason?

In v3 selftests were already wired up in v3, and there was the following 
build failure:

$ make  ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-
   CC       vdso_test_gettimeofday
   CC       vdso_test_getcpu
   CC       vdso_test_abi
   CC       vdso_test_clock_getres
   CC       vdso_test_correctness
   CC       vdso_test_getrandom
   CC       vdso_test_chacha
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/arch/powerpc/vdso/vgetrandom-chacha.S: 
Assembler messages:
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/arch/powerpc/vdso/vgetrandom-chacha.S:84: 
Error: `stmw' invalid when little-endian
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/arch/powerpc/vdso/vgetrandom-chacha.S:198: 
Error: `lmw' invalid when little-endian
make: *** [../lib.mk:222: 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_chacha] 
Error 1

So I did this change to get a clean PPC32 implementation before going 
into PPC64. I thought it was easier to go in two steps for reviews, 
bisectability, etc .... for just a very little extra stuff.

> 
>>   arch/powerpc/Kconfig                         |   1 +
>>   arch/powerpc/include/asm/vdso/getrandom.h    |  54 +++++
>>   arch/powerpc/include/asm/vdso/vsyscall.h     |   6 +
>>   arch/powerpc/include/asm/vdso_datapage.h     |   2 +
>>   arch/powerpc/kernel/asm-offsets.c            |   1 +
>>   arch/powerpc/kernel/vdso/Makefile            |  13 +-
>>   arch/powerpc/kernel/vdso/getrandom.S         |  58 ++++++
>>   arch/powerpc/kernel/vdso/vdso32.lds.S        |   1 +
>>   arch/powerpc/kernel/vdso/vdso64.lds.S        |   1 +
>>   arch/powerpc/kernel/vdso/vgetrandom-chacha.S | 207 +++++++++++++++++++
>>   arch/powerpc/kernel/vdso/vgetrandom.c        |  16 ++
>>   tools/testing/selftests/vDSO/Makefile        |   2 +-
>>   12 files changed, 359 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
>>   create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
>>   create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
>>   create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c
> 
> I think you might have forgotten to add the symlink in this commit (or
> the next one, per my comment above, if you agree with it).

???? That's odd. All CI tests on github went ok !!! Looks like the CI 
tests for selftests are broken. Argh ! And of course on my computer the 
link was there so I didn't notice.

> 
>> +/*
>> + * Very basic 32 bits implementation of ChaCha20. Produces a given positive number
>> + * of blocks of output with a nonce of 0, taking an input key and 8-byte
>> + * counter. Importantly does not spill to the stack. Its arguments are:
>> + *
>> + *	r3: output bytes
>> + *	r4: 32-byte key input
>> + *	r5: 8-byte counter input/output (saved on stack)
>> + *	r6: number of 64-byte blocks to write to output
>> + *
>> + *	r0: counter of blocks (initialised with r6)
>> + *	r4: Value '4' after key has been read.
>> + *	r5-r12: key
>> + *	r14-r15: counter
>> + *	r16-r31: state
>> + */
>> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>> +#ifdef __powerpc64__
>> +	blr
>> +#else
>> +	stwu	r1, -96(r1)
>> +	stw	r5, 20(r1)
>> +	stmw	r14, 24(r1)
>> +
>> +	lwz	r14, 0(r5)
>> +	lwz	r15, 4(r5)
>> +	mr	r0, r6
>> +	subi	r3, r3, 4
>> +
>> +	lwz	r5, 0(r4)
>> +	lwz	r6, 4(r4)
>> +	lwz	r7, 8(r4)
>> +	lwz	r8, 12(r4)
>> +	lwz	r9, 16(r4)
>> +	lwz	r10, 20(r4)
>> +	lwz	r11, 24(r4)
>> +	lwz	r12, 28(r4)
> 
> If you don't want to do this, don't worry about it, but while I'm
> commenting on things, I think it's worth noting that x86, loongarch, and
> arm64 implementations all use the preprocessor or macros to give names
> to these registers -- state1,2,3,...copy1,2,3 and so forth. Might be
> worth doing the same if you think there's an easy and obvious way of
> doing it. If not -- or if that kind of work abhors you -- don't worry
> about it, as I'm confident enough that this code works fine. But it
> might be "nice to have". Up to you.

I'll have a look.

> 
>> +
>> +	li	r4, 4
>> +.Lblock:
>> +	li	r31, 10
>> +
> 
> Maybe a comment here, "expand 32-byte k" or similar.

ok

> 
>> +	lis	r16, 0x6170
>> +	lis	r17, 0x3320
>> +	lis	r18, 0x7962
>> +	lis	r19, 0x6b20
>> +	addi	r16, r16, 0x7865
>> +	addi	r17, r17, 0x646e
>> +	addi	r18, r18, 0x2d32
>> +	addi	r19, r19, 0x6574
>> +
>> +	mtctr	r31
>> +
>> +
>> +	subic.	r0, r0, 1	/* subi. can't use r0 as source */
> 
> Never seen the period suffix. Just looked this up. Neat.

Not sure what your comment is. Are you talking about the dot suffix 
after subic ?

That dot means I want CR register to be updated by the instruction. It 
is equivalent to doing a comparision of the result with 0. It is used by 
the bne (branch if not equal) a few lines later.

