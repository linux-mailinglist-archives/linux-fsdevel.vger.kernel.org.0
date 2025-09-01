Return-Path: <linux-fsdevel+bounces-59906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39560B3EF0D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 21:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069732C1F10
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014FF25B2F4;
	Mon,  1 Sep 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="AR7943HS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFkWaCeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DF2580CA;
	Mon,  1 Sep 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756667; cv=none; b=NR6BpqXp2biprm2Kw7y5iTj3t2dRyjczEijk8pbWtTgsLMpd9N+Av8Ry68XwpsgSUBEcD1muiOYd4cvM4Y2zxz7/dlrzIrw5toxDvjr19MO/9n4t0k8fBJ9sbq1c4KDNA2HUipAl3A1fvcpqaJPZhxt+ZtJB022f5UvL4vrIDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756667; c=relaxed/simple;
	bh=Bsw8CaxEROMumMzgU1S4U1vyDdXzlPluKDsgkqNVJpc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GFpSn05+ys+wa6/lh37eTTotd/eJHFREi/tgnFC6qZJQNQxWyUFz47/Bd5PTvabH4zoK2MOfJlAVi3rs3BZUg6+WvQFDqaXzqVSNIUxkRptgLqdo3yr1iJZMIGxBsd/4dtwOnE0x4ZWhQJkpFabz1nkMTch+0c3DmbqZRLCm4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=AR7943HS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFkWaCeb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 00BAC1D002C8;
	Mon,  1 Sep 2025 15:57:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-12.internal (MEProxy); Mon, 01 Sep 2025 15:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756756662;
	 x=1756843062; bh=+wEl+0r45x6y1/M2f4wYxqvisWrDMs5TnlDtxIfnbLY=; b=
	AR7943HSG1uW1nPvp9Cmm9Pu71nsn8uHaqB221/hWbjvVD+kFUOKwKmeuTlecl0R
	hbpL+orWIdMeBHHAo1LZYx2+dwTTtYYWXpebXXw/3Ay4REWzwyXvNifDKyk5qNY+
	NtEJKuGogiV5nQ3033tcl2yigEA54b+h4dbhHjDV8QJnPpeutV2/zV0u8az8u18B
	jnA89BghL3tw9N3RY9FSqjTbJztnLbQyoHsyh6AWlTeJgFPUJMnMFo+HpjzZIWJd
	JFcGX8xkWEc6EldW/Y+BFdJ26r/Y/hepOYAqqxlN6rtJ9sqlk//L4g7HmO+35HuD
	XzhvehiTJmHGFZQBWuGE/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756756662; x=
	1756843062; bh=+wEl+0r45x6y1/M2f4wYxqvisWrDMs5TnlDtxIfnbLY=; b=o
	FkWaCebXTTmYy2kMxR3nV3f03y7FqJix7KqZ6hidwX3SOHy2fnvAE6B9QEHl79A9
	ugXqjxdh+h10THx5FIwhY4mTDpIYFm9EEFKoYIWkY7xahKsJG5yO/Ftm8emo3AD4
	juVyRQoAYV+gIXyDjDKRF2VVFpbUGXQXyG4x+GnrmuP7xWvDD6dB0I/D80tkZQ51
	dWSyE7HdMhSTEjNNI7zlgzH4ZCRafwaIDTvaZPIjLiGnuqKC1jUfRnyFOzK2ct2m
	Xon11BPM0oycLBMh4QLZJwqluP2Vm4QGIjh9hQHXvJrEMVOn4F3Za/hVfr2xwUwh
	37OGemFRVwg3trZSJlGAg==
X-ME-Sender: <xms:tvq1aLuzyb250eW4P11sRIikWpi6uozVIhvE5d3ueioRVL7n18xopQ>
    <xme:tvq1aMektShrbgsprPeBruANgVfZNj6J9OFea1RIRfMtN4v1SpJU2bgvPi6EW9-Rl
    RCj3wiVsqm56Muo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleeftdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtf
    frrghtthgvrhhnpeehgeeutdefleeutdfhieejfffhteetuddvhfegudekhfejiedulefh
    ffehheffueenucffohhmrghinheplhifnhdrnhgvthenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghumhdrohhr
    ghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hjghhuiihikhesghhmrghilhdrtghomhdprhgtphhtthhopegrmhhonhgrkhhovhesihhs
    phhrrghsrdhruhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseii
    vghnihhvrdhlihhnuhigrdhorhhgrdhukh
X-ME-Proxy: <xmx:tvq1aE-mqt1aWNlpRaoEyHHPCjyezWnwhSKVam0zBV3s2Sz98wfHdQ>
    <xmx:tvq1aB5YJq75yeQftJY68V8d5F7fBKRQPFtX_wLYCSyCI4PhOWFqWQ>
    <xmx:tvq1aK523rkvBvwNgB1kEKhdeVgmSBspTqrxoZjU4KNZrvzKddLq_A>
    <xmx:tvq1aKoshNFNbp8QR_bGu_Y_9_bHmU9jv8AvYULh9SFRym6dBRr6Ew>
    <xmx:tvq1aAMmIPqRng-1uhpesVa0XjR6ouzO0fh3pn6LZrQEtQiNdYM_KUnj>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EAB737840CC; Mon,  1 Sep 2025 15:57:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkTvZmR_UAfN
Date: Mon, 01 Sep 2025 15:57:21 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Mateusz Guzik" <mjguzik@gmail.com>,
 "Alexander Monakov" <amonakov@ispras.ru>
Cc: linux-fsdevel@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-kernel@vger.kernel.org
Message-Id: <7a2513ea-a144-4981-906a-7036d92d4dcb@app.fastmail.com>
In-Reply-To: 
 <u4vg6vh4myt5wuytwiif72hlgdnp2xmwu6mdmgarbx677sv6uf@dnr6x7epvddl>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <u4vg6vh4myt5wuytwiif72hlgdnp2xmwu6mdmgarbx677sv6uf@dnr6x7epvddl>
Subject: Re: ETXTBSY window in __fput
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 1, 2025, at 2:39 PM, Mateusz Guzik wrote:
> 
> The O_CLOFORM idea was accepted into POSIX and recent-ish implemented in
> all the BSDs (no, really) and illumos, but got NAKed in Linux. It's also
> a part of pig's attire so I think that's the right call.

Do you have a reference handy for that NAK?

> To that end, my sketch of a suggestion boils down to a new API which
> allows you to construct a new process one step at a time 

In this vein I think io_uring_spawn work sounds like the best: https://lwn.net/Articles/908268/

However...if we predicate any solution to this problem on changing every single codebase which is spawning processes, it's going to take a long time. I think changing the few special cases around "sealing" (fsverity and write + fexecve()) is more tractable.

