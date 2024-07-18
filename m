Return-Path: <linux-fsdevel+bounces-23927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01219934F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B045B28432B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4961B1422CA;
	Thu, 18 Jul 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZhOVqh3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156A12F5A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313875; cv=none; b=jPTvMDNYQMcROfvHwJa4K/WZjGufWGOKi8Z6RPTjMk7979D9KSRL6fl9oQ8WVJczEOCtMsvqCq11biWVgO1HVIPZDq6TIEYDdNglriMIn/cy8e/jessmLu0AVimB0TPpvOgwFJBbhxDnkKXDKg4LlLSlD2ieyhdrKuxJny1oOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313875; c=relaxed/simple;
	bh=DGvXyYV3ua+SqArf5bR3exBTqFl4attv9HXBDfclRQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUjsKdKMAMUrr+ynOnLR/A//CejujIi3iNOFKNyexcdkRjNxJawvcu8NermWZuwbEzhttFxlZBJgyIGTPAtNNogclOP6hYf7m6lY3Mt5rEqXxa9jdboRO5oZcHDVBFGpmSTd0ummpQgCGrAYOZgUngMOFE7nCqpiB1OlRE+iNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZhOVqh3k; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-65f8626780aso8199127b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721313872; x=1721918672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKhFNPjJUpLjnLuRbSgJY4qyi1z8LEzoBAkugdLbcKw=;
        b=ZhOVqh3klttsfvnC2opSOXBxkzN489dwvsjo0o2pKbqZthcjeGWsRaWRSqp7kCppOZ
         jRiJEoksfDSNsd3mEQWCPhPYYV/hABv8whw0wc2KKNqb2QMbN45E+iY4vxrP0XuMnKR8
         5q6jLcRmdkRENRvzzazLbevjZOJhVo11H3nS8vaMz+upZNryc+IfB+dpAWUi9LRsvFtC
         SqKTFq8OOGvyhxbysmN0BIVjS8J5BNtnBnV8L66w2SyL+lbpPcpxsMSS/N3W1Zdzkc+E
         xNt3Nf4TAYNrn/wk974Kk46d6OfL1+/tE8COImsgDUuojtfq2fvcboIszWjji/AoeNmj
         fZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721313872; x=1721918672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKhFNPjJUpLjnLuRbSgJY4qyi1z8LEzoBAkugdLbcKw=;
        b=OSrYx1MGCgtq9iuKdmRdmu6VDIBvc0g3k49ZyWEv4jlq4d6UxwYdT32f1kYevsaVVi
         6lC13woCHrT2BQscNeIrVwcoOr//wDf8s5oUKRRrqbbLwLY+y6yj5XA7ZREZcDFnqxu4
         v8+Eyp/QDbGge4yP1zKM7hJbp//wxRYQFOno7eZjL+CIMSWNdn1QjCPlRo+v0D7lppjv
         zyoBP/duPzNQcbU65rvVu+rkaEIKKIi0apGrdr8TIqsp37fCbejxNhmNRSApUSzz3S5P
         oy26P9x47tnZ+wLCF0gZ5Pu5YwWR8RvKslTQ44+Lcm8h2sBC99owRKbZ8f6knMW6ej0p
         C1+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCiHCpAHCmuX9wH/RQSJnoH1fQ6qRVO9yRXFUgNS4Tl0QMTs/bRtdd8+kdxZofpkPXOcmk3iU4UVz05cTR4Mn/tTsG5obQGKeEXi1SqQ==
X-Gm-Message-State: AOJu0YyUNUEx+hWX1Cgb4cF4AtMqqwRyJ3DE30DsYAeog/ITsS/tF+X+
	r7Wla8GcRLQgoKlOewI5IKAxxjI6x2hcJvCgmfPH+1hb1NfA4gbIUQx+Ze2hpy0=
X-Google-Smtp-Source: AGHT+IHKmwQjv2YanE2T9boGh0Yh605UeDRW731VbpfrcsHrn3pq/Ma/XFTr4SW2Njd2fIBK2u7YBw==
X-Received: by 2002:a05:690c:3203:b0:646:7b75:5c2c with SMTP id 00721157ae682-66601cce447mr32485437b3.16.1721313872074;
        Thu, 18 Jul 2024 07:44:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66601ad9f79sm3502717b3.27.2024.07.18.07.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:44:31 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:44:30 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@osandov.com,
	kernel-team@meta.com
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse
 requests
Message-ID: <20240718144430.GA2099026@perftesting>
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717213458.1613347-1-joannelkoong@gmail.com>

On Wed, Jul 17, 2024 at 02:34:58PM -0700, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or take
> too long to reply to a request. Currently there is no upper bound on
> how long a request may take, which may be frustrating to users who get
> stuck waiting for a request to complete.
> 
> This commit adds a daemon timeout option (in seconds) for fuse requests.
> If the timeout elapses before the request is replied to, the request will
> fail with -ETIME.
> 
> There are 3 possibilities for a request that times out:
> a) The request times out before the request has been sent to userspace
> b) The request times out after the request has been sent to userspace
> and before it receives a reply from the server
> c) The request times out after the request has been sent to userspace
> and the server replies while the kernel is timing out the request
> 
> Proper synchronization must be added to ensure that the request is
> handled correctly in all of these cases. To this effect, there is a new
> FR_PROCESSING bit added to the request flags, which is set atomically by
> either the timeout handler (see fuse_request_timeout()) which is invoked
> after the request timeout elapses or set by the request reply handler
> (see dev_do_write()), whichever gets there first.
> 
> If the reply handler and the timeout handler are executing simultaneously
> and the reply handler sets FR_PROCESSING before the timeout handler, then
> the request is re-queued onto the waitqueue and the kernel will process the
> reply as though the timeout did not elapse. If the timeout handler sets
> FR_PROCESSING before the reply handler, then the request will fail with
> -ETIME and the request will be cleaned up.
> 
> Proper acquires on the request reference must be added to ensure that the
> timeout handler does not drop the last refcount on the request while the
> reply handler (dev_do_write()) or forwarder handler (dev_do_read()) is
> still accessing the request. (By "forwarder handler", this is the handler
> that forwards the request to userspace).
> 
> Currently, this is the lifecycle of the request refcount:
> 
> Request is created:
> fuse_simple_request -> allocates request, sets refcount to 1
>   __fuse_request_send -> acquires refcount
>     queues request and waits for reply...
> fuse_simple_request -> drops refcount
> 
> Request is freed:
> fuse_dev_do_write
>   fuse_request_end -> drops refcount on request
> 
> The timeout handler drops the refcount on the request so that the
> request is properly cleaned up if a reply is never received. Because of
> this, both the forwarder handler and the reply handler must acquire a refcount
> on the request while it accesses the request, and the refcount must be
> acquired while the lock of the list the request is on is held.
> 
> There is a potential race if the request is being forwarded to
> userspace while the timeout handler is executing (eg FR_PENDING has
> already been cleared but dev_do_read() hasn't finished executing). This
> is a problem because this would free the request but the request has not
> been removed from the fpq list it's on. To prevent this, dev_do_read()
> must check FR_PROCESSING at the end of its logic and remove the request
> from the fpq list if the timeout occurred.
> 
> There is also the case where the connection may be aborted or the
> device may be released while the timeout handler is running. To protect
> against an extra refcount drop on the request, the timeout handler
> checks the connected state of the list and lets the abort handler drop the
> last reference if the abort is running simultaneously. Similarly, the
> timeout handler also needs to check if the req->out.h.error is set to
> -ESTALE, which indicates that the device release is cleaning up the
> request. In both these cases, the timeout handler will return without
> dropping the refcount.
> 
> Please also note that background requests are not applicable for timeouts
> since they are asynchronous.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 177 ++++++++++++++++++++++++++++++++++++++++++++---
>  fs/fuse/fuse_i.h |  12 ++++
>  fs/fuse/inode.c  |   7 ++
>  3 files changed, 188 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..7dd7b244951b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -331,6 +331,69 @@ void fuse_request_end(struct fuse_req *req)
>  }
>  EXPORT_SYMBOL_GPL(fuse_request_end);
>  
> +/* fuse_request_end for requests that timeout */
> +static void fuse_request_timeout(struct fuse_req *req)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_pqueue *fpq;
> +
> +	spin_lock(&fiq->lock);
> +	if (!fiq->connected) {
> +		spin_unlock(&fiq->lock);
> +		/*
> +		 * Connection is being aborted. The abort will release
> +		 * the refcount on the request
> +		 */
> +		req->out.h.error = -ECONNABORTED;
> +		return;
> +	}
> +	if (test_bit(FR_PENDING, &req->flags)) {
> +		/* Request is not yet in userspace, bail out */
> +		list_del(&req->list);
> +		spin_unlock(&fiq->lock);
> +		req->out.h.error = -ETIME;
> +		__fuse_put_request(req);

Why is this safe?  We could be the last holder of the reference on this request
correct?  The only places using __fuse_put_request() would be where we are in a
path where the caller already holds a reference on the request.  Since this is
async it may not be the case right?

If it is safe then it's just confusing and warrants a comment.

> +		return;
> +	}
> +	if (test_bit(FR_INTERRUPTED, &req->flags))
> +		list_del_init(&req->intr_entry);
> +
> +	fpq = req->fpq;
> +	spin_unlock(&fiq->lock);
> +
> +	if (fpq) {
> +		spin_lock(&fpq->lock);
> +		if (!fpq->connected && (!test_bit(FR_PRIVATE, &req->flags))) {
                                       ^^

You don't need the extra () there.

> +			spin_unlock(&fpq->lock);
> +			/*
> +			 * Connection is being aborted. The abort will release
> +			 * the refcount on the request
> +			 */
> +			req->out.h.error = -ECONNABORTED;
> +			return;
> +		}
> +		if (req->out.h.error == -ESTALE) {
> +			/*
> +			 * Device is being released. The fuse_dev_release call
> +			 * will drop the refcount on the request
> +			 */
> +			spin_unlock(&fpq->lock);
> +			return;
> +		}
> +		if (!test_bit(FR_PRIVATE, &req->flags))
> +			list_del_init(&req->list);
> +		spin_unlock(&fpq->lock);
> +	}
> +
> +	req->out.h.error = -ETIME;
> +
> +	if (test_bit(FR_ASYNC, &req->flags))
> +		req->args->end(req->fm, req->args, req->out.h.error);
> +
> +	fuse_put_request(req);
> +}

Just a general styling thing, we have two different states for requests here,
PENDING and !PENDING correct?  I think it may be better to do something like

if (test_bit(FR_PENDING, &req->flags))
	timeout_pending_req();
else
	timeout_inflight_req();

and then in timeout_pending_req() you do

spin_lock(&fiq->lock);
if (!test_bit(FR_PENDING, &req->flags)) {
	spin_unlock(&fiq_lock);
	timeout_inflight_req();
	return;
}

This will keep the two different state cleanup functions separate and a little
cleaner to grok.

> +
>  static int queue_interrupt(struct fuse_req *req)
>  {
>  	struct fuse_iqueue *fiq = &req->fm->fc->iq;
> @@ -361,6 +424,62 @@ static int queue_interrupt(struct fuse_req *req)
>  	return 0;
>  }
>  
> +enum wait_type {
> +	WAIT_TYPE_INTERRUPTIBLE,
> +	WAIT_TYPE_KILLABLE,
> +	WAIT_TYPE_NONINTERRUPTIBLE,
> +};
> +
> +static int fuse_wait_event_interruptible_timeout(struct fuse_req *req)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +
> +	return wait_event_interruptible_timeout(req->waitq,
> +						test_bit(FR_FINISHED,
> +							 &req->flags),
> +						fc->daemon_timeout);
> +}
> +ALLOW_ERROR_INJECTION(fuse_wait_event_interruptible_timeout, ERRNO);
> +
> +static int wait_answer_timeout(struct fuse_req *req, enum wait_type type)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +	int err;
> +
> +wait_answer_start:
> +	if (type == WAIT_TYPE_INTERRUPTIBLE)
> +		err = fuse_wait_event_interruptible_timeout(req);
> +	else if (type == WAIT_TYPE_KILLABLE)
> +		err = wait_event_killable_timeout(req->waitq,
> +						  test_bit(FR_FINISHED, &req->flags),
> +						  fc->daemon_timeout);
> +
> +	else if (type == WAIT_TYPE_NONINTERRUPTIBLE)
> +		err = wait_event_timeout(req->waitq, test_bit(FR_FINISHED, &req->flags),
> +					 fc->daemon_timeout);
> +	else
> +		WARN_ON(1);

This will leak some random value for err, so initialize err to something that
will be dealt with, like -EINVAL;

> +
> +	/* request was answered */
> +	if (err > 0)
> +		return 0;
> +
> +	/* request was not answered in time */
> +	if (err == 0) {
> +		if (test_and_set_bit(FR_PROCESSING, &req->flags))
> +			/* request reply is being processed by kernel right now.
> +			 * we should wait for the answer.
> +			 */

Format for multiline comments is

/*
 * blah
 * blah
 */

and since this is a 1 line if statement put it above the if statement.

> +			goto wait_answer_start;
> +
> +		fuse_request_timeout(req);
> +		return 0;
> +	}
> +
> +	/* else request was interrupted */
> +	return err;
> +}
> +
>  static void request_wait_answer(struct fuse_req *req)
>  {
>  	struct fuse_conn *fc = req->fm->fc;
> @@ -369,8 +488,11 @@ static void request_wait_answer(struct fuse_req *req)
>  
>  	if (!fc->no_interrupt) {
>  		/* Any signal may interrupt this */
> -		err = wait_event_interruptible(req->waitq,
> -					test_bit(FR_FINISHED, &req->flags));
> +		if (fc->daemon_timeout)
> +			err = wait_answer_timeout(req, WAIT_TYPE_INTERRUPTIBLE);
> +		else
> +			err = wait_event_interruptible(req->waitq,
> +						       test_bit(FR_FINISHED, &req->flags));
>  		if (!err)
>  			return;
>  
> @@ -383,8 +505,11 @@ static void request_wait_answer(struct fuse_req *req)
>  
>  	if (!test_bit(FR_FORCE, &req->flags)) {
>  		/* Only fatal signals may interrupt this */
> -		err = wait_event_killable(req->waitq,
> -					test_bit(FR_FINISHED, &req->flags));
> +		if (fc->daemon_timeout)
> +			err = wait_answer_timeout(req, WAIT_TYPE_KILLABLE);
> +		else
> +			err = wait_event_killable(req->waitq,
> +						  test_bit(FR_FINISHED, &req->flags));
>  		if (!err)
>  			return;
>  
> @@ -404,7 +529,10 @@ static void request_wait_answer(struct fuse_req *req)
>  	 * Either request is already in userspace, or it was forced.
>  	 * Wait it out.
>  	 */
> -	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
> +	if (fc->daemon_timeout)
> +		wait_answer_timeout(req, WAIT_TYPE_NONINTERRUPTIBLE);
> +	else
> +		wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
>  }
>  
>  static void __fuse_request_send(struct fuse_req *req)
> @@ -1268,6 +1396,9 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	req = list_entry(fiq->pending.next, struct fuse_req, list);
>  	clear_bit(FR_PENDING, &req->flags);
>  	list_del_init(&req->list);
> +	/* Acquire a reference since fuse_request_timeout may also be executing  */
> +	__fuse_get_request(req);
> +	req->fpq = fpq;
>  	spin_unlock(&fiq->lock);
>  

There's a race here with completion.  If we timeout a request right here, we can
end up sending that same request below.

You are going to need to check

test_bit(FR_PROCESSING)

after you take the fpq->lock just below here to make sure you didn't race with
the timeout handler and time the request out already.

>  	args = req->args;
> @@ -1280,6 +1411,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  		if (args->opcode == FUSE_SETXATTR)
>  			req->out.h.error = -E2BIG;
>  		fuse_request_end(req);
> +		fuse_put_request(req);
>  		goto restart;
>  	}
>  	spin_lock(&fpq->lock);
> @@ -1316,13 +1448,23 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	}
>  	hash = fuse_req_hash(req->in.h.unique);
>  	list_move_tail(&req->list, &fpq->processing[hash]);
> -	__fuse_get_request(req);
>  	set_bit(FR_SENT, &req->flags);
>  	spin_unlock(&fpq->lock);
>  	/* matches barrier in request_wait_answer() */
>  	smp_mb__after_atomic();
>  	if (test_bit(FR_INTERRUPTED, &req->flags))
>  		queue_interrupt(req);
> +
> +	/* Check if request timed out */
> +	if (test_bit(FR_PROCESSING, &req->flags)) {
> +		spin_lock(&fpq->lock);
> +		if (!test_bit(FR_PRIVATE, &req->flags))
> +			list_del_init(&req->list);
> +		spin_unlock(&fpq->lock);
> +		fuse_put_request(req);
> +		return -ETIME;
> +	}

This isn't quite right, we could have FR_PROCESSING set because we completed the
request before we got here.  If you put a schedule_timeout(HZ); right above this
you could easily see where a request gets completed by userspace, but now you've
fimed it out.

Additionally if we have FR_PROCESSING set from the timeout, shouldn't this
cleanup have been done already?  I don't understand why we need to handle this
here, we should just return and whoever is waiting on the request will get the
error.

Thanks,

Josef

