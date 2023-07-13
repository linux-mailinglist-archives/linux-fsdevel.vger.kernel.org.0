Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FE751C53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjGMI41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 04:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjGMI40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA7F12E;
        Thu, 13 Jul 2023 01:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9506061A91;
        Thu, 13 Jul 2023 08:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C52AC433C7;
        Thu, 13 Jul 2023 08:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689238585;
        bh=fXAs8WA2MGh2xR497240sNMs6n7reD0dpJ8m9xGMUa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1yAPWUwuO4iyD+7JcINl6beVztAa0Mvu8ZNb2RKzUNYrAq/NRcZGZMN3asORDhpo
         C2dJYnxbmnTguhDcwem2Sy4GIEmQJ4mvKOOizyMRsOh+PeWCYWKs8XIaN1hFoEuDQq
         fAEBfrdoHpPADPHBtyoWkOlgC4kVeHiiOFY45LaXx2/PvfEKuc3KSSqEcpigW+R07U
         PXk3+5hDwMfyXNJ7tS5io/C84qln5RJywbmtwVoMKW4j6ORWQry3yFckOBCePCkUB7
         SHZwnBCYVkPNlj3Nl90S3twQih+T9I1E2SDdy+zW8rID4mWj0m1Gcm8OGhuMpOBZV+
         YBVmYNQ8vrreQ==
Date:   Thu, 13 Jul 2023 10:56:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: avoid unnecessary wakeups in eventfd_write()
Message-ID: <20230713-wellen-heftig-b950ad3e64d2@brauner>
References: <tencent_DC522F05F54C72A6EF3193F9313CD756350A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_DC522F05F54C72A6EF3193F9313CD756350A@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:42:32AM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> In eventfd_write(), when ucnt is 0 and ctx->count is also 0,
> current->in_eventfd will be set to 1, which may affect eventfd_signal(),
> and unnecessary wakeups will also be performed.
> 
> Fix this issue by ensuring that ctx->count is not zero.
> 
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
>  fs/eventfd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 33a918f9566c..254b18ff0e00 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -281,10 +281,12 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
>  	}
>  	if (likely(res > 0)) {
>  		ctx->count += ucnt;
> -		current->in_eventfd = 1;
> -		if (waitqueue_active(&ctx->wqh))
> -			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> -		current->in_eventfd = 0;
> +		if (ctx->count) {
> +			current->in_eventfd = 1;
> +			if (waitqueue_active(&ctx->wqh))
> +				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> +			current->in_eventfd = 0;
> +		}
>  	}
>  	spin_unlock_irq(&ctx->wqh.lock);

I don't think we can do this. Consider the following:

        struct pollfd pfd = {
                .events = POLLIN | POLLOUT,
        };

        int fd = eventfd(0, 0);
        if (fd < 0)
                return -1;

        write(fd, &w, sizeof(__u64));

        poll(&pfd, 1, -1);

        printf("%d\n", pfd.revents & POLLOUT);

Currently, the eventfd_poll() will do:

        ULLONG_MAX - 1 > ctx->count

informing pollers with POLLOUT that the eventfd is writable, iow, that
the count has overflowed.

After your change such POLLOUT waiters will hang forever even though the
eventfd is writable.

So currently, a zero write on an eventfd can be used to inform another
process that they can write. This breaks this completely.

Caller's that don't want to be woken up on zero writes should just not
set POLLOUT:

        struct pollfd pfd = {
                .events = POLLIN,
        };

        int fd = eventfd(0, 0);
        if (fd < 0)
                return -1;

        write(fd, &w, sizeof(__u64));

        poll(&pfd, 1, -1);

This will wait until someone actually writes something.
