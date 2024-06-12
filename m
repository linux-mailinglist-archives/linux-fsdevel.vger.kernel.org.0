Return-Path: <linux-fsdevel+bounces-21521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B53905077
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 12:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2573E1F23697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 10:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD0816EBFA;
	Wed, 12 Jun 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYglZfeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD37BB19;
	Wed, 12 Jun 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188507; cv=none; b=Yq268k8uaiindXKiao6N/9qqQ1M7auNbDXZ0djIxzUiYUVU4hIt6lr6j32mo2LfJLeIjGDs3PGCtFVFOVsq8KAGMsbVpn2Xo5RSoaoyo+tRN8413pkmCbg2ZHcNP+GPtk8wylpbRquEk2C19Ug5aIS6DU0jZacd5k6CcLN7bylE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188507; c=relaxed/simple;
	bh=l6qWXOlYkiNh4aZueT78jx9WwtWf3q89ozgoiZSCKP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9dqdDYdPWclXPw0aU18g9bjGicjIQK4GzzBo822AfABnhAkVdavoNnIuSXbtGjZt3mj01busZlHgRxz1ApkSFdY38mXmcYvvhnBgUgxkA32nPHnOhrKnvjbPHruZj/UMxEv0M/S/CuOdw98M5zCXwzdVUFuIDhPA81+E+/ZACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYglZfeb; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80b9c393c8cso957477241.1;
        Wed, 12 Jun 2024 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718188505; x=1718793305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRlD9+JeJs697iLsuSWlTga8APWs4QACVErNO0SLQZ0=;
        b=mYglZfeba6kbFgBYdmOyYGF1ElwC638ccF8rYZrBFRZ4W1pyG5VbWBqTGRBzIrv1Pp
         Hno0DrU3vbXJ+/bXMwgiYc/HN2cR1VKTsX0GcplBwKQgpFaMLdTEB7C64GnFecqtVVPC
         VGVd3Pxl4k24hkllr3NPHduS9e+9i4iSWunY7oPH/c5a7uy5jwRx+80Ifj3O5zsvd6Hc
         IBQj3yEsNkUUH+a57uhcY+gbdTr2AKY7ul5B4koKp9PM3+KiXDUWXPow78nh60Gyz7eI
         cfOdY6hlvGaZVX9JP1K8lkk2CUfUBjz1dH3FBaWGHdf8dfc0vgbkSfOF4tWGDxLlFUx+
         2DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718188505; x=1718793305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRlD9+JeJs697iLsuSWlTga8APWs4QACVErNO0SLQZ0=;
        b=xExJJZK6Mx39yB92XXzOq/PFMMRFNyy7xp9yTkaot58lNNBokM9p62XtLk0LknCM5L
         tHUnK6+Z+amrpIwf3SryuN7dR9QPfvmVZ8xp5PAflRoM+GtQMZ1DBTBTwtblLK+F7OVc
         258915/1R21U/7ToJZVxf6aQaYvMOpv1Ne7Y2+yKxqtAfdu3DFc91MXEJF8NBLThahP+
         12ruj3L+ShpCFB6uxkhvHU3HR+NFwG59M+0FEgjwA0oPNov4gjDYANpvcPWUyYJQYDaK
         zPY8eqPyqcqx6ZeoQMw2+xEeR1Vv6IWwhcf+3ZDI09i1EYnOZdpOQC2OLKwwLtqoQ8OL
         ksow==
X-Forwarded-Encrypted: i=1; AJvYcCWis202AED39k/b+2Py5X5gAJ3R9o+sFFawUSD5cz92uV5FH6rJzSjRichp2XrsZISQ4NUjdDHgGQ0aOeYiUkMyPSs3U+6YFQgcTNvdJ7XPIiWQnsUds3M6Ntk5+4NHYUEGDc3e5QzB/qTfcRV1geDBmDc3e2j30l+1lC+T79xQZUfYN0UoHQ==
X-Gm-Message-State: AOJu0YyzOm+Ijm4BjpEMTAzs2/nWd0jG0l3/WpKKUYjYMNefgGOP/r5F
	CEeKMl5rOzvnrNSIos8IoVyK9KA2ICrizjWxGRsZydpvwuHE1NtSUsZCg2gV1hofDPG3jdp6wg9
	NoX6lsQccReyqYSx47Y5vxF8eH6I=
X-Google-Smtp-Source: AGHT+IG8RGjKwVA0WwyDvkW2k2N3AJJ0ptGb1SFZEGLpT6RKIK/BYhZ9JO1JKUds6gHjILDew716N+6RV8hr8WKKw3g=
X-Received: by 2002:a05:6102:d5:b0:48c:323e:1ba3 with SMTP id
 ada2fe7eead31-48d91e64e02mr1518264137.31.1718188504940; Wed, 12 Jun 2024
 03:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
In-Reply-To: <171817619547.14261.975798725161704336@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 12 Jun 2024 13:34:53 +0300
Message-ID: <CAOQ4uxidUYY02xry+y5VpRWfBjCmAt0CnmJ3JbgLTLkZ6nn1sA@mail.gmail.com>
Subject: Re: [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Clark <james.clark@arm.com>, ltp@lists.linux.it, linux-nfs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:10=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
>
> When a file is opened and created with open(..., O_CREAT) we get
> both the CREATE and OPEN fsnotify events and would expect them in that
> order.   For most filesystems we get them in that order because
> open_last_lookups() calls fsnofify_create() and then do_open() (from
> path_openat()) calls vfs_open()->do_dentry_open() which calls
> fsnotify_open().
>
> However when ->atomic_open is used, the
>    do_dentry_open() -> fsnotify_open()
> call happens from finish_open() which is called from the ->atomic_open
> handler in lookup_open() which is called *before* open_last_lookups()
> calls fsnotify_create.  So we get the "open" notification before
> "create" - which is backwards.  ltp testcase inotify02 tests this and
> reports the inconsistency.
>
> This patch lifts the fsnotify_open() call out of do_dentry_open() and
> places it higher up the call stack.  There are three callers of
> do_dentry_open().
>
> For vfs_open() and kernel_file_open() the fsnotify_open() is placed
> directly in that caller so there should be no behavioural change.
>
> For finish_open() there are two cases:
>  - finish_open is used in ->atomic_open handlers.  For these we add a
>    call to fsnotify_open() at the top of do_open() if FMODE_OPENED is
>    set - which means do_dentry_open() has been called.
>  - finish_open is used in ->tmpfile() handlers.  For these a similar
>    call to fsnotify_open() is added to vfs_tmpfile()

Any handlers other than ovl_tmpfile()?
This one is a very recent and pretty special case.
Did open(O_TMPFILE) used to emit an OPEN event before that change?

>
> With this patch NFSv3 is restored to its previous behaviour (before
> ->atomic_open support was added) of generating CREATE notifications
> before OPEN, and NFSv4 now has that same correct ordering that is has
> not had before.  I haven't tested other filesystems.
>
> Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC co=
rrectly.")
> Reported-by: James Clark <james.clark@arm.com>
> Closes: https://lore.kernel.org/all/01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@=
arm.com
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/namei.c |  5 +++++
>  fs/open.c  | 19 ++++++++++++-------
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 37fb0a8aa09a..057afacc4b60 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
>         int acc_mode;
>         int error;
>
> +       if (file->f_mode & FMODE_OPENED)
> +               fsnotify_open(file);
> +
>         if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
>                 error =3D complete_walk(nd);
>                 if (error)
> @@ -3700,6 +3703,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>         mode =3D vfs_prepare_mode(idmap, dir, mode, mode, mode);
>         error =3D dir->i_op->tmpfile(idmap, dir, file, mode);
>         dput(child);
> +       if (file->f_mode & FMODE_OPENED)
> +               fsnotify_open(file);
>         if (error)
>                 return error;
>         /* Don't check for other permissions, the inode was just created =
*/
> diff --git a/fs/open.c b/fs/open.c
> index 89cafb572061..970f299c0e77 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1004,11 +1004,6 @@ static int do_dentry_open(struct file *f,
>                 }
>         }
>
> -       /*
> -        * Once we return a file with FMODE_OPENED, __fput() will call
> -        * fsnotify_close(), so we need fsnotify_open() here for symmetry=
.
> -        */
> -       fsnotify_open(f);
>         return 0;
>
>  cleanup_all:
> @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
>   */
>  int vfs_open(const struct path *path, struct file *file)
>  {
> +       int ret;
> +
>         file->f_path =3D *path;
> -       return do_dentry_open(file, NULL);
> +       ret =3D do_dentry_open(file, NULL);
> +       if (!ret)
> +               /*
> +                * Once we return a file with FMODE_OPENED, __fput() will=
 call
> +                * fsnotify_close(), so we need fsnotify_open() here for =
symmetry.
> +                */
> +               fsnotify_open(file);

I agree that this change preserves the logic, but (my own) comment
above is inconsistent with the case of:

        if ((f->f_flags & O_DIRECT) && !(f->f_mode & FMODE_CAN_ODIRECT))
                return -EINVAL;

Which does set FMODE_OPENED, but does not emit an OPEN event.

I have a feeling that the comment is correct about the CLOSE event in
that case, but honestly, I don't think this corner case is that important,
just maybe the comment needs to be slightly clarified?

Thanks,
Amir.

> +       return ret;
>  }
>
>  struct file *dentry_open(const struct path *path, int flags,
> @@ -1178,7 +1182,8 @@ struct file *kernel_file_open(const struct path *pa=
th, int flags,
>         if (error) {
>                 fput(f);
>                 f =3D ERR_PTR(error);
> -       }
> +       } else
> +               fsnotify_open(f);
>         return f;
>  }
>  EXPORT_SYMBOL_GPL(kernel_file_open);
> --
> 2.44.0
>

