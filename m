Return-Path: <linux-fsdevel+bounces-54789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D5B03432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 03:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3FD176049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 01:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF519D88F;
	Mon, 14 Jul 2025 01:35:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAD2E630;
	Mon, 14 Jul 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752456904; cv=none; b=WV7n0xN2DP3j05mulksv5wIOx+QrHznW7w4XUWwk9TsTrBXcFW1XHHUcfM4Q1m/DOe2EXOInLX/fgLB3yQEegNifqts9BZmogn+RgIlqydZ/JCGXOIae2hsu4fLlZBCrUHQXmvQN6NMDSBrozzJRrMuSICcuHAuIuLoLVn1p85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752456904; c=relaxed/simple;
	bh=NHU1kztA7ZfgcTYXnt2QUKFhgqcNjIzYlmVZojQchaI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QiwKFIgUe8Kktdwm1f5gGNk386hMZK0kC5XyMCWwkA9HSmt6HN43NxR2rPE67FaDcoA0v6P86yCUotIkrMSin2NHMXuHgobwMAFKsUk2qEZH/XYhvC+m0POZWDKSJqnDWD/VNGXalT16Gm6Iqf8+xccsI8x/mSHws+9Wb9IIcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub85r-001w49-Cn;
	Mon, 14 Jul 2025 01:35:01 +0000
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
Subject: Re: [PATCH 15/20] ovl: narrow locking on ovl_remove_and_whiteout()
In-reply-to:
 <CAOQ4uxiv+UeEsGAihjGUajyOfX6P0QQ=xt9bMxZv+-WQM4rYjQ@mail.gmail.com>
References:
 <>, <CAOQ4uxiv+UeEsGAihjGUajyOfX6P0QQ=xt9bMxZv+-WQM4rYjQ@mail.gmail.com>
Date: Mon, 14 Jul 2025 11:35:00 +1000
Message-id: <175245690090.2234665.5628796793048465986@noble.neil.brown.name>

On Fri, 11 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > Normally it is ok to include a lookup with the subsequent operation on
> > the result.  However in this case ovl_cleanup_and_whiteout() already
> > (potentially) creates a whiteout inode so we need separate locking.
>=20
> The change itself looks fine and simple, but I didn't understand the text a=
bove.
>=20
> Can you please explain?

Maybe that was really a note to myself - at first glance the change
looked a little misguided.

While it is possible to perform the lookups outside the directory lock,
the take the lock, check the parents, perform the operation, it is
generally better to combine the lookup with the lock (hence my proposed
lookup_and_lock operations).

In the current locking scheme, performing the lookup and the operation
under the one lock avoids some races.
In my new code we don't avoid the race but the lookup-and-lock can
detect the race and repeat the lookup.

So in generally we can avoid returning the -EINVAL if the parent check
fails.

So changing code that did a lookup and rename in the same lock to code
which takes the lock twice seems wrong.  I wanted to justify it, and the
justification is the need to create the whiteout between the lookup and
the rename.

A different way to do this might be the create the whiteout before doing
the lookup_upper.  That would require a larger refactoring that probably
isn't justified.

I've changed it to:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This code:
  performs a lookup_upper
  created a whiteout object
  renames the whiteout over the result of the lookup

The create and the rename must be locked separated for proposed
directory locking changes.  This patch takes a first step of moving the
lookup out of the locked region.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/dir.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index d01e83f9d800..8580cd5c61e4 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -769,15 +769,11 @@ static int ovl_remove_and_whiteout(struct dentry *d=
entry,
> >                         goto out;
> >         }
> >
> > -       err =3D ovl_lock_rename_workdir(workdir, NULL, upperdir, NULL);
> > -       if (err)
> > -               goto out_dput;
> > -
> > -       upper =3D ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
> > -                                dentry->d_name.len);
> > +       upper =3D ovl_lookup_upper_unlocked(ofs, dentry->d_name.name, upp=
erdir,
> > +                                         dentry->d_name.len);
> >         err =3D PTR_ERR(upper);
> >         if (IS_ERR(upper))
> > -               goto out_unlock;
> > +               goto out_dput;
> >
> >         err =3D -ESTALE;
> >         if ((opaquedir && upper !=3D opaquedir) ||
> > @@ -786,6 +782,10 @@ static int ovl_remove_and_whiteout(struct dentry *de=
ntry,
> >                 goto out_dput_upper;
> >         }
> >
> > +       err =3D ovl_lock_rename_workdir(workdir, NULL, upperdir, upper);
> > +       if (err)
> > +               goto out_dput_upper;
> > +
> >         err =3D ovl_cleanup_and_whiteout(ofs, upperdir, upper);
> >         if (err)
> >                 goto out_d_drop;
> > @@ -793,10 +793,9 @@ static int ovl_remove_and_whiteout(struct dentry *de=
ntry,
> >         ovl_dir_modified(dentry->d_parent, true);
> >  out_d_drop:
> >         d_drop(dentry);
> > +       unlock_rename(workdir, upperdir);
> >  out_dput_upper:
> >         dput(upper);
> > -out_unlock:
> > -       unlock_rename(workdir, upperdir);
> >  out_dput:
> >         dput(opaquedir);
> >  out:
> > --
> > 2.49.0
> >
>=20


