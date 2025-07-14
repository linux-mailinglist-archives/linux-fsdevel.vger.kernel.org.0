Return-Path: <linux-fsdevel+bounces-54787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A08B03412
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 03:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC84E1899CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 01:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225B1624DD;
	Mon, 14 Jul 2025 01:03:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A21FC3;
	Mon, 14 Jul 2025 01:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752455013; cv=none; b=MvGsfblWjjHxZpOVrtpWrlOHTgzq2ICT1x1hW6zbSa4n20JSpN0v8mAyoM5sYoswAO90hMim2fXDoH0mDkOAC0T6k5an6q53rjFsjhBqaC0URhGhLuzjV7+gOYUefulkB89xPe4NlYDcmDrw3ODz09Wxyys/07NW3m+b778SXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752455013; c=relaxed/simple;
	bh=dPyovoIeHrIBwdhwUyTn8OGw1AhPl7ztDOh0GV4T+S0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=L/hfLbEDwabcuE7Jtk02n6xjYksK0QgXF67a5ZZ/op4N1Zq2/MKADdUeTbfEIeoKOPIwvIj1npFaDBAx2UeRpMikjDUxZoqwMtN1HX8WA8IBTbEVvH58FJ0MPT/rHjxZDt1jfvmw+T9xI+s1L7MfFxjgGss6+gC4icrll3QEMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub7bM-001vtw-Nq;
	Mon, 14 Jul 2025 01:03:30 +0000
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
Subject: Re: [PATCH 10/20] ovl: narrow locking in ovl_cleanup_index()
In-reply-to:
 <CAOQ4uxht32aHnM2K3rD_sBjJLkONf-zzNbGZUq34a8hH5qhLkA@mail.gmail.com>
References:
 <>, <CAOQ4uxht32aHnM2K3rD_sBjJLkONf-zzNbGZUq34a8hH5qhLkA@mail.gmail.com>
Date: Mon, 14 Jul 2025 11:03:30 +1000
Message-id: <175245501025.2234665.14337443312049915168@noble.neil.brown.name>

On Fri, 11 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > ovl_cleanup_index() takes a lock on the directory and then does a lookup
> > and possibly one of two different cleanups.
> > This patch narrows the locking to use the _unlocked() versions of the
> > lookup and one cleanup, and just takes the lock for the other cleanup.
> >
> > A subsequent patch will take the lock into the cleanup.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/util.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 9ce9fe62ef28..7369193b11ec 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -1107,21 +1107,20 @@ static void ovl_cleanup_index(struct dentry *dent=
ry)
> >                 goto out;
> >         }
> >
> > -       inode_lock_nested(dir, I_MUTEX_PARENT);
> > -       index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> > +       index =3D ovl_lookup_upper_unlocked(ofs, name.name, indexdir, nam=
e.len);
> >         err =3D PTR_ERR(index);
> >         if (IS_ERR(index)) {
> >                 index =3D NULL;
> >         } else if (ovl_index_all(dentry->d_sb)) {
> >                 /* Whiteout orphan index to block future open by handle */
> > +               inode_lock_nested(dir, I_MUTEX_PARENT);
>=20
> Don't we need to verify that index wasn't moved with
> parent_lock(indexdi, index)?

Yes, thanks.  I've change it to use lock_parent() (or whatever we end up
calling it).

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20
> >                 err =3D ovl_cleanup_and_whiteout(OVL_FS(dentry->d_sb),
> >                                                indexdir, index);
> > +               inode_unlock(dir);
> >         } else {
> >                 /* Cleanup orphan index entries */
> > -               err =3D ovl_cleanup(ofs, dir, index);
> > +               err =3D ovl_cleanup_unlocked(ofs, indexdir, index);
> >         }
> > -
> > -       inode_unlock(dir);
> >         if (err)
> >                 goto fail;
> >
> > --
> > 2.49.0
> >
>=20


