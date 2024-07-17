Return-Path: <linux-fsdevel+bounces-23886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4779344BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495AF1C219D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B8548CCC;
	Wed, 17 Jul 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="iMBSa8GF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvelIxI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBB374F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254997; cv=none; b=UzVe5YqL+tUmXxiROODqYfz8K4mIia0+DpeJwN2PU28266dSRUACpjfNy9LcdbL2gykQ05/cKE6G4xrqdXjYXMxUUk4Zx0o2soz83v8jvbuRUVSpjKgxu7+H42InavlwAlvi9kYxV9b6Gu4DaYqOb0OmfdtqCsZplJIEk6AlcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254997; c=relaxed/simple;
	bh=DmWHPcQph9YG8dytcCoeVAit0O/tQDL6sHdH/nf0dks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZwjUuZvOgkXSTQlylT0T76ER5BJiycpUAqmk6wZZrQECJ2/UJxnPJ4vrTx6zxEyYcniGyfbrnvNTCs1r1lUmc5HGoh6N5xh1ca8ULGrnO7sRGd+AoFNbSA409G6mU6YxHKYq0FMhvk6s6lxVk3XwnQM0bviahnZEjUbt+AnvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=iMBSa8GF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvelIxI1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4DF1313800D5;
	Wed, 17 Jul 2024 18:23:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 17 Jul 2024 18:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721254989;
	 x=1721341389; bh=kbcbLRfCm9WkuGvJ2y2cNB3RqHRyPbzXNt3fe7Nz9Zo=; b=
	iMBSa8GFQ4p0bS2tm//20QVa7bnR2IbNz0BDTXy2iw5vyccMvGH8LyNQaZfNOR1V
	ID2K/iOPzo68hb4wfQceexGtGwtn/R4BzrApPsyWn6RFmgFouT2y2hDWK1+AOeVE
	rjnAm0T3wG7tV7YzHyPVa+f2O6nrTOiduvJl2m2M0kfWXdKDNKwTkhisDWNVvt1A
	V1S/dbjETTyttMAk6aXd5lHpvrxlkIyujjDVqT56StkKyGTJXii82p3jG0t1sIKh
	CzXTEdCobA64l3nEOXD0Gc68pbXPpq0uyx1Ogrj3UvKNucG+VkMpbqEZrhWQkgPH
	mi/uMW03rcwJvxLA/TjGIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721254989; x=
	1721341389; bh=kbcbLRfCm9WkuGvJ2y2cNB3RqHRyPbzXNt3fe7Nz9Zo=; b=C
	velIxI1hQkU6TwD5Kcz3czpIcDIPntJFIQJ+tgT798emKDf72SkQPcm4oIMGuPes
	Lnyeorac6vRDmOBqVJ9Td91AD5uGxVUaR62U7VNJYLqI0kW0r96Y5fotFfgaSG/a
	+Fqi0EZWhoNRCrAwytEDMKExuXBxflISrSkRFLpIBeLbaNo0Du70r1ShmXbjH4un
	GdOleWLhW1JKcX3Ofq0HX6s/Wp7Ynr8kAtrqyu3fFA+lgtCtC5haogPu4LWIMLE7
	hG86md18cZm8rwlZAveS5IIMLUO6GMRWm+hCa27ZvX5gUCjBpk9DB/wr2gJ1AZer
	YvU4fMK0o9alCtkB6O0Kw==
X-ME-Sender: <xms:S0SYZs6kyr8czueWN13Ymacr4gsH4eMnKtCvp30-BTGgnDENRsd6fA>
    <xme:S0SYZt5bN5MHIMiapGwEHXg6rvcNCEHjmp9pDlv4zqXx5soi14liQjM_CyWf5ac5m
    m9bYxr4uvRsfSLU>
X-ME-Received: <xmr:S0SYZrfpI5fq6iMEhHFV89TFnPFUgVgv4TVr85rj0yX2mXcq3Tm2-io1nSsaAa0Lb7JFQoVsg453sM0mVFdJnoqLYcII_bJkJq9zaTvfOv6ZwOwJP79-EL0KAR0ZgZIxW4nZKsjOaguF3GIEelAkrnggHHS9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeekgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefghfefhfeiueffffetledtgffh
    hfdttdefueevledvleetfeevtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:S0SYZhJZ3Al8bxp4qUCUXDngG777MRyNc40DepGuJTQCx3gbKOmpWQ>
    <xmx:S0SYZgLdsx9fGJBF8kH6IyhwQUVRoEAJsQ0ZTi5zVIGmsEWLJ0zXEg>
    <xmx:S0SYZiyC4xJW9V9CPN9Tr3c2-wlKcYbFSdXK135L_C4sLTeVa_lrcQ>
    <xmx:S0SYZkKG_wxRuEuRk737cgoMpMRaZts0m62Zkp2-ZiegzEuZ-56YTA>
    <xmx:TUSYZo_ZguD6KbXBXwKaZ9uOY_Z5OuQnuCqMs18EV2qaL3FeJr5hfc1s>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 18:23:05 -0400 (EDT)
Message-ID: <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm>
Date: Thu, 18 Jul 2024 00:23:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, osandov@osandov.com, kernel-team@meta.com
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
Content-Language: en-US, fr, ru
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20240717213458.1613347-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

On 7/17/24 23:34, Joanne Koong wrote:
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


This and that thread here actually make me wonder if this is the right
approach

https://lore.kernel.org/lkml/20240613040147.329220-1-haifeng.xu@shopee.com/T/


In  th3 thread above a request got interrupted, but fuse-server still
does not manage stop it. From my point of view, interrupting a request
suggests to add a rather short kernel lifetime for it. With that one
either needs to wake up in intervals and check if request timeout got
exceeded or it needs to be an async kernel thread. I think that async
thread would also allow to give a timeout to background requests.

Or we add an async timeout to bg and interupted requests additionally?


(I only basically reviewed, can't do carefully right now - on vacation
and as I just noticed, on a laptop that gives me electric shocks when I
connect it to power.)


Thanks,
Bernd



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
> +
>  	fuse_put_request(req);
>  
>  	return reqsize;
> @@ -1332,6 +1474,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  		list_del_init(&req->list);
>  	spin_unlock(&fpq->lock);
>  	fuse_request_end(req);
> +	fuse_put_request(req);
>  	return err;
>  
>   err_unlock:
> @@ -1951,9 +2094,10 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  		goto copy_finish;
>  	}
>  
> +	__fuse_get_request(req);
> +
>  	/* Is it an interrupt reply ID? */
>  	if (oh.unique & FUSE_INT_REQ_BIT) {
> -		__fuse_get_request(req);
>  		spin_unlock(&fpq->lock);
>  
>  		err = 0;
> @@ -1969,6 +2113,13 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  		goto copy_finish;
>  	}
>  
> +	if (test_and_set_bit(FR_PROCESSING, &req->flags)) {
> +		/* request has timed out already */
> +		spin_unlock(&fpq->lock);
> +		fuse_put_request(req);
> +		goto copy_finish;
> +	}
> +
>  	clear_bit(FR_SENT, &req->flags);
>  	list_move(&req->list, &fpq->io);
>  	req->out.h = oh;
> @@ -1995,6 +2146,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
>  	spin_unlock(&fpq->lock);
>  
>  	fuse_request_end(req);
> +	fuse_put_request(req);
>  out:
>  	return err ? err : nbytes;
>  
> @@ -2260,13 +2412,22 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  	if (fud) {
>  		struct fuse_conn *fc = fud->fc;
>  		struct fuse_pqueue *fpq = &fud->pq;
> +		struct fuse_req *req;
>  		LIST_HEAD(to_end);
>  		unsigned int i;
>  
>  		spin_lock(&fpq->lock);
>  		WARN_ON(!list_empty(&fpq->io));
> -		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
> +		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +			/*
> +			 * Set the req error to -ESTALE so that if the timeout
> +			 * handler tries handling it, it knows it's being
> +			 * released
> +			 */
> +			list_for_each_entry(req, &fpq->processing[i], list)
> +				req->out.h.error = -ESTALE;
>  			list_splice_init(&fpq->processing[i], &to_end);
> +		}
>  		spin_unlock(&fpq->lock);
>  
>  		end_requests(&to_end);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f23919610313..cbabebbcd5bd 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -375,6 +375,9 @@ struct fuse_io_priv {
>   * FR_FINISHED:		request is finished
>   * FR_PRIVATE:		request is on private list
>   * FR_ASYNC:		request is asynchronous
> + * FR_PROCESSING:	request is being processed. this gets set when either
> + *			the reply is getting processed or the kernel is processing
> + *			a request timeout
>   */
>  enum fuse_req_flag {
>  	FR_ISREPLY,
> @@ -389,6 +392,7 @@ enum fuse_req_flag {
>  	FR_FINISHED,
>  	FR_PRIVATE,
>  	FR_ASYNC,
> +	FR_PROCESSING,
>  };
>  
>  /**
> @@ -435,6 +439,9 @@ struct fuse_req {
>  
>  	/** fuse_mount this request belongs to */
>  	struct fuse_mount *fm;
> +
> +	/** page queue this request has been added to */
> +	struct fuse_pqueue *fpq;
>  };
>  
>  struct fuse_iqueue;
> @@ -574,6 +581,8 @@ struct fuse_fs_context {
>  	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
> +	/*  Daemon timeout (in seconds). 0 = no timeout (infinite wait) */
> +	unsigned int daemon_timeout;
>  	const char *subtype;
>  
>  	/* DAX device, may be NULL */
> @@ -633,6 +642,9 @@ struct fuse_conn {
>  	/** Constrain ->max_pages to this value during feature negotiation */
>  	unsigned int max_pages_limit;
>  
> +	/* Daemon timeout (in jiffies). 0 = no timeout (infinite wait) */
> +	unsigned long daemon_timeout;
> +
>  	/** Input queue */
>  	struct fuse_iqueue iq;
>  
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 99e44ea7d875..a2d53a8b8e34 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -733,6 +733,7 @@ enum {
>  	OPT_ALLOW_OTHER,
>  	OPT_MAX_READ,
>  	OPT_BLKSIZE,
> +	OPT_DAEMON_TIMEOUT,
>  	OPT_ERR
>  };
>  
> @@ -747,6 +748,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +	fsparam_u32	("daemon_timeout",	OPT_DAEMON_TIMEOUT),
>  	{}
>  };
>  
> @@ -830,6 +832,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		ctx->blksize = result.uint_32;
>  		break;
>  
> +	case OPT_DAEMON_TIMEOUT:
> +		ctx->daemon_timeout = result.uint_32;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1724,6 +1730,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->group_id = ctx->group_id;
>  	fc->legacy_opts_show = ctx->legacy_opts_show;
>  	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
> +	fc->daemon_timeout = ctx->daemon_timeout * HZ;
>  	fc->destroy = ctx->destroy;
>  	fc->no_control = ctx->no_control;
>  	fc->no_force_umount = ctx->no_force_umount;


