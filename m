Return-Path: <linux-fsdevel+bounces-26503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D195A324
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DE51C21B68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3636192D99;
	Wed, 21 Aug 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="fd6NtZfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aB/DKdUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D961494AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258887; cv=none; b=CMBDuiljain6nSQmT8FV0qQmiy6fPLlSocbiaQyUOlZ05JamgDT0TF/w7Bk+Q+m1kQZzgqufaeSRZq2GfaNsWBsPv5zGaP694B78Q1d6TJm9nh+mP1UiN8yOpyP/iZLGinLpwpDIFrGUap+W9cdup1eML5s8rer5m9jHy4hjalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258887; c=relaxed/simple;
	bh=5P8SU71peE+gQ7DePojZE0c7BDbEg/G+sytSrj+REQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCkcQIOEmLj0v6k+cbMFSx3ksrM+swVAA/19eU7bUPPl9IvWKyVUTw6PIFn9IMpSszfBxMxw3/U/7vkbbHhLuWI/njPwy/c1hyW+FZDFHssjC/YVmZck8ECkFvqffmG71r4PgpeXtGjgppO7PenAZANZ4jGB115NcEYz0he339Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=fd6NtZfu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aB/DKdUu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 412C7138FF22;
	Wed, 21 Aug 2024 12:48:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 21 Aug 2024 12:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724258884;
	 x=1724345284; bh=KE6/Q2KZx9MUTjnpc235WlTrVsmXxJxmv8SMwiri088=; b=
	fd6NtZfuW9bLmz5tJ+0toKHfl5ChicHty66dCRxvHe5TC5IgInkqcYX7oiThOVcz
	pXmiuydTT3Ykfwrx700hJ2p51ippZ4+DATbben1MgUfgZCbOsHoP14gSj0coO7x5
	rphGovqmqkJy3ji7rLEEbP/wtP+dHAKzFvyZCEKxXPRyRjU7lHMKx7ZQIVTTQ2dD
	/k2YfuVvEnrsjDoH6ZUr3ixN1jEBJuS+xHyn6SoVVXGRijJmRAoF87QdatpSrM5I
	HZtpznT+IvPlL3Fv7bIcwE9+l7jAdiBBeN7VtYnu5sQzbXmDFxnOHMEahfr0kGtP
	L2QHaR97fkVCb4RhHUVCwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724258884; x=
	1724345284; bh=KE6/Q2KZx9MUTjnpc235WlTrVsmXxJxmv8SMwiri088=; b=a
	B/DKdUuS2pPRecmm4JHW4M8pStDvGA5lbUZKGuTsSESmg5C3etggvMtEYe6Z+hhy
	TJ6R5Fbz670av4kdTHQGoRqXVtA973uENra/Oy19J2rmqcxiFvouTOF+5lXAg30r
	bBs9KbRZ3IooFzLwGLV/kpnMDohPJ3VHNiPemz9qOpSRmOUoVaUtH82KULxqsRPt
	zTyvcU2/bwqQuoqtbp8FyTJXpdlrYU+0tGSCdq8V11xPo6ZXJAvJU2lySxo9YoV4
	OeLZc1hcMa573PVamjDI3I2k8zOZAAVxWTQyfCtLBYRP3gSnsp5Ox87Daw/L2Sog
	B4xMkzNhAmvCQ0SOdAjCw==
X-ME-Sender: <xms:RBrGZnoN3ooDE7mwNXtc9g11CfR2YD4WWQ928N_M0EeXp_61O9XHvw>
    <xme:RBrGZhp1FSGOSUOkUGtO83gwk-1UXFZ-Otl4kKy7osPXr9WAd-MSumsVdOPDx_mm7
    -qj4l_5Ph3SByUh>
X-ME-Received: <xmr:RBrGZkOQsNTmIO-peyVagLXg_GlrWaSKyD-fklAbM67nJ8-q78pYp9-njordBRWp1hp4hc1o8H2-rGII38hurxQygjtCoZhLwnLuowNQEukGWPNFcmrWwUcN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsug
    gvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfseht
    ohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgs
    rggsrgdrtghomh
X-ME-Proxy: <xmx:RBrGZq4KcY2UVyUWK7cQVUqhPaxU8nV4TPMo7b9131sU8HpnJxIAYA>
    <xmx:RBrGZm6kZcGiCLGmw8CZKk4HXbFUX-i9aRBI1OYjeAp_6Nopuip0ag>
    <xmx:RBrGZihzUCQmv6z9QRIyRHxBVexEspYGaza5tjSqzsV_5h6KXrXoBQ>
    <xmx:RBrGZo6JNAlNldzeJF7mDJXu91Sog5B62qI_XZz_2WbwOfg1lCtmhQ>
    <xmx:RBrGZjvFMYXJgbdt9l7tPyzAzKjSWwjE8acSK6t3rE2y5zajw3sNi7Yq>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 12:48:02 -0400 (EDT)
Message-ID: <6eb8caba-61ad-47d1-b839-fca3b75a93c7@fastmail.fm>
Date: Wed, 21 Aug 2024 18:48:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, joannelkoong@gmail.com, jefflexu@linux.alibaba.com
References: <20240820211735.2098951-1-bschubert@ddn.com>
 <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm>
 <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
 <3fc17edf-9fb1-4dc2-afd2-131e36705fae@fastmail.fm>
 <CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 18:18, Miklos Szeredi wrote:
> On Wed, 21 Aug 2024 at 17:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> 
>> But how would fuse_file_open() know how to send a sequence of requests?
> 
> It would just send a FUSE_COMPOUND request, which contains a
> FUSE_GETATTR and a FUSE_OPEN request.
> 
>> I don't see an issue to decode that on the server side into multiple
>> requests, but how do we process the result in fuse-client? For fg
>> requests we have exactly request that gets processed by the vfs
>> operaration sending a request - how would that look like with compounds?
> 
> AFAIU compunds in NFS4 bundle multiple request into one which the
> server processes sequentially and the results are also returned in a
> bundle.
> 
> That's just the protocol, the server and the client can use this in
> any way that conforms to the protocol.
> 
>>
>> Or do I totally misunderstand you and you want to use compounds to avoid
>> the uber struct for atomic-open? At least we still need to add in the
>> ATOMIC_OPEN_IS_OPEN_GETATTR flag there and actually another like
>> ATOMIC_OPEN_IS_DIRECTORY.
> 
> Yes, the main advantage would be to avoid having to add new request
> types for things that are actually just the aggregation of multiple
> existing request types.

Thanks, that simplifies things for fuse kernel. I'm still thinking about
what is the best way for fuse server. Traveling (back home) the next
days - will come with a new patch next week.


Thanks,
Bernd

