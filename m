Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D8574D8AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 16:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjGJOMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGJOMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2216E3;
        Mon, 10 Jul 2023 07:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C9D76100B;
        Mon, 10 Jul 2023 14:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B6CC433C7;
        Mon, 10 Jul 2023 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688998339;
        bh=n1QzVCFUGJL7T3s1ar92cI/LlLz0o3J+O2Umt/DnYE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIj3kCae4u0Ux6qtQCEqr8Ge2We9WxZg+Mzg3tErvnz2NLwFwANOXHrfo9nyQmUvM
         Pgo/xAVi+1iybArWOjB2C1i2CSz2aXn/l9gLGw7iPAJxpcmkxasR0uL7+0lXWvEwpC
         998RRR8oCVq/lCR29EZpAKubLCdICQeRbFfRmZoGtXpQB18BYApl4/lCdCunundpYs
         HCcPa4yvibPhDB/kVQXj046XwYZbFTmaxE1x+8iIvySHlVqZTaKOFtKkKZhZ2v8rzP
         fPRYhUMNvPTT8y+yk6/xomXCGg6Ahte1+pKJbwOtviB5wE++nxL61s+GY7bBiGga16
         EWviaSHxcoLjw==
Date:   Mon, 10 Jul 2023 16:12:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: avoid overflow to ULLONG_MAX when ctx->count is
 0
Message-ID: <20230710-fahrbahn-flocken-03818a6b2e91@brauner>
References: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_7588DFD1F365950A757310D764517A14B306@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 09, 2023 at 02:54:51PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> For eventfd with flag EFD_SEMAPHORE, when its ctx->count is 0, calling
> eventfd_ctx_do_read will cause ctx->count to overflow to ULLONG_MAX.
> 
> Fixes: cb289d6244a3 ("eventfd - allow atomic read and waitqueue remove")
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dylan Yudaken <dylany@fb.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

So this looks ok but I would like to see an analysis how the overflow
can happen. I'm looking at the callers and it seems that once ctx->count
hits 0 eventfd_read() won't call eventfd_ctx_do_read() anymore. So is
there a caller that can call directly or indirectly
eventfd_ctx_do_read() on a ctx->count == 0?

I'm just slightly skeptical about patches that fix issues without an
analysis how this can happen.

>  fs/eventfd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 8aa36cd37351..10a101df19cd 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -189,7 +189,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
>  {
>  	lockdep_assert_held(&ctx->wqh.lock);
>  
> -	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
> +	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
>  	ctx->count -= *cnt;
>  }
>  EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
> @@ -269,6 +269,8 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
>  		return -EFAULT;
>  	if (ucnt == ULLONG_MAX)
>  		return -EINVAL;
> +	if ((ctx->flags & EFD_SEMAPHORE) && !ucnt)
> +		return -EINVAL;
>  	spin_lock_irq(&ctx->wqh.lock);
>  	res = -EAGAIN;
>  	if (ULLONG_MAX - ctx->count > ucnt)
> -- 
> 2.25.1
> 
