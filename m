Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62654D0ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349698AbiFOS3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 14:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358465AbiFOS3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:29:09 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF363C499
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 11:29:06 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1XlHoHz3y26JC1XlHo1Z7E; Wed, 15 Jun 2022 20:29:04 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 15 Jun 2022 20:29:04 +0200
X-ME-IP: 90.11.190.129
Message-ID: <52d33450-44ae-3e05-9a3f-5835b3e97a7a@wanadoo.fr>
Date:   Wed, 15 Jun 2022 20:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] eventfd: Directly use ida_alloc()/free()
Content-Language: fr
To:     Bo Liu <liubo03@inspur.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615060314.2306-1-liubo03@inspur.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220615060314.2306-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 15/06/2022 à 08:03, Bo Liu a écrit :
> Use ida_alloc()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Hi,
for what it's worth:

Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

> ---
>   fs/eventfd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 3627dd7d25db..e17a2ea53da9 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -89,7 +89,7 @@ EXPORT_SYMBOL_GPL(eventfd_signal);
>   static void eventfd_free_ctx(struct eventfd_ctx *ctx)
>   {
>   	if (ctx->id >= 0)
> -		ida_simple_remove(&eventfd_ida, ctx->id);
> +		ida_free(&eventfd_ida, ctx->id);
>   	kfree(ctx);
>   }
>   
> @@ -423,7 +423,7 @@ static int do_eventfd(unsigned int count, int flags)
>   	init_waitqueue_head(&ctx->wqh);
>   	ctx->count = count;
>   	ctx->flags = flags;
> -	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
> +	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
>   
>   	flags &= EFD_SHARED_FCNTL_FLAGS;
>   	flags |= O_RDWR;

