Return-Path: <linux-fsdevel+bounces-53588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF285AF08A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 04:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B66A3A3828
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F661B9831;
	Wed,  2 Jul 2025 02:41:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0C1A073F;
	Wed,  2 Jul 2025 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424078; cv=none; b=mdfn69DFuS6u9BW2yEIWIDKsuFALL7s7TNFN669ON/2PK8jHopaQr2mPS2eW+fyfhtcHQyGpH/33uC057ltXkFRt/av1QYApFe/3rhXsPlKPzCUnlEmSsBbYatLNoYTzYFTuTbKDdiu5yL4YQB9z08kJA+COgwWQai3np/ilZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424078; c=relaxed/simple;
	bh=OPeA+BsDemhwchfDqKqEbF1sDn0Oyu6hJ4f1rl1/E9k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=j5sJMyDJjnvNwOB9HiY7cjeI4AhuAT/U9jRz0nfU4xr4HugQ3n2GLVJ/OlrQKKnkcBtjnkGxCk6a46EkXQRu40BelH/s8mXsnzQShsFpYV9jomUtq2EzUk6xxiUfdgt1emvzU5DKQWRD5hxMf7RWGyqb1asPi5ZWa+Kn/9fRV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWnPN-00GIZE-BL;
	Wed, 02 Jul 2025 02:41:13 +0000
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
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/12] ovl: narrow locking in ovl_check_rename_whiteout()
In-reply-to:
 <CAOQ4uxgbhgGHcW+x1F=9Fo5T6ALjADC9SJhzp_mSooqUb8_6sA@mail.gmail.com>
References:
 <>, <CAOQ4uxgbhgGHcW+x1F=9Fo5T6ALjADC9SJhzp_mSooqUb8_6sA@mail.gmail.com>
Date: Wed, 02 Jul 2025 12:41:13 +1000
Message-id: <175142407307.565058.17313140186618695058@noble.neil.brown.name>

On Thu, 26 Jun 2025, Amir Goldstein wrote:
> On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > ovl_check_rename_whiteout() now only holds the directory lock when
> > needed, and takes it again if necessary.
> >
> > This makes way for future changes where locks are taken on individual
> > dentries rather than the whole directory.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/super.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 3583e359655f..8331667b8101 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -554,7 +554,6 @@ static int ovl_get_upper(struct super_block *sb, stru=
ct ovl_fs *ofs,
> >  static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
> >  {
> >         struct dentry *workdir =3D ofs->workdir;
> > -       struct inode *dir =3D d_inode(workdir);
> >         struct dentry *temp;
> >         struct dentry *dest;
> >         struct dentry *whiteout;
> > @@ -571,19 +570,22 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
> >         err =3D PTR_ERR(dest);
> >         if (IS_ERR(dest)) {
> >                 dput(temp);
> > -               goto out_unlock;
> > +               unlock_rename(workdir, workdir);
> > +               goto out;
>=20
> dont use unlock_rename hack please

The lock was taken for the purpose of doing a rename.  So using
lock_rename and unlock_rename documents that.  I can use the less
informative "inode_lock" if you prefer.

> and why not return err?

Some people like to only have a single "return" in a function.  Some are
comfortable with more.  I guess I wasn't sure where you stood.

>=20
> >         }
> >
> >         /* Name is inline and stable - using snapshot as a copy helper */
> >         take_dentry_name_snapshot(&name, temp);
> >         err =3D ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_W=
HITEOUT);
> > +       unlock_rename(workdir, workdir);
> >         if (err) {
> >                 if (err =3D=3D -EINVAL)
> >                         err =3D 0;
> >                 goto cleanup_temp;
> >         }
> >
> > -       whiteout =3D ovl_lookup_upper(ofs, name.name.name, workdir, name.=
name.len);
> > +       whiteout =3D ovl_lookup_upper_unlocked(ofs, name.name.name,
> > +                                            workdir, name.name.len);
> >         err =3D PTR_ERR(whiteout);
> >         if (IS_ERR(whiteout))
> >                 goto cleanup_temp;
> > @@ -592,18 +594,16 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
> >
> >         /* Best effort cleanup of whiteout and temp file */
> >         if (err)
> > -               ovl_cleanup(ofs, dir, whiteout);
> > +               ovl_cleanup_unlocked(ofs, workdir, whiteout);
> >         dput(whiteout);
> >
> >  cleanup_temp:
> > -       ovl_cleanup(ofs, dir, temp);
> > +       ovl_cleanup_unlocked(ofs, workdir, temp);
> >         release_dentry_name_snapshot(&name);
> >         dput(temp);
> >         dput(dest);
> >
> > -out_unlock:
> > -       unlock_rename(workdir, workdir);
> > -
> > +out:
> >         return err;
> >  }
>=20
> I dont see the point in creating those out goto targets
> that just return err.
> I do not mind keeping them around if they use to do something and now
> they don't or when replacing goto out_unlock with goto out,
> but that is not the case here.

I'll get rid of them then.

Thanks,
NeilBrown


>=20
> Thanks,
> Amir.
>=20


