Return-Path: <linux-fsdevel+bounces-54785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCD0B0339A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 02:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885E61757C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 00:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2AC12BF24;
	Mon, 14 Jul 2025 00:29:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA68282E1;
	Mon, 14 Jul 2025 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752452964; cv=none; b=UkTJXRoNiG86X//weiYgJi3B3Hsmf2eQRof1QZ/sCjYmwOP+EO06m8eu3OE44hbEIVE7dVK8htUTxbC1XYFp53aiG9hEP5k4lM0BiGUvfDxaJ1l64Ki0HQ1CAz650n8Yj9wk6nx1YUcyeF9a3Pdpw6ULSlt9BpBy/6Txkcwc7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752452964; c=relaxed/simple;
	bh=S/yu4UkmmNP0w7NDnZoGJATYwygsPeEuXTtZUkek3mk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ezcD44zrAM38+R35DoMVA2xd4mt3vi8IZLbhiytrtNb2F6r5vNksi/AkAw+BdHHB9CLZtlFjddRJxNgSFgN5N5KBmBFcB1TrptEEh19TgR++kD1+AJSaExZFrYpWll+jIwki1sCOt1t7JE4Uxfft614ZpuQma51yfNHCh282XR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub74J-001vk3-2d;
	Mon, 14 Jul 2025 00:29:20 +0000
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
 Re: [PATCH 04/20] ovl: narrow the locked region in ovl_copy_up_workdir()
In-reply-to:
 <CAOQ4uxih6o7-3ESpktvP1YPVtaY4TKxO+WVmUEnE4ocQEPZE8Q@mail.gmail.com>
References:
 <>, <CAOQ4uxih6o7-3ESpktvP1YPVtaY4TKxO+WVmUEnE4ocQEPZE8Q@mail.gmail.com>
Date: Mon, 14 Jul 2025 10:29:20 +1000
Message-id: <175245296059.2234665.16015222685656399679@noble.neil.brown.name>

On Fri, 11 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > In ovl_copy_up_workdir() unlock immediately after the rename, and then
> > use ovl_cleanup_unlocked() with separate locking rather than using the
> > same lock to protect both.
> >
> > This makes way for future changes where locks are taken on individual
> > dentries rather than the whole directory.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/copy_up.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index eafb46686854..7b84a39c081f 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -765,7 +765,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
> >  {
> >         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
> >         struct inode *inode;
> > -       struct inode *wdir =3D d_inode(c->workdir);
> >         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
> >         struct dentry *temp, *upper, *trap;
> >         struct ovl_cu_creds cc;
> > @@ -816,9 +815,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
> >                 /* temp or workdir moved underneath us? abort without cle=
anup */
> >                 dput(temp);
> >                 err =3D -EIO;
> > -               if (IS_ERR(trap))
> > -                       goto out;
> > -               goto unlock;
> > +               if (!IS_ERR(trap))
> > +                       unlock_rename(c->workdir, c->destdir);
> > +               goto out;
>=20
> I now see that this bit was missing from my proposed patch 1
> variant, but with this in patch 1, this patch becomes trivial.

I missed that too :-)
As you say - nice and trivial here now.

NeilBrown


>=20
> Thanks,
> Amir.
>=20
> >         }
> >
> >         err =3D ovl_copy_up_metadata(c, temp);
> > @@ -832,9 +831,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
> >                 goto cleanup;
> >
> >         err =3D ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0=
);
> > +       unlock_rename(c->workdir, c->destdir);
> >         dput(upper);
> >         if (err)
> > -               goto cleanup;
> > +               goto cleanup_unlocked;
> >
> >         inode =3D d_inode(c->dentry);
> >         if (c->metacopy_digest)
> > @@ -848,17 +848,17 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
> >         ovl_inode_update(inode, temp);
> >         if (S_ISDIR(inode->i_mode))
> >                 ovl_set_flag(OVL_WHITEOUTS, inode);
> > -unlock:
> > -       unlock_rename(c->workdir, c->destdir);
> >  out:
> >         ovl_end_write(c->dentry);
> >
> >         return err;
> >
> >  cleanup:
> > -       ovl_cleanup(ofs, wdir, temp);
> > +       unlock_rename(c->workdir, c->destdir);
> > +cleanup_unlocked:
> > +       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> >         dput(temp);
> > -       goto unlock;
> > +       goto out;
> >
> >  cleanup_need_write:
> >         ovl_start_write(c->dentry);
> > --
> > 2.49.0
> >
>=20


