Return-Path: <linux-fsdevel+bounces-49284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4DEABA1DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF0A226B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184D326D4F1;
	Fri, 16 May 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRd/E9ON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692F230274
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416553; cv=none; b=k5YRuYo4EiJH5tJ59iMe4cudTZDZ/hMFg7MvVIXGXk0L6BLQLPiOFkOyf22S6lBiEzPpIwg6f1RpDVUtWMSmJTiI2xrssDu+5MpecgJYiMzt8NgvthaQC0dYVIKC43uTZ6ElGmtAdJT8/Ku8j+PU5XXCr8z6lst1EM9zImsOwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416553; c=relaxed/simple;
	bh=aU0nNXgJZBPdyvnJ6X9MLgPd/B2DlyBj1XGtMeYPPJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N15fe6viMV7kR8XhpgTx3E/NWE+WQ5/mjiu6IbpFVAC/4v404iXvvvK757s/DqlpqJYYvRFQDFnNsyTN7/aETeiRPxq8wubyMDjLfWOOiYDI0DNzHUA0L+ELwJKtXi4PMzGMgqiHXnAGwdEKUE3yO+OZREYchpZiJMCU3MVELtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRd/E9ON; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad238c68b35so427065966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747416550; x=1748021350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXHzZMhsIBdnLdE83EbJ0Im7v9A2I0SfPzFgMRhSenA=;
        b=ZRd/E9ONFecBYO04K+uDcBsnnoa0RsU2pocF5A83MBKfbkYnK8hfJaNWlLG64KOm1F
         +ZxvwFhLG/g7lLUGTTqEHQjPkOF8WZcWhi9naHg2NC1VSmUaf3shNTIwCxpHOOIW5Kq8
         n2p7vl0/mVOdsriGRNmCosXZFV+yJ4zCRDXiR0irP4s5RgxorY5bZumc8zfeQQgAIHpr
         2EFYf6EaRijH/KBDWrIX3kQ4oZoOS2/Xhkzp0lEAraJBFT1k3aLk/DV9nZ33hli80O98
         F1Wuh+J+E/Pq52D+dy/QRWybx534eE2VbZJQCGJZ4xl0Juyj3l0dpcI7YfKlGjz8vwlm
         YOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747416550; x=1748021350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXHzZMhsIBdnLdE83EbJ0Im7v9A2I0SfPzFgMRhSenA=;
        b=km0ERt002QDzd2JMqPKnUTvr671tkwkEI0XaDm4k9fdTPGBwv5s7SscMBPDVnUgFrH
         ZISlnchhmUSPeOMJ9VjhqH2OL0HSGcdb7V97YBXZKl3Q1zN4KexHZ+7gGbIKlmqVAiOi
         RDABBxEFoNVt4yZaPXSB2DgHcOLN4nSmo2nRbhv0bEVD+K+Dl/SEbnD30vmhxfiBQl/7
         zXQJDELw7zhKbSUfFoRKaH+BB6+EWNZUliCNSEZUTZPd74pGrMs1dTOI218y/1a98aZb
         5uNN5LeNIBXy7+d3Tg+xNXfhySm5gJBrIHQKfDkjFtkS0xlJqaz6//mOeAuBVpteLTGw
         7wuw==
X-Forwarded-Encrypted: i=1; AJvYcCXgbSTZIrivf7Ufdo5ZFL/kB1Ep9zyUuY2sKSEhaNMioiVFUfpVj6GfgYrvccCUHjcGl4bXRzuEnQfJM+Je@vger.kernel.org
X-Gm-Message-State: AOJu0YxksB7pEfUweIQ1YmDC5LFgQ6CtumC0DY5hz1w3MIgH8NuM11Y7
	O1wjp7dS2NEfJMW5PBzp7syGquK4WdquSH0QaRF0YyleVrLH40MBvHaaRJcsyx2NY3T9auXg9+2
	z4OWZlFMWQDzLQaeAC0rR+zOtdTcHRbo=
X-Gm-Gg: ASbGncsc83aOkdci9K7STx0Xdse1mQEfOv9ClWkRa5jcbCRvQ9OvhfVgnc5AM+cSp4Y
	VLoSs7Ra6ywpB+o6+9GbU+nbB4TOb0givArfM2GqfC0MOcnv9fyMaWApUza4CzI+3MxThTuiopp
	v3Cc3ituDCITS3wdMo18OTMcFdpf8D385a
X-Google-Smtp-Source: AGHT+IFjbzXaOF4xkqoWt+YssC57mCaecSj+oJr/GCNQKbV3zxq59qpW4dhIkJZcUDiRQrldmdhs7hQSI9MTjlwcf0U=
X-Received: by 2002:a17:906:c144:b0:ad2:2ba6:2012 with SMTP id
 a640c23a62f3a-ad536b5b1b1mr305865566b.11.1747416549484; Fri, 16 May 2025
 10:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <20250419100657.2654744-3-amir73il@gmail.com>
 <fsldmf3k4u5wi2k2su2z26nw7lmr4jonrt5caaiyt7fmpteqzg@xsu4cnaeu6oy> <CAOQ4uxj3UgaMkrvOmpCSBgsay6bD_+gGTLFBtC2Cqi_69pQgfQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj3UgaMkrvOmpCSBgsay6bD_+gGTLFBtC2Cqi_69pQgfQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 May 2025 19:28:58 +0200
X-Gm-Features: AX0GCFtelMVlteFJHSNthwAUYgcCjYoUTlavzZ4HqHu1Wl9RGbOeLPko0g0g7Fg
Message-ID: <CAOQ4uxi=HDMmCLsVXNxVTLAzkYOfEYMTcXUiTBuTB0Hm0=-awA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 8:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, May 14, 2025 at 5:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 19-04-25 12:06:57, Amir Goldstein wrote:
> > > An unprivileged user is allowed to create an fanotify group and add
> > > inode marks, but not filesystem, mntns and mount marks.
> > >
> > > Add limited support for setting up filesystem, mntns and mount marks =
by
> > > an unprivileged user under the following conditions:
> > >
> > > 1.   User has CAP_SYS_ADMIN in the user ns where the group was create=
d
> > > 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
> > >      mounted (implies FS_USERNS_MOUNT)
> > >   OR (in case setting up a mntns or mount mark)
> > > 2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntns
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I'm sorry for the delay. Both patches look good to me but I'd like some=
body
> > more versed with user namespaces to double check namespace checks in th=
is
> > patch are indeed sound (so that we don't introduce some security issue)=
.
>
> Good idea!
>
> > Christian, can you have a look please?
> >
>
> Christian,
>
> Please note that the checks below are loosely modeled after the tests in
> may_decode_fh(), with some differences:
>
> > >
> > >       /*
> > > -      * An unprivileged user is not allowed to setup mount nor files=
ystem
> > > -      * marks.  This also includes setting up such marks by a group =
that
> > > -      * was initialized by an unprivileged user.
> > > +      * A user is allowed to setup sb/mount/mntns marks only if it i=
s
> > > +      * capable in the user ns where the group was created.
> > >        */
> > > -     if ((!capable(CAP_SYS_ADMIN) ||
> > > -          FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
> > > +     if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
> > >           mark_type !=3D FAN_MARK_INODE)
> > >               return -EPERM;
> > >
>
> 1. This is an extra restriction. Not sure is need to remain forever,
> but it reduces
>     attack surface and does not limit the common use cases,
>     so I think it's worth to have.
>
> > > @@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd, =
unsigned int flags, __u64 mask,
> > >               obj =3D inode;
> > >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
> > >               obj =3D path.mnt;
> > > +             user_ns =3D real_mount(obj)->mnt_ns->user_ns;
> > >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
> > >               obj =3D path.mnt->mnt_sb;
> > > +             user_ns =3D path.mnt->mnt_sb->s_user_ns;
> > >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
> > >               obj =3D mnt_ns_from_dentry(path.dentry);
> > > +             user_ns =3D ((struct mnt_namespace *)obj)->user_ns;
> > >       }
> > >
> > > +     /*
> > > +      * In addition to being capable in the user ns where group was =
created,
> > > +      * the user also needs to be capable in the user ns associated =
with
> > > +      * the marked filesystem (for FS_USERNS_MOUNT filesystems) or i=
n the
> > > +      * user ns associated with the mntns (when marking a mount or m=
ntns).
> > > +      * This is aligned with the required permissions to open_by_han=
dle_at()
> > > +      * a directory fid provided with the events.
> > > +      */
> > > +     ret =3D -EPERM;
> > > +     if (user_ns && !ns_capable(user_ns, CAP_SYS_ADMIN))
> > > +             goto path_put_and_out;
> > > +
>
> 2. In may_decode_fh() we know the mount that resulting file will be
>     opened from so we accept
>     Either capable mnt->mnt_sb->s_user_ns
>     OR capable real_mount(mnt)->mnt_ns->user_ns
> whereas here we only check capable mnt->mnt_sb->s_user_ns
>    when subscribing to fs events on sb
>    and only check capable real_mount(mnt)->mnt_ns->user_ns
>    when subscribing to fs events on a specific mount
>
> I am not sure if there is a use case to allow watching events on a
> specific mount for capable mnt->mnt_sb->s_user_ns where
> real_mount(mnt)->mnt_ns->user_ns is not capable
> or if that setup is even possible?
>
> 3. Unlike may_decode_fh(), we do not check has_locked_children()
>     Not sure how bad it is to allow receiving events for fs changes in
>     obstructed paths (with file handles that cannot be opened).
> If this case does needs to be checked  then perhaps we should
> check for capable mnt->mnt_sb->s_user_ns also when subscribing
> to fs events on a mount.
>

OK, after some thinking I think it is best to align the logic to match
may_decode_fh() more closely, like this:

@@ -1986,13 +1987,40 @@ static int do_fanotify_mark(int fanotify_fd,
unsigned int flags, __u64 mask,
                inode =3D path.dentry->d_inode;
                obj =3D inode;
        } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
+               struct mount *mnt =3D real_mount(path.mnt);
+
                obj =3D path.mnt;
+               user_ns =3D path.mnt->mnt_sb->s_user_ns;
+               /*
+                * Do not allow watching a mount with locked mounts on top
+                * that could be hiding access to paths, unless user is als=
o
+                * capable on the user ns that created the sb.
+                */
+               if (!ns_capable(user_ns, CAP_SYS_ADMIN) &&
+                   !has_locked_children(mnt, path.mnt->mnt_root))
+                       user_ns =3D mnt->mnt_ns->user_ns;
        } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
                obj =3D path.mnt->mnt_sb;
+               user_ns =3D path.mnt->mnt_sb->s_user_ns;
        } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
-               obj =3D mnt_ns_from_dentry(path.dentry);
+               struct mnt_namespace *mntns =3D mnt_ns_from_dentry(path.den=
try);
+
+               obj =3D mntns;
+               user_ns =3D mntns->user_ns;
        }

+       /*
+        * In addition to being capable in the user ns where group was crea=
ted,
+        * the user also needs to be capable in the user ns associated with
+        * the marked filesystem or in the user ns associated with the mntn=
s
+        * (when marking a mount or mntns).
+        * This is aligned with the required permissions to open_by_handle_=
at()
+        * a directory fid provided with the events.
+        */
+       ret =3D -EPERM;
+       if (user_ns && !ns_capable(user_ns, CAP_SYS_ADMIN))
+               goto path_put_and_out;
+

Thanks,
Amir.

