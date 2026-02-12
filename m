Return-Path: <linux-fsdevel+bounces-77009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGMMHM2ujWmz5wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:43:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB4A12CA0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 570D03005AFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B982ED848;
	Thu, 12 Feb 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="PDehIW8N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhUjiY+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D11D2264CA;
	Thu, 12 Feb 2026 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892997; cv=none; b=nir687wYZIw0VhtIRenHLK9hadJHd9/KP8Wgi73JOtJXWwLed84Y423A68LAiNkbVlkMH8CIOcXpYFbZqiAkAInCmi21BE3mDyXyj191m2PhcxvMo3n4JY98O58grTvWbmKnPIbcr8V48eykCU/l8HAljJ7DB8MVYvYLEiU3bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892997; c=relaxed/simple;
	bh=SLgJE01bWWa0FPWHi9V4oSI4esf3y+mypKNgWTe8FvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGzskR57ke1JzeuXn8u/7g++fw/CCCpeRsMJZIx9cQw7WUBwID01eWA0UQh/+q/2JsiOEBcOmCaNDLr5qG+hM4ZmgRxRyZyQRRXpVVqZ1MvFGiYZrzCExKLy1h6l6az9doqmuMA9Q5efdPa7aany54Gr/aPfO6bQSNxW00s270c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=PDehIW8N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhUjiY+V; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 23EAD1D000D7;
	Thu, 12 Feb 2026 05:43:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Feb 2026 05:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770892994;
	 x=1770979394; bh=wrd12z2EhMQ5s/OYJOHKXYKBIX1C3bjuFL/tldxF+xI=; b=
	PDehIW8Nf1t5Wxjnmix4T9+4zHxvmmjwYTwosGez9gVHfGwUAdDX/3jw9m9mv9iA
	iQ9LBpGOs57iingnwktQ5jWOovRnQNxC3hYtRiWjdFbacmAzj/v0gu0gjCdFO17U
	tUE+bFg33Brw0lXIjw8qbJ3kXQn6D/MnUyZNUsM1XyyUd0sLDExcwTH+WAPmD7am
	bkB1N+jso/lEqTiy0PYZw7y2RISt/q1kkVH5tfOHSKfyOGzz6mVJRhHPazfLbGjC
	Fp+fKrfzxF6xcLzQtJfbpau1Zul2GckweZ+b3/21VlOTBfhgwCyZxCIklYZPdkog
	t1IpUzZS65re3LocTPUnqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770892994; x=
	1770979394; bh=wrd12z2EhMQ5s/OYJOHKXYKBIX1C3bjuFL/tldxF+xI=; b=Z
	hUjiY+VoZ5SfWwcoLzTHi4W7FYQ2gK7I1b6zaG1eIruTWwHCp24VK+zazDuH79an
	WvyeJv/M2roMvyscG+DOvzRccqrud6WNSV4dcc7l4v3EaxFHBCNDnRKRjPCfFhsX
	fHvSKIvp69cXXJFavgAADKJ3zV5bx6j5bFOUUZhnfEPu55dQdPO62iObZb45flvX
	hbm/9YI+wJkCOo58lGZDYAnJNV4UX+EyHcXcU/ZYQn0CSXjcWmAzzGxOqXgY7Ypu
	7RYN3g0XgJ+/rAzToBoBgO7GP4uupTLPbXLzLcsjqHulowMlDc2G+HFiJwE6BJXv
	5gRdR076CMV3/1i9C2yow==
X-ME-Sender: <xms:wq6NaRLuMW46DCvtr7m6r3oP3Cx2BNueoVIrkK7w6xdFUmy9AsUUiA>
    <xme:wq6NaXKnp1Bhgt7Lcjfzk6_UvDDW0eegqU-Hi0-WyU-jVpUwncNA8_nhb-xcUwpJi
    rnCav_2QiEp4x1xSolRcEfZ8F1BCMEficcec5Nf7ZvTWuXrXAA>
X-ME-Received: <xmr:wq6NaQVGKVm04uhHJv_gkqzNGtUqINsz3a86RM1P-gIJYTIIsdK57o950mSJ-cnavyei8_a5ONZNzLhgDdbrQQkIM91Mi7FdsyccP0fQ_O3Uwih8pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohephhhorhhsthessghirhhthhgvlhhmvghrrdgtohhmpdhrtghpthhtohepsghs
    tghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhngh
    esghhmrghilhdrtghomhdprhgtphhtthhopehluhhishesihhgrghlihgrrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhsghirhhthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:wq6NaQlMz84FpyiT8lssXM5x2DBb8zvjNK-8rq6206ImXt5Hr3Geag>
    <xmx:wq6NaWnGorVVLYV83fxZX6LczpgY3saRG6RTkfLPJvVb97fhc78rzA>
    <xmx:wq6NaQaxEL7bVp11g4h4fa3RT09pnpXLGBj4fYjMQxa7VAxo5RC80Q>
    <xmx:wq6NaYSYzNgdgO1MPeh85NIMSNjLMuDKQRES2uVeNYXmfpzlcxHFLw>
    <xmx:wq6NaWAoDB7anB6JUIAxhhMqqVzoY01EGXGe88ksAR1E4Xq_IJ3JXkyZ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 05:43:13 -0500 (EST)
Message-ID: <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
Date: Thu, 12 Feb 2026 11:43:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple
 requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>,
 Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>,
 Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77009-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: DCB4A12CA0A
X-Rspamd-Action: no action



On 2/12/26 11:16, Miklos Szeredi wrote:
> On Thu, 12 Feb 2026 at 10:48, Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>>
>>
>> On 2/12/26 10:07, Miklos Szeredi wrote:
>>> On Wed, 11 Feb 2026 at 21:36, Bernd Schubert <bernd@bsbernd.com> wrote:
>>>
>>>> With simple request and a single request per buffer, one can re-use the
>>>> existing buffer for the reply in fuse-server
>>>>
>>>> - write: Do the write operation, then store the result into the io-buffer
>>>> - read: Copy the relatively small header, store the result into the
>>>> io-buffer
>>>>
>>>> - Meta-operations: Same as read
>>>
>>> Reminds me of the header/payload separation in io-uring.
>>>
>>> We could actually do that on the /dev/fuse interface as well, just
>>> never got around to implementing it:  first page reserved for
>>> header(s), payload is stored at PAGE_SIZE offset in the supplied
>>> buffer.
>>
>> Yeah, same here, I never came around to that during the past year.
>>
>>>
>>> That doesn't solve the overwriting problem, since in theory we could
>>> have a compound with a READ and a WRITE but in practice we can just
>>> disallow such combinations.
>>>
>>> In fact I'd argue that most/all practical compounds will not even have
>>> a payload and can fit into a page sized buffer.
>>
>> That is what Horst had said as well, until I came up with a use case -
>> write and immediately fetch updated attributes.
> 
> Attributes definitely should fit in the reply header buffer.

And now let's include something more complex, let's say a write
including a partial page write of an unknown page. With compounds
fetching the entire page or just the missing part + file attributes
becomes possible.

> 
>>> So as a first iteration can we just limit compounds to small in/out sizes?
>>
>> Even without write payload, there is still FUSE_NAME_MAX, that can be up
>> to PATH_MAX -1. Let's say there is LOOKUP, CREATE/OPEN, GETATTR. Lookup
>> could take >4K, CREATE/OPEN another 4K. Copying that pro-actively out of
>> the buffer seems a bit overhead? Especially as libfuse needs to iterate
>> over each compound first and figure out the exact size.
> 
> Ah, huge filenames are a thing.  Probably not worth doing
> LOOKUP+CREATE as a compound since it duplicates the filename.  We
> already have LOOKUP_CREATE, which does both.  Am I missing something?

I think you mean FUSE_CREATE? Which is create+getattr, but always
preceded by FUSE_LOOKUP is always sent first? Horst is currently working
on full atomic open based on compounds, i.e. a totally new patch set to
the earlier versions. With that LOOKUP

Yes, we could use the same file name for the entire compound, but then
individual requests of the compound rely on an uber info. This info
needs to be created, it needs to be handled on the other side as part of
the individual parts. Please correct me if I'm wrong, but this sounds
much more difficult than just adding an info how much space is needed to
hold the result?

Thanks,
Bernd

