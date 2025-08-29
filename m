Return-Path: <linux-fsdevel+bounces-59661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13FBB3C284
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A837D3B5DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03C345729;
	Fri, 29 Aug 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="mZ7ljtgk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3hDbREu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75F3451CB;
	Fri, 29 Aug 2025 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492365; cv=none; b=FcSpViNmTU2PGO2FFwJR9qTKV/3zzSOPUqxRfEck5jIdsaBciPlZHgmrBRTgNr65//elrTrsklfP6n3QxRLl2yETJDWQKCH4ub6U8pQg06xezrK0MKQOXq0I9pjooGCWHhRktAan8nmhBy05loLjCU6vTpPz1JhfDsSUFj4kWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492365; c=relaxed/simple;
	bh=SkyzdbblTiqqUWXXVLGliB571OUrcEIqc4SgoQE8/1o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BXSOgo/MwqPFtcOHbeYSslnPZBjPUhhvM4u0O8D1getNYMti/iMLtp5olLcVsL6//aiSq2Va3Gtyxc5B2DI2hmBOPPtjIi2v6VroxAyiLFsD8LFz/KBQxh3zmiqr2ZoMcNuK2evrtpZE29ChbImSvgQKW252V8iOIvg40CHQmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=mZ7ljtgk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3hDbREu; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A0351D00093;
	Fri, 29 Aug 2025 14:32:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-12.internal (MEProxy); Fri, 29 Aug 2025 14:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756492359;
	 x=1756578759; bh=SkyzdbblTiqqUWXXVLGliB571OUrcEIqc4SgoQE8/1o=; b=
	mZ7ljtgkzOdEPCGVRkj/73d9guD1073tj/MZrme+j/0aH5Mwo9WoN7tJywaQi0mM
	RcnWFaDURd34seewrBct+NfBgTZ5HHPWTBH7S6fd173UgNHr/+hU3h16dyzRY6Xy
	+pzsD8GIh0BROrK+5h0GU2TF7ge6wmgDA2hHa8gw0UfPH3ab2SuXt1TvuPMjnGbJ
	mrcq84oRSSciruHLxfbNeNVlMf/des10Wce1CAWMErVGrPY7mWhUoxxrbB4eFHyP
	085fCE1Cdn3KGEUrFRVMzg7JxUchPFzIleZDx7t1R6pXvKhLxZexTKk21GH4g2YG
	XDMvw0vrWioAhk1jMSNNwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756492359; x=
	1756578759; bh=SkyzdbblTiqqUWXXVLGliB571OUrcEIqc4SgoQE8/1o=; b=J
	3hDbREuis4XNmDWa+8f3MSI+nejPq6rN4ovlNiwZefIIRPOVUCHlNkLIqacPz/nf
	keNpsCm5h1oRIKCSaaG9K2pPdJFbOFQmh2XG+4GaQ9TVobJyQHPNzlsoqXQmHZ+3
	vUNfsVx94T3gm/Jz/IKdmJigJ1vmoHa0YHzenSIfJFB7P9X5j+eF07l704MSXQJa
	CWrB3uQ8qArBqJhMxFxqoS7jup1875zlquEg9rce9jKrA914NBCQIKNKBs34hth1
	DOSig56ZiNOI6JnZRITNLU3t8XOsDOzUbi5aWFD2OS6c4QE6irlLwNXTTf7Dj2OR
	yNJwvgOu82FRznYgu9nzQ==
X-ME-Sender: <xms:RvKxaPlx9Uq3cijYR4JQIabpe6TxPNDAYUOFmwDCsf0NFogtnIVssA>
    <xme:RvKxaC1Zaba98gu2yHurGIDuTkYNgTRcKDPm7NNuCQ9GMaPxKif3AzYiivfK6bvlz
    24LY5-lb55hOJBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtf
    frrghtthgvrhhnpeevudevvefhffefgefgudeffeelheevueehuefftdfgffekjefhkeej
    hfelieekkeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgruhhsthhinhhgrhhouh
    hpsghughhsrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgpdhnsggprhgtphhtthhope
    eipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhonhgrkhhovhesihhsphhr
    rghsrdhruhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghn
    ihhvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:RvKxaC2Mi26EWxdtKSsGZhoAQzUx2XFjTWn-2ORhFtmPtMERgtG1sQ>
    <xmx:RvKxaI7xi_jSXTcUtiqbipMN43JfUZC754hXJaaQYnaG4ZLPTSJiSw>
    <xmx:RvKxaD_N0LPFWAQSd-Wq_5JRfwGY1nQfAmeppx_yEmRY5Zho5hmWmA>
    <xmx:RvKxaHVZPHRsCQWEseqZam9j8uReVhUAfxgUsyWPxTpEYWdjPzcMyw>
    <xmx:R_KxaAncT0xO0eH1DzCs7TPH4-PPP_LLPQiQ7zpbBvhRsllq2MiZbXTj>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE9107840CC; Fri, 29 Aug 2025 14:32:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkTvZmR_UAfN
Date: Fri, 29 Aug 2025 14:32:17 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Alexander Monakov" <amonakov@ispras.ru>, linux-fsdevel@vger.kernel.org
Cc: "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-kernel@vger.kernel.org
Message-Id: <adf9aee7-1621-4da9-b04d-754084fa8adf@app.fastmail.com>
In-Reply-To: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
Subject: Re: ETXTBSY window in __fput
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Aug 26, 2025, at 5:05 PM, Alexander Monakov wrote:
> Dear fs hackers,
>
> I suspect there's an unfortunate race window in __fput where file locks are
> dropped (locks_remove_file) prior to decreasing writer refcount
> (put_file_access). If I'm not mistaken, this window is observable and it
> breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> in more detail below.
>
> The program demonstrating the problem is attached (a slightly modified version
> of the demo given by Russ Cox on the Go issue tracker, see URL in first line).
> It makes 20 threads, each executing an infinite loop doing the following:
>
> 1) open an fd for writing with O_CLOEXEC
> 2) write executable code into it
> 3) close it
> 4) fork
> 5) in the child, attempt to execve the just-written file
>
> If you compile it with -DNOWAIT, you'll see that execve often fails with
> ETXTBSY. This happens if another thread forked while we were holding an open fd
> between steps 1 and 3, our fd "leaked" in that child, and then we reached our
> step 5 before that child did execve (at which point the leaked fd would be
> closed thanks to O_CLOEXEC).

This one looks to be the same as what we hit in https://github.com/containers/composefs-rs/issues/106 but with fsverity.

I came to the conclusion that we want O_CLOFORK (ref https://www.austingroupbugs.net/view.php?id=1318 ).




