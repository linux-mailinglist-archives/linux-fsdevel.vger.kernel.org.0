Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D325A56F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 08:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBGPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 02:15:25 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50693 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBGPY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:15:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BhDFM1jjKz9tyTH;
        Wed,  2 Sep 2020 08:15:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3We4wFWomQ2D; Wed,  2 Sep 2020 08:15:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BhDFM0fQQz9tyTG;
        Wed,  2 Sep 2020 08:15:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 111128B788;
        Wed,  2 Sep 2020 08:15:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bC4OSETSJupy; Wed,  2 Sep 2020 08:15:19 +0200 (CEST)
Received: from [10.25.210.31] (unknown [10.25.210.31])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C01518B784;
        Wed,  2 Sep 2020 08:15:19 +0200 (CEST)
Subject: Re: [PATCH 10/10] powerpc: remove address space overrides using
 set_fs()
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-11-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8974838a-a0b1-1806-4a3a-e983deda67ca@csgroup.eu>
Date:   Wed, 2 Sep 2020 08:15:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200827150030.282762-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 27/08/2020 à 17:00, Christoph Hellwig a écrit :
> Stop providing the possibility to override the address space using
> set_fs() now that there is no need for that any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/Kconfig                   |  1 -
>   arch/powerpc/include/asm/processor.h   |  7 ---
>   arch/powerpc/include/asm/thread_info.h |  5 +--
>   arch/powerpc/include/asm/uaccess.h     | 62 ++++++++------------------
>   arch/powerpc/kernel/signal.c           |  3 --
>   arch/powerpc/lib/sstep.c               |  6 +--
>   6 files changed, 22 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 7fe3531ad36a77..39727537d39701 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -8,62 +8,36 @@
>   #include <asm/extable.h>
>   #include <asm/kup.h>
>   
> -/*
> - * The fs value determines whether argument validity checking should be
> - * performed or not.  If get_fs() == USER_DS, checking is performed, with
> - * get_fs() == KERNEL_DS, checking is bypassed.
> - *
> - * For historical reasons, these macros are grossly misnamed.
> - *
> - * The fs/ds values are now the highest legal address in the "segment".
> - * This simplifies the checking in the routines below.
> - */
> -
> -#define MAKE_MM_SEG(s)  ((mm_segment_t) { (s) })
> -
> -#define KERNEL_DS	MAKE_MM_SEG(~0UL)
>   #ifdef __powerpc64__
>   /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
> -#define USER_DS		MAKE_MM_SEG(TASK_SIZE_USER64 - 1)
> -#else
> -#define USER_DS		MAKE_MM_SEG(TASK_SIZE - 1)
> -#endif
> -
> -#define get_fs()	(current->thread.addr_limit)
> +#define TASK_SIZE_MAX		TASK_SIZE_USER64
>   
> -static inline void set_fs(mm_segment_t fs)
> +static inline bool __access_ok(unsigned long addr, unsigned long size)
>   {
> -	current->thread.addr_limit = fs;
> -	/* On user-mode return check addr_limit (fs) is correct */
> -	set_thread_flag(TIF_FSCHECK);
> +	if (addr >= TASK_SIZE_MAX)
> +		return false;
> +	/*
> +	 * This check is sufficient because there is a large enough gap between
> +	 * user addresses and the kernel addresses.
> +	 */
> +	return size <= TASK_SIZE_MAX;
>   }
> -
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -#define user_addr_max()	(get_fs().seg)
> -
> -#ifdef __powerpc64__
> -/*
> - * This check is sufficient because there is a large enough
> - * gap between user addresses and the kernel addresses
> - */
> -#define __access_ok(addr, size, segment)	\
> -	(((addr) <= (segment).seg) && ((size) <= (segment).seg))
> -
>   #else
> +#define TASK_SIZE_MAX		TASK_SIZE
>   
> -static inline int __access_ok(unsigned long addr, unsigned long size,
> -			mm_segment_t seg)
> +static inline bool __access_ok(unsigned long addr, unsigned long size)
>   {
> -	if (addr > seg.seg)
> -		return 0;
> -	return (size == 0 || size - 1 <= seg.seg - addr);
> +	if (addr >= TASK_SIZE_MAX)
> +		return false;
> +	if (size == 0)
> +		return false;

__access_ok() was returning true when size == 0 up to now. Any reason to 
return false now ?

> +	return size <= TASK_SIZE_MAX - addr;
>   }
> -
> -#endif
> +#endif /* __powerpc64__ */
>   
>   #define access_ok(addr, size)		\
>   	(__chk_user_ptr(addr),		\
> -	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
> +	 __access_ok((unsigned long)(addr), (size)))
>   
>   /*
>    * These are the main single-value transfer routines.  They automatically

Christophe
