Return-Path: <linux-fsdevel+bounces-13661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4C87294C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 22:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B8CB2D416
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537112B177;
	Tue,  5 Mar 2024 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwhoyyrR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133612A16C;
	Tue,  5 Mar 2024 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673442; cv=none; b=doeirI0Lmtd2wBDPT+3OCfyPrdoisH3uk4DtGfCvXUej7pOMOeHuf23Flx9WdttwZ9v9Cuzlilh5T1z7Yd3H7aBBIrFFEW1Xwvv95qv3cE7yzvx27mI/JV2vr2Sc50S5j6rVYVD6c7vW3hFvGNfwO3PythBMNX7FVDYbXSYHwWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673442; c=relaxed/simple;
	bh=QRXH/8lE9leyc3TMSPftFHr6I8X4mVKYeHcAzXHHCAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWzSjLHGPLMybipamQMcjVKcmb9MSIS50CdKwD+lvG/caHvonuqhSUN2Z5b7DUrU5YCaecocmx1GE272PW3qs+DkH+iyY33oCFODqW7Pi1v/oEHhW4BajwPGy4kGySuAdTTMiZjn+9bNuWH4oKTka5CbngvNL2gwIFbHgy44B8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwhoyyrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52701C433F1;
	Tue,  5 Mar 2024 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709673442;
	bh=QRXH/8lE9leyc3TMSPftFHr6I8X4mVKYeHcAzXHHCAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwhoyyrR+vVycbZa7TIxMaLpC6rGRiP2VO1S5gAASloZMPCTvJDvebT6kls70aoxu
	 6/BAhB57kRXv8KkaND6Y1D9VCw3fEYgJTjiuohiNwFesCR3FRnQHDi8NtjNUgTDiAl
	 IBEQz+GSAYLg9kqwgmRpsNfs9lIVh8y6bN3rogMpR1CfYbdA7lxeL+21M55e7hFozL
	 de3Z+N+5f/PZfe/F1IgN4MmXU4YN45KGYu8k1CPPTgntUNIsIMSF4idkSghmxoL4d9
	 sJD4tACESoAZW0wvMDiVt4sJTbEbmtT9/mDQt8biDQ0zaGQaAF8DZVTR53/ps7E37J
	 OOxT0P7Mq3Rdw==
Date: Tue, 5 Mar 2024 13:17:20 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Benjamin LaHaise <ben@communityfibre.ca>,
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb
 conversion
Message-ID: <20240305211720.GB1202@sol.localdomain>
References: <20240304235715.3790858-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304235715.3790858-1-bvanassche@acm.org>

On Mon, Mar 04, 2024 at 03:57:15PM -0800, Bart Van Assche wrote:
> The first kiocb_set_cancel_fn() argument may point at a struct kiocb
> that is not embedded inside struct aio_kiocb. With the current code,
> depending on the compiler, the req->ki_ctx read happens either before
> the IOCB_AIO_RW test or after that test. Move the req->ki_ctx read such
> that it is guaranteed that the IOCB_AIO_RW test happens first.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Cc: Benjamin LaHaise <ben@communityfibre.ca>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: stable@vger.kernel.org
> Fixes: b820de741ae4 ("fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/aio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index da18dbcfcb22..9cdaa2faa536 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -589,8 +589,8 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  
>  void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  {
> -	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
> -	struct kioctx *ctx = req->ki_ctx;
> +	struct aio_kiocb *req;
> +	struct kioctx *ctx;
>  	unsigned long flags;
>  
>  	/*
> @@ -600,9 +600,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
>  	if (!(iocb->ki_flags & IOCB_AIO_RW))
>  		return;
>  
> +	req = container_of(iocb, struct aio_kiocb, rw);
> +
>  	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
>  		return;
>  
> +	ctx = req->ki_ctx;
> +
>  	spin_lock_irqsave(&ctx->ctx_lock, flags);
>  	list_add_tail(&req->ki_list, &ctx->active_reqs);
>  	req->ki_cancel = cancel;

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

