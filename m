Return-Path: <linux-fsdevel+bounces-25472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED4094C5F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99A42864FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 20:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994421553B7;
	Thu,  8 Aug 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="edSrbDYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E39460
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150211; cv=none; b=VNo5r1FlTYgEi3GolGVohhF4mx3lNdTedVvHRaX8zA5M1VisJPVnNtMurYEVQOVaw4QspL2tzcKb0f0+u/60OeCT1/fcUd+ph9d+kP9cMKoghZJu5tT0aPOzZtqxeBSykYbei0pjq7/yd0qBkoLSwfZdHcQU42NoJgEHVD8lQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150211; c=relaxed/simple;
	bh=wNTudCoa1Ym8bNN9ZkI23F3d4aO2s+usPfRNLEZ5Rx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SndaRC1w8zu9GKPsd6IBj4yHLOMJwBtuws00Rb7DGOvx1bFERZCANK6epP0ZDdTdnidEHwFpHg3GcXqmSzLZDpkwkAw4DirRxg+HyVOMHhJwhnI6ozQS0YKUbNwic5rQ6+eqpkYBMGMfyn0YVACEOTRCg2EZUqtPa6GUZ8vbmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=edSrbDYn; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so7535646d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 13:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723150208; x=1723755008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4gTYG6ykwcHfLDrnWcZVNQurGa8BI3H+OE7g2qsyMo=;
        b=edSrbDYnI5vLE69lXE/0P9ejMvKBcIgzvJyS9LKBO5oDUzaWQVjtxIJRQiREIVEJMW
         uMlnUdUQzCh0JWd5v+oVKSmgP7OrtrG2G3fbRRv0uuwHN7xaj0/7CtxB4scSfKtNRLSx
         R6S2zO6oppUzB7ex+k2k7pMK/rVUCKQkkaklrFMh0cyHwA8SD95/qhfV2SEwHXUkczPP
         ll21JZhVJW4O44pP3bwI8sF+L1I7QwtAV04ZsOYjR6lBR941/RRIekUIRvBDtT1xMOSr
         jOv/5i2kgBRiXPpGfGUk6TBwgyAwdzpe658BKaPF976MMPYmLfRQ0en5R+J6DThrZWk6
         HQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150208; x=1723755008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4gTYG6ykwcHfLDrnWcZVNQurGa8BI3H+OE7g2qsyMo=;
        b=OSZP4APN1i0RlT+w3Kxp+63SgBKe4+4rA8T69jE6t1snanmUWRHS38isgAqW+rZ1Od
         LIq0JeKvZxi7LiO9m7sdA2zy+hV10O3gs+7JfThxos8rS8eX+iVxRtDnssUaT3MYnwdr
         qaNa9xHgJMpVN8NXX4749QpmRu9cigB7N5PY7XSlBbuxzyqIjVYsytEtNtC8Kezh/3qR
         Vu5C6vTC9q1RaF0D7mkMWsmXl1X42214LK0ZwfFPW7pB+5ML7y14H9AIYG88yaB2bchn
         mYlhAZPFaeGjKH/82zBLsoeshgslIXqiQ0jo6D1hoKzGzxAB5+T27xC1ZohicBZr1FId
         PTdw==
X-Forwarded-Encrypted: i=1; AJvYcCUovQYmNlzJ0VwET3m5dqJ2poZHanC7/0pOrwJRGY+Up8CNRmHbtHjKcAK1//2TIHzbaDiUMo0DySkezhkwbE73VGYl4Y6B5U5s75V1VQ==
X-Gm-Message-State: AOJu0YwXLDX/ds6pu3ukIswQ13lFrHIZIqudTBfigBgIsomucoQqEDZ6
	q0pv3ZnYrMYJ2usABvf5k49LCXZkAUom50o9354r6Kaeibfx1q0tKTbw0TZ3U/2DIJ9QxXqpAry
	m
X-Google-Smtp-Source: AGHT+IGGcQDvHRCBLYDnN0xx69+IDFiclE+jDraOcE+YJxr6fgfp5fKfoON43USjJ2vhCEa2i0B45w==
X-Received: by 2002:a05:6214:5349:b0:6b5:ec9e:a80e with SMTP id 6a1803df08f44-6bd6bd807b1mr31836356d6.44.1723150208305;
        Thu, 08 Aug 2024 13:50:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c868b5asm69989526d6.117.2024.08.08.13.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:50:07 -0700 (PDT)
Date: Thu, 8 Aug 2024 16:50:06 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v3 1/2] fuse: add optional kernel-enforced timeout for
 requests
Message-ID: <20240808205006.GA625513@perftesting>
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
 <20240808190110.3188039-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808190110.3188039-2-joannelkoong@gmail.com>

On Thu, Aug 08, 2024 at 12:01:09PM -0700, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
> 
> This commit adds a timeout option (in seconds) for requests. If the
> timeout elapses before the server replies to the request, the request
> will fail with -ETIME.
> 
> There are 3 possibilities for a request that times out:
> a) The request times out before the request has been sent to userspace
> b) The request times out after the request has been sent to userspace
> and before it receives a reply from the server
> c) The request times out after the request has been sent to userspace
> and the server replies while the kernel is timing out the request
> 
> While a request timeout is being handled, there may be other handlers
> running at the same time if:
> a) the kernel is forwarding the request to the server
> b) the kernel is processing the server's reply to the request
> c) the request is being re-sent
> d) the connection is aborting
> e) the device is getting released
> 
> Proper synchronization must be added to ensure that the request is
> handled correctly in all of these cases. To this effect, there is a new
> FR_FINISHING bit added to the request flags, which is set atomically by
> either the timeout handler (see fuse_request_timeout()) which is invoked
> after the request timeout elapses or set by the request reply handler
> (see dev_do_write()), whichever gets there first. If the reply handler
> and the timeout handler are executing simultaneously and the reply handler
> sets FR_FINISHING before the timeout handler, then the request will be
> handled as if the timeout did not elapse. If the timeout handler sets
> FR_FINISHING before the reply handler, then the request will fail with
> -ETIME and the request will be cleaned up.
> 
> Currently, this is the refcount lifecycle of a request:
> 
> Synchronous request is created:
> fuse_simple_request -> allocates request, sets refcount to 1
>   __fuse_request_send -> acquires refcount
>     queues request and waits for reply...
> fuse_simple_request -> drops refcount
> 
> Background request is created:
> fuse_simple_background -> allocates request, sets refcount to 1
> 
> Request is replied to:
> fuse_dev_do_write
>   fuse_request_end -> drops refcount on request
> 
> Proper acquires on the request reference must be added to ensure that the
> timeout handler does not drop the last refcount on the request while
> other handlers may be operating on the request. Please note that the
> timeout handler may get invoked at any phase of the request's
> lifetime (eg before the request has been forwarded to userspace, etc).
> 
> It is always guaranteed that there is a refcount on the request when the
> timeout handler is executing. The timeout handler will be either
> deactivated by the reply/abort/release handlers, or if the timeout
> handler is concurrently executing on another CPU, the reply/abort/release
> handlers will wait for the timeout handler to finish executing first before
> it drops the final refcount on the request.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 197 +++++++++++++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h |  14 ++++
>  fs/fuse/inode.c  |   7 ++
>  3 files changed, 210 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..bcb9ff2156c0 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
>  
>  static struct kmem_cache *fuse_req_cachep;
>  
> +static void fuse_request_timeout(struct timer_list *timer);
> +
>  static struct fuse_dev *fuse_get_dev(struct file *file)
>  {
>  	/*
> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>  	refcount_set(&req->count, 1);
>  	__set_bit(FR_PENDING, &req->flags);
>  	req->fm = fm;
> +	if (fm->fc->req_timeout)
> +		timer_setup(&req->timer, fuse_request_timeout, 0);
>  }
>  
>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
> @@ -277,7 +281,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
>   * the 'end' callback is called if given, else the reference to the
>   * request is released
>   */
> -void fuse_request_end(struct fuse_req *req)
> +static void do_fuse_request_end(struct fuse_req *req)
>  {
>  	struct fuse_mount *fm = req->fm;
>  	struct fuse_conn *fc = fm->fc;
> @@ -296,8 +300,6 @@ void fuse_request_end(struct fuse_req *req)
>  		list_del_init(&req->intr_entry);
>  		spin_unlock(&fiq->lock);
>  	}
> -	WARN_ON(test_bit(FR_PENDING, &req->flags));
> -	WARN_ON(test_bit(FR_SENT, &req->flags));
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		spin_lock(&fc->bg_lock);
>  		clear_bit(FR_BACKGROUND, &req->flags);
> @@ -329,8 +331,104 @@ void fuse_request_end(struct fuse_req *req)
>  put_request:
>  	fuse_put_request(req);
>  }
> +
> +void fuse_request_end(struct fuse_req *req)
> +{
> +	WARN_ON(test_bit(FR_PENDING, &req->flags));
> +	WARN_ON(test_bit(FR_SENT, &req->flags));
> +
> +	if (req->timer.function)
> +		timer_delete_sync(&req->timer);

This becomes just timer_delete_sync();

> +
> +	do_fuse_request_end(req);
> +}
>  EXPORT_SYMBOL_GPL(fuse_request_end);
>  
> +static void timeout_inflight_req(struct fuse_req *req)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_pqueue *fpq;
> +
> +	spin_lock(&fiq->lock);
> +	fpq = req->fpq;
> +	spin_unlock(&fiq->lock);
> +
> +	/*
> +	 * If fpq has not been set yet, then the request is aborting (which
> +	 * clears FR_PENDING flag) before dev_do_read (which sets req->fpq)
> +	 * has been called. Let the abort handler handle this request.
> +	 */
> +	if (!fpq)
> +		return;
> +
> +	spin_lock(&fpq->lock);
> +	if (!fpq->connected || req->out.h.error == -ECONNABORTED) {
> +		/*
> +		 * Connection is being aborted or the fuse_dev is being released.
> +		 * The abort / release will clean up the request
> +		 */
> +		spin_unlock(&fpq->lock);
> +		return;
> +	}
> +
> +	if (!test_bit(FR_PRIVATE, &req->flags))
> +		list_del_init(&req->list);
> +
> +	spin_unlock(&fpq->lock);
> +
> +	req->out.h.error = -ETIME;
> +
> +	do_fuse_request_end(req);
> +}
> +
> +static void timeout_pending_req(struct fuse_req *req)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	bool background = test_bit(FR_BACKGROUND, &req->flags);
> +
> +	if (background)
> +		spin_lock(&fc->bg_lock);
> +	spin_lock(&fiq->lock);
> +
> +	if (!test_bit(FR_PENDING, &req->flags)) {
> +		spin_unlock(&fiq->lock);
> +		if (background)
> +			spin_unlock(&fc->bg_lock);
> +		timeout_inflight_req(req);
> +		return;
> +	}
> +
> +	if (!test_bit(FR_PRIVATE, &req->flags))
> +		list_del_init(&req->list);
> +
> +	spin_unlock(&fiq->lock);
> +	if (background)
> +		spin_unlock(&fc->bg_lock);
> +
> +	req->out.h.error = -ETIME;
> +
> +	do_fuse_request_end(req);
> +}
> +
> +static void fuse_request_timeout(struct timer_list *timer)
> +{
> +	struct fuse_req *req = container_of(timer, struct fuse_req, timer);
> +
> +	/*
> +	 * Request reply is being finished by the kernel right now.
> +	 * No need to time out the request.
> +	 */
> +	if (test_and_set_bit(FR_FINISHING, &req->flags))
> +		return;
> +
> +	if (test_bit(FR_PENDING, &req->flags))
> +		timeout_pending_req(req);
> +	else
> +		timeout_inflight_req(req);
> +}
> +
>  static int queue_interrupt(struct fuse_req *req)
>  {
>  	struct fuse_iqueue *fiq = &req->fm->fc->iq;
> @@ -393,6 +491,11 @@ static void request_wait_answer(struct fuse_req *req)
>  		if (test_bit(FR_PENDING, &req->flags)) {
>  			list_del(&req->list);
>  			spin_unlock(&fiq->lock);
> +			if (req->timer.function) {
> +				bool timed_out = !timer_delete_sync(&req->timer);
> +				if (timed_out)
> +					return;
> +			}

This can just be

	if (!timer_delete_sync(&req->timer))
		return;

>  			__fuse_put_request(req);
>  			req->out.h.error = -EINTR;
>  			return;
> @@ -409,7 +512,8 @@ static void request_wait_answer(struct fuse_req *req)
>  
>  static void __fuse_request_send(struct fuse_req *req)
>  {
> -	struct fuse_iqueue *fiq = &req->fm->fc->iq;
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
>  
>  	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
>  	spin_lock(&fiq->lock);
> @@ -421,6 +525,10 @@ static void __fuse_request_send(struct fuse_req *req)
>  		/* acquire extra reference, since request is still needed
>  		   after fuse_request_end() */
>  		__fuse_get_request(req);
> +		if (req->timer.function) {
> +			req->timer.expires = jiffies + fc->req_timeout;
> +			add_timer(&req->timer);
> +		}

This can just be

if (req->timer.function)
	mod_timer(&req->timer, jiffies + fc->req_timeout);

>  		queue_request_and_unlock(fiq, req);
>  
>  		request_wait_answer(req);
> @@ -539,6 +647,10 @@ static bool fuse_request_queue_background(struct fuse_req *req)
>  		if (fc->num_background == fc->max_background)
>  			fc->blocked = 1;
>  		list_add_tail(&req->list, &fc->bg_queue);
> +		if (req->timer.function) {
> +			req->timer.expires = jiffies + fc->req_timeout;
> +			add_timer(&req->timer);
> +		}

Same comment as above.

>  		flush_bg_queue(fc);
>  		queued = true;
>  	}
> @@ -594,6 +706,10 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>  
>  	spin_lock(&fiq->lock);
>  	if (fiq->connected) {
> +		if (req->timer.function) {
> +			req->timer.expires = jiffies + fm->fc->req_timeout;
> +			add_timer(&req->timer);
> +		}

Here as well.

>  		queue_request_and_unlock(fiq, req);
>  	} else {
>  		err = -ENODEV;
> @@ -1268,8 +1384,26 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	req = list_entry(fiq->pending.next, struct fuse_req, list);
>  	clear_bit(FR_PENDING, &req->flags);
>  	list_del_init(&req->list);
> +	/* Acquire a reference in case the timeout handler starts executing */
> +	__fuse_get_request(req);
> +	req->fpq = fpq;
>  	spin_unlock(&fiq->lock);
>  
> +	if (req->timer.function) {
> +		/*
> +		 * Temporarily disable the timer on the request to avoid race
> +		 * conditions between this code and the timeout handler.
> +		 *
> +		 * The timer is readded at the end of this function.
> +		 */
> +		bool timed_out = !timer_delete_sync(&req->timer);
> +		if (timed_out) {

This can also just be

if (!timer_delete_sync(&req->timer));

> +			WARN_ON(!test_bit(FR_FINISHED, &req->flags));
> +			fuse_put_request(req);
> +			goto restart;
> +		}
> +	}
> +
>  	args = req->args;
>  	reqsize = req->in.h.len;
>  
> @@ -1280,6 +1414,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  		if (args->opcode == FUSE_SETXATTR)
>  			req->out.h.error = -E2BIG;
>  		fuse_request_end(req);
> +		fuse_put_request(req);
>  		goto restart;
>  	}
>  	spin_lock(&fpq->lock);
> @@ -1316,13 +1451,18 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	}
>  	hash = fuse_req_hash(req->in.h.unique);
>  	list_move_tail(&req->list, &fpq->processing[hash]);
> -	__fuse_get_request(req);
>  	set_bit(FR_SENT, &req->flags);
> +
> +	/* re-arm the original timer */
> +	if (req->timer.function)
> +		add_timer(&req->timer);

This will not change anything if the timer was already armed, do you want
mod_timer_pending() here?  Or maybe just mod_timer()?  Thanks,

Josef

