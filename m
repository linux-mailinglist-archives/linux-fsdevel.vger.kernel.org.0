Return-Path: <linux-fsdevel+bounces-28230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D916D968546
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8961F25775
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19751185925;
	Mon,  2 Sep 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ZbFbwmMy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mWVfPogu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ECD15FD13
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274207; cv=none; b=eDZ5OqqE3BXq56l9J+BHR70hUHcfrpC2AyyK7o9NJYAHNICt/gHPvZNdq0B1ILYZgokAlLnmIgocKZOGck1HMbJLVcTwJHnyDWrupDjAfHnY/SgPGZ38liociQ9wn10ffwYexvPI6/r6tgNbj0zTzFSCgpTv/zBYhHijyF4+we8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274207; c=relaxed/simple;
	bh=+HYWz7WMe+5bH1E2zo2wyZlCOTuFH1sg50d11qkeeU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CA8byHDFgDq+QiqohoCgcuF+BVFNUAndaWpYkL1h20hWzAjYTAHihVZKjovTAC5tk2dn93+d9D218AM9xnxmQ3NLHJN3Q4KujeUukq2Zgu07MCH939UQEoFtFw+aqssKyoHFqaF4nR76J9Y5Vbh1Ice3gNtXQxtK9i7tXeNkKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ZbFbwmMy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mWVfPogu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 45C9C11402BE;
	Mon,  2 Sep 2024 06:50:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725274204;
	 x=1725360604; bh=cb0UrlQ2WWt7WybCGn/PMpJrbs54XmF0t0BQYslKS2c=; b=
	ZbFbwmMybhkjI559UtARAHq5TV1okojnMasv5etsjmmAmKE2Rj6plzlrr9W3wvqT
	lDZIojwE7iYi5VwLwldO8tBJEBHVZQGCkIU7gmrV9JLwf2qWO1TmytZGu9i1wtlm
	9kj8oyRLI3s/VSxdPAC0xoXv+Z0t9lbFTlPImIba7UlGQ5vi8+9RH9gf2NXJvXFt
	MDpRnnRn2Hg08jNRXtiPjdJ2+npBekMpi1kUXNxjzdt4ytFRfM5Ov+CsVyv4bMFV
	TmzyPItFo2myI33zP0zvlYva7xw1aIKE+Lo+3oyqCJzwzNYlewh95QeoZ7J2sEJB
	AHZCQpVnC1jr2GAs06JmQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725274204; x=
	1725360604; bh=cb0UrlQ2WWt7WybCGn/PMpJrbs54XmF0t0BQYslKS2c=; b=m
	WVfPogurwDa62Jji3ialMPODXBeltg++/u7EJnDIHr4FXYI8njfuIgqHBKmDlzT0
	+OAX4FPTV9LT4W5Ht3VsBCmQeETsaMupANqu2cnvCfCMzqjJlnJMKb1D5V5d/+FF
	f4MvEKE4ukYAFV632WRBtzDbXVhEDNGPlB3axJKBWZ3dzLJguIbFWn5YSVOOt74o
	O3FClTSPbyRL7zYb7323fzxvHsMG5FqM2XHXGrZREHNLVO8CgSerGoZ58U0GGttV
	GDPqfNvO+o88FuQRlcLQo3N2LXdy+/rKp5fFXCoE1HHJvXOn4z0JWzRdP8URs11J
	USAGfSJslnQI3sW9uiOTg==
X-ME-Sender: <xms:W5jVZg0swuu_4pSQ8iTNuyuDP3u_lFH2eaHKNMVrNjIeQvYLlxBbqA>
    <xme:W5jVZrGLMv-eRBXeZvvhxqNW_ozpv5DDHVH5iXkltmZgLx6eZC17uUVVvSn1viOk7
    2UpPcjrFsxODtH9>
X-ME-Received: <xmr:W5jVZo7Ykk7RTpaepwW4Lfzf2lqYaySbB_pT5-n6C2AwoYWbW_UDEM1hFEvD0M_P8ZgQagoofsiiKc76enhZNIgRRcsXkx7i0VmpCrOEJuKtRMAskA0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    jhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlrghorghrrdhshhgrohes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtg
    homh
X-ME-Proxy: <xmx:W5jVZp004W5xkpGW2-ckUhIFsaZdjvzTyLY0LKdWp2gLmzywYrpQcw>
    <xmx:W5jVZjE5KG4umP5oe_E1K7y3m5gLbbt0336M5xCcrtKKK2j1zIjTMw>
    <xmx:W5jVZi_8lMIbRT2V9dW6_HQ1_12CGTUCv8yg3sU8MsomtKgnZ0qLYg>
    <xmx:W5jVZokr82NaDZmbvbN-0rLdKYRPw9z8BaW-utItqo0sML-H0zV0AQ>
    <xmx:XJjVZi1kis9e0bxSNnLyZ5NvqHEpTdXZr6RW3GbMirEHNCk2ZMyIqvbC>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 06:50:02 -0400 (EDT)
Message-ID: <1c7c9f00-8e94-4a98-a3d4-a3610d35e744@fastmail.fm>
Date: Mon, 2 Sep 2024 12:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com>
 <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/24 12:37, Miklos Szeredi wrote:
> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> There are situations where fuse servers can become unresponsive or
>> stuck, for example if the server is in a deadlock. Currently, there's
>> no good way to detect if a server is stuck and needs to be killed
>> manually.
>>
>> This commit adds an option for enforcing a timeout (in seconds) on
>> requests where if the timeout elapses without a reply from the server,
>> the connection will be automatically aborted.
> 
> Okay.
> 
> I'm not sure what the overhead (scheduling and memory) of timers, but
> starting one for each request seems excessive.
> 
> Can we make the timeout per-connection instead of per request?
> 
> I.e. When the first request is sent, the timer is started. When a
> reply is received but there are still outstanding requests, the timer
> is reset.  When the last reply is received, the timer is stopped.
> 
> This should handle the frozen server case just as well.  It may not
> perfectly handle the case when the server is still alive but for some
> reason one or more requests get stuck, while others are still being
> processed.   The latter case is unlikely to be an issue in practice,
> IMO.

In case of distributed servers, it can easily happen that one server has
an issue, while other servers still process requests. Especially when
these are just requests that read/getattr/etc and do not write, i.e.
accessing the stuck server is not needed by other servers. So in my
opinion not so unlikely. Although for such cases not difficult to
timeout within the fuse server.


Thanks,
Bernd

