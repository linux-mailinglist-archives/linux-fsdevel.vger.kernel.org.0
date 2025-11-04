Return-Path: <linux-fsdevel+bounces-66878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ECCC2F6F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 07:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4929834CEF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 06:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4542D060E;
	Tue,  4 Nov 2025 06:20:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC10018C933;
	Tue,  4 Nov 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237208; cv=none; b=HlZpCzbS6c4nRbV+biu9bSsxIoeHT2FDff5QSQSTlOzBFR577vXpvP/0kt54yQegHeVVJhluk97y33prWw7gRSTUoRFw9REzPYE884OMwiha72uhTMlq9uKEdM6uCBLPV0E65rzeBw9nxHB+GqQLJ+UVUhdycE9+U6izkuU6Bwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237208; c=relaxed/simple;
	bh=rsWZ7bGZkQRSetQScgdnaT6tPj5+LnD8mQTU/aZN1EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAEr0IlEAYwbp8hvNH8DvuTuwHK18WMFqgUBUexef2t/aKNfGFJ4MkbQBY+c8P/4YO7ocvV4AkQTk56djvxedqhjKy3PipbKjyxJ+b8cD1tLxeWlLSXrl0fFTdS7oUekZdYF2nSE517fSSlY2ED43sRnELnBXChupDoXGxtU9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d0ylC5twsz9sS7;
	Tue,  4 Nov 2025 07:11:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1V_DzEabRqdH; Tue,  4 Nov 2025 07:11:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d0ylC4fs9z9sRy;
	Tue,  4 Nov 2025 07:11:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EE558B76C;
	Tue,  4 Nov 2025 07:11:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id bDAKbX6wpuSV; Tue,  4 Nov 2025 07:11:35 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D0C78B763;
	Tue,  4 Nov 2025 07:11:33 +0100 (CET)
Message-ID: <14010da0-9fba-4627-a499-e71034cd9bac@csgroup.eu>
Date: Tue, 4 Nov 2025 07:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V5 02/12] uaccess: Provide ASM GOTO safe wrappers for
 unsafe_*_user()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
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
 <20251027083745.231716098@linutronix.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20251027083745.231716098@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/10/2025 à 09:43, Thomas Gleixner a écrit :
> ASM GOTO is miscompiled by GCC when it is used inside a auto cleanup scope:
> 
> bool foo(u32 __user *p, u32 val)
> {
> 	scoped_guard(pagefault)
> 		unsafe_put_user(val, p, efault);
> 	return true;
> efault:
> 	return false;
> }
> 
>   e80:	e8 00 00 00 00       	call   e85 <foo+0x5>
>   e85:	65 48 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%rax
>   e8d:	83 80 04 14 00 00 01 	addl   $0x1,0x1404(%rax)   // pf_disable++
>   e94:	89 37                	mov    %esi,(%rdi)
>   e96:	83 a8 04 14 00 00 01 	subl   $0x1,0x1404(%rax)   // pf_disable--
>   e9d:	b8 01 00 00 00       	mov    $0x1,%eax           // success
>   ea2:	e9 00 00 00 00       	jmp    ea7 <foo+0x27>      // ret
>   ea7:	31 c0                	xor    %eax,%eax           // fail
>   ea9:	e9 00 00 00 00       	jmp    eae <foo+0x2e>      // ret
> 
> which is broken as it leaks the pagefault disable counter on failure.

Is there a GCC bug report for it ?

> 
> Clang at least fails the build.

Is it expected ? Is the error message meaningfull ?

> 
> Linus suggested to add a local label into the macro scope and let that
> jump to the actual caller supplied error label.
> 
>         	__label__ local_label;                                  \
>          arch_unsafe_get_user(x, ptr, local_label);              \
> 	if (0) {                                                \
> 	local_label:                                            \
> 		goto label;                                     \

That's in a while loop so it would have been cleaner (more readable) to 
break instead of that ugly if(0), see __get_user_size_allowed() in 
powerpc uaccess.h

> 
> That works for both GCC and clang.
> 
> clang:
> 
>   c80:	0f 1f 44 00 00       	   nopl   0x0(%rax,%rax,1)	
>   c85:	65 48 8b 0c 25 00 00 00 00 mov    %gs:0x0,%rcx
>   c8e:	ff 81 04 14 00 00    	   incl   0x1404(%rcx)	   // pf_disable++
>   c94:	31 c0                	   xor    %eax,%eax        // set retval to false
>   c96:	89 37                      mov    %esi,(%rdi)      // write
>   c98:	b0 01                	   mov    $0x1,%al         // set retval to true
>   c9a:	ff 89 04 14 00 00    	   decl   0x1404(%rcx)     // pf_disable--
>   ca0:	2e e9 00 00 00 00    	   cs jmp ca6 <foo+0x26>   // ret
> 
> The exception table entry points correctly to c9a
> 
> GCC:
> 
>   f70:   e8 00 00 00 00          call   f75 <baz+0x5>
>   f75:   65 48 8b 05 00 00 00 00 mov    %gs:0x0(%rip),%rax
>   f7d:   83 80 04 14 00 00 01    addl   $0x1,0x1404(%rax)  // pf_disable++
>   f84:   8b 17                   mov    (%rdi),%edx
>   f86:   89 16                   mov    %edx,(%rsi)
>   f88:   83 a8 04 14 00 00 01    subl   $0x1,0x1404(%rax) // pf_disable--
>   f8f:   b8 01 00 00 00          mov    $0x1,%eax         // success
>   f94:   e9 00 00 00 00          jmp    f99 <baz+0x29>    // ret
>   f99:   83 a8 04 14 00 00 01    subl   $0x1,0x1404(%rax) // pf_disable--
>   fa0:   31 c0                   xor    %eax,%eax         // fail
>   fa2:   e9 00 00 00 00          jmp    fa7 <baz+0x37>    // ret
> 
> The exception table entry points correctly to f99
> 
> So both compilers optimize out the extra goto and emit correct and
> efficient code.
 > > Provide a generic wrapper to do that to avoid modifying all the 
affected
> architecture specific implementation with that workaround.
> 
> The only change required for architectures is to rename unsafe_*_user() to
> arch_unsafe_*_user(). That's done in subsequent changes.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   include/linux/uaccess.h |   72 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 68 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -518,7 +518,34 @@ long strncpy_from_user_nofault(char *dst
>   		long count);
>   long strnlen_user_nofault(const void __user *unsafe_addr, long count);
>   
> -#ifndef __get_kernel_nofault
> +#ifdef arch_get_kernel_nofault
> +/*
> + * Wrap the architecture implementation so that @label can be outside of a
> + * cleanup() scope. A regular C goto works correctly, but ASM goto does
> + * not. Clang rejects such an attempt, but GCC silently emits buggy code.
> + */
> +#define __get_kernel_nofault(dst, src, type, label)		\
> +do {								\
> +	__label__ local_label;					\
> +	arch_get_kernel_nofault(dst, src, type, local_label);	\
> +	if (0) {						\
> +	local_label:						\
> +		goto label;					\
> +	}							\
> +} while (0)
> +
> +#define __put_kernel_nofault(dst, src, type, label)		\
> +do {								\
> +	__label__ local_label;					\
> +	arch_get_kernel_nofault(dst, src, type, local_label);	\
> +	if (0) {						\
> +	local_label:						\
> +		goto label;					\
> +	}							\
> +} while (0)
> +
> +#elif !defined(__get_kernel_nofault) /* arch_get_kernel_nofault */
> +
>   #define __get_kernel_nofault(dst, src, type, label)	\
>   do {							\
>   	type __user *p = (type __force __user *)(src);	\
> @@ -535,7 +562,8 @@ do {							\
>   	if (__put_user(data, p))			\
>   		goto label;				\
>   } while (0)
> -#endif
> +
> +#endif  /* !__get_kernel_nofault */
>   
>   /**
>    * get_kernel_nofault(): safely attempt to read from a location
> @@ -549,7 +577,42 @@ do {							\
>   	copy_from_kernel_nofault(&(val), __gk_ptr, sizeof(val));\
>   })
>   
> -#ifndef user_access_begin
> +#ifdef user_access_begin
> +
> +#ifdef arch_unsafe_get_user
> +/*
> + * Wrap the architecture implementation so that @label can be outside of a
> + * cleanup() scope. A regular C goto works correctly, but ASM goto does
> + * not. Clang rejects such an attempt, but GCC silently emits buggy code.
> + *
> + * Some architectures use internal local labels already, but this extra
> + * indirection here is harmless because the compiler optimizes it out
> + * completely in any case. This construct just ensures that the ASM GOTO
> + * target is always in the local scope. The C goto 'label' works correct
> + * when leaving a cleanup() scope.
> + */
> +#define unsafe_get_user(x, ptr, label)			\
> +do {							\
> +	__label__ local_label;				\
> +	arch_unsafe_get_user(x, ptr, local_label);	\
> +	if (0) {					\
> +	local_label:					\
> +		goto label;				\
> +	}						\
> +} while (0)
> +
> +#define unsafe_put_user(x, ptr, label)			\
> +do {							\
> +	__label__ local_label;				\
> +	arch_unsafe_put_user(x, ptr, local_label);	\
> +	if (0) {					\
> +	local_label:					\
> +		goto label;				\
> +	}						\
> +} while (0)
> +#endif /* arch_unsafe_get_user */
> +
> +#else /* user_access_begin */
>   #define user_access_begin(ptr,len) access_ok(ptr, len)
>   #define user_access_end() do { } while (0)
>   #define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
> @@ -559,7 +622,8 @@ do {							\
>   #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
>   static inline unsigned long user_access_save(void) { return 0UL; }
>   static inline void user_access_restore(unsigned long flags) { }
> -#endif
> +#endif /* !user_access_begin */
> +
>   #ifndef user_write_access_begin
>   #define user_write_access_begin user_access_begin
>   #define user_write_access_end user_access_end
> 


