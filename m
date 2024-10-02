Return-Path: <linux-fsdevel+bounces-30699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2B98D896
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68783B21BEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E271D1E62;
	Wed,  2 Oct 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jo+bqhcb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiwQpxk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE801D04A2;
	Wed,  2 Oct 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877570; cv=none; b=fcq45gP1gMk/1L43gdPG+RNAEAm40AF4lPCbCwSAMPHq33fR7ncw9Q+gCL8I7pBEHnS7w1yj3222GbJ5Tzc+Z4TtsAgkjHreNMFc8x/djauGUrISUXuCNGxQOLCJ570Mq8It7hLHJlCvKekeN5jNR06Jngc0Xa0ElPIbeoA4ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877570; c=relaxed/simple;
	bh=7JBxmJLQCcnHsrXGvgyv1lB/G1tEHsDaieHepCFljtE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MdTOJAZDRumAaONmZTMt4fNK8ft7Jl8Yh3WDXg+f7qVWJ0uToqSsQefVMC/P222tey9ZMyviS9zA8ujtd5BvtsQCztaYG31eR4z5/trAkUHXzYBNryOH/hvO/QSFY1/SzMS5z/ROWshS+54Nbz0rhlOIrwsE9u+Wq9lflCKaIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jo+bqhcb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GiwQpxk/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A1A31380235;
	Wed,  2 Oct 2024 09:59:27 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 09:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727877567;
	 x=1727963967; bh=ARQTSf00pYU1hk56fjFxaNV0rUTfMCXxlzmZF30o7Fg=; b=
	jo+bqhcbfghiuvMq5/zHTmv57L0KrYF4Hz9Oa3ujIT/ZX56+jHcRQQHMVua3TkoV
	cjHL/PDLj7adQLT4tRiqWNwYwMzIQ7mw3dT7iq1R4oQkhx+XmoI8LNqMyDDa2HcP
	nNPof+FO8MQjWz9q5ZlOoyUYRRLGLBfK7sMvfHW9wYq2Yqtjz62QpTGay8Zs7XLG
	qW/NWEeMzY5e7VE4WMHw+M1vq+kbLjy1HpTJUH2FyrCSu2GEOS2Vj0V0gkuLbZT4
	8/J+BoIvltnfHrkSok9/9uCRMKNWsImHH1hSmY5H45byvuEEKsu+/mbuOdeDqpJ9
	Na7vLbu/K8bHTvhun420tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727877567; x=
	1727963967; bh=ARQTSf00pYU1hk56fjFxaNV0rUTfMCXxlzmZF30o7Fg=; b=G
	iwQpxk/YY1zxnc9wvxDMjU6Zk/z8snjWRPNqOCWfkAo3oddMuCfhAmntG6g5xmkV
	dbf55WTB279zHUiMmOz+Sqlb73MYHgz2kqtrfSDok8w7anN2XvsCKc055k3g4cdG
	tR1QZ+lRcuKnz6PiKcjAKyocKYFN5x9hsb8j8Jephxhehk65LbsIb35uWxGWNMMm
	vGO5/CZg8/V9Rzf6PXXTEmwz84PpMC9oZa1HnaLEFoO6slgcdGoia8wQFonqh2n+
	+rdrOk2TiWPqq3zZn2ssvaExj2QguV2+wKbmNDL0SaMP5NTT9CVB0jf95gBcP+To
	DoDvjqPiW/NUDkW8di2Mg==
X-ME-Sender: <xms:v1H9ZqT8O0H1BqtJ5Pg6lDH8s_DaM-Gh_s3CULwELlnhzcSmYXME2A>
    <xme:v1H9ZvwFrBLQJ65TVAyeCeyGdrrhaOzwWhSOCCe7b_-DTco0Jd-PNCbKwtcx7Ubdp
    2h6QqFD3StTBEsWDW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgieejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:v1H9Zn1MT4SoNRvptTHJWYwr-i3KHn9CUyoC4L-MrPYb1_1Y4x80Sg>
    <xmx:v1H9ZmBLm8I3TSnxivYgF0UenfmoA7DPMe-kfJbuufjUMcebFdtwFw>
    <xmx:v1H9Zjgcm1prwUJqTE97zCbIcGwveY2BSritm09vjlN7g600g2c_Cw>
    <xmx:v1H9Zirw6wMsHpEicoGObGOv5hrXQeUCQO0qclK5-a0cvKLzWDZR1Q>
    <xmx:v1H9Zj5SNIJ_s46xc-enXxT3RrVnr4fRQmIP7E_ddsgzPbSSZxkaJq5P>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 064C82220071; Wed,  2 Oct 2024 09:59:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 13:57:47 +0000
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
Message-Id: <46c9172e-131a-4ba4-8945-aa53789b6bd6@app.fastmail.com>
In-Reply-To: 
 <CAH5fLghypb6UHbwkPLjZCrFM39WPsO6BCOnfoV+sU01qkZfjAQ@mail.gmail.com>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
 <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
 <CAH5fLghmkkYWF8zNFci-B-BvG8LbFCDEZkZWgr54HvLos5nrqw@mail.gmail.com>
 <50b1c868-3cab-4310-ba4f-2a0a24debaa9@app.fastmail.com>
 <CAH5fLghypb6UHbwkPLjZCrFM39WPsO6BCOnfoV+sU01qkZfjAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024, at 13:31, Alice Ryhl wrote:
> On Wed, Oct 2, 2024 at 3:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>>
>> On Wed, Oct 2, 2024, at 12:58, Alice Ryhl wrote:
>> > On Wed, Oct 2, 2024 at 2:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de=
> wrote:
>> > A quick sketch.
>> >
>> > One option is to do something along these lines:
>>
>> This does seem promising, at least if I read your sketch
>> correctly. I'd probably need a more concrete example to
>> understand better how this would be used in a driver.
>
> Could you point me at a driver that uses all of the features we want
> to support? Then I can try to sketch it.

drivers/media/v4l2-core/v4l2-ioctl.c probably has all of the
things we want here, plus more. This is a big ugly for having
to pass a function pointer into the video_usercopy() function
and then have both functions know about particular commands.

You can also see the effects of the compat handlers there,
e.g. VIDIOC_QUERYBUF has three possible sizes associated
with it, depending on sizeof(long) and sizeof(time_t).

There is a small optimization for buffers up to 128 bytes
to avoid the dynamic allocation, and this is likely a good
idea elsewhere as well.

>> > struct IoctlParams {
>> >     pub cmd: u32,
>> >     pub arg: usize,
>> > }
>> >
>> > impl IoctlParams {
>> >     fn user_slice(&self) -> IoctlUser {
>> >         let userslice =3D UserSlice::new(self.arg, _IOC_SIZE(self.c=
md));
>> >         match _IOC_DIR(self.cmd) {
>> >             _IOC_READ =3D> IoctlParams::Read(userslice.reader()),
>> >             _IOC_WRITE =3D> IoctlParams::Write(userslice.writer()),
>> >             _IOC_READ|_IOC_WRITE =3D> IoctlParams::WriteRead(usersl=
ice),
>> >             _ =3D> unreachable!(),
>>
>> Does the unreachable() here mean that something bad happens
>> if userspace passes something other than one of the three,
>> or are the 'cmd' values here in-kernel constants that are
>> always valid?
>
> The unreachable!() macro is equivalent to a call to BUG() .. we
> probably need to handle the fourth case too so that userspace can't
> trigger it ... but _IOC_DIR only has 4 possible return values.

As a small complication, _IOC_DIR is architecture specific,
and sometimes uses three bits that lead to four additional values
that are all invalid but could be passed by userspace.

>>
>> This is where I fail to see how that would fit in. If there
>> is a match statement in a driver, I would assume that it would
>> always match on the entire cmd code, but never have a command
>> that could with more than one _IOC_DIR type.
>
> Here's what Rust Binder does today:
>
> /// The ioctl handler.
> impl Process {
>     /// Ioctls that are write-only from the perspective of userspace.
>     ///
>     /// The kernel will only read from the pointer that userspace
> provided to us.
>     fn ioctl_write_only(
>         this: ArcBorrow<'_, Process>,
>         _file: &File,
>         cmd: u32,
>         reader: &mut UserSliceReader,
>     ) -> Result {
>         let thread =3D this.get_current_thread()?;
>         match cmd {
>             bindings::BINDER_SET_MAX_THREADS =3D>
> this.set_max_threads(reader.read()?),
>             bindings::BINDER_THREAD_EXIT =3D> this.remove_thread(threa=
d),
>             bindings::BINDER_SET_CONTEXT_MGR =3D>
> this.set_as_manager(None, &thread)?,
>             bindings::BINDER_SET_CONTEXT_MGR_EXT =3D> {
>                 this.set_as_manager(Some(reader.read()?), &thread)?
>             }
>             bindings::BINDER_ENABLE_ONEWAY_SPAM_DETECTION =3D> {
>                 this.set_oneway_spam_detection_enabled(reader.read()?)
>             }
>             bindings::BINDER_FREEZE =3D> ioctl_freeze(reader)?,
>             _ =3D> return Err(EINVAL),
>         }
>         Ok(())
>     }

I see. So the 'match cmd' bit is what we want to have
for certain, this is a sensible way to structure things.

Having the split into none/read/write/readwrite functions
feels odd to me, and this means we can't group a pair of
get/set commands together in one place, but I can also see
how this makes sense from the perspective of writing the
output buffer back to userspace.

It seems like it should be possible to validate the size of
the argument against _IOC_SIZE(cmd) at compile time, but this
is not currently done, right?

     Arnd

