Return-Path: <linux-fsdevel+bounces-10580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBBB84C6BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562F4286E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA22208C0;
	Wed,  7 Feb 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j175X5LG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03339208BE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296209; cv=none; b=hoQjpw7N/gM0lAcJ2Q3S+q+/IczQHnPpalpLD1O5dnb6+gp8hHpFTmslRPgoqea4E5SSwKMoIGAHB/QazgXQq8+OcGBOGs/RpSr5hjShRe3qkog0fuwgJl0SqJXKoNBYmaOthqthyKei793/pS3mBqgifLdTBgdlbhayojUmZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296209; c=relaxed/simple;
	bh=zIu+a2OfnFWRtNPvkRGkt1cfiJda4JfhDb5l9Ds4EXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCG92z+bR/cqKlXURUcrAXs3KHMYOc8loDargn0dMPileN3TLJ8QXwpvX5VylNEwnfPZMBnG8U6MSH/PyOeXY6/MlhDn6mEjGRMPP/uRW8FNyw34NIDwIeVevzymnpWSBsek3ZQpAPwt1o/F6q8A+tvM0urTYix6kLv4X63iYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j175X5LG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D28C433F1;
	Wed,  7 Feb 2024 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707296208;
	bh=zIu+a2OfnFWRtNPvkRGkt1cfiJda4JfhDb5l9Ds4EXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j175X5LGScs5+vtDTqRbg+B34rs/W5mNpdumUTjok0CK8/NJdimYcQQhOT3rwOvE/
	 A79Jhx5vJcWmkrUPwUgi1LbPpmOepfe1lRRtqubaBTgJ+3PIXrUgC0giqvbIzSd+Su
	 5fFs9CZEodqY2hdkvySHw02ymb1Kc9JEIhHDdPfXhAYvIG2W5zid7UwAScRbY8ppYr
	 qyqiGxqsBwhqlog/Tp/RWvbbsLZJ9HoDUWB5KOO9ni11b8V99Wsl6h+Pxnz81RMRuE
	 t6+za+mypLQ4HavRVFKwjEnpRthsT7MOXre8DyicBYEESODqXvtDGV/FBiSp2ihrJ9
	 xO+Rmrkmx/jnQ==
Date: Wed, 7 Feb 2024 09:56:43 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>, 
	Sandeep Dhavale <dhavale@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fs, USB gadget: Rework kiocb cancellation
Message-ID: <20240207-geliebt-badeort-a81cde648cfc@brauner>
References: <20240206234718.1437772-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206234718.1437772-1-bvanassche@acm.org>

On Tue, Feb 06, 2024 at 03:47:18PM -0800, Bart Van Assche wrote:
> Calling kiocb_set_cancel_fn() without knowing whether the caller
> submitted a struct kiocb or a struct aio_kiocb is unsafe. Fix this by
> introducing the cancel_kiocb() method in struct file_operations. The
> following call trace illustrates that without this patch an
> out-of-bounds write happens if I/O is submitted by io_uring (from a
> phone with an ARM CPU and kernel 6.1):
> 
> WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
> Call trace:
>  kiocb_set_cancel_fn+0x9c/0xa8
>  ffs_epfile_read_iter+0x144/0x1d0
>  io_read+0x19c/0x498
>  io_issue_sqe+0x118/0x27c
>  io_submit_sqes+0x25c/0x5fc
>  __arm64_sys_io_uring_enter+0x104/0xab0
>  invoke_syscall+0x58/0x11c
>  el0_svc_common+0xb4/0xf4
>  do_el0_svc+0x2c/0xb0
>  el0_svc+0x2c/0xa4
>  el0t_64_sync_handler+0x68/0xb4
>  el0t_64_sync+0x1a4/0x1a8
> 
> The following patch has been used as the basis of this patch: Christoph
> Hellwig, "[PATCH 08/32] aio: replace kiocb_set_cancel_fn with a
> cancel_kiocb file operation", May 2018
> (https://lore.kernel.org/all/20180515194833.6906-9-hch@lst.de/).

What's changed that voids Al's objections on that patch from 2018?
Specifically
https://lore.kernel.org/all/20180406021553.GS30522@ZenIV.linux.org.uk
https://lore.kernel.org/all/20180520052720.GY30522@ZenIV.linux.org.uk

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Sandeep Dhavale <dhavale@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/usb/gadget/function/f_fs.c | 10 +---
>  drivers/usb/gadget/legacy/inode.c  |  5 +-
>  fs/aio.c                           | 93 +++++++++++++++++-------------
>  include/linux/aio.h                |  7 ---
>  include/linux/fs.h                 |  1 +
>  include/linux/mm.h                 |  5 ++
>  include/linux/mm_inline.h          |  5 ++
>  7 files changed, 68 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 6bff6cb93789..adc00689fe3b 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -31,7 +31,6 @@
>  #include <linux/usb/composite.h>
>  #include <linux/usb/functionfs.h>
>  
> -#include <linux/aio.h>
>  #include <linux/kthread.h>
>  #include <linux/poll.h>
>  #include <linux/eventfd.h>
> @@ -1157,7 +1156,7 @@ ffs_epfile_open(struct inode *inode, struct file *file)
>  	return stream_open(inode, file);
>  }
>  
> -static int ffs_aio_cancel(struct kiocb *kiocb)
> +static int ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
>  {
>  	struct ffs_io_data *io_data = kiocb->private;
>  	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
> @@ -1198,9 +1197,6 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
>  
>  	kiocb->private = p;
>  
> -	if (p->aio)
> -		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
> -
>  	res = ffs_epfile_io(kiocb->ki_filp, p);
>  	if (res == -EIOCBQUEUED)
>  		return res;
> @@ -1242,9 +1238,6 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
>  
>  	kiocb->private = p;
>  
> -	if (p->aio)
> -		kiocb_set_cancel_fn(kiocb, ffs_aio_cancel);
> -
>  	res = ffs_epfile_io(kiocb->ki_filp, p);
>  	if (res == -EIOCBQUEUED)
>  		return res;
> @@ -1356,6 +1349,7 @@ static const struct file_operations ffs_epfile_operations = {
>  	.release =	ffs_epfile_release,
>  	.unlocked_ioctl =	ffs_epfile_ioctl,
>  	.compat_ioctl = compat_ptr_ioctl,
> +	.cancel_kiocb = ffs_epfile_cancel_kiocb,
>  };
>  
>  
> diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
> index 03179b1880fd..a4c03cfb3baa 100644
> --- a/drivers/usb/gadget/legacy/inode.c
> +++ b/drivers/usb/gadget/legacy/inode.c
> @@ -22,7 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/poll.h>
>  #include <linux/kthread.h>
> -#include <linux/aio.h>
>  #include <linux/uio.h>
>  #include <linux/refcount.h>
>  #include <linux/delay.h>
> @@ -446,7 +445,7 @@ struct kiocb_priv {
>  	unsigned		actual;
>  };
>  
> -static int ep_aio_cancel(struct kiocb *iocb)
> +static int ep_cancel_kiocb(struct kiocb *iocb)
>  {
>  	struct kiocb_priv	*priv = iocb->private;
>  	struct ep_data		*epdata;
> @@ -537,7 +536,6 @@ static ssize_t ep_aio(struct kiocb *iocb,
>  	iocb->private = priv;
>  	priv->iocb = iocb;
>  
> -	kiocb_set_cancel_fn(iocb, ep_aio_cancel);
>  	get_ep(epdata);
>  	priv->epdata = epdata;
>  	priv->actual = 0;
> @@ -709,6 +707,7 @@ static const struct file_operations ep_io_operations = {
>  	.unlocked_ioctl = ep_ioctl,
>  	.read_iter =	ep_read_iter,
>  	.write_iter =	ep_write_iter,
> +	.cancel_kiocb = ep_cancel_kiocb,
>  };
>  
>  /* ENDPOINT INITIALIZATION
> diff --git a/fs/aio.c b/fs/aio.c
> index bb2ff48991f3..0b13d6be773d 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -203,7 +203,6 @@ struct aio_kiocb {
>  	};
>  
>  	struct kioctx		*ki_ctx;
> -	kiocb_cancel_fn		*ki_cancel;
>  
>  	struct io_event		ki_res;
>  
> @@ -587,22 +586,6 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  #define AIO_EVENTS_FIRST_PAGE	((PAGE_SIZE - sizeof(struct aio_ring)) / sizeof(struct io_event))
>  #define AIO_EVENTS_OFFSET	(AIO_EVENTS_PER_PAGE - AIO_EVENTS_FIRST_PAGE)
>  
> -void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
> -{
> -	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
> -	struct kioctx *ctx = req->ki_ctx;
> -	unsigned long flags;
> -
> -	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
> -		return;
> -
> -	spin_lock_irqsave(&ctx->ctx_lock, flags);
> -	list_add_tail(&req->ki_list, &ctx->active_reqs);
> -	req->ki_cancel = cancel;
> -	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> -}
> -EXPORT_SYMBOL(kiocb_set_cancel_fn);
> -
>  /*
>   * free_ioctx() should be RCU delayed to synchronize against the RCU
>   * protected lookup_ioctx() and also needs process context to call
> @@ -634,6 +617,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
>  	queue_rcu_work(system_wq, &ctx->free_rwork);
>  }
>  
> +static void aio_cancel_and_del(struct aio_kiocb *req);
> +
>  /*
>   * When this function runs, the kioctx has been removed from the "hash table"
>   * and ctx->users has dropped to 0, so we know no more kiocbs can be submitted -
> @@ -649,8 +634,7 @@ static void free_ioctx_users(struct percpu_ref *ref)
>  	while (!list_empty(&ctx->active_reqs)) {
>  		req = list_first_entry(&ctx->active_reqs,
>  				       struct aio_kiocb, ki_list);
> -		req->ki_cancel(&req->rw);
> -		list_del_init(&req->ki_list);
> +		aio_cancel_and_del(req);
>  	}
>  
>  	spin_unlock_irq(&ctx->ctx_lock);
> @@ -1556,6 +1540,20 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
>  {
>  	switch (ret) {
>  	case -EIOCBQUEUED:
> +		/*
> +		 * If the .cancel_kiocb() callback has been set, add the request
> +		 * to the list of active requests.
> +		 */
> +		if (req->ki_filp->f_op->cancel_kiocb) {
> +			struct aio_kiocb *iocb =
> +				container_of(req, struct aio_kiocb, rw);
> +			struct kioctx *ctx = iocb->ki_ctx;
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&ctx->ctx_lock, flags);
> +			list_add_tail(&iocb->ki_list, &ctx->active_reqs);
> +			spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> +		}
>  		break;
>  	case -ERESTARTSYS:
>  	case -ERESTARTNOINTR:
> @@ -1715,6 +1713,41 @@ static void poll_iocb_unlock_wq(struct poll_iocb *req)
>  	rcu_read_unlock();
>  }
>  
> +/* assumes we are called with irqs disabled */
> +static int aio_poll_cancel(struct aio_kiocb *aiocb)
> +{
> +	struct poll_iocb *req = &aiocb->poll;
> +	struct kioctx *ctx = aiocb->ki_ctx;
> +
> +	lockdep_assert_held(&ctx->ctx_lock);
> +
> +	if (!poll_iocb_lock_wq(req)) {
> +		/* Not a polled request or already cancelled. */
> +		return 0;
> +	}
> +
> +	WRITE_ONCE(req->cancelled, true);
> +	if (!req->work_scheduled) {
> +		schedule_work(&aiocb->poll.work);
> +		req->work_scheduled = true;
> +	}
> +	poll_iocb_unlock_wq(req);
> +
> +	return 0;
> +}
> +
> +static void aio_cancel_and_del(struct aio_kiocb *req)
> +{
> +	struct kioctx *ctx = req->ki_ctx;
> +
> +	lockdep_assert_held(&ctx->ctx_lock);
> +
> +	if (req->rw.ki_filp->f_op->cancel_kiocb)
> +		req->rw.ki_filp->f_op->cancel_kiocb(&req->rw);
> +	aio_poll_cancel(req);
> +	list_del_init(&req->ki_list);
> +}
> +
>  static void aio_poll_complete_work(struct work_struct *work)
>  {
>  	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
> @@ -1760,24 +1793,6 @@ static void aio_poll_complete_work(struct work_struct *work)
>  	iocb_put(iocb);
>  }
>  
> -/* assumes we are called with irqs disabled */
> -static int aio_poll_cancel(struct kiocb *iocb)
> -{
> -	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
> -	struct poll_iocb *req = &aiocb->poll;
> -
> -	if (poll_iocb_lock_wq(req)) {
> -		WRITE_ONCE(req->cancelled, true);
> -		if (!req->work_scheduled) {
> -			schedule_work(&aiocb->poll.work);
> -			req->work_scheduled = true;
> -		}
> -		poll_iocb_unlock_wq(req);
> -	} /* else, the request was force-cancelled by POLLFREE already */
> -
> -	return 0;
> -}
> -
>  static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>  		void *key)
>  {
> @@ -1945,7 +1960,6 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>  			 * active_reqs so that it can be cancelled if needed.
>  			 */
>  			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
> -			aiocb->ki_cancel = aio_poll_cancel;
>  		}
>  		if (on_queue)
>  			poll_iocb_unlock_wq(req);
> @@ -2189,8 +2203,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>  	/* TODO: use a hash or array, this sucks. */
>  	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
>  		if (kiocb->ki_res.obj == obj) {
> -			ret = kiocb->ki_cancel(&kiocb->rw);
> -			list_del_init(&kiocb->ki_list);
> +			aio_cancel_and_del(kiocb);
>  			break;
>  		}
>  	}
> diff --git a/include/linux/aio.h b/include/linux/aio.h
> index 86892a4fe7c8..2aa6d0be3171 100644
> --- a/include/linux/aio.h
> +++ b/include/linux/aio.h
> @@ -4,20 +4,13 @@
>  
>  #include <linux/aio_abi.h>
>  
> -struct kioctx;
> -struct kiocb;
>  struct mm_struct;
>  
> -typedef int (kiocb_cancel_fn)(struct kiocb *);
> -
>  /* prototypes */
>  #ifdef CONFIG_AIO
>  extern void exit_aio(struct mm_struct *mm);
> -void kiocb_set_cancel_fn(struct kiocb *req, kiocb_cancel_fn *cancel);
>  #else
>  static inline void exit_aio(struct mm_struct *mm) { }
> -static inline void kiocb_set_cancel_fn(struct kiocb *req,
> -				       kiocb_cancel_fn *cancel) { }
>  #endif /* CONFIG_AIO */
>  
>  #endif /* __LINUX__AIO_H */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ed5966a70495..36cd982c167d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2021,6 +2021,7 @@ struct file_operations {
>  	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
>  	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>  				unsigned int poll_flags);
> +	int (*cancel_kiocb)(struct kiocb *);
>  } __randomize_layout;
>  
>  /* Wrap a directory iterator that needs exclusive inode access */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f5a97dec5169..7c05464c0ad0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1092,6 +1092,11 @@ static inline unsigned int folio_order(struct folio *folio)
>  	return folio->_flags_1 & 0xff;
>  }
>  
> +/*
> + * Include <linux/fs.h> to work around a circular dependency between
> + * <linux/fs.h> and <linux/huge_mm.h>.
> + */
> +#include <linux/fs.h>
>  #include <linux/huge_mm.h>
>  
>  /*
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index f4fe593c1400..4eb96f08ec4f 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -3,6 +3,11 @@
>  #define LINUX_MM_INLINE_H
>  
>  #include <linux/atomic.h>
> +/*
> + * Include <linux/fs.h> to work around a circular dependency between
> + * <linux/fs.h> and <linux/huge_mm.h>.
> + */
> +#include <linux/fs.h>
>  #include <linux/huge_mm.h>
>  #include <linux/mm_types.h>
>  #include <linux/swap.h>

