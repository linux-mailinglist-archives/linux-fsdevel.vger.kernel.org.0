Return-Path: <linux-fsdevel+bounces-29608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C0F97B58A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8BDB2283F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3F115B57F;
	Tue, 17 Sep 2024 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="p+I0VQyp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FuUBRSWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEEE4594D
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610457; cv=none; b=V2wFUgTarRq2pB8+VqXxpaS6uani5bAXvs+UW4DKvodl+xs9OaCKaZRtsuW0lNVu2CwO94Zo7PQQwNqwR0xLU9Q2LAicUeKxcHAXzDgixPLJxxhjznynywYn+MWJZBjN8tq3tXPFmB+UCtbHJZN5h0hD0eWqYe+bmCdLqo6iahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610457; c=relaxed/simple;
	bh=7YyXNhwfGj/8zUpJ98jJtAS3MCPTAmMjlhjwW0mVpSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouO43CUc2ClibZaa9hnRJximheHuX2zsVNKFAjaScfMDi/UmkCLZm7k4lUrMli6j27Yhzj7pGw4wgGr7T18EGsxsblRC/sDh0t/AqXGkej6wXBE2MAPYFHKrWpEh2M9AY6BFK6NC9GI9+oKt882+AeDhAHuE2Sm3a9x0mac3Noc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=p+I0VQyp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FuUBRSWN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 65E83138026F;
	Tue, 17 Sep 2024 18:00:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 17 Sep 2024 18:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1726610454;
	 x=1726696854; bh=3u1Z7nKNOyXjn3MmTb4WviaMzTdcHqiqYYPEZxqd6Z0=; b=
	p+I0VQypIb0T+Rlj5TKc6dT89EcEaGZ98ibaBwjAv8xAg25QVailo/Uie4sPvZi6
	xIPRW0xt4SoiasaNwEBHIqfUZFZThO94JNi8ft1EdUZ9nwfrE1oe9VNeLAuXEmWO
	BVky5bKSsXa4U4zxKHfkKmMJ27ean6iv09vU9tQFRbRS+nVEWLih/v05pFFEPh4y
	sqB8szEWMoGHLgOd+BSl6buIGHKzVjdIP//dsUhtvoAog/5rgIj9uFcPvAqApyCM
	8gHQM0Ng9juYGqTCPg3cT0/UmFjzrccniUcf60Xkjljf6ATjuxbNPODHxcF4gGwV
	xF6vkCUpgxjCelUPr2t3GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726610454; x=
	1726696854; bh=3u1Z7nKNOyXjn3MmTb4WviaMzTdcHqiqYYPEZxqd6Z0=; b=F
	uUBRSWNkR/VLCzbqJMH9fhxal6GemfnBN5wcYFJzEXe36r6kb63s1TJBDJLeDjhN
	FQ7vQFqTMEuLd6I3t2q0FByuAUv+HuqC+BRsBdEanSL80K4nn9XGSgYpA/Taj1Sr
	qgVNvRVHBh/Nip03N/+WNhQBjjjhz4K02ZoAsVLvwTEukHlsb/kQ1+pIbf/dbn/X
	KX3REB2CLmQmBeWLcXLrglM6ah84+0Uw7y8IDMjJN2lwC8Tsb2lZWqBbuAoA0B/b
	VFDvLTTGE+H4yZtyIA6BkbT3xYhBIqwwjK7ENHX8o1FjReLqz8mkrzN8+Np+S8fy
	biic5sFyVJLOWu//yUlJA==
X-ME-Sender: <xms:FfzpZsB9bd8vZ-MN8lE8CwZsQ3zvWXWw8gE-7aBB8CJ779x-0QEXGg>
    <xme:FfzpZugmjzUd691fdtETmyoJYivup9iAWGX2GipKRC7L5_N_d8dKVwVwEywxUvHgc
    dYxWwM7EFhyaQiZ>
X-ME-Received: <xmr:FfzpZvlYKHDhLXXFmmIzMGEQ5_GE8DU6yGG4nVitoDQJ8uIm0VnihLHuInnhpBhljR98xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudev
    leegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlrghorghrrdhshhgrohes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtg
    homhdprhgtphhtthhopehjrghkohgsrdgslhhomhgvrhestggvrhhnrdgthh
X-ME-Proxy: <xmx:FfzpZiwEjTk-qgkb9UQkPGAzdscC8yZ217v6W0K8AOcPBq7XNtZRtA>
    <xmx:FfzpZhQTnm-IAJxsBWMm_Acomm3FJRPnMq2LfZWn9oGuiFXVLAJ_iA>
    <xmx:FfzpZtazyPoci7V5kzPu6kfSlytX-h_7SWp8GlZ6wbo12G9LP9tbkQ>
    <xmx:FfzpZqRn7Oh6ztadshgvg2abbzAsDgGC9g6nZBvsCVJ5oXX2-a-wCw>
    <xmx:FvzpZsFxc7NU6VxjzCLhrCRMMdYb8-awLJ7x2d_2s7sHja34eZ_jv8P6>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 18:00:50 -0400 (EDT)
Message-ID: <b05ad1ae-fe54-4c0c-af4e-22a6c6e7d217@fastmail.fm>
Date: Wed, 18 Sep 2024 00:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com, Jakob Blomer <Jakob.Blomer@cern.ch>
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com>
 <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1ZSEk+GuC1kvNS_Cu9u7UsoFW+vd2xOsrbL5i_GNAoEkQ@mail.gmail.com>
 <02b45c36-b64c-4b7c-9148-55cbd06cc07b@fastmail.fm>
 <CAJnrk1ZSp97F3Y2=C-pLe_=0D+2ja5N3572yiY+4SGd=rz1m=Q@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZSp97F3Y2=C-pLe_=0D+2ja5N3572yiY+4SGd=rz1m=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Hi Joanne,

On 9/4/24 19:23, Joanne Koong wrote:
> On Tue, Sep 3, 2024 at 3:38 PM Bernd Schubert

>>
>>
>> I have question here, does it need to be an exact timeout or could it be
>> an interval/epoch? Let's say you timeout based on epoch lists? Example
>>
>> 1) epoch-a starts, requests are added to epoch-a list.
>> 2) epoch-b starts, epoch-a list should get empty
>> 3) epoch-c starts, epoch-b list should get empty, kill the connection if
>> epoch-a list is not empty (epoch-c list should not be needed, as epoch-a
>> list can be used, once confirmed it is empty.)
>>
>>
>> Here timeout would be epoch-a + epoch-b, i.e.
>> max-timeout <= 2 * epoch-time.
>> We could have more epochs/list-heads to make it more fine grained.
>>
>>
>> From my point of view that should be a rather cheap, as it just
>> adding/removing requests from list and checking for timeout if a list is
>> empty. With the caveat that it is not precise anymore.
> 
> I like this idea a lot. I like that it enforces per-request behavior
> and guarantees that any stalled request will abort the connection. I
> think it's fine for the timeout to be an interval/epoch so long as the
> documentation explicitly makes that clear. I think this would need to
> be done in the kernel instead of libfuse because if the server is in a
> deadlock when there are no pending requests in the lists and then the
> kernel sends requests to the server, none of the requests will make it
> to the list for the timer handler to detect any issues.
> 
> Before I make this change for v7, Miklos what are your thoughts on
> this direction?

we briefly discussed it with Miklos and Miklos agreed that epoch list
should be fine (would be great if you could quickly confirm, Miklos).

In the mean time I have another use case for timeout lists. Basically
Jakob from Cern (in CC) is asking for way to stop requests to
fuse-server and then to resume. I think that can be done easily through
notifications and unsetting (and later setting) fc->initialized. Demo
patch follows around tomorrow, but then Jakob actually wants to know
when it is safe to restart fuse-server (or part of it). That is where
the epoch timeout list would be handy - reply to the notification should
happen when the lists got empty, i.e. no request is handled anymore.
I think like this is better than FUSE_NOTIFY_RESEND, as that has an
issue with non-idempotent requests.


Thanks,
Bernd

