Return-Path: <linux-fsdevel+bounces-31722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2B99A613
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 16:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804DD2830FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8821949A;
	Fri, 11 Oct 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUcgNMCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA53219CB2;
	Fri, 11 Oct 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656073; cv=none; b=W1YB+Nc3ifnaPfT+IdZXaPIFtUWhAqBcwSmjDmLD+l70eGxV3Uha4rAxHP0VAx0pY8HwBCNhVdylJooOiwggp7gMI3YEdtfWZAVVUpE8xG2+7IWV18sOWOlw0vAXW+m4FuHYMqD90q+G+o+7buwDCcGqcV9KTG6OUT4Admqfujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656073; c=relaxed/simple;
	bh=eEtXQMP9cGBzj4SIUzHV218mOzk8GW4U4/8FSSi8JxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMR0O0zVCZpqPCX3vo+tsi4Kr/VVM2eEbKsiRwu9teJ//5+NsQ8t3onMXF3NooBa0Wd1ZotW2eqcDsZXwNWgoAj9nKzBdvL9MQG6qhVDgBNLu5D6a3rxjdeG5FsENCs4onkEMMWg/7qK7LCb/hXqYKnAqg1R0Yp3P1lSC4aBHIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUcgNMCN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b10e0fadbcso139867985a.2;
        Fri, 11 Oct 2024 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728656071; x=1729260871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDYzsV+F5Vy8b6juSV/lGuZAE/FncmOOUTRyd4Gy5Fk=;
        b=jUcgNMCN5Qnj30TqhFz2133PADhaUDQgXCi9VjGQJtXKXcwFhGiRYaugVX6S7KVnOF
         8eOmSVX/yPfOXU6WUQqeKcf+OGdyGOwLhjapQW6yqmuqybinep62WSlW0KV76DHo4VDQ
         9k0U8Vw6hG10IasrlzOuY0o+vZ/Unzk4wWwiyQvJBZFMi3hwMsUunxIJwVUR0IAPNfpz
         TbEMQnLI0HL/0dcZAc7/M7/AEnbud957sfsTksDKfC8KCEQ/sG0x0C0hOXOFOVbH7AUS
         L6Fbgoo0Ja0UWz9m4qFdGiga0BHQQoRK0nfH2BvQxnOgQgmYDuOz88FAv2xr+0PREQW0
         YYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656071; x=1729260871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDYzsV+F5Vy8b6juSV/lGuZAE/FncmOOUTRyd4Gy5Fk=;
        b=RdHTNHc9G/l0VTtvdetd9Knog0niW/JhBC1Pn8l85fZG5/B1Ey/M44uYAho8Mg1H9W
         kEL0eaVMvisyusqOKBB81YddVD04ZfzldRNGy1bKY3xP945KoO5mivK3AIMk274CmT4g
         RJ6qx8NVeRxiVp7Uv6yXUChD1iX7BWm4rQTSHGBXfhUKwApdcv9tnvTXUKX4tQ4nPrO7
         mD0C2Z63lfr1aBZ5P05nR1O9+V/KvUvK9mNwWzNfASt0+4kKFHcQ+atPAZYWJSTSWQpM
         tO5EfHQG34nWoCoY/b/m6COzM3CohUQ5QvDZKvfOrWqc5Umsb4HnR1qa6iEYPns/9bqI
         KkBg==
X-Forwarded-Encrypted: i=1; AJvYcCU/e3FTRzZK1a9HmAFXYiu0vCUkGfo4X/lnEtyAZaSvNlVYunxpTxBZo2TprvueNv43wFJ5t6W59WU1@vger.kernel.org, AJvYcCUMjrJ3xd3gi7wUVhP4+UIKpIGytRfsvgMIZGj1SSCWX9fEJm6dkYVcy+5fSQAoeq8y0NgAtE6nl9Yktaah@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKqbe2m8MeQ/+zq8QCiEwDGB7bVRErg452jT5YMpt3f+8/PRe
	aqZWZQT6eIxGaJwNzyzxfFZ7hInAsPLxSGWLS8l/MR0IX4qEQ5mkzKv7lyYEpPIzwav1GSCSUK2
	UeUtU9XlRVB1JZKWjMSsVD1UwrEI=
X-Google-Smtp-Source: AGHT+IH7q8RX+laf5xjpHVX8kVKa5dtyiL5M91n5c0WAC6BG0cgxOwx7CEatzTyBQkuXQTGjDkHMF9IXZWjh0GMMbcg=
X-Received: by 2002:a05:620a:4153:b0:7ac:b1fb:27d3 with SMTP id
 af79cd13be357-7b11a3ad389mr361155085a.40.1728656070491; Fri, 11 Oct 2024
 07:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011090023.655623-1-amir73il@gmail.com> <20241011090023.655623-3-amir73il@gmail.com>
 <3fad10839da31f8f8b08fe355612da39a610b111.camel@kernel.org>
In-Reply-To: <3fad10839da31f8f8b08fe355612da39a610b111.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Oct 2024 16:14:19 +0200
Message-ID: <CAOQ4uxgO5rNpsctjdKvJyy7Li7Di4x8AaRahVk5F8_tjgx1V=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fs: name_to_handle_at() support for "explicit
 connectable" file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:00=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-10-11 at 11:00 +0200, Amir Goldstein wrote:
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
> > index 218511f38cbb..8339a1041025 100644
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
>
> Is this even possible? The dentry in this case will have been reached
> by pathwalk. Oh, but I guess the dfd could point to a disconnected
> dentry and then you pass in AT_EMPTY_PATH.

But see comment above "...is unexpected since AT_EMPTY_PATH is not allowed.=
"

and see below

+        * AT_EMPTY_PATH could be used along with a dfd that refers to a
+        * disconnected non-directory, which cannot be used to encode a
+        * connectable file handle, because its parent is unknown.
+        */
+       if (flag & AT_HANDLE_CONNECTABLE &&
+           flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
                return -EINVAL;

The code/API should not allow this also for a malicious user,
unless I missed something, hence, the assertion.

>
> I'm not sure we want to warn in that case though, since this is a
> situation that an unprivileged user could be able to arrange. Maybe we
> should just return a more distinct error code in this case?
>
> Since the scenario involves a dfd that is disconnected, how about:
>
>     #define EBADFD          77      /* File descriptor in bad state */
>

To me it does not look like a good fit, but let's see what others think.
In the end, it is a rare condition that should never happen
(hence assert), so I don't think the error value matters that much?

> > +             return -EINVAL;
> > +
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
>
> nit: might need parenthesis around the above & check.
>
> > +         flag & (AT_HANDLE_FID | AT_EMPTY_PATH))

I don't think it is needed, but for readability I don't mind adding them.
I am having a hard time remembering the operation precedence  myself,
but this one is clear to me so I don't bother with ().

Thanks,
Amir.

