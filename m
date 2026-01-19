Return-Path: <linux-fsdevel+bounces-74535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A02D3B8C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 21:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E57E2300BFA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA532F0C7A;
	Mon, 19 Jan 2026 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Lc0EYW6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ext14fYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890632E4257;
	Mon, 19 Jan 2026 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855564; cv=none; b=l3H0vaOTNLgktKViwk6vLL8ktTyFrqQe6LHY9Ti/T6T3rafJuzqR/pDMn9Ts/2PQvhlpAK3mU7u10jJ9Jca6oakwbu7lmGxtfAPUl/kesbn1f5wA7mG5SPyj+qVodnJmJD699JvyKKCOmG6+thTICReoNHwPdeZg3VRSI6x126g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855564; c=relaxed/simple;
	bh=Nu+u8xIi1n/SDoC4CO0WUQIjg6M4bP4ZH6PEVt+Ooxc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NTFmOJbkyPmsjQRAoNByD7E5r9X+BYShOEneXXvHDkfqEOsQDwpwZTEjqyZSkFhaLMNUlEx2voccNaO59YLPrJfER2GnHzcs1lBGrqAXmXd/RgiPbI27/h2L2XdOs74S51A8I/Ljdiq+uqMB7Hhln3nfu/w0yLgqhYioNgk0ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Lc0EYW6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ext14fYh; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id C9DA613010D8;
	Mon, 19 Jan 2026 15:45:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 19 Jan 2026 15:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1768855559; x=1768862759; bh=v4LtkcerTNcKdHBuxb989VhIuXJUmGOFYwT
	3m9zCWpQ=; b=Lc0EYW6ibUUqVQJUKzaim23Euwd0BGgFRXe5DALzfEojg7VN6rT
	B6DiPIhAD3IC7M+5XEsbPahQ32cVgcxSRShqrzfxc+w2dQttIp0GWIrdUpX55qw0
	1YJfvLNEex4MDg629sJRt0DIagYZ7O2YgHGEWRwCbzJK6pewaTBy/LwbN/3UuIrH
	D1X+l3ArslIHe9m6/MxEM+BHkwyONj/QBcgvUoddEjQn2rtqiXm8XIlcaUBBGYcG
	L51CiT0gWDAG38s7mrfim3JvqvUewVVj4jdamfv/vGEC6XVs37En7pvh86V+RKx9
	u1Btsigj5UNDPW1ltBPZUH8SSA1nKU+SOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768855559; x=
	1768862759; bh=v4LtkcerTNcKdHBuxb989VhIuXJUmGOFYwT3m9zCWpQ=; b=e
	xt14fYhTflITcl6YnaiRNNIPiieIuY3T2ekw4mgpmY/v/o1D6Rm9og97ySUxlRr7
	FuBeLtlEdjDnDlXWSfPcQ5AbZapLP6oLiXJHFrRkIH0gKfaYLMLYjIQO36N4L42d
	r+sxyuyT+2Dw0f4nF6Lb5U2/7dD8/gO1shUXevXTcOuhLj1lVMOynN4dkejCogfQ
	7OuzydzQDyp0GPeNwjKBxultpJ+adDUHRpRjZpvqCu+f30BBcE9P8TFFL51mFFSd
	5nqf/ngi6HPQpjIzif8UMR8pgDgY3x6Ww4kDrS1yWA5BVy+Nd5cITHqHPkkjbEzT
	FALc3wWKIrn/NhNHGyWNw==
X-ME-Sender: <xms:BJhuaSbEzFcWy9Pk6146wE82fhYm_CxjTiFHqGZKgwA0vYGamqcSmg>
    <xme:BJhuaSwoBnyfk0eKn4-Aohsxi2pWCriN6dRenPPaxnkZL7_MsdqbsQlFS_j1eycjJ
    snQClQFRDDxmckQGHACK4fSLzS3RfNjJQu9JuQvNfYNBDMQpQ>
X-ME-Received: <xmr:BJhuaSJdRJMi7-ZpoAEIl9nJ6TzUD9unJMV7r6q_QrUGstq03Bv3pQ2jFX3ElyETlEyXOOSz_dMOZCxbyCO3448TMs1hLaDXJLozABR1b4SI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepghhuohgthhhunhhhrghisehvihhvohdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BJhuaSBO9clKpBY1c8tqtIkxX8-Yutqel2bbB8TbvrqddamOXX7Ykg>
    <xmx:BJhuaRhuOPQDyCA_KFYnfcdaAOzKUXr3io07nJfde0jw7wudsjV9Bg>
    <xmx:BJhuade95jkbwLWPmv5m35H6i7zd7TYoRjmUJ2fQMpOWq-IJ6QyQ1w>
    <xmx:BJhuaelSBffgMjviuHAjgSaIv0cuzLl42YuUELeDiPJYohFPRx_JkA>
    <xmx:B5huacYgAtwv-dw4ucg_ORya8hJwBFrWvyIGFRHLnxavffYq8g3321NH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 15:45:39 -0500 (EST)
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
Cc: "Christoph Hellwig" <hch@infradead.org>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>,
 "Gao Xiang" <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "Yue Hu" <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>,
 "Sandeep Dhavale" <dhavale@google.com>,
 "Hongbo Li" <lihongbo22@huawei.com>, "Chunhai Guo" <guochunhai@vivo.com>,
 "Carlos Maiolino" <cem@kernel.org>, "Ilya Dryomov" <idryomov@gmail.com>,
 "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>,
 "Luis de Bethencourt" <luisbg@kernel.org>,
 "Salah Triki" <salah.triki@gmail.com>,
 "Phillip Lougher" <phillip@squashfs.org.uk>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp" <shaggy@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Richard Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-unionfs@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
In-reply-to: <20260119-kanufahren-meerjungfrau-775048806544@brauner>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>,
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>,
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>,
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>,
 <aW3SAKIr_QsnEE5Q@infradead.org>,
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>,
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>
Date: Tue, 20 Jan 2026 07:45:35 +1100
Message-id: <176885553525.16766.291581709413217562@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 19 Jan 2026, Christian Brauner wrote:
> On Mon, Jan 19, 2026 at 06:22:42PM +1100, NeilBrown wrote:
> > On Mon, 19 Jan 2026, Christoph Hellwig wrote:
> > > On Mon, Jan 19, 2026 at 10:23:13AM +1100, NeilBrown wrote:
> > > > > This was Chuck's suggested name. His point was that STABLE means th=
at
> > > > > the FH's don't change during the lifetime of the file.
> > > > >=20
> > > > > I don't much care about the flag name, so if everyone likes PERSIST=
ENT
> > > > > better I'll roll with that.
> > > >=20
> > > > I don't like PERSISTENT.
> > > > I'd rather call a spade a spade.
> > > >=20
> > > >   EXPORT_OP_SUPPORTS_NFS_EXPORT
> > > > or
> > > >   EXPORT_OP_NOT_NFS_COMPATIBLE
> > > >=20
> > > > The issue here is NFS export and indirection doesn't bring any benefi=
ts.
> > >=20
> > > No, it absolutely is not.  And the whole concept of calling something
> > > after the initial or main use is a recipe for a mess.
> >=20
> > We are calling it for it's only use.  If there was ever another use, we
> > could change the name if that made sense.  It is not a public name, it
> > is easy to change.
> >=20
> > >=20
> > > Pick a name that conveys what the flag is about, and document those
> > > semantics well.  This flag is about the fact that for a given file,
> > > as long as that file exists in the file system the handle is stable.
> > > Both stable and persistent are suitable for that, nfs is everything
> > > but.
> >=20
> > My understanding is that kernfs would not get the flag.
> > kernfs filehandles do not change as long as the file exist.
> > But this is not sufficient for the files to be usefully exported.
> >=20
> > I suspect kernfs does re-use filehandles relatively soon after the
> > file/object has been destroyed.  Maybe that is the real problem here:
> > filehandle reuse, not filehandle stability.
> >=20
> > Jeff: could you please give details (and preserve them in future cover
> > letters) of which filesystems are known to have problems and what
> > exactly those problems are?
> >=20
> > >=20
> > > Remember nfs also support volatile file handles, and other applications
> > > might rely on this (I know of quite a few user space applications that
> > > do, but they are kinda hardwired to xfs anyway).
> >=20
> > The NFS protocol supports volatile file handles.  knfsd does not.
> > So maybe
> >   EXPORT_OP_NOT_NFSD_COMPATIBLE
> > might be better.  or EXPORT_OP_NOT_LINUX_NFSD_COMPATIBLE.
> > (I prefer opt-out rather than opt-in because nfsd export was the
> > original purpose of export_operations, but it isn't something
> > I would fight for)
>=20
> I prefer one of the variants you proposed here but I don't particularly
> care. It's not a hill worth dying on. So if Christoph insists on the
> other name then I say let's just go with it.
>=20

This sounds like you are recommending that we give in to bullying.
I would rather the decision be made based on the facts of the case, not
the opinions that are stated most bluntly.

I actually think that what Christoph wants is actually quite different
from what Jeff wants, and maybe two flags are needed.  But I don't yet
have a clear understanding of what Christoph wants, so I cannot be sure.

NeilBrown


