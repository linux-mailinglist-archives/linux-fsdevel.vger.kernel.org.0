Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF8038FCE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhEYIfd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:35:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55330 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231328AbhEYIfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:35:24 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fq6mH24T3zBBxl;
        Tue, 25 May 2021 10:33:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8CJvT3fW2Ivs; Tue, 25 May 2021 10:33:19 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fq6mH1Br4zBBm1;
        Tue, 25 May 2021 10:33:19 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 68EE0BBC; Tue, 25 May 2021 10:37:44 +0200 (CEST)
Received: from 37.173.125.11 ([37.173.125.11]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Tue, 25 May 2021 10:37:44 +0200
Date:   Tue, 25 May 2021 10:37:44 +0200
Message-ID: <20210525103744.Horde.nmFFeC3J2_-Qdu7udOYa8g1@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Wu Bo <wubo40@huawei.com>
Cc:     linfeilong@huawei.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] crypto: af_alg - use DIV_ROUND_UP helper macro for
 calculations
References: <1621930520-515336-1-git-send-email-wubo40@huawei.com>
 <1621930520-515336-2-git-send-email-wubo40@huawei.com>
In-Reply-To: <1621930520-515336-2-git-send-email-wubo40@huawei.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wu Bo <wubo40@huawei.com> a écrit :

> From: Wu Bo <wubo40@huawei.com>
>
> Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> macro for better readability.
>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  crypto/af_alg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> index 18cc82d..8bd288d 100644
> --- a/crypto/af_alg.c
> +++ b/crypto/af_alg.c
> @@ -411,7 +411,7 @@ int af_alg_make_sg(struct af_alg_sgl *sgl,  
> struct iov_iter *iter, int len)
>  	if (n < 0)
>  		return n;
>
> -	npages = (off + n + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	npages = DIV_ROUND_UP(off + n, PAGE_SIZE);

You should use PFN_UP()

>  	if (WARN_ON(npages == 0))
>  		return -EINVAL;
>  	/* Add one extra for linking */
> --
> 1.8.3.1


