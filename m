Return-Path: <linux-fsdevel+bounces-57338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6474B20913
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06F317CDAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6A2D3EC0;
	Mon, 11 Aug 2025 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b="OelWDBRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gtfip+fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4A2D3A88;
	Mon, 11 Aug 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916238; cv=none; b=Au90HPoMxO14WMapvlfcpEmHAODG3mspTMz3idvQyMOtSIYgWyTF1/2c6DJ14mf3w1pU+9q9zQA0S4YqKfF5GUwx4cm1zGLWdMxzgtJdY+z1+GFMOpbCzuTBMq+SSkLBBfEkkcjE+Rm9vIXG9+wzDWJo2H5ZGD73bk6zU6T4Lzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916238; c=relaxed/simple;
	bh=q9CYpkq6EBQT1zx02Btohpgz+ceFDDYnuRg4/W3LVks=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JtUIQCssZ9oabwVPGqN/9thS5UUfrgvUvUl6JNyDd4E2+IegvTHy/XBMn6OSEIYPrKL4aIUI6OT/sRQP4HfRToP1CrOkE3HOCznSGUBTx3rakup8mCv7u3LsHf5J7wpNK/H//XcPiu6OQDHJvzCj419d3GNi/vx6O6wTkbsG1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net; spf=pass smtp.mailfrom=bzzt.net; dkim=pass (2048-bit key) header.d=bzzt.net header.i=@bzzt.net header.b=OelWDBRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gtfip+fv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzzt.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bzzt.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAA2E7A006B;
	Mon, 11 Aug 2025 08:43:55 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-12.internal (MEProxy); Mon, 11 Aug 2025 08:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bzzt.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754916235;
	 x=1755002635; bh=YkBFMLQbtD0UKNRwkM7bGtf9VKzKcYkWlxvxgGNKmDc=; b=
	OelWDBRPmo+LJMFYtneBfj6svlM9BUi/QkkBUFz7IpbQviRNpmcx6R8d5nh8p8Lx
	7Pi7Ealdt7YQ91o6qWh29pjnTxoKTrMs0eBVPaBOTQg7hPUMOKYWcDf/PXbxGAYf
	T0voxONXvC4GaoNH5c6j9V8n6exWRF1rUNh3hDaTRxENuUE9d5cMhhuyBWAKXik+
	UDt2odiVbQArbI1Lyv/lgQFTFxMMyk/m+xCWqey/tGtAkbBZ7Fh9tBxo8hVftII6
	S+IYVO4Iwowk1k78hNLW6YpeaxIvE9NZCsxUiZ6sgr4JbTDHhjxg1Xj0chEQDTDR
	KmnI/v6D92m6iZwcymDTdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754916235; x=
	1755002635; bh=YkBFMLQbtD0UKNRwkM7bGtf9VKzKcYkWlxvxgGNKmDc=; b=G
	tfip+fvgnVkmQH3fjBkg9vM3/fx3jdoI8boecjOzTrQgMY/xXce31iHP/XPyBPuv
	u9HPLahY7riKN8DiwLnpCmyFSH87GLIHcZpFTF6iRrAI+lvoWw+zZIiEchFJQmow
	Ocw2RWGpVaoETE7nFsaewNkpoM/7MOSb6BHoRL8v5PXf22qcuztQumFxUYEF772g
	QkTCKiM/riQwPRjccxpuygqP7/+UNC2JcfvGK7YWrFhLwStapSdwELix17tSK1Jr
	NqTdPzagumPwFIceN/dxcL3byjD5sHb+vPjsKZqVbyMKGztKK56qhC1Gktxc6hRR
	1ProkTAPvZSItv9yH9FUA==
X-ME-Sender: <xms:iuWZaMnRFA1kliU9fUEJdoDsNFaYq-ZACIoYcivDBjoxb89HjvI79A>
    <xme:iuWZaL0EmkEf1v0avhologb0zUvM6G6vmt9x9dEewTGzK_eeFRRkb9v7w2975fulr
    LynyUybrJ8jJhvKEps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdetrhhnohhuthcugfhnghgvlhgvnhdfuceorghrnhhouhht
    segsiiiithdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffleeigedvgfdtkeehvdektd
    fgtdejhfffleejjefgiefggfetffevkeehudejnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghdpvghnghgvlhgvnhdrvghunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhhouhhtsegsiiiithdrnhgvthdpnhgspghrtghpthht
    ohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestg
    houggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuuggv
    sgihthgvrdgtohhmpdhrtghpthhtohepshgvuggrthdrughilhgvkhesghhmrghilhdrtg
    homhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrhigrnheslhgrhhhfrgdrgiihiidprhgtphhtthhopehnvghtfhhsse
    hlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:iuWZaEUb246Zggj5KdtXg-fipRp0Z2p9OtJsHVNSnP-_Zq6DB_-jyQ>
    <xmx:iuWZaC1NJrQtpRUcNoc_Cy7idwRjoo983rXmKN3-SrglbLrYRSNflQ>
    <xmx:iuWZaN3lSeb_b0-MMrtrh5ge-g8Cnq5M0wETtB8hVOT1d5XT522bGw>
    <xmx:iuWZaJmMVkoKDd4K07Tm4qYMgOs9VUQfbL1BoY5z5b_c0T55Ja_2Aw>
    <xmx:i-WZaG5VJR7GXEf6kibh-z4FktAYp_11bAldArILSOO_BLTV0sE84zMf>
Feedback-ID: i8a1146c4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7548618C0066; Mon, 11 Aug 2025 08:43:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtAeKOSr4ONc
Date: Mon, 11 Aug 2025 14:43:21 +0200
From: "Arnout Engelen" <arnout@bzzt.net>
To: "Dominique Martinet" <asmadeus@codewreck.org>
Cc: ryan@lahfa.xyz, antony.antony@secunet.com, antony@phenome.org,
 brauner@kernel.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
 maximilian@mbosch.me, netfs@lists.linux.dev, regressions@lists.linux.dev,
 sedat.dilek@gmail.com, v9fs@lists.linux.dev,
 "Matthew Wilcox" <willy@infradead.org>, dhowells@redhat.com
Message-Id: <9294e7ac-4a3f-4a48-8e3e-0659955bf165@app.fastmail.com>
In-Reply-To: <aJmfBTflGvAI6sBs@codewreck.org>
References: <w5ap2zcsatkx4dmakrkjmaexwh3mnmgc5vhavb2miaj6grrzat@7kzr5vlsrmh5>
 <20250810175712.3588005-1-arnout@bzzt.net> <aJlAD0nPcR2kvAtS@codewreck.org>
 <aJmfBTflGvAI6sBs@codewreck.org>
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 11, 2025, at 02:57, asmadeus@codewreck.org wrote:
> Arnout Engelen wrote on Sun, Aug 10, 2025 at 07:57:11PM +0200:
> > I have a smallish nix-based reproducer at [3], and a more involved setup
> > with a lot of logging enabled and a convenient way to attach gdb at [4].
> > You start the VM and then 'cat /repro/default.json' manually, and see if
> > it looks 'truncated'.
> 
> Thank you!!! I was able to reproduce with this!
>
> Anyway this is a huge leap forward (hopeful it's the same problem and we
> don't have two similar issues lurking here...), we can't thank you
> enough.

Great - that means a lot ;)

On Mon, Aug 11, 2025, at 09:43, Dominique Martinet wrote:
> So that wasn't a 9p bug, I'm not sure if I should be happy or not?

:D

> I've sent "proper-ish" patches at [1] which most concerned people should
> be in Cc; I'm fairly confident this will make the bug go away but any
> testing is appreciated, please reply to the patches with a Tested-by if
> you have time.
> 
> [1] https://lkml.kernel.org/r/20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org

Awesome!


Kind regards,

-- 
Arnout Engelen
Engelen Open Source
https://engelen.eu

