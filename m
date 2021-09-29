Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE3241CBAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 20:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbhI2SUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 14:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344234AbhI2SUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632939500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nnJZ7DpiogLpstvFiZH+ZlbBG07Zi0HLaCj48WwsBY8=;
        b=VoeqJSbg2PQ9UDy5sx45KMOyAJCoo6so3Q1EMvopmsviFHsTRIujC1Canf2dZdMn6904XW
        iGAyDpNCjyfKhhtrx1UluRFogjG443ERuNZlHKBD+wlbIeH0fuyT40FhfwpQD9KYP53ZMJ
        gau2cJye3JkRFO2dt7Uy12kUEH/SvyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-wd7hD-DWPf2CUXLQtgs_rA-1; Wed, 29 Sep 2021 14:18:18 -0400
X-MC-Unique: wd7hD-DWPf2CUXLQtgs_rA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23556189CD1F;
        Wed, 29 Sep 2021 18:18:17 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2115819C59;
        Wed, 29 Sep 2021 18:18:16 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ramji Jiyani <ramjiyani@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, hch@lst.de
Subject: Re: [PATCH] aio: Add support for the POLLFREE
References: <20210913183753.563103-1-ramjiyani@google.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 29 Sep 2021 14:20:08 -0400
In-Reply-To: <20210913183753.563103-1-ramjiyani@google.com> (Ramji Jiyani's
        message of "Mon, 13 Sep 2021 18:37:52 +0000")
Message-ID: <x494ka39rc7.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding Oleg and Christoph.

Ramji Jiyani <ramjiyani@google.com> writes:

> Commit f5cb779ba163 ("ANDROID: binder: remove waitqueue when thread
> exits.") fixed the use-after-free in eventpoll but aio still has the
> same issue because it doesn't honor the POLLFREE flag.
>
> Add support for the POLLFREE flag to force complete iocb inline in
> aio_poll_wake(). A thread may use it to signal it's exit and/or request
> to cleanup while pending poll request. In this case, aio_poll_wake()
> needs to make sure it doesn't keep any reference to the queue entry
> before returning from wake to avoid possible use after free via
> poll_cancel() path.

Is this an in-kernel user?  Can you explain more about how or when this
happens?  Do you have a stack trace that shows the problem?  I'm not
sure this use of POLLFREE exactly follows with the initial intention of
the flag, but hopefully Oleg can comment on that.

Thanks,
Jeff

> The POLLFREE flag is no more exclusive to the epoll and is being
> shared with the aio. Remove comment from poll.h to avoid confusion.
> Also enclosed the POLLFREE macro definition in parentheses to fix
> checkpatch error.
>
> Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
> ---
>  fs/aio.c                        | 45 ++++++++++++++++++---------------
>  include/uapi/asm-generic/poll.h |  2 +-
>  2 files changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 51b08ab01dff..5d539c05df42 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1674,6 +1674,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>  {
>  	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
>  	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
> +	struct kioctx *ctx = iocb->ki_ctx;
>  	__poll_t mask = key_to_poll(key);
>  	unsigned long flags;
>  
> @@ -1683,29 +1684,33 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>  
>  	list_del_init(&req->wait.entry);
>  
> -	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
> -		struct kioctx *ctx = iocb->ki_ctx;
> +	/*
> +	 * Use irqsave/irqrestore because not all filesystems (e.g. fuse)
> +	 * call this function with IRQs disabled and because IRQs have to
> +	 * be disabled before ctx_lock is obtained.
> +	 */
> +	if (mask & POLLFREE) {
> +		/* Force complete iocb inline to remove refs to deleted entry */
> +		spin_lock_irqsave(&ctx->ctx_lock, flags);
> +	} else if (!(mask && spin_trylock_irqsave(&ctx->ctx_lock, flags))) {
> +		/* Can't complete iocb inline; schedule for later */
> +		schedule_work(&req->work);
> +		return 1;
> +	}
>  
> -		/*
> -		 * Try to complete the iocb inline if we can. Use
> -		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
> -		 * call this function with IRQs disabled and because IRQs
> -		 * have to be disabled before ctx_lock is obtained.
> -		 */
> -		list_del(&iocb->ki_list);
> -		iocb->ki_res.res = mangle_poll(mask);
> -		req->done = true;
> -		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> -			iocb = NULL;
> -			INIT_WORK(&req->work, aio_poll_put_work);
> -			schedule_work(&req->work);
> -		}
> -		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> -		if (iocb)
> -			iocb_put(iocb);
> -	} else {
> +	/* complete iocb inline */
> +	list_del(&iocb->ki_list);
> +	iocb->ki_res.res = mangle_poll(mask);
> +	req->done = true;
> +	if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> +		iocb = NULL;
> +		INIT_WORK(&req->work, aio_poll_put_work);
>  		schedule_work(&req->work);
>  	}
> +	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> +	if (iocb)
> +		iocb_put(iocb);
> +
>  	return 1;
>  }
>  
> diff --git a/include/uapi/asm-generic/poll.h b/include/uapi/asm-generic/poll.h
> index 41b509f410bf..35b1b69af729 100644
> --- a/include/uapi/asm-generic/poll.h
> +++ b/include/uapi/asm-generic/poll.h
> @@ -29,7 +29,7 @@
>  #define POLLRDHUP       0x2000
>  #endif
>  
> -#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
> +#define POLLFREE	((__force __poll_t)0x4000)
>  
>  #define POLL_BUSY_LOOP	(__force __poll_t)0x8000

