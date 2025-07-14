Return-Path: <linux-fsdevel+bounces-54791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E3B0343A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 03:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088961776A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4961A317D;
	Mon, 14 Jul 2025 01:44:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067AE17B50F;
	Mon, 14 Jul 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752457471; cv=none; b=cyl0W+GRMhA6g6Oz/+gxVjCfRq1M1vl9LxwWuquB9h5ZSV5NAHMlei/DxiEbXlkHhSAGXGYTdnWRRsCiCZ90Aogp0efZYG5n1KJ1MZrCdIZ0qYiN4opmyjouMobnL7Q3/JnDE4lVe1V+WlpNEEv/ga5JAnpQnogWey80tB0eqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752457471; c=relaxed/simple;
	bh=kA9IMTjkFU32Fl82QWXLmkIFoCZ2okJoOdwmem4eKSo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ef14kMS0jSsf21m6JjIEQQAw5SmprmqB69gUETDs0uaEUJiFCJeZKGPbBFv0NGTsP7G7m+nwZWvwBsmmgxlT8cPjM6/LcngZikCtmmNzcovfC4myB/+bHOUs4FazjPuMOlMTFtlj8iTZakRrxRAKRO09A4h8zZpthLxqk0ZHUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub8F0-001w6L-Gt;
	Mon, 14 Jul 2025 01:44:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/20] ovl: narrow locking in ovl_whiteout()
In-reply-to:
 <CAOQ4uxgHAun6Z3q_adGSs0GqE+WpZfYCpXejuC3DrUS9mF2rwQ@mail.gmail.com>
References:
 <>, <CAOQ4uxgHAun6Z3q_adGSs0GqE+WpZfYCpXejuC3DrUS9mF2rwQ@mail.gmail.com>
Date: Mon, 14 Jul 2025 11:44:28 +1000
Message-id: <175245746802.2234665.6652040882873329423@noble.neil.brown.name>

On Sat, 12 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > ovl_whiteout() relies on the workdir i_rwsem to provide exclusive access
> > to ofs->whiteout which it manipulates.  Rather than depending on this,
> > add a new mutex, "whiteout_lock" to explicitly provide the required
> > locking.  Use guard(mutex) for this so that we can return without
> > needing to explicitly unlock.
> >
> > Then take the lock on workdir only when needed - to lookup the temp name
> > and to do the whiteout or link.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/dir.c       | 49 +++++++++++++++++++++-------------------
> >  fs/overlayfs/ovl_entry.h |  1 +
> >  fs/overlayfs/params.c    |  2 ++
> >  3 files changed, 29 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 086719129be3..fd89c25775bd 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -84,41 +84,44 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
> >         struct dentry *workdir =3D ofs->workdir;
> >         struct inode *wdir =3D workdir->d_inode;
> >
> > -       inode_lock_nested(wdir, I_MUTEX_PARENT);
> > +       guard(mutex)(&ofs->whiteout_lock);
> > +
> >         if (!ofs->whiteout) {
> > +               inode_lock_nested(wdir, I_MUTEX_PARENT);
> >                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> > -               if (IS_ERR(whiteout))
> > -                       goto out;
> > -
> > -               err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> > -               if (err) {
> > -                       dput(whiteout);
> > -                       whiteout =3D ERR_PTR(err);
> > -                       goto out;
> > +               if (!IS_ERR(whiteout)) {
> > +                       err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> > +                       if (err) {
> > +                               dput(whiteout);
> > +                               whiteout =3D ERR_PTR(err);
> > +                       }
> >                 }
> > +               inode_unlock(wdir);
> > +               if (IS_ERR(whiteout))
> > +                       return whiteout;
> >                 ofs->whiteout =3D whiteout;
> >         }
> >
> >         if (!ofs->no_shared_whiteout) {
> > +               inode_lock_nested(wdir, I_MUTEX_PARENT);
> >                 whiteout =3D ovl_lookup_temp(ofs, workdir);
> > -               if (IS_ERR(whiteout))
> > -                       goto out;
> > -
> > -               err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whiteout);
> > -               if (!err)
> > -                       goto out;
> > -
> > -               if (err !=3D -EMLINK) {
> > -                       pr_warn("Failed to link whiteout - disabling whit=
eout inode sharing(nlink=3D%u, err=3D%i)\n",
> > -                               ofs->whiteout->d_inode->i_nlink, err);
> > -                       ofs->no_shared_whiteout =3D true;
> > +               if (!IS_ERR(whiteout)) {
> > +                       err =3D ovl_do_link(ofs, ofs->whiteout, wdir, whi=
teout);
> > +                       if (err) {
> > +                               dput(whiteout);
> > +                               whiteout =3D ERR_PTR(err);
> > +                       }
> >                 }
> > -               dput(whiteout);
> > +               inode_unlock(wdir);
> > +               if (!IS_ERR(whiteout) || PTR_ERR(whiteout) !=3D -EMLINK)
> > +                       return whiteout;
>=20
> +               if (!IS_ERR(whiteout))
> +                       return whiteout;
>=20
> > +
> > +               pr_warn("Failed to link whiteout - disabling whiteout ino=
de sharing(nlink=3D%u, err=3D%i)\n",
> > +                       ofs->whiteout->d_inode->i_nlink, err);
> > +               ofs->no_shared_whiteout =3D true;
>=20
> Logic was changed.
> The above pr_warn and no_shared_whiteout =3D true and for the case of
> PTR_ERR(whiteout) !=3D -EMLINK
>=20
> >         }
> >         whiteout =3D ofs->whiteout;
> >         ofs->whiteout =3D NULL;
>=20
> The outcome is the same with all errors - we return and reset
> ofs->whiteout, but with EMLINK this is expected and not a warning
> with other errors unexpected and warning and we do not try again
> to hardlink to singleton whiteout.

I see that now - thanks.  I've fix up the code.

Thanks,
NeilBrown

