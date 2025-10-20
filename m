Return-Path: <linux-fsdevel+bounces-64730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A785BF2EFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A28E334E5FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5ED332ED0;
	Mon, 20 Oct 2025 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkD+Qk09"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C63176E7
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984947; cv=none; b=KZELGzYu2ri9JIH/nfkfcLoJ6Qcu3p6O37C5bQGZoAipRSBEEJk2KnlhtlXhCInxd09YjjW7QuLafScaplaJj4k9l8ozzLsf536Mr3USfUUyztMf3hQz9cUl4inEnFAflhpBZqEB71X+LTSJGIQI/oabB92msR7KIJ54aGy9RrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984947; c=relaxed/simple;
	bh=ZMV+mmzzpGd4DCD5WlKnTNAdsxGRE/UXzlqiriyVU3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcqXqzbYkMFlXI0gjdn72S2kCRMhuZtL5N/BGkoqgadlpdJnHm1p//16xgxzXX7lZyJ4IuC38C9CZ07PjWJf0dOZlX700XOph4+OJ5OOQ5HjFz7xSeQDVVsK3sHY0O4eM7bUtIUcCCJPRwyH1DtXxKc7iN0YpZi35nFMMJS7whY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkD+Qk09; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711f156326so34011245e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984942; x=1761589742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yxdyPTr8lflDTwtMVtJRlloOOyifPoptczhCt+xGBw=;
        b=lkD+Qk09Obz15FHz4uF/IpVuSVOnBy0/pr9cgTsKQJr2gJQJ2sUJ6rv9/viJxNaV+I
         vTJDwOFhmIXKsjVcRTtsWLvVG1b9PZMnvjuVGVIEBbI3PVBQRSqbYCJ4rhFVBm72z7Mt
         eRvfWIreeonGcUbdEUmIHkAob4MhKjvqQQedEfZdPOQZIIk72lPGzYUnsGmLz+mGeo8O
         aFa699/4d+UaUKDRFSgssmgczTjiWxbyI2vnap718M1mM7lljOb7HCTfDAqY9sYIbyDl
         zTHJxEiNPXQuUceym/5hhvNgPFs3Z5lia/ZM+vnpGCv9jpMFuhum2+ACLwk6hmKIirtD
         /f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984942; x=1761589742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yxdyPTr8lflDTwtMVtJRlloOOyifPoptczhCt+xGBw=;
        b=VymE+dogk1skdkX8pul4/xC5//6Pi0flqmDx9UQdxp0Xa6YcONFmPCZBY+ZK4h3MVO
         G0CMhXQszXEQpEHf8m2qJu7B0tN5p9pbreYqZ4qB5jlERUsBpu29NOfbrb+MnQxs0np5
         gmj58YuVJZm5Tj2cAUJ2wkG/d1gHbrVZ2A9J4Mdh6wbmGWJR/iSmZsbNbc2UVgcLIuHA
         LB2PbHqdy9qM8wQe9u+ljd5YZOMT28aJSE1wpRequ+S5vFCn76RzBqamioHqMLpXkV0a
         UV743K8punOTxuBmr8jUeyrKI2d2Pi4+CXbLTZiAQcM0iYSzLo++cL7b/CDPzr5x3RUz
         Tqlg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0vdcF5hLP1qPEjaVJEYNPmRpTzc2iSzaM76a0vsDx/0AC/ts8HwiVZFPfORc6NkW9TzJwxgaYGmjOxnk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ipdOr1y+XcUp4eSU2C7ChfPOmVLVm9Y1OCAF4yt0KNt8N0PF
	O7L5NVibFCCsZPBVyfjJroPtU9G1j9QDTjemWQkcPZ6qSM7i+yarQOdQ
X-Gm-Gg: ASbGncsZxAyaTOnRU9LS+DeBlm6BRuyKkt9cTX0ezP2s+HUyFipELEF8Ndp42X0BOjI
	DI86sMUxap2me3hjMEmvU/qyPiUxut1kJNbX050O7NR996UNMF8uUGoR7cxxt75XCwUpYWcogtD
	qYLFVMjLPesdySOaj18L+/8aB2TMcSuMlDZzGw6pzEHXuIJVJWxNY3JiAZEZt1q2P+vmkuyUSch
	D+YLAAcwCtC8u+OsPwvGA6S9Bb3CeD3CMCCQ1h1ywz132fCCz3//pI5YT5kIkiwu/tL79DNbcb9
	XCJf6dwdMz8wBgnjd5ASpvKETGjSVKDIdIeGu2u14vI7WFM/kVdl+bft9U49Io+OvJwDySiwB4a
	I8t3OVDz/LpZN+ux3Tq/NcQPPqwbwEvVdx6V6tsvpW0Ppgt40fsezd9H48uEBRX3k25lYoYwq6h
	EtWvg+yV36/qXaY7SkD+A206RFUAOnf4dh739tL++T0u5bp+SsdhIH
X-Google-Smtp-Source: AGHT+IEpzbsejOPW2DE1Xi2kfs5OCLo5cknKMYnsHf1ZhzSMoaTGb7o47ht4fDoeapYu+RtWSxVe8Q==
X-Received: by 2002:a05:600c:19d4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47117907234mr110583035e9.19.1760984941885;
        Mon, 20 Oct 2025 11:29:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm234365475e9.13.2025.10.20.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:29:01 -0700 (PDT)
Date: Mon, 20 Oct 2025 19:28:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, kernel test robot <lkp@intel.com>, Russell
 King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Heiko
 Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas
 Palix <nicolas.palix@imag.fr>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access
 regions
Message-ID: <20251020192859.640d7f0a@pumpkin>
In-Reply-To: <20251017093030.253004391@linutronix.de>
References: <20251017085938.150569636@linutronix.de>
	<20251017093030.253004391@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 12:09:08 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> User space access regions are tedious and require similar code patterns all
> over the place:
> 
>      	if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> This got worse with the recent addition of masked user access, which
> optimizes the speculation prevention:
> 
> 	if (can_do_masked_user_access())
> 		from = masked_user_read_access_begin((from));
> 	else if (!user_read_access_begin(from, sizeof(*from)))
> 		return -EFAULT;
> 	unsafe_get_user(val, from, Efault);
> 	user_read_access_end();
> 	return 0;
> Efault:
> 	user_read_access_end();
> 	return -EFAULT;
> 
> There have been issues with using the wrong user_*_access_end() variant in
> the error path and other typical Copy&Pasta problems, e.g. using the wrong
> fault label in the user accessor which ends up using the wrong accesss end
> variant. 
> 
> These patterns beg for scopes with automatic cleanup. The resulting outcome
> is:
>     	scoped_masked_user_read_access(from, Efault)
> 		unsafe_get_user(val, from, Efault);
> 	return 0;
>   Efault:
> 	return -EFAULT;

That definitely looks better than the earlier versions.
Even if the implementation looks like an entry in the obfuscated C competition.

I don't think you need the 'masked' in that name.
Since it works in all cases.

(I don't like the word 'masked' at all, not sure where it came from.
Probably because the first version used logical operators.
'Masking' a user address ought to be the operation of removing high-order
address bits that the hardware is treating as 'don't care'.
The canonical operation here is uaddr = min(uaddr, guard_page) - likely to be
a conditional move.
I think that s/masked/sanitised/ would make more sense (the patch to do
that isn't very big at the moment). I might post it.)

> 
> The scope guarantees the proper cleanup for the access mode is invoked both
> in the success and the failure (fault) path.
> 
> The scoped_masked_user_$MODE_access() macros are implemented as self
> terminating nested for() loops. Thanks to Andrew Cooper for pointing me at
> them. The scope can therefore be left with 'break', 'goto' and 'return'.
> Even 'continue' "works" due to the self termination mechanism. Both GCC and
> clang optimize all the convoluted macro maze out and the above results with
> clang in:
> 
>  b80:	f3 0f 1e fa          	       endbr64
>  b84:	48 b8 ef cd ab 89 67 45 23 01  movabs $0x123456789abcdef,%rax
>  b8e:	48 39 c7    	               cmp    %rax,%rdi
>  b91:	48 0f 47 f8          	       cmova  %rax,%rdi
>  b95:	90                   	       nop
>  b96:	90                   	       nop
>  b97:	90                   	       nop
>  b98:	31 c9                	       xor    %ecx,%ecx
>  b9a:	8b 07                	       mov    (%rdi),%eax
>  b9c:	89 06                	       mov    %eax,(%rsi)
>  b9e:	85 c9                	       test   %ecx,%ecx
>  ba0:	0f 94 c0             	       sete   %al
>  ba3:	90                   	       nop
>  ba4:	90                   	       nop
>  ba5:	90                   	       nop
>  ba6:	c3                   	       ret
> 
> Which looks as compact as it gets. The NOPs are placeholder for STAC/CLAC.
> GCC emits the fault path seperately:
> 
>  bf0:	f3 0f 1e fa          	       endbr64
>  bf4:	48 b8 ef cd ab 89 67 45 23 01  movabs $0x123456789abcdef,%rax
>  bfe:	48 39 c7             	       cmp    %rax,%rdi
>  c01:	48 0f 47 f8          	       cmova  %rax,%rdi
>  c05:	90                   	       nop
>  c06:	90                   	       nop
>  c07:	90                   	       nop
>  c08:	31 d2                	       xor    %edx,%edx
>  c0a:	8b 07                	       mov    (%rdi),%eax
>  c0c:	89 06                	       mov    %eax,(%rsi)
>  c0e:	85 d2                	       test   %edx,%edx
>  c10:	75 09                	       jne    c1b <afoo+0x2b>
>  c12:	90                   	       nop
>  c13:	90                   	       nop
>  c14:	90                   	       nop
>  c15:	b8 01 00 00 00       	       mov    $0x1,%eax
>  c1a:	c3                   	       ret
>  c1b:	90                   	       nop
>  c1c:	90                   	       nop
>  c1d:	90                   	       nop
>  c1e:	31 c0                	       xor    %eax,%eax
>  c20:	c3                   	       ret
> 
> 
> The fault labels for the scoped*() macros and the fault labels for the
> actual user space accessors can be shared and must be placed outside of the
> scope.
> 
> If masked user access is enabled on an architecture, then the pointer
> handed in to scoped_masked_user_$MODE_access() can be modified to point to
> a guaranteed faulting user address. This modification is only scope local
> as the pointer is aliased inside the scope. When the scope is left the
> alias is not longer in effect. IOW the original pointer value is preserved
> so it can be used e.g. for fixup or diagnostic purposes in the fault path.

I think you need to add (in the kerndoc somewhere):

There is no requirement to do the accesses in strict memory order
(or to access the lowest address first).
The only constraint is that gaps must be significantly less than 4k.

Basically the architectures have to support code accessing uptr[4]
before uptr[0] (so using ~0 as the 'bad address' isn't a good idea).
Otherwise you have to go through 'hoops' to double check that all code
accesses the first member of a structure before the second one.
(I've looked through likely users of this and something like poll
or epoll does the 2nd access first - and it isn't obvious.)

There always has to be a guard page at the top of valid user addresses.
Otherwise sequential accesses run into kernel space.
So the code just has to generate the base of the guard page for kernel
addresses (see the horrid ppc code for cpu that have broken conditional move).

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> V3: Make it a nested for() loop
>     Get rid of the code in macro parameters - Linus
>     Provide sized variants - Mathieu
> V2: Remove the shady wrappers around the opening and use scopes with automatic cleanup
> ---
>  include/linux/uaccess.h |  197 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
> 
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_UACCESS_H__
>  #define __LINUX_UACCESS_H__
>  
> +#include <linux/cleanup.h>
>  #include <linux/fault-inject-usercopy.h>
>  #include <linux/instrumented.h>
>  #include <linux/minmax.h>
> @@ -35,9 +36,17 @@
>  
>  #ifdef masked_user_access_begin
>   #define can_do_masked_user_access() 1
> +# ifndef masked_user_write_access_begin
> +#  define masked_user_write_access_begin masked_user_access_begin
> +# endif
> +# ifndef masked_user_read_access_begin
> +#  define masked_user_read_access_begin masked_user_access_begin
> +#endif
>  #else
>   #define can_do_masked_user_access() 0
>   #define masked_user_access_begin(src) NULL
> + #define masked_user_read_access_begin(src) NULL
> + #define masked_user_write_access_begin(src) NULL
>   #define mask_user_address(src) (src)
>  #endif
>  
> @@ -633,6 +642,194 @@ static inline void user_access_restore(u
>  #define user_read_access_end user_access_end
>  #endif
>  
> +/* Define RW variant so the below _mode macro expansion works */
> +#define masked_user_rw_access_begin(u)	masked_user_access_begin(u)
> +#define user_rw_access_begin(u, s)	user_access_begin(u, s)
> +#define user_rw_access_end()		user_access_end()
> +
> +/* Scoped user access */
> +#define USER_ACCESS_GUARD(_mode)					\
> +static __always_inline void __user *					\
> +class_masked_user_##_mode##_begin(void __user *ptr)			\
> +{									\
> +	return ptr;							\
> +}									\
> +									\
> +static __always_inline void						\
> +class_masked_user_##_mode##_end(void __user *ptr)			\
> +{									\
> +	user_##_mode##_access_end();					\
> +}									\
> +									\
> +DEFINE_CLASS(masked_user_ ##_mode## _access, void __user *,		\
> +	     class_masked_user_##_mode##_end(_T),			\
> +	     class_masked_user_##_mode##_begin(ptr), void __user *ptr)	\
> +									\
> +static __always_inline class_masked_user_##_mode##_access_t		\
> +class_masked_user_##_mode##_access_ptr(void __user *scope)		\
> +{									\
> +	return scope;							\
> +}
> +
> +USER_ACCESS_GUARD(read)
> +USER_ACCESS_GUARD(write)
> +USER_ACCESS_GUARD(rw)
> +#undef USER_ACCESS_GUARD
> +
> +/**
> + * __scoped_user_access_begin - Start the masked user access
> + * @_mode:	The mode of the access class (read, write, rw)
> + * @_uptr:	The pointer to access user space memory
> + * @_size:	Size of the access
> + * @_elbl:	Error label to goto when the access region is rejected.
> + *
> + * Internal helper for __scoped_masked_user_access(). Don't use directly
> + */
> +#define __scoped_user_access_begin(_mode, _uptr, _size, _elbl)		\
> +({									\
> +	typeof((_uptr)) ____ret;					\
> +									\
> +	if (can_do_masked_user_access()) {				\
> +		____ret = masked_user_##_mode##_access_begin((_uptr));	\
> +	} else {							\
> +		____ret = _uptr;					\
> +		if (!user_##_mode##_access_begin(_uptr, (_size)))	\
> +			goto _elbl;					\
> +	}								\
> +	____ret;							\
> +})
> +
> +/**
> + * __scoped_masked_user_access - Open a scope for masked user access
> + * @_mode:	The mode of the access class (read, write, rw)
> + * @_uptr:	The pointer to access user space memory
> + * @_size:	Size of the access
> + * @_elbl:	Error label to goto when the access region is rejected. It
> + *		must be placed outside the scope.
> + *
> + * If the user access function inside the scope requires a fault label, it
> + * can use @_elvl or a difference label outside the scope, which requires
> + * that user access which is implemented with ASM GOTO has been properly
> + * wrapped. See unsafe_get_user() for reference.
> + *
> + *	scoped_masked_user_rw_access(ptr, efault) {
> + *		unsafe_get_user(rval, &ptr->rval, efault);
> + *		unsafe_put_user(wval, &ptr->wval, efault);
> + *	}
> + *	return 0;
> + *  efault:
> + *	return -EFAULT;
> + *
> + * The scope is internally implemented as a autoterminating nested for()
> + * loop, which can be left with 'return', 'break' and 'goto' at any
> + * point.
> + *
> + * When the scope is left user_##@_mode##_access_end() is automatically
> + * invoked.
> + *
> + * When the architecture supports masked user access and the access region
> + * which is determined by @_uptr and @_size is not a valid user space
> + * address, i.e. < TASK_SIZE, the scope sets the pointer to a faulting user
> + * space address and does not terminate early. This optimizes for the good
> + * case and lets the performance uncritical bad case go through the fault.
> + *
> + * The eventual modification of the pointer is limited to the scope.
> + * Outside of the scope the original pointer value is unmodified, so that
> + * the original pointer value is available for diagnostic purposes in an
> + * out of scope fault path.
> + *
> + * Nesting scoped masked user access into a masked user access scope is
> + * invalid and fails the build. Nesting into other guards, e.g. pagefault
> + * is safe.
> + *
> + * Don't use directly. Use the scoped_masked_user_$MODE_access() instead.
> +*/
> +#define __scoped_masked_user_access(_mode, _uptr, _size, _elbl)					\
> +for (bool ____stop = false; !____stop; ____stop = true)						\
> +	for (typeof((_uptr)) _tmpptr = __scoped_user_access_begin(_mode, _uptr, _size, _elbl);	\

Can you use 'auto' instead of typeof() ?

> +	     !____stop; ____stop = true)							\
> +		for (CLASS(masked_user_##_mode##_access, scope) (_tmpptr); !____stop;		\
> +		     ____stop = true)					\
> +			/* Force modified pointer usage within the scope */			\
> +			for (const typeof((_uptr)) _uptr = _tmpptr; !____stop; ____stop = true)	\

gcc 15.1 also seems to support 'const auto _uptr = _tmpptr;'

	David

> +				if (1)
> +
> +/**
> + * scoped_masked_user_read_access_size - Start a scoped user read access with given size
> + * @_usrc:	Pointer to the user space address to read from
> + * @_size:	Size of the access starting from @_usrc
> + * @_elbl:	Error label to goto when the access region is rejected.
> + *
> + * For further information see __scoped_masked_user_access() above.
> + */
> +#define scoped_masked_user_read_access_size(_usrc, _size, _elbl)		\
> +	__scoped_masked_user_access(read, (_usrc), (_size), _elbl)
> +
> +/**
> + * scoped_masked_user_read_access - Start a scoped user read access
> + * @_usrc:	Pointer to the user space address to read from
> + * @_elbl:	Error label to goto when the access region is rejected.
> + *
> + * The size of the access starting from @_usrc is determined via sizeof(*@_usrc)).
> + *
> + * For further information see __scoped_masked_user_access() above.
> + */
> +#define scoped_masked_user_read_access(_usrc, _elbl)				\
> +	scoped_masked_user_read_access_size((_usrc), sizeof(*(_usrc)), _elbl)
> +
> +/**
> + * scoped_masked_user_read_end - End a scoped user read access
> + *
> + * Ends the scope opened with scoped_masked_user_read_access[_size]()
> + */
> +#define scoped_masked_user_read_end()	__scoped_masked_user_end()
> +
> +/**
> + * scoped_masked_user_write_access_size - Start a scoped user write access with given size
> + * @_udst:	Pointer to the user space address to write to
> + * @_size:	Size of the access starting from @_udst
> + * @_elbl:	Error label to goto when the access region is rejected.
> + *
> + * For further information see __scoped_masked_user_access() above.
> + */
> +#define scoped_masked_user_write_access_size(_udst, _size, _elbl)		\
> +	__scoped_masked_user_access(write, (_udst),  (_size), _elbl)
> +
> +/**
> + * scoped_masked_user_write_access - Start a scoped user write access
> + * @_udst:	Pointer to the user space address to write to
> + * @_elbl:	Error label to goto when the access region is rejected.
> + *
> + * The size of the access starting from @_udst is determined via sizeof(*@_udst)).
> + *
> + * For further information see __scoped_masked_user_access() above.
> + */
> +#define scoped_masked_user_write_access(_udst, _elbl)				\
> +	scoped_masked_user_write_access_size((_udst), sizeof(*(_udst)), _elbl)
> +
> +/**
> + * scoped_masked_user_rw_access_size - Start a scoped user read/write access with given size
> + * @_uptr	Pointer to the user space address to read from and write to
> + * @_size:	Size of the access starting from @_uptr
> + * @_elbl:	Error label to goto when the access region is rejected.
> + *
> + * For further information see __scoped_masked_user_access() above.
> + */
> +#define scoped_masked_user_rw_access_size(_uptr, _size, _elbl)			\
> +	__scoped_masked_user_access(rw, (_uptr), (_size), _elbl)
> +
> +/**
> + * scoped_masked_user_rw_access - Start a scoped user read/write access
> + * @_uptr	Pointer to the user space address to read from and write to
> + * @_elbl:	Error label to goto when the access region is rejected.
> + *
> + * The size of the access starting from @_uptr is determined via sizeof(*@_uptr)).
> + *
> + * For further information see __scoped_masked_user_access() above.
> + */
> +#define scoped_masked_user_rw_access(_uptr, _elbl)				\
> +	scoped_masked_user_rw_access_size((_uptr), sizeof(*(_uptr)), _elbl)
> +
>  #ifdef CONFIG_HARDENED_USERCOPY
>  void __noreturn usercopy_abort(const char *name, const char *detail,
>  			       bool to_user, unsigned long offset,
> 
> 


