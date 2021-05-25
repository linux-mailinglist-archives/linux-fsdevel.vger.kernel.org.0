Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8638FCED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhEYIfj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:35:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38888 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhEYIff (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:35:35 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fq6n90HXKzBByZ;
        Tue, 25 May 2021 10:34:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bCjmXtHDn76g; Tue, 25 May 2021 10:34:04 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fq6n86QgLzBBxw;
        Tue, 25 May 2021 10:34:04 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 2C5DBBBC; Tue, 25 May 2021 10:38:30 +0200 (CEST)
Received: from 37.173.125.11 ([37.173.125.11]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Tue, 25 May 2021 10:38:30 +0200
Date:   Tue, 25 May 2021 10:38:30 +0200
Message-ID: <20210525103830.Horde.TfZkOjej0Mdf8d8SMAnj2w1@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Wu Bo <wubo40@huawei.com>
Cc:     linfeilong@huawei.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/2] fs: direct-io: use DIV_ROUND_UP helper macro for
 calculations
References: <1621930520-515336-1-git-send-email-wubo40@huawei.com>
 <1621930520-515336-3-git-send-email-wubo40@huawei.com>
In-Reply-To: <1621930520-515336-3-git-send-email-wubo40@huawei.com>
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
>  fs/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index b2e86e7..6e7d402 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -195,7 +195,7 @@ static inline int dio_refill_pages(struct dio  
> *dio, struct dio_submit *sdio)
>  		iov_iter_advance(sdio->iter, ret);
>  		ret += sdio->from;
>  		sdio->head = 0;
> -		sdio->tail = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
> +		sdio->tail = DIV_ROUND_UP(ret, PAGE_SIZE);

Use PFN_UP() instead.


>  		sdio->to = ((ret - 1) & (PAGE_SIZE - 1)) + 1;
>  		return 0;
>  	}
> --
> 1.8.3.1


