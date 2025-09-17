Return-Path: <linux-fsdevel+bounces-61882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DCB7CF26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2761C060A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 07:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1622BFC8F;
	Wed, 17 Sep 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="iRrddFte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQZJAwzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED739246BB3;
	Wed, 17 Sep 2025 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093960; cv=none; b=SK75w5tUHDHSAV+bbCudFVRLliGKOUpgYYjDQQQ5xJ8PELRz6nvidMn1dH+RrhX1iiB+DXXNBhE+HfvYJRY463O9msguYsqSM0SnVqrBvbVtdtHAqoXpCsminTn6KfmGmjjWtt/rJ5hmrkWAZ32RxxMQHexnbIyyW2GgC5TM+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093960; c=relaxed/simple;
	bh=iZGF3EBuz/5+IMp82uUAii/ILmQ/A1qF5H2JhUEIUss=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uEu3cBCqJIzZCY+Hox5V9Cv4r4sB4r+110EKnXuqLFji4AIsHlk++ArVt3ZYujVTAhOHc9jQxul8GVqJcepBdLodK0sCcP5fXDwdtRmPI575K/GoxfT9ePxzSPMn7M37pC/2r4ugSdXg/5/Uqq0qPlVPJGjMfA7zJ2L0UQEoj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=iRrddFte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQZJAwzl; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DF10140018D;
	Wed, 17 Sep 2025 03:25:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 17 Sep 2025 03:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758093957; x=1758180357; bh=B7h5B0h/sRlMrJZYPZ6tm6frc38WjqVKzPp
	Fh4FPOoU=; b=iRrddFteDYVa3svDudxKo+wxHstme1PBvqxNNepUV1O9zlRHA5R
	qcZKQe6wDe1IJMcH/ba8W2ejv5eZ67P8/s8689fTMk3/9wobOmSc3Hl+LnyweBnW
	Es66SQYcyXILFTcvWTQKmqkQgYOeklCe6jbuVJCVdkbP2CIQL2ZfO+4xpbJL9nE0
	+89+H/pGLpLHFh1FBlSWXaFx/1ogzipSqXgWDrjUgaNBMZfmIuDJ7ZtnqwElsaUP
	aX0N0L3+gnKUVyb1Lre7y2J2R1j//LCZx7ggq0wVb8Zw461ElsyZ4VTfF8Z+boRm
	X5D6qNqQ945yhKzDt6a21XdHCcE4LP+2ShQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758093957; x=
	1758180357; bh=B7h5B0h/sRlMrJZYPZ6tm6frc38WjqVKzPpFh4FPOoU=; b=S
	QZJAwzlB/N3P4B91AV4QPf/aLcyOn2fcT8ih7bBQJ2RcRvdLnKmua35TyzFiHHJX
	+aMrSjiJX1IGv5QH2fN0z5crzQDjQNhNutrfZ4oheUqryYSWsizP9I4biGFznX0c
	C9fPOnquxiRWZOic/MCLB1kFFXy3Sp6uup1qG/tmbuamGpepCNFr6EnCEXO9TRBO
	5SOpyC2uSojHQa1h/RDTRlvvw11+yX5dHJoTd5BLUYtV6H48Mm+6jdbgaZgVnEiu
	jiJ2rVblwrCM/JH2eDJS+Dk6K4jJ2GWmfCtQpzFxxDLPbG5ssBrwdMDmXdQSCVlc
	FKg1wTr/na10vaNos5jLA==
X-ME-Sender: <xms:hGLKaIUqg0K0jCVDRPOyfkrHrFxekl_f8eUI7Jai8M9eNf3GsoWdBg>
    <xme:hGLKaITRTiYAa5rxhFh4fFmVZLAmpDbK39w8wqFKZM_8zgTmwPp5mPcnUQDZZ7RKz
    HlFYxJtD67vzQ>
X-ME-Received: <xmr:hGLKaI3O8O2l74WVvg6M2mFlQHyS7ESAzJO5v0YfqJjDIsQxk9AVCalx52PwhE3p3ANPKdSyv60TE6dp-pCmvCvjsCakAnIeVi0UaZI97KDz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegvdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhrohhnughmhieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghn
    nhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:hGLKaAd4NLXE2kIMRKiJv8ZNkIXa3sl-flaBiQb8-TtpIyI_p9p_rw>
    <xmx:hGLKaIPco9w6SyUGZkqIfo8vNAZM0We4TTW95Uu2vq828axS0zxjGA>
    <xmx:hGLKaMX-ZqCT7kiBtv8swfWvNyo7kpyCaRqO_KjnK6dEyBhp4tO_oQ>
    <xmx:hGLKaIyIzUrzE27ot-dUzCiW0IO6vrzxE1eP-o2pmOrlinxQlZkWeg>
    <xmx:hWLKaBHxxufwihFTf0woVkYtHb2O951S4Vv2MJd4sfHrue2qPGA2oC3k>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 03:25:53 -0400 (EDT)
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
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>
Subject:
 Re: VFS: change ->atomic_open() calling to always have exclusive access
In-reply-to: <20250917043458.GT39973@ZenIV>
References:
 <20250915031134.2671907-1-neilb@ownmail.net>, <20250917043458.GT39973@ZenIV>
Date: Wed, 17 Sep 2025 17:25:50 +1000
Message-id: <175809395023.1696783.11694150794163442878@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 17 Sep 2025, Al Viro wrote:
> On Mon, Sep 15, 2025 at 01:01:06PM +1000, NeilBrown wrote:
> > ->atomic_open() is called with only a shared lock on the directory when
> > O_CREAT wasn't requested.  If the dentry is negative it is still called
> > because the filesystem might want to revalidate-and-open in an atomic
> > operations.  NFS does this to fullfil close-to-open consistency
> > requirements.
> >=20
> > NFS has complex code to drop the dentry and reallocate with
> > d_alloc_parallel() in this case to ensure that only one lookup/open
> > happens at a time.  It would be simpler to have NFS return zero from
> > ->d_revalidate in this case so that d_alloc_parallel() will be calling
> > in lookup_open() and NFS wan't need to worry about concurrency.
> >=20
> > So this series makes that change to NFS to simplify atomic_open and remove
> > the d_drop() and d_alloc_parallel(), and then changes lookup_open() so th=
at
> > atomic_open() can never be called without exclusive access to the dentry.
>=20
> What will happen if you have a stale negative dentry of /mnt/foo/bar, with
> /mnt/foo not writable to you (e.g. because /mnt is read-only mount) and
> foo/bar having actually been created by another client since your old lookup
> had happened?  What's more, assume that this file is owned by you and has 0=
660
> for mode.
>=20
> Calling open("/mnt/foo/bar", O_CREAT|O_RDWR, 0666) should succeed - the file
> in question exists, so O_CREAT and the third argument of open(2) should be
> ignored.
>=20
> What happens is that we get ->d_revalidate() still with effects of O_CREAT
> (i.e. LOOKUP_CREATE|LOOKUP_OPEN), but ->atomic_open() does *not* get O_CREA=
T.
>=20
> Your series is broken in that case, AFAICS.
>=20

True, thanks, but not fatally so I think.

Even though O_CREAT was cleared, we still have an exclusive lock on the
directory so there is no need to d_drop() and reallocate the dentry
in nfs_atomic_open().

The change I need to make is to remove

+	if (!(open_flags & O_CREAT) && !d_in_lookup(dentry))
+		return finish_no_open(file, dentry);

so that we still go ahead with the NFS OPEN request in any case.

Thanks,
NeilBrown


