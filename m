Return-Path: <linux-fsdevel+bounces-29778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B6D97DBC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 07:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E661C20DD8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 05:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40313B284;
	Sat, 21 Sep 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWNFLEiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C12F30;
	Sat, 21 Sep 2024 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726896796; cv=none; b=b4bCQPsapzsXPViYGQM3Gk33GLLjdtpTIU7fPXRVZ6Rye9Dogi7M/DuTrbqhG/Ho/SbTSkR0G6/VtvvZw/RSlejQnh61hUt5tPX7Hssg2CDl+rI66nJQSPJbp+ptbyyxPCgWlBIERMKAHoJZha8o47JW1SR7s12jokuix2PIBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726896796; c=relaxed/simple;
	bh=7mNHM1PwqPWlBf/USyGytS+Z9q6v1ayx5JI91uUoCzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IllZSjVMT9oK8O755LpoTR37hF4aVT6Ca/ht0WUZABYptwQ9i1IhXw2LRayzK6C8hXqytEfiTSe5eN2UgWsp2m2OUcHrcArXU5HM9ySeYCHcWdHpfDsY9tUmIBPtdIKDIldtJHf4OnnYKbf+TdzSWm57fagXDblIgRoJP3rwCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWNFLEiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACA2C4CEC2;
	Sat, 21 Sep 2024 05:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726896796;
	bh=7mNHM1PwqPWlBf/USyGytS+Z9q6v1ayx5JI91uUoCzA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uWNFLEiUAiVl0riHd4qvExFUrNSlSbqWp2ntR7JTaRkNzYjr4Wk5Vw0CpJMAXlOZo
	 N/KNFGzBqXSCg7yvHa8blKTX/Ef7yaYI3XN9fbopWD3f/KdvXmrbL46VcFdDDHyumG
	 hIMwdawYkv+eA3PawILj4UPnqhNV0hnwjePjYGCoigNg9sIsBbYhuLeQXjiMWDXgju
	 4V9P4/bv+zJDcMNysPy7tVc/LpKJ2+fKKETryt+g/HihB+fayQ8FAy11p6u17b5fxa
	 k5NvqwiGgM3k7gwJuLriEGTekKSY1Ry9qZlNkIUCeV+l8Si4dh0KvxgoulYMFBFehd
	 mQ8SwPcplS2+g==
Message-ID: <8aa01edea8972c1bde3b34df32f9db72e29420ed.camel@kernel.org>
Subject: Re: [RFC PATCH 2/2] fs: open_by_handle_at() support for decoding
 connectable file handles
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai
 <cyphar@cyphar.com>,  Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Sat, 21 Sep 2024 07:33:12 +0200
In-Reply-To: <CAOQ4uxjkN2WgT8QJeeZfbRCqrTMED+PtYEXrkDmWjh0iw+PGGw@mail.gmail.com>
References: <20240919140611.1771651-1-amir73il@gmail.com>
	 <20240919140611.1771651-3-amir73il@gmail.com>
	 <784e439e0319bf0c3fbb0b92361a99ee2d78ac9f.camel@kernel.org>
	 <CAOQ4uxjkN2WgT8QJeeZfbRCqrTMED+PtYEXrkDmWjh0iw+PGGw@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 18:38 +0200, Amir Goldstein wrote:
> On Fri, Sep 20, 2024 at 6:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Thu, 2024-09-19 at 16:06 +0200, Amir Goldstein wrote:
> > > Allow using an O_PATH fd as mount fd argument of open_by_handle_at(2)=
.
> > > This was not allowed before, so we use it to enable a new API for
> > > decoding "connectable" file handles that were created using the
> > > AT_HANDLE_CONNECTABLE flag to name_to_handle_at(2).
> > >=20
> > > When mount fd is an O_PATH fd and decoding an O_PATH fd is requested,
> > > use that as a hint to try to decode a "connected" fd with known path,
> > > which is accessible (to capable user) from mount fd path.
> > >=20
> > > Note that this does not check if the path is accessible to the callin=
g
> > > user, just that it is accessible wrt the mount namesapce, so if there
> > > is no "connected" alias, or if parts of the path are hidden in the
> > > mount namespace, open_by_handle_at(2) will return -ESTALE.
> > >=20
> > > Note that the file handles used to decode a "connected" fd do not hav=
e
> > > to be encoded with the AT_HANDLE_CONNECTABLE flag.  Specifically,
> > > directory file handles are always "connectable", regardless of using
> > > the AT_HANDLE_CONNECTABLE flag.
> > >=20
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/fhandle.c | 61 +++++++++++++++++++++++++++++++-------------------=
--
> > >  1 file changed, 37 insertions(+), 24 deletions(-)
> > >=20
> >=20
> > The mountfd is only used to get a path, so I don't see a problem with
> > allowing that to be an O_PATH fd.
> >=20
> > I'm less keen on using the fact that mountfd is an O_PATH fd to change
> > the behaviour of open_by_handle_at(). That seems very subtle. Is there
> > a good reason to do it that way instead of just declaring a new AT_*
> > flag for this?
> >=20
>=20
> Not sure if it is a good reason, but open_by_handle_at() has an O_ flags
> argument, not an AT_ flags argument...
>=20
> If my hack API is not acceptable then we will need to add
> open_by_handle_at2(), with struct open_how argument or something.
>=20

Oh right, I forgot that open_by_handle_at doesn't take AT_* flags.
A new syscall may be best then.

I can see a couple of other potential approaches:

1/ You could add a new fcntl() cmd that puts the mountfd into a
"connectable filehandles" mode. The downside there is that it'd take 2
syscalls to do your open.

2/ You could add flags to open_how that make openat2() behave like
open_by_handle_at(). Add a flag that allows "pathname" to point to a
filehandle instead, and a second flag that indicates that the fh is
connectable.

Both of those are pretty hacky though.

> >=20
> > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > index 956d9b25d4f7..1fabfb79fd55 100644
> > > --- a/fs/fhandle.c
> > > +++ b/fs/fhandle.c
> > > @@ -146,37 +146,45 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, co=
nst char __user *, name,
> > >       return err;
> > >  }
> > >=20
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
> > >=20
> > >       return 0;
> > >  }
> > >=20
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
> > >=20
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
> >=20
> > I don't quite understand why the above change is necessary. Can you
> > explain why we need to limit this only to the case where
> > EXPORT_FH_DIR_ONLY is set?
> >=20
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
Jeff Layton <jlayton@kernel.org>

