Return-Path: <linux-fsdevel+bounces-31365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DE9957CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 21:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63843288C0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F1212D16;
	Tue,  8 Oct 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpnW9GOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9D1E0489;
	Tue,  8 Oct 2024 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728416636; cv=none; b=ti3O14kTB17leLg8GBp40bU9aFmoeisF6oLRDhRZ2Pi4QFZZhOejdWfDsLx4v7EFlKIsdAoqtfs8RluLNqODz5LIGxwJiRZsmpSUpM9NWR/pQCG9PgKOLt99vUftPeUJr84LblxsIINIBtn1TPRHlscAvEtGACrvdPIR2FTYefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728416636; c=relaxed/simple;
	bh=eVEvm04Io1YQmLb2Xtc1LArgKobBkhWH8oeheCDpQmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSCSvjrpRN3Z522VCMzWoIUGETCaQzrlbK8jeS+LxW5+T7u+mEROZh/QmGGFa1uf9Z/kr847Fc51DQ9N9X5xxvd3aNtriaWfJ6MmM19dNv6Rriu2mQy2FYQ+aLjip5uHM/ywIe3ynNeyn+SuvdRFKGunor+JiB2QhvHq/G636GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpnW9GOV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9ad15d11bso517377385a.0;
        Tue, 08 Oct 2024 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728416633; x=1729021433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjtpduuowLXeUNjo6HDl8oEEXH8JFe/e3kxm7IbFFYA=;
        b=lpnW9GOVfKqZJhoTaAiGb7xPbyudhAwZ49Nvst1yPlposHTRdW+IJKbVp8FS7n7YuS
         0gS/mEuSB33mRJXOFVcU4yKzJXoDQs/Rl4xjQahPpP1FURzZNXnVx87jJQpFOlU2OFuj
         zUx44qx8v7q9COUrngdFcp1IwQ4Gkd6ywEbxVfoZs3scgU6ccjX0+h1W5mIvwb0p6p3y
         wUnUf4L5IBQEY6zvpgxTtI6VCu9CiTsmPcJ6d5v3vSVTJ5K7xzQkcpM+hnZKHe9eAPM7
         F66KCnZDrqnlrZyb0/JaA0CxL31hayxHF+rSyWSf5uy33DuemA6UnUAOgdE82dUwzYB1
         5HxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728416633; x=1729021433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjtpduuowLXeUNjo6HDl8oEEXH8JFe/e3kxm7IbFFYA=;
        b=FN2pjE577PBikHMOazL9rpEaAJgtZD+CxYeHaH2jMJBKPqahvhjOTozZJBmF82Oagl
         +8m0dlWKwzCXx1KWPJOGj3hoso2Pnbev1WV7C7wxYmptmHF/U1vCf6cYFbvR40amcWBs
         seJx2N//NUi4jGt5ZAiVEqp2lbhMXMKBAiHf2frRvL5ly1k8lG39FIF5iDhqpei6p7/N
         053CWw0rtv68Xht/NU/hreHKVHTVpAFZGHv01xZqCLTKmOMD+P0CzOnhCHvbRnGezwJ3
         fC/taKvUAGxb2APoEdiQ6XjzzNc5mNejYEMjkwtPFIApNNhFcBetosGHpuNPMJGH+dlZ
         /VtA==
X-Forwarded-Encrypted: i=1; AJvYcCVTDLHE5wagchVOsvzozeyIsAcnUWT2dhDzd5ivLnXDHMSgom7hGiL7rdTSo9wTvmDZpQVBJoWknl+f@vger.kernel.org, AJvYcCX5UYMstYgGPqtftrOD1aOZqPI3VH+r5GRBwdPfL7TU1r6VEJ/QWtRz3H3cVucvSZMgqfHN1IdnE0V2X6Y4@vger.kernel.org
X-Gm-Message-State: AOJu0YybhrqQRVy3NE2iw8nXycO5Rvvd0+ZdHEPx15Yemkj45D8PgJ64
	/3aF328Kx0qgn2Da0YsYzlDumvCsx7qCSkwUKyt9H6xAB9xF7OsqeH6G4ebK98VJ9Uf06oPVG3f
	KF0p4fzNYFJccF5qt5jNafyQcTZM=
X-Google-Smtp-Source: AGHT+IFoDlGlgbU1snNhZR97kaktxaigPM7PG0cqTH3dV3CgjrDQzvolszI1NYR922sbJn7DH63IdBAE5OEYNqOx7o0=
X-Received: by 2002:a05:620a:15e:b0:7af:cf2e:197b with SMTP id
 af79cd13be357-7afcf2e1a5fmr120579285a.21.1728416633322; Tue, 08 Oct 2024
 12:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008152118.453724-1-amir73il@gmail.com> <20241008152118.453724-3-amir73il@gmail.com>
 <a990a33d58e922381dec54a7748995d3e773b5b3.camel@kernel.org>
In-Reply-To: <a990a33d58e922381dec54a7748995d3e773b5b3.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 8 Oct 2024 21:43:41 +0200
Message-ID: <CAOQ4uxhAf3tFUi85W4WHtKw3dTEtM+41jOQPC6EKn6QTtALRJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: name_to_handle_at() support for "explicit
 connectable" file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:31=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-10-08 at 17:21 +0200, Amir Goldstein wrote:
> > nfsd encodes "connectable" file handles for the subtree_check feature,
> > which can be resolved to an open file with a connected path.
> > So far, userspace nfs server could not make use of this functionality.
> >
> > Introduce a new flag AT_HANDLE_CONNECTABLE to name_to_handle_at(2).
> > When used, the encoded file handle is "explicitly connectable".
> >
> > The "explicitly connectable" file handle sets bits in the high 16bit of
> > the handle_type field, so open_by_handle_at(2) will know that it needs
> > to open a file with a connected path.
> >
> > old kernels will now recognize the handle_type with high bits set,
> > so "explicitly connectable" file handles cannot be decoded by
> > open_by_handle_at(2) on old kernels.
> >
> > The flag AT_HANDLE_CONNECTABLE is not allowed together with either
> > AT_HANDLE_FID or AT_EMPTY_PATH.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/fhandle.c               | 48 ++++++++++++++++++++++++++++++++++----
> >  include/linux/exportfs.h   |  2 ++
> >  include/uapi/linux/fcntl.h |  1 +
> >  3 files changed, 46 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > index c5792cf3c6e9..7b4c8945efcb 100644
> > --- a/fs/fhandle.c
> > +++ b/fs/fhandle.c
> > @@ -31,6 +31,14 @@ static long do_sys_name_to_handle(const struct path =
*path,
> >       if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_f=
lags))
> >               return -EOPNOTSUPP;
> >
> > +     /*
> > +      * A request to encode a connectable handle for a disconnected de=
ntry
> > +      * is unexpected since AT_EMPTY_PATH is not allowed.
> > +      */
> > +     if (fh_flags & EXPORT_FH_CONNECTABLE &&
> > +         WARN_ON(path->dentry->d_flags & DCACHE_DISCONNECTED))
> > +             return -EINVAL;
> > +
>
> Is it possible to get a DCACHE_DISCONNECTED dentry here? This thing
> comes from a userland path walk (a'la name_to_handle_at()). That means
> that it necessarily is connected.

Can't you get it with AT_EMPTY_PATH if dfd is obtained by open_by_handle()?

>
> I'd drop the fh_flags check, since it seems like having that set on any
> dentry we get in this interface would be a bug.
>

Well I don't know if giving a disconnected dentry to name_to_handle
is intentional, but it is not wrong, unless user actually requests a
connectable file handle. No?

> >       if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
> >               return -EFAULT;
> >
> > @@ -45,7 +53,7 @@ static long do_sys_name_to_handle(const struct path *=
path,
> >       /* convert handle size to multiple of sizeof(u32) */
> >       handle_dwords =3D f_handle.handle_bytes >> 2;
> >
> > -     /* we ask for a non connectable maybe decodeable file handle */
> > +     /* Encode a possibly decodeable/connectable file handle */
> >       retval =3D exportfs_encode_fh(path->dentry,
> >                                   (struct fid *)handle->f_handle,
> >                                   &handle_dwords, fh_flags);
> > @@ -67,8 +75,23 @@ static long do_sys_name_to_handle(const struct path =
*path,
> >                * non variable part of the file_handle
> >                */
> >               handle_bytes =3D 0;
> > -     } else
> > +     } else {
> > +             /*
> > +              * When asked to encode a connectable file handle, encode=
 this
> > +              * property in the file handle itself, so that we later k=
now
> > +              * how to decode it.
> > +              * For sanity, also encode in the file handle if the enco=
ded
> > +              * object is a directory and verify this during decode, b=
ecause
> > +              * decoding directory file handles is quite different tha=
n
> > +              * decoding connectable non-directory file handles.
> > +              */
> > +             if (fh_flags & EXPORT_FH_CONNECTABLE) {
> > +                     handle->handle_type |=3D FILEID_IS_CONNECTABLE;
> > +                     if (d_is_dir(path->dentry))
> > +                             fh_flags |=3D FILEID_IS_DIR;
> > +             }
> >               retval =3D 0;
> > +     }
> >       /* copy the mount id */
> >       if (unique_mntid) {
> >               if (put_user(real_mount(path->mnt)->mnt_id_unique,
> > @@ -109,15 +132,30 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, cons=
t char __user *, name,
> >  {
> >       struct path path;
> >       int lookup_flags;
> > -     int fh_flags;
> > +     int fh_flags =3D 0;
> >       int err;
> >
> >       if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
> > -                  AT_HANDLE_MNT_ID_UNIQUE))
> > +                  AT_HANDLE_MNT_ID_UNIQUE | AT_HANDLE_CONNECTABLE))
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * AT_HANDLE_FID means there is no intention to decode file handl=
e
> > +      * AT_HANDLE_CONNECTABLE means there is an intention to decode a
> > +      * connected fd (with known path), so these flags are conflicting=
.
> > +      * AT_EMPTY_PATH could be used along with a dfd that refers to a
> > +      * disconnected non-directory, which cannot be used to encode a
> > +      * connectable file handle, because its parent is unknown.
> > +      */
> > +     if (flag & AT_HANDLE_CONNECTABLE &&
> > +         flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
> >               return -EINVAL;
> > +     else if (flag & AT_HANDLE_FID)
> > +             fh_flags |=3D EXPORT_FH_FID;
> > +     else if (flag & AT_HANDLE_CONNECTABLE)
> > +             fh_flags |=3D EXPORT_FH_CONNECTABLE;
> >
> >       lookup_flags =3D (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
> > -     fh_flags =3D (flag & AT_HANDLE_FID) ? EXPORT_FH_FID : 0;
> >       if (flag & AT_EMPTY_PATH)
> >               lookup_flags |=3D LOOKUP_EMPTY;
> >       err =3D user_path_at(dfd, name, lookup_flags, &path);
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 76a3050b3593..230b0e1d669d 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -169,6 +169,8 @@ struct fid {
> >  #define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> >
> >  /* Flags supported in encoded handle_type that is exported to user */
> > +#define FILEID_IS_CONNECTABLE        0x10000
> > +#define FILEID_IS_DIR                0x40000
>
> nit: why skip 0x20000 ?

Well in v2, the values were just shifting the EXPORT_FH_ flags left
so I kept it this way, although I am not sure if FILEID_ID_FID is ever
going to be useful, so I guess there is no good reason to skip 0x20000

Thanks,
Amir.

