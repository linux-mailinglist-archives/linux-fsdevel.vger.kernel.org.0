Return-Path: <linux-fsdevel+bounces-24974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D199D947615
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFD41C20D50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8D144D1A;
	Mon,  5 Aug 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cUEVJCc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90031E505
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843137; cv=none; b=ge+HASjm/UjImkvmXmUstPPJpiAD6iPFVGsoIeQrmoMF/sK2uAM0x2whCm4ofxBVN80iK7QWi59fGZTuUq1M4fJpuFlmV7eBipAGN0MsW4VRQImTp5Nq3ZMWJCN5zyRv2EpKqLAE0icuk4fMqjwI8WoH7MFPbVQztOsrlsMHsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843137; c=relaxed/simple;
	bh=N1+kU05CoU/IeYt9WA13/LtZ7eOLOebLXExfGSNBgZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwbuIkvs/wZK2Dxj/OSHfiSAN+hWCjgwikx8OcSt8mI6gu86UcaLTaVQzyAxwUGDbvs21EZ5mgoGAn0wIks7t23gQfILeyh3hL1sUBxM+VebRbacF890k07Of/RTkQKcUYIfL6ut2Qb0bHTAnNGwgb0shXMzcsXoMMmwalzj/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cUEVJCc7; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722843127; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZSgSQ37mNenrRk1ciUgokqBXo1uhoIjA02yLya5toH4=;
	b=cUEVJCc7/HCwCPTPB1iAENyMpdts8NzYwhSXSLnkMlEDO4oQ0JrG8KvKNCMdb2j+heoOkgll2oZNCP31GZrc+JyJSUY4zQrYXjxpSO0TyOoci5fa+8VQJMu+Dejb8bMYQI+1Uuvs9cebhdMRazrtZLclv+SKneEU/fXvJ00/kN4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WC63wri_1722843125;
Received: from 30.221.145.203(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WC63wri_1722843125)
          by smtp.aliyun-inc.com;
          Mon, 05 Aug 2024 15:32:06 +0800
Message-ID: <ffce4a22-5104-4707-812b-962638e45aeb@linux.alibaba.com>
Date: Mon, 5 Aug 2024 15:32:01 +0800
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
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240730002348.3431931-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 8:23 AM, Joanne Koong wrote:
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

FMHO, could we move the above error assignment up to the caller to make
do_fuse_request_end() look cleaner?


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

Similarly, move the caller i.e. fuse_request_end() call
timer_delete_sync() instead?


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

Just out of curious, why fc->bg_lock is needed here, which makes the
code look less clean?


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

I'm not sure if special handling for requests in fpq->io list in needed
here.  At least when connection is aborted, thos LOCKED requests in
fpq->io list won't be finished instantly until they are unlocked.



-- 
Thanks,
Jingbo

