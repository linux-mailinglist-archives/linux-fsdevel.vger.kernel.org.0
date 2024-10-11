Return-Path: <linux-fsdevel+bounces-31744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40099AAE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F726B22841
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C41C244B;
	Fri, 11 Oct 2024 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKtERJx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CCC19FA9D;
	Fri, 11 Oct 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670380; cv=none; b=upRXRFGaNs3ZZf677v4z92KZD1Yerxdq5uxOemICn3fhqcLXrWVQ/hLvgfbaVpftaNO5PmczgwPq9hGbgmV7o0waD5za+OpAh/MYwN6U5Bgnn8NmfUAKjRJRL60HHZniJz4OVUQHpCj6t67WVXtkMWPf7ic3d2aMzl26SAzhtzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670380; c=relaxed/simple;
	bh=CtqPhoHIgi28H2cIDzqHX25ZvYCNembvu0nV2sg8XiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KROig2X4CITGP6N3n2BOaGtKWw0AQriv3KrlMS4bhllqqfpBoakUXbhfeqnI8HW9S9LccVBjvx6k1C/k9g1nOqTgUUF3DnRZKUx9fGmCmnEmq7azvAOlN5uiIHhdAdnApiPMAc0r+XuvvTC0KkxaZMOP0/6p81hOzqlRfrzqxvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKtERJx4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b111003738so176965685a.1;
        Fri, 11 Oct 2024 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728670378; x=1729275178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcRKcewjXGSkfMCjRnUHIjLorxNqPM3K90IOrxWa4V8=;
        b=IKtERJx4kO+uHbKiQPHwmil2Acsu3dI8IzppDWbq/FqQGloR6B/8QZ3xf4wm2nfXKB
         2JZ02CiE/NcItm48QQ4eTX+j8WxSfyu82n9bzCzkzC/jnGdVVVORjFa1cW+gneBaeT76
         zWf4qg8tclGHeQ/L5ojlHomHuVmpk6oc9rpwhhQcT7TMCgl7otzHWqckgQr4hlfC8r5x
         PdWMR/ZtykTyJZgcVZ72Oh5oQMkFpQf+OH6qlxtd+QOHZF/ZnieZm2g7qWJzwknW7PUu
         lDA6OgUVBokQ0zfdJJmA2EyG8Fnl0G/IokaDClUfYQ8VLJa1s0PrLjxhQi7Hj8NGBtdW
         p8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728670378; x=1729275178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcRKcewjXGSkfMCjRnUHIjLorxNqPM3K90IOrxWa4V8=;
        b=B6bw7l7lgllGPXai47zIaVrNvpe//pMUqDl0HEcswO64xkP8+nJ97oUxZLLD1Rlhe8
         56hbyjJyU7xJ12w2tm2tueK+3Q+Oi8KrJg2bgwQ6gqbcYkFSC7T1W8S0OiuNTXCxWOG7
         QQLtplVU+NvInMQXB1Nqa5BD0zqQPcU+7q7FHejE5tIiHr48StQB4OdnDoVcIoVrDC5j
         TFncDFBBRuavSV8d76uPMG8B8R1fFUY9jo/0IWaG//hQbu/CywO/ZpdgqFg8eVmh3jgc
         KBF9WLA/wXRWSsseFW8WfPNbqLep4jUZoss0/So1sreWkMH6ofWe4awbyhlO76UnIoF6
         s98Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+PJbTVmmhySYRTozmOakiY1BRrF7OsisJ6rDe+2jtznz/fgt5jHLnC2ukS/EnlmcfbMxb/amVTgp@vger.kernel.org, AJvYcCVp1XUygqDA828cAd91TA6EUSIkI92yqOmgVBJfBNEB7xwZqtucdiFY5Q/of9nqZYTB8HuW6nuHf6kpbgpv@vger.kernel.org
X-Gm-Message-State: AOJu0YwH33W/aF8vDEYbCLTfFOEqcJW+K+ch1hYC0E2JHUw/r6I8ytdH
	5lwJvQJPZBHrAp4w8dR0ABMu1+AMQoi7y1WF+dRPM25HCVJwgr59FMVqAwG0a713J0MaJv7MMg3
	lXiRKWX37G6kbJxT5iADgULWFv/E=
X-Google-Smtp-Source: AGHT+IFJpcc0m8uHx1BwqxSlGEJayXmOhgwyLf2XFZc11WX96mq8QeV/18tdnTOOzRk6SfpR00pdNRSZFXI25JxkT8o=
X-Received: by 2002:a05:620a:2413:b0:7b1:1236:f3d6 with SMTP id
 af79cd13be357-7b11a363dabmr521395985a.15.1728670377929; Fri, 11 Oct 2024
 11:12:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011090023.655623-1-amir73il@gmail.com> <20241011090023.655623-3-amir73il@gmail.com>
 <3fad10839da31f8f8b08fe355612da39a610b111.camel@kernel.org>
 <CAOQ4uxgO5rNpsctjdKvJyy7Li7Di4x8AaRahVk5F8_tjgx1V=A@mail.gmail.com> <5ce49036cedbf7fa78a1395ded031fe2c0935e32.camel@kernel.org>
In-Reply-To: <5ce49036cedbf7fa78a1395ded031fe2c0935e32.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Oct 2024 20:12:46 +0200
Message-ID: <CAOQ4uxjkSuQUsc0CSRx3_S__oWe3SqYhW8zPOeVNBCZhnqQy-w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] fs: name_to_handle_at() support for "explicit
 connectable" file handles
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:18=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-10-11 at 16:14 +0200, Amir Goldstein wrote:
> > On Fri, Oct 11, 2024 at 4:00=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Fri, 2024-10-11 at 11:00 +0200, Amir Goldstein wrote:
> > > > nfsd encodes "connectable" file handles for the subtree_check featu=
re,
> > > > which can be resolved to an open file with a connected path.
> > > > So far, userspace nfs server could not make use of this functionali=
ty.
> > > >
> > > > Introduce a new flag AT_HANDLE_CONNECTABLE to name_to_handle_at(2).
> > > > When used, the encoded file handle is "explicitly connectable".
> > > >
> > > > The "explicitly connectable" file handle sets bits in the high 16bi=
t of
> > > > the handle_type field, so open_by_handle_at(2) will know that it ne=
eds
> > > > to open a file with a connected path.
> > > >
> > > > old kernels will now recognize the handle_type with high bits set,
> > > > so "explicitly connectable" file handles cannot be decoded by
> > > > open_by_handle_at(2) on old kernels.
> > > >
> > > > The flag AT_HANDLE_CONNECTABLE is not allowed together with either
> > > > AT_HANDLE_FID or AT_EMPTY_PATH.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/fhandle.c               | 48 ++++++++++++++++++++++++++++++++++=
----
> > > >  include/linux/exportfs.h   |  2 ++
> > > >  include/uapi/linux/fcntl.h |  1 +
> > > >  3 files changed, 46 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > index 218511f38cbb..8339a1041025 100644
> > > > --- a/fs/fhandle.c
> > > > +++ b/fs/fhandle.c
> > > > @@ -31,6 +31,14 @@ static long do_sys_name_to_handle(const struct p=
ath *path,
> > > >       if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, =
fh_flags))
> > > >               return -EOPNOTSUPP;
> > > >
> > > > +     /*
> > > > +      * A request to encode a connectable handle for a disconnecte=
d dentry
> > > > +      * is unexpected since AT_EMPTY_PATH is not allowed.
> > > > +      */
> > > > +     if (fh_flags & EXPORT_FH_CONNECTABLE &&
> > > > +         WARN_ON(path->dentry->d_flags & DCACHE_DISCONNECTED))
> > >
> > > Is this even possible? The dentry in this case will have been reached
> > > by pathwalk. Oh, but I guess the dfd could point to a disconnected
> > > dentry and then you pass in AT_EMPTY_PATH.
> >
> > But see comment above "...is unexpected since AT_EMPTY_PATH is not allo=
wed."
> >
> > and see below
> >
> > +        * AT_EMPTY_PATH could be used along with a dfd that refers to =
a
> > +        * disconnected non-directory, which cannot be used to encode a
> > +        * connectable file handle, because its parent is unknown.
> > +        */
> > +       if (flag & AT_HANDLE_CONNECTABLE &&
> > +           flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
> >                 return -EINVAL;
> >
> > The code/API should not allow this also for a malicious user,
> > unless I missed something, hence, the assertion.
> >
>
> Ok. If that's the case, I'm fine with this as-is then. If that ever
> fires then I guess we'll know that something is wrong.
>
> > >
> > > I'm not sure we want to warn in that case though, since this is a
> > > situation that an unprivileged user could be able to arrange. Maybe w=
e
> > > should just return a more distinct error code in this case?
> > >
> > > Since the scenario involves a dfd that is disconnected, how about:
> > >
> > >     #define EBADFD          77      /* File descriptor in bad state *=
/
> > >
> >
> > To me it does not look like a good fit, but let's see what others think=
.
> > In the end, it is a rare condition that should never happen
> > (hence assert), so I don't think the error value matters that much?
> >
>
> Agreed.
>
> > > > +             return -EINVAL;
> > > > +
> > > >       if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)=
))
> > > >               return -EFAULT;
> > > >
> > > > @@ -45,7 +53,7 @@ static long do_sys_name_to_handle(const struct pa=
th *path,
> > > >       /* convert handle size to multiple of sizeof(u32) */
> > > >       handle_dwords =3D f_handle.handle_bytes >> 2;
> > > >
> > > > -     /* we ask for a non connectable maybe decodeable file handle =
*/
> > > > +     /* Encode a possibly decodeable/connectable file handle */
> > > >       retval =3D exportfs_encode_fh(path->dentry,
> > > >                                   (struct fid *)handle->f_handle,
> > > >                                   &handle_dwords, fh_flags);
> > > > @@ -67,8 +75,23 @@ static long do_sys_name_to_handle(const struct p=
ath *path,
> > > >                * non variable part of the file_handle
> > > >                */
> > > >               handle_bytes =3D 0;
> > > > -     } else
> > > > +     } else {
> > > > +             /*
> > > > +              * When asked to encode a connectable file handle, en=
code this
> > > > +              * property in the file handle itself, so that we lat=
er know
> > > > +              * how to decode it.
> > > > +              * For sanity, also encode in the file handle if the =
encoded
> > > > +              * object is a directory and verify this during decod=
e, because
> > > > +              * decoding directory file handles is quite different=
 than
> > > > +              * decoding connectable non-directory file handles.
> > > > +              */
> > > > +             if (fh_flags & EXPORT_FH_CONNECTABLE) {
> > > > +                     handle->handle_type |=3D FILEID_IS_CONNECTABL=
E;
> > > > +                     if (d_is_dir(path->dentry))
> > > > +                             fh_flags |=3D FILEID_IS_DIR;
> > > > +             }
> > > >               retval =3D 0;
> > > > +     }
> > > >       /* copy the mount id */
> > > >       if (unique_mntid) {
> > > >               if (put_user(real_mount(path->mnt)->mnt_id_unique,
> > > > @@ -109,15 +132,30 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, =
const char __user *, name,
> > > >  {
> > > >       struct path path;
> > > >       int lookup_flags;
> > > > -     int fh_flags;
> > > > +     int fh_flags =3D 0;
> > > >       int err;
> > > >
> > > >       if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FI=
D |
> > > > -                  AT_HANDLE_MNT_ID_UNIQUE))
> > > > +                  AT_HANDLE_MNT_ID_UNIQUE | AT_HANDLE_CONNECTABLE)=
)
> > > > +             return -EINVAL;
> > > > +
> > > > +     /*
> > > > +      * AT_HANDLE_FID means there is no intention to decode file h=
andle
> > > > +      * AT_HANDLE_CONNECTABLE means there is an intention to decod=
e a
> > > > +      * connected fd (with known path), so these flags are conflic=
ting.
> > > > +      * AT_EMPTY_PATH could be used along with a dfd that refers t=
o a
> > > > +      * disconnected non-directory, which cannot be used to encode=
 a
> > > > +      * connectable file handle, because its parent is unknown.
> > > > +      */
> > > > +     if (flag & AT_HANDLE_CONNECTABLE &&
> > >
> > > nit: might need parenthesis around the above & check.
> > >
> > > > +         flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
> >
> > I don't think it is needed, but for readability I don't mind adding the=
m.
> > I am having a hard time remembering the operation precedence  myself,
> > but this one is clear to me so I don't bother with ().
>
> I (lately) get warnings from the compiler with W=3D1 even when the
> precedence is fine. If you're not seeing that then this is OK too.
>

Did not get any warnings, but if Christian wants to add the () on
commit I have no quarrel with that :)

Thanks for the review!
Amir.

