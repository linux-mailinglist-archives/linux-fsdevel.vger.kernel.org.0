Return-Path: <linux-fsdevel+bounces-7877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5198082C1F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B80B1F24EEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038046DD09;
	Fri, 12 Jan 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS9Jgkxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7064CC7
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67fb9df3699so42859226d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 06:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705070177; x=1705674977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4zeTiKN7U6aUirollZs1qGwOU4SZbrVpEz4emzjoFQ=;
        b=bS9Jgkxc246i8n+0XzBeO5e58wPyZV0MpvYFpO72aPCiP/wbXGxUO7nImpqfpwOlj6
         Vsf5oAThe7X3uVi9KsLSBE3oojlON7MwqojoTEaU7FbG3lxdlmmusyYCwYD9qYGua8Ws
         NbDd/wfo291pNyw4czBHPNGatcijB19pL/LYTvF9Vcvj6NI+2DIzfMGR5UGfzLVnOkio
         XLPgaCEz+B0EFbYN5sJNFrP5iUHxfN5/ftrGi9YeO0WfcJhhPfppb8dHWn0ewjaaj9pu
         wu9blAbalJrlZw/Wo53bJCmOwi8Di4OCv2455yL11GSGqh9o++6ocYNCF09sgdLqy2xo
         9rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705070177; x=1705674977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4zeTiKN7U6aUirollZs1qGwOU4SZbrVpEz4emzjoFQ=;
        b=kxoInpsfy8R0S/rqDajbifW9iksrD1pWsqWKyJ56+6t/sZMUjndnCLCc0/PKWwTCqp
         s2pCHdYbFmCKZfcyyQy0CFpbWlcRmlA9zlwnsxNQgmFTDZoMKx6G0AFOj6ZzHP+TErEw
         /rA8tMlofHbHXosBM+FGAp7EdBn9frzA1GYUXm3WtYnsH6ucn5gaRwR2UGRa4+XJAK3C
         8UdJ1jraBfB1/HgQ0T46eETGqYreB+29fCWDkpNeaaCSgXbGBNJbKZl0yEh5MzJ1CnUw
         a36hRRtSUvJXg5vo+9HyjBYQCSqnGcntP5P4/vIyOvcWT3Sct7VthWzTIrBJjHBbcmGM
         /i6g==
X-Gm-Message-State: AOJu0YxWHkDGUAe26aLFB1uogrQAUU7OSTKCVS/+f8DyNY8i2W76tJYi
	bQ65Hj3Hi7w2FAqBnueg6UNfRrh0ng7+pQQjUy8=
X-Google-Smtp-Source: AGHT+IGLvlBF0Hj+Kn9uviOM/PemjcOtzw9Y7VVbRr2RkYVwgNys9R4+8zO3N2TBIGzGJbSSfHovfaK5DorX5YJ2Itc=
X-Received: by 2002:a05:6214:76b:b0:67f:7109:786e with SMTP id
 f11-20020a056214076b00b0067f7109786emr1132301qvz.123.1705070176727; Fri, 12
 Jan 2024 06:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111152233.352912-1-amir73il@gmail.com> <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
 <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk> <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
In-Reply-To: <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Jan 2024 16:36:05 +0200
Message-ID: <CAOQ4uxgzvz9XE4eMLaRt4Jkg-o4+mTQvgbHrayx27ku2ONGfPg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event watchers
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 4:11=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/12/24 6:58 AM, Jens Axboe wrote:
> > On 1/12/24 6:00 AM, Amir Goldstein wrote:
> >> On Fri, Jan 12, 2024 at 1:09?PM Jan Kara <jack@suse.cz> wrote:
> >>>
> >>> On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
> >>>> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any=
 type")
> >>>> optimized the case where there are no fsnotify watchers on any of th=
e
> >>>> filesystem's objects.
> >>>>
> >>>> It is quite common for a system to have a single local filesystem an=
d
> >>>> it is quite common for the system to have some inotify watches on so=
me
> >>>> config files or directories, so the optimization of no marks at all =
is
> >>>> often not in effect.
> >>>>
> >>>> Content event (i.e. access,modify) watchers on sb/mount more rare, s=
o
> >>>> optimizing the case of no sb/mount marks with content events can imp=
rove
> >>>> performance for more systems, especially for performance sensitive i=
o
> >>>> workloads.
> >>>>
> >>>> Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with conten=
t
> >>>> events in their mask exist and use that flag to optimize out the cal=
l to
> >>>> __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
> >>>>
> >>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >>>
> >>> ...
> >>>
> >>>> -static inline int fsnotify_file(struct file *file, __u32 mask)
> >>>> +static inline int fsnotify_path(const struct path *path, __u32 mask=
)
> >>>>  {
> >>>> -     const struct path *path;
> >>>> +     struct dentry *dentry =3D path->dentry;
> >>>>
> >>>> -     if (file->f_mode & FMODE_NONOTIFY)
> >>>> +     if (!fsnotify_sb_has_watchers(dentry->d_sb))
> >>>>               return 0;
> >>>>
> >>>> -     path =3D &file->f_path;
> >>>> +     /* Optimize the likely case of sb/mount/parent not watching co=
ntent */
> >>>> +     if (mask & FSNOTIFY_CONTENT_EVENTS &&
> >>>> +         likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)=
) &&
> >>>> +         likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) =
{
> >>>> +             /*
> >>>> +              * XXX: if SB_I_CONTENT_WATCHED is not set, checking f=
or content
> >>>> +              * events in s_fsnotify_mask is redundant, but it will=
 be needed
> >>>> +              * if we use the flag FS_MNT_CONTENT_WATCHED to indica=
te the
> >>>> +              * existence of only mount content event watchers.
> >>>> +              */
> >>>> +             __u32 marks_mask =3D d_inode(dentry)->i_fsnotify_mask =
|
> >>>> +                                dentry->d_sb->s_fsnotify_mask;
> >>>> +
> >>>> +             if (!(mask & marks_mask))
> >>>> +                     return 0;
> >>>> +     }
> >>>
> >>> So I'm probably missing something but how is all this patch different=
 from:
> >>>
> >>>         if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED=
))) {
> >>>                 __u32 marks_mask =3D d_inode(dentry)->i_fsnotify_mask=
 |
> >>>                         path->mnt->mnt_fsnotify_mask |
> >>
> >> It's actually:
> >>
> >>                           real_mount(path->mnt)->mnt_fsnotify_mask
> >>
> >> and this requires including "internal/mount.h" in all the call sites.
> >>
> >>>                         dentry->d_sb->s_fsnotify_mask;
> >>>                 if (!(mask & marks_mask))
> >>>                         return 0;
> >>>         }
> >>>
> >>> I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent even=
ts
> >>> (read & write) we care about. In Jens' case
> >>>
> >>>         !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
> >>>         !(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)
> >>>
> >>> is true as otherwise we'd go right to fsnotify_parent() and so Jens
> >>> wouldn't see the performance benefit. But then with your patch you fe=
tch
> >>> i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
> >>> difference to what I suggest above is the path->mnt->mnt_fsnotify_mas=
k
> >>> fetch but that is equivalent to sb->s_iflags (or wherever we store th=
at
> >>> bit) fetch?
> >>>
> >>> So that would confirm that the parent handling costs in fsnotify_pare=
nt()
> >>> is what's really making the difference and just avoiding that by chec=
king
> >>> masks early should be enough?
> >>
> >> Can't the benefit be also related to saving a function call?
> >>
> >> Only one way to find out...
> >>
> >> Jens,
> >>
> >> Can you please test attached v3 with a non-inlined fsnotify_path() hel=
per?
> >
> > I can run it since it doesn't take much to do that, but there's no way
> > parallel universe where saving a function call would yield those kinds
> > of wins (or have that much cost).
>
> Ran this patch, and it's better than mainline for sure, but it does have
> additional overhead that the previous version did not:
>
>                +1.46%  [kernel.vmlinux]  [k] fsnotify_path
>

That is what I suspected would happen.

So at this time, we have patch v2 which looks like a clear win.
It uses a slightly hackish SB_I_CONTENT_WATCHED to work around
the fact that real_mount() is not accessible to the inlined call sites.

With a little more effort, we can move SB_I_CONTENT_WATCHED
into the s_fsnotify_mask, but TBH, I don't know if moving it is worth
the effort because right now, SB_I_CONTENT_WATCHED would
be really rare and with HSM events, an sb really does behave in
slightly different ways, so it might not be such a bad idea to mark
the sb and publish this state to all the subsystems with an s_iflags.

If folks agree to keeping SB_I_CONTENT_WATCHED, we would
need to protect from a rare concurrent update with
SB_I_TS_EXPIRY_WARNED flag.

Jan, what do you think?

Thanks,
Amir.

