Return-Path: <linux-fsdevel+bounces-62266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03287B8B93F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 00:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450283AB812
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 22:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55772D249F;
	Fri, 19 Sep 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="r/fTBYcb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GgQMSawD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B931D54D8
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 22:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322196; cv=none; b=qRu9jvGekew+lCUzdpgK4AlmqgAU5lgsoekvmyDcuiLT1O6JD6pBcCZgw0qcBBATOtcoJf5QxTajWpc/VBoxnX2OJGx0Utek1yL5v33sRpkkWbGAotYDGiTudQmorj1yft7JQ4hP8N3uacQRIPczRU/UoQQnkU6yJu+AbnCffZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322196; c=relaxed/simple;
	bh=8X6IH1VfYVJ2etsEAFcJPp7dSkxGrIkTlcCFyASJBMU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gO6dGS7vD88+TZ1z5h2jW86MF0s/z/Jm4t5h+DsH6M0OWr6mEY6CcEsxQpWuNPeYUsq5SGTH+hmJAyOyzdxdYoj9n4kJuvt0d3TYcjUUqCrXxNjiSNlmXI0AqLxfTwhzHLwo0c4gieYbLtkX43pka9rzHGofX1g7EhrsNbSdjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=r/fTBYcb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GgQMSawD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50241140009E;
	Fri, 19 Sep 2025 18:49:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 18:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758322192; x=1758408592; bh=ulr4ow53JhBa4iPS0mEANq6kIbDvgIl9tql
	/4+Z9sXI=; b=r/fTBYcbhM1z9Q17YD4FHVPx6De/BDmqzKEb6h9v03KmTtpOIt7
	43wL2NzrrVjGep/ydu+GEH4eqQeKsGJlbuBOYGyUCkdluxchsndlaYZXiid51YIq
	f+HSTxpf/k81nKBX+JckzLDnYJAueQx6qZmYtcIGY3cX5wi/B79+bspqG2+VmV1F
	qvolVdhH+2CgupOfNLexL0FKtGJkFlPhkK1QFqbJ/eZdsSv4rf5n/QYb9ycCjgFa
	Ofv0YY57ekc2jIN8vZfbARtopL6o/f4Fm3kZ6C0wHw8VuhZJZ8WgZJNyxcPD5ujQ
	xVkBl8EIRb/yDUGRuiOeB6SILKA09awkKyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758322192; x=
	1758408592; bh=ulr4ow53JhBa4iPS0mEANq6kIbDvgIl9tql/4+Z9sXI=; b=G
	gQMSawD7rYZ9GTy65lw0y9R6knRXh6fCjShi8jZkVbMzpyagryqnyY5Jh5DkAG3s
	SyEJqReyQtzGXrwuzQAqDVY6HvamADErMAbV7XBesi4SQIZQ0M2wNktCOsxfni9p
	FNhSyU+IaItNX4FWTuRPyyQ8vmbQhRRSNLOTMsirCvKS6kyA7z6q19pVqugvmtBW
	Q85cjgjD284owy9yOY36Luh+p4In+tOywljOYEruM5U+MbS8PZy1fmLjIU7ID7iy
	9g4SHo6jcVZy0lDnoEkgMA1QzhvEc3J3utTe6ytzt6hBjPfKy5/v4+R4XznwzeCV
	d+MyLerUHkVPD6NjMy3KQ==
X-ME-Sender: <xms:D97NaLojYpKo6uUsAQSvGWTlbdmsh1IyHT_ODUvVWn3aXG9lDa8sjg>
    <xme:D97NaNDIYsnEYKwe6uIRqFqikrFhBub98ndK9F9lm3OOS1PQyIbTAq3cjVn26BhYN
    qCNKyhlJDIh7g>
X-ME-Received: <xmr:D97NaNxkCP4q6kA7z6PA6PfSM6i61uMh9oIEe2pAg59RkXfEV_iIOQ1Wj0jvGdajZPWNfjhWYfeLvHVNuVK_OAK-uxfJ9pJBjdbHC4n4yHIr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:D97NaK11RGJFCcwH5Cl2HNkvlG53-sA2rX_VhndJDz9RLKGIESafyw>
    <xmx:D97NaNz2Cmkm9eXYq4F0MzkIVp_437uz_xxkSJpPuSJq33vKmvcYYQ>
    <xmx:D97NaBGY-TVkz9OfXF6mA2ZRQnclBb_Wao6eM81-6XjYJzEJQyIPPA>
    <xmx:D97NaAZl3nnftrvDR6ObLCAcFzwyN4gFIjZxQrW3WglRwE70ITpZDw>
    <xmx:EN7NaGBz-UJzDznkYE1JB8bWnfhrezHO8frrycePCTRD0VjGpRyE91kD>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 18:49:49 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] debugfs: rename start_creating() to
 debugfs_start_creating()
In-reply-to: <20250919050643.GI39973@ZenIV>
References: <20250915021504.2632889-1-neilb@ownmail.net>,
 <20250915021504.2632889-7-neilb@ownmail.net>, <20250919050643.GI39973@ZenIV>
Date: Sat, 20 Sep 2025 08:49:42 +1000
Message-id: <175832218210.1696783.2506353828893239653@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 19 Sep 2025, Al Viro wrote:
> On Mon, Sep 15, 2025 at 12:13:46PM +1000, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > start_creating() is a generic name which I would like to use for a
> > function similar to simple_start_creating(), only not quite so simple.
> >=20
> > debugfs is using this name which, though static, will cause complaints
> > if then name is given a different signature in a header file.
> >=20
> > So rename it to debugfs_start_creating().
>=20
> FWIW, there's one thing that might conflict with.  Take a look at this
> in 3 of 4 callers of that thing:
>=20
>         dentry =3D start_creating(name, parent);
> =20
>         if (IS_ERR(dentry))
>                 return dentry;
> =20
>         if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
>                 failed_creating(dentry);
>                 return ERR_PTR(-EPERM);
>         }
>=20
> Now, note that the very first thing start_creating() does is
>=20
>         if (!(debugfs_allow & DEBUGFS_ALLOW_API)) =20
>                 return ERR_PTR(-EPERM);
>=20
> and that debugfs_allow is assign-once variable - it's set only debugfs_kern=
el(),
> called only via
> early_param("debugfs", debugfs_kernel);
>=20
> So that's dead code and had always been such.  All those checks had been ad=
ded
> at the same point - in a24c6f7bc923 "debugfs: Add access restriction option=
",
> so at a guess the dead ones are rudiments from an earlier version of that p=
atch
> that hadn't been taken out by an accident - they should've been taken out a=
nd
> shot on review, really.
>=20
> They obviously need to go and that'll be textually close enough to the call=
s of
> start_creating() to cause conflicts.
>=20

I think your concerns are misplaced.
I just created two branches, one which renamed start_creating and one
which removed the redundant DEBUGFS_ALLOW_API checks, and then asked git
to merge them.
It said:

Auto-merging fs/debugfs/inode.c
Merge made by the 'ort' strategy.
 fs/debugfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

It had no difficulty at all.

NeilBrown

