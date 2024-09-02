Return-Path: <linux-fsdevel+bounces-28250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67059968891
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 15:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C824FB2422C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A11D175E;
	Mon,  2 Sep 2024 13:12:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA91DAC5E;
	Mon,  2 Sep 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282772; cv=none; b=oxSP12PHVFYTr2wI8KZnhLmulFUtkdBOfMYnGxXmu3RWvoe8+MwrAajN2rlbw7SkecqW1+GYagXwHdRw3Yy6CyDTkqB7xfnhO1415VQ2HdVIEsfpmS9/HbZ/hMNTf9VqM6KUrD3oBNfBE28r10WxooVaYryUFafUN9hWgU5y0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282772; c=relaxed/simple;
	bh=ZBo7aRATQMh4u4PYHX2hGyvAc1Uqu4weIrPRMvH+4Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrxYrnq2qZTcFgoHkNGopZLIFKK+S3IU6GIb2JEwR6puURKJ2u4hjYb6nvwkKpEA/o7ZbzCZeQkEEuEDx173Axn1/G0IeAiE04AMky0KJNao0t33GoghI6x67CitN1Y55e6VmZBrCdzYFLWJ0VAgH+AiEf761uYGq+KxGOVc2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy8Lm6QHHz9sSN;
	Mon,  2 Sep 2024 15:12:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOAmrEYbu_oc; Mon,  2 Sep 2024 15:12:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy8Lm5Z1Xz9sS7;
	Mon,  2 Sep 2024 15:12:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AD68B8B76C;
	Mon,  2 Sep 2024 15:12:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id bvD0TdiWVJyj; Mon,  2 Sep 2024 15:12:48 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B29AB8B763;
	Mon,  2 Sep 2024 15:12:47 +0200 (CEST)
Message-ID: <bdf1a515-b3d0-471d-89ee-989ae0d63202@csgroup.eu>
Date: Mon, 2 Sep 2024 15:12:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC64
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
 <27de70dcc356e56754a03a2887a97597f5e840a4.1725278148.git.christophe.leroy@csgroup.eu>
 <ZtWyeuCfzZ66fVsg@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtWyeuCfzZ66fVsg@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/09/2024 à 14:41, Jason A. Donenfeld a écrit :
> On Mon, Sep 02, 2024 at 02:04:42PM +0200, Christophe Leroy wrote:
>>   SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>>   #ifdef __powerpc64__
>> -	blr
>> +	std	r5, -216(r1)
>> +
>> +	std	r14, -144(r1)
>> +	std	r15, -136(r1)
>> +	std	r16, -128(r1)
>> +	std	r17, -120(r1)
>> +	std	r18, -112(r1)
>> +	std	r19, -104(r1)
>> +	std	r20, -96(r1)
>> +	std	r21, -88(r1)
>> +	std	r22, -80(r1)
>> +	std	r23, -72(r1)
>> +	std	r24, -64(r1)
>> +	std	r25, -56(r1)
>> +	std	r26, -48(r1)
>> +	std	r27, -40(r1)
>> +	std	r28, -32(r1)
>> +	std	r29, -24(r1)
>> +	std	r30, -16(r1)
>> +	std	r31, -8(r1)
>>   #else
>>   	stwu	r1, -96(r1)
>>   	stw	r5, 20(r1)
>> +#ifdef __BIG_ENDIAN__
>>   	stmw	r14, 24(r1)
>> +#else
>> +	stw	r14, 24(r1)
>> +	stw	r15, 28(r1)
>> +	stw	r16, 32(r1)
>> +	stw	r17, 36(r1)
>> +	stw	r18, 40(r1)
>> +	stw	r19, 44(r1)
>> +	stw	r20, 48(r1)
>> +	stw	r21, 52(r1)
>> +	stw	r22, 56(r1)
>> +	stw	r23, 60(r1)
>> +	stw	r24, 64(r1)
>> +	stw	r25, 68(r1)
>> +	stw	r26, 72(r1)
>> +	stw	r27, 76(r1)
>> +	stw	r28, 80(r1)
>> +	stw	r29, 84(r1)
>> +	stw	r30, 88(r1)
>> +	stw	r31, 92(r1)
>> +#endif
>> +#endif
> 
> This confuses me. Why are you adding code to the !__powerpc64__ branch
> in this commit? (Also, why does stmw not work on LE?)

That's for the VDSO32 ie running 32 bits binaries on a 64 bits kernel.

"Programming Environments Manual for 32-Bit Implementations of the 
PowerPC™ Architecture" say: In some implementations operating with 
little-endian byte order, execution of an lmw or stmw instruction
causes the system alignment error handler to be invoked

And GCC doesn't like it either:

tools/arch/powerpc/vdso/vgetrandom-chacha.S:84: Error: `stmw' invalid 
when little-endian

