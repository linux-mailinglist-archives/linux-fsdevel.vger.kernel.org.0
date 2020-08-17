Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C312473BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 21:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbgHQTAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 15:00:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14031 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730832AbgHQPsK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVdjS6XRmz9vCxl;
        Mon, 17 Aug 2020 17:47:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HMNM4ubvFG_E; Mon, 17 Aug 2020 17:47:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVdjS5Vhfz9vCxf;
        Mon, 17 Aug 2020 17:47:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 35ED38B7C2;
        Mon, 17 Aug 2020 17:48:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i100p36g_FZq; Mon, 17 Aug 2020 17:48:01 +0200 (CEST)
Received: from [172.25.230.104] (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA36D8B779;
        Mon, 17 Aug 2020 17:47:59 +0200 (CEST)
Subject: Re: [PATCH 10/11] powerpc: use non-set_fs based maccess routines
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-11-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <84df68bd-eb66-0105-1f3c-f3b07e5d60e6@csgroup.eu>
Date:   Mon, 17 Aug 2020 17:47:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817073212.830069-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 17/08/2020 à 09:32, Christoph Hellwig a écrit :
> Provide __get_kernel_nofault and __put_kernel_nofault routines to
> implement the maccess routines without messing with set_fs and without
> opening up access to user space.

__get_user_size() opens access to user space. You have to use 
__get_user_size_allowed() when user access is already allowed (or when 
not needed to allow it).

Christophe

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/include/asm/uaccess.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 00699903f1efca..a31de40ac00b62 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -623,4 +623,20 @@ do {									\
>   		__put_user_goto(*(u8*)(_src + _i), (u8 __user *)(_dst + _i), e);\
>   } while (0)
>   
> +#define HAVE_GET_KERNEL_NOFAULT
> +
> +#define __get_kernel_nofault(dst, src, type, err_label)			\
> +do {									\
> +	int __kr_err;							\
> +									\
> +	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
> +			sizeof(type), __kr_err);			\
> +	if (unlikely(__kr_err))						\
> +		goto err_label;						\
> +} while (0)
> +
> +#define __put_kernel_nofault(dst, src, type, err_label)			\
> +	__put_user_size_goto(*((type *)(src)),				\
> +		(__force type __user *)(dst), sizeof(type), err_label)
> +
>   #endif	/* _ARCH_POWERPC_UACCESS_H */
> 
