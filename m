Return-Path: <linux-fsdevel+bounces-20589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAFB8D53E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4F21C2253D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1451A6A8D2;
	Thu, 30 May 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yzKgblgA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1118641
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717101176; cv=none; b=hJzB4tfaeHAQ3e+4wAHGIl43VyN08XYWHQB37i4Axc0SDCV/WfaxWK+MhDSSW9VA/4RPY+WGCzsHVDxHQ5N+gR2YXrD3ttt0TCW0kM1gNm++XWq0w31MgHQdbPBM2UBXEKdb3rHa08VCO4imEMHs0tj/xZD9TdQCfTdYymzJZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717101176; c=relaxed/simple;
	bh=2gEWGeYcOB+AXB/Lmj6IwDcvK4u2nGGaM+/yNYCAQJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9Z28ILFvoGcgDW2HokcVitjl6ld1gkQf139nr8HiCjDX3v0r6SpgO0ms8SleahX4we8H2T3qJH6XheROsUkot2ym95zD5RqepOHDGuRvwe3MUb9lLRKzf3nApPr+A8X/Sk+ZTysSC5liGWN3Y4sGqGzOnbrbJkAPMQcWw5Xfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yzKgblgA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43fd2809723so6594921cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717101173; x=1717705973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAN5ygfOWr5KC+oYo+Hy+L3m4xbm+0RzTx2uKNaehf8=;
        b=yzKgblgAkc8WPLnFG9mumFhIq1IvZgc47DDWQ14jBxlGyWSXyW4ZISoGwMKAXybVJD
         O/9TFcV/VSMNl2w6f9F9q/LgfIBYxXbaYI2LtOmsgEwUvgFbDoHSv6JkwXQfv7pC7Xlc
         G0fd7O4GCplUbsbkvTFg/WVWyk/m4/PeeKsx0Gy+T22QYsbyAbS6GtmCbu62tIs8qmAz
         zTGbqpTbK5ZNwZEFayZaTiAWbEJZLfBf8WcskxOjqNmOrMLv++Z8TMaVSf3XfQ9jcZiW
         NhsPUilhwKgQbCpqMlcKi0Yb4c0S1tZfJvrIke/XDbF22/73/Qvn3xeDvM6qr8P3HpJg
         0Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717101173; x=1717705973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAN5ygfOWr5KC+oYo+Hy+L3m4xbm+0RzTx2uKNaehf8=;
        b=k5qc2hAw1i2dQyP31k3piLTM4w7AcxZDkbXli9178x9HipprrfC7fVmv048mPX5YCo
         q9Unf3FAjKiss8gNLSH0in6Rx1LxOrOdIkZiVxHbYHqyhkIBdosORODcTF1QY61tPTxj
         0T0wUf+Uhip/Et8M+FA2hzAUKN2hV9eIVEp/0xH3OQDJJ79I6b/39+7NWE4/f1dGcCHj
         8D6xrzPs3QA29b1ASFSCDq24oDTY0ulISOEratTv9gfnwgFBpf57ch1SssAHyoHuEX4e
         /IeyQpC6rXc/txPY+fyqS0egm0EN1+h4pbi3XqNMdHYGNg+JQNjcduodUR/dDM71Ibdf
         GO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOcPdmPOn+BFOgQE9sTrRIaj/1wzDq/XnExa7FQeQ4t+eReqELIhoETwUBgAhmM6sM1FiLlVMdTDxByOxfe1N1i7vvYf1us/IT/Kv62Q==
X-Gm-Message-State: AOJu0YyfbuP0F8BzMj2ULmuuABX6brwvbiQlwsEw4HAs6Jw+x4XflFNY
	ZcXC0ZAeG/A38yzjHwIbBbiUlyTNASk1m7K2cruQKgb+q5XQCUq5swbJZpwuVLI=
X-Google-Smtp-Source: AGHT+IHfOzc/Lq85dNH3uGT2IbA+bNqmbF/TBZEjxz88sOji1FjZUSqZqHD2LfYGtCKGkR+KRq2VEw==
X-Received: by 2002:a05:622a:83:b0:43a:deee:a5ea with SMTP id d75a77b69052e-43fe92abf37mr32400501cf.13.1717101173267;
        Thu, 30 May 2024 13:32:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23bfaf9sm1539771cf.27.2024.05.30.13.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 13:32:52 -0700 (PDT)
Date: Thu, 30 May 2024 16:32:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 14/19] fuse: {uring} Allow to queue to the ring
Message-ID: <20240530203251.GF2210558@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-14-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-14-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:49PM +0200, Bernd Schubert wrote:
> This enables enqueuing requests through fuse uring queues.
> 
> For initial simplicity requests are always allocated the normal way
> then added to ring queues lists and only then copied to ring queue
> entries. Later on the allocation and adding the requests to a list
> can be avoided, by directly using a ring entry. This introduces
> some code complexity and is therefore not done for now.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c         | 80 +++++++++++++++++++++++++++++++++++++++-----
>  fs/fuse/dev_uring.c   | 92 ++++++++++++++++++++++++++++++++++++++++++---------
>  fs/fuse/dev_uring_i.h | 17 ++++++++++
>  3 files changed, 165 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6ffd216b27c8..c7fd3849a105 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -218,13 +218,29 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
>  };
>  EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
>  
> -static void queue_request_and_unlock(struct fuse_iqueue *fiq,
> -				     struct fuse_req *req)
> +
> +static void queue_request_and_unlock(struct fuse_conn *fc,
> +				     struct fuse_req *req, bool allow_uring)
>  __releases(fiq->lock)
>  {
> +	struct fuse_iqueue *fiq = &fc->iq;
> +
>  	req->in.h.len = sizeof(struct fuse_in_header) +
>  		fuse_len_args(req->args->in_numargs,
>  			      (struct fuse_arg *) req->args->in_args);
> +
> +	if (allow_uring && fuse_uring_ready(fc)) {
> +		int res;
> +
> +		/* this lock is not needed at all for ring req handling */
> +		spin_unlock(&fiq->lock);
> +		res = fuse_uring_queue_fuse_req(fc, req);
> +		if (!res)
> +			return;
> +
> +		/* fallthrough, handled through /dev/fuse read/write */

We need the lock here because we're modifying &fiq->pending, this will end in
tears.

> +	}
> +
>  	list_add_tail(&req->list, &fiq->pending);
>  	fiq->ops->wake_pending_and_unlock(fiq);
>  }
> @@ -261,7 +277,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
>  		fc->active_background++;
>  		spin_lock(&fiq->lock);
>  		req->in.h.unique = fuse_get_unique(fiq);
> -		queue_request_and_unlock(fiq, req);
> +		queue_request_and_unlock(fc, req, true);
>  	}
>  }
>  
> @@ -405,7 +421,8 @@ static void request_wait_answer(struct fuse_req *req)
>  
>  static void __fuse_request_send(struct fuse_req *req)
>  {
> -	struct fuse_iqueue *fiq = &req->fm->fc->iq;
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
>  
>  	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
>  	spin_lock(&fiq->lock);
> @@ -417,7 +434,7 @@ static void __fuse_request_send(struct fuse_req *req)
>  		/* acquire extra reference, since request is still needed
>  		   after fuse_request_end() */
>  		__fuse_get_request(req);
> -		queue_request_and_unlock(fiq, req);
> +		queue_request_and_unlock(fc, req, true);
>  
>  		request_wait_answer(req);
>  		/* Pairs with smp_wmb() in fuse_request_end() */
> @@ -487,6 +504,10 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
>  	if (args->force) {
>  		atomic_inc(&fc->num_waiting);
>  		req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
> +		if (unlikely(!req)) {
> +			ret = -ENOTCONN;
> +			goto err;
> +		}

This is extraneous, and not possible since we're doing __GFP_NOFAIL.

>  
>  		if (!args->nocreds)
>  			fuse_force_creds(req);
> @@ -514,16 +535,55 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
>  	}
>  	fuse_put_request(req);
>  
> +err:
>  	return ret;
>  }
>  
> -static bool fuse_request_queue_background(struct fuse_req *req)
> +static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
> +					       struct fuse_req *req)
> +{
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	int err;
> +
> +	req->in.h.unique = fuse_get_unique(fiq);
> +	req->in.h.len = sizeof(struct fuse_in_header) +
> +		fuse_len_args(req->args->in_numargs,
> +			      (struct fuse_arg *) req->args->in_args);
> +
> +	err = fuse_uring_queue_fuse_req(fc, req);
> +	if (!err) {

I'd rather

if (err)
	return false;

Then the rest of this code.

Also generally speaking I think you're correct, below isn't needed because the
queues themselves have their own limits, so I think just delete this bit.

> +		/* XXX remove and lets the users of that use per queue values -
> +		 * avoid the shared spin lock...
> +		 * Is this needed at all?
> +		 */
> +		spin_lock(&fc->bg_lock);
> +		fc->num_background++;
> +		fc->active_background++;
> +
> +
> +		/* XXX block when per ring queues get occupied */
> +		if (fc->num_background == fc->max_background)
> +			fc->blocked = 1;
> +		spin_unlock(&fc->bg_lock);
> +	}
> +
> +	return err ? false : true;
> +}
> +
> +/*
> + * @return true if queued
> + */
> +static int fuse_request_queue_background(struct fuse_req *req)
>  {
>  	struct fuse_mount *fm = req->fm;
>  	struct fuse_conn *fc = fm->fc;
>  	bool queued = false;
>  
>  	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
> +
> +	if (fuse_uring_ready(fc))
> +		return fuse_request_queue_background_uring(fc, req);
> +
>  	if (!test_bit(FR_WAITING, &req->flags)) {
>  		__set_bit(FR_WAITING, &req->flags);
>  		atomic_inc(&fc->num_waiting);
> @@ -576,7 +636,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>  				    struct fuse_args *args, u64 unique)
>  {
>  	struct fuse_req *req;
> -	struct fuse_iqueue *fiq = &fm->fc->iq;
> +	struct fuse_conn *fc = fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
>  	int err = 0;
>  
>  	req = fuse_get_req(fm, false);
> @@ -590,7 +651,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>  
>  	spin_lock(&fiq->lock);
>  	if (fiq->connected) {
> -		queue_request_and_unlock(fiq, req);
> +		/* uring for notify not supported yet */
> +		queue_request_and_unlock(fc, req, false);
>  	} else {
>  		err = -ENODEV;
>  		spin_unlock(&fiq->lock);
> @@ -2205,6 +2267,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		fuse_uring_set_stopped(fc);
>  
>  		fuse_set_initialized(fc);
> +

Extraneous newline.

>  		list_for_each_entry(fud, &fc->devices, entry) {
>  			struct fuse_pqueue *fpq = &fud->pq;
>  
> @@ -2478,6 +2541,7 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
>  		if (res != 0)
>  			return res;
>  		break;
> +

Extraneous newline.

>  		case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
>  			fud->uring_dev = 1;
>  			res = fuse_uring_queue_cfg(fc->ring, &cfg.qconf);
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 6001ba4d6e82..fe80e66150c3 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -32,8 +32,7 @@
>  #include <linux/io_uring/cmd.h>
>  
>  static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
> -					    bool set_err, int error,
> -					    unsigned int issue_flags);
> +					    bool set_err, int error);
>  
>  static void fuse_ring_ring_ent_unset_userspace(struct fuse_ring_ent *ent)
>  {
> @@ -683,8 +682,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>   * userspace will read it
>   * This is comparable with classical read(/dev/fuse)
>   */
> -static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
> -				    unsigned int issue_flags, bool send_in_task)
> +static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent)
>  {
>  	struct fuse_ring *ring = ring_ent->queue->ring;
>  	struct fuse_ring_req *rreq = ring_ent->rreq;
> @@ -721,20 +719,17 @@ static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
>  	rreq->in = req->in.h;
>  	set_bit(FR_SENT, &req->flags);
>  
> -	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu issue_flags=%u\n",
> +	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu\n",
>  		 __func__, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
> -		 rreq->in.opcode, rreq->in.unique, issue_flags);
> +		 rreq->in.opcode, rreq->in.unique);
>  
> -	if (send_in_task)
> -		io_uring_cmd_complete_in_task(ring_ent->cmd,
> -					      fuse_uring_async_send_to_ring);
> -	else
> -		io_uring_cmd_done(ring_ent->cmd, 0, 0, issue_flags);
> +	io_uring_cmd_complete_in_task(ring_ent->cmd,
> +				      fuse_uring_async_send_to_ring);
>  
>  	return;
>  
>  err:
> -	fuse_uring_req_end_and_get_next(ring_ent, true, err, issue_flags);
> +	fuse_uring_req_end_and_get_next(ring_ent, true, err);
>  }
>  
>  /*
> @@ -811,8 +806,7 @@ static bool fuse_uring_ent_release_and_fetch(struct fuse_ring_ent *ring_ent)
>   * has lock/unlock/lock to avoid holding the lock on calling fuse_request_end
>   */
>  static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
> -					    bool set_err, int error,
> -					    unsigned int issue_flags)
> +					    bool set_err, int error)
>  {
>  	struct fuse_req *req = ring_ent->fuse_req;
>  	int has_next;
> @@ -828,7 +822,7 @@ static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
>  	has_next = fuse_uring_ent_release_and_fetch(ring_ent);
>  	if (has_next) {
>  		/* called within uring context - use provided flags */
> -		fuse_uring_send_to_ring(ring_ent, issue_flags, false);
> +		fuse_uring_send_to_ring(ring_ent);
>  	}
>  }
>  
> @@ -863,7 +857,7 @@ static void fuse_uring_commit_and_release(struct fuse_dev *fud,
>  out:
>  	pr_devel("%s:%d ret=%zd op=%d req-ret=%d\n", __func__, __LINE__, err,
>  		 req->args->opcode, req->out.h.error);
> -	fuse_uring_req_end_and_get_next(ring_ent, set_err, err, issue_flags);
> +	fuse_uring_req_end_and_get_next(ring_ent, set_err, err);
>  }
>  
>  /*
> @@ -1101,3 +1095,69 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  	goto out;
>  }
>  
> +int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	struct fuse_ring *ring = fc->ring;
> +	struct fuse_ring_queue *queue;
> +	int qid = 0;
> +	struct fuse_ring_ent *ring_ent = NULL;
> +	int res;
> +	bool async = test_bit(FR_BACKGROUND, &req->flags);
> +	struct list_head *req_queue, *ent_queue;
> +
> +	if (ring->per_core_queue) {
> +		/*
> +		 * async requests are best handled on another core, the current
> +		 * core can do application/page handling, while the async request
> +		 * is handled on another core in userspace.
> +		 * For sync request the application has to wait - no processing, so
> +		 * the request should continue on the current core and avoid context
> +		 * switches.
> +		 * XXX This should be on the same numa node and not busy - is there
> +		 * a scheduler function available  that could make this decision?
> +		 * It should also not persistently switch between cores - makes
> +		 * it hard for the scheduler.
> +		 */
> +		qid = task_cpu(current);
> +
> +		if (unlikely(qid >= ring->nr_queues)) {
> +			WARN_ONCE(1,
> +				  "Core number (%u) exceeds nr ueues (%zu)\n",
> +				  qid, ring->nr_queues);
> +			qid = 0;
> +		}
> +	}
> +
> +	queue = fuse_uring_get_queue(ring, qid);
> +	req_queue = async ? &queue->async_fuse_req_queue :
> +			    &queue->sync_fuse_req_queue;
> +	ent_queue = async ? &queue->async_ent_avail_queue :
> +			    &queue->sync_ent_avail_queue;
> +
> +	spin_lock(&queue->lock);
> +
> +	if (unlikely(queue->stopped)) {
> +		res = -ENOTCONN;
> +		goto err_unlock;

This is the only place we use err_unlock, just do

if (unlikely(queue->stopped)) {
	spin_unlock(&queue->lock);
	return -ENOTCONN;
}

and then you can get rid of res.  Thanks,

Josef

