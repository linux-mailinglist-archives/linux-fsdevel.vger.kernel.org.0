Return-Path: <linux-fsdevel+bounces-13547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C688870ABE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347681F231DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A2779948;
	Mon,  4 Mar 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL9BNOn9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A37869E;
	Mon,  4 Mar 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580716; cv=none; b=m2JJ0HJANmG4TMHPQwkO1lxcp/CaNgNxaNVtSNzfE5J0FpRAib8HG+28GUoHvMaO/EPzmCmeGFOwmsv7ks/VyUuVRXt9k8t7fTDP7CDBtSvGgf3o34xzvv1KkTGX8+f7M9ue642UqsQu6tOBvK22XReRlWQw4F2X2bGtS+dGTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580716; c=relaxed/simple;
	bh=/7r2yABS70a2BV6XpcMn72U5TYLEICOD6PuGQ6u/XDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6iwOTnYHru8fzzwBX9NpESVwJjLpAXWAOqSqqqpnnTDU25EpFz71VqEX4QmsohL/pepiYyfdhyig/64ezUIIrRukFXc4ovWICQvitLKLMgQanETjDU4F62rM+I8WnvjLoL0a2L12+oNJwdXwoX5lNTLcNQ+cmT1IO1AVldRj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL9BNOn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206BFC433F1;
	Mon,  4 Mar 2024 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580715;
	bh=/7r2yABS70a2BV6XpcMn72U5TYLEICOD6PuGQ6u/XDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HL9BNOn9j3nsV+vEwAQlzNMLVlrtDdXS4J70mNXFp/uhEqJNvhwYWN/WvW4mZzKHG
	 UIXYq+hr5UgxJAoLvD7sSeWUOP438JXs/NOicgbWXu8zeLCtLyjIJRGU5918hNnMmb
	 SXLFapzROq83bPtEHBJUGBY3RLgCJQjxchAmRLbrDybSp4r/pNdBqAVXN1nF3WrYfi
	 YGVPJ3xN46B9mZ1LQHMh4yWUfJY5SMwpoNxJZf2+AsJTCjuCvhhy/J8Gnph+tl+tw/
	 jmDhc5fk/Ep3wMIUNS7vQSP9ruXaT9W2VgfT43DjOD0v4003LRSn/W7pzwIC61xhof
	 judK6rA9UFsiw==
Date: Mon, 4 Mar 2024 11:31:53 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Benjamin LaHaise <ben@communityfibre.ca>,
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org,
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Subject: Re: [PATCH] Revert "fs/aio: Make io_cancel() generate completions
 again"
Message-ID: <20240304193153.GC1195@sol.localdomain>
References: <20240304182945.3646109-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304182945.3646109-1-bvanassche@acm.org>

On Mon, Mar 04, 2024 at 10:29:44AM -0800, Bart Van Assche wrote:
> Patch "fs/aio: Make io_cancel() generate completions again" is based on the
> assumption that calling kiocb->ki_cancel() does not complete R/W requests.
> This is incorrect: the two drivers that call kiocb_set_cancel_fn() callers
> set a cancellation function that calls usb_ep_dequeue(). According to its
> documentation, usb_ep_dequeue() calls the completion routine with status
> -ECONNRESET. Hence this revert.
> 
> Cc: Benjamin LaHaise <ben@communityfibre.ca>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
> Fixes: 54cbc058d86b ("fs/aio: Make io_cancel() generate completions again")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/aio.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 28223f511931..da18dbcfcb22 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -2165,11 +2165,14 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
>  #endif
>  
>  /* sys_io_cancel:
> - *	Attempts to cancel an iocb previously passed to io_submit(). If the
> - *	operation is successfully cancelled 0 is returned. May fail with
> - *	-EFAULT if any of the data structures pointed to are invalid. May
> - *	fail with -EINVAL if aio_context specified by ctx_id is invalid. Will
> - *	fail with -ENOSYS if not implemented.
> + *	Attempts to cancel an iocb previously passed to io_submit.  If
> + *	the operation is successfully cancelled, the resulting event is
> + *	copied into the memory pointed to by result without being placed
> + *	into the completion queue and 0 is returned.  May fail with
> + *	-EFAULT if any of the data structures pointed to are invalid.
> + *	May fail with -EINVAL if aio_context specified by ctx_id is
> + *	invalid.  May fail with -EAGAIN if the iocb specified was not
> + *	cancelled.  Will fail with -ENOSYS if not implemented.
>   */
>  SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>  		struct io_event __user *, result)
> @@ -2200,12 +2203,14 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>  	}
>  	spin_unlock_irq(&ctx->ctx_lock);
>  
> -	/*
> -	 * The result argument is no longer used - the io_event is always
> -	 * delivered via the ring buffer.
> -	 */
> -	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
> -		aio_complete_rw(&kiocb->rw, -EINTR);
> +	if (!ret) {
> +		/*
> +		 * The result argument is no longer used - the io_event is
> +		 * always delivered via the ring buffer. -EINPROGRESS indicates
> +		 * cancellation is progress:
> +		 */
> +		ret = -EINPROGRESS;
> +	}

Acked-by: Eric Biggers <ebiggers@google.com>

It does look like all the ->ki_cancel functions complete the request already, so
this patch was unnecessary and just introduced a bug.

Note that IOCB_CMD_POLL installs a ->ki_cancel function too, and that's how
syzbot hit the use-after-free so easily.

I assume that the patch just wasn't tested?  Or did you find that it actually
fixed something (how)?

By the way, libaio (https://pagure.io/libaio) has a test suite for these system
calls.  How about adding a test case that cancels an IOCB_CMD_POLL request and
verifies that the completion event is received?

- Eric

