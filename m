Return-Path: <linux-fsdevel+bounces-54784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4803B03396
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 02:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9231894E50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3CD4A00;
	Mon, 14 Jul 2025 00:14:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625371FC3;
	Mon, 14 Jul 2025 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752452064; cv=none; b=t45+JXBeurNSKHd/T01x+O4gYemccaKDGSXsZ1uzkzbQYlpVgY8pukRs/AX4kEmQSnyViqeuIQ3zianBtplvP0TVF0oxXHn18bKZ3Lyy6p3meyQTzCTDAsGW1HaZIyhimQp7fDFpfkns3/+2YbEFDo0rKe03wWXwRTX4iTR6+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752452064; c=relaxed/simple;
	bh=B4uvuZjZtqiEu5m/Y4kmddyCY0yi3DreReig0VGrr0g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YL89qWRGzNy6tvRL8QfLhigcWK1JCv5WB/HiIPgr4Dr3O2iOwpyGPU3IH+m97asllQyBMQxAILPH64llcy5AuPSltfXyPxIfAG5eohlmuO+5e9rT1BliQTDRUNxNK8YdMov1vCrfp9JhExEsQzCCZYLybGNjC9WVfoVAwiiXtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub6pm-001vhe-P4;
	Mon, 14 Jul 2025 00:14:20 +0000
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
Subject:
 Re: [PATCH 02/20] ovl: change ovl_create_index() to take write and dir locks
In-reply-to:
 <CAOQ4uxjHzRpGKe+YR4=79OOT0gwAKJox_2BPjeuhkbr9jk8rWg@mail.gmail.com>
References:
 <>, <CAOQ4uxjHzRpGKe+YR4=79OOT0gwAKJox_2BPjeuhkbr9jk8rWg@mail.gmail.com>
Date: Mon, 14 Jul 2025 10:14:20 +1000
Message-id: <175245206026.2234665.11538239462276106357@noble.neil.brown.name>

On Fri, 11 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > ovl_copy_up_workdir() currently take a rename lock on two directories,
> > then use the lock to both create a file in one directory, perform a
> > rename, and possibly unlink the file for cleanup.  This is incompatible
> > with proposed changes which will lock just the dentry of objects being
> > acted on.
> >
> > This patch moves the call to ovl_create_index() earlier in
> > ovl_copy_up_workdir() to before the lock is taken, and also before write
> > access to the filesystem is gained (this last is not strictly necessary
> > but seems cleaner).
>=20
> With my proposed change to patch 1, ovl_create_index() will be
> called with ovl_start_write() held so you wont need to add it.
>=20
> >
> > ovl_create_index() then take the requires locks and drops them before
> > returning.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
>=20
> With that fixed, feel free to add:
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Done - thanks.

NeilBrown


>=20
> Thanks,
> Amir.
>=20
> > ---
> >  fs/overlayfs/copy_up.c | 24 +++++++++++++++---------
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index 5d21b8d94a0a..25be0b80a40b 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -517,8 +517,6 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struc=
t dentry *upper,
> >
> >  /*
> >   * Create and install index entry.
> > - *
> > - * Caller must hold i_mutex on indexdir.
> >   */
> >  static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *=
fh,
> >                             struct dentry *upper)
> > @@ -550,7 +548,10 @@ static int ovl_create_index(struct dentry *dentry, c=
onst struct ovl_fh *fh,
> >         if (err)
> >                 return err;
> >
> > +       ovl_start_write(dentry);
> > +       inode_lock(dir);
> >         temp =3D ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
> > +       inode_unlock(dir);
> >         err =3D PTR_ERR(temp);
> >         if (IS_ERR(temp))
> >                 goto free_name;
> > @@ -559,6 +560,9 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
> >         if (err)
> >                 goto out;
> >
> > +       err =3D parent_lock(indexdir, temp);
> > +       if (err)
> > +               goto out;
> >         index =3D ovl_lookup_upper(ofs, name.name, indexdir, name.len);
> >         if (IS_ERR(index)) {
> >                 err =3D PTR_ERR(index);
> > @@ -566,9 +570,11 @@ static int ovl_create_index(struct dentry *dentry, c=
onst struct ovl_fh *fh,
> >                 err =3D ovl_do_rename(ofs, indexdir, temp, indexdir, inde=
x, 0);
> >                 dput(index);
> >         }
> > +       parent_unlock(indexdir);
> >  out:
> >         if (err)
> > -               ovl_cleanup(ofs, dir, temp);
> > +               ovl_cleanup_unlocked(ofs, indexdir, temp);
> > +       ovl_end_write(dentry);
> >         dput(temp);
> >  free_name:
> >         kfree(name.name);
> > @@ -797,6 +803,12 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
> >         if (err)
> >                 goto cleanup_need_write;
> >
> > +       if (S_ISDIR(c->stat.mode) && c->indexed) {
> > +               err =3D ovl_create_index(c->dentry, c->origin_fh, temp);
> > +               if (err)
> > +                       goto cleanup_need_write;
> > +       }
> > +
> >         /*
> >          * We cannot hold lock_rename() throughout this helper, because of
> >          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
> > @@ -818,12 +830,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
> >         if (err)
> >                 goto cleanup;
> >
> > -       if (S_ISDIR(c->stat.mode) && c->indexed) {
> > -               err =3D ovl_create_index(c->dentry, c->origin_fh, temp);
> > -               if (err)
> > -                       goto cleanup;
> > -       }
> > -
> >         upper =3D ovl_lookup_upper(ofs, c->destname.name, c->destdir,
> >                                  c->destname.len);
> >         err =3D PTR_ERR(upper);
> > --
> > 2.49.0
> >
>=20


