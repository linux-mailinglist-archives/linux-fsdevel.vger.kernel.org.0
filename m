Return-Path: <linux-fsdevel+bounces-66881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 354CEC2F7F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5A9834D1A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2142D978C;
	Tue,  4 Nov 2025 06:50:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503742D0C7A;
	Tue,  4 Nov 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239009; cv=none; b=q4vF5jPdPFbhnGKPwtchTtPLmcmIuu2v9exl0y4Q0s+NHt82KPuy8Jk3K4evh67ew3dYsW5zBxINejVMHUlGnKTnWyOywXxBy6UV6+d51JBXbQsmd6AtcGUlHh4kSlc5dB1JMtsKQy7wEmKXr5qZdItICfuKR/AwhLLzAFZBSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239009; c=relaxed/simple;
	bh=6peD8WY0N5KSWRJShXt5lyUU/uFqTtooZSIdteyLidU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9ITbHJB+RvWR2HPz9ScxljR99EBII45BC3/0sdDhBMHZKDuNcz5pkR7K2/A2Ou/IyQIaAmA5ah4eM2m2z6mhZ7EBBEmLp4cX7Uz3aLKClo31CSG/cYvoqTche0YWdp45olJ5RkJ/jAmnojheUEOI9zYPjnamAGE68XBI7+TUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d0z970xwrz9sSY;
	Tue,  4 Nov 2025 07:30:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8o3eFqSyCr4H; Tue,  4 Nov 2025 07:30:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d0z966mmTz9sSV;
	Tue,  4 Nov 2025 07:30:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CA6B28B76C;
	Tue,  4 Nov 2025 07:30:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id GLvucgCkTsyh; Tue,  4 Nov 2025 07:30:34 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C05318B763;
	Tue,  4 Nov 2025 07:30:32 +0100 (CET)
Message-ID: <fc087f38-2e14-41d1-8044-c054eb41ad19@csgroup.eu>
Date: Tue, 4 Nov 2025 07:30:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 08/12] uaccess: Provide put/get_user_inline()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
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
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20251027083700.573016505@linutronix.de>
 <20251027083745.609031602@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251027083745.609031602@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/10/2025 à 09:43, Thomas Gleixner a écrit :
> Provide conveniance wrappers around scoped user access similiar to
> put/get_user(), which reduce the usage sites to:
> 
>         if (!get_user_inline(val, ptr))
>         		return -EFAULT;
> 
> Should only be used if there is a demonstrable performance benefit.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> V5: Rename to inline
> V4: Rename to scoped
> ---
>   include/linux/uaccess.h |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -825,6 +825,56 @@ for (bool done = false; !done; done = tr
>   #define scoped_user_rw_access(uptr, elbl)				\
>   	scoped_user_rw_access_size(uptr, sizeof(*(uptr)), elbl)
>   
> +/**
> + * get_user_inline - Read user data inlined
> + * @val:	The variable to store the value read from user memory
> + * @usrc:	Pointer to the user space memory to read from
> + *
> + * Return: 0 if successful, -EFAULT when faulted
> + *
> + * Inlined variant of get_user(). Only use when there is a demonstrable
> + * performance reason.
> + */
> +#define get_user_inline(val, usrc)				\
> +({								\
> +	__label__ efault;					\
> +	typeof(usrc) _tmpsrc = usrc;				\
> +	int _ret = 0;						\
> +								\
> +	scoped_user_read_access(_tmpsrc, efault)		\
> +		unsafe_get_user(val, _tmpsrc, efault);		\
> +	if (0) {						\
> +	efault:							\
> +		_ret = -EFAULT;					\
> +	}							\
> +	_ret;							\
> +})
> +
> +/**
> + * put_user_inline - Write to user memory inlined
> + * @val:	The value to write
> + * @udst:	Pointer to the user space memory to write to
> + *
> + * Return: 0 if successful, -EFAULT when faulted
> + *
> + * Inlined variant of put_user(). Only use when there is a demonstrable
> + * performance reason.
> + */
> +#define put_user_inline(val, udst)				\
> +({								\
> +	__label__ efault;					\
> +	typeof(udst) _tmpdst = udst;				\
> +	int _ret = 0;						\
> +								\
> +	scoped_user_write_access(_tmpdst, efault)		\
> +		unsafe_put_user(val, _tmpdst, efault);		\
> +	if (0) {						\
> +	efault:							\
> +		_ret = -EFAULT;					\
> +	}							\
> +	_ret;							\
> +})
> +
>   #ifdef CONFIG_HARDENED_USERCOPY
>   void __noreturn usercopy_abort(const char *name, const char *detail,
>   			       bool to_user, unsigned long offset,
> 


