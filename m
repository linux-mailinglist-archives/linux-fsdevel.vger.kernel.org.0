Return-Path: <linux-fsdevel+bounces-30728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B598DF37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACB51F2569B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756B1D0B82;
	Wed,  2 Oct 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HBKSdGqc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpwEGpXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536A23C9;
	Wed,  2 Oct 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883145; cv=none; b=TEw3ZZj0T1oSTJm2nJom2pW6qzq/IaRPYGsjoZNkU/rRuxR2+nWYgnvFQJE2Kh3MaAsPJQ5b0xxP4cJP/Qjz+J3Tto8Jq+/X0+KQeVUV4OeA+qQlx3CeJsyzLtl1QIVN6rJQJ//cCgEzO7kSexeqQzYviq0vFKuOrDQFjn2aFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883145; c=relaxed/simple;
	bh=dv8Jq3RMXP2neJCCNvhcBngd39WK1oFLDQVoovW1SyI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tnZPGI6+QDm/jLIveHPgExYFmVXWytJwEY/1I6YPIhTF4GyH0NpLN1xwJdYufhy4cvZmLtk/dTVRKBATCUvj6CJmeDopd9WzXRLhiUVEj03kItQuWiy8r4C9wVfs4EvB74yvPo62caxtKSy1V71TSN0yB92W5jXhG/w3z4rg80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HBKSdGqc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpwEGpXe; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 767F413801E5;
	Wed,  2 Oct 2024 11:32:22 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 11:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727883142;
	 x=1727969542; bh=4v2KYEEwHpmE1Lr5xj6ZmVuQBMjcCa/z8GvIKBxSidA=; b=
	HBKSdGqcirudqKvPgQPrOQ5IOudY5lwYtlAqs3w6DF/znILjMzgG0uo051/HOV4s
	g7hXPLoSmtV6aiq8J5/HVoWTkqGf6tcdiIaTuEb9DCv2rGY6DY3LuSaBWgwMYYM9
	T9h13qIJE7WLKrFYuDhics1nRmzze6RNYEfW385JveuuRCgJsbPwnRWRc35lor4a
	WQOG4MCk1c0WLE4lDHja/9ExH+zACl4ZAjzuq9fS2ANBMn9JhYX+tmocFM59FOXy
	GJ7l3Mj9Brk0JUnjy8Rm+Xq74gAlv4rLrP0PpqrbQaWwj38FicCpNwpVVg7WFZYg
	gbUegv0XIjLXeJBXoIy/UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727883142; x=
	1727969542; bh=4v2KYEEwHpmE1Lr5xj6ZmVuQBMjcCa/z8GvIKBxSidA=; b=H
	pwEGpXeI0in71Dw4X8F5A7D3d1A423RQ66mATPL/phLVgpPzphj+YF9xiLbZnI7g
	kVAgRrFd3I0yfd6dL/vscuTa0X70HjHcLMNJ6d8dZYIgoKGb9Vq7Q1ARlyV8i7ZE
	OIzwUsKxgd45tl1G8L5Acl5XqmZkbSu1vFVfFY4+ZmfbsFSVDHBltp9I019eaUR5
	PkA3I9Br0AD1LCgPhJXG+gcVTQjM9XqRDsEuGFLpIRM9T/ckAMg0yjbtCJIHsBrg
	8wc+Azi8o7UgXpoL1Ay/8Rl9m0zYaOtjGIJyoKr6UPV3TNHPwO9BzdUA9WzrABIq
	X8IqNLhT6c15dE7566ysA==
X-ME-Sender: <xms:hWf9ZonWyk3K4TGElhzuZPV2t8XzfFm9sShnVFFiO8GJCUVu9AS3SQ>
    <xme:hWf9Zn2KXjjMZ2f3CAOOkLzEQ2JJhiuovSUstDT7bRUKAgpswRuJxhQ7BByBozvYu
    bpwSYeQMKUwpNY5aqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:hWf9ZmqdSflvrACVy31NGa4AowXp4IB0YreIhW1Qury23sCepzLA3w>
    <xmx:hWf9ZkmuYJZ4CGwS9XRD6B3K1GWThUhHqVL6VPR-18n1eObRLAnYLg>
    <xmx:hWf9Zm2PTxlbBAtMl1HLKVyDf_WLD_ykyIE4xSOofoPksABwdDcd3A>
    <xmx:hWf9ZrubHoF9xT6XQjqScAMhxCpNWO9yB_p7jmknmPgoTVNyDEt1Tg>
    <xmx:hmf9ZgMPCEpeZ55MvVCRxPrvzoq3qz-CWRJN6LRu3WeTDG7Gkylt-pxE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 981EB2220071; Wed,  2 Oct 2024 11:32:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 15:31:59 +0000
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
Message-Id: <fc5cee69-e37a-4053-a425-f9191e58011a@app.fastmail.com>
In-Reply-To: 
 <CAH5fLgjjcwTZzN5+6yfku2J6SG1A8pNUKOkk1_JuyAcfNXa2BQ@mail.gmail.com>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <CAH5fLghmkkYWF8zNFci-B-BvG8LbFCDEZkZWgr54HvLos5nrqw@mail.gmail.com>
 <50b1c868-3cab-4310-ba4f-2a0a24debaa9@app.fastmail.com>
 <CAH5fLghypb6UHbwkPLjZCrFM39WPsO6BCOnfoV+sU01qkZfjAQ@mail.gmail.com>
 <46c9172e-131a-4ba4-8945-aa53789b6bd6@app.fastmail.com>
 <CAH5fLgjjcwTZzN5+6yfku2J6SG1A8pNUKOkk1_JuyAcfNXa2BQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024, at 14:23, Alice Ryhl wrote:
> On Wed, Oct 2, 2024 at 3:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>>
>> On Wed, Oct 2, 2024, at 13:31, Alice Ryhl wrote:
>> > On Wed, Oct 2, 2024 at 3:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de=
> wrote:
>> >>
>> You can also see the effects of the compat handlers there,
>> e.g. VIDIOC_QUERYBUF has three possible sizes associated
>> with it, depending on sizeof(long) and sizeof(time_t).
>>
>> There is a small optimization for buffers up to 128 bytes
>> to avoid the dynamic allocation, and this is likely a good
>> idea elsewhere as well.
>
> Oh, my. That seems like a rather sophisticated ioctl handler.
>
> Do we want all new ioctl handlers to work along those lines?

It was intentionally an example to demonstrate the worst
case one might hit, and I would hope that most drivers end
up not having to worry about them.=20

To clarify: the file I mentioned is itself a piece of
infrastructure that is used to make the actual drivers
simpler, in this case by having drivers just fill out
a 'struct v4l2_ioctl_ops' with the command specific callbacks.

This works because video_ioctl2() has a clearly defined set
of commands that is shared by a large number of drivers.
For a generic bit of infrastructure, we obviously wouldn't
do anything that knows about specific commands, but the way
the get_user/put_user part works based on the size can be
quite similar.

There is similar piece of infrastructure in
drivers/gpu/drm/drm_ioctl.c, which is a bit simpler.

>> It seems like it should be possible to validate the size of
>> the argument against _IOC_SIZE(cmd) at compile time, but this
>> is not currently done, right?
>
> No, right now that validation happens at runtime. The ioctl handler
> tries to use the UserSliceReader to read a struct, which fails if the
> struct is too large.

Ok.

> I wonder if we could go for something more comprehensive than the
> super simple thing I just put together. I'm sure we can validate more
> things at compile time.



     Arnd

