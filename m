Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998C346C84A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 00:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbhLGXhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 18:37:23 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35548 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbhLGXhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:37:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22545CE1E73;
        Tue,  7 Dec 2021 23:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D659EC341C3;
        Tue,  7 Dec 2021 23:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638920029;
        bh=Nfg3YqguSxA2+g9j6/7r7xpPHPuAYZukNSC1CsbBOMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g93jKFyAqj2TfzuK2Gur3oEbcPEVFjha9zobMvPO6mkDnCYL7cF0kKnWRiqzkNrM4
         /DkM3VXQSPlpz+7t8pUbMCwarwBBsH2QBi5vhfuFwDcvHFKQPhb5qJ0rzv2wZYb2z1
         7P7HqnwbwcgbypmcdB7VsjDPJfM7Xq7Sa22wS/Wubybi3/GMnCgRmCb2gWfg17Z9vn
         R9uQAddFTMwV9R2n12xiAEfazexBnN7Z/S9hhrjW6EghA18ZVmkF1o+XfcT+lVlhHI
         720PV8QvGWfeNFhnnftgB/BMgMAQXd8S12bIynYpnr4neJeYx0DfM4C017XSLS0CUs
         RLGrSoR7Vmwnw==
Date:   Tue, 7 Dec 2021 15:33:47 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     bcrl@kvack.org, viro@zeniv.linux.org.uk, tglx@linutronix.de,
        axboe@kernel.dk, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
Message-ID: <Ya/vW/eGXCzbmvAC@sol.localdomain>
References: <20210913111928.98-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913111928.98-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:19:28PM +0800, Xie Yongji wrote:
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
>  			iocb = NULL;
>  			INIT_WORK(&req->work, aio_poll_put_work);
>  			schedule_work(&req->work);
> -- 
> 2.11.0
> 

Since I was just working with this file...:

Reviewed-by: Eric Biggers <ebiggers@google.com>

I don't know who is taking aio fixes these days, but whoever does so probably
should take this one at the same time as mine
(https://lore.kernel.org/linux-fsdevel/20211207095726.169766-1-ebiggers@kernel.org).

- Eric
