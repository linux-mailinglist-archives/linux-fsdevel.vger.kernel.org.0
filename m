Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46CCD146786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 13:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAWMFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 07:05:54 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWMFx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:05:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 483LZl4c7hz9sQp;
        Thu, 23 Jan 2020 23:05:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1579781151;
        bh=ZQ/DobkV1Dl4jXiUQ8eTuwbaOJ9Q+q9Cve8ywXkWLMs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZIRH0c97Xbsudpt8o2hZXHdZ1NqigRM9kAf4c/XGanyKn4DHkPON42Bqf00XpDgck
         mbTR7REalarbOowPx2aRCWgEs6YbyoPIRapPhLm2AOOQ+KtGPu3y/DXPuuSgLkQ9rK
         wOvJDKB/gTpZ9Qb5hd+EVkf8Nxg0/0C2bXOgoso/FCShQLDFvvugKJ3HMhXzmeI1cu
         0H9jqB1QJLMIbD+JAIe/uIYuAv/AkPA0tbuKND1duI5ayJRbvzooEGjci8eHSqxRsT
         H29RNg3tHCs3o1gcYa6oR2OtyHZx4t9p2YDLgw/GmbmDR8b1h5yUgHnRAi8n2YPIK1
         0SYsAYiAT8Z4A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 6/6] powerpc: Implement user_access_begin and friends
In-Reply-To: <2a20d19776faba4d85dbe51ae00a5f6ac5ac0969.1579715466.git.christophe.leroy@c-s.fr>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr> <2a20d19776faba4d85dbe51ae00a5f6ac5ac0969.1579715466.git.christophe.leroy@c-s.fr>
Date:   Thu, 23 Jan 2020 23:05:50 +1100
Message-ID: <87iml2idi9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Today, when a function like strncpy_from_user() is called,
> the userspace access protection is de-activated and re-activated
> for every word read.
>
> By implementing user_access_begin and friends, the protection
> is de-activated at the beginning of the copy and re-activated at the
> end.
>
> Implement user_access_begin(), user_access_end() and
> unsafe_get_user(), unsafe_put_user() and unsafe_copy_to_user()
>
> For the time being, we keep user_access_save() and
> user_access_restore() as nops.

That means we will run with user access enabled in a few more places, but
it's only used sparingly AFAICS:

  kernel/trace/trace_branch.c:    unsigned long flags = user_access_save();
  lib/ubsan.c:    unsigned long flags = user_access_save();
  lib/ubsan.c:    unsigned long ua_flags = user_access_save();
  mm/kasan/common.c:      unsigned long flags = user_access_save();

And we don't have objtool checking that user access enablement isn't
leaking in the first place, so I guess it's OK for us not to implement
these to begin with?

cheers


> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index cafad1960e76..ea67bbd56bd4 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -91,9 +91,14 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
>  	__put_user_check((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
>  
>  #define __get_user(x, ptr) \
> -	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
> +	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), true)
>  #define __put_user(x, ptr) \
> -	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
> +	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), true)
> +
> +#define __get_user_allowed(x, ptr) \
> +	__get_user_nocheck((x), (ptr), sizeof(*(ptr)), false)
> +#define __put_user_allowed(x, ptr) \
> +	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), false)
>  
>  #define __get_user_inatomic(x, ptr) \
>  	__get_user_nosleep((x), (ptr), sizeof(*(ptr)))
> @@ -138,10 +143,9 @@ extern long __put_user_bad(void);
>  		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
>  #endif /* __powerpc64__ */
>  
> -#define __put_user_size(x, ptr, size, retval)			\
> +#define __put_user_size_allowed(x, ptr, size, retval)		\
>  do {								\
>  	retval = 0;						\
> -	allow_write_to_user(ptr, size);				\
>  	switch (size) {						\
>  	  case 1: __put_user_asm(x, ptr, retval, "stb"); break;	\
>  	  case 2: __put_user_asm(x, ptr, retval, "sth"); break;	\
> @@ -149,17 +153,26 @@ do {								\
>  	  case 8: __put_user_asm2(x, ptr, retval); break;	\
>  	  default: __put_user_bad();				\
>  	}							\
> +} while (0)
> +
> +#define __put_user_size(x, ptr, size, retval)			\
> +do {								\
> +	allow_write_to_user(ptr, size);				\
> +	__put_user_size_allowed(x, ptr, size, retval);		\
>  	prevent_write_to_user(ptr, size);			\
>  } while (0)
>  
> -#define __put_user_nocheck(x, ptr, size)			\
> +#define __put_user_nocheck(x, ptr, size, allow)			\
>  ({								\
>  	long __pu_err;						\
>  	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
>  	if (!is_kernel_addr((unsigned long)__pu_addr))		\
>  		might_fault();					\
>  	__chk_user_ptr(ptr);					\
> -	__put_user_size((x), __pu_addr, (size), __pu_err);	\
> +	if (allow)								\
> +		__put_user_size((x), __pu_addr, (size), __pu_err);		\
> +	else									\
> +		__put_user_size_allowed((x), __pu_addr, (size), __pu_err);	\
>  	__pu_err;						\
>  })
>  
> @@ -236,13 +249,12 @@ extern long __get_user_bad(void);
>  		: "b" (addr), "i" (-EFAULT), "0" (err))
>  #endif /* __powerpc64__ */
>  
> -#define __get_user_size(x, ptr, size, retval)			\
> +#define __get_user_size_allowed(x, ptr, size, retval)		\
>  do {								\
>  	retval = 0;						\
>  	__chk_user_ptr(ptr);					\
>  	if (size > sizeof(x))					\
>  		(x) = __get_user_bad();				\
> -	allow_read_from_user(ptr, size);			\
>  	switch (size) {						\
>  	case 1: __get_user_asm(x, ptr, retval, "lbz"); break;	\
>  	case 2: __get_user_asm(x, ptr, retval, "lhz"); break;	\
> @@ -250,6 +262,12 @@ do {								\
>  	case 8: __get_user_asm2(x, ptr, retval);  break;	\
>  	default: (x) = __get_user_bad();			\
>  	}							\
> +} while (0)
> +
> +#define __get_user_size(x, ptr, size, retval)			\
> +do {								\
> +	allow_read_from_user(ptr, size);			\
> +	__get_user_size_allowed(x, ptr, size, retval);		\
>  	prevent_read_from_user(ptr, size);			\
>  } while (0)
>  
> @@ -260,7 +278,7 @@ do {								\
>  #define __long_type(x) \
>  	__typeof__(__builtin_choose_expr(sizeof(x) > sizeof(0UL), 0ULL, 0UL))
>  
> -#define __get_user_nocheck(x, ptr, size)			\
> +#define __get_user_nocheck(x, ptr, size, allow)			\
>  ({								\
>  	long __gu_err;						\
>  	__long_type(*(ptr)) __gu_val;				\
> @@ -269,7 +287,10 @@ do {								\
>  	if (!is_kernel_addr((unsigned long)__gu_addr))		\
>  		might_fault();					\
>  	barrier_nospec();					\
> -	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
> +	if (allow)								\
> +		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);		\
> +	else									\
> +		__get_user_size_allowed(__gu_val, __gu_addr, (size), __gu_err);	\
>  	(x) = (__typeof__(*(ptr)))__gu_val;			\
>  	__gu_err;						\
>  })
> @@ -387,6 +408,34 @@ static inline unsigned long raw_copy_to_user(void __user *to,
>  	return ret;
>  }
>  
> +static inline unsigned long
> +raw_copy_to_user_allowed(void __user *to, const void *from, unsigned long n)
> +{
> +	unsigned long ret;
> +	if (__builtin_constant_p(n) && (n) <= 8) {
> +		ret = 1;
> +
> +		switch (n) {
> +		case 1:
> +			__put_user_size_allowed(*(u8 *)from, (u8 __user *)to, 1, ret);
> +			break;
> +		case 2:
> +			__put_user_size_allowed(*(u16 *)from, (u16 __user *)to, 2, ret);
> +			break;
> +		case 4:
> +			__put_user_size_allowed(*(u32 *)from, (u32 __user *)to, 4, ret);
> +			break;
> +		case 8:
> +			__put_user_size_allowed(*(u64 *)from, (u64 __user *)to, 8, ret);
> +			break;
> +		}
> +		if (ret == 0)
> +			return 0;
> +	}
> +
> +	return __copy_tofrom_user(to, (__force const void __user *)from, n);
> +}
> +
>  static __always_inline unsigned long __must_check
>  copy_to_user_mcsafe(void __user *to, const void *from, unsigned long n)
>  {
> @@ -428,4 +477,27 @@ extern long __copy_from_user_flushcache(void *dst, const void __user *src,
>  extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
>  			   size_t len);
>  
> +static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
> +{
> +	if (unlikely(!access_ok(ptr, len)))
> +		return false;
> +	allow_read_write_user((void __user *)ptr, ptr, len);
> +	return true;
> +}
> +#define user_access_begin	user_access_begin
> +
> +static inline void user_access_end(void)
> +{
> +	prevent_user_access(NULL, NULL, ~0UL, KUAP_SELF);
> +}
> +#define user_access_end		user_access_end
> +
> +static inline unsigned long user_access_save(void) { return 0UL; }
> +static inline void user_access_restore(unsigned long flags) { }
> +
> +#define unsafe_op_wrap(op, err) do { if (unlikely(op)) goto err; } while (0)
> +#define unsafe_get_user(x,p,e) unsafe_op_wrap(__get_user_allowed(x,p),e)
> +#define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user_allowed(x,p),e)
> +#define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(raw_copy_to_user_allowed(d,s,l),e)
> +
>  #endif	/* _ARCH_POWERPC_UACCESS_H */
> -- 
> 2.25.0
