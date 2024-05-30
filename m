Return-Path: <linux-fsdevel+bounces-20588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69EA8D53CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D671C2457E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E217C223;
	Thu, 30 May 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pkplBU7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E7158A06
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100495; cv=none; b=nEV0OjqT4v8xqIQKF9pde3fog9p3BJnr+B0DVeVp5nx+qfKjtyzr8R8m/aovXWepTTjg4Jie0uz1Vb/uTfv0apyhI5CgHDME1YfTeGiyV9Fo2QXdWfkZARJvRgdZzR4Ec8ba77YOxG+z9JTCdYRPntyZq7UI8gMsp5t99md3m/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100495; c=relaxed/simple;
	bh=NAZuWH7bOBM6fw81N/eah2vC00xwHRIdpR/pR2xJD+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEa69Y3YGAag9qXoKAyh9dKJ3W/P7AxJa+k2zxFNOxX/cCk0qGtd9UvHOBrKTxbwBZCcGx1HzPk2OBP/mT7v2Nuxf2v3UkB/s5iBR+/Nl7/k/cooq+zOomqQQtzTKyaCFkQ5Op4NIShXoFcdNOeLH8tkBiw+BypGheTfZTVSIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pkplBU7O; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-794b1052194so91480185a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717100493; x=1717705293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRSDf1lMQs+7Z23AExNMDv7TO8+Bma2HvK1rK+UYjxA=;
        b=pkplBU7OpNND9yXWLhxSUXwHjDiWSiFY3mKBp7odIJIJ8r948Ahqkn0EPKc/QN2xYt
         6zePQiCg9TjYMJryWQvYmQb5kfJHSastJNuOKNFNt2RKTg0yvJCY19cGidedG80jFnHf
         Fes09KASczzBo9N1TF46FOyLMXpU2gMNRVuKlX7d8HTc1JBrRPBOk8q8tZMRFEQuATbg
         OFLoYuuWR5Ylflpi4vGT+9UkdOaiIbxUpoy4L7yARPx6x8jgupU7xfQMq3xAHwLVR9g6
         vwF6dovkDLBzyJ2FFpXIAX7NqeIlPj20ryv76L56gGYMhZcjUvBS9NDP65pFy8V3QGzh
         PqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100493; x=1717705293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRSDf1lMQs+7Z23AExNMDv7TO8+Bma2HvK1rK+UYjxA=;
        b=UTNMnalSX/LJ4I6QJ7CqrAr+3sdzh0ReFKjsm4xQI2fVhQI4c0vw4LGtV8JAMLez7T
         MAkoczd27rmQhQxyNqCyq/NsMt/iwuG8tIchejD6jZRuCXX2Ma7xNdDm+V93kmkzL2QM
         aK6QsjG/PclgciK+mif2rGaQ0gJ+JLjMPBiqIwMh1+wyDyV4WX8Sj3XwuQr+moWyLPBV
         RDa7YvBonm417eXXi57sblDouTYZxMsEc1NcNNpzFgTCtn8fY05l9IcgZV3HYyc0TEVz
         UX5xPIahG0h2SeKfq/A+ViEguCC5O8k65M7knmKBX6uul+iRZ6ubIPNOX6S18TUmI/SE
         GdEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9GBlHjJ3GYCKbdAbrQg9Kp4KgpdsvrcqGcHO6PqaznmmkfYsRCoYQSVpeYKi60AUrdQuMDb6su0DiUSjmPML3YmTIJaiALXIWeHz9MA==
X-Gm-Message-State: AOJu0YwSa+HSAutuht23ijb3+/GM1VnVJ9e+0t4BOkg9UQ236g3xPyye
	qMgWpCFwRSkSRE+htlB3ftHtivC4b74GsZf/M+yBgbNC8GdBjOwz7ykO50D6aQQ=
X-Google-Smtp-Source: AGHT+IFEasJPYHBJgiGZ7VkRVAj51CSE5+oVqpsbEkaqUm8NOiFZV+xLJ9imSpmmyeinHvdFdUdWqg==
X-Received: by 2002:a05:620a:2596:b0:794:afc4:dade with SMTP id af79cd13be357-794e9e183bemr420932585a.61.1717100492899;
        Thu, 30 May 2024 13:21:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2efc67csm10748285a.20.2024.05.30.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 13:21:32 -0700 (PDT)
Date: Thu, 30 May 2024 16:21:31 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 13/19] fuse: {uring} Handle uring shutdown
Message-ID: <20240530202131.GE2210558@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-13-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-13-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:48PM +0200, Bernd Schubert wrote:
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev.c         |  10 +++
>  fs/fuse/dev_uring.c   | 194 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/dev_uring_i.h |  67 +++++++++++++++++
>  3 files changed, 271 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index a7d26440de39..6ffd216b27c8 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2202,6 +2202,8 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		fc->connected = 0;
>  		spin_unlock(&fc->bg_lock);
>  
> +		fuse_uring_set_stopped(fc);
> +
>  		fuse_set_initialized(fc);
>  		list_for_each_entry(fud, &fc->devices, entry) {
>  			struct fuse_pqueue *fpq = &fud->pq;
> @@ -2245,6 +2247,12 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		spin_unlock(&fc->lock);
>  
>  		fuse_dev_end_requests(&to_end);
> +
> +		/*
> +		 * fc->lock must not be taken to avoid conflicts with io-uring
> +		 * locks
> +		 */
> +		fuse_uring_abort(fc);

Perhaps a 

lockdep_assert_not_held(&fc->lock)

in fuse_uring_abort() then?

>  	} else {
>  		spin_unlock(&fc->lock);
>  	}
> @@ -2256,6 +2264,8 @@ void fuse_wait_aborted(struct fuse_conn *fc)
>  	/* matches implicit memory barrier in fuse_drop_waiting() */
>  	smp_mb();
>  	wait_event(fc->blocked_waitq, atomic_read(&fc->num_waiting) == 0);
> +
> +	fuse_uring_wait_stopped_queues(fc);
>  }
>  
>  int fuse_dev_release(struct inode *inode, struct file *file)
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5269b3f8891e..6001ba4d6e82 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -48,6 +48,44 @@ fuse_uring_async_send_to_ring(struct io_uring_cmd *cmd,
>  	io_uring_cmd_done(cmd, 0, 0, issue_flags);
>  }
>  
> +/* Abort all list queued request on the given ring queue */
> +static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
> +{
> +	struct fuse_req *req;
> +	LIST_HEAD(sync_list);
> +	LIST_HEAD(async_list);
> +
> +	spin_lock(&queue->lock);
> +
> +	list_for_each_entry(req, &queue->sync_fuse_req_queue, list)
> +		clear_bit(FR_PENDING, &req->flags);
> +	list_for_each_entry(req, &queue->async_fuse_req_queue, list)
> +		clear_bit(FR_PENDING, &req->flags);
> +
> +	list_splice_init(&queue->async_fuse_req_queue, &sync_list);
> +	list_splice_init(&queue->sync_fuse_req_queue, &async_list);
> +
> +	spin_unlock(&queue->lock);
> +
> +	/* must not hold queue lock to avoid order issues with fi->lock */
> +	fuse_dev_end_requests(&sync_list);
> +	fuse_dev_end_requests(&async_list);
> +}
> +
> +void fuse_uring_abort_end_requests(struct fuse_ring *ring)
> +{
> +	int qid;
> +
> +	for (qid = 0; qid < ring->nr_queues; qid++) {
> +		struct fuse_ring_queue *queue = fuse_uring_get_queue(ring, qid);
> +
> +		if (!queue->configured)
> +			continue;
> +
> +		fuse_uring_abort_end_queue_requests(queue);
> +	}
> +}
> +
>  /* Update conn limits according to ring values */
>  static void fuse_uring_conn_cfg_limits(struct fuse_ring *ring)
>  {
> @@ -361,6 +399,162 @@ int fuse_uring_queue_cfg(struct fuse_ring *ring,
>  	return 0;
>  }
>  
> +static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
> +{
> +	struct fuse_req *req = ent->fuse_req;
> +
> +	ent->fuse_req = NULL;
> +	clear_bit(FRRS_FUSE_REQ, &ent->state);
> +	clear_bit(FR_SENT, &req->flags);
> +	req->out.h.error = -ECONNABORTED;
> +	fuse_request_end(req);
> +}
> +
> +/*
> + * Release a request/entry on connection shutdown
> + */
> +static bool fuse_uring_try_entry_stop(struct fuse_ring_ent *ent,
> +				      bool need_cmd_done)
> +	__must_hold(ent->queue->lock)
> +{
> +	struct fuse_ring_queue *queue = ent->queue;
> +	bool released = false;
> +
> +	if (test_bit(FRRS_FREED, &ent->state))
> +		goto out; /* no work left, freed before */

Just return false;

> +
> +	if (ent->state == BIT(FRRS_INIT) || test_bit(FRRS_WAIT, &ent->state) ||
> +	    test_bit(FRRS_USERSPACE, &ent->state)) {

Again, apologies for just now noticing this, but this is kind of a complicated
state machine.

I think I'd rather you just use ent->state as an actual state machine, so it has
one value and one value only at any given time, which appears to be what happens
except in that we have FRRS_INIT set in addition to whatever other bit is set.

Rework this so it's less complicated, because it's quite difficult to follow in
it's current form.  Thanks,

Josef

