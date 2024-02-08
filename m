Return-Path: <linux-fsdevel+bounces-10858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FE84EB72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8632862B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B144F888;
	Thu,  8 Feb 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RfKjYLga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFCB4F60E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430490; cv=none; b=FI1NMouTlLF9tkBWF/Bx09r3MjnYRGVyD/nwpWGasEYi+EGUPzvAXhMtvEXJqw+Oi2fB7+61qmW95Gnd91TZ6NaULwNrYKJNMmEYDQ9W2y5l3fzeUQ4EmsRc4QNlU7A1Q4AIteW0IoDRs7FKNNIdF0VcSxLocMlp6d64roaS0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430490; c=relaxed/simple;
	bh=w2knZeJZbIQ0BuLwEt9Ja8H4MCay7UegxluvlLfoKkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6O1NB5NgYqORZ6YEiAfZOPp8pW6axceheuclTExJ7O7FiCJceYBqGEiqq7mVpkrk7uZ7JiKYD03uLh9gyxqwdlbud5KtQ21b4t0NI/wjNRcjBz8+MgRAa0u8/qzeAk2RDP+qbUfaTi3svIWkbYExcrM7sQz9Ol/Urqfjml8bYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RfKjYLga; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d722740622so521955ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 14:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707430486; x=1708035286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJZe3WKZAzGu9qi3wHAHmWxTGMVrYkJP/kqmcvUlp9Q=;
        b=RfKjYLga0ubAWl4wXOeuf0bL5SU//XRQl2Jdjkn/zEKRUqL6Rh6YkkDxwqAgNKYyRt
         MyEk8pwr09WHPTSX9QcYLXWyKQDu75SHCC7AQ72bCl9/wje27jM3pA06ey5lL84ttJT2
         qHIYDM9GuTXuXrZZZRK0ARj/a/3nhG5RUNu3sT/v/pPh2tbRESNZmgG1IUAgEPrfC/TH
         tRMsM1rE+8i8L8WxEptlUA++ZAb61tLn5iCNJsBDA/yO/ZnSGfJnyivtrsZs7kJReoKc
         7vX8vXw0HbDhC3q3Z+2vRcWX363jhBxdkOxXAMQwmmksQxE5+YKZTKDgBq2OONmXT9Ju
         LiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430486; x=1708035286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJZe3WKZAzGu9qi3wHAHmWxTGMVrYkJP/kqmcvUlp9Q=;
        b=Tio5uXmycWPZ0AgfPfRg0nAISFEKSyKy6F7USqgK6mvl+JBmyqqNXt5isgnjv7sbpF
         eGkLnnbspqUgaIy/l6FzxIY8waoIwuvYOvi0WFuC+ZUAXVfd0Eqxe06JRW0RaEMcvjsd
         xvrcm1xoXFucvZ0GiqVSldzV0/dZCY+v1bId6gcxngQrgY7eNCbHkDBd36ySl2H5YRf8
         dwS7N6BWvPSAizZ2BexwhpROaKQKu0MNBQDr6dcHGweMM+6EFHPtJzpDz0iANzdXkK3U
         N007BqMIMj5C/IfHKb9Xucoj6g3wsh2K/z4MvvfHoMrb71lGmJteUb/FKe7qchIDNGXK
         RNnw==
X-Gm-Message-State: AOJu0YwKYrRYIF4ZAM00YmTuqhsvRjqY8uR9wB+6UkZqPD5LIwhAdfbZ
	uBspHgg9bAXKh1hUbhxGtXNzTLzw7VUD6sMksw4EVzxF1GsR/OCnrtY+LE3fJng=
X-Google-Smtp-Source: AGHT+IHO3uSm9x85FQTGuBLYP4FxPnDzQsV1qS1Qs7g6KTcdcB/B4tgEPN2x11npTOHgu7ul8XhzdQ==
X-Received: by 2002:a17:903:22cf:b0:1d9:143:a254 with SMTP id y15-20020a17090322cf00b001d90143a254mr552425plg.2.1707430486535;
        Thu, 08 Feb 2024 14:14:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMldF9OJ+LXmKAUVCW2YFka69iOFryVLMcZkkeBW15KbtTqsws6PoOnIQ8NZ5zRUw6Kjp71J4piMiZrOntuY2MO7DKZKk867fk7oQKmrGQ1L0hMFgINADeD3FiBD3UZNhlLiBrwu133YVxK14vfCcRRojnFiYFmgCYgOnecw6XQgRQ1J32L8hC0NU6IHb5gHhQapCBbjbxN7rAcctucff+M47Cl66mM+KPuRtuId+dIUQ4fj3OU3CWtyZTKWVb885H
Received: from ?IPV6:2600:380:771a:2bff:256a:9053:7400:793f? ([2600:380:771a:2bff:256a:9053:7400:793f])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902e29200b001d8fb137a57sm263212plc.12.2024.02.08.14.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 14:14:46 -0800 (PST)
Message-ID: <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
Date: Thu, 8 Feb 2024 15:14:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20240208215518.1361570-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240208215518.1361570-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 2:55 PM, Bart Van Assche wrote:
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 6bff6cb93789..4837e3071263 100644
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
> @@ -1157,23 +1156,16 @@ ffs_epfile_open(struct inode *inode, struct file *file)
>  	return stream_open(inode, file);
>  }
>  
> -static int ffs_aio_cancel(struct kiocb *kiocb)
> +static void ffs_epfile_cancel_kiocb(struct kiocb *kiocb)
>  {
>  	struct ffs_io_data *io_data = kiocb->private;
>  	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
>  	unsigned long flags;
> -	int value;
>  
>  	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
> -
>  	if (io_data && io_data->ep && io_data->req)
> -		value = usb_ep_dequeue(io_data->ep, io_data->req);
> -	else
> -		value = -EINVAL;
> -
> +		usb_ep_dequeue(io_data->ep, io_data->req);
>  	spin_unlock_irqrestore(&epfile->ffs->eps_lock, flags);
> -
> -	return value;
>  }

I'm assuming the NULL checks can go because it's just the async parts
now?

> @@ -634,6 +619,8 @@ static void free_ioctx_reqs(struct percpu_ref *ref)
>  	queue_rcu_work(system_wq, &ctx->free_rwork);
>  }
>  
> +static void aio_cancel_and_del(struct aio_kiocb *req);
> +

Just move the function higher up? It doesn't have any dependencies.

> @@ -1552,6 +1538,24 @@ static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
>  	return __import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter, compat);
>  }
>  
> +static void aio_add_rw_to_active_reqs(struct kiocb *req)
> +{
> +	struct aio_kiocb *aio = container_of(req, struct aio_kiocb, rw);
> +	struct kioctx *ctx = aio->ki_ctx;
> +	unsigned long flags;
> +
> +	/*
> +	 * If the .cancel_kiocb() callback has been set, add the request
> +	 * to the list of active requests.
> +	 */
> +	if (!req->ki_filp->f_op->cancel_kiocb)
> +		return;
> +
> +	spin_lock_irqsave(&ctx->ctx_lock, flags);
> +	list_add_tail(&aio->ki_list, &ctx->active_reqs);
> +	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
> +}

This can use spin_lock_irq(), always called from process context.

> +/* Must be called only for IOCB_CMD_POLL requests. */
> +static void aio_poll_cancel(struct aio_kiocb *aiocb)
> +{
> +	struct poll_iocb *req = &aiocb->poll;
> +	struct kioctx *ctx = aiocb->ki_ctx;
> +
> +	lockdep_assert_held(&ctx->ctx_lock);
> +
> +	if (!poll_iocb_lock_wq(req))
> +		return;
> +
> +	WRITE_ONCE(req->cancelled, true);
> +	if (!req->work_scheduled) {
> +		schedule_work(&aiocb->poll.work);
> +		req->work_scheduled = true;
> +	}
> +	poll_iocb_unlock_wq(req);
> +}

Not your code, it's just moved, but this looks racy. Might not matter,
and obviously beyond the scope of this change.

> +{
> +	void (*cancel_kiocb)(struct kiocb *) =
> +		req->rw.ki_filp->f_op->cancel_kiocb;
> +	struct kioctx *ctx = req->ki_ctx;
> +
> +	lockdep_assert_held(&ctx->ctx_lock);
> +
> +	switch (req->ki_opcode) {
> +	case IOCB_CMD_PREAD:
> +	case IOCB_CMD_PWRITE:
> +	case IOCB_CMD_PREADV:
> +	case IOCB_CMD_PWRITEV:
> +		if (cancel_kiocb)
> +			cancel_kiocb(&req->rw);
> +		break;
> +	case IOCB_CMD_FSYNC:
> +	case IOCB_CMD_FDSYNC:
> +		break;
> +	case IOCB_CMD_POLL:
> +		aio_poll_cancel(req);
> +		break;
> +	default:
> +		WARN_ONCE(true, "invalid aio operation %d\n", req->ki_opcode);
> +	}
> +
> +	list_del_init(&req->ki_list);
> +}

Why don't you just keep ki_cancel() and just change it to a void return
that takes an aio_kiocb? Then you don't need this odd switch, or adding
an opcode field just for this. That seems cleaner.

Outside of these little nits, looks alright. I'd still love to kill the
silly cancel code just for the gadget bits, but that's for another day.
And since the gadget and aio code basically never changes, a cleaned up
variant of the this patch should be trivial enough to backport to
stable, so I don't think we need to worry about doing a fixup first.

-- 
Jens Axboe


