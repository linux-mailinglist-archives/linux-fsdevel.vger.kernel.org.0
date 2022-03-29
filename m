Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC14EAF3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiC2Ocm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiC2Ocl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A71AF35;
        Tue, 29 Mar 2022 07:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F0376163C;
        Tue, 29 Mar 2022 14:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCCDC340ED;
        Tue, 29 Mar 2022 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648564257;
        bh=YGBCDwu20aYXceHDsziZY/5cKNx33SODcdFmgKmTk0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LKaRD1/k84sNuoq0SvqUflcATp6zSiHt9JegnZDIP0tI5pRmi/8iOIDMqNP9md5Lo
         jm0bF6tnCRfBdNeiBMdY5qJ7IwSnTsSkuDYatdDzPv6bx2GaW5bc9Mpz1KwYLRBeTu
         ehNI5Q8+04Mz+uXpsZnvY/YWgR7zWCLH13TOCcEHVG+lrrEUTJ56716KsmQK65MWvh
         NH4cNK4qrH0vx+bCl4gvl11JeGEWo/3w2Oeffyi3Oeghdfv7djNtMEVT5tGf+6hDI4
         ai204mBep8gMQ+TtRorFuwCt7uirxaKoGuiRIkKsOwirgEx1dtzLUYwoHq4rz3YZVg
         Dsvgb7YLO4Iuw==
Date:   Tue, 29 Mar 2022 23:30:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] proc: bootconfig: add null pointer check
Message-Id: <20220329233053.bf162ee2e15f742ac967213a@kernel.org>
In-Reply-To: <20220329104004.2376879-1-lv.ruyi@zte.com.cn>
References: <20220329104004.2376879-1-lv.ruyi@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

Can you pick this with below lines? This seems to be there from v5.6.

Fixes: c1a3c36017d4 ("proc: bootconfig: Add /proc/bootconfig to show boot config list")
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

On Tue, 29 Mar 2022 10:40:04 +0000
cgel.zte@gmail.com wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kzalloc is a memory allocation function which can return NULL when some
> internal memory errors happen. It is safer to add null pointer check.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  fs/proc/bootconfig.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> index 6d8d4bf20837..2e244ada1f97 100644
> --- a/fs/proc/bootconfig.c
> +++ b/fs/proc/bootconfig.c
> @@ -32,6 +32,8 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
>  	int ret = 0;
>  
>  	key = kzalloc(XBC_KEYLEN_MAX, GFP_KERNEL);
> +	if (!key)
> +		return -ENOMEM;
>  
>  	xbc_for_each_key_value(leaf, val) {
>  		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
