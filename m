Return-Path: <linux-fsdevel+bounces-69924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF6DC8BF67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB54F3A4729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45D340DB0;
	Wed, 26 Nov 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZdTlAq2Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZynZqTH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704F22AE7A;
	Wed, 26 Nov 2025 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764190781; cv=none; b=HW3xAucFajMYWesOUnX2PQ4uhzLaU/gxr+V49ZN0yACsTOyKewkxi/5k1nzwM7JnnD/CvD06dmnQXcXKo/r2sRR4BU60rkK36jgF/KVbDyRbllA+ZoXiv9h84zOrV5YZwQ7VSFTvyNXdwlsx0RQhX0zt0Cbq/RqlqN63w7vkka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764190781; c=relaxed/simple;
	bh=mDivYV8H2fKoVDRBsPbKcSOCUT+x3TVzfO4rk4UTTCY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CZSctWAhZGFSAHLO28csywZ16KdZUM6cTEk6H/EnAqQNHDTWYDKiXhiMJo8A3Yn9krUuYimDHL8Fub6Sc/bCcuws7CDs6ERnZu1qIFAcregTkfuaAFsq5885qAG+fJ/vt7PtmmkuK4L2jQXZKJA+KzDY946Bzh2pF/MiKMxbSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZdTlAq2Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZynZqTH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6EAA07A016B;
	Wed, 26 Nov 2025 15:59:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 26 Nov 2025 15:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1764190778; x=1764277178; bh=UwGoRZDEj2HkNb3Upl8B+DAm4uvFedCAdR8
	K/+ROm9k=; b=ZdTlAq2Z6anI8UNtScC0ANlhl0/0t93CBn3Siyk5Ac4Of3HMrQx
	wD02s/SaqBp4+m7yomyX3bkGqRvh3d26vpzVJ6NcN640NlWx3edgIOyTF3jIUPw6
	oSJ0DDKsu03AwL/ZuQ1Lt6nu9tiF5DjJNUkr5vXMsHonQ/ymEle5BX6Qp5fV+u/a
	d/DLlpwzT2MNKdZH6LbPCr3sUcw9koZ+9c32uO3Eu6TbqgVXTfQIQiKLP/BXsT3p
	8qKeaSv+dgsOVRNTzteKoKXAfIb8YT+fJVavLDRy7tsL+ROTCaFIRiZrk1kCGDYq
	pc6Ior1e5DShEieuvHjAydi15XtQAyHjxNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764190778; x=
	1764277178; bh=UwGoRZDEj2HkNb3Upl8B+DAm4uvFedCAdR8K/+ROm9k=; b=h
	ZynZqTHM7DyVQp67OY4oc9scGQC3e4dOX3yp1QlUN5Z1teFIwVcGznsk8mJAHDNl
	LvHJesP6DBuSjpj0gVLusfn5Fsi637tdd4dNYJ1gLtcii5CggZu3aLwgY1yvt5Pe
	4VY5mKt/iPMUUDADyrbnGIIkDdcWXgaxho1VSKA6fijpaWGb72/susxcn1/233/8
	ciC5cwMNOU/wlVgDnZEnEaKCbboZmFmf9yv4F0+ljStahYo5Ny3KCJFRSm0DB9R3
	lw8inrOKG+CeiVooqGxD2rH2WQ+sB18LZc5ie48AWT5plaLvKdPv2M+U6Q9JlQck
	ya152/0YX6oFpw287g1Fw==
X-ME-Sender: <xms:OWonaawLyy8z6nAhmVnSBierYIYtunjAJ7q2oSaWREvHCVpenGNrXw>
    <xme:OWonaQqVtTcDYw6f64jMIK7s6lq8N3nPE-lRZ7QFpry3t5NzWIz7yoiDRAecBkrqA
    13sFgkkRMGXQZ1SlbTd7NLOGTZ6iCRT-wU4seP63KAYQwy3Yq0>
X-ME-Received: <xmr:OWonaScRNprZecAe5pIthoTlycbO5EDEAZg2KR03kDLrPxmcWOdo9JEgdlOj9CmeNJ03Lw-RoOGIkcxgV6mdeS0XIrm1fgVdN-RGvRwlyQ57>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepjhgrtghkse
    hsuhhsvgdrtgiipdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtth
    hopegurghirdhnghhosehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:OWonabp7yflLx3HJbj_dietehsBxdHJFjm9T0OdX1P6Mus1QdHlhfA>
    <xmx:OWonaUnPlU8GNKTivwmxyttk5Ks0TH73iByvovkAH0hxIonsfk4rvA>
    <xmx:OWonaURL-xMFjhcsyQD2gj-NTP17qDlkBI0_vFJIP1yDd9Z7mNo8mg>
    <xmx:OWonaSaUMQNq6iLmJMEcuMxojB4BqQV_5BFqLRrfkoRynkS1sIet-A>
    <xmx:OmonaacCpCa2PYvwD8boxEbKRA2QqtjStxqtM0ixhRxUx3NSA5S0QuPw>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 15:59:33 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 "Trond Myklebust" <trondmy@kernel.org>, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v1 0/3] Allow knfsd to use atomic_open()
In-reply-to: <034A5D25-AAD3-4633-B90A-317762CED5D2@hammerspace.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>,
 <176351538077.634289.8846523947369398554@noble.neil.brown.name>,
 <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>,
 <176367758664.634289.10094974539440300671@noble.neil.brown.name>,
 <034A5D25-AAD3-4633-B90A-317762CED5D2@hammerspace.com>
Date: Thu, 27 Nov 2025 07:59:32 +1100
Message-id: <176419077220.634289.8903814965587480932@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 21 Nov 2025, Benjamin Coddington wrote:
> On 20 Nov 2025, at 17:26, NeilBrown wrote:
>=20
> > On Wed, 19 Nov 2025, Benjamin Coddington wrote:
> >
> >> Ah, it's true.  I did not validate knfsd's behaviors, only its interface=
 with
> >> VFS.  IIUC knfsd gets around needing to pass O_EXCL by holding the direc=
tory
> >> inode lock over the create, and since it doesn't need to do lookup becau=
se
> >> it already has a filehandle, I think O_EXCL is moot.
> >
> > Holding the directory lock is sufficient for providing O_EXCL for local
> > filesystems which will be blocked from creating while that lock is held.
> > It is *not* sufficient for remote filesystems which are precisely those
> > which provide ->atomic_open.
> >
> > The fact that you are adding support for atomic_open means that O_EXCL
> > isn't moot.
>=20
> I mean to say: knfsd doesn't need to pass O_EXCL because its already taking
> care to produce an exclusive open via nfsv4 semantics.

Huh?

The interesting circumstance here is an NFS re-export of an NFS
filesystem - is that right?

The only way that an exclusive create can be achieved on the target
filesystem is if an NFS4_CREATE_EXCLUSIVE4_1 (or similar) create request
is sent to the ultimate sever.  There is nothing knfsd can do to
produce exclusive open semantics on a remote NFS serve except to
explicitly request them.

>=20
> > I don't know what you mean by "since it doesn't need to do lookup because
> > it already has a filehandle".  What filehandle does it already have?
>=20
> The client has sent along the filehandle of the parent directory, and knfsd
> has already done lookup_one() on the child name, and we pass along that
> negative dentry thet we looked up while holding the directory's inode lock.

This (holding the directory's inode lock) works perfectly well for local
filesystems (which don't implement ->atomic_open).  It has no effect on
remote filesystems (which is why we have ->atomic_open).

Thanks,
NeilBrown

