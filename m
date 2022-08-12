Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE215590B58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 06:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiHLEyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 00:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiHLEyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 00:54:13 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE829825
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Aug 2022 21:54:12 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id MMgToznoetFxAMMgToIj8m; Fri, 12 Aug 2022 06:54:10 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 12 Aug 2022 06:54:10 +0200
X-ME-IP: 90.11.190.129
Message-ID: <a8666743-4dc5-79b8-56c7-23c05fc88d66@wanadoo.fr>
Date:   Fri, 12 Aug 2022 06:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] aio: Save a few cycles in 'lookup_ioctx()'
Content-Language: fr
To:     bcrl@kvack.org, viro@zeniv.linux.org.uk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <0c3fcdaec33bb12b2367860dfab7ed4224ea000c.1635974999.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <0c3fcdaec33bb12b2367860dfab7ed4224ea000c.1635974999.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 03/11/2021 à 22:31, Christophe JAILLET a écrit :
> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> save a few cycles when it is known that the rcu lock is already
> taken/released.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   fs/aio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 9c81cf611d65..d189ea13e10a 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1062,7 +1062,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
>   	id = array_index_nospec(id, table->nr);
>   	ctx = rcu_dereference(table->table[id]);
>   	if (ctx && ctx->user_id == ctx_id) {
> -		if (percpu_ref_tryget_live(&ctx->users))
> +		if (percpu_ref_tryget_live_rcu(&ctx->users))
>   			ret = ctx;
>   	}
>   out:


Hi,
gentle reminder.

Is this patch useful?
When I first posted it, percpu_ref_tryget_live_rcu() was really new.
Now it is part of linux since 5.16.

Saving a few cycles in a function with "lookup" in its name looks always 
good to me.

CJ
