Return-Path: <linux-fsdevel+bounces-49000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCEDAB747D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE83A3A75DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21312874E8;
	Wed, 14 May 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiIr0diM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93E286D5D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247976; cv=none; b=HpcczYe/Z54k0Mg9HGBxo2psKkZZTpzkttQSuEa6/UWJFBxxFtUqB7jbIItEhJBXNGqwDAT0EuG/aSdqiN5mMjgPoHU3AP8jQeyy1Foh/3m+yeSdsA7V96wEMhoUbflXWDtqmUGlRWkzzQrwKDZ+hneLPWPqv1BMb8K5VYVvSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247976; c=relaxed/simple;
	bh=QZ7WmPuxHKeeU5AxLe5ASlx2Qe88jdNXBInyeyPvRM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAWudCI8YXzbTzanm3JA4UL3V6Gskz6LcFpzjwvSmzIDQtmaOm8mqVmv7Rz6ldo3ycxCe6DLJ/KCBj1Ng87YXP6eA/zWG3mzXVvfjac9m9kFxL7MRG7wWToZR/fQa0zweuwrf7HQ72iek/TSlgPofHoDjz0WXbtz8KO9Pt9zG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiIr0diM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbf534f8dbso197234a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747247973; x=1747852773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrDCehNQxLsKl7VBfm1PYbXDz5NBQok/rzIBeMNAElw=;
        b=KiIr0diM+gMmVvwiA44hz6WOMkFMPscKoKLQUoRkEPkhkGnBG6lxR9NejDClnoRwkp
         ekRl5sEqI2xiGsjm6aLP6vSQ3tgqmGBgpo+V6pm4ugn6F+COc0BU2Swvf4XWgeH0ubJB
         d4CQX8aC+cOlKVED+d3DL3m2TV6vW94gMqPt8sXtzHlkrokec4j5GATC2eGZme70jEWr
         ltE9U3a+Dts6WVAALTFQMF8ghokU1Oc9nxwQoASPq//V0OM/pqMaQBeY9Jo4zreKqjfZ
         PZeVZlTaj3TWqy9NkVv33IxGo5mNQmUrcQJPkBEiJz94XOdTpzqC0VaERZT5/vOHIrSa
         G3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247973; x=1747852773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrDCehNQxLsKl7VBfm1PYbXDz5NBQok/rzIBeMNAElw=;
        b=Sxq0S6ksxFjawyFF381qoQrnrmPEiTzXC6NCS/vXaODf8WkHrHZxSc3PMnwfk5I2c8
         0YVBElYkfqvttPo5euLqxG7lmBGYFGBOT/RBb+YcjlCVgoKk21M2pfa0rUZYq/eCeG4x
         sgtmpwAghbmuNxbn9ignfZeiH8QT3vlC218iW8YYb0k6Gm0zsmm4GXX6ptUT/fileRbZ
         tn03JFH9Fc9w6Z5m/20gQ/Xw9Nhg3rG2EF3F7jKribc6q7yTv5+RiXUS/n7wujKj8EO/
         wgA42wvPDOecZ+R3Caao5o924PBmRsGGr9xpnWVjS1ij3djNtI+EzTiTe0NTxcQ/UIaH
         NQcA==
X-Forwarded-Encrypted: i=1; AJvYcCU4JUXrRX7RSjz2PdQRuj2+wev38fKliGV0zpUQEDHVI+kp30dtwiLRreFULVQ1TsxIMVobI/t80e+PmwhU@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiZcafMczH1gL8EhCsEBpCCV/0Z5t96jJm/MiidRBv4VQ3lbh
	6oT+eXMp/O6WbvGkm0DpOcYuQn8vqBDctkeic5L3Nav7kd8ousrebE9p4c92AcvVWxGJ//iDO9U
	qvoa8cUywmeBVWFFcSLbnQeeTu84=
X-Gm-Gg: ASbGnct7F9LALLQmlEKfF1exK4uEZ8ZVvFX65t3SGl89y9Ar7meti5dzGhSBIAeGLea
	5S9bNrUrk4L9ts1+kvou5cd1S6sbnqGXEJxQaYTlnSb3AcXycArxUr2i5CTajlAtVSu1HzEnRGq
	Zs1fYfs9ysj5hm+SD8yYIYo2BvyJ5DJn67
X-Google-Smtp-Source: AGHT+IGrjZSqB1KfsmTdKVsyXudAbrFZCSL54pgAoQgR3AlusBe7lvMpJkDM2C8QmT6gnPdsK4buryaNj539ClY614k=
X-Received: by 2002:a17:907:86a1:b0:ad2:4374:84a2 with SMTP id
 a640c23a62f3a-ad4f70f61eamr450615866b.6.1747247972376; Wed, 14 May 2025
 11:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <20250419100657.2654744-3-amir73il@gmail.com>
 <fsldmf3k4u5wi2k2su2z26nw7lmr4jonrt5caaiyt7fmpteqzg@xsu4cnaeu6oy>
In-Reply-To: <fsldmf3k4u5wi2k2su2z26nw7lmr4jonrt5caaiyt7fmpteqzg@xsu4cnaeu6oy>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 May 2025 20:39:19 +0200
X-Gm-Features: AX0GCFsISaDZ0OmsiDJoY9P-r6pUbfAHHhIMklfVno_krjeqJ2T4l6r_LgrIxCY
Message-ID: <CAOQ4uxj3UgaMkrvOmpCSBgsay6bD_+gGTLFBtC2Cqi_69pQgfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 5:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 19-04-25 12:06:57, Amir Goldstein wrote:
> > An unprivileged user is allowed to create an fanotify group and add
> > inode marks, but not filesystem, mntns and mount marks.
> >
> > Add limited support for setting up filesystem, mntns and mount marks by
> > an unprivileged user under the following conditions:
> >
> > 1.   User has CAP_SYS_ADMIN in the user ns where the group was created
> > 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
> >      mounted (implies FS_USERNS_MOUNT)
> >   OR (in case setting up a mntns or mount mark)
> > 2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntns
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> I'm sorry for the delay. Both patches look good to me but I'd like somebo=
dy
> more versed with user namespaces to double check namespace checks in this
> patch are indeed sound (so that we don't introduce some security issue).

Good idea!

> Christian, can you have a look please?
>

Christian,

Please note that the checks below are loosely modeled after the tests in
may_decode_fh(), with some differences:

> >
> >       /*
> > -      * An unprivileged user is not allowed to setup mount nor filesys=
tem
> > -      * marks.  This also includes setting up such marks by a group th=
at
> > -      * was initialized by an unprivileged user.
> > +      * A user is allowed to setup sb/mount/mntns marks only if it is
> > +      * capable in the user ns where the group was created.
> >        */
> > -     if ((!capable(CAP_SYS_ADMIN) ||
> > -          FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
> > +     if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
> >           mark_type !=3D FAN_MARK_INODE)
> >               return -EPERM;
> >

1. This is an extra restriction. Not sure is need to remain forever,
but it reduces
    attack surface and does not limit the common use cases,
    so I think it's worth to have.

> > @@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd, un=
signed int flags, __u64 mask,
> >               obj =3D inode;
> >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
> >               obj =3D path.mnt;
> > +             user_ns =3D real_mount(obj)->mnt_ns->user_ns;
> >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
> >               obj =3D path.mnt->mnt_sb;
> > +             user_ns =3D path.mnt->mnt_sb->s_user_ns;
> >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
> >               obj =3D mnt_ns_from_dentry(path.dentry);
> > +             user_ns =3D ((struct mnt_namespace *)obj)->user_ns;
> >       }
> >
> > +     /*
> > +      * In addition to being capable in the user ns where group was cr=
eated,
> > +      * the user also needs to be capable in the user ns associated wi=
th
> > +      * the marked filesystem (for FS_USERNS_MOUNT filesystems) or in =
the
> > +      * user ns associated with the mntns (when marking a mount or mnt=
ns).
> > +      * This is aligned with the required permissions to open_by_handl=
e_at()
> > +      * a directory fid provided with the events.
> > +      */
> > +     ret =3D -EPERM;
> > +     if (user_ns && !ns_capable(user_ns, CAP_SYS_ADMIN))
> > +             goto path_put_and_out;
> > +

2. In may_decode_fh() we know the mount that resulting file will be
    opened from so we accept
    Either capable mnt->mnt_sb->s_user_ns
    OR capable real_mount(mnt)->mnt_ns->user_ns
whereas here we only check capable mnt->mnt_sb->s_user_ns
   when subscribing to fs events on sb
   and only check capable real_mount(mnt)->mnt_ns->user_ns
   when subscribing to fs events on a specific mount

I am not sure if there is a use case to allow watching events on a
specific mount for capable mnt->mnt_sb->s_user_ns where
real_mount(mnt)->mnt_ns->user_ns is not capable
or if that setup is even possible?

3. Unlike may_decode_fh(), we do not check has_locked_children()
    Not sure how bad it is to allow receiving events for fs changes in
    obstructed paths (with file handles that cannot be opened).
If this case does needs to be checked  then perhaps we should
check for capable mnt->mnt_sb->s_user_ns also when subscribing
to fs events on a mount.

Thanks,
Amir.

