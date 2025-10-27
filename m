Return-Path: <linux-fsdevel+bounces-65657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1EFC0BB0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 03:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55C134E3E77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 02:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3032D24A9;
	Mon, 27 Oct 2025 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ee45DJBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K90SEpy9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C22D0C9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761532432; cv=none; b=KchGv2dWMPYY9P1RMGCiozaDSdNj2b8Y5vYpzJkFjTs+qVGBj5ROEzIpTCMyhXk6k9YbvBYXVhOi8/oKpU0ZklegyjjAQ09wg/jQiBDDvVSdtNx1pLmmolJqY/QKMjAfzRBvQ4bCLBNkQXmm9IDZWlppq0DAHQdclTjNRvh36o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761532432; c=relaxed/simple;
	bh=4jLOJeKfjgn7UtvseeXi8T2gF3suh1k+jted3n193vk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=izJnO7AtHtBflg1aS+WSx9BESeHG6YVSBImzrnVEpSKaNp8KkrJWJIGqBw+zfqxEqT0P0PJj8Neqv8kWWQWfdt3xETkJ+jlRNxTzqEu6qn7Y2FQUKT/93FhZRIt3FnOypoz/bVyBzK1bvnwhCnDeTrRDTbSLo+fAQF/eMHy7VqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ee45DJBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K90SEpy9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8075D14001EA;
	Sun, 26 Oct 2025 22:33:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 26 Oct 2025 22:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1761532427; x=1761618827; bh=NbhNftDem6iWehLet/HgR1Ua5tVf4PJKIM2
	73tdAETk=; b=Ee45DJBMRN0vbNfiBp/JSsEJ+jHS+xAzq8/oCxxf8vFUvKDfFvo
	ZVOqKcaC6z3TpGIhIdPIBLJz1BlVVd8v+wmOlb25ltip6Giql1Vb+II9VKNfVM1F
	rZWooWU8fTsQUzuC6uxx3kJNQziSv3ZY6sOxc6lhqyxo+uN2Us/bgTAvuj/j3MoJ
	9gv5TWpHgFp5hHXlthZu8PR1MOfIbdYMWPDCkyd4Rebz92WtXhYM8CDk+mUeIdOf
	/h0g5/t1xten/t784G6ssWJPUM0bv059qXYDwN39wn01hr5s+Yp/m/IagUrTXD/9
	lch6GRDTM4fM171WFrc36OQGTAUdjefg7HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761532427; x=
	1761618827; bh=NbhNftDem6iWehLet/HgR1Ua5tVf4PJKIM273tdAETk=; b=K
	90SEpy9V+hn5IYJfkAoTlmcZnYV1YMhgKPcoyepAIbezpBjchbKzCtCTbJxZWHDD
	bA8VznRMdvn7thYh2FYHoOYLKyCnMHtfN0oBcu7/XYXGKuf/LmDntLzNraASx5Kq
	5gQuzQU5BZMpFhhySOcLFELJQNMES71n0AZLi2X9Svnw+bVWQXGQ/8RK2o8H4Zj1
	TckOKxNGFXJplOen6qEYeuUFuKmLMLdRdVu38Y5i5PsJJ7amO7HvfIL9IyfpcZTA
	tbPIIR0/r6iJz+iy4+dO7WorSQIhmwbTy3Y090eWHlkoWU2jygB0FtrEjLedu7hL
	9V4M2SqyV8+6ZOlEoR2Tg==
X-ME-Sender: <xms:C9r-aAgB3KYJ7dqUyi4M8h5Rhyga2u_Kvx3QQosWvFg7xcqmk0kG2w>
    <xme:C9r-aD-_KScpzkkTBGZwVpHfwyTQYVjS6ANTpED1tecNg4F5U9aRbUwQ3AS_hLJFj
    pTi7deNzRTXLJ2-mp-3s3gaIr3lx47wRPytXFGOEb0hatseyg>
X-ME-Received: <xmr:C9r-aHF-tSz0IAWymkecX3tiGQQpYEp-zQR4SiMoBZrZ2zOVW-LOvumFt4xq6AOKABDfa8l60yyjyalW3ZxxOksFX91eAc94X6LnGDdXzqx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheeijeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:C9r-aGlg2qUOkBWP6ciBjumhM5iQ6hJ5HKNkWaY8Fsk4qDumHfNpQA>
    <xmx:C9r-aLY-qarTtndzdmibaPPmJCm-4rgTzWo3uq1BhxGfgBO8NOzfgA>
    <xmx:C9r-aLGl3uq4iTBPOSsn4c0AA8XgnwzaC6oCIpggwwSuAWc_5xsn2w>
    <xmx:C9r-aMJmio53DwtKWxCmbdinShxde8IsKGq-tQFeMGd2LyKLzELxQw>
    <xmx:C9r-aI7dNPa4kfcyfkYtDbn1VyhxIVQ5sATY7rw7d_WlRFK_9tXY2-5U>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Oct 2025 22:33:45 -0400 (EDT)
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
Subject: Re: [PATCH v3 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 end_renaming()
In-reply-to:
 <CAOQ4uxgzceK-RJd3rN8pBSBf1Oo0u8wd6KSfdiKQSTF1RUuzXw@mail.gmail.com>
References: <20251022044545.893630-1-neilb@ownmail.net>,
 <20251022044545.893630-10-neilb@ownmail.net>,
 <CAOQ4uxhExX9SiKVRyf=GHhNy-f8O=KH-oDS3=efLinXC8E=ekA@mail.gmail.com>,
 <CAOQ4uxgzceK-RJd3rN8pBSBf1Oo0u8wd6KSfdiKQSTF1RUuzXw@mail.gmail.com>
Date: Mon, 27 Oct 2025 13:33:36 +1100
Message-id: <176153241680.1793333.14890183364964784556@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 25 Oct 2025, Amir Goldstein wrote:
> On Wed, Oct 22, 2025 at 12:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Wed, Oct 22, 2025 at 6:47=E2=80=AFAM NeilBrown <neilb@ownmail.net> wro=
te:
> > >
> > > From: NeilBrown <neil@brown.name>
> > >
> > > start_renaming() combines name lookup and locking to prepare for rename.
> > > It is used when two names need to be looked up as in nfsd and overlayfs=
 -
> > > cases where one or both dentries are already available will be handled
> > > separately.
> > >
> > > __start_renaming() avoids the inode_permission check and hash
> > > calculation and is suitable after filename_parentat() in do_renameat2().
> > > It subsumes quite a bit of code from that function.
> > >
> > > start_renaming() does calculate the hash and check X permission and is
> > > suitable elsewhere:
> > > - nfsd_rename()
> > > - ovl_rename()
> > >
> > > In ovl, ovl_do_rename_rd() is factored out of ovl_do_rename(), which
> > > itself will be gone by the end of the series.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > >
> > > --
> > > Changes since v2:
> > >  - in __start_renaming() some label have been renamed, and err
> > >    is always set before a "goto out_foo" rather than passing the
> > >    error in a dentry*.
> > >  - ovl_do_rename() changed to call the new ovl_do_rename_rd() rather
> > >    than keeping duplicate code
> > >  - code around ovl_cleanup() call in ovl_rename() restructured.
> >
> > Thanks for fixing those and for the change log.
> >
> > Feel free to add:
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> ...
> > > @@ -1299,18 +1285,22 @@ static int ovl_rename(struct mnt_idmap *idmap, =
struct inode *olddir,
> > >                 err =3D ovl_set_redirect(new, samedir);
> > >         else if (!overwrite && new_is_dir && !new_opaque &&
> > >                  ovl_type_merge(old->d_parent))
> > > -               err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
> > > +               err =3D ovl_set_opaque_xerr(new, rd.new_dentry, -EXDEV);
> > >         if (err)
> > >                 goto out_unlock;
> > >
> > > -       err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
> > > -                           new_upperdir, newdentry, flags);
> > > -       unlock_rename(new_upperdir, old_upperdir);
> > > +       err =3D ovl_do_rename_rd(&rd);
> > > +
> > > +       if (!err && cleanup_whiteout)
> > > +               whiteout =3D dget(rd.new_dentry);
> > > +
> > > +       end_renaming(&rd);
> > > +
> > >         if (err)
> > >                 goto out_revert_creds;
> > >
> > > -       if (cleanup_whiteout)
> > > -               ovl_cleanup(ofs, old_upperdir, newdentry);
> > > +       if (whiteout)
> > > +               ovl_cleanup(ofs, old_upperdir, whiteout);
>=20
> missing
>                        dput(whiteout);

Doh =3D of course.  Thanks.

NeilBrown


>                  }
>=20
> This fixes the dentry leak I reported.
>=20
> Thanks,
> Amir.
>=20


