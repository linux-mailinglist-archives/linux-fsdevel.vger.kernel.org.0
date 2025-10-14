Return-Path: <linux-fsdevel+bounces-64166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2A6BDB95B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 00:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDADF5429CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F4D30DD2F;
	Tue, 14 Oct 2025 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="vRjj1Iz2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwWFCDct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464630595D;
	Tue, 14 Oct 2025 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479844; cv=none; b=GzzZZ++kBudOjLolSr/BTmQLyg26En9kvRDFGGGAJamRSqWsyuSExuP754P7McPMC40PFPjlKkeF+MCleA470wUrGZlg+hQkpRmjQmvBwu6Otng4B+j+TTi9CmsNvdYofZ5wh4adla2Xkk+VmtjyNFmLQYlAujl1iejv6K2G5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479844; c=relaxed/simple;
	bh=Y0ZWB8IW7WA3Tu8mFcSM9NS2fCmDXQy88DlyKa+fx6s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WgyGl1o6CBuUCf3LP9gTrZYpvnovU9iZuPOlNMpLKLdH81CG+qH5QBRhwleerk2hzqVQlysFj0d+yhn4K/5GhubOdkKVQSjTBaKsR4pLyiwy19t2HC6ywDS5nYULBHg4qO2lv2N/t1n1aSI4bcpsxaGTl/BKnjde1/c1TKPEBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=vRjj1Iz2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iwWFCDct; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.stl.internal (Postfix) with ESMTP id 0EF761300683;
	Tue, 14 Oct 2025 18:10:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 18:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760479838; x=1760487038; bh=nCzRbfcA8hHPMwFKOygEjL9TtP08HW4n43B
	k2GKqoug=; b=vRjj1Iz2MJkRiS5oTgMN69YY9T5CviUbsSueOnyqMALlKoLh7yC
	F0GyMWGoMaieW6VVoqxN/76Kf8BXa+mAuY2fx5ic4vurbiqZfp8UGUfqUglsez+F
	e//U4w9egmHZnXSGLnKkvonWJDj850lqc3m4Y2KARjsEzY7sN1ZxlMXPAfe+TN1c
	faN3HaM9wzmxKHLwXnc9zzlM1yqDxqqyKxl9t862tUXE+97RP6M/0e/IKnUVmGc0
	75Ysc46PH/bff5A6VrDh5isNkbg9+PLWoK6xUBZ1Ukf0oPOXzIS3qXHVaO1enjNV
	PhDqsBZ4y0aUxHxZFZ501FLY2BA+n5X2Elw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760479838; x=
	1760487038; bh=nCzRbfcA8hHPMwFKOygEjL9TtP08HW4n43Bk2GKqoug=; b=i
	wWFCDctDN6fTbgIeyP3+WP5OzVNSAHCGloQOLBJLDpkzsPUmwGboWIrqXVVflhuy
	pL8Nj9AovR0zDR42pMxC9Xx3vzC9mJIito/nvOz7kDFn3lIRtPTh9qetJUlaqdJA
	1yFqjPJ1tmw0wrvZdafT2MnEaR28OLjNkfBsC1d2loB3gWxtZLUdKqj9ATQf5dYZ
	/phLJpA3tyIrGgzY81dE5JhtEAkvHgeTNNyIQJ4K3gLKWaYjjB88kGyN7YFA2qt+
	qJMfxLBW/xxSST92Z3pa7QBLaCKoTSoMI/u7UwU1ryX2phtVa9XyXe7EBwJgJ/rT
	Pm8PKokPejEsxh0+Sy3MA==
X-ME-Sender: <xms:XMruaFuRT8IUuTMjKG1Dw0WHyOjGHDNfXyRE-_nVp-MOI_fakUzx5g>
    <xme:XMruaNcG5qIHN3loksbZIoOceexzPVYZB3m0MFlN7v7iPHUT-OBQMT3-R4AgSGJpy
    F4LDimAEuIL4DZn8RlZZTV4nEOoqE44hAHGM8uz2N-BVxnY5w>
X-ME-Received: <xmr:XMruaBCr8PUP68p5xyBv2IrG4FxXTP8o3dAsBdcWY2_anfqWcF9PLzpLs2oJYv8sM08gZU8SNz8rNKAbWIDwRZfZNYVmIGisVM5S051kkx5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqgihfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhunhhiohhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XMruaIlLW6kt8bsuAvkOEJYObTHM-44_i5n9WPzH3fXV5aO1bcA2kw>
    <xmx:XMruaPhVqYQSbftP3_kDMT2NjLrpo1kVjx2g8f9L1MaXawYwkuOn5A>
    <xmx:XMruaI16pFKOg_mv60A4rOIORMn7r6yl4PwtfngiItDQHs2j_EmxVg>
    <xmx:XMruaDRhyP5ci8StbP1zoSb-2OZ4m2R3hTYOSSlLhMk0uGw48OMmeg>
    <xmx:XsruaL1914rXeSmv2yP-lSzIlJexfiGmlhQv0Y75LbhTSC1UULawID9r>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 18:10:25 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "David Howells" <dhowells@redhat.com>, "Tyler Hicks" <code@tyhicks.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Steve French" <smfrench@gmail.com>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>,
 "Carlos Maiolino" <cem@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, netfs@lists.linux.dev,
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org
Subject:
 Re: [PATCH 02/13] filelock: add a lm_may_setlease lease_manager callback
In-reply-to: <87a320441f2b568c71649a7e6e99381b1dba6a8e.camel@kernel.org>
References: <>, <87a320441f2b568c71649a7e6e99381b1dba6a8e.camel@kernel.org>
Date: Wed, 15 Oct 2025 09:10:23 +1100
Message-id: <176047982343.1793333.618816248171085890@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Oct 2025, Jeff Layton wrote:
> On Tue, 2025-10-14 at 16:34 +1100, NeilBrown wrote:
> > On Tue, 14 Oct 2025, Jeff Layton wrote:
> > > The NFSv4.1 protocol adds support for directory delegations, but it
> > > specifies that if you already have a delegation and try to request a new
> > > one on the same filehandle, the server must reply that the delegation is
> > > unavailable.
> > >=20
> > > Add a new lease manager callback to allow the lease manager (nfsd in
> > > this case) to impose this extra check when performing a setlease.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/locks.c               |  5 +++++
> > >  include/linux/filelock.h | 14 ++++++++++++++
> > >  2 files changed, 19 insertions(+)
> > >=20
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 0b16921fb52e602ea2e0c3de39d9d772af98ba7d..9e366b13674538dbf482ffd=
eee92fc717733ee20 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -1826,6 +1826,11 @@ generic_add_lease(struct file *filp, int arg, st=
ruct file_lease **flp, void **pr
> > >  			continue;
> > >  		}
> > > =20
> > > +		/* Allow the lease manager to veto the setlease */
> > > +		if (lease->fl_lmops->lm_may_setlease &&
> > > +		    !lease->fl_lmops->lm_may_setlease(lease, fl))
> > > +			goto out;
> > > +
> >=20
> > I don't see any locking around this.  What if the condition which
> > triggers a veto happens after this check, and before the lm_change
> > below?
> > Should lm_change implement the veto?  Return -EAGAIN?
> >=20
> >=20
>=20
> The flc_lock is held over this check and any subsequent lease addition.
> Is that not sufficient?

Ah - I didn't see that - sorry.

But I still wonder why ->lm_change cannot do the veto.

I also wonder if the current code can work.  If that loop finds an
existing lease with the same file and the same owner the it invokes
"continue" before the code that you added.
So unless I'm misunderstanding (again) in the case that you are
interested in, the new code doesn't run.

Thanks,
NeilBrown

