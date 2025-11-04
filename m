Return-Path: <linux-fsdevel+bounces-66886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65587C2F81A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33D934F238E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C382EE616;
	Tue,  4 Nov 2025 06:50:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03E2EBBB5;
	Tue,  4 Nov 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239032; cv=none; b=kX2qZVEqzx9V8x/sY3MihEiorzn4pmqUCWMysMaDuaVQnNHLRYaMayc+a5Q5JdbO4XfU+SR98yFcD60W2wR8/JShfiQc4P8gRfROEO5OWBIQelxx45b6kAHXPo1bJksXA4mWfk2skAfdweaX+dlAVztqdXvISu0s6CSULYMCCuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239032; c=relaxed/simple;
	bh=by2cO8Ki42/nHAReZn3vr372SHmYylTJ6gxOFBGWMf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGu+Yqu4FXR6RTKWrT+CvBtruJGa3uGrWP1JTXk1Q8mgYSPreIfIDesX8VCsc2KLIWcHOq6Psh1ECaY2eVjmZ2Y11FrzDyrS+66aZrWdMjbFP4uMPrfZC4PRLjfRdgy/KO9KM+zPmr9qbCXmoisZE67BAKYcHxBn6Q8UHAONFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d0z9m0gsPz9sSb;
	Tue,  4 Nov 2025 07:31:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzBUMEXuRcrz; Tue,  4 Nov 2025 07:31:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d0z9l6gDWz9sSZ;
	Tue,  4 Nov 2025 07:31:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CCC188B76C;
	Tue,  4 Nov 2025 07:31:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id GoDVNgciAAnR; Tue,  4 Nov 2025 07:31:07 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EA3368B763;
	Tue,  4 Nov 2025 07:31:05 +0100 (CET)
Message-ID: <942a27d9-135a-4e59-8eff-a44c46f8bb76@csgroup.eu>
Date: Tue, 4 Nov 2025 07:31:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 10/12] futex: Convert to get/put_user_inline()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.736737934@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251027083745.736737934@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/10/2025 à 09:44, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the open coded implementation with the new get/put_user_inline()
> helpers. This might be replaced by a regular get/put_user(), but that needs
> a proper performance evaluation.
> 
> No functional change intended
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "André Almeida" <andrealmeid@igalia.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> V5: Rename again and remove the helpers
> V4: Rename once moar
> V3: Adapt to scope changes
> V2: Convert to scoped variant
> ---
>   kernel/futex/core.c  |    4 +--
>   kernel/futex/futex.h |   58 ++-------------------------------------------------
>   2 files changed, 5 insertions(+), 57 deletions(-)
> ---
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -581,7 +581,7 @@ int get_futex_key(u32 __user *uaddr, uns
>   	if (flags & FLAGS_NUMA) {
>   		u32 __user *naddr = (void *)uaddr + size / 2;
>   
> -		if (futex_get_value(&node, naddr))
> +		if (get_user_inline(node, naddr))
>   			return -EFAULT;
>   
>   		if ((node != FUTEX_NO_NODE) &&
> @@ -601,7 +601,7 @@ int get_futex_key(u32 __user *uaddr, uns
>   			node = numa_node_id();
>   			node_updated = true;
>   		}
> -		if (node_updated && futex_put_value(node, naddr))
> +		if (node_updated && put_user_inline(node, naddr))
>   			return -EFAULT;
>   	}
>   
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -281,63 +281,11 @@ static inline int futex_cmpxchg_value_lo
>   	return ret;
>   }
>   
> -/*
> - * This does a plain atomic user space read, and the user pointer has
> - * already been verified earlier by get_futex_key() to be both aligned
> - * and actually in user space, just like futex_atomic_cmpxchg_inatomic().
> - *
> - * We still want to avoid any speculation, and while __get_user() is
> - * the traditional model for this, it's actually slower than doing
> - * this manually these days.
> - *
> - * We could just have a per-architecture special function for it,
> - * the same way we do futex_atomic_cmpxchg_inatomic(), but rather
> - * than force everybody to do that, write it out long-hand using
> - * the low-level user-access infrastructure.
> - *
> - * This looks a bit overkill, but generally just results in a couple
> - * of instructions.
> - */
> -static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
> -{
> -	u32 val;
> -
> -	if (can_do_masked_user_access())
> -		from = masked_user_access_begin(from);
> -	else if (!user_read_access_begin(from, sizeof(*from)))
> -		return -EFAULT;
> -	unsafe_get_user(val, from, Efault);
> -	user_read_access_end();
> -	*dest = val;
> -	return 0;
> -Efault:
> -	user_read_access_end();
> -	return -EFAULT;
> -}
> -
> -static __always_inline int futex_put_value(u32 val, u32 __user *to)
> -{
> -	if (can_do_masked_user_access())
> -		to = masked_user_access_begin(to);
> -	else if (!user_write_access_begin(to, sizeof(*to)))
> -		return -EFAULT;
> -	unsafe_put_user(val, to, Efault);
> -	user_write_access_end();
> -	return 0;
> -Efault:
> -	user_write_access_end();
> -	return -EFAULT;
> -}
> -
> +/* Read from user memory with pagefaults disabled */
>   static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
>   {
> -	int ret;
> -
> -	pagefault_disable();
> -	ret = futex_get_value(dest, from);
> -	pagefault_enable();
> -
> -	return ret;
> +	guard(pagefault)();
> +	return get_user_inline(*dest, from);
>   }
>   
>   extern void __futex_unqueue(struct futex_q *q);
> 


