Return-Path: <linux-fsdevel+bounces-40715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E920EA26FC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5A31886B06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC0C1FFC79;
	Tue,  4 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="WIdA212e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Huum7Pha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC0E20C006
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667041; cv=none; b=SZe3hXgWmOTH2xQ7+WMvq6Z85rQH/2eCVGwI5YAPnb4loMqSszMh8TtjTi291qkOKXxKWnPmxwC2dUfxKP0WTL2RuKM3eTjoqsMtDAPKMgNHnd4SOhme2ANsCInEQ9P5ohQG/izupI2Sjkkwb4JxGXEc3rrqBKdtPM7IwRXlkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667041; c=relaxed/simple;
	bh=FZzaytokswciD/9A/KFNDiyTNa7q6Xnr6A5Tr0dGeQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rb3mW4QKfPH4yiUtO9EOWhSWfQ3mqq/81AZpNLyPHMwNbcJJvQGxjybC2ygkVuupFaBTGm8YjzUkEUoKf50XQ7h+kQ3/223I57tFC4mBm8fguuBj9qmAjFg7vpLQm7yJksZOw53KP+C1VlU/nTWwF++eKWntTIUHYjSEVSuR4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=WIdA212e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Huum7Pha; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 969DA114017A;
	Tue,  4 Feb 2025 06:03:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 06:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738667037;
	 x=1738753437; bh=EZeqCX+Md/RqmXa3jFIvpMvMve9T5jYILRnCSvWAZtU=; b=
	WIdA212eLlk/sFW23VxRb25cuKCOkc+MHQPbgXiureYLL47ISjpzGCwtb+bmtAIa
	AnTVlK7pR5t81L3TVGmYE/5Ekpyw8Fr+EoDdKk1iy3hp6OIjC5Dk3Ech9EWePOo6
	HG8oe+Q8ng4BrMHjVlO6F4UsCgTkV0E2X9NuYzsCwohUzI3SgNCkNQputh5lGBT+
	Whl2oYnadtH5MvDjjQPQ3oVH/LnaZAGysF3Ya2L3odIcoskRRVPCOPX966Oft35v
	JQ69UVzNF0TKV2a0DyWD0T8RShOF+zHrpIVhrDnZ2gPfZ0daxByN3KgL8rDABuUY
	43bHmiNiPFoRDllyWYhS5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738667037; x=
	1738753437; bh=EZeqCX+Md/RqmXa3jFIvpMvMve9T5jYILRnCSvWAZtU=; b=H
	uum7Pha1I5gi1+iGp7HewnJmJNT43kjd4z/GIs10oFncPoR1CshH0hSRGDIkJAVZ
	nJNIv10OErt+4K6huYBuUCCLEuujuCI/uzwRhB/ep1kbKm2K/Rktk0sFNs4QJlSz
	I3f42xsTpY3hfO0sks/xelmqM+L20RZBpH8CcFukI1AS5I4aMtwaBxt6XJHKZBqk
	VuulBttixErpgiwWiMe87fteGTVm4lX3NrzSdg6Mmd8fGWG1G0bqYhQZJDv+qoWv
	gxxwmTm8wNNJnfZKE/Sj1lX2A8mxInY3lXamkYdffIKcDJ5WZklcVQZsWcC0U+pS
	9CHj1yCFTKADIHLonH8iA==
X-ME-Sender: <xms:HPShZ_qDAhiYlkGWI00UGz1pXj1eludw7Lul9QIZuo8hJucrWIOCpQ>
    <xme:HPShZ5rpEjoQg7bKouSIgQ7ppL7_op9d-e9lc8XzBHylR-jnqv_xH8-IJb6MPFw4K
    w3Mqxc9N1yxNs2g>
X-ME-Received: <xmr:HPShZ8MqRpV96PXQ_6C8_O3RpMNzo1j0rVC4sMiGMn5a9YksNmtOusONn0U0qs0dO4dPRurtytroZkv0HE-ctgr-Hcf5ptmzcCOiGXwmyXso_gGNjERe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdefgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:HPShZy7T8mNoah50hp69BZPnqbxSyTTkN5dFQj7S9VeTT4D6GjzESA>
    <xmx:HPShZ-4Cy4bqP1gjmOs6J1LHdyPEXAizqwNQHiJ93K_XJqF-lj_Ehw>
    <xmx:HPShZ6ivYGGjKmJ82WLswxwdFvcuAUY-aoyzf_8GjjNWYbLH2eEN9A>
    <xmx:HPShZw5MeWW3s5WUH_kGhKanE9avsmx8LDLttNHp_Qk1nBDZ4dmL9w>
    <xmx:HfShZ50O1288gi4Ect41H9L18z2eMhDIHRMRm7YYA28Zs4CL2Kn9UjOh>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 06:03:56 -0500 (EST)
Message-ID: <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
Date: Tue, 4 Feb 2025 12:03:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250203185040.2365113-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

On 2/3/25 19:50, Joanne Koong wrote:
> req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
> bit is cleared from the request flags when assigning a request to a
> uring entry, the fiq->lock does not need to be held.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch support")
> ---
>  fs/fuse/dev_uring.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ab8c26042aa8..42389d3e7235 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
>  			ent->state);
>  	}
>  
> -	spin_lock(&fiq->lock);
>  	clear_bit(FR_PENDING, &req->flags);
> -	spin_unlock(&fiq->lock);
>  	ent->fuse_req = req;
>  	ent->state = FRRS_FUSE_REQ;
>  	list_move(&ent->list, &queue->ent_w_req_queue);

I think that would have an issue in request_wait_answer(). Let's say


task-A, request_wait_answer(),
		spin_lock(&fiq->lock);
		/* Request is not yet in userspace, bail out */
		if (test_bit(FR_PENDING, &req->flags)) {  // ========> if passed
			list_del(&req->list);  // --> removes from the list

task-B, 
fuse_uring_add_req_to_ring_ent()
	clear_bit(FR_PENDING, &req->flags);
	ent->fuse_req = req;
	ent->state = FRRS_FUSE_REQ;
	list_move_tail(&ent->list, &queue->ent_w_req_queue);
	fuse_uring_add_to_pq(ent, req);  // ==> Add to list



What I mean is, task-A passes the if, but is then slower than task-B. I.e.
task-B runs fuse_uring_add_to_pq() before task-B does the list_del.


Now the ring entry gets handled by fuse-server, comes back to fuse-client
and does not find the request anymore, because both tasks raced.
The entire ring entry will be lost - it not be used anymore for
the live time of the connection.

And the other issue might be total list corruption, because two tasks might
access the list at the same time.


Thanks,
Bernd


