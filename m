Return-Path: <linux-fsdevel+bounces-64935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75DFBF7144
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E07619C042A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103333B972;
	Tue, 21 Oct 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TDjSEslf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnEStIT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF89339700;
	Tue, 21 Oct 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057004; cv=none; b=g1PVII2RpPP4jhfuDSR3uY+kVdicDUp+zlcTTW9IRwmcSHjxemAg4taH84H9LRRHH83qwW6g57lTcZMl26/kVHwLvZRYpzsq/NGDYzJXuSpKnAEPugSfbd7lMPjGAyPMgC8/80aoe3VVqd/Y59iyrhyv2a69tqamymgC7VutuOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057004; c=relaxed/simple;
	bh=dJDOI3h7QDXQrVf2BiOHjAcyt2F4hukhucH/CTwTWTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u390tUnA/R9n3qnp8KZwisA0Xx0fVqZJ4BbaK3ChNvTiiVg9c4yr9BVcdMz3T1SgiCfCe6+xo6u9kXuxTEsHOzc8H4aj9hmSvabFAqWHyjWkT8bVFUqXk24j1/APsumdqB+vUAo9V0ZV1rQWBIm3pg/Ljv5JHl3I6ZfUxvXQNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TDjSEslf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnEStIT2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761057000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JS0LeUwhlIw7hjeLiFOMMF88gibn32hLzkAIdUzT3+E=;
	b=TDjSEslf+74J5IkqxbH7EKFCeOy9rDtwyTAG4CBl91QecO/LOfBJuamaRgki19wnXmzo3L
	SqhHxTI7uj395SMVGnS8mInc+ldJ+4y14A+Tcar1t1rjk1P3oeuzs3c10NKrLSlp7vvjg1
	VO1O+FpON2MdfZDx3F07Yrx1LWm3Y1tfPuAVvpcu5B5UAr7m32Qar3mTzXGVgZBL/qgxSl
	M9opFpJxcueJycQLaJQ3wdIRJ/cBq2l9fv20bUR/0U+lK5gVKnfZf6PfXeExQ9Wlmv8R1s
	ZuvqMMx5rUW/pmozC8w6KZbofI1CcE3oULCQg5X4tGxerhKckq68CFYL4PWaaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761057000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JS0LeUwhlIw7hjeLiFOMMF88gibn32hLzkAIdUzT3+E=;
	b=gnEStIT2+yktjKDz7BaF+L145njHkg3c1jlLnNHRsA0/k3jev0BD99TtrH6ssZALtH2/2H
	tt8KIreM40BQSKDA==
To: David Laight <david.laight.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>,
 Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
In-Reply-To: <20251020192859.640d7f0a@pumpkin>
References: <20251017085938.150569636@linutronix.de>
 <20251017093030.253004391@linutronix.de> <20251020192859.640d7f0a@pumpkin>
Date: Tue, 21 Oct 2025 16:29:58 +0200
Message-ID: <877bwoz5sp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025 at 19:28, David Laight wrote:
> On Fri, 17 Oct 2025 12:09:08 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> That definitely looks better than the earlier versions.
> Even if the implementation looks like an entry in the obfuscated C
> competition.

It has too many characters for that. The contest variant would be:

for(u8 s=0;!s;s=1)for(typeof(u) t= S(m,u,s,e);!s;s=1)for(C(u##m##a,c)(t);!s;s=1)for(const typeof(u) u=t;!s;s=1)

> I don't think you need the 'masked' in that name.
> Since it works in all cases.
>
> (I don't like the word 'masked' at all, not sure where it came from.

It's what Linus named it and I did not think about the name much so far.

> Probably because the first version used logical operators.
> 'Masking' a user address ought to be the operation of removing high-order
> address bits that the hardware is treating as 'don't care'.
> The canonical operation here is uaddr = min(uaddr, guard_page) - likely to be
> a conditional move.

That's how it's implemented for x86:

>>  b84:	48 b8 ef cd ab 89 67 45 23 01  movabs $0x123456789abcdef,%rax
>>  b8e:	48 39 c7    	               cmp    %rax,%rdi
>>  b91:	48 0f 47 f8          	       cmova  %rax,%rdi

0x123456789abcdef is a compile time placeholder for $USR_PTR_MAX which is
replaced during early boot by the real user space topmost address. See below.

> I think that s/masked/sanitised/ would make more sense (the patch to do
> that isn't very big at the moment). I might post it.)

The real point is that it is optimized. It does not have to use the
speculation fence if the architecture supports "masking" because the CPU
can't speculate on the input address as the actual read/write address
depends on the cmova. That's similar to the array_nospec() magic which
masks the input index unconditionally so it's in the valid range before
it can be used for speculatively accessing the array.

So yes, the naming is a bit awkward.

In principle most places which use user_$MODE_access_begin() could
benefit from that. Also under the hood the scope magic actually falls
back to that when the architecture does not support the "masked"
variant.

So simply naming it scoped_user_$MODE_access() is probably the least
confusing of all.

>> If masked user access is enabled on an architecture, then the pointer
>> handed in to scoped_masked_user_$MODE_access() can be modified to point to
>> a guaranteed faulting user address. This modification is only scope local
>> as the pointer is aliased inside the scope. When the scope is left the
>> alias is not longer in effect. IOW the original pointer value is preserved
>> so it can be used e.g. for fixup or diagnostic purposes in the fault path.
>
> I think you need to add (in the kerndoc somewhere):
>
> There is no requirement to do the accesses in strict memory order
> (or to access the lowest address first).
> The only constraint is that gaps must be significantly less than 4k.

The requirement is that the access is not spilling over into the kernel
address space, which means:

       USR_PTR_MAX <= address < (1U << 63)

USR_PTR_MAX on x86 is either
            (1U << 47) - PAGE_SIZE (4-level page tables)
         or (1U << 57) - PAGE_SIZE (5-level page tables)

Which means at least ~8 EiB of unmapped space in both cases.

The access order does not matter at all.

>> +#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\
>> +for (bool ____stop = false; !____stop; ____stop = true)						\
>> +	for (typeof((_uptr)) _tmpptr = __scoped_user_access_begin(_mode, _uptr, _size, _elbl);	\
>
> Can you use 'auto' instead of typeof() ?

Compilers are mightily unhappy about that unless I do typecasting on the
assignment, which is not really buying anything.

>> +	     !____stop; ____stop = true)							\
>> +		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;		\
>> +		     ____stop = true)					\
>> +			/* Force modified pointer usage within the scope */			\
>> +			for (const typeof((_uptr)) _uptr = _tmpptr; !____stop; ____stop = true)	\
>
> gcc 15.1 also seems to support 'const auto _uptr = _tmpptr;'

Older compilers not so much.

Thanks,

        tglx

