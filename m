Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49997261C19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgIHTOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 15:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731195AbgIHQEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599581086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0nFHBAUKZtW6gfmKK0htBo0gwbtsv3Iq0Ml6HLLohY8=;
        b=Pn4A1LX68rOZ64MG9Sw2kVJ1k73IzTGWO+Vw9D+dG8a5T2udNYG7xRPnMbuWVCIlr/hL4O
        ZEDejS1sih3x3iNaIuP0SPHj8g61WJZcz+stXqyzymhX+bAhQsNoil93bj1OF5/gGe9WQU
        TMNE1ll/BgO4RngVadNV3/6nUlWD8bs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-a12p8u7iO72gd7kDfgT0Qg-1; Tue, 08 Sep 2020 09:44:53 -0400
X-MC-Unique: a12p8u7iO72gd7kDfgT0Qg-1
Received: by mail-wm1-f71.google.com with SMTP id d22so2412902wmd.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2020 06:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0nFHBAUKZtW6gfmKK0htBo0gwbtsv3Iq0Ml6HLLohY8=;
        b=uY7B7dJHFTtm23gt066ncf060/jLYA39CTHRhZT5Bt8y4AH4OuIS/eDHQTUV/d8aDQ
         +7K53BvtSfCtAtjtVuYeTOQkAAfq1Ly9R1QyzzF04+dZx+Ga92Z+6ENCf6DgnBLcfGPJ
         ytI7kHqqKr6nw6OjocyGrbqzrZYDhph92jR7MD0LEF8tRkOYq5RZALwbDAJdXYzzhqPE
         Fz4GOqPhS6w/QBXx+FdhOtaCtrMwQ3G+AkAYQYNPlpuj+DMAANz2iPvC9bYg36lAIzVu
         TGDGFQ+Txe6UdLBxvVYT8YW68V+KHvjjFhhaZQmEv1umVL6xcpaXMYsM68z/qUdx0pYw
         UIvQ==
X-Gm-Message-State: AOAM531K86LxYIQJxbMUmjkipQlWlZDgQqRA/Tvh+T42efPYboFEzDac
        +TNCWI2yS2XWp1NNcicMar6Pjcxv3dae252Xe8RIQxOYvYoYQLDXY/5JS/L6YZMa21BpyLUojwq
        c5sKDC5+EdBirJsMqnuarSiqKRg==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr25476349wru.50.1599572692190;
        Tue, 08 Sep 2020 06:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9ir0JHeXFpAb6judRqJTvTeaAaWL4TLCJr6544I6qsmBmpMMbYdbvWqjAJ6jpsRsfpch5mg==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr25476320wru.50.1599572691912;
        Tue, 08 Sep 2020 06:44:51 -0700 (PDT)
Received: from steredhat (host-79-53-225-185.retail.telecomitalia.it. [79.53.225.185])
        by smtp.gmail.com with ESMTPSA id a83sm31806176wmh.48.2020.09.08.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:44:51 -0700 (PDT)
Date:   Tue, 8 Sep 2020 15:44:48 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        Aleksa Sarai <asarai@suse.de>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 3/3] io_uring: allow disabling rings during the
 creation
Message-ID: <20200908134448.sg7evdrfn6xa67sn@steredhat>
References: <20200827145831.95189-1-sgarzare@redhat.com>
 <20200827145831.95189-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827145831.95189-4-sgarzare@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

On Thu, Aug 27, 2020 at 04:58:31PM +0200, Stefano Garzarella wrote:
> This patch adds a new IORING_SETUP_R_DISABLED flag to start the
> rings disabled, allowing the user to register restrictions,
> buffers, files, before to start processing SQEs.
> 
> When IORING_SETUP_R_DISABLED is set, SQE are not processed and
> SQPOLL kthread is not started.
> 
> The restrictions registration are allowed only when the rings
> are disable to prevent concurrency issue while processing SQEs.
> 
> The rings can be enabled using IORING_REGISTER_ENABLE_RINGS
> opcode with io_uring_register(2).
> 
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4:
>  - fixed io_uring_enter() exit path when ring is disabled
> 
> v3:
>  - enabled restrictions only when the rings start
> 
> RFC v2:
>  - removed return value of io_sq_offload_start()
> ---
>  fs/io_uring.c                 | 52 ++++++++++++++++++++++++++++++-----
>  include/uapi/linux/io_uring.h |  2 ++
>  2 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 5f62997c147b..b036f3373fbe 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -226,6 +226,7 @@ struct io_restriction {
>  	DECLARE_BITMAP(sqe_op, IORING_OP_LAST);
>  	u8 sqe_flags_allowed;
>  	u8 sqe_flags_required;
> +	bool registered;
>  };
>  
>  struct io_ring_ctx {
> @@ -7497,8 +7498,8 @@ static int io_init_wq_offload(struct io_ring_ctx *ctx,
>  	return ret;
>  }
>  
> -static int io_sq_offload_start(struct io_ring_ctx *ctx,
> -			       struct io_uring_params *p)
> +static int io_sq_offload_create(struct io_ring_ctx *ctx,
> +				struct io_uring_params *p)
>  {
>  	int ret;
>  
> @@ -7532,7 +7533,6 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>  			ctx->sqo_thread = NULL;
>  			goto err;
>  		}
> -		wake_up_process(ctx->sqo_thread);
>  	} else if (p->flags & IORING_SETUP_SQ_AFF) {
>  		/* Can't have SQ_AFF without SQPOLL */
>  		ret = -EINVAL;
> @@ -7549,6 +7549,12 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>  	return ret;
>  }
>  
> +static void io_sq_offload_start(struct io_ring_ctx *ctx)
> +{
> +	if ((ctx->flags & IORING_SETUP_SQPOLL) && ctx->sqo_thread)
> +		wake_up_process(ctx->sqo_thread);
> +}
> +
>  static inline void __io_unaccount_mem(struct user_struct *user,
>  				      unsigned long nr_pages)
>  {
> @@ -8295,6 +8301,9 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>  	if (!percpu_ref_tryget(&ctx->refs))
>  		goto out_fput;
>  
> +	if (ctx->flags & IORING_SETUP_R_DISABLED)
> +		goto out_fput;
> +

While writing the man page paragraph, I discovered that if the rings are
disabled I returned ENXIO error in io_uring_enter(), coming from the previous
check.

I'm not sure it is the best one, maybe I can return EBADFD or another
error.

What do you suggest?

I'll add a test for this case.

Thanks,
Stefano

