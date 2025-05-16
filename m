Return-Path: <linux-fsdevel+bounces-49292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C0ABA336
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 20:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276E9170282
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3A27E7E3;
	Fri, 16 May 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAmclpib"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AF2E628
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421594; cv=none; b=oh04LNu58pnJaakQ3RCS4H4llDOQ7XbHRMLLI9cZ80LeavAcw2KibKzcDNlr74GkIzdf1kx93nUwX8/Za5WCUDirndAuICfyJfEtWLzYw6Biy72wWAcBGCk3A6SN6MHBrsD1q+QMF09jY0EQgI31ZT6uoYHkHvavFuM3GYlxPts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421594; c=relaxed/simple;
	bh=2puCuvhOrvm2nvP9CFv/1U8IlCoYkfbeEDDYQYlwL1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8k3myl+myrYGotcIhISYQjpjBDnGsy9ZpdjAixjGnXdaPnvLCTKXVeq21R08NrO8dRRdpH1vXRP85pfRgNpiCBx/CmORMrxEsLHWkSiaBUtuoj/O/ScVDeUVEAz50c2qwPIwkzI/q4qRc4sf3UjWU5b1X3rXX2c4x+3mPxI+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAmclpib; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601609043cfso1580958a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747421590; x=1748026390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fYzUszGIFPDwERZAMiYY0dNSZcjHIjw1aaKLOC8q1E=;
        b=RAmclpibeAeyJB0i650edGoKjV06wCwKT9HGxI6S2vukmq8SrPQ8IfAIq55bWobr/r
         5X6H3sQqq4PJN8FoBkAGfwVya8ytXpMsics39iVHeBtduny5OesR5hU6wgEapOUZL5/v
         I308B+eVFDzQP9SYfqA1wOnoL9WYx3TLHYGs0VhoH4KnHDy7Pz2j2KV6+T2igVCAaLN+
         K3omHDFhR/CowaLOw3RMvKt4lKEPYa1f20Aj7eJ40asMAu+scEBg8GcYBv527CMF/MvG
         GDmWUxECHgAS5+13o2eFmFlFQe2jjHSgztyS7Dlq/Non/lUpE7bp8M2lFuJiJQp2Zsz/
         BVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421590; x=1748026390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fYzUszGIFPDwERZAMiYY0dNSZcjHIjw1aaKLOC8q1E=;
        b=gGjD+IMOXdWb1DQ9pNLjcGJ5ZuHxFGBKIVJWkatakpXQjD+I1A04pNz3mY9TkgBGP9
         JiiHgjsrujq2RuHLtcksVycvV21pnoTZ+QUC/xwsOMclNkXr1t4Qlfk/7+/aEaNwvzFp
         gdRb4HbgnmYdmnGI3WWZNdzUMkmWJ0tKVDOuLCmKgNd7Te+vKqQ9w4xA+i+w/yA01C02
         aIB9nEg0fE05YEvXAlUW841PYkhtZoGac3R9XKGyFizjOhpDnY/gn5JWmXZ33UrSpzHZ
         LP/SezLnjuy7Ka7tYvRL7iXFBuu9xD5wSjWcEqfYoT7zly/zMGfcYwNUzCfqnEixRFYz
         j+xw==
X-Forwarded-Encrypted: i=1; AJvYcCWDazta0kP6WZ4OHzK/SMmLnp11AFCplCw/DKFFs7tJCF7grdhKp+MHYg0QbjF2bBGcR69ltTV6R15ynFRm@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/UUx4/av+KJxpt1WihB4wP5KD/m+1SndefEQHLRz9pnl0RlK
	zhOC8eHW1AFvnXjS6vs/dv61fPf57kkEaMdGagbCWzYG9PucIqdhy941TNM4xTF80GI8Jdiz8B7
	/U1RNVrmdjkajdByMjaqvCaimsVgykmc=
X-Gm-Gg: ASbGncvcwdqKU1xF+0alwTAcYuXrR02rKtRZzGQMF4fWk9h8cLrLyFvMKWW6+q65BnN
	QngZuavQ1YdwbrHrAcYQewC3ietZ+z1wnyORTzneIo7PcbqSVTDrGS1iLHX+whKzh80EbIB1ETx
	9b74D3ZVwl5wrHRy2lSqpZyn3mFBIIGR+P
X-Google-Smtp-Source: AGHT+IHp1vgBB9iHOP0JNMdUr87WakZhsFZpVrxDIvngH8xcR2G272yyvN8Lxv3wwiCiZ/QX6femm96LkDVvfB5SLvs=
X-Received: by 2002:a17:906:9fc4:b0:ad2:51d8:7930 with SMTP id
 a640c23a62f3a-ad52d46923emr399102966b.12.1747421590177; Fri, 16 May 2025
 11:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <20250419100657.2654744-3-amir73il@gmail.com>
 <fsldmf3k4u5wi2k2su2z26nw7lmr4jonrt5caaiyt7fmpteqzg@xsu4cnaeu6oy>
 <CAOQ4uxj3UgaMkrvOmpCSBgsay6bD_+gGTLFBtC2Cqi_69pQgfQ@mail.gmail.com> <CAOQ4uxi=HDMmCLsVXNxVTLAzkYOfEYMTcXUiTBuTB0Hm0=-awA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi=HDMmCLsVXNxVTLAzkYOfEYMTcXUiTBuTB0Hm0=-awA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 May 2025 20:52:57 +0200
X-Gm-Features: AX0GCFtRS4phXYcAwR0m6T2hgIYO3cfgdtgWmZkMIrDPN9pfW8m2PQwcbAdSMD4
Message-ID: <CAOQ4uxiDmZ20W-pHvnEsSoKEWPZbHpb_jjzLJV9FASgPL+F03g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: support watching filesystems and mounts
 inside userns
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 7:28=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, May 14, 2025 at 8:39=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Wed, May 14, 2025 at 5:49=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 19-04-25 12:06:57, Amir Goldstein wrote:
> > > > An unprivileged user is allowed to create an fanotify group and add
> > > > inode marks, but not filesystem, mntns and mount marks.
> > > >
> > > > Add limited support for setting up filesystem, mntns and mount mark=
s by
> > > > an unprivileged user under the following conditions:
> > > >
> > > > 1.   User has CAP_SYS_ADMIN in the user ns where the group was crea=
ted
> > > > 2.a. User has CAP_SYS_ADMIN in the user ns where the filesystem was
> > > >      mounted (implies FS_USERNS_MOUNT)
> > > >   OR (in case setting up a mntns or mount mark)
> > > > 2.b. User has CAP_SYS_ADMIN in the user ns associated with the mntn=
s
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > I'm sorry for the delay. Both patches look good to me but I'd like so=
mebody
> > > more versed with user namespaces to double check namespace checks in =
this
> > > patch are indeed sound (so that we don't introduce some security issu=
e).
> >
> > Good idea!
> >
> > > Christian, can you have a look please?
> > >
> >
> > Christian,
> >
> > Please note that the checks below are loosely modeled after the tests i=
n
> > may_decode_fh(), with some differences:
> >
> > > >
> > > >       /*
> > > > -      * An unprivileged user is not allowed to setup mount nor fil=
esystem
> > > > -      * marks.  This also includes setting up such marks by a grou=
p that
> > > > -      * was initialized by an unprivileged user.
> > > > +      * A user is allowed to setup sb/mount/mntns marks only if it=
 is
> > > > +      * capable in the user ns where the group was created.
> > > >        */
> > > > -     if ((!capable(CAP_SYS_ADMIN) ||
> > > > -          FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
> > > > +     if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
> > > >           mark_type !=3D FAN_MARK_INODE)
> > > >               return -EPERM;
> > > >
> >
> > 1. This is an extra restriction. Not sure is need to remain forever,
> > but it reduces
> >     attack surface and does not limit the common use cases,
> >     so I think it's worth to have.
> >
> > > > @@ -1987,12 +1988,27 @@ static int do_fanotify_mark(int fanotify_fd=
, unsigned int flags, __u64 mask,
> > > >               obj =3D inode;
> > > >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
> > > >               obj =3D path.mnt;
> > > > +             user_ns =3D real_mount(obj)->mnt_ns->user_ns;
> > > >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_SB) {
> > > >               obj =3D path.mnt->mnt_sb;
> > > > +             user_ns =3D path.mnt->mnt_sb->s_user_ns;
> > > >       } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_MNTNS) {
> > > >               obj =3D mnt_ns_from_dentry(path.dentry);
> > > > +             user_ns =3D ((struct mnt_namespace *)obj)->user_ns;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * In addition to being capable in the user ns where group wa=
s created,
> > > > +      * the user also needs to be capable in the user ns associate=
d with
> > > > +      * the marked filesystem (for FS_USERNS_MOUNT filesystems) or=
 in the
> > > > +      * user ns associated with the mntns (when marking a mount or=
 mntns).
> > > > +      * This is aligned with the required permissions to open_by_h=
andle_at()
> > > > +      * a directory fid provided with the events.
> > > > +      */
> > > > +     ret =3D -EPERM;
> > > > +     if (user_ns && !ns_capable(user_ns, CAP_SYS_ADMIN))
> > > > +             goto path_put_and_out;
> > > > +
> >
> > 2. In may_decode_fh() we know the mount that resulting file will be
> >     opened from so we accept
> >     Either capable mnt->mnt_sb->s_user_ns
> >     OR capable real_mount(mnt)->mnt_ns->user_ns
> > whereas here we only check capable mnt->mnt_sb->s_user_ns
> >    when subscribing to fs events on sb
> >    and only check capable real_mount(mnt)->mnt_ns->user_ns
> >    when subscribing to fs events on a specific mount
> >
> > I am not sure if there is a use case to allow watching events on a
> > specific mount for capable mnt->mnt_sb->s_user_ns where
> > real_mount(mnt)->mnt_ns->user_ns is not capable
> > or if that setup is even possible?
> >
> > 3. Unlike may_decode_fh(), we do not check has_locked_children()
> >     Not sure how bad it is to allow receiving events for fs changes in
> >     obstructed paths (with file handles that cannot be opened).
> > If this case does needs to be checked  then perhaps we should
> > check for capable mnt->mnt_sb->s_user_ns also when subscribing
> > to fs events on a mount.
> >
>
> OK, after some thinking I think it is best to align the logic to match
> may_decode_fh() more closely, like this:
>
> @@ -1986,13 +1987,40 @@ static int do_fanotify_mark(int fanotify_fd,
> unsigned int flags, __u64 mask,
>                 inode =3D path.dentry->d_inode;
>                 obj =3D inode;
>         } else if (obj_type =3D=3D FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
> +               struct mount *mnt =3D real_mount(path.mnt);
> +
>                 obj =3D path.mnt;
> +               user_ns =3D path.mnt->mnt_sb->s_user_ns;
> +               /*
> +                * Do not allow watching a mount with locked mounts on to=
p
> +                * that could be hiding access to paths, unless user is a=
lso
> +                * capable on the user ns that created the sb.
> +                */
> +               if (!ns_capable(user_ns, CAP_SYS_ADMIN) &&
> +                   !has_locked_children(mnt, path.mnt->mnt_root))
> +                       user_ns =3D mnt->mnt_ns->user_ns;

No scratch that.
I will send v2 that is much simpler.

Thanks,
Amir.

