Return-Path: <linux-fsdevel+bounces-67398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0524DC3DEF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 01:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C90C3AA0F6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922B1E3762;
	Fri,  7 Nov 2025 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="WZYAC5pt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Psg2gNos"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23A33993;
	Fri,  7 Nov 2025 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473681; cv=none; b=ufJ4zqM+wyIPsjRK193FvrNokGG8H5JotQCaEz+5/ywGO0gzCbAKdeXXS87qBajmt7/nSDGn52hFA2/0C4NSQD5WZQ3FY1D2zwrkGJ2e58HdCXT3JVihuupOidW4o11gd7t94HiSh/ADjaY6BOHWPJtd/MtYyP+Kta8ZdkjZ8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473681; c=relaxed/simple;
	bh=MufCujU/0LsEsdoh25mDaMBAKJ5uFyL9+gDf2+vBd+0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=oHYXEcTSYoHyVkX72EIqQp/P5StWGobo798vrgPKFkPEkyNRL5ulqc34y95dBzU5Q70jyjXpa6GEl3JMrRYy72FKDLvfRAtsDuZPNxrlAQyxUhrdj6GtCfXZaxIIc/Z6SGzkmAFCGOCwEtUPUkJZUwttL8x470KeSzTiJxH2JMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=WZYAC5pt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Psg2gNos; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 2F76A13801BB;
	Thu,  6 Nov 2025 19:01:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 06 Nov 2025 19:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762473676; x=1762480876; bh=H6fp6wT7I155+JjI5U+YS+I+wpfi8UjlpY4
	LU8fjdU4=; b=WZYAC5ptT+JI+E3LCYQDPMrHgn2+EeezTwSX9Fj81LnO57sEIW0
	r5bog5i33AtRsNThYOW5jDpkHJo5LmpOQU7UBC/WI2CsBHqkVpPTyHV/ApxUM1tN
	z6dVSfEJthkopAMT44s7CyEjRA2sDrA7Y2ef+eMrFuZp33UeziEFvqR18wUswgoZ
	7iPlUWWsOUPV/ZTTFBfyHToZxwjR9SvGXXZHsmi76QwHLy2cwbWHeeTpiMc4d1Bx
	XeBUu2V3z1ClTvl5FdR+kiB+ei1mybka1yZ1GjCONTkXDJfd+mNjp5j/C8/VHSTP
	dThaFVWL2uE50jq2dsohAmGrZdbMqVO7Ang==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762473676; x=
	1762480876; bh=H6fp6wT7I155+JjI5U+YS+I+wpfi8UjlpY4LU8fjdU4=; b=P
	sg2gNosOUgNreOPGLlVE9k8r0A93bFTvKl0A1YiFCaR0/yxDdKMWNofRmX2pbv2C
	pRquqzDxvSlnoOFKUo3q0Ir6NiXbOSxcJH8T5/d9/oXcWZsBYNknHCW+NvYGKU2G
	Ni1/LdQGu7Us7ontcePjlATrS/pgRVzjGEEX7HanmFiC2g+ePTDJ5SSAtpJBah0H
	UWRXuHQQCAsLEu8BLIO90FsUNkSBOy8aoz2K3RYVbczfmOyGIUeyWzmqDvAPkDRA
	jQU6SMudoXVNKkegC9Kaz3mNZdYl5nPuZwKwE6TAABXrWOiDglM1NlGb8+vPxFje
	mse7RGNm/dK9IXvzGfidw==
X-ME-Sender: <xms:xDYNaRhNbUJHsahPPmb6piowRnF47nS9W-BDbBUWZMioGCLB0QKE0Q>
    <xme:xDYNadGCoPUcs45mlm9G-M-v6BypV59NlC8i5D0rXfDdqG1vicJvxUwSAeEgzm-AW
    mM9E_dg4ffodJEGnHgTyJ5KyY9-2grnnN8X99UhFArcj-pfDw>
X-ME-Received: <xmr:xDYNaZhYRnJe2Zwy43UTfxOwR_mAMlSeo2ztdDGjHNPtTGiDI9p-9jO_eGsbdcJ0bT11eVgdtj8wsq09LuBid3ldax93JTUA9nFc7WrB4ws3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepleegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepfhhrrghnkhdrlhhisehvihhvohdrtghomhdprhgtphhtthhopehlihhn
    uhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhnihhlfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhhrghruggvnhhinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xDYNaRZM3kLhMQrgyC03y_mvDTyKIhHr-UZRyaVoDw1bUdd3TO5KWQ>
    <xmx:xDYNab6BMLI1rNIb697RuBsl1xbiAOh3-jJjQLerAQCMMocsAIIZ6A>
    <xmx:xDYNaWzpKwiCJssErWAKaC5Omh24WDMdd_ESMwy-1QKK0c3T8HNikg>
    <xmx:xDYNadOOkUDnvT6bORX3tFjgvG8jH6RVTiJmdbw7J549hUUGJI3E9w>
    <xmx:zDYNaZmP4HdGrgNN2fuf1yLCRS5MEi7pUT3ZiXhJ138U_-MYPTZPl43i>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 19:00:45 -0500 (EST)
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
Cc: "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>,
 "Dominique Martinet" <asmadeus@codewreck.org>,
 "Christian Schoenebeck" <linux_oss@crudebyte.com>,
 "David Sterba" <dsterba@suse.com>, "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 "Chris Mason" <clm@fb.com>, "Xiubo Li" <xiubli@redhat.com>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Jan Harkes" <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, "Tyler Hicks" <code@tyhicks.com>,
 "Jeremy Kerr" <jk@ozlabs.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Namjae Jeon" <linkinjeon@kernel.org>,
 "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Yuezhang Mo" <yuezhang.mo@sony.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Andreas Dilger" <adilger.kernel@dilger.ca>,
 "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>,
 "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Yangtao Li" <frank.li@vivo.com>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
 "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>,
 "David Hildenbrand" <david@redhat.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Dave Kleikamp" <shaggy@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>,
 "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
 "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Bob Copeland" <me@bobcopeland.com>,
 "Mike Marshall" <hubcap@omnibond.com>,
 "Martin Brandenburg" <martin@omnibond.com>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Steve French" <sfrench@samba.org>, "Paulo Alcantara" <pc@manguebit.org>,
 "Ronnie Sahlberg" <ronniesahlberg@gmail.com>,
 "Shyam Prasad N" <sprasad@microsoft.com>, "Tom Talpey" <tom@talpey.com>,
 "Bharath SM" <bharathsm@microsoft.com>,
 "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Hans de Goede" <hansg@kernel.org>, "Carlos Maiolino" <cem@kernel.org>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 linux-um@lists.infradead.org, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject:
 Re: [PATCH] vfs: remove the excl argument from the ->create() inode_operation
In-reply-to: <f5927a9bb985b9ad241bc5f9fc32acfd35340222.camel@kernel.org>
References: <20251105-create-excl-v1-1-a4cce035cc55@kernel.org>,
 <176237780417.634289.15818324160940255011@noble.neil.brown.name>,
 <6758176514cdd6e2ceacb3bd0e4d63fb8784b7c6.camel@kernel.org>,
 <f5927a9bb985b9ad241bc5f9fc32acfd35340222.camel@kernel.org>
Date: Fri, 07 Nov 2025 11:00:34 +1100
Message-id: <176247363419.634289.473957828516111884@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 07 Nov 2025, Jeff Layton wrote:
> On Thu, 2025-11-06 at 07:07 -0500, Jeff Layton wrote:
> > On Thu, 2025-11-06 at 08:23 +1100, NeilBrown wrote:
> > > On Thu, 06 Nov 2025, Jeff Layton wrote:
> > > > Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
> > > > the "excl" argument to the ->create() inode_operation is always set to
> > > > true. Remove it, and fix up all of the create implementations.
> > >=20
> > > nonono
> > >=20
> > >=20
> > > > @@ -3802,7 +3802,7 @@ static struct dentry *lookup_open(struct nameid=
ata *nd, struct file *file,
> > > >  		}
> > > > =20
> > > >  		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> > > > -						mode, open_flag & O_EXCL);
> > > > +						mode);
> > >=20
> > > "open_flag & O_EXCL" is not the same as "true".
> > >=20
> > > It is true that "all calls to vfs_create() pass true for 'excl'"
> > > The same is NOT true for inode_operations.create.
> > >=20
> >=20
> > I don't think this is a problem, actually:
> >=20
> > Almost all of the existing ->create() operations ignore the "excl"
> > bool. There are only two that I found that do not: NFS and GFS2. Both
> > of those have an ->atomic_open() operation though, so lookup_open()
> > will never call ->create() for those filesystems. This means that -
> > > create() _is_ always called with excl =3D=3D true.
>=20
> How about this for a revised changelog, which makes the above clear:
>=20
>     vfs: remove the excl argument from the ->create() inode_operation
>    =20
>     Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
>     the "excl" argument to the ->create() inode_operation is always set to
>     true in vfs_create().
>    =20
>     There is another call to ->create() in lookup_open() that can set it to
>     either true or false. All of the ->create() operations in the kernel
>     ignore the excl argument, except for NFS and GFS2. Both NFS and GFS2
>     have an ->atomic_open() operation, however so lookup_open() will never
>     call ->create() on those filesystems.
>    =20
>     Remove the "excl" argument from the ->create() operation, and fix up the
>     filesystems accordingly.

Thanks, that is a substantial improvement.  I see your point now and I
think this is a really nice cleanup to make - thanks.

I think the commit message could be improved further by leading with the
detail that is central - that most ->create function ignore 'excl'.

 With two exceptions, ->create() methods provided by filesystems ignore
 the "excl" flag.  Those exception are NFS and GFS2 which both also
 provide ->atomic_open.

 excl is always true when ->create is called from vfs_create() (since
 commit......) so the only time it can be false is when it is called by
 lookup_open() for filesystems that do not provide ->atomic_open.

 So the excl flag to ->create is either ignored or true.  So we can
 remove it and change NFS and GFS2 to acts as though it were true.

>=20
> Maybe we also need some comments or updates to Documentation/ to make
> it clear that ->create() always implies O_EXCL semantics?

Definitely, something in porting.rst and something in vfs.rst.

I would be worth saying somewhere that if the fs needs to mediate
non-exclusive creation, it must provide atomic_open().

Thanks,
NeilBrown


> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


