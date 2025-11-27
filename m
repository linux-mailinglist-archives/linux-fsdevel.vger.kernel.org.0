Return-Path: <linux-fsdevel+bounces-69937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC8C8C6DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 01:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63EB934F1DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 00:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFEB225A35;
	Thu, 27 Nov 2025 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dZ3oUZB+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XSNSgk9a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0653A8F7;
	Thu, 27 Nov 2025 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764203792; cv=none; b=tEBzw5rj2rCHG5S0MwhhM8SO1mqaHNOkr0F406Pt/SAJDJ3uAZ1IPSAa8EDPH3s8RGTgGUoKZqADR/OlhDs7+v6mZWmp/FrDxLqS19FfZCKpe0nhnL99v5gjWGnmjhWg9vDQY+q5kqYhyetYEw4Mcn1PgezmESolktttsa9sELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764203792; c=relaxed/simple;
	bh=xsuFcbAlg2HboMaO7bbDJ/KZc/wViFY/2Ba8FAZUTeg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BlTotGO4XtWMPdaPhriUeaTwGjm3Xq+szyHpIIU9KLqBac56vbGoIB6A/hRmG8+bDgRPEfQQSeyY3KynQTVaXc7K+WEPOs2I7WxEyxvseWF81iq9EkqahMR9fPJDx5RhwEpvUFb3G55XVtcOZfDkN2igZLajeRRxF7VUn5WDdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dZ3oUZB+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XSNSgk9a; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D6447EC0032;
	Wed, 26 Nov 2025 19:36:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 26 Nov 2025 19:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1764203788; x=1764290188; bh=P7Cl5oo2kGuj6tjWqJ/aNffHuN9nBjPRtVO
	qt/AXLNA=; b=dZ3oUZB+vN9SYW55tRyRF+d1BsOlZ1fE6rDXfsWgX+hru5OUWmI
	9mCR5VtxXCHIprPTHz+DuB0fUv2Sn1/XsUpHrlKjtmVRCq3jwIhPZpFBDD+Xh3Ad
	Fx6TpoZmaLTq+hjPjSZ+6O+/sy7NHpWc2O+j//USDWeGM//YS/1AJbv9HVCDzq0a
	8Z1xC2YKNqJFTTbYuTOeTd9djT3uT2hMzK1dBt3npXoqR6WKlQd+DCGNAatWlcPu
	yOi2A1I/vGbYhzCRktUyl10QSrDpTQJkOkVmsAi0jZRKKX6rJLrMTV2gP26hISIZ
	mDwCGtVvFMGFB4Rk/3tb5IQ/AenVHmgBUWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764203788; x=
	1764290188; bh=P7Cl5oo2kGuj6tjWqJ/aNffHuN9nBjPRtVOqt/AXLNA=; b=X
	SNSgk9aw65jvcthV0WQALtb4HUptm5zN93f2RTegAXPa3oOd9ISGr9SzQ/BbO64V
	RKFD5/gZ1oDO2fKCS/EI6bMfF5C00XdIMsJwwNrKZ9zCT31P5A+FRLhViiHOpc9f
	PKGz8sdaMmL6X8N/w8q9EP7IzFvLeXtgE0WNVLGXHV5+F5N7V8vhUPDHZR0m9VUN
	LneN9ggbbyKEK3N0acZHjgGwZlS/c0ztkT3zrztX/Fnh65Vlzd0sIQkyHMa8db9W
	XJ/zk2Zi+HhGSsiBNLpAXFTRWU+jpOR/cIKyGvZ23+olzhym/SkHDtkvb1oEIevo
	OnPv54+L8r+WUCi8/1XdQ==
X-ME-Sender: <xms:DJ0naZmuFUdboO5grDQinB8zM6PhJacgP75g4kKod8JvVB50Max2-g>
    <xme:DJ0nafPhWelhwuJKpOwxOv66Fc4HOdOeEcgNBChw5o2qg3CJtxrOpeKgDAUtqmTQq
    9exj0MfK6oCDpw12I0lnsDjZ7C_rd9XOyGJdsAKVgFJpdDGdw>
X-ME-Received: <xmr:DJ0naVwmEM9AECzzdwQLQer52s-IKpxQ55dTh7I4zQtInOOAly0AeW6ReDkvPoNth_mmstDKUlYkU-XW6eFh36SlZNRVHCE2NRbp-p_zoHLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DJ0naUshjuwxhK27jyugEFQEqOGn16QnyCyQ7vAdfTBX4NGFSSSdpg>
    <xmx:DJ0naQaUvLmul-zcc8s6wSnCgOYCA3_STMu9qsBqsb8by5yuDzmdug>
    <xmx:DJ0nab3del8lnk4_thAw4hwnWgBw8yk122anGVXVUjZkVBKM_V_ByQ>
    <xmx:DJ0naaunp7sfseXVlMn7jTfxxlb1hHpzl1ESGRinaO4KEgcbXxkEYw>
    <xmx:DJ0naewUMTSZCCDhjiGzlqLDY4YwQZIIl2VOEdtRF5AE5wsPx9ARWPPI>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 19:36:24 -0500 (EST)
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
In-reply-to: <9DF41F45-F6E6-4306-93BC-48BF63236BE4@hammerspace.com>
References: <cover.1763483341.git.bcodding@hammerspace.com>,
 <176351538077.634289.8846523947369398554@noble.neil.brown.name>,
 <0C9008B1-2C70-43C4-8532-52D91D6B7ED1@hammerspace.com>,
 <176367758664.634289.10094974539440300671@noble.neil.brown.name>,
 <034A5D25-AAD3-4633-B90A-317762CED5D2@hammerspace.com>,
 <176419077220.634289.8903814965587480932@noble.neil.brown.name>,
 <9DF41F45-F6E6-4306-93BC-48BF63236BE4@hammerspace.com>
Date: Thu, 27 Nov 2025 11:36:20 +1100
Message-id: <176420378092.634289.15227073044036379500@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 27 Nov 2025, Benjamin Coddington wrote:
> On 26 Nov 2025, at 15:59, NeilBrown wrote:
>=20
> > On Fri, 21 Nov 2025, Benjamin Coddington wrote:
> >> On 20 Nov 2025, at 17:26, NeilBrown wrote:
> >>
> >>> On Wed, 19 Nov 2025, Benjamin Coddington wrote:
> >>>
> >>>> Ah, it's true.  I did not validate knfsd's behaviors, only its interfa=
ce with
> >>>> VFS.  IIUC knfsd gets around needing to pass O_EXCL by holding the dir=
ectory
> >>>> inode lock over the create, and since it doesn't need to do lookup bec=
ause
> >>>> it already has a filehandle, I think O_EXCL is moot.
> >>>
> >>> Holding the directory lock is sufficient for providing O_EXCL for local
> >>> filesystems which will be blocked from creating while that lock is held.
> >>> It is *not* sufficient for remote filesystems which are precisely those
> >>> which provide ->atomic_open.
> >>>
> >>> The fact that you are adding support for atomic_open means that O_EXCL
> >>> isn't moot.
> >>
> >> I mean to say: knfsd doesn't need to pass O_EXCL because its already tak=
ing
> >> care to produce an exclusive open via nfsv4 semantics.
> >
> > Huh?
> >
> > The interesting circumstance here is an NFS re-export of an NFS
> > filesystem - is that right?
>=20
> That's right.
>=20
> > The only way that an exclusive create can be achieved on the target
> > filesystem is if an NFS4_CREATE_EXCLUSIVE4_1 (or similar) create request
> > is sent to the ultimate sever.  There is nothing knfsd can do to
> > produce exclusive open semantics on a remote NFS serve except to
> > explicitly request them.
>=20
> True - but I haven't really been worried about that, so I think I see what
> you're getting at now - you'd like kNFSD to start using O_EXCL when it
> receives NFS4_CREATE_EXCLUSIVE4_1.
>=20
> I think that's a whole different change on its own, but not necessary
> here because these changes are targeting a very specific problem - the
> problem where open(O_CREAT) is done in two operations on the remote
> filesystem.  That problem is solved by this patchset, and I don't think the
> solution is incomplete because we're not passing O_EXCL for the
> NFS4_CREATE_EXCLUSIVE{4_1} case.  I think that's a new enhancement - one
> that I haven't thought through (yet) or tested.
>=20
> Up until now, kNFSD has not bothered fiddling with O_EXCL because of the
> reasons I listed above - for local filesystems or remote.
>=20
> Do you disagree that the changes here for the open(O_CREAT) problem is
> incomplete without new O_EXCL passing to atomic_open()?=20

It isn't so much that the change is incomplete.  Rather, the change
introduces a regression.

The old code was

-	error =3D vfs_create(mnt_idmap(path->mnt),
-			   d_inode(path->dentry->d_parent),
-			   path->dentry, mode, true);


Note the "true" at the end.  This instructs nfs_create() to pass O_EXCL
to nfs_do_create() so an over-the-wire exclusive create is performed.

The new code is

+		dentry =3D atomic_open(path, dentry, file, flags, mode);

Where "flags" is oflags from nfsd4_vfs_create() which is=20
   O_CREAT| O_LARGEFILE | O_(read/write/rdwr)
and no O_EXCL.
(When atomic_open is called by lookup_open, "open_flag" is passed which
might contain O_EXCL).

>                                                          If so, do we also
> need to consider passing O_EXCL when kNFSD does vfs_open() for the case when
> the filesystem does not have atomic_open()?

No as vfs_open() doesn't do the create, vfs_create() does that.
And we do need to pass (the equivalent of) O_EXCL when calling
vfs_create().  In fact we do - that 'true' as the large arg means
exactly O_EXCL.
(really we shouldn't be passing 'true' if an exclusive create wasn't
requested, but it only makes a difference for filesystems that support
->atomic_open, so it doesn't actually matter what we pass - and Jeff
has a patch to remove that last arg to vfs_create()).


>=20
> Thanks for engaging with me,
> Ben
>=20

Thanks,
NeilBrown


