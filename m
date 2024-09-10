Return-Path: <linux-fsdevel+bounces-29038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5871973CD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2811C20F4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825F1A01BF;
	Tue, 10 Sep 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="eguzrwBI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yy/y3egC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE119E989
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983921; cv=none; b=CgrX4KAcrIKfI0v1g8aMkqsdWghgzQ/D7OnfRUvPAt4mD61kY51ZnY+WP9Q8nqqnd/2ZQEvB5HadxjnXt/MGt1WGeazlpVgEL3OOzssBnHPtBedoophc7jdIh6C+ew6QnNw/6Q2HgkZ17yqjrR1lv4XqWZBALfn3zACUjDOSoYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983921; c=relaxed/simple;
	bh=3Py+JHIGN46rSiyrmZWXqbTPfvG9rEjQSslYobGvKz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pxnt/jtoUKyq8WNE8YNu9gjxZDWDn7qIxlKMCzgPKG0+0QgLJ8uti+uWZq5rhxFwHeCpQQ1GTPsDhSKs+7rMF4fv5Xdqubed9TULsR3h4bG44nfWRc1SU18rUX83Q6eIlneM1AvPzZchjvlVQU522Fz6dSpPfJCbemjU9IVP2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=eguzrwBI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yy/y3egC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 83BF113801DA;
	Tue, 10 Sep 2024 11:58:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 10 Sep 2024 11:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725983918;
	 x=1726070318; bh=u480jq2d7GpTCXKmssv36sL6/YOZVP9nUjQobYgUqJc=; b=
	eguzrwBIeYnVzFAVnN8SnCfb4KNoIQOOw9MRZ/xorB0FFIiIWrsgrZ7TD+qW5vIw
	vlsJtZ/Brx0+faEc9+cYhQCddgUdE7TZK9Z70BdTOOv9n7wNkJoldH1gtvtswuUg
	TVOLQ8PdZL+bMCevlDvBlkBEV84SkzoqWYnr+Jl+B3za2WMYfnR9nLWyL72VYvEO
	s+oqOgAm2t8PIDWFSDylC9lf9HGA9HSdYiAR3zuc+6/OS4dh8Sp/GsVWlfbZKhOI
	ZK7jzXoJs7jQf5REx/KTiQtKahIavD22I/TMU1n4LZA8lg1qPZEbHv2Q/bwV5OH5
	BR/mRXdpu4kbvM7PXIOxRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725983918; x=
	1726070318; bh=u480jq2d7GpTCXKmssv36sL6/YOZVP9nUjQobYgUqJc=; b=Y
	y/y3egCctxanskY21WFpwzak7/nqKQNsTnTJwSdryohdO2875dKUvasY1TEezHqd
	jxtRZAacJTgYUh793bGazijAKwkMRd1D7yozFaoYxshz2VT1RACdkroLbJN/uRCP
	Kg3uKg5mDAZ76rTdxKDjAliRoeLLkLttwx8T5W/3s+2h+dLp5oUR5vBTqLLBPz+W
	U8WYUPmbWhJr90XEFhukUy5KppLMVLcfp+8KKeDsh7GF7fQlEuHDbDvJMglVrUPU
	liPyEcGnKSpIT8jykzfHliZulG7/OaOc9ObB0YHx2OV2g04sLb15fMmbXV0nMzN/
	Zul0+9PSglFIsjkLs/CTw==
X-ME-Sender: <xms:rmzgZn7skF6ytx6v8cL55s-1RStsdkXyT1wMBz7a1RY5p5OX8gE32Q>
    <xme:rmzgZs4BTAhM2hrQXIxGJzfiFKzzVGTcjnNVSyK6ydhrfBmhPlTk-2ZELoMml07ri
    Pw4iuLNlaRvrhiN>
X-ME-Received: <xmr:rmzgZucwRBekNFtUckr4aEf6aAUD5028knNmgtqbG-38JHvaVkK6ZPZwtwYtdRMK8zwbyHmr7AFFaAB-I_3xq_P5e7jDjUoQFNbzvo1degY0zspMH-H6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfg
    tdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehhrghnfigvnhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmihhklhhoshesshiivghrvgguihdrhhhu
X-ME-Proxy: <xmx:rmzgZoLIz9cLLruEnSRVa7mN2lY7WqlGxGQ2ny_p8Joxqih9xc1CIg>
    <xmx:rmzgZrLvuGEbE2T_uwoQ0kaMaA47HLIeKwSwGJDKM9Fj-N--KcWymw>
    <xmx:rmzgZhyXFpgUgDRCqwqG3nocFUUXwDz7tJ4CmtxOCd7UpAEA8fUDkA>
    <xmx:rmzgZnIQzxUKwENpmaj_KPuyLQODKvaVVryFzjhnJR4XwjjkxISJpw>
    <xmx:rmzgZj1EeMPVnys8aPgQSPJB4nI2xRr_GZoY3TxRRMO7ocWpAlTlUx5f>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 11:58:37 -0400 (EDT)
Message-ID: <5012b62c-79f3-4ec4-af19-ace3f9b340e7@fastmail.fm>
Date: Tue, 10 Sep 2024 17:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interrupt on readdirplus?
To: Han-Wen Nienhuys <hanwenn@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
References: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAOw_e7bqrAkZtUcY=Q6ZSeh_bKo+jyQ=oNfuzKCJpRT=5s-Yqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Han-Wen,

On 9/10/24 14:45, Han-Wen Nienhuys wrote:
> Hi there,
> 
> I have noticed Go-FUSE test failures of late, that seem to originate
> in (changed?) kernel behavior. The problems looks like this:
> 
> 12:54:13.385435 rx 20: OPENDIR n1  p330882
> 12:54:13.385514 tx 20:     OK, {Fh 1 }
> 12:54:13.385838 rx 22: READDIRPLUS n1 {Fh 1 [0 +4096)  L 0 LARGEFILE}  p330882
> 12:54:13.385844 rx 23: INTERRUPT n0 {ix 22}  p0
> 12:54:13.386114 tx 22:     OK,  4000b data "\x02\x00\x00\x00\x00\x00\x00\x00"...
> 12:54:13.386642 rx 24: READDIRPLUS n1 {Fh 1 [1 +4096)  L 0 LARGEFILE}  p330882
> 12:54:13.386849 tx 24:     95=operation not supported
> 
> As you can see, the kernel attempts to interrupt the READDIRPLUS

do you where the interrupt comes from? Is your test interrupting
interrupting readdir?

> operation, but go-fuse ignores the interrupt and returns 25 entries.
> The kernel somehow thinks that only 1 entry was consumed, and issues
> the next READDIRPLUS at offset 1. If go-fuse ignores the faulty offset
> and continues the listing (ie. continuing with entry 25), the test
> passes.
> 
> Is this behavior of the kernel expected or a bug?
> 
> I am redoing the API for directory listing to support cacheable and
> seekable directories, and in the new version, this looks like a
> directory seek. If the file system does not support seekable
> directories, I must return some kind of error (which is the ENOTSUP
> you can see in the log above).

Is this with or without FOPEN_CACHE_DIR? Would be helpful to know
if FOPEN_CACHE_DIR - fuse kernel code is quite different when this
is set.

> 
> I started seeing this after upgrading to Fedora 40. My kernel is
> 6.10.7-200.fc40.x86_64
> 

Would be interesting to know your kernel version before? There is
commit cdf6ac2a03d2, which removes a readdir lock. Although the
commit message explains why it is not needed anymore.


Thanks,
Bernd

