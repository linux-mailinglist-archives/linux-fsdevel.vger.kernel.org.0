Return-Path: <linux-fsdevel+bounces-40037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D4A1B4C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 12:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F0116AF6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E6207A03;
	Fri, 24 Jan 2025 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="NAxM7vAu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2WCNTaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041E1AAA3D
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737718241; cv=none; b=Wp5RB2R/j6faaNEVEK7wZP/zjR93jFmE5T2LYVi67PDknVpHnn9AcHyUMa+cGaBpeyQkZtV2mBhFCmtVyKL4cQCi+cs4RH9tpg5YWlqCdcON1DOpiWtt03/DnDi0JoI7AsBC9z7IK5CcvOsxDLkeAhkov6WqLLcIK7HqMDBNnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737718241; c=relaxed/simple;
	bh=wSDKzq2mRu8KpR5ebiyjBrJOJZqhEWeaadutU331CuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBBeukE2gRCHMCA42qi6kfqNQPnd4t/AHar87zBmZNXnU5uBe0jfpztR1Tc1E6Ed0bh5iHIiO15uejcAz43U5Txmj7Uh8GDEQLUaE7mMYhV6wGa1Voz9+hTHUSQeD0vC7Eb9pW2XJn4uyxussHzbcFK6eyDrMzoCMRx/TX9fzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=NAxM7vAu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2WCNTaf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB91311401D0;
	Fri, 24 Jan 2025 06:30:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 24 Jan 2025 06:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737718236;
	 x=1737804636; bh=eivNN8X9W42J8xTQ0lN4L9GLseWeUW0utNTtYOLHQhM=; b=
	NAxM7vAu2iWXszQxN5pl2jkhszlwe8TKRFYN1U/mBzSsT1zZKWMBL0Zh3eZ/y1DS
	gI2aEsr0BZExSHFbgV5KUut8cGFZ0gjELhU7WXTo5HRgzUFRYQ+fLqa1hvah32Rv
	/MHMlqlv0zbdpFLTNG10sJfjvrUsb6s9TwggW3BqQIyovOGyBPeMNyDjI4cYCnJw
	SsRgYJfYy5/WAW9WKMW00ELcwLxMKs3N3kex8a4vkqzN8NCqOgclwCyKZhILkC7L
	jiDlhu79vcS5wCmWR2BLtRKLvepgk3zmV3kkwTUX6HdYl61S8yvLylhpN0cmiFMw
	3Byz2lT2BLmtTraJLj6shA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737718236; x=
	1737804636; bh=eivNN8X9W42J8xTQ0lN4L9GLseWeUW0utNTtYOLHQhM=; b=U
	2WCNTafNfNjTeLtsINSv1DNB+FoGZLo1ZVQrsKi4Y2Wfc3/ydf/E6ubDhYOtuuSX
	BGiE8n/XPQuqB3o5IsmDDTIHTa0Xlcadf7FlzXGISdlm+keD3T0cozBFkSyQz6ko
	hhs0zBK5/iYJhC9NMzXZJvOvNvEy+1nD7OrC+PVjcnLETsgoM+/DiASkYNtrblXs
	U1rTb3a4zNuo4bETL+y9f8oQ/gBY1gtgD2E05qqANwm3UrT/5VtGV9aEu3A10nol
	aofLpihMFpQPuKnjLc0h/Cjp/MYQpjQ9VL23vbmJsUB+IeDgHLU2gQF2hVSUfQql
	tGvZyeyKxhwIPsrtwW8VQ==
X-ME-Sender: <xms:3HmTZ6o_EAHb8azne-5zaC0tn3ddYvVUJLuVRx75FbCcxSlyKy6TIg>
    <xme:3HmTZ4rzy3ElSjO4GkA65xcg6_bZN-hUWfTUzQUZcaU7tq884sl9mHahUPskSg1gR
    Gt_GUGrjOMH14C8>
X-ME-Received: <xmr:3HmTZ_MFPdcoCsCw0L8wkP93eK4Sp1BFZ4r9Dl4Pzl8TKbek_69i1MKUMjMYfxNFXHYO1x3J7bcHJxd4JzPkQumblg8t-awuKVHgVute9ZvvDcXuOjuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedggeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:3HmTZ55GO_PQjw2JX43A6Qveo5CbvzpWgXunUbzJyq9vWQ77iQCMMQ>
    <xmx:3HmTZ57JmisM8IXoqCtwu5V2xVYNiYPoxRRLX-BZBXKOTGXZ0XnncQ>
    <xmx:3HmTZ5homgQ6ZvNr56QAditp-Ttnw1uJ9_BN1YGJNu51QVSlHwdcAA>
    <xmx:3HmTZz6qdF4O7iF0StQZygaMxglKhZGAmFSJkxip8M6QX6PBYAYhYA>
    <xmx:3HmTZ80CrhSmUfrhB9mHdMBzrHJ7jIV2GU7kHqw6p_8wU8Dj_MyTgqWc>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 06:30:35 -0500 (EST)
Message-ID: <11f66304-753d-4500-9c84-184f254d0e46@fastmail.fm>
Date: Fri, 24 Jan 2025 12:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: optimize over-io-uring request expiration check
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250123235251.1139078-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250123235251.1139078-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/24/25 00:52, Joanne Koong wrote:
> Currently, when checking whether a request has timed out, we check
> fpq processing, but fuse-over-io-uring has one fpq per core and 256
> entries in the processing table. For systems where there are a
> large number of cores, this may be too much overhead.
> 
> Instead of checking the fpq processing list, check ent_w_req_queue,
> ent_in_userspace, and ent_commit_queue.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c        |  2 +-
>  fs/fuse/dev_uring.c  | 23 ++++++++++++++++++++---
>  fs/fuse/fuse_dev_i.h |  1 -
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3c03aac480a4..80a11ef4b69a 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,7 +45,7 @@ bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list)
>  	return time_is_before_jiffies(req->create_time + fc->timeout.req_timeout);
>  }
>  
> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
> +static bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
>  {
>  	int i;
>  
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 5c9b5a5fb7f7..dfa6c5337bbf 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -90,6 +90,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
>  		fuse_uring_flush_bg(queue);
>  		spin_unlock(&fc->bg_lock);
>  	}
> +	ent->fuse_req = NULL;
>  
>  	spin_unlock(&queue->lock);
>  
> @@ -97,8 +98,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
>  		req->out.h.error = error;
>  
>  	clear_bit(FR_SENT, &req->flags);
> -	fuse_request_end(ent->fuse_req);
> -	ent->fuse_req = NULL;
> +	fuse_request_end(req);
>  }
>  

Oh, this is actually a fix, it should be always set with the lock being
held.



>  /* Abort all list queued request on the given ring queue */
> @@ -140,6 +140,21 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
>  	}
>  }
>  
> +static bool ent_list_request_expired(struct fuse_conn *fc, struct list_head *list)
> +{
> +	struct fuse_ring_ent *ent;
> +	struct fuse_req *req;
> +
> +	list_for_each_entry(ent, list, list) {
> +		req = ent->fuse_req;
> +		if (req)
> +			return time_is_before_jiffies(req->create_time +
> +						      fc->timeout.req_timeout);
> +	}
> +
> +	return false;
> +}

Hmm, would only need to check head? Oh I see it, we need to use
list_move_tail().  


> +
>  bool fuse_uring_request_expired(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring = fc->ring;
> @@ -157,7 +172,9 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>  		spin_lock(&queue->lock);
>  		if (fuse_request_expired(fc, &queue->fuse_req_queue) ||
>  		    fuse_request_expired(fc, &queue->fuse_req_bg_queue) ||
> -		    fuse_fpq_processing_expired(fc, queue->fpq.processing)) {
> +		    ent_list_request_expired(fc, &queue->ent_w_req_queue) ||
> +		    ent_list_request_expired(fc, &queue->ent_in_userspace) ||
> +		    ent_list_request_expired(fc, &queue->ent_commit_queue)) {
>  			spin_unlock(&queue->lock);
>  			return true;
>  		}
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 3c4ae4d52b6f..19c29c6000a7 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -63,7 +63,6 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
>  void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
>  
>  bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing);
>  
>  #endif
>  


