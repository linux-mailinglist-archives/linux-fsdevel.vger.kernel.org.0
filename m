Return-Path: <linux-fsdevel+bounces-63142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2172BAF181
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 06:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7031888475
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 04:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A4278754;
	Wed,  1 Oct 2025 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GqDPi1HB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bg59yWBt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5B842056
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 04:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759293370; cv=none; b=lTFrBHWj5MkKJR3cPeWW63dfc/RmAokPyVb42UbVUDshjq5GiUD37DES64lkNsx6m5CcmP2GnGOa/XDShmpT/edCx28ry9tqso9jXHacBdQNQcJ/UECK46tqNJX/cy4js368d1eCDSM3ioYC/wzjc73/fI4U5uUHXKIcdNfi6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759293370; c=relaxed/simple;
	bh=+lOTZhFnYpYoEDSag0JEHUkUwT9/o9cW7jLt4wnB5cI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=s09tJe3oXCLc3OsTpzOo7sIc6ADdPSldRrLz6N/y7CupZ7fiFOpkXs3mrEW6IsPZ5Mgofci2DYaRTdIYVQiVMV7nJHmtWHampxtvlF9U2w0UpjNDgV8rpEM9X6PzY57N1EQbVvCLRZ+39OrU6MkBphljWN7/wGh8dTBzUa6+LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GqDPi1HB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bg59yWBt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E637EC019E;
	Wed,  1 Oct 2025 00:36:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 00:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759293364; x=1759379764; bh=kPGDt0YBrGT63Z0WB7+OMOiSh7Vd+u90my9
	+jUucrn0=; b=GqDPi1HBKFVy470fg9QqVoLJEn6euJ95EitmMmrjD0qg8F/D8FR
	lYfeF1UXs7n0a9pC5XSZezooH+zBgdsWvCC1kx//CK4Qv7ajLe2vfkbx5+PKKsDN
	jXztr9NMd6vonGyl9AgK1uVZdosUGScP89fA1JOo9S1fwL9dFKuMB20U9GEj6W1J
	lg742WfZo53S7vFHPU9u+xLIR0AiOafHgJ8A4pNITn1c36g3WeIatNosoy0ovE6H
	ScSgQ6MDCE5pyaIUaHIPSUFNWVE7fuRl/FlumaxkB9R5raTsfGPtBvDOG4weZrQj
	udQGog23UGMZ/fZFTI3NiHLecOhTsnD94kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759293364; x=
	1759379764; bh=kPGDt0YBrGT63Z0WB7+OMOiSh7Vd+u90my9+jUucrn0=; b=B
	g59yWBt/g4aRCzO/+TPQM2WcrrHcLAUHfUu2O5RIGOrd837aNe8ElA1psIwPdqB/
	YGMXI1UGsGZXRNxVSWAJrX588Zg1SSZLXXe/hTmurZmi4eiWEqdpX0a4rANepNvg
	78jeXt9o4xbo0EhcuPIBQ/FVN4aM/Fhg40eh86J8L/JIVhJDYtWSKhS/BbkssKQ4
	2tF9GPUH99hYU9AEuipOO9uQSkGIa+wSOGPGGVpvhbUdHPlh69JmvmDHm7rlYR0f
	WzvxpVAkCHiNVl1dTi7hO3GmO/RVaxDRMQxR3vcMVh29OxkkVK8AWJgTMcDcGA7o
	Kx0O23LTzilWB9/9hXlvQ==
X-ME-Sender: <xms:tK_caDxDPDjlF2xBj4Xyw2Yfvjqw0JJSl2k-mi2gPTH27EiSi_xffQ>
    <xme:tK_caGOnkKi6AgvKIOFI0-g1WVMif4ZFQbgkGB1OxRO-gUDoP6gPUeYXJX0dQ2tLt
    c59mU5V1wxsCmLi1cDdBRgixajSn_pqCrZLpvvPaKASOREyGg>
X-ME-Received: <xmr:tK_caMWtRvMQaCn1e7rB1eH2GW8I6183M8qwSFaiuJqNNjCDQ6uPvUKM5RZk2ctKM_kGasZ0DYT0HLmSyQUg8WX1BMKNVgKvm-n3GllAmKOD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tK_caC3_oBvAdM5joV2PjEI6yy-MHEgpA_4eGgIKp8KiISqydhHhWw>
    <xmx:tK_caCrwjpeiTKE9kcOFyfCKmr5UhAdgi89rP0TqA17kbaQLD6cogA>
    <xmx:tK_caBVsCVWbPK-rI7F2lDZ2djdKS-rxKd4t5vwcPkg6B6EbKgeS_A>
    <xmx:tK_caFa3Ls3qyGqk8zTU-qV0DEmtEtx6ydSmIHHTOrZIrKauTwRIbw>
    <xmx:tK_caKJ6nfXphHsM_Il0GORPJ94c3ubxcmvK3QoRaEi4tAMkl5rMUxma>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 00:36:01 -0400 (EDT)
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
Subject: Re: [PATCH 09/11] VFS/ovl/smb: introduce start_renaming_dentry()
In-reply-to:
 <CAOQ4uxiZ=R16EN+Ha_HxgxAhE1r2vKX4Ck+H9_AfyB4a6=9=Zw@mail.gmail.com>
References: <20250926025015.1747294-1-neilb@ownmail.net>,
 <20250926025015.1747294-10-neilb@ownmail.net>,
 <CAOQ4uxiZ=R16EN+Ha_HxgxAhE1r2vKX4Ck+H9_AfyB4a6=9=Zw@mail.gmail.com>
Date: Wed, 01 Oct 2025 14:35:58 +1000
Message-id: <175929335864.1696783.9943644484099275405@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 30 Sep 2025, Amir Goldstein wrote:
> On Fri, Sep 26, 2025 at 4:51=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
> > + * On success the found dentry is stored in @rd.new_dentry and
> > + * @rd.old_parent is confirmed to be the parent of @old_dentry.  If it
> > + * was originally %NULL, it is set.  In either case a refernence is take=
n.
>=20
> Typo: %NULL, typo: refernence

%NULL isn't a typo.  As documented in kernel-doc.rst

   %CONST
   should be used to give appropriate formatting to constant.

Thanks for the refernence fix!

NeilBrown


>=20
> > + *
> > + * References and the lock can be dropped with end_renaming()
> > + *
> > + * The passed in qstr need not have the hash calculated, and basic
> > + * eXecute permission checking is performed against @rd.mnt_idmap.
> > + *
> > + * Returns: zero or an error.
> > + */
> > +int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
> > +                         struct dentry *old_dentry, struct qstr *new_las=
t)
> > +{
> > +       int err;
> > +
> > +       err =3D lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent=
);
> > +       if (err)
> > +               return err;
> > +       return __start_renaming_dentry(rd, lookup_flags, old_dentry, new_=
last);
> > +}
> > +
> >  void end_renaming(struct renamedata *rd)
> >  {
> >         unlock_rename(rd->old_parent, rd->new_parent);
> >         dput(rd->old_dentry);
> >         dput(rd->new_dentry);
> > +       dput(rd->old_parent);
> >  }
> >  EXPORT_SYMBOL(end_renaming);
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 6a31ea34ff80..3f19548b5d48 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -523,8 +523,8 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
> >  {
> >         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
> >         struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
> > -       struct dentry *index =3D NULL;
> >         struct dentry *temp =3D NULL;
> > +       struct renamedata rd =3D {};
> >         struct qstr name =3D { };
> >         int err;
> >
> > @@ -556,17 +556,15 @@ static int ovl_create_index(struct dentry *dentry, =
const struct ovl_fh *fh,
> >         if (err)
> >                 goto out;
> >
> > -       err =3D ovl_parent_lock(indexdir, temp);
> > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > +       rd.old_parent =3D indexdir;
> > +       rd.new_parent =3D indexdir;
> > +       err =3D start_renaming_dentry(&rd, 0, temp, &name);
> >         if (err)
> >                 goto out;
> > -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> > -       if (IS_ERR(index)) {
> > -               err =3D PTR_ERR(index);
> > -       } else {
> > -               err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
> > -               dput(index);
> > -       }
> > -       ovl_parent_unlock(indexdir);
> > +
> > +       err =3D ovl_do_rename_rd(&rd);
> > +       end_renaming(&rd);
> >  out:
> >         if (err)
> >                 ovl_cleanup(ofs, indexdir, temp);
> > @@ -763,7 +761,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
> >         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> >         struct inode *inode;
> >         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
> > -       struct dentry *temp, *upper, *trap;
> > +       struct renamedata rd =3D {};
> > +       struct dentry *temp;
> >         struct ovl_cu_creds cc;
> >         int err;
> >         struct ovl_cattr cattr =3D {
> > @@ -807,29 +806,27 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
> >          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
> >          * temp wasn't moved before copy up completion or cleanup.
> >          */
> > -       trap =3D lock_rename(c->workdir, c->destdir);
> > -       if (trap || temp->d_parent !=3D c->workdir) {
> > +       rd.mnt_idmap =3D ovl_upper_mnt_idmap(ofs);
> > +       rd.old_parent =3D c->workdir;
> > +       rd.new_parent =3D c->destdir;
> > +       rd.flags =3D 0;
> > +       err =3D start_renaming_dentry(&rd, 0, temp,
> > +                                   &QSTR_LEN(c->destname.name, c->destna=
me.len));
> > +       if (err =3D=3D -EINVAL || err =3D=3D -EXDEV) {
>=20
> This error code whitelist is not needed and is too fragile anyway.
> After your commit
> 9d23967b18c64 ("ovl: simplify an error path in ovl_copy_up_workdir()")
> any locking error is treated the same - it does not matter what the
> reason for lock_rename() or start_renaming_dentry() is.
>=20
> >                 /* temp or workdir moved underneath us? abort without cle=
anup */
> >                 dput(temp);
> >                 err =3D -EIO;
> > -               if (!IS_ERR(trap))
> > -                       unlock_rename(c->workdir, c->destdir);
> >                 goto out;
> >         }
>=20
> Frankly, we could get rid of the "abort without cleanup"
> comment and instead: err =3D -EIO; goto cleanup_unlocked;
> because before cleanup_unlocked, cleanup was relying on the
> lock_rename() to take the lock for the cleanup, but we don't need
> that anymore.
>=20
> To be clear, I don't think is it important to goto cleanup_unlocked,
> leaving goto out is fine because we are not very sympathetic
> to changes to underlying layers while ovl is mounted, so we should
> not really care about this cleanup, but for the sake of simpler code
> I wouldn't mind the goto cleanup_unlocked.
>=20
> > -
> > -       err =3D ovl_copy_up_metadata(c, temp);
> >         if (err)
> >                 goto cleanup;
>=20
> Is this right? should we be calling end_renaming() on error?
>=20
> Thanks,
> Amir.
>=20


