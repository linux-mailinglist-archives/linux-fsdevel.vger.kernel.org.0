Return-Path: <linux-fsdevel+bounces-45177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E4A740B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 23:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2390817B15A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940CD1DE88C;
	Thu, 27 Mar 2025 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="FLrhb0ks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wzlbzHu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702EC1DC19F;
	Thu, 27 Mar 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114070; cv=none; b=Rl7hclYEofgkhQ+Lk6ZhJWKkdNMCZfH65sEHmfqxuYKe4YgYN7y3J0uyGApV/QkY1m9JqVPEEJnco6YTyYGfIkTQ7RAhGtIjy3owOiX8YDvX5LDGMBiL0iBln8Lte6m8tWmfe7T68pPR08JQaGQSPZJ24qj4j4JOazo+NfxIqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114070; c=relaxed/simple;
	bh=7Qix2cDbHH1dg7ZCRKRy38FoNJXwa8le7X1DdJ13E3E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sLIAKXO8QZqWfUP68DcPfhVgPq4MbAojitxPocP3HOrTg3S2Tou2jQFON5hpFlImQuA6iQvwzDB6gyRzEhnO7+dFeiDOjgTZxmdO15wmlR5nH/BFm4RiSVnbPBLIghITZV8OnM/qL2AKXuZK5m8acOUuCS3jV6ezxfZ4l2zkbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=FLrhb0ks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wzlbzHu/; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 37B4E114016F;
	Thu, 27 Mar 2025 18:21:03 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 18:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743114063;
	 x=1743200463; bh=YUEZNyWXaK5Of6RiWiLb4oleL3r3Nc/4TepMjvhLE7Q=; b=
	FLrhb0ks/djqAbV/e04bvQSiyXxpjkZE4siXEovnkc52IGVZkrZoRu3CnSwTLLen
	nIpkbDGCRMggyC9YcbEgXYeWHk2jRiESLs7uDyP81jy3MgejvG9IzOAXQIp56AFI
	l8GTTle/OO7HzQsCHXXnNTgUN+1C+rV2MTlY57ggSNTUfCYwI+X+afi7xibvQ/X1
	+0zNgL4YqE2aOpllnIVTe8iUFZYy/aIGz6yr2Nx7Ikj0GNkECfM6kgcVMk7TV3A3
	x0tGiC46NYaARAGSM/O4kJgwV5vmN33P23CXLo5bN3u+nCFOrYJPbQMUo6hRdmoh
	abjTBsd4N9fAap29TpRtpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743114063; x=
	1743200463; bh=YUEZNyWXaK5Of6RiWiLb4oleL3r3Nc/4TepMjvhLE7Q=; b=w
	zlbzHu/XjT7h1pdHnLxlZJJ/S1GCmFHWG0Jr0aiSOBxoQsZXCkDizBYG/YddHMgg
	t9ywN4gTU31qsJa0OuLuSQenCI9C+DANfEXKffyysv9HBQGGJSUAFvVooVbA16Fw
	2IsrKtRgY5zlMQniuOrKSc1lKxYJyNRawxxY+0zkt7zqlOEgxh7NejngaTT2kTTh
	+28mXUEdE1EsamX6TOY8Wa2Lf9fArD0f7u7mZmKb+7kXm8SfFdpcOnDwqadrIfk4
	cc+9U7gKgD0aRlsy4baFUupnz+PeuYidaAWa8GhC4ny1cFtgkHRXa372kBHJOn1z
	pXONR75ubuiw2w+UnSMpg==
X-ME-Sender: <xms:Ts_lZ0iSl9xnbysV211Ebyt88h3lp-KwRqKZdA7j4xG5hnAZf3bv7w>
    <xme:Ts_lZ9AUTKzek9Ep-ogjuBXC_tNAPIJnmrLCESzcMDsvzKdI8MRhBD2HR8Kf1IuiE
    Wp1wcch2h_agoA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeliedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfveholhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvh
    gvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrhhnpeetfeelhfeiteffvdehgfduveei
    jefgveeuveelueeuveeiffffhfdvffevfeeuvdenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghumhdrohhrghdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghmih
    hrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlvgiglhesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepghhstghrihhvrghnsehrvgguhhgrthdrtghomhdprhgtph
    htthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhikhhl
    ohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidquhhnihhonhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ts_lZ8EUOD5lv_JmYYZqRApgjlNm-lon-oiiC1m1z9D7bneoaDqGxA>
    <xmx:Ts_lZ1SoVaXsFUVgaLv9RJAR7iluUvRTHNiuv6cIQS3qFs_Ma9JBeg>
    <xmx:Ts_lZxzoZ5xSwO3JhQH_yBiC8uRZwkFr4TsbT7FJym1Z-ELTaRoyDw>
    <xmx:Ts_lZz6YfbWpTgFYnAjWlcIRPFDlWdRciqS3eL1y2a1g_T3kEqtFGg>
    <xmx:T8_lZ4kZriWuwUsUXQOR9Uk1NYIDIWufK-dXO66EDHANdYYwyshUMdBw>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 744B029C006F; Thu, 27 Mar 2025 18:21:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc7607f2cfbff4e09
Date: Thu, 27 Mar 2025 18:20:42 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Amir Goldstein" <amir73il@gmail.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "Giuseppe Scrivano" <gscrivan@redhat.com>,
 "Miklos Szeredi" <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Alexander Larsson" <alexl@redhat.com>
Message-Id: <fd568b3b-e18d-4bca-8b47-c5bd9c26ecdc@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxjad0hm10F1hMFX8uqZr+kJT-GibFNe9hAv_v971sb97A@mail.gmail.com>
References: <20250210194512.417339-1-mszeredi@redhat.com>
 <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
 <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
 <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
 <87a5ahdjrd.fsf@redhat.com>
 <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
 <875xl4etgk.fsf@redhat.com>
 <CAJfpeguhVYAp5aKeKDXDwip-Z0hc=3W4t=TMLr+-cbEUODf2vA@mail.gmail.com>
 <CAOQ4uxgenjB-TQ4rT9JH3wk+q6Qb8b4TgoPxA0P3G8R-gVm+WA@mail.gmail.com>
 <CAJfpegu6mJ2NZr2rkCVexrayUt=wwNSyYv5AE694D04EH2vx2w@mail.gmail.com>
 <CAOQ4uxjad0hm10F1hMFX8uqZr+kJT-GibFNe9hAv_v971sb97A@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Mar 27, 2025, at 1:13 PM, Amir Goldstein wrote:
> 
> I am not sure how composefs lowerdata layer is being deployed,
> but but I am pretty sure that the composefs erofs layers are
> designed to be migratable to any fs where the lowerdata repo
> exists, so I think hard coding the lowerdata inode is undesired.

Yes, I don't see any security benefit to binding to specific lower inodes, and it reduces flexibility to do so. A nice feature of composefs is that underneath it's "just files" and all tools and techniques for managing files apply.

