Return-Path: <linux-fsdevel+bounces-34831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDF9C9143
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586C9B3CE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC5718B499;
	Thu, 14 Nov 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJMRhPzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950F6F2F3;
	Thu, 14 Nov 2024 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604959; cv=none; b=Ln4wId8SV2jRdVSGB1NJD9345+s4g1VMgTNw8ncZ6Hd9xKIMfUp5ByfLOwByXsehG3e2f0tWhzz+OZBGqEYTznLWOrQS8++tQT5XlikyoiLhYp55W3yRRhEg8mgcYn/Lrmv7SOIMOMf82cyY41MSUeNvMJTXbDe0Ima5McQ8huY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604959; c=relaxed/simple;
	bh=coBv7kOMWr4FUkylnULciwEVU/uk2ko3fjjBkmaG4ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhGNKJKD73gkjk3jXloxEzay6N//7FvE4EeVb1cTXVdnzpvahDykgFncHaXDAUlkBA0sHF/MStkEA3sUFWgu+pOHdWqzznUMeV6qrg/K6I45IwpQRED5wCR4BsI9zomwXuFj1nwIVgxhF7tywnVQZNDGAiPNcDE/xZ/zC7T1dfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJMRhPzX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b18da94ba9so72589185a.0;
        Thu, 14 Nov 2024 09:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604957; x=1732209757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeFJjr3sAvxDHgXGKvBlBBH/HNXVr6YZMX5uUHaIfVg=;
        b=LJMRhPzX4Z5H/E7IZAd45/5CNNvpFk1cfOJvSkUtyK2uPEzwDMY9QvGXNpPhmU/iWb
         TyRszd7nj7Orv64xYzEi1NpwGG1NbbmhHguT42t32Td0yXdxBklYtWl+6TlM6s54RYfN
         hRdkT6NEJrl4pck8VjtuG6vrYWJT702bOBuajgOaACd26cKMYwLOF+S79cvJJxUMOJ01
         45OOWti4pQEHygzaVWXsQmTHccJ9T8XEc+6yfgkYF30RhT4EdvA0FIAaADhbghqiDsrf
         r8rT1Eh3QMhq25/c9c5Us8F10Ip/azrzi2liyVlVEMUzuceno4dGUQdBn9I+HKOAVwUZ
         Do/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604957; x=1732209757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeFJjr3sAvxDHgXGKvBlBBH/HNXVr6YZMX5uUHaIfVg=;
        b=p3pcroDvtiIrKTg4unCugvnIuIl6IpWoLsX7WTJVJJY3dX7rKwBeYdNl8QOH88VeRz
         cp6vW/vlqD2IP23F4rDEsLnGCLZ3TAJuRsiHHA/+uLEmI+Ikp2C3a9Fycf5bR5cuXj3B
         MFQrwu7OU4MtWcizRpTiaGSMFSr8cegEHeB+fbpqMoYfv4IOR6SJarr21Nxc6nRh9uSo
         ObqhiL4yyNQNajsnyFSgZ+jeE/VJdOYvvdGDUxz3dt96SEpy268y6IT4dRyCtsp1zrp3
         nP8My1SjRIeye+UKeVU3p0LfWh/MeOONmAuzq6c2WIi+sdQHVlLXH8Uv0ygIJFHI1KwJ
         F7/A==
X-Forwarded-Encrypted: i=1; AJvYcCUo6BQ+FKpnR2DF+IND+bTcRqc32CY6PFV4UL9D+O/MNOatUH3YdgGJ5/IPvnOoxaHpyVWcsJyUctFy@vger.kernel.org, AJvYcCUzMghRXj9BhyFhHU7KF/bYsqfwlLtkE6TpB/YYpIO32hT8b86IgQDzAm3D5svFEfP7frk712lSp2t7X4bLng==@vger.kernel.org, AJvYcCWfZra3sszKrUF135SHzpXaufdGHbrb4UJI35mQKkbvEONHfE8cpC4gNFncU/F0P9HHC5regbwebsWvgA==@vger.kernel.org, AJvYcCXju8F9gT/0NpSoRBa+7M1jNVdszZwUjaJhqae3bstuK898sBvlu7gj+tYpEm8kR8HbY/vXvcqcuohSnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyjgy9wj0+QwXL48kBl3xbt7Jz0CucaxJxMewdB2lzgQwOlNBN
	KLYejlRm6xx2eJZjcfZdnc6jIzYqhlaCiM3jUWsEAhSsK25fkVCssInXaUfAjiP3KrpCEENEFd2
	CIu/DY+eMq4Zrbsx22pE1HFqabTE=
X-Google-Smtp-Source: AGHT+IGWy+vxnndz1151nIk1OoEYSziwAZ6Hll6nVis3K2RK0WbhxR9+FRkzy7ldvbq1Mbv1M4ojoumTX5Yaw3ABvqg=
X-Received: by 2002:a05:620a:2894:b0:7a9:abdf:f517 with SMTP id
 af79cd13be357-7b35a545fc5mr637868285a.25.1731604956930; Thu, 14 Nov 2024
 09:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <CAOQ4uxjob2qKk4MRqPeNtbhfdSfP0VO-R5VWw0txMCGLwJ-Z1g@mail.gmail.com>
 <CAHk-=wigQ0ew96Yv29tJUrUKBZRC-x=fDjCTQ7gc4yPys2Ngrw@mail.gmail.com>
 <CAOQ4uxjeWrJtcgsC0YEmjdMPBOOpfz=zQ9VuG=z-Sc6WYNJOjQ@mail.gmail.com> <20241114150127.clibtrycjd3ke5ld@quack3>
In-Reply-To: <20241114150127.clibtrycjd3ke5ld@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 18:22:25 +0100
Message-ID: <CAOQ4uxgNoDUcgSjo=oK6QmzCuEdgauDs2H6WGbD=RuzkZX115Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-11-24 19:49:31, Amir Goldstein wrote:
> > From 7a2cd74654a53684d545b96c57c9091e420b3add Mon Sep 17 00:00:00 2001
> > From: Amir Goldstein <amir73il@gmail.com>
> > Date: Tue, 12 Nov 2024 13:46:08 +0100
> > Subject: [PATCH] fsnotify: opt-in for permission events at file open ti=
me
> >
> > Legacy inotify/fanotify listeners can add watches for events on inode,
> > parent or mount and expect to get events (e.g. FS_MODIFY) on files that
> > were already open at the time of setting up the watches.
> >
> > fanotify permission events are typically used by Anti-malware sofware,
> > that is watching the entire mount and it is not common to have more tha=
t
> > one Anti-malware engine installed on a system.
> >
> > To reduce the overhead of the fsnotify_file_perm() hooks on every file
> > access, relax the semantics of the legacy FAN_ACCESS_PERM event to gene=
rate
> > events only if there were *any* permission event listeners on the
> > filesystem at the time that the file was opened.
> >
> > The new semantic is implemented by extending the FMODE_NONOTIFY bit int=
o
> > two FMODE_NONOTIFY_* bits, that are used to store a mode for which of t=
he
> > events types to report.
> >
> > This is going to apply to the new fanotify pre-content events in order
> > to reduce the cost of the new pre-content event vfs hooks.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwj8L=3DmtcRTi=3DNEC=
HMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Couple of notes below.
>
> > diff --git a/fs/open.c b/fs/open.c
> > index 226aca8c7909..194c2c8d8cd4 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -901,7 +901,7 @@ static int do_dentry_open(struct file *f,
> >       f->f_sb_err =3D file_sample_sb_err(f);
> >
> >       if (unlikely(f->f_flags & O_PATH)) {
> > -             f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > +             f->f_mode =3D FMODE_PATH | FMODE_OPENED | FMODE_NONOTIFY;
> >               f->f_op =3D &empty_fops;
> >               return 0;
> >       }
> > @@ -929,6 +929,12 @@ static int do_dentry_open(struct file *f,
> >       if (error)
> >               goto cleanup_all;
> >
> > +     /*
> > +      * Set FMODE_NONOTIFY_* bits according to existing permission wat=
ches.
> > +      * If FMODE_NONOTIFY was already set for an fanotify fd, this doe=
sn't
> > +      * change anything.
> > +      */
> > +     f->f_mode |=3D fsnotify_file_mode(f);
>
> Maybe it would be obvious to do this like:
>
>         file_set_fsnotify_mode(f);
>
> Because currently this depends on the details of how exactly FMODE_NONOTI=
FY
> is encoded.
>

ok. makes sense.

> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 70359dd669ff..dd583ce7dba8 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -173,13 +173,14 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, lo=
ff_t offset,
> >
> >  #define      FMODE_NOREUSE           ((__force fmode_t)(1 << 23))
> >
> > -/* FMODE_* bit 24 */
> > -
> >  /* File is embedded in backing_file object */
> > -#define FMODE_BACKING                ((__force fmode_t)(1 << 25))
> > +#define FMODE_BACKING                ((__force fmode_t)(1 << 24))
> > +
> > +/* File shouldn't generate fanotify pre-content events */
> > +#define FMODE_NONOTIFY_HSM   ((__force fmode_t)(1 << 25))
> >
> > -/* File was opened by fanotify and shouldn't generate fanotify events =
*/
> > -#define FMODE_NONOTIFY               ((__force fmode_t)(1 << 26))
> > +/* File shouldn't generate fanotify permission events */
> > +#define FMODE_NONOTIFY_PERM  ((__force fmode_t)(1 << 26))
> >
> >  /* File is capable of returning -EAGAIN if I/O will block */
> >  #define FMODE_NOWAIT         ((__force fmode_t)(1 << 27))
> > @@ -190,6 +191,21 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, lof=
f_t offset,
> >  /* File does not contribute to nr_files count */
> >  #define FMODE_NOACCOUNT              ((__force fmode_t)(1 << 29))
> >
> > +/*
> > + * The two FMODE_NONOTIFY_ bits used together have a special meaning o=
f
> > + * not reporting any events at all including non-permission events.
> > + * These are the possible values of FMODE_NOTIFY(f->f_mode) and their =
meaning:
> > + *
> > + * FMODE_NONOTIFY_HSM - suppress only pre-content events.
> > + * FMODE_NONOTIFY_PERM - suppress permission (incl. pre-content) event=
s.
> > + * FMODE_NONOTIFY - suppress all (incl. non-permission) events.
> > + */
> > +#define FMODE_NONOTIFY_MASK \
> > +     (FMODE_NONOTIFY_HSM | FMODE_NONOTIFY_PERM)
> > +#define FMODE_NONOTIFY FMODE_NONOTIFY_MASK
> > +#define FMODE_NOTIFY(mode) \
> > +     ((mode) & FMODE_NONOTIFY_MASK)
>
> This looks a bit error-prone to me (FMODE_NONOTIFY looks like another FMO=
DE
> flag but in fact it is not which is an invitation for subtle bugs) and th=
e
> tests below which are sometimes done as (FMODE_NOTIFY(mode) =3D=3D xxx) a=
nd
> sometimes as (file->f_mode & xxx) are inconsistent and confusing (unless =
you
> understand what's happening under the hood).
>
> So how about defining macros like FMODE_FSNOTIFY_NORMAL(),
> FMODE_FSNOTIFY_CONTENT() and FMODE_FSNOTIFY_PRE_CONTENT() which evaluate =
to
> true if we should be sending normal/content/pre-content events to the fil=
e.
> With appropriate comments this should make things more obvious.
>

ok, maybe something like this:

#define FMODE_FSNOTIFY_NONE(mode) \
        (FMODE_FSNOTIFY(mode) =3D=3D FMODE_NONOTIFY)
#define FMODE_FSNOTIFY_NORMAL(mode) \
        (FMODE_FSNOTIFY(mode) =3D=3D FMODE_NONOTIFY_PERM)
#define FMODE_FSNOTIFY_PERM(mode) \
        (!((mode) & FMODE_NONOTIFY_PERM))
#define FMODE_FSNOTIFY_HSM(mode) \
        (FMODE_FSNOTIFY(mode) =3D=3D 0)

At least keeping the double negatives contained in one place.

And then we have these users in the final code:

static inline bool fsnotify_file_has_pre_content_watches(struct file *file)
{
        return file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode));
}

static inline int fsnotify_open_perm(struct file *file)
{
        int ret;

        if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
                return 0;
...

static inline int fsnotify_file(struct file *file, __u32 mask)
{
        if (FMODE_FSNOTIFY_NONE(file->f_mode))
                return 0;
...

BTW, I prefer using PERM,HSM instead of the FSNOTIFY_PRIO_
names for brevity, but also because at the moment of this patch
FMODE_NONOTIFY_PERM means "suppress permission events
if there are no listeners with priority >=3D FSNOTIFY_PRIO_CONTENT
at all on any objects of the filesystem".

It does NOT mean that there ARE permission events watchers on the file's
sb/mnt/inode or parent, but what the users of the flag care about really is
whether the specific file is being watched for permission events.

I was contemplating if we should add the following check at open time
as following patches add for pre-content watchers also for
permission watchers on the specific file:

        /*
         * Permission events is a super set of pre-content events, so if th=
ere
         * are no permission event watchers, there are also no pre-content =
event
         * watchers and this is implied from the single FMODE_NONOTIFY_PERM=
 bit.
         */
        if (likely(!fsnotify_sb_has_priority_watchers(sb,
                                                FSNOTIFY_PRIO_CONTENT)))
                return FMODE_NONOTIFY_PERM;

+        /*
+         * There are content watchers in the filesystem, but are there
+         * permission event watchers on this specific file?
+         */
+        if (likely(!fsnotify_file_object_watched(file,
+                                                 ALL_FSNOTIFY_PERM_EVENTS)=
))
+                return FMODE_NONOTIFY_PERM;
+

I decided not to stretch the behavior change too much and also since
Anti-malware permission watchers often watch all the mounts of a
filesystem, there is probably little to gain from this extra check.
But we can reconsider this in the future.

WDYT?

In any case, IMO the language of FMODE_FSNOTIFY_PERM() matches
the meaning of the users better and makes the code easier to understand.

FMODE_FSNOTIFY_HSM() is debatable, but at least it is short ;)

Anyway, I will send v2 with your suggestions.

Thanks,
Amir.

