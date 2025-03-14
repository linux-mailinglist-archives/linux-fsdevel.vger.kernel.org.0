Return-Path: <linux-fsdevel+bounces-44039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC436A61AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 20:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FE719C3830
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BD92046BB;
	Fri, 14 Mar 2025 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="NbTEZ9oL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mBNcjPNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30A15886C
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981621; cv=none; b=aXNYXNt/6WzF/POLhKULkOuiyG6oXFhqLbMz8Vev+rGV+AhLBVLpN2np/xSCI9LQHnIOKdRNsdvEmVofRUHoTP7ftPPys7XYRdTMb2U5W6ORHQaiZa5dfaCXi+8iweyV7MYRjhxPr3Ril0Ov3lefytgNNbhsHcR9pwbPz2axuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981621; c=relaxed/simple;
	bh=XikpaWhjgsr+X06X1ZHLZoNDivJOIr+PS9j9Y/Mk9sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0vQPKM2wHnep6plHV1Tf+myPpA0zKTYKy5/hIbQ16YYdNtiRbrB/mIFwqRvn1BdUVbMrvS3jcAg4rqIIyUIWWCkGEaP50Kg21M0gOYQ8THWG9c5xtSEXXzfTGBpCTT3eiGUj9F94Z5PL0IOWMthzUfySr3lXo4BMJ9aaQu7GYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=NbTEZ9oL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mBNcjPNm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 16A8A1140170;
	Fri, 14 Mar 2025 15:46:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 14 Mar 2025 15:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741981617;
	 x=1742068017; bh=8xodwfwEn0U/1b1G74SDMqPf3LyEcvdzwzdCtZkfoww=; b=
	NbTEZ9oLIOGDb6YVcfFvUNMl6WysTwZQymgrqGVZnKvith8xig3SGxpzVFKhw/OQ
	Lp5F3lap5fWdDPT99yJNXStW/qCtasasbaIpoYZ77ZSXgXgRXQxCtP57Nalpp35v
	mStCLTfm6o+DgAp5hsbe8l8fuUt5W3MJVcXMDCycQUQK6IHcx4OtqpRXZyooF04D
	7CBImy5zqkLesLduZ+wzq1XC0gAi0w7CPiuj5YZmePwttMPY1TLDivU6veRkziSO
	6eU5/qBtpw/Vho4DfV6xO0fNuac01p/Li3rQdOLJBhOvR6CeWxOvIPHJhWKEhY3v
	wHKz6tM+xTVGO5UQ7Akbgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741981617; x=
	1742068017; bh=8xodwfwEn0U/1b1G74SDMqPf3LyEcvdzwzdCtZkfoww=; b=m
	BNcjPNm9TqdiCNKjTWoavmomKf040uO91m7rI2tbSgBq1GjgLzlIWrgjUbJdm2BV
	FBzt0VjzeCVoa1rrUvpnIvmH/iUrh2ckUxR7T9zo3V81rgDp4iBwBbzKcnUNvPMC
	e5WGZytDO1Xa/pC1rWle/EeNwo0ot0kR7kI4KgSvNQQqh3MuNjHnJAfq0mpvtftT
	2P2XXFaNGBj9aaAvnLkHO6r66rV9abTBkrYymU5/c6TTstPgf6L8g/0RmxiouSTU
	GLLIl4bKZmUEwy1AXGFWFVvxmnorKHrbcKYjt6J/WiMWiVSy8wvfaRg+LVeJ002m
	U+NjSQ5az62M3DnC205qg==
X-ME-Sender: <xms:sYfUZ_EC0kfhqh9M60tzuGUASdcOW5q4X5muiFvDvah2guZy_lY0Yw>
    <xme:sYfUZ8XiMT_j5h1UqsuhEDomu7OD26CA3RyMeQfNaREiHQWEmddLORwzlvWn2qk-l
    KWbUz2wYXgwEPTK>
X-ME-Received: <xmr:sYfUZxLk9pR0w8xxCveeOBT4SBZvRNwZsqGrPsU1T14p8VCKbHZ5M1ga3b59IbFGi4fdjYnNqM7ReFVk7UzBX81n3AMSYnG40L8P3yn8Kbqws5LN9dQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    vghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:sYfUZ9Gzgl_NXbD686XHLET6QagSqycvkRCM0HFvK-kpxtCcSBkG6w>
    <xmx:sYfUZ1UaJFfqsVzEE9_Mbaps1lxXOoXi1NX0fRdO9-U-27VOxyq6Rg>
    <xmx:sYfUZ4MwSgdSWJWH1gYpbFJlbVEf7_ANHvMLEI8sRlV8D4vukZdATQ>
    <xmx:sYfUZ03rjYdpayvyS-uwL32Y0B3P1VZm8avvsI79VJE6R_gR32OiRA>
    <xmx:sYfUZ7y2gsgrUtlna0Kr3q9hs4lOlWVt_G3zvLeH8FK6MGMLnrBw_hqu>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 15:46:56 -0400 (EDT)
Message-ID: <3d85f45f-a04d-4f79-9d07-4836f8cf422c@fastmail.fm>
Date: Fri, 14 Mar 2025 20:46:55 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix uring race condition for null dereference of fc
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: kernel-team@meta.com
References: <20250314191334.215741-1-joannelkoong@gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250314191334.215741-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Joanne,

On 3/14/25 20:13, Joanne Koong wrote:
> There is a race condition leading to a kernel crash from a null
> dereference when attemping to access fc->lock in
> fuse_uring_create_queue(). fc may be NULL in the case where another
> thread is creating the uring in fuse_uring_create() and has set
> fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> reads ring->fc.
> 
> This fix sets fc->ring only after ring->fc has been set, which
> guarantees now that ring->fc is a proper pointer when any queues are
> created.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")
> ---
>  fs/fuse/dev_uring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ab8c26042aa8..618a413ef400 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -235,9 +235,9 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  
>  	init_waitqueue_head(&ring->stop_waitq);
>  
> -	fc->ring = ring;
>  	ring->nr_queues = nr_queues;
>  	ring->fc = fc;
> +	fc->ring = ring;
>  	ring->max_payload_sz = max_payload_size;
>  	atomic_set(&ring->queue_refs, 0);
>  

oh, I  didn't get that and even KCSAN didn't complain. But I see that it
would be possible. I'm just a bit scared that the compiler might 
re-order things on its own.

What about this?

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 9d78c9f29a09..f33a7e6f5ec3 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -241,11 +241,12 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
        init_waitqueue_head(&ring->stop_waitq);
 
-       fc->ring = ring;
        ring->nr_queues = nr_queues;
        ring->fc = fc;
        ring->max_payload_sz = max_payload_size;
        atomic_set(&ring->queue_refs, 0);
+       /* Ensures initialization is visible before ring pointer */
+       smp_store_release(&fc->ring, ring);
 
        spin_unlock(&fc->lock);
        return ring;



Thanks,
Bernd

