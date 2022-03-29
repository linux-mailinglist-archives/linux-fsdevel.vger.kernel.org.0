Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509614EAF25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiC2OX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiC2OX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A84122222;
        Tue, 29 Mar 2022 07:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D3161638;
        Tue, 29 Mar 2022 14:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA87C3410F;
        Tue, 29 Mar 2022 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648563701;
        bh=VVwm5sRxqTtRExOkYAMV6MNiuhhqErOVTCMWlhLuUdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bTo4imMBl22nJx/aU/x3311Ww/V+MRrKVct7hdnteuF4DxXTzOMyHoCnikSGfwYQb
         +x2xVRDTxyLZViA6A+IgYfIznefpkMr2Eyozhw1ZQr9GNR0sMtmj2SZLmg5/u5fIth
         S3pOVS6RdwvUjWTmpNlkq2xnNbTYAsvCYlB8dI4THd6CVCcAd9LJ7DSfIvU6Z17UWc
         BfzzDlOpgnuLvkrys9mGW92Af4afeTnaXqejzBcKmWJWpOyUDd+GiDCzDfthBpfDJw
         iQiLhyBzzAyo4bh9FssR4DTRlFaZrWxIL+7lqNMHrTByPQMTxI99rTOPac5DBIW8w3
         r2vpNqPKVPyaA==
Date:   Tue, 29 Mar 2022 23:21:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] proc: bootconfig: add null pointer check
Message-Id: <20220329232137.c63ea3258df2176667d6f846@kernel.org>
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

On Tue, 29 Mar 2022 10:40:04 +0000
cgel.zte@gmail.com wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kzalloc is a memory allocation function which can return NULL when some
> internal memory errors happen. It is safer to add null pointer check.

Oops, yes.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

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
