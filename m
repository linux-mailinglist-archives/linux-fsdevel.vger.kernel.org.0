Return-Path: <linux-fsdevel+bounces-30732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79498DFB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9617228448B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9181D0E08;
	Wed,  2 Oct 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TU3t05EV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5Q+YBcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0861D0DDA;
	Wed,  2 Oct 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883937; cv=none; b=Ewbx+QTT1TQ4Kk6ElBqdvp4MarrTHAaAxrc1hG7FiVImaLTRHOxuYY1c6KP7KEv4gVFaySoe+MxanxSQb+NTLIemJMNkB+nevblWZkWMgrWIUhjvjfw3hIX472lfPrHzP8Ion7J+uNTmezOO9E6o0bsUayFoCtXK8bVTV1UOX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883937; c=relaxed/simple;
	bh=eNw4arMQ67mFk/jMxU41QXu7mkTh6QRJeAtFMw5V9fA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J5TRjMPZEHrw01zDXB3GsBVPz3V++idbQFrAlLjkRPBqxKo34ILS/C8kt4gX7IM4LQmzvtJFVIYUOuo6+TA86MUKzwteZhzqC7VuxUxB1NDoO1a9TX5p+xL1O5c0L6iUcPb/MI0znP93wDKnR6Yzy+S6wJJpnJePqY/mnEOucmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TU3t05EV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5Q+YBcT; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5939213801D4;
	Wed,  2 Oct 2024 11:45:30 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727883930;
	 x=1727970330; bh=oty9sIPBDyhv/ZrVcebfA4NP1nfbxqi9GsI5LvWrrbY=; b=
	TU3t05EVvnf+3c0sOGvgfnxfzdU7aSj5aDYQ8lyymUzkbF1u0H28xAnzXyVimMqC
	LFFVUXpQLq1qFq7ZuIaxYPr0hH1RLmMWCF4VegzeRud3I23Kw6e0qv8itsHk1NlJ
	JQSvD1HeK0OXbQy0b5nbqpMGx9jXgK1iUyqFbihKrN+7m2tADmb5GgggAYcjqwps
	pvbBlVM/XcHxmmeuxaDAugd0ig/wm7XsQ5/KM2NMVY2iAc4pDjcMz0fgrCSuZcQf
	1dpUjBNN7FJacGQ/6QrW/IGjEf8Iqfpqd5m90OLaVliSFkD2jFn4AvwuyfSNHOhD
	U2r1AB0zc39ROTeA8yib7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727883930; x=
	1727970330; bh=oty9sIPBDyhv/ZrVcebfA4NP1nfbxqi9GsI5LvWrrbY=; b=E
	5Q+YBcTJFwGrltbC587xsM4eizoIksjMfg0VYZF9YOC4UKOtwkXIu/Hb5+mrAexQ
	1Ksfj/NQGrpnMylYRj5WG6ihKwXHBm+i+kH18nYwDWz95W+RCMGmJiZkDFNjkX7D
	NP3y1Q/gvfXDcPQUNHblmjtDfiqQ4Op5td3XYrqxUe4IOoKzmzpkSWgib9EHnZd2
	Cl+NbIRv2ncqw4Em48HotsxzAF9c7Mxl/XwiiTvSXET1NVU9yuPfr/CddxWcfHua
	bcmTiAd9Rp/oCTna/2BLOdOfH/W8mPOEeLh1wJOeJ/X8ezLmXYgsdUFoVz1FWpmG
	Oe/rcXGetx+ZFi+bdSAKQ==
X-ME-Sender: <xms:mWr9ZozH4bN5v69rCWMkfKKW_V0DjkJW9o15vjST08rbfZZyZgGtCQ>
    <xme:mWr9ZsTabxXJ5N7tM1CEcDeVMnBsB25XwCF0O5hzt-_Uh2ASpHtp3MF7R3-kgsSnh
    jpbU9edCxjoipuBDyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnh
    gvthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrdhhih
    hnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mWr9ZqWVPDt5RBEIqvvyVgEU6Ct8PJNcawEza60twQ07LV7vfAoMfA>
    <xmx:mWr9ZmhhPfaehgEIV-twXgpg_3UV4TL1sGYGySNmgHr85kfc0G_g1A>
    <xmx:mWr9ZqCtyTX1RNs6V4W0j0wEjlpIe5TEM7d3FO9NS2PkTEfeK3JhSg>
    <xmx:mWr9ZnJJQ2lG2BKgYmMfWBVAYnvzFuTFxZ2yS577rfaUUdQfgE2N2Q>
    <xmx:mmr9ZiZcEXn7tfIoHJkk7yhhspjTgTExumE1GtGCbN_YXXNP5lWYssLP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9027B2220071; Wed,  2 Oct 2024 11:45:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 15:45:08 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <10dca723-73e2-4757-8e94-22407f069a75@app.fastmail.com>
In-Reply-To: <20241002-inbegriff-getadelt-9275ce925594@brauner>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <20241002-rabiat-ehren-8c3d1f5a133d@brauner>
 <CAH5fLgjdpF7F03ORSKkb+r3+nGfrnA+q1GKw=KHCHASrkz1NPw@mail.gmail.com>
 <20241002-inbegriff-getadelt-9275ce925594@brauner>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024, at 14:23, Christian Brauner wrote:

> and then copy the stuff via copy_struct_from_user() or copy back out to
> user via other means.
>
> This way you can safely extend ioctl()s in a backward and forward
> compatible manner and if we can enforce this for new drivers then I
> think that's what we should do.

I don't see much value in building generic code for ioctl around
this specific variant of extensibility. Extending ioctl commands
by having a larger structure that results in a new cmd code
constant is fine, but there is little difference between doing
this with the same or a different 'nr' value. Most drivers just
always use a new nr here, and I see no reason to discourage that.

There is actually a small risk in your example where it can
break if you have the same size between native and compat
variants of the same command, like

struct old {
    long a;
};

struct new {
    long a;
    int b;
};

Here, the 64-bit 'old' has the same size as the 32-bit 'new',
so if we try to handle them in a shared native/compat ioctl
function, this needs an extra in_conmpat_syscall() check that
adds complexity and is easy to forget.

    Arnd

