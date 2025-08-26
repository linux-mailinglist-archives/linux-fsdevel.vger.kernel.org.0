Return-Path: <linux-fsdevel+bounces-59166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E13B35590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E8387B7351
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACF2F8BE6;
	Tue, 26 Aug 2025 07:22:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC02F90CE;
	Tue, 26 Aug 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192959; cv=none; b=WUXQBAcC4I1bazWfmr0ZxZsLJBgbxz+ik7rhnciwurp3G+1n8hKkSxkp0J9SIoVoa3bd72KAcGeUdnUMP3pj6stXq5KqHJFrAswcD38KRY4RiqPFQFMLP4H2TqK+QuC+20IEAp4D2vq9y29GJDw0Yofw6AHncLXLYCoU+Z5Bjfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192959; c=relaxed/simple;
	bh=XcGvYcZMLnrHa09lad/o2eW6WhrYmFQp0SnHPnBbVO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UaX1ktGGz1NAB1o0DYx/PibCTChtUoOkJ09VDLcd6xw5gItNv9pWqdNB3LtQ8fsnRiV4vEfIh/yOv0dByzUhSloj6hcRe8o9w9dww+vvckeQtOJcARTp1qlAgFi4edJgPM8nVUcIzEIltylRzQoLIg1WF3Fya5orpeJ4z+7fszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9zDJ5h0cz9sSc;
	Tue, 26 Aug 2025 09:04:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iDf0OF6MIwyG; Tue, 26 Aug 2025 09:04:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9zDJ4VdZz9sSZ;
	Tue, 26 Aug 2025 09:04:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CDAB8B764;
	Tue, 26 Aug 2025 09:04:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4F8oWfZvrEGM; Tue, 26 Aug 2025 09:04:16 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C0D448B763;
	Tue, 26 Aug 2025 09:04:15 +0200 (CEST)
Message-ID: <0424c6bc-aa12-4ee2-a062-68ce16603c26@csgroup.eu>
Date: Tue, 26 Aug 2025 09:04:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 1/4] uaccess: Provide common helpers for masked user
 access
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
References: <20250813150610.521355442@linutronix.de>
 <20250813151939.601040635@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250813151939.601040635@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/08/2025 à 17:57, Thomas Gleixner a écrit :
> commit 2865baf54077 ("x86: support user address masking instead of
> non-speculative conditional") provided an optimization for
> unsafe_get/put_user(), which optimizes the Spectre-V1 mitigation in an
> architecture specific way. Currently only x86_64 supports that.
> 
> The required code pattern is:
> 
> 	if (can_do_masked_user_access())
> 		dst = masked_user_access_begin(dst);
> 	else if (!user_write_access_begin(dst, sizeof(*dst)))
> 		return -EFAULT;
> 	unsafe_put_user(val, dst, Efault);
> 	user_read_access_end();

You previously called user_write_access_begin(), so must be a 
user_write_access_end() here not a user_read_access_end().

> 	return 0;
> Efault:
> 	user_read_access_end();

Same.

> 	return -EFAULT;
> 
> The futex code already grew an instance of that and there are other areas,
> which can be optimized, when the calling code actually verified before,
> that the user pointer is both aligned and actually in user space.
> 
> Use the futex example and provide generic helper inlines for that to avoid
> having tons of copies all over the tree.
> 
> This provides get/put_user_masked_uNN() where $NN is the variable size in
> bits, i.e. 8, 16, 32, 64.

Couldn't the $NN be automatically determined through the type of the 
provided user pointer (i.e. the 'from' and 'to' in patch 2) ?

> 
> The second set of helpers is to encapsulate the prologue for larger access
> patterns, e.g. multiple consecutive unsafe_put/get_user() scenarioes:
> 
> 	if (can_do_masked_user_access())
> 		dst = masked_user_access_begin(dst);
> 	else if (!user_write_access_begin(dst, sizeof(*dst)))
> 		return -EFAULT;
> 	unsafe_put_user(a, &dst->a, Efault);
> 	unsafe_put_user(b, &dst->b, Efault);
> 	user_write_access_end();
> 	return 0;
> Efault:
> 	user_write_access_end();
> 	return -EFAULT;
> 
> which allows to shorten this to:
> 
> 	if (!user_write_masked_begin(dst))
> 		return -EFAULT;
> 	unsafe_put_user(a, &dst->a, Efault);
> 	...

That's nice but ... it hides even deeper the fact that 
masked_user_access_begin() opens a read/write access to userspace. On 
x86 it doesn't matter because all userspace accesses are read/write. But 
on architectures like powerpc it becomes a problem if you do a 
read/write open then only call user_read_access_end() as write access 
might remain open.

I have a patch (See [1]) that splits masked_user_access_begin() into 
three versions, one for read-only, one for write-only and one for 
read-write., so that they match user_read_access_end() 
user_write_access_end() and user_access_end() respectively.

[1] 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/7b570e237f7099d564d7b1a270169428ac1f3099.1755854833.git.christophe.leroy@csgroup.eu/


> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/uaccess.h |   78 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
> 
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -569,6 +569,84 @@ static inline void user_access_restore(u
>   #define user_read_access_end user_access_end
>   #endif
>   
> +/*
> + * Conveniance macros to avoid spreading this pattern all over the place
> + */
> +#define user_read_masked_begin(src) ({					\
> +	bool __ret = true;						\
> +									\
> +	if (can_do_masked_user_access())				\
> +		src = masked_user_access_begin(src);			\

Should call a masked_user_read_access_begin() to perform a read-only 
masked access begin, matching the read-only access begin below

> +	else if (!user_read_access_begin(src, sizeof(*src)))		\
> +		__ret = false;						\
> +	__ret;								\
> +})
> +
> +#define user_write_masked_begin(dst) ({					\
> +	bool __ret = true;						\
> +									\
> +	if (can_do_masked_user_access())				\
> +		dst = masked_user_access_begin(dst);			\

Should call masked_user_write_access_begin() to perform a write-only 
masked access begin, matching the write-only access begin below

> +	else if (!user_write_access_begin(dst, sizeof(*dst)))		\
> +		__ret = false;						\
> +	__ret;								\
> +})

You are missing a user_masked_begin() for read-write operations.

> +
> +/*
> + * get_user_masked_uNN() and put_user_masked_uNN() where NN is the size of
> + * the variable in bits. Supported values are 8, 16, 32 and 64.
> + *
> + * These functions can be used to optimize __get_user() and __put_user()
> + * scenarios, if the architecture supports masked user access. This avoids
> + * the more costly speculation barriers. If the architecture does not
> + * support it, it falls back to user_*_access_begin().
> + *
> + * As with __get/put_user() the user pointer has to be verified by the
> + * caller to be actually in user space.
> + */
> +#define GEN_GET_USER_MASKED(type)					\
> +	static __always_inline						\
> +	int get_user_masked_##type (type *dst, type __user *src)	\
> +	{								\
> +		type val;						\
> +									\
> +		if (!user_read_masked_begin(src))			\
> +			return -EFAULT;					\
> +		unsafe_get_user(val, src, Efault);			\
> +		user_read_access_end();					\
> +		*dst = val;						\
> +		return 0;						\
> +	Efault:								\
> +		user_read_access_end();					\
> +		return -EFAULT;						\
> +	}
> +
> +GEN_GET_USER_MASKED(u8)
> +GEN_GET_USER_MASKED(u16)
> +GEN_GET_USER_MASKED(u32)
> +GEN_GET_USER_MASKED(u64)
> +#undef GEN_GET_USER_MASKED

Do we need four functions ? Can't we just have a get_user_masked() macro 
that relies on the type of src , just like unsafe_get_user() ?

> +
> +#define GEN_PUT_USER_MASKED(type)					\
> +	static __always_inline						\
> +	int put_user_masked_##type (type val, type __user *dst)		\
> +	{								\
> +		if (!user_write_masked_begin(dst))			\
> +			return -EFAULT;					\
> +		unsafe_put_user(val, dst, Efault);			\
> +		user_write_access_end();				\
> +		return 0;						\
> +	Efault:								\
> +		user_write_access_end();				\
> +		return -EFAULT;						\
> +	}
> +
> +GEN_PUT_USER_MASKED(u8)
> +GEN_PUT_USER_MASKED(u16)
> +GEN_PUT_USER_MASKED(u32)
> +GEN_PUT_USER_MASKED(u64)

Same.

> +#undef GEN_PUT_USER_MASKED
> +
>   #ifdef CONFIG_HARDENED_USERCOPY
>   void __noreturn usercopy_abort(const char *name, const char *detail,
>   			       bool to_user, unsigned long offset,
> 
> 


