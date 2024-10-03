Return-Path: <linux-fsdevel+bounces-30882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A00D98F02F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF761F21DF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF16819AD5C;
	Thu,  3 Oct 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="eFZsDRji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jui4qD03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B182BAFC
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961582; cv=none; b=bs3n8mwfmph1xzSshOy7y4Sy+eqmzrMqSjERCzsapiHK2/lH1PoF0rm5fjK5bhjtZpUdD0xLq+8uhNOd9P2Kyr03ymrxw6LFD2qHwlWEPuWATnVsV6IvBVSsZH4xrf/pH+z8wR63rRq1fqaaq0KORjzCYW5puZd/zRq+WSqpCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961582; c=relaxed/simple;
	bh=IDlCndBvWaBCAt6szH+YpO0XtWjFJdjkh3m9FXnXaGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AxmsBE2NckmgklpSdD4vxQw2MY9ae0GU3IYs53GEGsx5OfCJDl8o8/5KbSo+5ZuPUtYViJf3Uj/V7f2ksL5zQS1TBXynJyXURn2DrRc/dAQ27YjJj7Uo1IEW/GaeY9XzF4ZiLZz3Gt7eva0FPUZm9qWWT78np8bjelb+3BBVkiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=eFZsDRji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jui4qD03; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 60E7C1380244;
	Thu,  3 Oct 2024 09:19:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 03 Oct 2024 09:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727961579;
	 x=1728047979; bh=hLaw3nlRMwXdd6xv4Fjp7mUdZUi5vNR+kTRy82KrBy0=; b=
	eFZsDRji/1xtkxsKxtmJ31/ONlSDPDn6rPWgDs4lYrc3y5r8R5IXkcsu3koQ82Ha
	Eu6sytxSwI+fCl13wiT6k86BzDS/paIZKQmkYoo03ufDfwje5QB6fiLT8fxKaYBH
	51CnpEYgxu/4CdrHebqZgkgOsY4JfN2vsLnTTkCVCafKBPDgOlU31ojH6chKtwRP
	+c7Kqp8hX6RXYDUC52Abx8dIewGNKV4gjT0R31NsESQm10Co4pc+R4jMjQhcZCt5
	DnezF2vszs/MlRqZ3Fg7nJfZ/7DB3dKSF9hrpKQCBOPhjMKcUwwG6sQEnMHIpYZI
	Wsl8CmWDG7hAphhp9HI3Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727961579; x=
	1728047979; bh=hLaw3nlRMwXdd6xv4Fjp7mUdZUi5vNR+kTRy82KrBy0=; b=J
	ui4qD03/Wf6SC8+jY1SB1RgYrWDqgwQsytKoJh6i5CPZ16D3fJsLmQm7848zDrQ1
	5DxYFtDSKyKz6Z743iMJZjdHspMmLDt93DagtvFxGNK1LV+aMpjgdw43++2fhzAU
	61IZvXdKRHCGW7t1tKToSXqrtHMge/11v67Ub9QPzuon6/3RGGgVYJhLhOI+4yA/
	G56/H/UXA4fCKS2sudbfyh+7RURuooD8jbdIe8i2jvpvGM/4QZjytIXFXlloJSZe
	MDj9UlUw6YLD/pHg76pezCOX/zNhjqJyjuJdufbK5eXsCxS/jMhp+3zH/68icj3g
	6dm6iGJCfXX8X97ORsMag==
X-ME-Sender: <xms:6pn-ZngOEuv_WTXVJe9ifgCbh0AKePYS5Pc8JgaSmvOLFPV28M7huA>
    <xme:6pn-ZkAVRv6kvaRrHZFwlUfMslNjSR_xZk6qvARWtLQh2NYlw334zpmFWoqMejiD8
    TfztaiKdmcc1N82>
X-ME-Received: <xmr:6pn-ZnHkTkn89G5n6qoaVImW7U8IyEnhDD3oGhCCg_Y0ccjWkthuBHViD2IlVS94kRVcmTFRUqCWp76cA0Smuhpfm1sCd92upasM8H9kqe-eviQ0R_G7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgieefucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:6pn-ZkQ25PLeg_uz6CgoZgDt4Z5Od6zjQTS3mj_MT3wQ1N3nB1da1Q>
    <xmx:6pn-Zkz3366wrHI1rmKkZdiDenj69J6GDf1oBp1T1rwp2l-Ug64RTA>
    <xmx:6pn-Zq4vgRAlKwM2crKFleWVY34nra4RtI9HzPretwNoYMzaLrIDnQ>
    <xmx:6pn-Zpwy3WK_noFNOIXbB9cXld9Fh9cMoN8QUgtgzNaRlJtFdcmWmA>
    <xmx:65n-Zuv4b6qlQNZtFhfHYDGK4QS1tEyoW9cG-Afb1O6gBXG5ZImyRXcx>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 09:19:37 -0400 (EDT)
Message-ID: <c2346ef4-7cf1-412a-982c-cf961aa8c433@fastmail.fm>
Date: Thu, 3 Oct 2024 15:19:37 +0200
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegtazfLLV9FoeUzSMbN3SoVoA6XfcHmOrMZnVMKxbRs0hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/24 14:02, Miklos Szeredi wrote:
> On Thu, 3 Oct 2024 at 12:10, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> 
>> What I mean is that you wanted to get rid of the 'tag' - using any kind of
>> search means we still need it. I.e. we cannot just take last list head
>> or tail and use that.
>> The array is only dynamic at initialization time. And why spending O(logN)
>> to search instead of O(1)?
> 
> Because for sane queue depths they are essentially the same.  This is
> not where we can gain or lose any significant performance.
> 
>> And I know that it is an implementation detail, I just would like to avoid
>> many rebasing rounds on these details.
> 
> I think the logical interface would be:
> 
>  - pass a userspace buffer to FETCH (you told me, but I don't remember
> why sqe->addr isn't suitable)

I think we could change to that now. 

> 
>  - set sqe->user_data to an implementation dependent value, this could
> be just the userspace buffer, but it could be a request object

Libfuse already does this, it points to 'struct fuse_ring_ent', which then
points to the buffer. Maybe that could be optimized to have 
'struct fuse_ring_ent' as part of the buffer.

> 
>  - kernel allocates an idle request and queues it.
> 
>  - request comes in, kernel takes a request from the idle queue and fills it
> 
>  - cqe->user_data is returned with the original sqe->user_data, which
> should be sufficient for the server to identify the request
> 
>  - process request, send COMMIT_AND_FETCH with the userspace buffer
> and user data
> 
>  - the kernel reads the header from the userspace buffer, finds
> outh->unique, finds and completes the request
> 
>  - then queues the request on the idle queue
> 
> ...
> 
> What's wrong with that?

In my opinion a bit sad that we have to search
instead of just doing an array[ID] access. I certainly don't want to
rely on the current hashed list search, this only works reasonably
well, because with the current threading model requests in fly is
typically small. 
And then rb entries also have pointers - it won't take 
any less memory, more on the contrary. 

At best one could argue that on tear down races are avoided as one
has to do a search now. Although that was handled but checks
tear-down checks in fuse_uring_cmd.

Well, if you really prefer, I'm going to add use an rbtree or maybe
better xarray search.  No reason for anything like that in libfuse, it can
just continue to type cast 'user_data'.


Thanks,
Bernd

