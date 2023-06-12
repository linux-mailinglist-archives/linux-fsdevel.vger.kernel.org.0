Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64FD72B903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 09:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjFLHrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 03:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjFLHrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:47:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8882B19B7;
        Mon, 12 Jun 2023 00:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B70C861158;
        Mon, 12 Jun 2023 07:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE889C433EF;
        Mon, 12 Jun 2023 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686555933;
        bh=fNNa/Ten3TAlzVZUvP7Qr28Og4PiRtD+xLvGhMlIHD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVqte4ZR8kr8QRufriFvaxb3GbJ16a6Ry+QujPy8QHRA0g1eaOqnUP7XKFByaeMbS
         PIBzA+ic9BrmYEA0rhLrMz8G+OSyRqkJ6iHqQEWWL/MOtZhYDtQ2SDEtlgoCUWloW7
         HETVfw5tOhenB7hvWOsHXtnlsyJyn/zPJakfUcXI+n30d8Q6tpT8N8zKOMvICFZk7X
         7pcNsXOUlsbPvJduhngeBouustBapzDAoasJl2GFuQchKPJ4CPhdLs7V9+xWsBa0ph
         448DKiqNWI8LwhWv59HbzFEplFlBQvgeIFZ8eVz0f5TU7QXFKgrEczNLK/onFaEG2f
         ZZJ451H7DYVnA==
Date:   Mon, 12 Jun 2023 09:45:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     wenyang.linux@foxmail.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: show flags in fdinfo
Message-ID: <20230612-atomkraftgegner-erziehen-8ee4a0c9c606@brauner>
References: <tencent_59C3AA88A8F1829226E5D3619837FC4A9E09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_59C3AA88A8F1829226E5D3619837FC4A9E09@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:59:47AM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> The flags should be displayed in fdinfo, as different flags
> could affect the behavior of eventfd.
> 
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dylan Yudaken <dylany@fb.com>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/eventfd.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 6c06a527747f..5b5448e65f6f 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -33,10 +33,10 @@ struct eventfd_ctx {
>  	/*
>  	 * Every time that a write(2) is performed on an eventfd, the
>  	 * value of the __u64 being written is added to "count" and a
> -	 * wakeup is performed on "wqh". A read(2) will return the "count"
> -	 * value to userspace, and will reset "count" to zero. The kernel
> -	 * side eventfd_signal() also, adds to the "count" counter and
> -	 * issue a wakeup.
> +	 * wakeup is performed on "wqh". If EFD_SEMAPHORE flag was not
> +	 * specified, a read(2) will return the "count" value to userspace,
> +	 * and will reset "count" to zero. The kernel side eventfd_signal()
> +	 * also, adds to the "count" counter and issue a wakeup.
>  	 */
>  	__u64 count;
>  	unsigned int flags;
> @@ -301,6 +301,7 @@ static void eventfd_show_fdinfo(struct seq_file *m, struct file *f)
>  		   (unsigned long long)ctx->count);
>  	spin_unlock_irq(&ctx->wqh.lock);
>  	seq_printf(m, "eventfd-id: %d\n", ctx->id);
> +	seq_printf(m, "eventfd-flags: 0%o\n", ctx->flags);

EFD_CLOEXEC and EFD_NONBLOCK are mapped to generic O_* flags and are
included in fdinfo output already:

pos:    0
flags:  02000002 -> O_CLOEXEC/EFD_CLOEXEC | O_RDWR
mnt_id: 15
ino:    12497
eventfd-count:                0
eventfd-id: 156

So the only thing you really care about is EFD_SEMAPHORE. Since this
changes the type of the eventfd I would just do either:

eventfd-semaphore: {0,1}

or - if we can reasonably expect a third type:

eventfd-type: {0, ..., n}

though I suspect since it hasn't changed since 2.6-something that
eventfd-semaphore: {0,1} is probably fine.





so you only really care about EFD_SEMAPHORE. 
