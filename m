Return-Path: <linux-fsdevel+bounces-21602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE35E906523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9731F24BB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2A13C3EE;
	Thu, 13 Jun 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfbGT37W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421F13BC0D;
	Thu, 13 Jun 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263875; cv=none; b=hHzPZN0hXkqC7qS3GAQhLhuzFdkxFV3hWmNFuvCVYQB2P34w43nge4kr+M3jOIVGKbqOYJYjhtHy7WDqZIu5qK2obmxD0eAsy9TxuWcOvbK+ETIyK5B7sRL0umgJ9YONSAaleydzELTLgnJrmMqVStKZiS4Zb+h/jZ9z8fQLvd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263875; c=relaxed/simple;
	bh=CR2vCZ7zdRzX00CQQ42G136ShNwfvXLPurS6gkUl8JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVpLlAOyPgECSX5TE78QMk0q/BWZHXrpmY6a+tvOiMPEtE5p4O4cWar38+HecKUQfZivV10d/wUkLrEvhvgJ08jhkwH/MgsPh5Lx9ZcjWWt/RarccuvAGpxOuKX8F/KsbLYwMhPaPDQ0macaKPxUweza2i2WMns7DqsDepQOCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfbGT37W; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b0745efaeeso3530356d6.1;
        Thu, 13 Jun 2024 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718263872; x=1718868672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5UwcZQgMEQIOp6sHS8xrUu+ogF+oqd67ekyxw5sYR8=;
        b=kfbGT37Wp/FKNgCMJl4NNBl0M3jf5MxfYrQGnLXGEZYeQiP9D3mJP2/XsaKTwOYrZ9
         zgIGrHQKmtQWaP5l+chM5u4qMV1+yElvHBD23mkDHfWvHMn0pagfp5gCBfvyfTrZ3su4
         JLrJkq4cDYcKPjppSHbJTSaaMvMiyxNh7INPm2pG9ctN/kLvPcLIXVyQjBbWWZG2+XAj
         SFN8ZRIYfV+fhx6CYOXPyp/jFw5wBj3Dz9GXfDt+0BWRioOi3Jtq3MPji2dEX0oiAENI
         BFmwkv9kkY0IHUORerg9i8FLenqO2jwkvBdokbneqEbij2wXGbNp5pNRxwrCQfzIXpNd
         okPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263872; x=1718868672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5UwcZQgMEQIOp6sHS8xrUu+ogF+oqd67ekyxw5sYR8=;
        b=dkIQjtacWdNCVUjdZyNZH1ndI9UERZIfcShRdD2sbF838wAyv0Ig4xLrmzDSuM/9cm
         r9dkYJLEImlVy8J+stFmwletcLoI+S6136HAmzo0dM+iKaDsC2L0q2es/m4U79ZujWAQ
         d4YLtK7ZKiBzhmy1Dfh+l5muJUDP8L6rLKhbYw20+frrQyRwgHBhKaT/zK0VvuXKjLiQ
         9hfSqZfQvWfpssCS3Au0L/LA3UC4RmOMvbHOxeOc/uE8wC60mR2eTlqtDdRk7ruYX9rR
         RvMdZGfohtq5FtNHrepbiM6RgpmQGIwGl7XiWUaCW8N1Ko4eKY8HAlKGuVCnygOg4l4V
         nJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjJsG1SmX+w706/c+prPXcOOm/zrBY5ahl536nnxNS5lm6HgkxAyIf9AvOhdj1yVz/WD1hO+QDIUirILF8DvCDTmt6uu3VDbxjIwgBCtaENWwayPqVHYl8KkNS7ISncTTeI8yu6VFCR+NV4u2pIjwV+OXZZu2NFDZZEBjuEl63wckYnjSSmA==
X-Gm-Message-State: AOJu0Yzlih9cMILX0hL3aMpCW8UVrVw5jvkJH9aVj6ZWjq+KXmACPGg3
	LHYkuM/Muvid4wqJQj/XFK/AvEDegNHUw2C+tJjHtJziZNIW2rCwHwrMLwGowKhW/BYUmczpLzy
	GSmcVh3CXV8LphusbJhHwZ4Lod3c=
X-Google-Smtp-Source: AGHT+IFbpfSFMJuePaJond8yuZhV+5vlXbm32Wex30d26dnEELli5NckMHvLs+Y0Jk01EnL5twKPzTrAxlrNY5sg50U=
X-Received: by 2002:a05:6214:4a89:b0:6b0:825e:ab71 with SMTP id
 6a1803df08f44-6b191778be9mr51179626d6.1.1718263872153; Thu, 13 Jun 2024
 00:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171817619547.14261.975798725161704336@noble.neil.brown.name> <20240612-nennung-ungnade-ae9bdc5f8c4c@brauner>
In-Reply-To: <20240612-nennung-ungnade-ae9bdc5f8c4c@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Jun 2024 10:31:00 +0300
Message-ID: <CAOQ4uxgSje5Trq7CySjf7M6F92y3J2NNZihP1jzQU2n-2RNKSA@mail.gmail.com>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	James Clark <james.clark@arm.com>, ltp@lists.linux.it, linux-nfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 4:53=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Jun 12, 2024 at 05:09:55PM +1000, NeilBrown wrote:
> >
> > When a file is opened and created with open(..., O_CREAT) we get
> > both the CREATE and OPEN fsnotify events and would expect them in that
> > order.   For most filesystems we get them in that order because
> > open_last_lookups() calls fsnofify_create() and then do_open() (from
> > path_openat()) calls vfs_open()->do_dentry_open() which calls
> > fsnotify_open().
> >
> > However when ->atomic_open is used, the
> >    do_dentry_open() -> fsnotify_open()
> > call happens from finish_open() which is called from the ->atomic_open
> > handler in lookup_open() which is called *before* open_last_lookups()
> > calls fsnotify_create.  So we get the "open" notification before
> > "create" - which is backwards.  ltp testcase inotify02 tests this and
> > reports the inconsistency.
> >
> > This patch lifts the fsnotify_open() call out of do_dentry_open() and
> > places it higher up the call stack.  There are three callers of
> > do_dentry_open().
> >
> > For vfs_open() and kernel_file_open() the fsnotify_open() is placed
> > directly in that caller so there should be no behavioural change.
> >
> > For finish_open() there are two cases:
> >  - finish_open is used in ->atomic_open handlers.  For these we add a
> >    call to fsnotify_open() at the top of do_open() if FMODE_OPENED is
> >    set - which means do_dentry_open() has been called.
> >  - finish_open is used in ->tmpfile() handlers.  For these a similar
> >    call to fsnotify_open() is added to vfs_tmpfile()
> >
> > With this patch NFSv3 is restored to its previous behaviour (before
> > ->atomic_open support was added) of generating CREATE notifications
> > before OPEN, and NFSv4 now has that same correct ordering that is has
> > not had before.  I haven't tested other filesystems.
> >
> > Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC =
correctly.")

I think it is better to add (also?)
Fixes: 7b8c9d7bb457 ("fsnotify: move fsnotify_open() hook into
do_dentry_open()")
because this is when the test case was regressed for other atomic_open() fs

> > Reported-by: James Clark <james.clark@arm.com>
> > Closes: https://lore.kernel.org/all/01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c=
8@arm.com
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
>
> We should take this is a bugfix because it doesn't change behavior.
>

I agree.
I would love for this to be backported to at least v6.9.y
because FAN_CREATE events supported on fuse,nfs, (zero f_fsid)
only since v6.8, which triggered my fix to fanotify16 LTP test.

> But then we should follow this up with a patch series that tries to
> rectify the open/close imbalance because I find that pretty ugly. That's
> at least my opinion.
>
> We should aim to only generate an open event when may_open() succeeds
> and don't generate a close event when the open has failed. Maybe:
>
> +#ifdef CONFIG_FSNOTIFY
> +#define file_nonotify(f) ((f)->f_mode |=3D __FMODE_NONOTIFY)
> +#else
> +#define file_nonotify(f) ((void)(f))
> +#endif
>
> will do.

Why bother with the ifdef? __FMODE_NONOTIFY is always defined.

Maybe something like this (untested partial patch):


+static inline int fsnotify_open_error(struct file *f, int error)
+{
+       /*
+        * Once we return a file with FMODE_OPENED, __fput() will call
+        * fsnotify_close(), so we need to either call fsnotify_open() or
+        * set __FMODE_NONOTIFY to suppress fsnotify_close() for symmetry.
+        */
+       if (error)
+               f->f_mode |=3D __FMODE_NONOTIFY;
+       else
+               fsnotify_open(f);
+       return error;
+}
+
 static int do_dentry_open(struct file *f,
                          int (*open)(struct inode *, struct file *))
 {
@@ -1004,11 +1018,6 @@ static int do_dentry_open(struct file *f,
                }
        }

-       /*
-        * Once we return a file with FMODE_OPENED, __fput() will call
-        * fsnotify_close(), so we need fsnotify_open() here for symmetry.
-        */
-       fsnotify_open(f);
        return 0;

 cleanup_all:
@@ -1085,8 +1094,11 @@ EXPORT_SYMBOL(file_path);
  */
 int vfs_open(const struct path *path, struct file *file)
 {
+       int error;
+
        file->f_path =3D *path;
-       return do_dentry_open(file, NULL);
+       error =3D do_dentry_open(file, NULL);
+       return fsnotify_open_error(file, error);
 }

 struct file *dentry_open(const struct path *path, int flags,
@@ -1175,6 +1187,7 @@ struct file *kernel_file_open(const struct path
*path, int flags,

        f->f_path =3D *path;
        error =3D do_dentry_open(f, NULL);
+       fsnotify_open_error(f, error);
        if (error) {
                fput(f);
                f =3D ERR_PTR(error);


>
> Basic open permissions failing should count as failure to open and thus
> also turn of a close event.
>
> The somewhat ugly part is imho that security hooks introduce another
> layer of complexity. While we do count security_file_permission() as
> a failure to open we wouldn't e.g., count security_file_post_open() as a
> failure to open (Though granted here that "*_post_open()" makes it
> easier.). But it is really ugly that LSMs get to say "no" _after_ the
> file has been opened. I suspect this is some IMA or EVM thing where they
> hash the contents or something but it's royally ugly and I complained
> about this before. But maybe such things should just generate an LSM
> layer event via fsnotify in the future (FSNOTIFY_MAC) or something...
> Then userspace can see "Hey, the VFS said yes but then the MAC stuff
> said no."

Not sure what IMA/EVM needs so cannot comment about this proposal.

Thanks,
Amir.

