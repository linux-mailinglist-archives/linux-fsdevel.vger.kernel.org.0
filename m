Return-Path: <linux-fsdevel+bounces-62929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F877BA5E46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 13:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4DE1888D9F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Sep 2025 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024B2D6E6E;
	Sat, 27 Sep 2025 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Fw4ZTCpj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKWw9jBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684E2D6E6A
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Sep 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758972020; cv=none; b=kqo7hkGsw7CI2lwmZTH3erd2mjsXMB10T8OjdPwMAdYYfkcjD9ho8g7Dn4tAqDhKHWTNQHa4FdfRDBfm2NbPFP0HZcW5YAav6wcs2EWRvGjO1ysazGda03BWupWCW/2dB8xPiD7Zd6ta60US//Y4QR49KHODVHNI6f54j36O/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758972020; c=relaxed/simple;
	bh=KaJKX4nzOTaz8X0mYwCKtULY0yl5tuIrT6HBiWZiyTM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=saqXNJEyPcqjcG3IAe/OD5Ub41s/C7aMBl9woC8Bi5Jcb9rQmRXuCA+IV7b75MsGrY2jJYw+qHdNX3V9naWIhotv8nO4f/6TBpttnI52zgE2L43mamiSNr/vVslryRgo//K6Ple2BNCQxK7kFAgBLImQ6OB1foveEghXHn8Ayyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Fw4ZTCpj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GKWw9jBf; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D7BF1D00064;
	Sat, 27 Sep 2025 07:20:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 27 Sep 2025 07:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1758972017; x=1759058417; bh=ZuUt771X/MZDHb+sFyxD4xXxus/zIZfEq03
	AjStanhc=; b=Fw4ZTCpj6qdXMxw45aL+pyVn2/ZfRB6B60PWEp4L3N92ABYjnD2
	vWH9IXbTMp/SK0zHPqQDRA+SKAnwCbhIyKG+n1IVmXaTnk1myriWwvaDkLr/3huo
	hDfa70Oc7BiSbm97ETPxvM7N81g6Hmjypw6a6pYex+QGwGxuRTAurRpoyKHteCvb
	BF9Sj9XV/BrXTYxkR9nKnudlxvOrCziLozB7+Xq7n/aPuXh0XC0r0/86K0w2Ie/m
	RbZFQHA4XLM8MUtcsRahmh6sAQWFVkGxmee7uiceJoXv5zCrx3BFeEjFqsAxzxCL
	qCcmaBQfN8+yvB9ux4E2kkkO6r1npdQpMSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758972017; x=
	1759058417; bh=ZuUt771X/MZDHb+sFyxD4xXxus/zIZfEq03AjStanhc=; b=G
	KWw9jBftmi/j/YCaNwKgjd/q8Mh6y28hIvEtQT4zOOuAY72v5AD0BRp8P6qOiTR0
	/KVzbv+058T+CUSD2xi934HC1/k2UxSgSyJhC1bKPwp/6cyf/s0ld3yJArazkIC7
	JPPDD9oOHGEpYgajmjrjW8j87KUAF4aeGlHjqdli7hFdxzlgZs4FFef9HcrQhxaS
	ewMvqPcSEKdPzFThfciiDwvLu6g25uJILvpyg9t8tO6fBx5w1bmDBQyjs6fxTw2W
	5GvkvPab4Prw4aq/i5nYB6mNDXFrQuLUh2Z/L06AvPy06HtdttPSiOdxi7yZvTRb
	H6cyMLNopv+7rchcVfvQw==
X-ME-Sender: <xms:cMjXaLF6Q0IolsTw1RDgBpQca0NajxxlUQTZ1ihWBQowvJWDaAMqOw>
    <xme:cMjXaDRiUv_BtrfNXTRXOdC-xI2F2uL_fOnrvEnMtQONfNXq12qin5c_Z7yeE6ewG
    -pNJ3i2_2NcY516MxDcp7v6pHT-ioxbpXR_AyIEbsIA4zivHA>
X-ME-Received: <xmr:cMjXaML-Rmgc0cNYb1uZM0e1e4AiFweTywLmdgqTAITsq6CLV1PZcuzPf0-UKSmZFUlWgzSrN4V27SatEmTpCRX5jqCvnDaaILnF_2w6nJf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dutdfgudffhfffueeuleduffdvjeefueefgefgtedttddtiefgteejgeevffeggeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivg
    hnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvg
    drtgiipdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cMjXaObIwkQPPRpFL47nw_Sh_6KyN0qzd9EALeFvY77QUKyijqoFfg>
    <xmx:cMjXaO8Jutpqdj0C3uD5WOysEcHyXX1-u4ymINeCbi4WYD2PmtzqyQ>
    <xmx:cMjXaPZiJj_wdmzm6CyuLayst8E5CUXWCVtVA_2mRb2LExRxkSUZzQ>
    <xmx:cMjXaCP7vTZYhgEYlBHyOgMuTnFhbRN7hK4g2L6tTUnWZUsgzSAZ-w>
    <xmx:ccjXaI96bZBTFr88WdXI0CJFygSys38zHIr_7gjWkqMKkTjA1inD_1zu>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 07:20:14 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/11] Create APIs to centralise locking for directory ops
In-reply-to:
 <CAOQ4uxhr+pFGa+SW-pJgeNpK5BYPxr6VVvq5LLQV4M59UBrVbw@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <CAOQ4uxhr+pFGa+SW-pJgeNpK5BYPxr6VVvq5LLQV4M59UBrVbw@mail.gmail.com>
Date: Sat, 27 Sep 2025 21:20:10 +1000
Message-id: <175897201039.1696783.9339851944147869858@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:50=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > This is the next batch in my ongoing work to change directory op locking.
> >
> > The series creates a number of interfaces that combine locking and lookup=
, or
> > sometimes do the locking without lookup.
> > After this series there are still a few places where non-VFS code knows
> > about the locking rules.  Places that call simple_start_creating()
> > still have explicit unlock on the parent (I think).  Al is doing work
> > on those places so I'll wait until he is finished.
> > Also there explicit locking one place in nfsd which is changed by an
> > in-flight patch.  That lands it can be updated to use these interfaces.
> >
> > The first patch here should have been part of the last patch of the
> > previous series - sorry for leaving it out.  It should probably be
> > squashed into that patch.
> >
> > I've combined the new interface with changes is various places to use
> > the new interfaces.  I think it is easier to reveiew the design that way.
> > If necessary I can split these out to have separate patches for each place
> > that new APIs are used if the general design is accepted.
> >
> > NeilBrown
> >
> >  [PATCH 01/11] debugfs: rename end_creating() to
> >  [PATCH 02/11] VFS: introduce start_dirop() and end_dirop()
> >  [PATCH 03/11] VFS/nfsd/cachefiles/ovl: add start_creating() and
> >  [PATCH 04/11] VFS/nfsd/cachefiles/ovl: introduce start_removing() and
> >  [PATCH 05/11] VFS: introduce start_creating_noperm() and
> >  [PATCH 06/11] VFS: introduce start_removing_dentry()
> >  [PATCH 07/11] VFS: add start_creating_killable() and
> >  [PATCH 08/11] VFS/nfsd/ovl: introduce start_renaming() and
> >  [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
> >  [PATCH 10/11] Add start_renaming_two_dentrys()
> >  [PATCH 11/11] ecryptfs: use new start_creaing/start_removing APIs
>=20
> Overall looks like nice abstractions.
> Will try to look closer in next few days.

Thanks.

>=20
> Can you please share a branch for testing.

https://github.com/neilbrown/linux branch pdirops

I may update that as I process other review.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


