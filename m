Return-Path: <linux-fsdevel+bounces-24959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A2947182
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 00:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B984EB20ACB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A813A3F0;
	Sun,  4 Aug 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="m54M793Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/kOSb8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8618046
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722811604; cv=none; b=PBbKHyky9JQIF1aa9SdOm8DHrR3wmHnCOtb8As7ZYQ72tLo0Mw7QfkV7LJE4fyvANsCFmd+hU8SG9H+LApJJB/9UNHrthWqU9OE1NPRfhyUOJlHmYVK+gULOGxyXdiOJGUGuGRcVtgbu1HAFU66T1xb7F6VknSt+6uHziDp/YSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722811604; c=relaxed/simple;
	bh=R1c4e0xR34qxM7sahLXjEpIIHEJfszOthAwUw/Q0M44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNZvUjfRUea8VqsNCmiAsM8iTzU7BTcTIQzDYmFKGdcpXdHNFp5gC/FT9cC9soL0JMp6r6YBS4GaFCKheHPnkKXGxEyjpO/iIS6G+sl9CkzjSNIWZqLChUAVSiVAJRbW4Z6YI2aI50ePhgR27QJm5k+PjWcCwDgXKi7LvA6EmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=m54M793Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/kOSb8s; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 660E91383375;
	Sun,  4 Aug 2024 18:46:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 04 Aug 2024 18:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722811600;
	 x=1722898000; bh=SG38o/n2IS4cdrCek28PBMPt8HmF56cakCN5iVhw8s0=; b=
	m54M793Z042R0+XokNhOk9/UuDLQii7oGGVdMgfncGn6Kr5XlfYs8V201OyWTCt6
	m848yQrl+J0ugJ/g/Gm2WMwJtAeB7iHfNF7k1ytDs3rZgGqD3PhFomzqey3WEQuA
	AqBl89g1WRkJoPVgufKz6Jp4nDprtRtb0kBj8w07c8wCCPo3J4PZBO3AAf6KGIP+
	AxCjq7XJCCOGbDpBHWJ6T6pCH/ttTLLJWlGX1I4EqyI/9v+jN6p7WbRLB9jVhx3L
	ONkKfkoLN0x4alc5ZFUyWaJABgUINBJSFPcS9zXrBCgva5IjVDWGJqhU9ddAYZVj
	7PU/Q007ftgVjod5gsEz4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722811600; x=
	1722898000; bh=SG38o/n2IS4cdrCek28PBMPt8HmF56cakCN5iVhw8s0=; b=m
	/kOSb8sdprXP3UmvlPP9k5bcIyZxMec1F4Edllk0p04lz7HfvCVUu2o3k7claxqu
	0GfAoldHW90CHxW4bAvnzGrFJvAK6sSygJt1wapi/JEI3HDLeidMqWL7DixyhF5Y
	90sQJmoHtW0pFxMk2n2c9sT2jHjLJvgHVZqTiKF08r50UxjhNEGxUEM41/mKrxK+
	mhff9oNuny/3WOF3ts1ym9ICcvH58H3LnfGflZlZuxCJnD8WAIzGq3DTip+vV6JZ
	c/aYwRcyDRKS/MIM3P8ZLAh8GUhpU+wAm3AY4JNqBgRHu+G/LJEP4b/V3Pz2LJJz
	Vdnu7bnjEn18GhxhJ11sw==
X-ME-Sender: <xms:zwSwZupumujRCqn2bUVecf6FPDAcxmwBSzO5UJkuz2F1wa4XzlHkVw>
    <xme:zwSwZsqRFT0wM0LXiO6mZBhQcX5YUxOvscQgCKvGRrYUJmhuDw-iES9eWuqzGInk2
    fcHgG1qTebsDuef>
X-ME-Received: <xmr:zwSwZjPnwuxKM_qCO4BtIIVHXB2_HBaw-qxdpbeoH9d1IRa-ayFP3TQLvcSmRC836ihWIsb2yzH6_8eNcDww5tAcJm3TQJ-AsAjGwShr0CkjL9GBUp-j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeehgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:zwSwZt6um4wIcWULyTiA6FHRj_-4gAAeWtSMLb-WTFrZtcGGx88MIw>
    <xmx:0ASwZt6sULIt6cWJbP-q5ZCClY1P9_CuYNODIXK9t15IZfr2l5wgGQ>
    <xmx:0ASwZtiqN8kUzVkGvCAa9U0LG8GkPF2xXKbJwTXVazJtyYEpj5jiMw>
    <xmx:0ASwZn5f7_HGg9EcaKZUAVP7ZEe53KN9MRMBG7EFXjrSngaQsTHCIQ>
    <xmx:0ASwZqtiifEAJIWXXYjp1RWfhlzGS-MHGRyUUqvuNyq5LHnEPhHq5Qkp>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Aug 2024 18:46:38 -0400 (EDT)
Message-ID: <51a1d881-d3c6-4be6-93e7-358200df1bdd@fastmail.fm>
Date: Mon, 5 Aug 2024 00:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, laoar.shao@gmail.com, kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240730002348.3431931-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 02:23, Joanne Koong wrote:
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
>  fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++--
>  fs/fuse/fuse_i.h |  14 ++++
>  fs/fuse/inode.c  |   7 ++
>  3 files changed, 200 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..9992bc5f4469 100644
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
> @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
>   * the 'end' callback is called if given, else the reference to the
>   * request is released
>   */
> -void fuse_request_end(struct fuse_req *req)
> +static void do_fuse_request_end(struct fuse_req *req, bool from_timer_callback)
>  {
>  	struct fuse_mount *fm = req->fm;
>  	struct fuse_conn *fc = fm->fc;
>  	struct fuse_iqueue *fiq = &fc->iq;
>  
> +	if (from_timer_callback)
> +		req->out.h.error = -ETIME;
> +
>  	if (test_and_set_bit(FR_FINISHED, &req->flags))
>  		goto put_request;
>  
> @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
>  		list_del_init(&req->intr_entry);
>  		spin_unlock(&fiq->lock);
>  	}
> -	WARN_ON(test_bit(FR_PENDING, &req->flags));
> -	WARN_ON(test_bit(FR_SENT, &req->flags));
>  	if (test_bit(FR_BACKGROUND, &req->flags)) {
>  		spin_lock(&fc->bg_lock);
>  		clear_bit(FR_BACKGROUND, &req->flags);
> @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
>  		wake_up(&req->waitq);
>  	}
>  
> +	if (!from_timer_callback && req->timer.function)
> +		timer_delete_sync(&req->timer);
> +
>  	if (test_bit(FR_ASYNC, &req->flags))
>  		req->args->end(fm, req->args, req->out.h.error);
>  put_request:
>  	fuse_put_request(req);
>  }
> +
> +void fuse_request_end(struct fuse_req *req)
> +{
> +	WARN_ON(test_bit(FR_PENDING, &req->flags));
> +	WARN_ON(test_bit(FR_SENT, &req->flags));
> +
> +	do_fuse_request_end(req, false);
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
> +	do_fuse_request_end(req, true);
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
> +	do_fuse_request_end(req, true);
> +}
> +
> +static void fuse_request_timeout(struct timer_list *timer)
> +{
> +	struct fuse_req *req = container_of(timer, struct fuse_req, timer);

Let's say the timeout thread races with the thread that does
fuse_dev_do_write() and that thread is much faster and already calls :

fuse_dev_do_write():
	fuse_request_end(req);
	fuse_put_request(req);
out:
	return err ? err : nbytes;


(What I mean is that the timeout triggered, but did not reach
FR_FINISHING yet and at the same time another thread on another core
calls fuse_dev_do_write()).

> +
> +	/*
> +	 * Request reply is being finished by the kernel right now.
> +	 * No need to time out the request.
> +	 */
> +	if (test_and_set_bit(FR_FINISHING, &req->flags))
> +		return;

Wouldn't that trigger an UAF when the fuse_dev_do_write() was proceding
much faster and already released the request?

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
> @@ -409,7 +506,8 @@ static void request_wait_answer(struct fuse_req *req)
>  
>  static void __fuse_request_send(struct fuse_req *req)
>  {
> -	struct fuse_iqueue *fiq = &req->fm->fc->iq;
> +	struct fuse_conn *fc = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fc->iq;
>  
>  	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
>  	spin_lock(&fiq->lock);
> @@ -421,6 +519,10 @@ static void __fuse_request_send(struct fuse_req *req)
>  		/* acquire extra reference, since request is still needed
>  		   after fuse_request_end() */
>  		__fuse_get_request(req);
> +		if (req->timer.function) {
> +			req->timer.expires = jiffies + fc->req_timeout;
> +			add_timer(&req->timer);
> +		}

Does this leave a chance to put in a timeout of 0, if someone first sets
 fc->req_timeout and then sets it back to 0?


(I'm going to continue reviewing tomorrow, gets very late here).


Thanks,
Bernd

