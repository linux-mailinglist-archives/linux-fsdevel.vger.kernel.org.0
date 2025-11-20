Return-Path: <linux-fsdevel+bounces-69278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0A7C767D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65A144E278A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A22F2FE04D;
	Thu, 20 Nov 2025 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="L1WFj9Nr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hgWM+k1E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45946217F31;
	Thu, 20 Nov 2025 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677603; cv=none; b=J1UijdKk4esxckfIIO+mTiUcl43aEJLd7X29wfDyIJaNIXmPzGCl1SxMjWdm/GdRRZMT6hn7DPCZi7DDoXQWpmTPe7twpzZecDYU7tbqyrjle1/zwy6pm9WCQ80wedpMWtlchX8pYR2G81DzXoVGP649JiPdoFsp7MSP2J6/q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677603; c=relaxed/simple;
	bh=JSMXVGZMenn2xK+CrSjRDAWMYSxYloPM/PVcL6Aizfw=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=nUUsFIsVrMSO55CW88d02vNQSHDkKPwOjDD9bbNelky4hPpYTX1Y2ySCqVK7RH8pzNcnC2vWz8bhbn9zKax+L/xGqHsa3+MqUschCBeXOLGU0WJus2WNSO1KdxzOdT/nxtMGSa+u1ToYVJInhUosQpZMJYYF/U7RczxqPQMy49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=L1WFj9Nr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hgWM+k1E; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 639AC140032A;
	Thu, 20 Nov 2025 17:26:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 20 Nov 2025 17:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763677600; x=1763764000; bh=A67nBEE8bNQ0ywZx/xHs65vupNeFuDWv9OG
	wlq7mtAo=; b=L1WFj9NrFI/Z8pugSEvfao9N18B0iiM+IfJTj+b0NnC694Y4Igo
	27IsRdV0YxNdjQdkd8/gkcIPGN7zpk1jQmZ5qdW01ivw+J1g6AHfNloIlZjtpXSq
	Gkd2LjjZiZdNL69ia5tUpNFNHN0oqk9FGFS6XXdb/CwFsvbaZ18+9dTDYd/UG1Li
	EUcrDCrc80jtwvLgtHlGkOa26tfVk9dXMgqT27cIp9tfELpVRnfwPgKK5QfD4Id6
	pBduaEGeXy69o0MOWh/KNjOQu2918WB46+8hBPUdNIw7CD3gTwkwGnkFslNCaJ6q
	GzyDQZ3SMkQO4QMkE+5LD+Zjt3JeoHbXkpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763677600; x=
	1763764000; bh=A67nBEE8bNQ0ywZx/xHs65vupNeFuDWv9OGwlq7mtAo=; b=h
	gWM+k1EN9sX/X5SzyFDKXHXqU1MYzVrFF/ybpjk/S385KPmH4Wu7EUgq9JxaAs50
	Oy4VJPSSN0muTDpsAv1BFPcaouY5LvDl6jthhHbcNNmAezGDAg6+BcvILlluueSi
	ioG/dZU6eFKrtpkswBh7h7B3oVW1h2pY3lLRfEm6qe0JTzmD8pd2yy+Rr+//uDmC
	Yj7g0D65Dwf17DiO8F+UHS3GasFnHXOYpgKJopXvd1stzxeuvFdagpe9oXSgc70o
	a11P79nhViRsvH5Bk1iXOTalXtfdW2+1caI1FwZXw9uVH9DokJYGQ60ep/e1FPsA
	nIZPq/3lXQVICD4eZ0nZA==
X-ME-Sender: <xms:n5UfaYI43pvJWhSXvLPW8ecO1j9uMQgTbiuXrra-7L6z3EYELEBrmw>
    <xme:n5UfaSjwb1-B_9Z6tUh3WqgUVVMfMnC1pBHi3IHkKK2mDe1P82H66nfs5TcJ0tVan
    JaZdVvkHy3VtbGWlDqEv2aZoKHfhguUptzFfC_j2cqVyhij>
X-ME-Received: <xmr:n5Ufae3QE_aFN7a2mYsMWVCWK0ptW5gkYIvoEVTqgzBDxxY0PpIcPVUeSuEy87XLg7ZFxatLJr2d8A9JkRaHtZZ8KoMcKCAbtJfPWb32KtgB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekvdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:n5UfaQgHCND_GUjLDy9CtuLsP7MgCgSSIFWSJcYqXdvPXLxFJvGaDg>
    <xmx:n5UfaX8zR8lMzgRrvBd1qvxgp3LYiX784V4iXhLKGLmfJYPedfPvBQ>
    <xmx:n5UfaUJ6U3qw5DzN_XxvrGGSNrI4lk9FSqHwHQHmaxcJeANOCGuO4g>
    <xmx:n5UfaUzKHWfz19hU54at6L0ZllbxR8xQA4w0Jy0AiE_fB9JQA3IRJA>
    <xmx:oJUfaU3vnCP9hfaltNJbHRMuLlxyuypU8-1dpeuzOz8xMppDgSsTpkZC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 17:26:35 -0500 (EST)
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
In-reply-to: <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>,
 <176351538077.634289.8846523947369398554@noble.neil.brown.name>,
 <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>
Date: Fri, 21 Nov 2025 09:26:26 +1100
Message-id: <176367758664.634289.10094974539440300671@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 19 Nov 2025, Benjamin Coddington wrote:
> On 18 Nov 2025, at 20:23, NeilBrown wrote:
>=20
> > On Wed, 19 Nov 2025, Benjamin Coddington wrote:
> >> We have workloads that will benefit from allowing knfsd to use atomic_op=
en()
> >> in the open/create path.  There are two benefits; the first is the origi=
nal
> >> matter of correctness: when knfsd must perform both vfs_create() and
> >> vfs_open() in series there can be races or error results that cause the
> >> caller to receive unexpected results.  The second benefit is that for so=
me
> >> network filesystems, we can reduce the number of remote round-trip
> >> operations by using a single atomic_open() path which provides a perform=
ance
> >> benefit.
> >>
> >> I've implemented this with the simplest possible change - by modifying
> >> dentry_create() which has a single user: knfsd.  The changes cause us to
> >> insert ourselves part-way into the previously closed/static atomic_open()
> >> path, so I expect VFS folks to have some good ideas about potentially
> >> superior approaches.
> >
> > I think using atomic_open is important - thanks for doing this.
> >
> > I think there is another race this fixes.
> > If the client ends and unchecked v4 OPEN request, nfsd does a lookup and
> > finds the name doesn't exist, it will then (currently) use vfs_create()
> > requesting an exclusive create.  If this races with a create happening
> > from another client, this could result in -EEXIST which is not what the
> > client would expect.  Using atomic_open would fix this.
> >
> > However I cannot see that you ever pass O_EXCL to atomic_open (or did I
> > miss something?).  So I don't think the code is quite right yet.  O_EXCL
> > should be passed is an exclusive or checked create was requested.
>=20
> Ah, it's true.  I did not validate knfsd's behaviors, only its interface wi=
th
> VFS.  IIUC knfsd gets around needing to pass O_EXCL by holding the directory
> inode lock over the create, and since it doesn't need to do lookup because
> it already has a filehandle, I think O_EXCL is moot.

Holding the directory lock is sufficient for providing O_EXCL for local
filesystems which will be blocked from creating while that lock is held.
It is *not* sufficient for remote filesystems which are precisely those
which provide ->atomic_open.

The fact that you are adding support for atomic_open means that O_EXCL
isn't moot.

I don't know what you mean by "since it doesn't need to do lookup because
it already has a filehandle".  What filehandle does it already have?

Thanks,
NeilBrown


>=20
> > With a VFS hat on, I would rather there were more shared code between
> > dentry_create() and lookup_open().  I don't know exactly what this would
> > look like, and I wouldn't want that desire to hold up this patch, but it
> > might be worth thinking about to see if there are any easy similarities
> > to exploit.
>=20
> I agree, that would be nice.  It would definitely be a bigger touch, and I
> was going for the minimal change here.
>=20
> Thanks for looking at this Neil.
>=20
> Ben
>=20


