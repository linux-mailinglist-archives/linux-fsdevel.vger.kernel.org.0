Return-Path: <linux-fsdevel+bounces-54788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8E9B0341B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 03:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A323B9920
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 01:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82793197A76;
	Mon, 14 Jul 2025 01:08:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0540322A;
	Mon, 14 Jul 2025 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752455293; cv=none; b=JxzTsQhvXe+UJT9L2pEgJa0izZLrmYA3Nyb3E90hUD1H78yKP1exfyXkjtkN2F1pJbHXqUXdoOkGJusESXMkIF4Ya/sg2nQ56nqfXpMKfsmEmmsOtoSrkxQW8fQyGGPD7/o8oX8VZHj9RkTa1i8rx6gIR0jQK+N5olWRxfu87LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752455293; c=relaxed/simple;
	bh=h410tD+KBGS2DGEiiBS5CEWM1qF6tVRjJv+aWY0xGHY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rHy+emnxYjnKGxWKD4nMNj9PVwHUTOfjETtG7KsyvI3T4ck+q4bgKrzTug51ReGgcGpD9cDAssNy62zDdlKlhZ2sZRPtpQDw4YQOtshboCRGBcItB6J1ZRlISaV8jAlLZ3tpsszOpqiMTh4BBLw2IDMwE8YMkL6x1A1MmQoylzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ub7fs-001vvJ-8E;
	Mon, 14 Jul 2025 01:08:10 +0000
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
Subject: Re: [PATCH 11/20] ovl: narrow locking in ovl_workdir_create()
In-reply-to:
 <CAOQ4uxjwgoPAmu7M+6+-McrvnrUjYQ4eK6ZWZcLnn5RS+seArQ@mail.gmail.com>
References:
 <>, <CAOQ4uxjwgoPAmu7M+6+-McrvnrUjYQ4eK6ZWZcLnn5RS+seArQ@mail.gmail.com>
Date: Mon, 14 Jul 2025 11:08:09 +1000
Message-id: <175245528976.2234665.7568103453340576012@noble.neil.brown.name>

On Fri, 11 Jul 2025, Amir Goldstein wrote:
> On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > In ovl_workdir_create() don't hold the dir lock for the whole time, but
> > only take it when needed.
> >
> > It now gets taken separately for ovl_workdir_cleanup().  A subsequent
> > patch will move the locking into that function.
> >
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/overlayfs/super.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 9cce3251dd83..239ae1946edf 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >         int err;
> >         bool retried =3D false;
> >
> > -       inode_lock_nested(dir, I_MUTEX_PARENT);
> >  retry:
> > +       inode_lock_nested(dir, I_MUTEX_PARENT);
> >         work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(nam=
e));
> >
> >         if (!IS_ERR(work)) {
> > @@ -311,23 +311,27 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
> >
> >                 if (work->d_inode) {
> >                         err =3D -EEXIST;
> > +                       inode_unlock(dir);
> >                         if (retried)
> >                                 goto out_dput;
> >
> >                         if (persist)
> > -                               goto out_unlock;
> > +                               goto out;
> >
> >                         retried =3D true;
> > +                       inode_lock_nested(dir, I_MUTEX_PARENT);
>=20
> Feels like this should be parent_lock(ofs->workbasedir, work)
> and parent_lock(ofs->workbasedir, NULL) in retry:

Agreed.

>=20
> >                         err =3D ovl_workdir_cleanup(ofs, dir, mnt, work, =
0);
> > +                       inode_unlock(dir);
> >                         dput(work);
> >                         if (err =3D=3D -EINVAL) {
> >                                 work =3D ERR_PTR(err);
> > -                               goto out_unlock;
> > +                               goto out;
> >                         }
> >                         goto retry;
> >                 }
> >
> >                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> > +               inode_unlock(dir);
> >                 err =3D PTR_ERR(work);
> >                 if (IS_ERR(work))
> >                         goto out_err;
> > @@ -365,11 +369,11 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
> >                 if (err)
> >                         goto out_dput;
> >         } else {
> > +               inode_unlock(dir);
> >                 err =3D PTR_ERR(work);
> >                 goto out_err;
> >         }
> > -out_unlock:
> > -       inode_unlock(dir);
> > +out:
> >         return work;
> >
> >  out_dput:
> > @@ -378,7 +382,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
> >         pr_warn("failed to create directory %s/%s (errno: %i); mounting r=
ead-only\n",
> >                 ofs->config.workdir, name, -err);
> >         work =3D NULL;
> > -       goto out_unlock;
> > +       goto out;
>=20
> might as well be return NULL now.

Done.  I got rid of the out: label completely.

NeilBrown

>=20
> Thanks,
> Amir.
>=20


