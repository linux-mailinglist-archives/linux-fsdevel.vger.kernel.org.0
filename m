Return-Path: <linux-fsdevel+bounces-13582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31784871898
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 09:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6395F1C21FDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4184EB22;
	Tue,  5 Mar 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcGLzprZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D11EF1A;
	Tue,  5 Mar 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628653; cv=none; b=Ip4pFzwNd4jaPGh07/2lZIwWsaUIUFRnEBjpOGkxOdeiTNa7sXP88ElRnK+BAKcD6N3bdxEjtTW3RFtYQIWU5vGzKwwWIuG3uUQfLRfAxcTU6W3OudhDgTrwnPwgDXcs3gbP4mLzhRaTWNC6k2JAoxwImSxwXRAjSJieAFs4C7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628653; c=relaxed/simple;
	bh=DyXXmi9xBKFIB5b3qAVMIq5k1bllrfhLzGN76CiHtxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjG2G8ENk4WpFdPs+vsC8f97E/lICDSYzH6q4WuLYEbmw6yvs4sB9ZWC10FUsT5IWctwtoua74IXwZi/tFj6j9oev9bOX8pZJQlK9sr2CIVUAxJ30s75DVvtITGLUjTyzgRxbznxF0Duv5tsjy2AWiXpxlHsTlRYezIpR0d7ft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcGLzprZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A2BC433F1;
	Tue,  5 Mar 2024 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709628652;
	bh=DyXXmi9xBKFIB5b3qAVMIq5k1bllrfhLzGN76CiHtxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FcGLzprZ6+RIeEtQGE7uPCLSWvNTyYgPaWj717NC+20kXmDItu8kpNn2PJiZ+0Qrs
	 HP/7AHbRgCohMJrA6pJhEeLzMEwuB8ILPNG/tbCjUmvKrtk/0ism494/5NSdFb7xSD
	 U+5fsUQPJygLZuXdeAFLktGUro4R/tI+HY3ZSWxE3l33D3Heczh1MaqtxbOf0n6mva
	 E7NWukQjfm1KVc6BxYSBUQ1b0BglclfFD57rKUHyEqlaYLMq4/EE5eUjpDSUvXOntl
	 GBdhSkemIwQDcTxTcwbKNeJaOpWj5PykVXpM//kCStZ5/mfBmZSfcJsh3kqjj3HWPD
	 ax6V2YKEij2KA==
Date: Tue, 5 Mar 2024 09:50:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-fsdevel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Benjamin LaHaise <ben@communityfibre.ca>, 
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>, 
	Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org, 
	syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Subject: Re: [PATCH] Revert "fs/aio: Make io_cancel() generate completions
 again"
Message-ID: <20240305-hinunter-atempause-5a3784811337@brauner>
References: <20240304182945.3646109-1-bvanassche@acm.org>
 <20240304193153.GC1195@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304193153.GC1195@sol.localdomain>

On Mon, Mar 04, 2024 at 11:31:53AM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 10:29:44AM -0800, Bart Van Assche wrote:
> > Patch "fs/aio: Make io_cancel() generate completions again" is based on the
> > assumption that calling kiocb->ki_cancel() does not complete R/W requests.
> > This is incorrect: the two drivers that call kiocb_set_cancel_fn() callers
> > set a cancellation function that calls usb_ep_dequeue(). According to its
> > documentation, usb_ep_dequeue() calls the completion routine with status
> > -ECONNRESET. Hence this revert.
> > 
> > Cc: Benjamin LaHaise <ben@communityfibre.ca>
> > Cc: Eric Biggers <ebiggers@google.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Avi Kivity <avi@scylladb.com>
> > Cc: Sandeep Dhavale <dhavale@google.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: stable@vger.kernel.org
> > Reported-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
> > Fixes: 54cbc058d86b ("fs/aio: Make io_cancel() generate completions again")
> > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > ---
> >  fs/aio.c | 27 ++++++++++++++++-----------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 28223f511931..da18dbcfcb22 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -2165,11 +2165,14 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
> >  #endif
> >  
> >  /* sys_io_cancel:
> > - *	Attempts to cancel an iocb previously passed to io_submit(). If the
> > - *	operation is successfully cancelled 0 is returned. May fail with
> > - *	-EFAULT if any of the data structures pointed to are invalid. May
> > - *	fail with -EINVAL if aio_context specified by ctx_id is invalid. Will
> > - *	fail with -ENOSYS if not implemented.
> > + *	Attempts to cancel an iocb previously passed to io_submit.  If
> > + *	the operation is successfully cancelled, the resulting event is
> > + *	copied into the memory pointed to by result without being placed
> > + *	into the completion queue and 0 is returned.  May fail with
> > + *	-EFAULT if any of the data structures pointed to are invalid.
> > + *	May fail with -EINVAL if aio_context specified by ctx_id is
> > + *	invalid.  May fail with -EAGAIN if the iocb specified was not
> > + *	cancelled.  Will fail with -ENOSYS if not implemented.
> >   */
> >  SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
> >  		struct io_event __user *, result)
> > @@ -2200,12 +2203,14 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
> >  	}
> >  	spin_unlock_irq(&ctx->ctx_lock);
> >  
> > -	/*
> > -	 * The result argument is no longer used - the io_event is always
> > -	 * delivered via the ring buffer.
> > -	 */
> > -	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
> > -		aio_complete_rw(&kiocb->rw, -EINTR);
> > +	if (!ret) {
> > +		/*
> > +		 * The result argument is no longer used - the io_event is
> > +		 * always delivered via the ring buffer. -EINPROGRESS indicates
> > +		 * cancellation is progress:
> > +		 */
> > +		ret = -EINPROGRESS;
> > +	}
> 
> Acked-by: Eric Biggers <ebiggers@google.com>
> 
> It does look like all the ->ki_cancel functions complete the request already, so
> this patch was unnecessary and just introduced a bug.
> 
> Note that IOCB_CMD_POLL installs a ->ki_cancel function too, and that's how
> syzbot hit the use-after-free so easily.
> 
> I assume that the patch just wasn't tested?  Or did you find that it actually
> fixed something (how)?

We've been wrestling aio cancellations for a while now and aimed to
actually remove it but apparently it's used in the wild. I still very
much prefer if we could finally nuke this code.

> 
> By the way, libaio (https://pagure.io/libaio) has a test suite for these system
> calls.  How about adding a test case that cancels an IOCB_CMD_POLL request and
> verifies that the completion event is received?

Yes, please.

