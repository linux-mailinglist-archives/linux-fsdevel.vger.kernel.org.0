Return-Path: <linux-fsdevel+bounces-21822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30F90B241
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0CA1F21621
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D8A1BE244;
	Mon, 17 Jun 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxhy3icL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AA1BD512;
	Mon, 17 Jun 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632210; cv=none; b=CBItUyCUpZBjorcoD9oFTrMMgA40i3Ej3ddYZHgdF6MbJfue3I5fZhwPJfVmpxA4W3SRjhcHtsSXZc3UjClHlmMJ7GON4LnNXM4l62SbCECw1y2s3//etrzBxmFHeJgQ3rixCL/QKm+ioBTJxboPtt3uf1L/kZDy371Q1NgD67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632210; c=relaxed/simple;
	bh=YMzX6ooz3JsUkie/XsaWHUpwkokp4Qo3s799ez1M10k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9hLFVVx21HcnpKksvV4oHkc8mB+41tgTZ3j7sTFGCMvmtQ1Oqdv8vwHeedxqpS0Qac36b764ICFAs8/IxSkMDfx56ZAic8XqOKRtTI2JD8hWskR+PM4kM1ZgD2xS9ZxlHqi7+vdpTNHnop+m3PEY2wxPPXQ80wJZ2f6F6Bud00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxhy3icL; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-797f222c9f9so258853385a.3;
        Mon, 17 Jun 2024 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718632208; x=1719237008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uafBfjF9BGnnEyoetBs+q1J93YDTYA8APT02I3KvMtE=;
        b=Nxhy3icLkBssqMVHYTgQ8Ui8UvA7suNaUBJnqH4k21CYQCcrl33wqfkNV3+5LaGzew
         euLby8ixiYfcefNKUnvJ0TaN56DQnFDcMPhx/5N8+lphG62KI85glh29d7g9YX205hsk
         BwXJOBK8OtL+Ryeoqc4LbIoTKqy+WcyMh0HcE4SdEmUVgTe+22zIxTBiGoCyF8290CG7
         8IlMvCzu45p9J/kZFtM96ld2zo+RE9qfWrOmyrVEzag+QHQvLDlnWg3N/xUygEGpRRv1
         M4jyclhZEprsOTzKGe4CEZidT6vXqgVTFGMzAssxbzZwAjnyCKdAZ/Jh0hY2kgtQ+3g3
         o+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632208; x=1719237008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uafBfjF9BGnnEyoetBs+q1J93YDTYA8APT02I3KvMtE=;
        b=vJ4YBG769tHuAJUOQwjk2VTpUsssOKGWYjfAhqMG0PVTmR053d/vVbtl2UWva+aP8p
         ZBjhNc6YKvoqwhOM6rbZrrC8ke8tlCP44v6ddDCjXvbxdYgz/Xpg61PvyWQhcQ0uTMO+
         VF4oVDyNjQRLzMnnsyX4ADDkAGcyxQi5zMdzfDr+Qt9vEhrWfVhgmMoVm1lKnh+cQ7YY
         TjRvtg4tNJMya05Nn4Gh183WhAYw42X2rGoJHNwahLLldkwr61UDVjWBsJKUiYYUHS0Z
         EI1V7e8vP2gANIdEmjPMTvzqvjVwWxBvGYYyNhz1cn7UejQNFzKWoJlx/rN7Nklrrqww
         /ASg==
X-Forwarded-Encrypted: i=1; AJvYcCXWOjFeVJhe9xKxk8RwF5MzJazlAeaf2XNwifts5zihYQjcR5xcO1V8VtJ6qjYLseFthlXof3fcNKC5eYkCIZXNzXV28TeG+2LGXkXE3AUNn2O0QoPzmj1O/WIxuf8h2eyuRoWgg9/Fpe8z0/hlh8Fl8J8lm/2hTAAaG/nFDumYVyI9ndO41w==
X-Gm-Message-State: AOJu0YwN1YcOTLLxLq7ILxCPpBMqaomdbYBZ0wL4/2X4L898qTwoXSrC
	MTNlx8wp2BV80oXSNGDgilTldTgXUgYf3pRSTcEvvUnBAm80IE2s+yCN7HEDiFNhRpDsT8JzKM1
	4H08TR4qOwQXFXZXNdQN2KZxHsQg=
X-Google-Smtp-Source: AGHT+IFCVTLsrP0x9BXCG8zvXI+ugi8pb1IfH41pX+8htWWGkprkwbA7/blxrVWGjWHUC+ygmzazhT+4NLZm8CQ6DtM=
X-Received: by 2002:a05:620a:318b:b0:795:4cc8:6dba with SMTP id
 af79cd13be357-798d269406emr1165225485a.58.1718632207841; Mon, 17 Jun 2024
 06:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
 <20240615-fahrrad-bauordnung-a349bacd8c82@brauner> <20240617093745.nhnc7e7efdldnjzl@quack3>
 <CAOQ4uxiN3JnH-oJTw63rTR_B8oPBfB7hWyun0Hsb3ZX3AORf2g@mail.gmail.com> <20240617130739.ki5tpsbgvhumdrla@quack3>
In-Reply-To: <20240617130739.ki5tpsbgvhumdrla@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Jun 2024 16:49:55 +0300
Message-ID: <CAOQ4uxhGD563ye9F=+m_gcaDuYJPbD1mbwmtm0y476Oxe5fH6Q@mail.gmail.com>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>, James Clark <james.clark@arm.com>, 
	ltp@lists.linux.it, linux-nfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:07=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 17-06-24 15:09:09, Amir Goldstein wrote:
> > On Mon, Jun 17, 2024 at 12:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Sat 15-06-24 07:35:42, Christian Brauner wrote:
> > > > On Wed, 12 Jun 2024 17:09:55 +1000, NeilBrown wrote:
> > > > > When a file is opened and created with open(..., O_CREAT) we get
> > > > > both the CREATE and OPEN fsnotify events and would expect them in=
 that
> > > > > order.   For most filesystems we get them in that order because
> > > > > open_last_lookups() calls fsnofify_create() and then do_open() (f=
rom
> > > > > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > > > > fsnotify_open().
> > > > >
> > > > > [...]
> > > >
> > > > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > > > Patches in the vfs.fixes branch should appear in linux-next soon.
> > > >
> > > > Please report any outstanding bugs that were missed during review i=
n a
> > > > new review to the original patch series allowing us to drop it.
> > > >
> > > > It's encouraged to provide Acked-bys and Reviewed-bys even though t=
he
> > > > patch has now been applied. If possible patch trailers will be upda=
ted.
> > > >
> > > > Note that commit hashes shown below are subject to change due to re=
base,
> > > > trailer updates or similar. If in doubt, please check the listed br=
anch.
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > > branch: vfs.fixes
> > > >
> > > > [1/1] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open use=
d.
> > > >       https://git.kernel.org/vfs/vfs/c/7536b2f06724
> > >
> > > I have reviewed the patch you've committed since I wasn't quite sure =
which
> > > changes you're going to apply after your discussion with Amir. And I =
have
> > > two comments:
> > >
> > > @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
> > >   */
> > >  int vfs_open(const struct path *path, struct file *file)
> > >  {
> > > +       int ret;
> > > +
> > >         file->f_path =3D *path;
> > > -       return do_dentry_open(file, NULL);
> > > +       ret =3D do_dentry_open(file, NULL);
> > > +       if (!ret)
> > > +               /*
> > > +                * Once we return a file with FMODE_OPENED, __fput() =
will call
> > > +                * fsnotify_close(), so we need fsnotify_open() here =
for symmetry.
> > > +                */
> > > +               fsnotify_open(file);
> >
> > Please add { } around multi line indented text.
> >
> > > +       return ret;
> > >  }
> > >
> > > AFAICT this will have a side-effect that now fsnotify_open() will be
> > > generated even for O_PATH open. It is true that fsnotify_close() is g=
etting
> > > generated for them already and we should strive for symmetry. Concept=
ually
> > > it doesn't make sense to me to generate fsnotify events for O_PATH
> > > opens/closes but maybe I miss something. Amir, any opinion here?
> >
> > Good catch!
> >
> > I agree that we do not need OPEN nor CLOSE events for O_PATH.
> > I suggest to solve it with:
> >
> > @@ -915,7 +929,7 @@ static int do_dentry_open(struct file *f,
> >         f->f_sb_err =3D file_sample_sb_err(f);
> >
> >         if (unlikely(f->f_flags & O_PATH)) {
> > -               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > +               f->f_mode =3D FMODE_PATH | FMODE_OPENED | __FMODE_NONOT=
IFY;
> >                 f->f_op =3D &empty_fops;
> >                 return 0;
> >         }
>
> First I was somewhat nervous about this as it results in returning O_PATH
> fd with __FMODE_NONOTIFY to userspace and I was afraid it may influence
> generation of events *somewhere*.

It influences my POC code of future lookup permission event:
https://github.com/amir73il/linux/commits/fan_lookup_perm/
which is supposed to generate events on lookup with O_PATH fd.

> But checking a bit, we use 'file' for
> generating only open, access, modify, and close events so yes, this shoul=
d
> be safe. Alternatively we could add explicit checks for !O_PATH when
> generating open / close events.
>

So yeh, this would be better:

--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -112,7 +112,7 @@ static inline int fsnotify_file(struct file *file,
__u32 mask)
 {
        const struct path *path;

-       if (file->f_mode & FMODE_NONOTIFY)
+       if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
                return 0;

        path =3D &file->f_path;
--

It is a dilemma, if this patch should be separate.
On the one hand it fixes unbalanced CLOSE events on O_PATH fd,
so it is an independent fix.
OTOH, it is a requirement for moving fsnotify_open() out of
do_dentry_open(), so not so healthy to separate them, when it is less clear
that they need to be backported together.

> > > @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
> > >         int acc_mode;
> > >         int error;
> > >
> > > +       if (file->f_mode & FMODE_OPENED)
> > > +               fsnotify_open(file);
> > > +
> > >         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> > >                 error =3D complete_walk(nd);
> > >                 if (error)
> > >
> > > Frankly, this works but looks as an odd place to put this notificatio=
n to.
> > > Why not just placing it just next to where fsnotify_create() is gener=
ated
> > > in open_last_lookups()? Like:
> > >
> > >         if (open_flag & O_CREAT)
> > >                 inode_lock(dir->d_inode);
> > >         else
> > >                 inode_lock_shared(dir->d_inode);
> > >         dentry =3D lookup_open(nd, file, op, got_write);
> > > -       if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
> > > -               fsnotify_create(dir->d_inode, dentry);
> > > +       if (!IS_ERR(dentry)) {
> > > +               if (file->f_mode & FMODE_CREATED)
> > > +                       fsnotify_create(dir->d_inode, dentry);
> > > +               if (file->f_mode & FMODE_OPENED)
> > > +                       fsnotify_open(file);
> > > +       }
> > >         if (open_flag & O_CREAT)
> > >                 inode_unlock(dir->d_inode);
> > >         else
> > >                 inode_unlock_shared(dir->d_inode);
> > >
> > > That looks like a place where it is much more obvious this is for
> > > atomic_open() handling? Now I admit I'm not really closely familiar w=
ith
> > > the atomic_open() paths so maybe I miss something and do_open() is be=
tter.
> >
> > It looks nice, but I think it is missing the fast lookup case without O=
_CREAT
> > (i.e. goto finish_lookup).
>
> I don't think so. AFAICT that case will generate the event in vfs_open()
> anyway and not in open_last_lookups() / do_open(). Am I missing something=
?

No. I am. This code is hard to follow.
I am fine with your variant, but maybe after so many in-tree changes
including the extra change of O_PATH, perhaps it would be better
to move this patch to your fsnotify tree?

Thanks,
Amir.

