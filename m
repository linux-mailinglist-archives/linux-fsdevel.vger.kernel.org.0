Return-Path: <linux-fsdevel+bounces-10884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A884F251
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09ACDB211E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB88679E2;
	Fri,  9 Feb 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1j0i4e/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65618339AE;
	Fri,  9 Feb 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471298; cv=none; b=ciqsn6pv8QvtS41tBkIetNSosOJNJHrqJ5ZXEx8w4PHLP+9Fp2WAAPrISwAqgxW6l1NOmyTaO3UuV/+zIb9/Y5axF5tvFFH+PEWXaBY7i0t+zvMM/iONQuiX3OssfT9HvXzcHAQdGwjQB/d5y27/DjyNZgynnHmlHKwEqCNll88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471298; c=relaxed/simple;
	bh=Dl8+7wqvbWf28CAnnHsxj1BPsEuDTnBPdGgGo5EbXqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQDm/ypSGOhg2hWvB71Wem1Gzvd6K9obJVkxCsYXdsU3NGsVEzQFj2sVRtUY+lf1fi0xw1NqqfO0o3jHn1bBNuCCo2fzSwgTI6xt+Xe2d2Kud50680O1OVsjCxP8Q6V6HrR3vXWYNEx5tf9Vxmh2Hx8WYKGdyxOlclNrV1X3ABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1j0i4e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21139C433C7;
	Fri,  9 Feb 2024 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707471297;
	bh=Dl8+7wqvbWf28CAnnHsxj1BPsEuDTnBPdGgGo5EbXqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1j0i4e/4Pe2gBfUglOh5E7B1BX/SEOvUO+84VHkhvPbcz1jK/H6+phGQloEwtq8T
	 I9OjvsyNJWg17T8kzVrGtN3yxJTxbdviGqDUzrZP48XxXRWLToYbaqk+Od7ScY36Lm
	 H0VNiyBuS6OPv+CcjiKYBwBzRNagEJoxh88605IV6K/4QXklvf/+LIMRmf7eCdgM9M
	 e1yW24mkkZfrbzvAwyxX+eZFztt7e43TqCAYkHkB3CjpcZTsw6jhulFUfAbH7wS/JE
	 QItO9UI+yH2W3walP7dU9RMm2SA5+vXodKZX8wqZqvHexQVBY1V9Q8KjG9KLx6y9Lv
	 y0dpIqEZS5ACg==
Date: Fri, 9 Feb 2024 10:34:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Message-ID: <20240209-katapultieren-lastkraftwagen-d28bbc0a92b2@brauner>
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>

On Thu, Feb 08, 2024 at 03:14:43PM -0700, Jens Axboe wrote:
> On 2/8/24 2:55 PM, Bart Van Assche wrote:
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> > index 6bff6cb93789..4837e3071263 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -31,7 +31,6 @@
> >  #include <linux/usb/composite.h>
> >  #include <linux/usb/functionfs.h>
> >  
> > -#include <linux/aio.h>
> >  #include <linux/kthread.h>
> >  #include <linux/poll.h>
> >  #include <linux/eventfd.h>
> > @@ -1157,23 +1156,16 @@ ffs_epfile_open(struct inode *inode, struct file *file)
> >  	return stream_open(inode, file);
> >  }
> >  
> > -static int ffs_aio_cancel(struct kiocb *kiocb)
> > +static void ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
> >  {
> >  	struct ffs_io_data *io_data = kiocb->private;
> >  	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
> >  	unsigned long flags;
> > -	int value;
> >  
> >  	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
> > -
> >  	if (io_data && io_data->ep && io_data->req)
> > -		value = usb_ep_dequeue(io_data->ep, io_data->req);
> > -	else
> > -		value = -EINVAL;
> > -
> > +		usb_ep_dequeue(io_data->ep, io_data->req);
> >  	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
> > -
> > -	return value;
> >  }
> 
> I'm assuming the NULL checks can go because it's just the async parts
> now?
> 
> > @@ -634,6 +619,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
> >  	queue_rcu_work(system_wq, &ctx->free_rwork);
> >  }
> >  
> > +static void aio_cancel_and_del(struct aio_kiocb *req);
> > +
> 
> Just move the function higher up? It doesn't have any dependencies.
> 
> > @@ -1552,6 +1538,24 @@ static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
> >  	return __import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter, compat);
> >  }
> >  
> > +static void aio_add_rw_to_active_reqs(struct kiocb *req)
> > +{
> > +	struct aio_kiocb *aio = container_of(req, struct aio_kiocb, rw);
> > +	struct kioctx *ctx = aio->ki_ctx;
> > +	unsigned long flags;
> > +
> > +	/*
> > +	 * If the .cancel_kiocb() callback has been set, add the request
> > +	 * to the list of active requests.
> > +	 */
> > +	if (!req->ki_filp->f_op->cancel_kiocb)
> > +		return;
> > +
> > +	spin_lock_irqsave(&ctx->ctx_lock, flags);
> > +	list_add_tail(&aio->ki_list, &ctx->active_reqs);
> > +	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> > +}
> 
> This can use spin_lock_irq(), always called from process context.
> 
> > +/* Must be called only for IOCB_CMD_POLL requests. */
> > +static void aio_poll_cancel(struct aio_kiocb *aiocb)
> > +{
> > +	struct poll_iocb *req = &aiocb->poll;
> > +	struct kioctx *ctx = aiocb->ki_ctx;
> > +
> > +	lockdep_assert_held(&ctx->ctx_lock);
> > +
> > +	if (!poll_iocb_lock_wq(req))
> > +		return;
> > +
> > +	WRITE_ONCE(req->cancelled, true);
> > +	if (!req->work_scheduled) {
> > +		schedule_work(&aiocb->poll.work);
> > +		req->work_scheduled = true;
> > +	}
> > +	poll_iocb_unlock_wq(req);
> > +}
> 
> Not your code, it's just moved, but this looks racy. Might not matter,
> and obviously beyond the scope of this change.
> 
> > +{
> > +	void (*cancel_kiocb)(struct kiocb *) =
> > +		req->rw.ki_filp->f_op->cancel_kiocb;
> > +	struct kioctx *ctx = req->ki_ctx;
> > +
> > +	lockdep_assert_held(&ctx->ctx_lock);
> > +
> > +	switch (req->ki_opcode) {
> > +	case IOCB_CMD_PREAD:
> > +	case IOCB_CMD_PWRITE:
> > +	case IOCB_CMD_PREADV:
> > +	case IOCB_CMD_PWRITEV:
> > +		if (cancel_kiocb)
> > +			cancel_kiocb(&req->rw);
> > +		break;
> > +	case IOCB_CMD_FSYNC:
> > +	case IOCB_CMD_FDSYNC:
> > +		break;
> > +	case IOCB_CMD_POLL:
> > +		aio_poll_cancel(req);
> > +		break;
> > +	default:
> > +		WARN_ONCE(true, "invalid aio operation %d\n", req->ki_opcode);
> > +	}
> > +
> > +	list_del_init(&req->ki_list);
> > +}
> 
> Why don't you just keep ki_cancel() and just change it to a void return
> that takes an aio_kiocb? Then you don't need this odd switch, or adding
> an opcode field just for this. That seems cleaner.
> 
> Outside of these little nits, looks alright. I'd still love to kill the
> silly cancel code just for the gadget bits, but that's for another day.

Well, I'd prefer to kill it if we can asap. Because then we can lose
that annoying file_operations addition. That really rubs me the wrong way.

> And since the gadget and aio code basically never changes, a cleaned up
> variant of the this patch should be trivial enough to backport to
> stable, so I don't think we need to worry about doing a fixup first.

