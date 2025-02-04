Return-Path: <linux-fsdevel+bounces-40714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECCA26FAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6387A1CC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504120B1E8;
	Tue,  4 Feb 2025 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfOUzCqZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE312036FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666727; cv=none; b=FptrbG8hcu0m6yBW1NHgG48veAwdvZ+daE2dOe9Vgufl4X6dbNAjmqWto2u95mtBkp23RGO3rNH2EpVAKnb8TPSM6nD6+7PRgLzelj8ENUQjR984OkyT40Kn9JSnd9CP00v0KOfAk7e7sfwkcy+GBGh+kAnvuTA+q9LIbPgYvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666727; c=relaxed/simple;
	bh=G4s7DezeFbnN232qaCbRiu8DaS57mRQAoM4ZXiZbvas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leFycATn8uvlFJCdy2v5fJcZdtXsbuimxs0YtkQ+Sks+rWqcRTx9I4A/Wk6dEY+jEZtNcpwgMKm+wFD8TlBqDKNvhDpOM5RcilGERDS6znkOOQt35fjI8Y6vTf4ARpINv2ErWFRo1TZ/4h3VW87O9bT4m1xcXRtDiv/TIr4YiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfOUzCqZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dc0522475eso11050033a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 02:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738666724; x=1739271524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0r2c+Giz9vArExcRVwbQzzihgoUmO1zdRjCms3uKCE=;
        b=mfOUzCqZPXiNA0wR4cva5vz2nse1OkhYezl3TO6qsdprWKJ9FdzsW3PWPsbdZyipS7
         5zvdLdecm8KTJxEOBFXY77YqKurZ1fypgV90FXo/LTzCcOfGb03POIFkmqt2ua0BA7M9
         Y1k9JY8ssgjzvg//HmdMG11WC5fZ6chQUPojl1Iw+jnva5PHERYP/55LqetvBrd4VODd
         V5LRYmOSj1/dMzVpJGgw6O/NK7jXj+18B11TDvfffE3emrFhavZqIx4fOI8SPAmxSRde
         +StbFkN05CbPIBkleOsKzNrgcnJjAqABowdnQoPuW1+/5yH5kS3S2HOkd8bIKKynehHd
         t8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738666724; x=1739271524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0r2c+Giz9vArExcRVwbQzzihgoUmO1zdRjCms3uKCE=;
        b=fApF5ln7YdAeXP6lqea5A5GFSyz8F3YhH16J4CkbvoIq79elpg9m7y5e5+1xtbTFKQ
         I1vSYYKRB6rcJurbnAwZuyjWBVE+OSNH1d2oppNtBIGsacUqR4KQsz1oKY1+/Ut2PTMI
         o6J+SueSLZcVKjCHOCjmGYdyyNQ+uGG7VMFZVI83457oqPsdOCt/xFusYzjNuB8Gg1Zk
         obibE/oZn6dwGQ5JGbPkec/1sTftX0OpGfeq6CE9SMCWrJBhqcE1dBmGBYn6yPuVXsdm
         wcosmzSW/EqVB3ZCwIcuYUjVyJVRCdAvc+lXpkT8pZjiPbJwCx3iMWT4t1UwR68SQQqX
         Ksyg==
X-Forwarded-Encrypted: i=1; AJvYcCV0fNK/rRa6oJ4+FJFJmAxXTjQ1SaGAWZtAdYoLoA/FeSUvIhaghaox+2nYiuw7KtP4rN9NV1sn04Uu83bJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RAKxIgrIiJbnq3XrIa51rkd099rZn5kMoxrSLhI1Qltlzul1
	FAV1IzI08kTaVLTvhhrq24+YZEmIYuSuPPOE9Z5sf/beq98Jg39QIpi9q9lGGrIcz5RfJ806gt5
	fBx5geZSJlDyB8gi/jnRIgeYri2k=
X-Gm-Gg: ASbGncsoDcu2dnIlVmMO9uTB9USH5+xVwqcoRYgu4pjh/vDYn/BRGicLr4XgCdoe1or
	a/p0Cxm3ROH7K8dvk0Ckv2bC5jXAgLYTsJXG7hLEdc6/ZVcEws9wLdYnGr8mSzqEAIhZvnoLz
X-Google-Smtp-Source: AGHT+IH/dkfL9G4qWTOhQNNACg6080iuKQTfgC0lmAS93YcRthHaPM3UODQo8TUuUW0Qn87AVxdPag77GDoHEWwgpCY=
X-Received: by 2002:a05:6402:2390:b0:5dc:71f6:9710 with SMTP id
 4fb4d7f45d1cf-5dc71f6989dmr18297727a12.11.1738666723547; Tue, 04 Feb 2025
 02:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223205.861346-1-amir73il@gmail.com> <20250203223205.861346-2-amir73il@gmail.com>
 <20250204-drehleiter-kehlkopf-ebfb51587558@brauner>
In-Reply-To: <20250204-drehleiter-kehlkopf-ebfb51587558@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 4 Feb 2025 11:58:32 +0100
X-Gm-Features: AWEUYZn-puVU8VYm95oHnS2TtP2aVO_Z9byDhGlXoGy96pOuomwAczCADA8pTdM
Message-ID: <CAOQ4uxhKJ2fyiV5uZe4TcOmfLayKYgs1Rr3LyMyDa337qTvjZw@mail.gmail.com>
Subject: Re: [PATCH 1/3] fsnotify: use accessor to set FMODE_NONOTIFY_*
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alex Williamson <alex.williamson@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:43=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Feb 03, 2025 at 11:32:03PM +0100, Amir Goldstein wrote:
> > The FMODE_NONOTIFY_* bits are a 2-bits mode.  Open coding manipulation
> > of those bits is risky.  Use an accessor file_set_fsnotify_mode() to
> > set the mode.
> >
> > Rename file_set_fsnotify_mode() =3D> file_set_fsnotify_mode_from_watche=
rs()
> > to make way for the simple accessor name.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  drivers/tty/pty.c        |  2 +-
> >  fs/notify/fsnotify.c     | 18 ++++++++++++------
> >  fs/open.c                |  7 ++++---
> >  include/linux/fs.h       |  9 ++++++++-
> >  include/linux/fsnotify.h |  4 ++--
> >  5 files changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> > index df08f13052ff4..8bb1a01fef2a1 100644
> > --- a/drivers/tty/pty.c
> > +++ b/drivers/tty/pty.c
> > @@ -798,7 +798,7 @@ static int ptmx_open(struct inode *inode, struct fi=
le *filp)
> >       nonseekable_open(inode, filp);
> >
> >       /* We refuse fsnotify events on ptmx, since it's a shared resourc=
e */
> > -     filp->f_mode |=3D FMODE_NONOTIFY;
> > +     file_set_fsnotify_mode(filp, FMODE_NONOTIFY);
> >
> >       retval =3D tty_alloc_file(filp);
> >       if (retval)
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 8ee495a58d0ad..77a1521335a10 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -648,7 +648,7 @@ EXPORT_SYMBOL_GPL(fsnotify);
> >   * Later, fsnotify permission hooks do not check if there are permissi=
on event
> >   * watches, but that there were permission event watches at open time.
> >   */
> > -void file_set_fsnotify_mode(struct file *file)
> > +void file_set_fsnotify_mode_from_watchers(struct file *file)
> >  {
> >       struct dentry *dentry =3D file->f_path.dentry, *parent;
> >       struct super_block *sb =3D dentry->d_sb;
> > @@ -665,7 +665,7 @@ void file_set_fsnotify_mode(struct file *file)
> >        */
> >       if (likely(!fsnotify_sb_has_priority_watchers(sb,
> >                                               FSNOTIFY_PRIO_CONTENT))) =
{
> > -             file->f_mode |=3D FMODE_NONOTIFY_PERM;
> > +             file_set_fsnotify_mode(file, FMODE_NONOTIFY_PERM);
> >               return;
> >       }
> >
> > @@ -676,7 +676,7 @@ void file_set_fsnotify_mode(struct file *file)
> >       if ((!d_is_dir(dentry) && !d_is_reg(dentry)) ||
> >           likely(!fsnotify_sb_has_priority_watchers(sb,
> >                                               FSNOTIFY_PRIO_PRE_CONTENT=
))) {
> > -             file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> > +             file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
> >               return;
> >       }
> >
> > @@ -686,19 +686,25 @@ void file_set_fsnotify_mode(struct file *file)
> >        */
> >       mnt_mask =3D READ_ONCE(real_mount(file->f_path.mnt)->mnt_fsnotify=
_mask);
> >       if (unlikely(fsnotify_object_watched(d_inode(dentry), mnt_mask,
> > -                                  FSNOTIFY_PRE_CONTENT_EVENTS)))
> > +                                  FSNOTIFY_PRE_CONTENT_EVENTS))) {
> > +             /* Enable pre-content events */
> > +             file_set_fsnotify_mode(file, 0);
> >               return;
> > +     }
> >
> >       /* Is parent watching for pre-content events on this file? */
> >       if (dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) {
> >               parent =3D dget_parent(dentry);
> >               p_mask =3D fsnotify_inode_watches_children(d_inode(parent=
));
> >               dput(parent);
> > -             if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS)
> > +             if (p_mask & FSNOTIFY_PRE_CONTENT_EVENTS) {
> > +                     /* Enable pre-content events */
> > +                     file_set_fsnotify_mode(file, 0);
> >                       return;
> > +             }
> >       }
> >       /* Nobody watching for pre-content events from this file */
> > -     file->f_mode |=3D FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> > +     file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
> >  }
> >  #endif
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index 932e5a6de63bb..3fcbfff8aede8 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -905,7 +905,8 @@ static int do_dentry_open(struct file *f,
> >       f->f_sb_err =3D file_sample_sb_err(f);
> >
> >       if (unlikely(f->f_flags & O_PATH)) {
> > -             f->f_mode =3D FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
> > +             f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > +             file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> >               f->f_op =3D &empty_fops;
> >               return 0;
> >       }
> > @@ -938,7 +939,7 @@ static int do_dentry_open(struct file *f,
> >        * If FMODE_NONOTIFY was already set for an fanotify fd, this doe=
sn't
> >        * change anything.
> >        */
> > -     file_set_fsnotify_mode(f);
> > +     file_set_fsnotify_mode_from_watchers(f);
> >       error =3D fsnotify_open_perm(f);
> >       if (error)
> >               goto cleanup_all;
> > @@ -1122,7 +1123,7 @@ struct file *dentry_open_nonotify(const struct pa=
th *path, int flags,
> >       if (!IS_ERR(f)) {
> >               int error;
> >
> > -             f->f_mode |=3D FMODE_NONOTIFY;
> > +             file_set_fsnotify_mode(f, FMODE_NONOTIFY);
> >               error =3D vfs_open(path, f);
> >               if (error) {
> >                       fput(f);
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index be3ad155ec9f7..e73d9b998780d 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -206,6 +206,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff=
_t offset,
> >   * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) event=
s.
> >   * FMODE_NONOTIFY | FMODE_NONOTIFY_PERM - suppress only pre-content ev=
ents.
> >   */
> > +#define FMODE_NONOTIFY_HSM \
> > +     (FMODE_NONOTIFY | FMODE_NONOTIFY_PERM)
>
> After this patch series this define is used exactly twice and it's
> currently identical to FMODE_FSNOTIFY_HSM. I suggest to remove it and
> simply pass FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the two places it's
> used. I can do this myself though so if Jan doesn't have other comments
> don't bother resending.
>

I thought that
file_set_fsnotify_mode(file, FMODE_NONOTIFY_HSM);
is more readable then
file_set_fsnotify_mode(FMODE_NONOTIFY | FMODE_NONOTIFY_PERM);
and makes it clearer that the individual bits should not be messed with

but since Jan was one who pushed for open coding
f->f_mode =3D FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
I think he will agree with you,
so I humbly accept your suggestion :)

Thanks,
Amir.

