Return-Path: <linux-fsdevel+bounces-29783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BCD97DC59
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 11:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71CE1F21F3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65961547E1;
	Sat, 21 Sep 2024 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="0sicksh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CC1BDDF;
	Sat, 21 Sep 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726910176; cv=none; b=s7slnllYvDEnQ/CE9erv3CaAo5Dine0Mw+TL54GHcZ0exUWvuKvjbRHlwYYzsZ1d3zijhUXbA889PIZyiBh1BXTTe4UOLH4po+VMZ7kXhnLb7dsnMijld4C+ZJSXXgZkwpxauftG+d1Fyg7KWMY+LCCxzxzjbnRBxy/XUc/x1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726910176; c=relaxed/simple;
	bh=BePoVzKiaxek61qylns0PTuYom+ae0wIHISUm0gPPU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G20tvY6bKbmRmQQ82uWoJJb6p2R+HtkF++VQ8bFeO8dbMnFbR88LKbZfNuxeM24qSnl5RQOt9aKktKoPR/0cr/qYG8RyZMjg8rvz9SbHdiM2fZSmWGrItcz36uiLBy3yZ4JU0zN4suBcI63oys9U+G5vVSGJypn3CGXWALsf1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=0sicksh2; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X9kBy3PYZz9shh;
	Sat, 21 Sep 2024 11:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1726910170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fLpn3BaVK6IxNsmQokm97DGxKZVzxbP/qbH692tMuw=;
	b=0sicksh2KxMJWAWXSV9tzS9yKv5VzBChTdoAzHysW1/bvvGpAU7xMouvsDi2Rja4zP8Yda
	Q9cPS4d6qR4ICAmGDlRmetOvF/M5B0qI3VCq7/oWGSJWfoJ7hfPoS/PlAOAZ8L169jge0Z
	FTRcw8nP1EBoG8UObX5DcmVtl0h8RC3p7tPbjUVzGnJnyGtOGLhpAiJHJ/ONsOBNkLRExx
	CQfWMkTgETFXP/L3ZX90L7K9k4nw0tQ3Yv8NdGHLTKO5WSjyWmwTqToNFpIVval08c1Gp8
	NnZjwCHzOxyz3wy0EDmMPJA/ng1H1lbPOViZ52c4s5KQFEr9hd8ZXmsUpAz6Zg==
Date: Sat, 21 Sep 2024 11:15:58 +0200
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] fs: open_by_handle_at() support for decoding
 connectable file handles
Message-ID: <20240921.091326-painless.info.basic.shim-TQFR4LPWlFqc@cyphar.com>
References: <20240919140611.1771651-1-amir73il@gmail.com>
 <20240919140611.1771651-3-amir73il@gmail.com>
 <784e439e0319bf0c3fbb0b92361a99ee2d78ac9f.camel@kernel.org>
 <CAOQ4uxjkN2WgT8QJeeZfbRCqrTMED+PtYEXrkDmWjh0iw+PGGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npdq67u2aepslxfh"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjkN2WgT8QJeeZfbRCqrTMED+PtYEXrkDmWjh0iw+PGGw@mail.gmail.com>


--npdq67u2aepslxfh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-20, Amir Goldstein <amir73il@gmail.com> wrote:
> On Fri, Sep 20, 2024 at 6:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Thu, 2024-09-19 at 16:06 +0200, Amir Goldstein wrote:
> > > Allow using an O_PATH fd as mount fd argument of open_by_handle_at(2).
> > > This was not allowed before, so we use it to enable a new API for
> > > decoding "connectable" file handles that were created using the
> > > AT_HANDLE_CONNECTABLE flag to name_to_handle_at(2).
> > >
> > > When mount fd is an O_PATH fd and decoding an O_PATH fd is requested,
> > > use that as a hint to try to decode a "connected" fd with known path,
> > > which is accessible (to capable user) from mount fd path.
> > >
> > > Note that this does not check if the path is accessible to the calling
> > > user, just that it is accessible wrt the mount namesapce, so if there
> > > is no "connected" alias, or if parts of the path are hidden in the
> > > mount namespace, open_by_handle_at(2) will return -ESTALE.
> > >
> > > Note that the file handles used to decode a "connected" fd do not have
> > > to be encoded with the AT_HANDLE_CONNECTABLE flag.  Specifically,
> > > directory file handles are always "connectable", regardless of using
> > > the AT_HANDLE_CONNECTABLE flag.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/fhandle.c | 61 +++++++++++++++++++++++++++++++-------------------=
--
> > >  1 file changed, 37 insertions(+), 24 deletions(-)
> > >
> >
> > The mountfd is only used to get a path, so I don't see a problem with
> > allowing that to be an O_PATH fd.
> >
> > I'm less keen on using the fact that mountfd is an O_PATH fd to change
> > the behaviour of open_by_handle_at(). That seems very subtle. Is there
> > a good reason to do it that way instead of just declaring a new AT_*
> > flag for this?
> >
>=20
> Not sure if it is a good reason, but open_by_handle_at() has an O_ flags
> argument, not an AT_ flags argument...
>=20
> If my hack API is not acceptable then we will need to add
> open_by_handle_at2(), with struct open_how argument or something.

Does all of the stuff in openat2 make sense for open_by_handle_at? What
should RESOLVE_* or mode do? There's no standard namei lookup done.

> > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > index 956d9b25d4f7..1fabfb79fd55 100644
> > > --- a/fs/fhandle.c
> > > +++ b/fs/fhandle.c
> > > @@ -146,37 +146,45 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, co=
nst char __user *, name,
> > >       return err;
> > >  }
> > >
> > > -static int get_path_from_fd(int fd, struct path *root)
> > > +enum handle_to_path_flags {
> > > +     HANDLE_CHECK_PERMS   =3D (1 << 0),
> > > +     HANDLE_CHECK_SUBTREE =3D (1 << 1),
> > > +};
> > > +
> > > +struct handle_to_path_ctx {
> > > +     struct path root;
> > > +     enum handle_to_path_flags flags;
> > > +     unsigned int fh_flags;
> > > +     unsigned int o_flags;
> > > +};
> > > +
> > > +static int get_path_from_fd(int fd, struct handle_to_path_ctx *ctx)
> > >  {
> > >       if (fd =3D=3D AT_FDCWD) {
> > >               struct fs_struct *fs =3D current->fs;
> > >               spin_lock(&fs->lock);
> > > -             *root =3D fs->pwd;
> > > -             path_get(root);
> > > +             ctx->root =3D fs->pwd;
> > > +             path_get(&ctx->root);
> > >               spin_unlock(&fs->lock);
> > >       } else {
> > > -             struct fd f =3D fdget(fd);
> > > +             struct fd f =3D fdget_raw(fd);
> > >               if (!f.file)
> > >                       return -EBADF;
> > > -             *root =3D f.file->f_path;
> > > -             path_get(root);
> > > +             ctx->root =3D f.file->f_path;
> > > +             path_get(&ctx->root);
> > > +             /*
> > > +              * Use O_PATH mount fd and requested O_PATH fd as a hin=
t for
> > > +              * decoding an fd with connected path, that is accessib=
le from
> > > +              * the mount fd path.
> > > +              */
> > > +             if (ctx->o_flags & O_PATH && f.file->f_mode & FMODE_PAT=
H)
> > > +                     ctx->flags |=3D HANDLE_CHECK_SUBTREE;
> > >               fdput(f);
> > >       }
> > >
> > >       return 0;
> > >  }
> > >
> > > -enum handle_to_path_flags {
> > > -     HANDLE_CHECK_PERMS   =3D (1 << 0),
> > > -     HANDLE_CHECK_SUBTREE =3D (1 << 1),
> > > -};
> > > -
> > > -struct handle_to_path_ctx {
> > > -     struct path root;
> > > -     enum handle_to_path_flags flags;
> > > -     unsigned int fh_flags;
> > > -};
> > > -
> > >  static int vfs_dentry_acceptable(void *context, struct dentry *dentr=
y)
> > >  {
> > >       struct handle_to_path_ctx *ctx =3D context;
> > > @@ -224,7 +232,13 @@ static int vfs_dentry_acceptable(void *context, =
struct dentry *dentry)
> > >
> > >       if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d =3D=3D root)
> > >               retval =3D 1;
> > > -     WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
> > > +     /*
> > > +      * exportfs_decode_fh_raw() does not call acceptable() callback=
 with
> > > +      * a disconnected directory dentry, so we should have reached e=
ither
> > > +      * mount fd directory or sb root.
> > > +      */
> > > +     if (ctx->fh_flags & EXPORT_FH_DIR_ONLY)
> > > +             WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
> >
> > I don't quite understand why the above change is necessary. Can you
> > explain why we need to limit this only to the case where
> > EXPORT_FH_DIR_ONLY is set?
> >
>=20
> With EXPORT_FH_DIR_ONLY, exportfs_decode_fh_raw() should
> only be calling acceptable() with a connected directory dentry.
>=20
> Until this patch, vfs_dentry_acceptable() would only be called with
> EXPORT_FH_DIR_ONLY so the WARN_ON could be unconditional.
>=20
> After this patch, vfs_dentry_acceptable() could also be called for
> a disconnected non-dir dentry and then it should just fail to
> accept the dentry, but should not WARN_ON.
>=20
> Thanks for the review!
> Amir.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--npdq67u2aepslxfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZu6OzgAKCRAol/rSt+lE
bzj4AP4myRGBP9LQoXtW0mdZm/eNwEsaShJPCTTsaAzdHzUM6QEAgt9ia3VWP865
3fMS9XVsnI38mTgAVtlQkPoeAtIHMwE=
=3S7C
-----END PGP SIGNATURE-----

--npdq67u2aepslxfh--

