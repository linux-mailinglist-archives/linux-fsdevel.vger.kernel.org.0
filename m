Return-Path: <linux-fsdevel+bounces-74604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EB256D3C5A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 249745A9982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC053EF0A7;
	Tue, 20 Jan 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hN9KLdlX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x/vEY8yh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC13EDABE;
	Tue, 20 Jan 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904903; cv=none; b=plXoI3il3GKlexD+Su11lgAhng7yxRdN+glW88w7IthYUMljMQnrGDM0/8Z4pThX/3djzGCRKrbGQcGlhd0oiU72jRcm92+VNQqtBvKwOCWaUt8NAAwU+fbf5OkvqimVQKPC+rOx8oyrd48u6nCcmQv2yIvWWhxfWalX65/+v48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904903; c=relaxed/simple;
	bh=uAbk1/Uz2jcgXXPvriA1m0gX6yf6gApwV4w11D9e+k8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EATC+XwUCGbuTbc+FmQW6lHSTm116qGalKMVRcguUAL5vG50rzdvYn7qWgWKvz9MG0BbozjYIoHTg+ATVdzgX8TGS0+zg3TWrbBedSqR6S8r5vOZYAa+K7IG9nvU6qdeKZwpPt/HxNzd3V3pcw5lQ3SV1SRe1CH6wOQGsW3Joi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hN9KLdlX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x/vEY8yh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 07AF61D004D5;
	Tue, 20 Jan 2026 05:28:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 05:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768904899; x=1768991299; bh=C3EXE34x1FqSyMvYORQfF6pSnoOYXTmwsAd
	UpJjSX4k=; b=hN9KLdlXFBqO3z1rE4l3FNa6pysHyxvxAaeUL+gE4jcSNI4QzmW
	niJzH9B7sz96mtrTwSthQw5hOoOFjDgFDsJfHHvdeI9d1xHYn38VnFb2D+9opnKD
	7t8eXVMGpAmDWaBbChrGoRNqmDCryjZRQx9eLtsZD0rsTVBa6jklFZSDgF8Luh7R
	f7CFECVYFWTNZnk7wFnUkJpWDer4k+ZG+baEybDgxlntdnXQTQR58JxkhK6wcTHL
	fxj/R1hBmDLsjAjTMgHPgu0wB6vIIS5KUi1X4LyKMI95YEPRu2o8gYBR9D7UBU7D
	NFLS2g+NpuHnBNfQrvtzR0hWhl5Wwns6RDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768904899; x=
	1768991299; bh=C3EXE34x1FqSyMvYORQfF6pSnoOYXTmwsAdUpJjSX4k=; b=x
	/vEY8yh/+K/bJFMKKoNH6RNKOKyUTMKznsKU/X+HeRAHv7M5vEBYU347hvC6abrg
	fR6IAQld/ZHkp+2EOJLIHkg08VB+AZaLjkLpfgJORpONuir9dMMt+O87rbYyoNly
	yCuJX9Rwtc61MTaokAtSNGv15bby5HQcyipaS4JpYLwwCfcAxcokiAH23FH7vx66
	34z/2yliFuzoduPOuTd7cqxO+zbntlHFuYOQHcLyS5RRItwCg0FDPb5yohgytprc
	IxysS6vuzMHPZFBqa/KMJPoCzyTfqEJVuDuvmSeqM0GII2RTr2AzGsjyAG0N0QaB
	Oq++yxlVPdfJE/mGBObEw==
X-ME-Sender: <xms:w1hvaYAO_XVpYN0MjCapn5gUhgYGqvMN3_NJ-mezp0R9Oc_ZA626Tw>
    <xme:w1hvaSr-xCBhzJM3FtapcGvnTtekbybFml001IruHmzrNSd1DwXyXvyOt5IHYsA4V
    yiOTJfb6nLwSPwI6jQZCVKnH0oP9NiC3IU4K15wk_b8FwOqiA>
X-ME-Received: <xmr:w1hvabEBi3RolmKwCd0ZhzAFp2981QBg0OQPUONatUInSposudcnZSUy3insU1kcJ08zNjFAhF1g9A4rCMOqrK3zrgEC5ZFhMzTS-zvT26ky>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epuddtgfdufffhffeuueeludffvdejfeeufeeggfettddttdeigfetjeegveffgeegnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    dqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhhn
    rghrthesphhovghtthgvrhhinhhgrdhnvghtpdhrtghpthhtoheptghhuhgtkhdrlhgvvh
    gvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepthhrohhnughmhieskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w1hvaes8S-KeCEA2rdlHCpMvRH7uKjBisa5YWNLQhQGR951ArjqsPQ>
    <xmx:w1hvaZYzWGJ8aZZwZQvFS4bRfdBqK_fAEp5uRvDiGnBwWNmsG1byeA>
    <xmx:w1hvaW5anCXSFAKbH_KSP8gkF13OjV1B-7sxcKZy4sI3f9QFfAkO5g>
    <xmx:w1hvaZ9fI9eJZT0Mh-WJXePIXZqtoGxh6OP89cAv9UPbImZke5RDCQ>
    <xmx:w1hvaeMRlBbBquaIq6kujcykaIhsu85Z58Zq_Vbdwe3zix753h3pCrBX>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 05:28:16 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Rick Macklem" <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org, "Lennart Poettering" <lennart@poettering.net>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
In-reply-to: <20260120-irrelevant-zeilen-b3c40a8e6c30@brauner>
References: <cover.1768573690.git.bcodding@hammerspace.com>,
 <20260119-reingehen-gelitten-a5e364f704fa@brauner>,
 <176885678653.16766.8436118850581649792@noble.neil.brown.name>,
 <20260120-tratsch-luftfahrt-d447fdd12c10@brauner>,
 <176890236169.16766.7338555258291967939@noble.neil.brown.name>,
 <20260120-irrelevant-zeilen-b3c40a8e6c30@brauner>
Date: Tue, 20 Jan 2026 21:28:13 +1100
Message-id: <176890489330.16766.1807342797736472831@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 20 Jan 2026, Christian Brauner wrote:
> On Tue, Jan 20, 2026 at 08:46:01PM +1100, NeilBrown wrote:
> > On Tue, 20 Jan 2026, Christian Brauner wrote:
> > > > You don't need signing to ensure a filehandle doesn't persist across
> > > > reboot.  For that you just need a generation number.  Storing a random
> > > > number generated at boot time in the filehandle would be a good solut=
ion.
> > >=20
> > > For pidfs I went with the 64-bit inode number. But I dislike the
> > > generation number thing. If I would have to freedom to completely redo
> > > it I would probably assign a uuid to the pidfs sb and then use that in
> > > the file handles alongside the inode number. That would be enough for
> > > sure as the uuid would change on each boot.
> >=20
> > What you are calling a "uuid" in "the pidfs sb" is exactly what I am
> > calling a "generation number" - for pidfs it would be a "generation
>=20
> "generation number" just evokes the 32-bit identifier in struct inode
> that's overall somewhat useless. And a UUID has much stronger
> guarantees.
>=20
> > number" for the whole filesystem, while for ext4 etc it is a generation
> > number of the inode number.
> >=20
> > So we are substantially in agreement.
>=20
> Great!
>=20
> >=20
> > Why do you not have freedom to add a uuid to the pidfs sb and to the
> > filehandles now?
>=20
> Userspace relies on the current format to get the inode number from the
> file handle:
> https://github.com/systemd/systemd/blob/main/src/basic/pidfd-util.c#L233-L2=
81

The
  assert(r !=3D -EOVERFLOW);
means you cannot extend it

>=20
> And they often also construct them in userspace. That needs to continue
> to work. I also don't think it's that critical.
>=20

as does this.

OK, thanks.

NeilBrown

