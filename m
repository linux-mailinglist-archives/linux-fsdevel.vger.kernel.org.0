Return-Path: <linux-fsdevel+bounces-36286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E2A9E0E6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 23:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8161DB2A6A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 21:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5B1DF748;
	Mon,  2 Dec 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="j8Nk7cM5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NRciItoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAFA50;
	Mon,  2 Dec 2024 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176211; cv=none; b=ikbWAPSBfNSOv+FIgG4iYk2B2SosubmnjXLupmYek0rO2PR9aGmL1vvZ2R7oSoxRnRc/f2O6E9ZMzXbPJ/kxTkdRagGoO1jtauq6luyZgpsS+LiBFBw/6bEYZK+6f6LfZDrtW9tAkNbAtqprhp7jzUaNif4rYSRe9Qxb/1uMSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176211; c=relaxed/simple;
	bh=XoADd0ngvc0ii1gCfzrSDFcbAn0l59Bqsdk9xwTlMsI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZTrL0zohY4rYQGYmTmWpEJymxKdKPecS0HOgfz+3K3RljMpWHX1ixDjzkIwSV5ymhigywMiSMUQ9O9njazS4ImW3Cwlh5iBp2YnDhqWf9iBHWB6ptFurD5XasuPwZLPRn/KQJLICbbIejk3z419ZWLPRfcTgqwGSIzzD/wVINyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=j8Nk7cM5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NRciItoR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA120114020C;
	Mon,  2 Dec 2024 16:50:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 16:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733176207;
	 x=1733262607; bh=XoADd0ngvc0ii1gCfzrSDFcbAn0l59Bqsdk9xwTlMsI=; b=
	j8Nk7cM5E3omutwsSiZb3XiZjA3ZByAZnNgAqa7B8FxX3ynx4ysRjf0rtS9th0hz
	Fllui72ssoJxNLSzpIJK/YPohGhXkTfKccyztqQ0GPCKiFXxtTOwHeGO0QiX4bUk
	oBTotkhWw5A2LB6BPZ3rCwbV9AQvZR9xkCuA84NSxorCg2pNSVD2piAuqBbLdy+k
	qPWKG8PMRu4ROfVu7jICG4+bKEHDpbBtlTlnUvSZzO2Fylpmq6zvj75B2MZuRD3n
	eikHoGZ3DuxYco4s7DHdpmX9b4k8HqUB2FV1suklGztdtsQGxeaYGZEZhmhNZVAU
	Yy+5E9PtqwUuD0JbkgDdJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733176207; x=
	1733262607; bh=XoADd0ngvc0ii1gCfzrSDFcbAn0l59Bqsdk9xwTlMsI=; b=N
	RciItoRLMag1d+pCQSme3w2jXhVvklFAGVWi87bEae3mZIFfxD7NMTeE037b8JdX
	ekW7YHCCGQzbNHnXWdx+kLKQbjDd1xsOoalXqQdf/xwXk7Ay2Irzi6yRyPYv9Dw7
	qRo6QAoo3eXK0gqxWEjEXRo1ReJKhwCFmmJZHpYMrfnGEXq15WjjEEo4tW/Bwslf
	lNTnCOHC1lW3ZiMKvi215OJaaY8/y3SWSuPz76bwxZen0p3AJISAvA8ZduPrN8Eq
	2e1KoYiX/TIXMdqdMUXpIXyq8OHAgjfsK6ynEPPECirDnja+or4M0f+wKnIcmwRb
	33szpomEKAOMYh3S/x58Q==
X-ME-Sender: <xms:jytOZ4_YtU4An2NYwpHbiJGkjKHCGSuM40T6FOo80ruw7AY8IVT8kg>
    <xme:jytOZwvLx9GwwJHJa4cTJ71TYydw3GTHxioCiQ8hAJB2qjJj6kzQT-mhHcOo6LmHH
    XLaWe5PGC6APKoJ>
X-ME-Received: <xmr:jytOZ-CtAYIaOLMFtVZvPXEbyklqT3eNGAyqEMWsH0PIT-HolnXUIFFiH_gRVaSZPdP3-_dTk-p-3PG6zWzVRzgOpaL-vVerI4fQC_MPAs4NQxesmae7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepieekfedvleetgfff
    vdevfeelvdefffeghfetgeegffduudehieeuteevuedukeejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehnihhhrghrtghhrghithhhrghnhigrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgr
    nheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehshiiisghoth
    dokeejsgekvgeivgguvdehuggstgegudejheelfhejsehshiiikhgrlhhlvghrrdgrphhp
    shhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:jytOZ4e0UazsaxIFy4dE1osarFnI30-CqcrMTCiYQhSxQ9tvMcAgEA>
    <xmx:jytOZ9PrsoGO98lrLBZugyPmxoLqo3kz49q_MYZccT3hCcyYdUC5LA>
    <xmx:jytOZymXeNrm4XioOnipRW7getQx16QJMhAR3DxJakOgeMX4KO_nTg>
    <xmx:jytOZ_vDkLei6Q-PCQjKKLPWPVoKkdKRL0u6Z7mQdMJX5qSftAv9kw>
    <xmx:jytOZwcutuYdYqZpQx2sCNW27L0PFByIh8_CP1F_ahR1X7DF-rqJh_8n>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 16:50:06 -0500 (EST)
Message-ID: <c2f05447-0f1b-4710-ad7f-d318b95ac7e3@fastmail.fm>
Date: Mon, 2 Dec 2024 22:50:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add a null-ptr check
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
References: <20241130065118.539620-1-niharchaithanya@gmail.com>
 <8806fcd7-8db3-4f9e-ae58-d9a2c7c55702@fastmail.fm>
 <CAJnrk1b1zM=Zyn+LiV2bLbShQoCj4z5b++W2H4h7zR0QbTdZjg@mail.gmail.com>
 <364da8c4-7559-4c6e-afc4-d1b59a297d51@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <364da8c4-7559-4c6e-afc4-d1b59a297d51@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I think I found it, look into fuse_get_user_pages() in your patch - it
returns nbytesp as coming in, without having added any pages.

