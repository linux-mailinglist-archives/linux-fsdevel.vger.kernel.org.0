Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0269240AE20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhINMrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhINMrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556BBC061574;
        Tue, 14 Sep 2021 05:46:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631623583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q/84IbPNGrTQfQ+vsiQ1jeuVMXcjffcoOobz9HXS1DE=;
        b=oP2XLefL2yIJ+6Ioj819kz6Q8jspPl/Sjin4qKtUhFC0KKyL99sA2EouK74kKlj9EGFOTr
        Tg9cb5G1D1N4V2RFqxK9XxmIvyxnkAfjQq87zwuGHECZ1+DzbmcHMeIXhz8+QMhqjDlHz0
        EjoB2DAO6A7YO0qjixf7DhmedxiZGSJvcX1xKrT6wdao1+ytvgPQZaohTIslaYV0c9DBlC
        naFi5CGOveKH6VJe+3mkg8lin54ZEwe9Y5O/sk7WQR67pAO1NzVyUGzBhEjZzhH5vueW3Y
        j7GgXTAaakKKEFtyc06lixWDKYZ1op27Rh+3r6daqrbVPiUOI4XyeWEr1kNMzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631623583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q/84IbPNGrTQfQ+vsiQ1jeuVMXcjffcoOobz9HXS1DE=;
        b=gMw3xdcKKC5uepnGYt7QsCS/HH7qJ7ceE7u7+S+xPN02hcBa9frc2eNLT4ImQb7iA6EBFu
        TISXsPlfK6bRPPAg==
To:     Xie Yongji <xieyongji@bytedance.com>, bcrl@kvack.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
In-Reply-To: <20210913111928.98-1-xieyongji@bytedance.com>
References: <20210913111928.98-1-xieyongji@bytedance.com>
Date:   Tue, 14 Sep 2021 14:46:23 +0200
Message-ID: <87ee9rcokg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13 2021 at 19:19, Xie Yongji wrote:
> We should defer eventfd_signal() to the workqueue when
> eventfd_signal_allowed() return false rather than return
> true.
>
> Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 51b08ab01dff..8822e3ed4566 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>  		list_del(&iocb->ki_list);
>  		iocb->ki_res.res = mangle_poll(mask);
>  		req->done = true;
> -		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> +		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {

Thanks for catching that!

>  			iocb = NULL;
>  			INIT_WORK(&req->work, aio_poll_put_work);
>  			schedule_work(&req->work);
