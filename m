Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D934725C5A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgICPrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 11:47:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26991 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgICPrr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:47:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bj4vL0kzwzB09ZF;
        Thu,  3 Sep 2020 17:47:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UBMjKOF82pyz; Thu,  3 Sep 2020 17:47:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bj4vK623nzB09ZD;
        Thu,  3 Sep 2020 17:47:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6B978B80B;
        Thu,  3 Sep 2020 17:47:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8kHWzQ3JESNL; Thu,  3 Sep 2020 17:47:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79F9B8B803;
        Thu,  3 Sep 2020 17:47:34 +0200 (CEST)
Subject: Re: [PATCH 14/14] powerpc: remove address space overrides using
 set_fs()
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-15-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e7d2d231-5658-a4d3-0495-2af62f34aa34@csgroup.eu>
Date:   Thu, 3 Sep 2020 17:43:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903142242.925828-15-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 03/09/2020 à 16:22, Christoph Hellwig a écrit :
> Stop providing the possibility to override the address space using
> set_fs() now that there is no need for that any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


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
> +	return size == 0 || size <= TASK_SIZE_MAX - addr;
>   }

You don't need to test size == 0 anymore. It used to be necessary 
because of the 'size - 1', as size is unsigned.

Now you can directly do

	return size <= TASK_SIZE_MAX - addr;

If size is 0, this will always be true (because you already know that 
addr is not >= TASK_SIZE_MAX

Christophe
