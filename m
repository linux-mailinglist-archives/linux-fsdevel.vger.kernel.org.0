Return-Path: <linux-fsdevel+bounces-29782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9946F97DC53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D6B282B3B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C8155753;
	Sat, 21 Sep 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="GShYYeh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F08D13C9C4;
	Sat, 21 Sep 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726910008; cv=none; b=PGNs+fdjkaDc9WjPLaONB/gzU2StyZvmhAxQgsMRgS7tLcvpPVAm9W9irO2wVS7FzeT2UqmLx53eYSytBcIM6gsFSPyUgQiNo3lU/BJIvAxizb6PddCndflfHPFJGkKX8hqWogQSvFJTGXTrecwbMwDccWfsajMWW1XM+CJCMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726910008; c=relaxed/simple;
	bh=pNM10KwtOjlR9c3K2EPCYqchgOsybjtW6PkTtqB2Onk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2SWBA0RvsKFojv3NaStVzh2YpuAzfP4LQ4GguZ9jecWs4BDBHoszyeK5pLIPanB3l5HtG7KmZ1RMlXrPou1qUHaarCVA5nXounZVu8yv89Aws9l2aGwYPUI7XSx8c0UdaOSkSDswqWgQufO9r3zQtU3p9/J7M5G/QaPU9MWbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=GShYYeh5; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X9k7j1QBmz9slx;
	Sat, 21 Sep 2024 11:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1726910001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHbCgsbDnxl1mMAQ7XWVI+PsqjdCNiWEmdhc7L5q30k=;
	b=GShYYeh5xGR+krYvOY3MaG39YgLBUPxA7PukH0Ga1PK+xGlkNl81WJuS2MtNLKeQ37Qs0K
	Ntfmauqtn5bgkL+Qr1brb4ulGX9kGXtXdUyeV7grt1bynLZl4Qd4Nt4gUKW5NPiXblw+sD
	5Jd2B2/v4uDhY6KTa28LLuLBFWca9Svn5Fs3j+3fD7SDjbTrlyIMLl7bY2kEeg37GV9Oaz
	td35+DxWcWkkki872qYuUU25nNDDT+rtMPemMHs+DYlM0cwcF71rJ3ZyZfh1DX3qfwz7p2
	enQwFIxK1Nu6BvI0KDtp5uwy7gHkM9kbcpO8EcjS+owtYyZXbUmgcMhjKU6BFQ==
Date: Sat, 21 Sep 2024 11:13:07 +0200
From: Aleksa Sarai <cyphar@cyphar.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] fs: open_by_handle_at() support for decoding
 connectable file handles
Message-ID: <20240921.091141-stupid.droplet.blank.gavels-w1NCi5Yx37LX@cyphar.com>
References: <20240919140611.1771651-1-amir73il@gmail.com>
 <20240919140611.1771651-3-amir73il@gmail.com>
 <784e439e0319bf0c3fbb0b92361a99ee2d78ac9f.camel@kernel.org>
 <CAOQ4uxjkN2WgT8QJeeZfbRCqrTMED+PtYEXrkDmWjh0iw+PGGw@mail.gmail.com>
 <8aa01edea8972c1bde3b34df32f9db72e29420ed.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rfthctmypwivc4q"
Content-Disposition: inline
In-Reply-To: <8aa01edea8972c1bde3b34df32f9db72e29420ed.camel@kernel.org>
X-Rspamd-Queue-Id: 4X9k7j1QBmz9slx


--6rfthctmypwivc4q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-21, Jeff Layton <jlayton@kernel.org> wrote:
> On Fri, 2024-09-20 at 18:38 +0200, Amir Goldstein wrote:
> > On Fri, Sep 20, 2024 at 6:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >=20
> > > On Thu, 2024-09-19 at 16:06 +0200, Amir Goldstein wrote:
> > > > Allow using an O_PATH fd as mount fd argument of open_by_handle_at(=
2).
> > > > This was not allowed before, so we use it to enable a new API for
> > > > decoding "connectable" file handles that were created using the
> > > > AT_HANDLE_CONNECTABLE flag to name_to_handle_at(2).
> > > >=20
> > > > When mount fd is an O_PATH fd and decoding an O_PATH fd is requeste=
d,
> > > > use that as a hint to try to decode a "connected" fd with known pat=
h,
> > > > which is accessible (to capable user) from mount fd path.
> > > >=20
> > > > Note that this does not check if the path is accessible to the call=
ing
> > > > user, just that it is accessible wrt the mount namesapce, so if the=
re
> > > > is no "connected" alias, or if parts of the path are hidden in the
> > > > mount namespace, open_by_handle_at(2) will return -ESTALE.
> > > >=20
> > > > Note that the file handles used to decode a "connected" fd do not h=
ave
> > > > to be encoded with the AT_HANDLE_CONNECTABLE flag.  Specifically,
> > > > directory file handles are always "connectable", regardless of using
> > > > the AT_HANDLE_CONNECTABLE flag.
> > > >=20
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/fhandle.c | 61 +++++++++++++++++++++++++++++++-----------------=
----
> > > >  1 file changed, 37 insertions(+), 24 deletions(-)
> > > >=20
> > >=20
> > > The mountfd is only used to get a path, so I don't see a problem with
> > > allowing that to be an O_PATH fd.
> > >=20
> > > I'm less keen on using the fact that mountfd is an O_PATH fd to change
> > > the behaviour of open_by_handle_at(). That seems very subtle. Is there
> > > a good reason to do it that way instead of just declaring a new AT_*
> > > flag for this?
> > >=20
> >=20
> > Not sure if it is a good reason, but open_by_handle_at() has an O_ flags
> > argument, not an AT_ flags argument...
> >=20
> > If my hack API is not acceptable then we will need to add
> > open_by_handle_at2(), with struct open_how argument or something.
> >=20
>=20
> Oh right, I forgot that open_by_handle_at doesn't take AT_* flags.
> A new syscall may be best then.
>=20
> I can see a couple of other potential approaches:
>=20
> 1/ You could add a new fcntl() cmd that puts the mountfd into a
> "connectable filehandles" mode. The downside there is that it'd take 2
> syscalls to do your open.
>=20
> 2/ You could add flags to open_how that make openat2() behave like
> open_by_handle_at(). Add a flag that allows "pathname" to point to a
> filehandle instead, and a second flag that indicates that the fh is
> connectable.

Hackiness aside, the latter is not workable until we can filter
extensible structs with seccomp. Container runtimes all block
open_by_handle_at(2) because it can be used to break out of non-userns
containers.

> Both of those are pretty hacky though.
>=20
> > >=20
> > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > index 956d9b25d4f7..1fabfb79fd55 100644
> > > > --- a/fs/fhandle.c
> > > > +++ b/fs/fhandle.c
> > > > @@ -146,37 +146,45 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, =
const char __user *, name,
> > > >       return err;
> > > >  }
> > > >=20
> > > > -static int get_path_from_fd(int fd, struct path *root)
> > > > +enum handle_to_path_flags {
> > > > +     HANDLE_CHECK_PERMS   =3D (1 << 0),
> > > > +     HANDLE_CHECK_SUBTREE =3D (1 << 1),
> > > > +};
> > > > +
> > > > +struct handle_to_path_ctx {
> > > > +     struct path root;
> > > > +     enum handle_to_path_flags flags;
> > > > +     unsigned int fh_flags;
> > > > +     unsigned int o_flags;
> > > > +};
> > > > +
> > > > +static int get_path_from_fd(int fd, struct handle_to_path_ctx *ctx)
> > > >  {
> > > >       if (fd =3D=3D AT_FDCWD) {
> > > >               struct fs_struct *fs =3D current->fs;
> > > >               spin_lock(&fs->lock);
> > > > -             *root =3D fs->pwd;
> > > > -             path_get(root);
> > > > +             ctx->root =3D fs->pwd;
> > > > +             path_get(&ctx->root);
> > > >               spin_unlock(&fs->lock);
> > > >       } else {
> > > > -             struct fd f =3D fdget(fd);
> > > > +             struct fd f =3D fdget_raw(fd);
> > > >               if (!f.file)
> > > >                       return -EBADF;
> > > > -             *root =3D f.file->f_path;
> > > > -             path_get(root);
> > > > +             ctx->root =3D f.file->f_path;
> > > > +             path_get(&ctx->root);
> > > > +             /*
> > > > +              * Use O_PATH mount fd and requested O_PATH fd as a h=
int for
> > > > +              * decoding an fd with connected path, that is access=
ible from
> > > > +              * the mount fd path.
> > > > +              */
> > > > +             if (ctx->o_flags & O_PATH && f.file->f_mode & FMODE_P=
ATH)
> > > > +                     ctx->flags |=3D HANDLE_CHECK_SUBTREE;
> > > >               fdput(f);
> > > >       }
> > > >=20
> > > >       return 0;
> > > >  }
> > > >=20
> > > > -enum handle_to_path_flags {
> > > > -     HANDLE_CHECK_PERMS   =3D (1 << 0),
> > > > -     HANDLE_CHECK_SUBTREE =3D (1 << 1),
> > > > -};
> > > > -
> > > > -struct handle_to_path_ctx {
> > > > -     struct path root;
> > > > -     enum handle_to_path_flags flags;
> > > > -     unsigned int fh_flags;
> > > > -};
> > > > -
> > > >  static int vfs_dentry_acceptable(void *context, struct dentry *den=
try)
> > > >  {
> > > >       struct handle_to_path_ctx *ctx =3D context;
> > > > @@ -224,7 +232,13 @@ static int vfs_dentry_acceptable(void *context=
, struct dentry *dentry)
> > > >=20
> > > >       if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d =3D=3D root)
> > > >               retval =3D 1;
> > > > -     WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root);
> > > > +     /*
> > > > +      * exportfs_decode_fh_raw() does not call acceptable() callba=
ck with
> > > > +      * a disconnected directory dentry, so we should have reached=
 either
> > > > +      * mount fd directory or sb root.
> > > > +      */
> > > > +     if (ctx->fh_flags & EXPORT_FH_DIR_ONLY)
> > > > +             WARN_ON_ONCE(d !=3D root && d !=3D root->d_sb->s_root=
);
> > >=20
> > > I don't quite understand why the above change is necessary. Can you
> > > explain why we need to limit this only to the case where
> > > EXPORT_FH_DIR_ONLY is set?
> > >=20
> >=20
> > With EXPORT_FH_DIR_ONLY, exportfs_decode_fh_raw() should
> > only be calling acceptable() with a connected directory dentry.
> >=20
> > Until this patch, vfs_dentry_acceptable() would only be called with
> > EXPORT_FH_DIR_ONLY so the WARN_ON could be unconditional.
> >=20
> > After this patch, vfs_dentry_acceptable() could also be called for
> > a disconnected non-dir dentry and then it should just fail to
> > accept the dentry, but should not WARN_ON.
> >=20
> > Thanks for the review!
> > Amir.
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6rfthctmypwivc4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZu6OHwAKCRAol/rSt+lE
b+LXAP9Qr05YgJ+MsmbDt8Z+6mSgnSPQsGrhbsoBkSX/WMVnlAEA1mjpyOZPuuyG
n6YRjjv0qC/27DF2iBTLiLNYSAyXzgc=
=HAhx
-----END PGP SIGNATURE-----

--6rfthctmypwivc4q--

