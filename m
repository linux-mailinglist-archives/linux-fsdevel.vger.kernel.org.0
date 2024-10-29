Return-Path: <linux-fsdevel+bounces-33157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF16B9B5297
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 20:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AED01F24533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 19:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7A1FF7C2;
	Tue, 29 Oct 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="uCOx5fKC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QiWQGqZ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1020606E
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229436; cv=none; b=bSHeapwAJd7T3SD0dEcrtkv3nCRU00FQ2/QUuD3d5qoztxcuDfHH/QsKuU5uVlO9CXrFmMBXMHCgm/BHuZaFYuG93iz8VP9sVhE2sRbYfyt+6pzho0yFQtGCMsj/OcPlzR3pwSzcB88usvHmU062wPSvQniEJ7P8MXfa0A9Ga+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229436; c=relaxed/simple;
	bh=P0kTE+NhGiftqcvLb1U1BlizCWEkB1an+T4deLiRfAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmi481cJuEuyION3IyOXjar+vWq2dPE/S5H/AGPCH3RlNKsc+EswhYobthCh4o9p7Yr4hZl6Nmvuaro4H+p9jWG6q6HnpZj+N+GoQYtREDqMYX0Ri2sq08RoO8k14UGCHLO2SYfKIxGnUGBn3H6Ap4W+K1w+yEAqpXRvbKsOJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=uCOx5fKC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QiWQGqZ9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 280CC13800EC;
	Tue, 29 Oct 2024 15:17:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Oct 2024 15:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730229432;
	 x=1730315832; bh=0773r7iPRBrQdgMTMOTySRelBKRWAx4ryJDSP++t5q4=; b=
	uCOx5fKC3tJ5gBjbnbuB7c7xyV6cYWf1/B4cNqpeapkm2mK2Zxg/0tZOlHvFKZGX
	9v4+vyoZ7FS+IXSU8VjT05l2xUVB1Dvhj4WN5E+KCyz8+QKoH0wfALGOIsfrwODS
	FaseTjMRBu3u7gNiGL/LI9NfGW+EoP6yQhuvMflUjDVkpM4em0syltz5uUhkP7Cp
	NCWHFw9N/t3xHQF2dixyk/dLeaUHuKO8id8/qAiJJNgFyRj9IRPKCPRTw82GVaz/
	H33cBOMQ+jQ3DBmovcr6u4gQaNwnvTwxIEZZEwtXviHukugLqeSHvkHl/ZWo1/H+
	eprHQSL6UE/brGM2QYFDIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730229432; x=
	1730315832; bh=0773r7iPRBrQdgMTMOTySRelBKRWAx4ryJDSP++t5q4=; b=Q
	iWQGqZ9LrN7u6H8epD3S+dPx5TQTTBxjR+Hrgm8g0xwj0mXseRtHtQbPge7LSDlL
	HTZQFbsZkpTmv7kxRG1iD6zK2YJXFOX+cPVnVYv5D2CeVvaykCIjxi9WNhfhXMyt
	Dm2PZowULfoBJkD5OrTuzrQNoQFyR5vaRiRnB/JUJdZCzspUwWunTqutj0HokglZ
	BSY1/m0baJktiaUx8hVWMdyeo72BOW6zQKQ64KY5JjcqYQD1Y0Ne0zM+O4B2X+eh
	Cvh51PqXoREJ9eYv55mzHU19QltfKv8nI4kcSsy6MdRg0pmAkZAAOPJUSs3IwJMu
	BYefR6lAcYxZAdW5MjjBQ==
X-ME-Sender: <xms:tjQhZ3Jb8kGZ5WNm516Xc4c_Xd-X-vrFe61XtDIbbbkIwx2Mlg_Qjw>
    <xme:tjQhZ7J3Z0OAne3EwEwUlIYIA10nKM6mc-NbUEWvzG1cp3fdSPwZrN_xVRL6F3fVr
    7OWf6pF4tjsQ8hp>
X-ME-Received: <xmr:tjQhZ_s6EFSkfevGryJSuamyISqHIGypQs-O9BRt-BnLV5jb5M8r-d6EHYn67C4Pn-K3YF7olGtD1ApeQJhccpJdeeeKxgHHp5VbAcjN9T9-V7LGfBvG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihuse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrgho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrd
    gtohhm
X-ME-Proxy: <xmx:tjQhZwYLLq73rVclK9TkqWyRmLmD3E50rUcxSyBMkBGc79jKRbay3g>
    <xmx:tjQhZ-bZTSFrSimDuQhHzRI2K7Ib-pWCqTmfkyXgQzE4cxXEHNYj9A>
    <xmx:tjQhZ0AH2fSs9v6XXf1_bqTf9ky5M0RRhfQ16kJ7oIrIbRE1BdvzCg>
    <xmx:tjQhZ8Ynid79X_5Y2U-tPoAuax_X3oeTsJkwpc4XzmzRN0fv_gvM0g>
    <xmx:uDQhZ25SRtvkcjPndtjMzLcnRN8GfKEdywY1YPuYiYxpad6mPRYhp_bm>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 15:17:09 -0400 (EDT)
Message-ID: <9ba4eaf4-b9f0-483f-90e5-9512aded419e@fastmail.fm>
Date: Tue, 29 Oct 2024 20:17:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20241011191320.91592-1-joannelkoong@gmail.com>
 <20241011191320.91592-3-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241011191320.91592-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/11/24 21:13, Joanne Koong wrote:
> There are situations where fuse servers can become unresponsive or
> stuck, for example if the server is deadlocked. Currently, there's no
> good way to detect if a server is stuck and needs to be killed manually.
> 
> This commit adds an option for enforcing a timeout (in minutes) for
> requests where if the timeout elapses without the server responding to
> the request, the connection will be automatically aborted.
> 
> Please note that these timeouts are not 100% precise. The request may
> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> timeout due to how it's internally implemented.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 21 +++++++++++++
>  fs/fuse/inode.c  | 21 +++++++++++++
>  3 files changed, 122 insertions(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 1f64ae6d7a69..054bfa2a26ed 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,6 +45,82 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
>  	return READ_ONCE(file->private_data);
>  }
>  
> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
> +{
> +	return jiffies > req->create_time + fc->timeout.req_timeout;
> +}
> +
> +/*
> + * Check if any requests aren't being completed by the specified request
> + * timeout. To do so, we:
> + * - check the fiq pending list
> + * - check the bg queue
> + * - check the fpq io and processing lists
> + *
> + * To make this fast, we only check against the head request on each list since
> + * these are generally queued in order of creation time (eg newer requests get
> + * queued to the tail). We might miss a few edge cases (eg requests transitioning
> + * between lists, re-sent requests at the head of the pending list having a
> + * later creation time than other requests on that list, etc.) but that is fine
> + * since if the request never gets fulfilled, it will eventually be caught.
> + */
> +void fuse_check_timeout(struct timer_list *timer)
> +{
> +	struct fuse_conn *fc = container_of(timer, struct fuse_conn, timeout.timer);
> +	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_req *req;
> +	struct fuse_dev *fud;
> +	struct fuse_pqueue *fpq;
> +	bool expired = false;
> +	int i;
> +
> +	spin_lock(&fiq->lock);
> +	req = list_first_entry_or_null(&fiq->pending, struct fuse_req, list);
> +	if (req)
> +		expired = request_expired(fc, req);
> +	spin_unlock(&fiq->lock);
> +	if (expired)
> +		goto abort_conn;
> +
> +	spin_lock(&fc->bg_lock);
> +	req = list_first_entry_or_null(&fc->bg_queue, struct fuse_req, list);
> +	if (req)
> +		expired = request_expired(fc, req);
> +	spin_unlock(&fc->bg_lock);
> +	if (expired)
> +		goto abort_conn;
> +
> +	spin_lock(&fc->lock);
> +	if (!fc->connected) {
> +		spin_unlock(&fc->lock);
> +		return;
> +	}
> +	list_for_each_entry(fud, &fc->devices, entry) {
> +		fpq = &fud->pq;
> +		spin_lock(&fpq->lock);
> +		req = list_first_entry_or_null(&fpq->io, struct fuse_req, list);
> +		if (req && request_expired(fc, req))
> +			goto fpq_abort;
> +
> +		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
> +			req = list_first_entry_or_null(&fpq->processing[i], struct fuse_req, list);
> +			if (req && request_expired(fc, req))
> +				goto fpq_abort;
> +		}
> +		spin_unlock(&fpq->lock);
> +	}
> +	spin_unlock(&fc->lock);

I really don't have a strong opinion on that - I wonder if it wouldn't
be better for this part to have an extra timeout list per fud or pq as
previously. That would slightly increases memory usage and overhead per
request as a second list is needed, but would reduce these 1/min cpu
spikes as only one list per fud would need to be checked. But then, it
would be easy to change that later, if timeout checks turn out to be a
problem.


> +
> +	mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> +	return;
> +
> +fpq_abort:
> +	spin_unlock(&fpq->lock);
> +	spin_unlock(&fc->lock);
> +abort_conn:
> +	fuse_abort_conn(fc);
> +}
> +
>  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>  {
>  	INIT_LIST_HEAD(&req->list);
> @@ -53,6 +129,7 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>  	refcount_set(&req->count, 1);
>  	__set_bit(FR_PENDING, &req->flags);
>  	req->fm = fm;
> +	req->create_time = jiffies;
>  }
>  
>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
> @@ -2296,6 +2373,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		spin_unlock(&fc->lock);
>  
>  		end_requests(&to_end);
> +
> +		if (fc->timeout.req_timeout)
> +			timer_delete(&fc->timeout.timer);
>  	} else {
>  		spin_unlock(&fc->lock);
>  	}
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7ff00bae4a84..ef4558c2c44e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -435,6 +435,9 @@ struct fuse_req {
>  
>  	/** fuse_mount this request belongs to */
>  	struct fuse_mount *fm;
> +
> +	/** When (in jiffies) the request was created */
> +	unsigned long create_time;
>  };
>  
>  struct fuse_iqueue;
> @@ -525,6 +528,16 @@ struct fuse_pqueue {
>  	struct list_head io;
>  };
>  
> +/* Frequency (in seconds) of request timeout checks, if opted into */
> +#define FUSE_TIMEOUT_TIMER_FREQ 60 * HZ
> +
> +struct fuse_timeout {
> +	struct timer_list timer;
> +
> +	/* Request timeout (in jiffies). 0 = no timeout */
> +	unsigned long req_timeout;
> +};
> +
>  /**
>   * Fuse device instance
>   */
> @@ -571,6 +584,8 @@ struct fuse_fs_context {
>  	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
> +	/*  Request timeout (in minutes). 0 = no timeout (infinite wait) */
> +	unsigned int req_timeout;
>  	const char *subtype;
>  
>  	/* DAX device, may be NULL */
> @@ -914,6 +929,9 @@ struct fuse_conn {
>  	/** IDR for backing files ids */
>  	struct idr backing_files_map;
>  #endif
> +
> +	/** Only used if the connection enforces request timeouts */
> +	struct fuse_timeout timeout;
>  };
>  
>  /*
> @@ -1175,6 +1193,9 @@ void fuse_request_end(struct fuse_req *req);
>  void fuse_abort_conn(struct fuse_conn *fc);
>  void fuse_wait_aborted(struct fuse_conn *fc);
>  
> +/* Check if any requests timed out */
> +void fuse_check_timeout(struct timer_list *timer);
> +
>  /**
>   * Invalidate inode attributes
>   */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index f1779ff3f8d1..a78aac76b942 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -735,6 +735,7 @@ enum {
>  	OPT_ALLOW_OTHER,
>  	OPT_MAX_READ,
>  	OPT_BLKSIZE,
> +	OPT_REQUEST_TIMEOUT,
>  	OPT_ERR
>  };
>  
> @@ -749,6 +750,7 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
>  	fsparam_u32	("max_read",		OPT_MAX_READ),
>  	fsparam_u32	("blksize",		OPT_BLKSIZE),
>  	fsparam_string	("subtype",		OPT_SUBTYPE),
> +	fsparam_u16	("request_timeout",	OPT_REQUEST_TIMEOUT),
>  	{}
>  };
>  
> @@ -844,6 +846,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
>  		ctx->blksize = result.uint_32;
>  		break;
>  
> +	case OPT_REQUEST_TIMEOUT:
> +		ctx->req_timeout = result.uint_16;
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -973,6 +979,8 @@ void fuse_conn_put(struct fuse_conn *fc)
>  
>  		if (IS_ENABLED(CONFIG_FUSE_DAX))
>  			fuse_dax_conn_free(fc);
> +		if (fc->timeout.req_timeout)
> +			timer_shutdown_sync(&fc->timeout.timer);
>  		if (fiq->ops->release)
>  			fiq->ops->release(fiq);
>  		put_pid_ns(fc->pid_ns);
> @@ -1691,6 +1699,18 @@ int fuse_init_fs_context_submount(struct fs_context *fsc)
>  }
>  EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
>  
> +static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
> +{
> +	if (ctx->req_timeout) {
> +		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_timeout))
> +			fc->timeout.req_timeout = U32_MAX;


ULONG_MAX?

> +		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> +		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> +	} else {
> +		fc->timeout.req_timeout = 0;
> +	}
> +}
> +
>  int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  {
>  	struct fuse_dev *fud = NULL;
> @@ -1753,6 +1773,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	fc->destroy = ctx->destroy;
>  	fc->no_control = ctx->no_control;
>  	fc->no_force_umount = ctx->no_force_umount;
> +	fuse_init_fc_timeout(fc, ctx);
>  
>  	err = -ENOMEM;
>  	root = fuse_get_root_inode(sb, ctx->rootmode);


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

