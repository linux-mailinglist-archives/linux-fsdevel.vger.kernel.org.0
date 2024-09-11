Return-Path: <linux-fsdevel+bounces-29085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C9974F0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCE31F2521B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DAA15C13F;
	Wed, 11 Sep 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="i4wyOMhW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obcmpIdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B5157480
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048285; cv=none; b=BbhYxtSPSRoP2SW3ZLTOo+JOzXzV+NSxhFpbz/dEhU53AvC/gKeHaWDAjwe5aeMBOBLZpjoIv5dSrZgSW04jOorBz1Pucn7T5aHpYYuBIgbasscyK7gbQIEtoqAUNhWQNhSaqe4gxfgTquOXm8ooh9j0o69vA3YbMqzceHEN37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048285; c=relaxed/simple;
	bh=uEqqHpfaVt2WOJTA9rCQbe8MYCahEZTdBr2UQ/H8NpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFsPTtwqxFvK8joTTSkssdeiNQH3L0KgCW6QdWocRPWwpIm3eT6ijoUAhzsP9sKpaQ7+2aV3qEzLzCBkmZbwB+72sYH9T3mB5DSOg8MpWZOcAGppj55m4p5IXkSS4InGmCCsycQmdJx4PB3DLjbSpxZFVSrpsXenPUiPPQl3P1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=i4wyOMhW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obcmpIdA; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A64711140297;
	Wed, 11 Sep 2024 05:51:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 11 Sep 2024 05:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726048282;
	 x=1726134682; bh=VyF/01k+QB6QutyustloSh6o3y/1TLCKWDbyZa6q+HU=; b=
	i4wyOMhWkXgDFPRHPlqWzgWKjwZtQqfcAv+Kp58nbopio2t+Pkg/j3C8cBYx34rg
	x6JLcsJ3x4SE46GDYRj1BhchVTaEQqHCJpQUwXIkH0p4xqzNMeheKYdxVt48bc+s
	EzLfJYbC8hsIlG6ujpWg9RqjgcFb25mo3CFwWz6qTwK8E9IAl77p8wCp9VWaa0DK
	Wj1DuQt+xqhUXybsSOgC0TbynC+TciXffuMrmNwNL51DzU3XBhRToZ2YpgENIgll
	86jMcoepsO0gZyHITW0/icgNHLbY/rd2WXqg22qLaJiRGkaWOkUgVWEwGxP0OQ6v
	9Un6rGicDms8eDQTXslDUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726048282; x=
	1726134682; bh=VyF/01k+QB6QutyustloSh6o3y/1TLCKWDbyZa6q+HU=; b=o
	bcmpIdAaDWMQpRolBUq+2s7oTFObdHA+cJtJgcLBwk1fpAqvp9zP1FbzKb26y5+D
	2RqN0J+s2Dl25Y4alluafe/gWpu8E5z123QKa1yeZ+Tj3uWIykQxZtPrqedlV+x6
	82FnA8ZGKSnirwYwu5Jv4KzxS9XzXcaZNNQbGuaUGzFQw+5dsjuqe17Ccvmp7OUz
	yzjNkZWtMelaknstyI1i5MXBKZOKyhajIowhG2y8Xvf2l5Qy2Slv/5KcFneEKKxH
	iR9g5EiuUvKTA+F9msVoDWdONxtUHW4w8x9Va47U9oleKgQIqqbdKNXRbwxT9iAO
	UKQZ7dAhEQqX088varYrg==
X-ME-Sender: <xms:GmjhZpyk_48lLq_o9B5voLUcR0Ns21bo05nbHizE2eEDvLKdJryIsA>
    <xme:GmjhZpRag01xKdzde8w3pUYf60WXV5zqyBXOGg9rzQLVRvX1V6GpY9QuqC0fBtnOT
    5mLIP_kqHQnAQUH>
X-ME-Received: <xmr:GmjhZjXhHtRk5Jmq3m3UyK6XwuK-gOAgt1FQZbOATH4OmIzAz2t-8mTvXaQ1fuFz5f-rSuQLF-5oav0BZ72yCn3gimSM5ryo2xTs4qkfDDlfrgIJ6_Ii>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehhrghnfigvnhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhk
    lhhoshesshiivghrvgguihdrhhhu
X-ME-Proxy: <xmx:GmjhZrjtOucI1MBjqZL0f-JFpxD0fVrTMrk56XO30_tcg9XMdmynKQ>
    <xmx:GmjhZrBLjldrWXagTsTyoaUrHz7HTJpPzYhGDmtfujtV8T4oiqKx3w>
    <xmx:GmjhZkL2vAZylVCL0VI4cIvGPc8gk-2LTlheS2NECViigjBcD_NTQQ>
    <xmx:GmjhZqC3KVdpXEZNZfAzw9XtxbtfVc0Ki36IoqLLNIxH648eNXgx8g>
    <xmx:GmjhZm-afmSupFY7yAnE7Pved5bQ6Ee45-Vw7vDQ2hSTzmNJ0_fSF1Dp>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Sep 2024 05:51:21 -0400 (EDT)
Message-ID: <0a122714-8835-4658-b364-10f4709456e7@fastmail.fm>
Date: Wed, 11 Sep 2024 11:51:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interrupt on readdirplus?
To: Han-Wen Nienhuys <hanwenn@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
 <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm>
 <CAOw_e7Yd7shq3oup-s3PVVQMyHE7rqFF8JNftnCU5Fyp8S5pYQ@mail.gmail.com>
 <CAJnrk1YxUqmV4uMJbokrsOajhtwuuXHRpB1T9r4DY-zoU7JZmQ@mail.gmail.com>
 <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOw_e7YSyq8C+_Qu_dkxS2k4qEECcySGdmAtqPcyTXBtaeiQ7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> 
> 
>> If I'm understanding your post correctly, the issue you are seeing is
>> that if your go-fuse server returns 25 entries to an interrupted
>> READDIRPLUS request, the kernel's next READDIRPLUS request is at
>> offset 1 instead of at offset 25?
> 
> yes. If the offset is ignored (mustSeek = false in fs/bridge.go), it
> causes test failures, because of a short read on the readdir result
> there are too few entries.
> 
> If I don't ignore the offset, I have to implement a workaround on my
> side which is expensive and clumsy (which is what the `mustSeek`
> variable controls.)
> 

That is the part I still do not understand - what is the issue if you do
not ignore the offset? Is it maybe just the test suite that expects
offset 25?


Thanks,
Bernd

