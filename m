Return-Path: <linux-fsdevel+bounces-44309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8F9A67183
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC377A993B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29D207A33;
	Tue, 18 Mar 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="SM2SaPkE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KEJ7Y/Zq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C27F2080CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294335; cv=none; b=sMj4nErPjrqz8GmswrqVR6rTssp0sc2beBsbAUIvTgIwjfJl9CyPHc0QGVKXyuz9BYnvzzzlZzZUPShgq4I59/q2yIIM1rhJvAlB30F7V7F5YLl5OUXrLUitJlCiYW6iuH+YwfjLvgQai5lTHzDcsLbzG6KvZgt4zb+nJv71FvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294335; c=relaxed/simple;
	bh=eojSfRiCnhvLL8Sk7LIGbM3RWONvNNRMk4hoeH/YM/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGQquFQEM3/uKJYxN1jXKzD0UPqYh5NXD47kWVJNOrSo721UnJ+96CbEsoKBa1CD839kJN9DEsLj00UC7ipYI0dY8kR8BG9Q+5pp4E8YOcBUAtSg8Tbl3cq5UBBslk73JD5GvmsaKnK6oECMSvPxdG03KRaJAKP3SMA5Ap3k5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=SM2SaPkE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KEJ7Y/Zq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A883A2540191;
	Tue, 18 Mar 2025 06:38:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 06:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742294331;
	 x=1742380731; bh=xMK9swX+xySOu4N8Bmoue8ORdFCbO9Jq6Y8jpj7cVAU=; b=
	SM2SaPkEW3Wh0h32a9W9ruH4pE5RjsWm3m3OM27iI7L7m4Uue+Oxw30OVjjZ/b0y
	4Ryu3Oem9P8ypsqwGzs5Igaq3DgYJKQKnBv1NbNaNttBzbRiWsBjFDpuG5FBdpxU
	B6Zap9R7qjZgbex5pZSTn7MzKWznn81ILaiFCiWAXCbpCwxP3vEV0i3RQtg+tZnK
	LzGRULO5v8rdrIVN9TXauRENF5MsGQ7YXWkvH9G/uDqgYG90nhuzTigWxfcYeqRk
	LO0+HTCPay1pw0SpWbmDq+ktbMQ8jbaRk0lFJM+k2SuHYOWjV2p1jNyPJLM6x0ar
	WodDxK3MN5MFh/88zj0mEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742294331; x=
	1742380731; bh=xMK9swX+xySOu4N8Bmoue8ORdFCbO9Jq6Y8jpj7cVAU=; b=K
	EJ7Y/ZqIMzTgx+CHT4pQ/mn+QUC+vtNmGJKi+ZnGuaFRkIwlUueJZIjNmUW1bhDp
	F+0f456wsDGNfpqgpwqK2DZar20lRoRi1AXxQgTTs5YeUL/mgJupLwTskqX12x/B
	9fePu+AS0s4v/BEvUm+yTbNqaSJqwh6u8aeQAWiTMMT+YR4l20f0dNmogvdH1mZk
	CLBMEoV05JFfdjulA0Ax/ot7xhOVzMEHm13YKfKGetZCypsSXx2iZFssMxaPUSnt
	PiM+9Had5+yAH0e/mh1EygIwO/CkWs+ZLkx7aR4QLbs4n814e0H2drE5ilBW/ZXn
	PUC2mnV46NeVazyrjj1ag==
X-ME-Sender: <xms:O03ZZxPSayoVHXnOfe-8rTrngzGO3RDIPJq6s2o11VtoCFCrsy7OvA>
    <xme:O03ZZz-gH1owOGI2tIahW3pwHvqhUPQWI-GJt77lZq5m8vMdyS5lHxHbccZ2YUC0R
    jU4ympCgf3uL4y0>
X-ME-Received: <xmr:O03ZZwQt5BwmrnGy-ZxdUUZ1MZzZVseXkzcWCLLlA-AGLzSqwIBF7V0JBVszNnE9azrqz017Zui8UQSRVdvYGfYJiYaPhIh2duAKd8KbHTMK3PjwHwtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepffejveeffeej
    gffhfefhieeuffffteeltdfghffhtddtfeeuveelvdelteefvedtnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorghn
    nhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsii
    gvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrd
    gtohhm
X-ME-Proxy: <xmx:O03ZZ9suLIoQJoNhGCCUFWP0fJWXP_-VtDa2TalIKFcSDUYG57hMsA>
    <xmx:O03ZZ5d5EN-4-FHnOO4QZJtlJLEeXu1I4UBuAOSxiJOkM85Me2DUXQ>
    <xmx:O03ZZ50LXFHHSOGauk1CYsE-6Rifc5jZOhGVNQtGrkQx-wx05UjLjg>
    <xmx:O03ZZ1-R-aNPJk8XGnBNvBMbiIlaPy8dcVl_JB6p9CV-BYzmPv7k4A>
    <xmx:O03ZZw5NIn1eXXALcz47IW4xpA76kkT6p9C9mjPkv5acbQaOkRrgcfHY>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 06:38:50 -0400 (EDT)
Message-ID: <fd9ba4b3-319a-443c-966e-b34eaca8d24c@fastmail.fm>
Date: Tue, 18 Mar 2025 11:38:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: fix uring race condition for null dereference of
 fc
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250318003028.3330599-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250318003028.3330599-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/25 01:30, Joanne Koong wrote:
> There is a race condition leading to a kernel crash from a null
> dereference when attemping to access fc->lock in
> fuse_uring_create_queue(). fc may be NULL in the case where another
> thread is creating the uring in fuse_uring_create() and has set
> fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> reads ring->fc. There is another race condition as well where in
> fuse_uring_register(), ring->nr_queues may still be 0 and not yet set
> to the new value when we compare qid against it.
> 
> This fix sets fc->ring only after ring->fc and ring->nr_queues have been
> set, which guarantees now that ring->fc is a proper pointer when any
> queues are created and ring->nr_queues reflects the right number of
> queues if ring is not NULL. We must use smp_store_release() and
> smp_load_acquire() semantics to ensure the ordering will remain correct
> where fc->ring is assigned only after ring->fc and ring->nr_queues have
> been assigned.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
> 
> ---
> 
> Changes between v2 -> v3:
> * v2 implementation still has race condition for ring->nr_queues
> *link to v2: https://lore.kernel.org/linux-fsdevel/20250314205033.762641-1-joannelkoong@gmail.com/
> 
> Changes between v1 -> v2:
> * v1 implementation may be reordered by compiler (Bernd)
> * link to v1: https://lore.kernel.org/linux-fsdevel/20250314191334.215741-1-joannelkoong@gmail.com/
> 
> ---
>  fs/fuse/dev_uring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ab8c26042aa8..97e6d31479e0 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -235,11 +235,11 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  
>  	init_waitqueue_head(&ring->stop_waitq);
>  
> -	fc->ring = ring;
>  	ring->nr_queues = nr_queues;
>  	ring->fc = fc;
>  	ring->max_payload_sz = max_payload_size;
>  	atomic_set(&ring->queue_refs, 0);
> +	smp_store_release(&fc->ring, ring);
>  
>  	spin_unlock(&fc->lock);
>  	return ring;
> @@ -1068,7 +1068,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>  			       unsigned int issue_flags, struct fuse_conn *fc)
>  {
>  	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe_cmd(cmd->sqe);
> -	struct fuse_ring *ring = fc->ring;
> +	struct fuse_ring *ring = smp_load_acquire(&fc->ring);
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent;
>  	int err;

I was actually debating with myself that smp_load_acquire() on Friday. 
I think we do not need it, because if the ring is not found, it will 
go into the spin lock. But it does not hurt either and it might
cleaner to have a pair of smp_store_release() and smp_load_acquire().


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

