Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530AC1AEAC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 10:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDRIPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 04:15:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17005 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgDRIPt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:15:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4945PZ0MxHz9txY8;
        Sat, 18 Apr 2020 10:15:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AQQa/JgG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hnYClEVc0eyG; Sat, 18 Apr 2020 10:15:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4945PY6R23z9txY6;
        Sat, 18 Apr 2020 10:15:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587197745; bh=jB5Gl7RxVqyXpo2Hse+3VUzGqM2gawZmxz49L7U420s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AQQa/JgGK4MzHvWoF2Z5uKFlyqbmJPtwJYfrPJO+D4iL/MNPzfUNv7235qVqZ+XxE
         2qr4B+iHbPm8eirpT2+BC1epVeoc8Tb7up/e08oG8+cE8EbaSzsZsFepDU+MrCJbhV
         jaPxQfZ42OA6Bw5qa9V+tN+58qaX+TXbTogZbPbo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EAF788B772;
        Sat, 18 Apr 2020 10:15:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xduYPJ1JYzVW; Sat, 18 Apr 2020 10:15:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 972068B75E;
        Sat, 18 Apr 2020 10:15:45 +0200 (CEST)
Subject: Re: [PATCH 8/8] exec: open code copy_string_kernel
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Jeremy Kerr <jk@ozlabs.org>, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
References: <20200414070142.288696-1-hch@lst.de>
 <20200414070142.288696-9-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ffea91ee-f386-9d19-0bc9-ab59eb7b9a41@c-s.fr>
Date:   Sat, 18 Apr 2020 10:15:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414070142.288696-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 14/04/2020 à 09:01, Christoph Hellwig a écrit :
> Currently copy_string_kernel is just a wrapper around copy_strings that
> simplifies the calling conventions and uses set_fs to allow passing a
> kernel pointer.  But due to the fact the we only need to handle a single
> kernel argument pointer, the logic can be sigificantly simplified while
> getting rid of the set_fs.


Instead of duplicating almost identical code, can you write a function 
that takes whether the source is from user or from kernel, then you just 
do things like:

	if (from_user)
		len = strnlen_user(str, MAX_ARG_STRLEN);
	else
		len = strnlen(str, MAX_ARG_STRLEN);


	if (from_user)
		copy_from_user(kaddr+offset, str, bytes_to_copy);
	else
		memcpy(kaddr+offset, str, bytes_to_copy);

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/exec.c | 43 ++++++++++++++++++++++++++++++++++---------
>   1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index b2a77d5acede..ea90af1fb236 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -592,17 +592,42 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>    */
>   int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>   {
> -	int r;
> -	mm_segment_t oldfs = get_fs();
> -	struct user_arg_ptr argv = {
> -		.ptr.native = (const char __user *const  __user *)&arg,
> -	};
> +	int len = strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating NUL */;
> +	unsigned long pos = bprm->p;
> +
> +	if (len == 0)
> +		return -EFAULT;
> +	if (!valid_arg_len(bprm, len))
> +		return -E2BIG;
> +
> +	/* We're going to work our way backwards. */
> +	arg += len;
> +	bprm->p -= len;
> +	if (IS_ENABLED(CONFIG_MMU) && bprm->p < bprm->argmin)
> +		return -E2BIG;
> +
> +	while (len > 0) {
> +		unsigned int bytes_to_copy = min_t(unsigned int, len,
> +				min_not_zero(offset_in_page(pos), PAGE_SIZE));
> +		struct page *page;
> +		char *kaddr;
>   
> -	set_fs(KERNEL_DS);
> -	r = copy_strings(1, argv, bprm);
> -	set_fs(oldfs);
> +		pos -= bytes_to_copy;
> +		arg -= bytes_to_copy;
> +		len -= bytes_to_copy;
>   
> -	return r;
> +		page = get_arg_page(bprm, pos, 1);
> +		if (!page)
> +			return -E2BIG;
> +		kaddr = kmap_atomic(page);
> +		flush_arg_page(bprm, pos & PAGE_MASK, page);
> +		memcpy(kaddr + offset_in_page(pos), arg, bytes_to_copy);
> +		flush_kernel_dcache_page(page);
> +		kunmap_atomic(kaddr);
> +		put_arg_page(page);
> +	}
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL(copy_string_kernel);
>   
> 

Christophe
