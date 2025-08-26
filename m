Return-Path: <linux-fsdevel+bounces-59165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDCB3556C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFD4171978
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4172FB63D;
	Tue, 26 Aug 2025 07:20:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43712F99BE;
	Tue, 26 Aug 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192840; cv=none; b=Ta4cQrzUAwAci9UOBGxW9tFrsokkAV/z+/h0gJO1iFQJuPOQoopF80lMUmgpHEHZmWarunAJ/G8HHlb34j3fo0p8h6ZCMlkH3Pcam2RWwNozD6Lgwz/0CY6CAO1bocc97sEVE75EHwb0CmYOuN0f3asgw5313DAuLwZurbEOvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192840; c=relaxed/simple;
	bh=HBOuPiCMgssaVDKhUcT22GsE8DqXSmsboQj/z407W5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dim8hxIvuxopyezWn4HEwX4wrKV6yTg2zqkNzoBUnPFYQOco4BVHzW6ULidCxT601//iw6qAJI8MDRRpODAYekNqnwIRC21bsd+RM4YjSCQa07XQ5B22DtscnPT//idzkzpN7AITCFPNkYerTrL5y2l8SNNJ8cbL7jz3yYoyeu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9zKx2Fdmz9sSr;
	Tue, 26 Aug 2025 09:09:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lx-7OYCz28iu; Tue, 26 Aug 2025 09:09:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9zKx1NyDz9sSq;
	Tue, 26 Aug 2025 09:09:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A1DC8B764;
	Tue, 26 Aug 2025 09:09:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0SKtV0v0anN4; Tue, 26 Aug 2025 09:09:09 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B03E8B763;
	Tue, 26 Aug 2025 09:09:08 +0200 (CEST)
Message-ID: <288844da-400f-46f8-aa12-e0309424fb14@csgroup.eu>
Date: Tue, 26 Aug 2025 09:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 3/4] x86/futex: Use user_*_masked_begin()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20250813150610.521355442@linutronix.de>
 <20250813151939.729465198@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250813151939.729465198@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/08/2025 à 17:57, Thomas Gleixner a écrit :
> Replace the can_do_masked_user_access() conditional with the generic macro.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: x86@kernel.org
> ---
>   arch/x86/include/asm/futex.h |   12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/include/asm/futex.h
> +++ b/arch/x86/include/asm/futex.h
> @@ -48,9 +48,7 @@ do {								\
>   static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
>   		u32 __user *uaddr)
>   {
> -	if (can_do_masked_user_access())
> -		uaddr = masked_user_access_begin(uaddr);
> -	else if (!user_access_begin(uaddr, sizeof(u32)))
> +	if (!user_write_masked_begin(uaddr))

You are replacing a user_access_begin() by a macro that calls 
user_write_access_begin(). I means that reads will not be allowed, 
allthough arch_futex_atomic_op_inuser() performs read-then-write, so it 
requires a full read-write user access.

>   		return -EFAULT;
>   
>   	switch (op) {
> @@ -74,7 +72,7 @@ static __always_inline int arch_futex_at
>   		user_access_end();
>   		return -ENOSYS;
>   	}
> -	user_access_end();
> +	user_write_access_end();

Same, can't be changed to write-only, read permission is required as well.

>   	return 0;
>   Efault:
>   	user_access_end();
> @@ -86,9 +84,7 @@ static inline int futex_atomic_cmpxchg_i
>   {
>   	int ret = 0;
>   
> -	if (can_do_masked_user_access())
> -		uaddr = masked_user_access_begin(uaddr);
> -	else if (!user_access_begin(uaddr, sizeof(u32)))
> +	if (!user_write_masked_begin(uaddr))

Same, read access is also needed.

>   		return -EFAULT;
>   	asm volatile("\n"
>   		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
> @@ -98,7 +94,7 @@ static inline int futex_atomic_cmpxchg_i
>   		: "r" (newval), "1" (oldval)
>   		: "memory"
>   	);
> -	user_access_end();
> +	user_write_access_end();

Same, read access is also needed.

>   	*uval = oldval;
>   	return ret;
>   }
> 
> 


