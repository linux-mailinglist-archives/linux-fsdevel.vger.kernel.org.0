Return-Path: <linux-fsdevel+bounces-65027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9253ABF9E0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516D3422F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 03:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA99F2D5935;
	Wed, 22 Oct 2025 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="wKa4Lw+a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ORjkGwu7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F8278158
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105275; cv=none; b=d7UJoNQANZj5XrKNf+CNDZyAyOVvRjyK9hpYZ2+PcKpDLwkRg8MWyGIatu4LR1yI8kjDkEdyBOXhB6Q8AVnFix9WAAiWqvJamLPLgXTSQgYUPUueAdHb/Iaob6wZSMLSyrD9xBK1jQGz4bnhIvEEqFazza7td4CjmTAuAPCJf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105275; c=relaxed/simple;
	bh=sr0NnYEW9OhB2enk0RbiMhx5DUyl3S9qKunAnv8q/wU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uEZCBZ+8DlzkRQQkcnhl68vrm8qqbTOtJZPvsY/4UeY19lfVZU2ZLI4VLG6OnmWeNNsvBs6LRIH6UYE1H4zoVMDZuRNf5oCbUBO18dtZtfhDh36IkeoZek04711FDi23bYWPvQs/fPCbo6b5qkFlS6KlBCVqmmFKP0gjIHX47qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=wKa4Lw+a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ORjkGwu7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 093C3EC011C;
	Tue, 21 Oct 2025 23:54:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 23:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761105273; x=1761191673; bh=8G3IMbx/h0wxx0knobS4ByJnYnDzZ6paEKT
	qAGMOCN8=; b=wKa4Lw+a1f7eef/dKRVy1yKdiyzCMaO2FIpoeyiRCm+I6jAxVtX
	rokh26mQm83IKtSHXIyWPBboiMuW95ycjebrLiGY+4pSEyIyhmIKOH7Q4227kSZf
	bxym3Cv1YXKg5mjDCIdFo1y3mWySH6We6zyEQBFMd5Xuu8GLNAoHLo6vEl4KvgW4
	hlYeq8fkPj8AmiPMOLTONiCviQdq+X2uFbFWKC8vqYF2gsomIfcc8uz0RUoU2g5d
	b6l8rKz8pMsl5JWXsvuvIdeIGQg7bOsvBHim2Z1allzLPgHC31GKP9J+8iD3bL10
	fBW6DMSinTecYY7JX2g+lrpAelDCapRfpsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761105273; x=
	1761191673; bh=8G3IMbx/h0wxx0knobS4ByJnYnDzZ6paEKTqAGMOCN8=; b=O
	RjkGwu7TjZphxS27w06DiI8dzDTE0DZdPNmxqFf3SiJb3xvm7um+8074XiGQuU3E
	3zKd8nUwCag3Y8cKJFoMwVg4JWgN4ObWecnoOfdfIoXsCMAXUSdaKJXV+DjzkYOC
	tZt13/FbpdDtL4WWz3J9ueNz4U7pQ+Iof71FHVqtuMdT9egLF5hynvgmX/g41SEC
	q5wdXGjy2qKee2GfRTqq9qExgzzuDy2D9RdEeVzxnpiKz6yKhAX1PwEy7MH/iB7e
	uHHcC4zkzJkZ6p+gubpHBUCtzyMjgNfo1OTQ/Z7J5J+/qzZWu1nvlDk8j+BjHlyz
	5nlmX/d0frAAfr8stVTQw==
X-ME-Sender: <xms:eFX4aLUncByTVNHq7MBoXoDCE1pxoXK2X4TFOciSnZYc4D0ej42wYA>
    <xme:eFX4aOikef9Rj6KvzLPZMRde-SKxuo9NqeB1RxkdpPOB3IwqMiFrdVqQFBarIczHg
    B_ptYY8-YQZQAzwJK_U4JB9BJ5u1HAUgTB7ctCf3H6vZb4xXw>
X-ME-Received: <xmr:eFX4aGYd3FRqfDSbdXSXWhawuVqMDH_s9o_CTQ2KuW372ty12KUGUeuS8SsSrcZ7l7qOESXdgpVn4Yu32pK9TmCrHwauCi7rxgB6ClpDymcc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:eFX4aLos-HA3W-r-mq3RJrMVGatqOFOOOhXpViygRNc3NkF_nZKL6Q>
    <xmx:eFX4aDMDloTqABHKyyVsh0Dur4l-V8UaI-wNe0_uUUEPwJZInUd10A>
    <xmx:eFX4aOqccvalDxWmFzIy9lEyCQZE1nGWogM3oiCfq9QBEEnTPdU7Yw>
    <xmx:eFX4aAfgM8P1VhxqAEWBbuPKf_YznMa6zGSnPwzOUQaVKiWLVBzE6g>
    <xmx:eVX4aPMdRHApVcF52vBdS3Vr9_taBopLiRslYGNohlSYSV5cPXY3Zu-q>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:54:30 -0400 (EDT)
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
Subject: Re: [PATCH v2 13/14] VFS: change vfs_mkdir() to unlock on failure.
In-reply-to:
 <CAOQ4uxg6dcKRKhCiTsDEqFvKVAm4d88rWGayZNRKaYq7i7_ZkA@mail.gmail.com>
References: <20251015014756.2073439-1-neilb@ownmail.net>,
 <20251015014756.2073439-14-neilb@ownmail.net>,
 <CAOQ4uxg6dcKRKhCiTsDEqFvKVAm4d88rWGayZNRKaYq7i7_ZkA@mail.gmail.com>
Date: Wed, 22 Oct 2025 14:54:27 +1100
Message-id: <176110526740.1793333.16568205244393987794@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Oct 2025, Amir Goldstein wrote:
> On Wed, Oct 15, 2025 at 3:49=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > vfs_mkdir() already drops the reference to the dentry on failure but it
> > leaves the parent locked.
> > This complicates end_creating() which needs to unlock the parent even
> > though the dentry is no longer available.
> >
> > If we change vfs_mkdir() to unlock on failure as well as releasing the
> > dentry, we can remove the "parent" arg from end_creating() and simplify
> > the rules for calling it.
>=20
> Does this deserve a mention in filesystems/porting.rst?
> I think the change of semantics in
> c54b386969a58 VFS: Change vfs_mkdir() to return the dentry.
> was also not recorded in porting.rst.

Yes, I think you are right.  I've added that and addressed the nit
below.

Thanks,
NeilBrown


>=20
> >
> > Note that cachefiles_get_directory() can choose to substitute an error
> > instead of actually calling vfs_mkdir(), for fault injection.  In that
> > case it needs to call end_creating(), just as vfs_mkdir() now does on
> > error.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> This looks much better IMO.
>=20
> With one nit below fixed, feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>=20
> > ---
> >  fs/btrfs/ioctl.c         |  2 +-
> >  fs/cachefiles/namei.c    | 14 ++++++++------
> >  fs/ecryptfs/inode.c      |  8 ++++----
> >  fs/namei.c               |  4 ++--
> >  fs/nfsd/nfs3proc.c       |  2 +-
> >  fs/nfsd/nfs4proc.c       |  2 +-
> >  fs/nfsd/nfs4recover.c    |  2 +-
> >  fs/nfsd/nfsproc.c        |  2 +-
> >  fs/nfsd/vfs.c            |  8 ++++----
> >  fs/overlayfs/copy_up.c   |  4 ++--
> >  fs/overlayfs/dir.c       | 13 ++++++-------
> >  fs/overlayfs/super.c     |  6 +++---
> >  fs/xfs/scrub/orphanage.c |  2 +-
> >  include/linux/namei.h    | 28 +++++++++-------------------
> >  ipc/mqueue.c             |  2 +-
> >  15 files changed, 45 insertions(+), 54 deletions(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 4fbfdd8faf6a..90ef777eae25 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -935,7 +935,7 @@ static noinline int btrfs_mksubvol(struct dentry *par=
ent,
> >  out_up_read:
> >         up_read(&fs_info->subvol_sem);
> >  out_dput:
> > -       end_creating(dentry, parent);
> > +       end_creating(dentry);
> >         return ret;
> >  }
> >
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index b97a40917a32..10f010dc9946 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -130,8 +130,10 @@ struct dentry *cachefiles_get_directory(struct cache=
files_cache *cache,
> >                 ret =3D cachefiles_inject_write_error();
> >                 if (ret =3D=3D 0)
> >                         subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir)=
, subdir, 0700);
> > -               else
> > +               else {
> > +                       end_creating(subdir);
> >                         subdir =3D ERR_PTR(ret);
> > +               }
>=20
> Please match if {} else {} parenthesis
>=20
> Thanks,
> Amir.
>=20


