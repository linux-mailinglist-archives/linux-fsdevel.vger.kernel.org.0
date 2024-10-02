Return-Path: <linux-fsdevel+bounces-30688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75FC98D4F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246501F22067
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369C1D079C;
	Wed,  2 Oct 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oMWM41c5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ay50gRV+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F71D04A0;
	Wed,  2 Oct 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875523; cv=none; b=NCZZAcimiwvAMA2aMtUlK6np12PhjIXypYIeOBTlDEcikPZcVc0Zo7LlJV6JNfK6jDQySKbi6NbxVZ2geCrPPSbZw1bqB/DENSYxNDupRliSoaXqIET7UzoyLxNtK9KFC86vpodhyS2Tluy3odIxfowamVRCKS0mm2/Dkspoh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875523; c=relaxed/simple;
	bh=egV8xnUg2Yox7LAPfCu83pPYQGRqt+/jri2jCNfTGNc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G1rRwZS9FM0lOecuPxriuU7eBkvnWBGkEZRywjWtcx/xnPnKtcyTNEed8VbOO0QVo/99Apad7YxgBISlOX5XJlb6kMonBP1S+ek9EHmO78TE4VK4FKcU1t4YBx0nw1+jONvkVTkC+hulAPDzPDhBCh031WqYLsuupLTu6u1cbJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oMWM41c5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ay50gRV+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 16ADD1380161;
	Wed,  2 Oct 2024 09:25:19 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 09:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727875519;
	 x=1727961919; bh=Z4MKQ39vYgIplCzEEGZADkdr7VtYAgse2H3C6I2sd4Y=; b=
	oMWM41c51p6Z55xiU5rdfFIFPJK0iOQkjbrpNqOC9BU+luF7dmJNsS/ykfwOfV7q
	G75wNWXRMDgQcx5Kd4DehCbPITzUcWOFhRz9j9sS+K+zo7w3PW8Fn1wLKdSq5dph
	JdZWKrZj9z9Z1wXfnScj9dVkyQxmCWN9Sm55ftB3BDYKrMC8ysM1RsCreXleafXO
	gmweOTM75djKo4CK/4Cf9p7Mvav3gEeYqo3QAdlfg0bC0reH7j85CqGaCkX/0BWE
	NMdTx1fUAVA0PQycmyugyd5efhm7sXnuAF/jLyxzGLKtjYYfYg8xfEE3WuBfNSHp
	WJk9bRK5GID/cdzuyqszFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727875519; x=
	1727961919; bh=Z4MKQ39vYgIplCzEEGZADkdr7VtYAgse2H3C6I2sd4Y=; b=a
	y50gRV+fGmW6zlioVC87/VMkdc5jwLC5dUhdL9dkMLTONolQ7E2VLb24AmHuVyay
	aRS32diSwefIMguV1fVu6WtsRFYBz/ayiekcW1L1gn69uWR2nXJRRa5CvOcvulKK
	bZNkf/RIqdrpItSbXCYWHG/F5dBqWAXKW2VC9k7NjLakPQ5uoIZKG9XQgWfx1Wc1
	Ok5vxg5xnTIzxKhKHK0CMlLQ+1oZHwO7X/45lDkvvjs0MCPqZ9/E9TVVjpku8H2g
	ZvQFiyKZYTC6fIrtcu6zzEPCPNEXOX0kw+rRnMjUJSmg1MMk5mSbPmPSCX6dWFw4
	CEBSbltM/bhLJYcsicUSQ==
X-ME-Sender: <xms:vkn9ZndHfKpPIGtFb0TcP9awPeLb_NfZY6BtNalhxolTgx-ExTedPQ>
    <xme:vkn9ZtNzyZr9H1TxotrhDZ-ZxXeIXBdOMJ-XvoqxGwEzqMre0E8sFdVvR_noDGPKc
    nf7w2CoWkyuwiloyas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnh
    gvthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrdhhih
    hnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:vkn9Zgg7up0_Cv_sGYEJ-wqBAyJU5Gja4f-S8Iesfw6zRdEEzDCF5g>
    <xmx:vkn9Zo--lxmZ5raBYIl9L1fVmFcXtf-EPJrTIPdcrb5Kt6sYoj1OXA>
    <xmx:vkn9Zjth6CShe8TOpIetpY80Tb-kgntxGvx0uc5rbWIuyh1fsVx3_w>
    <xmx:vkn9ZnEEl8sbQ0-KHOWNcE6Td7DfQmpBuPTdNV_dAKynPZGzgJucOg>
    <xmx:v0n9ZjH3YpJEzFSZ8pnw9OHB4bDIX4-oY5lLoFGOonhTNXYgEUCHyl9K>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 445E32220071; Wed,  2 Oct 2024 09:25:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 13:24:57 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <50b1c868-3cab-4310-ba4f-2a0a24debaa9@app.fastmail.com>
In-Reply-To: 
 <CAH5fLghmkkYWF8zNFci-B-BvG8LbFCDEZkZWgr54HvLos5nrqw@mail.gmail.com>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <CAH5fLghmkkYWF8zNFci-B-BvG8LbFCDEZkZWgr54HvLos5nrqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024, at 12:58, Alice Ryhl wrote:
> On Wed, Oct 2, 2024 at 2:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> A quick sketch.
>
> One option is to do something along these lines:

This does seem promising, at least if I read your sketch
correctly. I'd probably need a more concrete example to
understand better how this would be used in a driver.

> struct IoctlParams {
>     pub cmd: u32,
>     pub arg: usize,
> }
>
> impl IoctlParams {
>     fn user_slice(&self) -> IoctlUser {
>         let userslice =3D UserSlice::new(self.arg, _IOC_SIZE(self.cmd)=
);
>         match _IOC_DIR(self.cmd) {
>             _IOC_READ =3D> IoctlParams::Read(userslice.reader()),
>             _IOC_WRITE =3D> IoctlParams::Write(userslice.writer()),
>             _IOC_READ|_IOC_WRITE =3D> IoctlParams::WriteRead(userslice=
),
>             _ =3D> unreachable!(),

Does the unreachable() here mean that something bad happens
if userspace passes something other than one of the three,
or are the 'cmd' values here in-kernel constants that are
always valid?

> enum IoctlUser {
>     Read(UserSliceReader),
>     Write(UserSliceWriter),
>     WriteRead(UserSlice),
> }
>
> Then ioctl implementations can use a match statement like this:
>
> match ioc_params.user_slice() {
>     IoctlUser::Read(slice) =3D> {},
>     IoctlUser::Write(slice) =3D> {},
>     IoctlUser::WriteRead(slice) =3D> {},
> }
>
> Where each branch of the match handles that case.

This is where I fail to see how that would fit in. If there
is a match statement in a driver, I would assume that it would
always match on the entire cmd code, but never have a command
that could with more than one _IOC_DIR type.

      Arnd

