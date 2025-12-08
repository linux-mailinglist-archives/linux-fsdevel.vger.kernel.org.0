Return-Path: <linux-fsdevel+bounces-70984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802BCAE5D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 23:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8493014614
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 22:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67929B795;
	Mon,  8 Dec 2025 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="2SliMHUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tRXAwjfs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C671EA84
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765234218; cv=none; b=HQ1LJE1T+cvJOyassPxDGSQBrb4TuU8NURnIQ8sJ2BWozDY59GuaUNUTQ7NGDRK6Lq2EkbXl9jMjQM/ii8+VTTTk9rufELN+Jrog1nolNBV/bkKIxmcGvJfQt3xORAB0ncLmDF3ZDJRKiWURkvZhHKe7qN4YBKnb7iAwyu/ZW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765234218; c=relaxed/simple;
	bh=KvTSu5K+G7/bwJZIr3Wgxm8Y2UxeDY/IGOjh6bO8jvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYXnnC7wZ8BK9vWOv2VRBHD/ietB20Wu7as5AQa1AzzJQznhkCPSbOExOMU5RmmyYRV90vlZzbVTkOa+0butURyKuTkbbRNCetN68A/kSgTIqrT/2U/8pDvu7vCEeQ9YMsHzg6MVj4CBSQ48pDv0ji9LcrlcbETG7AYLpTRJDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=2SliMHUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tRXAwjfs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35B57140020F;
	Mon,  8 Dec 2025 17:50:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Dec 2025 17:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765234214;
	 x=1765320614; bh=lLXmXDpRnhzfWaE3XISz3MOd9E8rJyTsfepw3TQVaRc=; b=
	2SliMHUitCoQKcoP3PLImyIbj6FidZaORZfXG3DgwwSdZ7moyD7pOKN4LRPyvmhV
	ZqPaCij2rO5rY0l4c8fl2gpbagXok8N80fkfbiH0gVAIe5wqLbPD65SNUX1o9GdU
	rd8sxOOJyj/SsIrbMeYgseEfDu713gWMf6bOhhNlNhkzsB5Lr0ImEvY4OPw+PfGj
	Z6QVsjm8j7viv6kgHSv8TCMoPFN9YC61llYj66eU8L7PUD1F/f7ZH6TfR49n1TRl
	zkLcItBIcRnFUqeLiaKVDX1tptjMaMwo/Pxd3ziqH/DrTvgJlFtILs/bdRVZZ5UM
	FJsdZ/DlPgSFZX26XfIQIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765234214; x=
	1765320614; bh=lLXmXDpRnhzfWaE3XISz3MOd9E8rJyTsfepw3TQVaRc=; b=t
	RXAwjfsoX9qFbRMkbOoyzPpe3fAECj17K4FNnnFQfXDgOfAetH/IoW3I/rKq+fYL
	IdoIIgdvtul4ZtBCavwn6NVnHZqh21bZH1Is8vP4JX1P0YmBZuqVmqld++3I4hgn
	Wm10KTKCaBWmqsEZ/ygyqkNV0fQwoi6EppHVHTEo3wUKbEH0U3cwUreqBcjfygqS
	VFv1IjexUI1nuxkfQ23VAG+dfl04JdRAIUP0N6VuxAwzwOFZMe094bR12nnz0PyH
	BSzIHyIxfD05GRNgmXgCZrLo9wBtBEqGXgntFpuxnev/2pWe55xgxXa6f4CW9mtp
	E8eJH24ZVs7ZVMach2RpQ==
X-ME-Sender: <xms:JVY3aTMuqWzVigPbTySD_AYS8VfMOEIz8w6y1MbW_6FmC2a2EjqJ1w>
    <xme:JVY3aRq__wsGewTehJTWkWMqpMOtbstJMeLjAXIUqwAslAsVkdR8QZ4c7RiM_yxuX
    juKNDxJ3HczSDq5bSfW0ZIAXxzg9OigvZ9kN5NMxL4yx_rz77E>
X-ME-Received: <xmr:JVY3acEUUeL78x1hxFxmXeAJ2-vq_r4sOvuvwVWYZ-Xk-o81k9HFPlL4LByxf6rGBkBqPKUn6WneIvo8plLQMBQlAWPfmWv2sPbNSTB59y_VWOR9e829>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgs
    vghrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeehhfejueejleehtdehteefvdfgtd
    elffeuudejhfehgedufedvhfehueevudeugeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghordhl
    ihhlohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrh
    gvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprh
    gtphhtthhopeihrghnghgvrhhkuhhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehl
    ohhnuhiglhhirdeigeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:JVY3aeqrBJmXc-cobE9jQTTiKOq6o8T-IY_chrTgnZ_rQ4M8WjS52w>
    <xmx:JVY3adY9nyf22PyChk0y8aeEg1r8x5roOUinLkDPPqIpmmnxsz195w>
    <xmx:JVY3afW20xRl4jz-RbOJz3X7q9YL6zdzjnfD1LkSRZhugTtZs4UxJQ>
    <xmx:JVY3ae96aUIp8R_l_B1Bu2qs1e72znoi1W0ThlLlBtYe5warB2J6kA>
    <xmx:JlY3aRfSa9zNnmEw9fg6yVU4nEaB22sIfoJ2LZDeK0RaUAB49fHGMVMz>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 17:50:12 -0500 (EST)
Message-ID: <c486d34f-8b41-4a5e-84eb-dd37b0a63703@bsbernd.com>
Date: Mon, 8 Dec 2025 23:50:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: limit debug log output during ring teardown
To: Long Li <leo.lilong@huawei.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com, yangerkun@huawei.com,
 lonuxli.64@gmail.com
References: <20251204023219.1249542-1-leo.lilong@huawei.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251204023219.1249542-1-leo.lilong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/25 03:32, Long Li wrote:
> Currently, if there are pending entries in the queue after the teardown
> timeout, the system keeps printing entry state information at very short
> intervals (FUSE_URING_TEARDOWN_INTERVAL). This can flood the system logs.
> Additionally, ring->stop_debug_log is set but not used.
> 
> Clean up unused ring->stop_debug_log, update teardown time after each
> log entry state, and change the log entry state interval to
> FUSE_URING_TEARDOWN_TIMEOUT.
> 
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
> v1->v2: Update teardown time to limit entry state output interval
>  fs/fuse/dev_uring.c   | 7 ++++---
>  fs/fuse/dev_uring_i.h | 5 -----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5ceb217ced1b..68d2fbdc3a7c 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -426,7 +426,6 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
>  		}
>  		spin_unlock(&queue->lock);
>  	}
> -	ring->stop_debug_log = 1;
>  }
>  
>  static void fuse_uring_async_stop_queues(struct work_struct *work)
> @@ -453,9 +452,11 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
>  	 * If there are still queue references left
>  	 */
>  	if (atomic_read(&ring->queue_refs) > 0) {
> -		if (time_after(jiffies,
> -			       ring->teardown_time + FUSE_URING_TEARDOWN_TIMEOUT))
> +		if (time_after(jiffies, ring->teardown_time +
> +					FUSE_URING_TEARDOWN_TIMEOUT)) {
>  			fuse_uring_log_ent_state(ring);
> +			ring->teardown_time = jiffies;
> +		}
>  
>  		schedule_delayed_work(&ring->async_teardown_work,
>  				      FUSE_URING_TEARDOWN_INTERVAL);
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..4cd3cbd51c7a 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -117,11 +117,6 @@ struct fuse_ring {
>  
>  	struct fuse_ring_queue **queues;
>  
> -	/*
> -	 * Log ring entry states on stop when entries cannot be released
> -	 */
> -	unsigned int stop_debug_log : 1;
> -
>  	wait_queue_head_t stop_waitq;
>  
>  	/* async tear down */


Thank you! I'm still interested in, if you get repeated warning messages.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

