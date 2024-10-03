Return-Path: <linux-fsdevel+bounces-30890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0567798F11D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DE71C21FB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A0F19CD0B;
	Thu,  3 Oct 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="URN76eio";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="POA2Ef5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155A64C8F
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964547; cv=none; b=Zu216UgC4jK0XXda9ETEDO3e1SLNPyfMWIKHQo2+cM/5hZrHja5ezFhFjO7JM0KC7LA35Mq10geU4xjfvIHOZYQx989ptCCk3Sjro5fSzoqyCjml0O9sdS/94Ph67bBAAhp/I2r/R4U5jnNuX5ilOiQgdM676qkY3lsqKFLByP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964547; c=relaxed/simple;
	bh=DRwYEoJhMMp1n3zRfsq6usRE2kTVuyS1qK9f5ROSQlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq+W6ex5tia9xaW95h+Pw/ZCHu8JgQ/mVv/PkSdmSnOkckcr5WfCXoVURVqikQ5SsvLHoba2/m2RH8j4RaBYxF40pycbTYw09frZM2+ELWuqM51kVppFSPz9d13SGC2QhMLyLIwjeQue2wr7OdpDPi7eh/JxyO34+38x5wySp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=URN76eio; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=POA2Ef5r; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DA49114014E;
	Thu,  3 Oct 2024 10:09:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 03 Oct 2024 10:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727964544;
	 x=1728050944; bh=Z8dxwJ8U05MhXaZtm2YTwwvkhbYQr5LDsYY+kYgBQcU=; b=
	URN76eioMgWbKyd3KhEcWxnrH2uXrjSMyvsQpjlSzVq0yUy/u1yBDLHGPHRVOA0n
	pJA3VuaeZq42GUteNCnP5U4YwJJ97B9VOEGSKgL++w4YJXALyvIY1konKTm7tIJC
	rflCdGwWWxjwEhoYVZUeM/E/YfTsGa8IWBiunQEHZhdghWd+sifOI76lYLqr82cF
	cTfDqg7J6B1bHlpJfSIXhXbi+JN7opaQsA656LzBX/Hsy8NCukeRIUD+aLgljUg8
	7xSTi/YI628ufB4QBXa/dEa8cx7wC30NBqTDBT4Ru1S+bJOcxxyORMphvIPqVeVl
	pJjjLIXUrNyLbOMXCaG4vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727964544; x=
	1728050944; bh=Z8dxwJ8U05MhXaZtm2YTwwvkhbYQr5LDsYY+kYgBQcU=; b=P
	OA2Ef5rMigKKGMWOPcaDOLGtAbuGCM07wgJVjwxW/VtvOGOvS4e/KL3qEJZTa0vf
	M64TYzhAQr6Hgk+t+AT1i4aB/HXpuyfGaCRvQaw7SqIWgjH876ArrByTXbmAzmDI
	5t/Ng6kgkitltRaGXQrb2jyTZuhOiURSXZgsva92GzLan4euGwvlogjwEkgaVLlL
	YKOQzrubsAMZc9VPnXCyWOryT+h6nq2SBzRhbzy9yCSNGHS8Ccdeyuh0/yywtrkL
	IKeDxlzQ1VBkPhrpWB5G/DFJ1glKksR1jbE3kuHov1sLfUojvCO1XtZVzqNEA0yc
	jnnjQK7RJkHI4fG/ytY7Q==
X-ME-Sender: <xms:f6X-Zo3Ai9d9O-cQRf37Tzv2lrD1aniV0LE3aYqj1eGR7I7ZpEE9Ng>
    <xme:f6X-ZjHGcWV8QZN58rrWd4hFdF9OrLfDU7Tp07_UCq9dL9qxJI6gBJhBb6OHG8xLy
    Uiv0Y6n9Z6_vWkk>
X-ME-Received: <xmr:f6X-Zg7BDZTh3iBjOnD4Ja7KsOF1o0LkUg6sViQDxqo2GcU1xC0iuWh5QuraMtYA8N6kLfn67qoPQXmywbf6X82sBssxJWHhzUNlSd2uCjWUZzvzzAX1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomh
X-ME-Proxy: <xmx:f6X-Zh0zGcdfQtICU6Biq6F13bhjH8nOJOf2ZD-FGw0LbEaBErPETQ>
    <xmx:f6X-ZrGVpuoc6Y6XbeolJ_tOctT7EEFUGFF4f3K1LV67B7iw67et8g>
    <xmx:f6X-Zq9efZFrBHDGJeMZjPj9bIjSllCqX17ZHMuscceWxY7xCved1g>
    <xmx:f6X-ZgkcZBOBhphCcmpThdj9pjmp4LgDsvKnaNTRZQ8OXjZnS_Z5Ag>
    <xmx:gKX-ZvjCj6bMa35Jd9HTszCSAbKsyylOFl3Pw0APvlR-prrkrLY13nzm>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 10:09:03 -0400 (EDT)
Message-ID: <e75d6df7-d39b-4186-b319-08b3d1207712@fastmail.fm>
Date: Thu, 3 Oct 2024 16:09:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse-io-uring: We need to keep the tag/index
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
 <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
 <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm>
 <CAJfpegtazfLLV9FoeUzSMbN3SoVoA6XfcHmOrMZnVMKxbRs0hQ@mail.gmail.com>
 <c2346ef4-7cf1-412a-982c-cf961aa8c433@fastmail.fm>
 <a97070c4-c3ec-4545-bff5-496db3c9e967@fastmail.fm>
 <CAJfpegvK2+Q=L4hM5o0fZPuJc-zkCwZHj2EcLXFFEq__sPmXgQ@mail.gmail.com>
 <CAJfpegtpCdGPN=X1_58bpD9eBnnK1gCBKTkGsRqn7cK3wJzk8g@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegtpCdGPN=X1_58bpD9eBnnK1gCBKTkGsRqn7cK3wJzk8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/24 16:04, Miklos Szeredi wrote:
> On Thu, 3 Oct 2024 at 16:02, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Thu, 3 Oct 2024 at 15:56, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>> I'm inclined to do xarray, but still to assign an index (in the order of
>>> received FUSE_URING_REQ_FETCH per queue) - should still give O(1).
>>
>> xarray index is unsigned long, while req->unique is u64, which on 32
>> bit doesn't fit.
> 
> I suggest leaving this optimization to a later time.  Less code to
> review and less chance for bugs to creep in.

Well, we need to search - either rbtree or xarray, please not the
existing request_find() with a list search - totally unsuitable for
large number of requests in fly (think of a ring with 32768 entries).
I.e. that points to not using req->unique, but own own index.


Thanks,
Bernd

