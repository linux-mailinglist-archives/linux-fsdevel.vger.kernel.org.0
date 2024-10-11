Return-Path: <linux-fsdevel+bounces-31723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B255A99A623
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D8BB2424D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7375217902;
	Fri, 11 Oct 2024 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwclqwX4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE42184;
	Fri, 11 Oct 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656305; cv=none; b=KFBxy2PH3g6rKal+QjsY3XhhUt/aF3Qva2OsyjQE0YtOtnRSaTxdWRETGTDqSgAACXMROQz6MfjwZ05NeVURQ77px4Fg+6h5H3c0g5Hq/xM5dt9kodb7h4Hj9DVYwnrn3glXGKqF9WDL2ERfcGs5TyACOc8M5BXA80gXC3Rqu6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656305; c=relaxed/simple;
	bh=+8YToAqNQ6r0+MJdP9iaP2R0AZsZ1p2fl1SITz1MhAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6qMo7SqtWFAspNvtjd7er+nP3B4AOpdzHfPiJNJ0tfRk1GPWZPX+0q+P8RlvvgA6AIlo2gBdBEuXZVQHU5+4m0vP2uY5tVo+RbuYbXZf5uQF1xahtTYN8OPAsfo0pmrAtIzAEYEYs0TCcwP5u23yDpO8YmcS87ECR+zCgHU2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwclqwX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF97C4CEC3;
	Fri, 11 Oct 2024 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728656304;
	bh=+8YToAqNQ6r0+MJdP9iaP2R0AZsZ1p2fl1SITz1MhAM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gwclqwX4m6Y8sTh4EXGTab14Votq/M83mXfcywJzEAygN+pMybNgPAxqbCLKm2cMu
	 ixvoZHmpAcskjSzwPzcjd8DUVWnqv0D6H7Hp676vxdPvW5lZjW0gMfeeJfMz4FB0Dx
	 x+ckt9CijByGo2CZy+u+h+M1pRyMvDSy8TLmu1zZZSIOJdZCNE3u+x0rgM0qweR3UU
	 ZfBprt2yO2pqv6O+/LZpbjs9L4lkxNULVhOJ4BCCAlg42wxHLGiXuLnHHPD1gPZsJv
	 IMbuHS8WuDHsaG5SBlVg7qqrFqFHVQZ8YvcWS5qFtDLFtg43wmkZo/pLL0drdUt5ib
	 GdgJ4trnNk4Tg==
Message-ID: <5ce49036cedbf7fa78a1395ded031fe2c0935e32.camel@kernel.org>
Subject: Re: [PATCH v4 2/3] fs: name_to_handle_at() support for "explicit
 connectable" file handles
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa
 Sarai <cyphar@cyphar.com>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Date: Fri, 11 Oct 2024 10:18:23 -0400
In-Reply-To: <CAOQ4uxgO5rNpsctjdKvJyy7Li7Di4x8AaRahVk5F8_tjgx1V=A@mail.gmail.com>
References: <20241011090023.655623-1-amir73il@gmail.com>
	 <20241011090023.655623-3-amir73il@gmail.com>
	 <3fad10839da31f8f8b08fe355612da39a610b111.camel@kernel.org>
	 <CAOQ4uxgO5rNpsctjdKvJyy7Li7Di4x8AaRahVk5F8_tjgx1V=A@mail.gmail.com>
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

On Fri, 2024-10-11 at 16:14 +0200, Amir Goldstein wrote:
> On Fri, Oct 11, 2024 at 4:00=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > On Fri, 2024-10-11 at 11:00 +0200, Amir Goldstein wrote:
> > > nfsd encodes "connectable" file handles for the subtree_check feature=
,
> > > which can be resolved to an open file with a connected path.
> > > So far, userspace nfs server could not make use of this functionality=
.
> > >=20
> > > Introduce a new flag AT_HANDLE_CONNECTABLE to name_to_handle_at(2).
> > > When used, the encoded file handle is "explicitly connectable".
> > >=20
> > > The "explicitly connectable" file handle sets bits in the high 16bit =
of
> > > the handle_type field, so open_by_handle_at(2) will know that it need=
s
> > > to open a file with a connected path.
> > >=20
> > > old kernels will now recognize the handle_type with high bits set,
> > > so "explicitly connectable" file handles cannot be decoded by
> > > open_by_handle_at(2) on old kernels.
> > >=20
> > > The flag AT_HANDLE_CONNECTABLE is not allowed together with either
> > > AT_HANDLE_FID or AT_EMPTY_PATH.
> > >=20
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/fhandle.c               | 48 ++++++++++++++++++++++++++++++++++--=
--
> > >  include/linux/exportfs.h   |  2 ++
> > >  include/uapi/linux/fcntl.h |  1 +
> > >  3 files changed, 46 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > index 218511f38cbb..8339a1041025 100644
> > > --- a/fs/fhandle.c
> > > +++ b/fs/fhandle.c
> > > @@ -31,6 +31,14 @@ static long do_sys_name_to_handle(const struct pat=
h *path,
> > >       if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh=
_flags))
> > >               return -EOPNOTSUPP;
> > >=20
> > > +     /*
> > > +      * A request to encode a connectable handle for a disconnected =
dentry
> > > +      * is unexpected since AT_EMPTY_PATH is not allowed.
> > > +      */
> > > +     if (fh_flags & EXPORT_FH_CONNECTABLE &&
> > > +         WARN_ON(path->dentry->d_flags & DCACHE_DISCONNECTED))
> >=20
> > Is this even possible? The dentry in this case will have been reached
> > by pathwalk. Oh, but I guess the dfd could point to a disconnected
> > dentry and then you pass in AT_EMPTY_PATH.
>=20
> But see comment above "...is unexpected since AT_EMPTY_PATH is not allowe=
d."
>=20
> and see below
>=20
> +        * AT_EMPTY_PATH could be used along with a dfd that refers to a
> +        * disconnected non-directory, which cannot be used to encode a
> +        * connectable file handle, because its parent is unknown.
> +        */
> +       if (flag & AT_HANDLE_CONNECTABLE &&
> +           flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
>                 return -EINVAL;
>=20
> The code/API should not allow this also for a malicious user,
> unless I missed something, hence, the assertion.
>=20

Ok. If that's the case, I'm fine with this as-is then. If that ever
fires then I guess we'll know that something is wrong.

> >=20
> > I'm not sure we want to warn in that case though, since this is a
> > situation that an unprivileged user could be able to arrange. Maybe we
> > should just return a more distinct error code in this case?
> >=20
> > Since the scenario involves a dfd that is disconnected, how about:
> >=20
> >     #define EBADFD          77      /* File descriptor in bad state */
> >=20
>=20
> To me it does not look like a good fit, but let's see what others think.
> In the end, it is a rare condition that should never happen
> (hence assert), so I don't think the error value matters that much?
>=20

Agreed.

> > > +             return -EINVAL;
> > > +
> > >       if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
> > >               return -EFAULT;
> > >=20
> > > @@ -45,7 +53,7 @@ static long do_sys_name_to_handle(const struct path=
 *path,
> > >       /* convert handle size to multiple of sizeof(u32) */
> > >       handle_dwords =3D f_handle.handle_bytes >> 2;
> > >=20
> > > -     /* we ask for a non connectable maybe decodeable file handle */
> > > +     /* Encode a possibly decodeable/connectable file handle */
> > >       retval =3D exportfs_encode_fh(path->dentry,
> > >                                   (struct fid *)handle->f_handle,
> > >                                   &handle_dwords, fh_flags);
> > > @@ -67,8 +75,23 @@ static long do_sys_name_to_handle(const struct pat=
h *path,
> > >                * non variable part of the file_handle
> > >                */
> > >               handle_bytes =3D 0;
> > > -     } else
> > > +     } else {
> > > +             /*
> > > +              * When asked to encode a connectable file handle, enco=
de this
> > > +              * property in the file handle itself, so that we later=
 know
> > > +              * how to decode it.
> > > +              * For sanity, also encode in the file handle if the en=
coded
> > > +              * object is a directory and verify this during decode,=
 because
> > > +              * decoding directory file handles is quite different t=
han
> > > +              * decoding connectable non-directory file handles.
> > > +              */
> > > +             if (fh_flags & EXPORT_FH_CONNECTABLE) {
> > > +                     handle->handle_type |=3D FILEID_IS_CONNECTABLE;
> > > +                     if (d_is_dir(path->dentry))
> > > +                             fh_flags |=3D FILEID_IS_DIR;
> > > +             }
> > >               retval =3D 0;
> > > +     }
> > >       /* copy the mount id */
> > >       if (unique_mntid) {
> > >               if (put_user(real_mount(path->mnt)->mnt_id_unique,
> > > @@ -109,15 +132,30 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, co=
nst char __user *, name,
> > >  {
> > >       struct path path;
> > >       int lookup_flags;
> > > -     int fh_flags;
> > > +     int fh_flags =3D 0;
> > >       int err;
> > >=20
> > >       if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID =
|
> > > -                  AT_HANDLE_MNT_ID_UNIQUE))
> > > +                  AT_HANDLE_MNT_ID_UNIQUE | AT_HANDLE_CONNECTABLE))
> > > +             return -EINVAL;
> > > +
> > > +     /*
> > > +      * AT_HANDLE_FID means there is no intention to decode file han=
dle
> > > +      * AT_HANDLE_CONNECTABLE means there is an intention to decode =
a
> > > +      * connected fd (with known path), so these flags are conflicti=
ng.
> > > +      * AT_EMPTY_PATH could be used along with a dfd that refers to =
a
> > > +      * disconnected non-directory, which cannot be used to encode a
> > > +      * connectable file handle, because its parent is unknown.
> > > +      */
> > > +     if (flag & AT_HANDLE_CONNECTABLE &&
> >=20
> > nit: might need parenthesis around the above & check.
> >=20
> > > +         flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
>=20
> I don't think it is needed, but for readability I don't mind adding them.
> I am having a hard time remembering the operation precedence  myself,
> but this one is clear to me so I don't bother with ().

I (lately) get warnings from the compiler with W=3D1 even when the
precedence is fine. If you're not seeing that then this is OK too.

--=20
Jeff Layton <jlayton@kernel.org>

