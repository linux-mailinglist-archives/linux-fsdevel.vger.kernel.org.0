Return-Path: <linux-fsdevel+bounces-21839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E762A90B78D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664FC1F22CD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B1E16A94E;
	Mon, 17 Jun 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GumAcy6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164E16A93C;
	Mon, 17 Jun 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644354; cv=none; b=mAlQSRUVQCrBUMO3XqryJO0rjFGNW11tuFE2T0az6x6GBZ/Yg37A+vGCfziKzxLuMMrH3jWlkP2ft65xu/Bcpq2zrtwAgX1uEGA+crPKgRemPmPNWRZy6EdvkhrfJTrJlk+ficutHRDy5LlIriLYgZHiqWrtnFcoTO3VuzzBKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644354; c=relaxed/simple;
	bh=ISxkW9K320Bmd5RQDq2ZbzfdwhVCbKLmvhyYXjmlSCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmuAGygfeltBK1pn0mkC2JK4W7S7C5uAOkmi/AabAPCoYUh0I+93v6oHkve4KvOlCzDEwTLjq7LTMv6uo6kV+8YZMyojvpoIKYO3jZBF34HnswFawGTA9LGvJDo5rKJal4Y98HoyIeuGRwzuUccUGcnrJxAJfHtWyfL5U9XeqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GumAcy6E; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b065d12dc6so24266096d6.0;
        Mon, 17 Jun 2024 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718644352; x=1719249152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8Y4dIpWWIt1HFS2GNCWadogAx3UU4JsBC/chYCx394=;
        b=GumAcy6EWHdHXTqJPZOoE3B6pgc/vDKL1wl3ETOntlxohzGrniCkh1tiQhTPfImK/d
         pRliekaM/MSWrlVj2rJhQZkITJH11H3H19h3y03KjewzCx9ZB6ZiA7gzhTIIc8Yav1co
         UDAvyI2BE6drReK9VtbyDB5zrHkHALCquDABeXwZbH5nFhrsxfUE3eCmSMPqd2OIcXPo
         Oar2TH9q3QuvrxWKP6P3LfXimqVSO0xdb5Ng0ntvYr93pC1tdIB66USD7R1wkv/Amvx2
         zXixo7f9PmP6EYWbV7LYq+BEY/o485Zn5+FnSRq7G4wZ6ww2S80Y+Z4UmWHai1WVoFn3
         UvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718644352; x=1719249152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Y4dIpWWIt1HFS2GNCWadogAx3UU4JsBC/chYCx394=;
        b=LqN7kNTp4lU/KJGhKPbw9EpvW0oc5DUtulgWZNohc8UnxHNtJeIPZ+XK8Gx25LhlTt
         NwJmeAPEpXszbJsjLjt+vQW4/jX/kpavdY3by0eSEXDqpZCqK7BesHHtNPhJsPMibrWC
         lBPnkXi+/C+wuvphtMxb2FQkinGp1OrmA4swfAsxTPBSAQt5cIv5pVjjNPIEIs8bd5nZ
         AsWDwjHfmD0tOsJsjdXVKb6cDEpLi8qbAh73nReSF/DNarSmOutIAfR7PPnuwkopYW1X
         pTBsFTu0pWyyPFv6YZDXwhtFcho5cciaX/xgoDiCaIFKXSWUFxrasWTK0HoTuo44shRr
         uswg==
X-Forwarded-Encrypted: i=1; AJvYcCU/oacKti987OSQ5p05S6DQ42bSvNeHzvLI0NdPSYLpRVXmq1tgwjkzH5V+Vuz4H4/LV4BgTcsev46BuoVYxEc2ZKbl5SFHVcmlD5bZ/WzhoAUVJEZplAFIH6IUJuhhivxzCpjE40ytdA==
X-Gm-Message-State: AOJu0Yw1vjDIti4Q5SuFuqqHkF95WQCu3L+/d9QiH6dVZvQc+Sqh3YL6
	2tSyJbi3VnkfPUGXLavQwmK10NICECOO3zCEGVMEOBbWlZz4iulcCQkWIFkSOX0oCbFEbiCVGhi
	HKlyMrlbigEStCuFClMd+WxpoSds=
X-Google-Smtp-Source: AGHT+IHAP4gy8lnROASB8oUCFBeFNwK9k1Y9Fg4moSWCdTK/kmcqlQoziT3/xJr7TMRegSRGJNJddUNJ3mRnbsMVkrA=
X-Received: by 2002:a0c:ef0a:0:b0:6b2:cefe:6c79 with SMTP id
 6a1803df08f44-6b2cefe6ce9mr50141586d6.9.1718644351581; Mon, 17 Jun 2024
 10:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617161828.6718-1-jack@suse.cz> <20240617162303.1596-2-jack@suse.cz>
In-Reply-To: <20240617162303.1596-2-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Jun 2024 20:12:19 +0300
Message-ID: <CAOQ4uxh2WrSGjBNNTaY4Eew3cX6iPrAT9TnpqtQFccS_omNqzg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	James Clark <james.clark@arm.com>, linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>, 
	Al Viro <viro@zeniv.linux.org.uk>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 7:23=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> From: NeilBrown <neilb@suse.de>
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
>    call to fsnotify_open() at open_last_lookups() if FMODE_OPENED is
>    set - which means do_dentry_open() has been called.
>  - finish_open is used in ->tmpfile() handlers.  For these a similar
>    call to fsnotify_open() is added to vfs_tmpfile()
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
> Link: https://lore.kernel.org/r/171817619547.14261.975798725161704336@nob=
le.neil.brown.name
> Fixes: 7b8c9d7bb457 ("fsnotify: move fsnotify_open() hook into do_dentry_=
open()")
> Tested-by: James Clark <james.clark@arm.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/namei.c | 10 ++++++++--
>  fs/open.c  | 22 +++++++++++++++-------
>  2 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 37fb0a8aa09a..1e05a0f3f04d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3572,8 +3572,12 @@ static const char *open_last_lookups(struct nameid=
ata *nd,
>         else
>                 inode_lock_shared(dir->d_inode);
>         dentry =3D lookup_open(nd, file, op, got_write);
> -       if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
> -               fsnotify_create(dir->d_inode, dentry);
> +       if (!IS_ERR(dentry)) {
> +               if (file->f_mode & FMODE_CREATED)
> +                       fsnotify_create(dir->d_inode, dentry);
> +               if (file->f_mode & FMODE_OPENED)
> +                       fsnotify_open(file);
> +       }
>         if (open_flag & O_CREAT)
>                 inode_unlock(dir->d_inode);
>         else
> @@ -3700,6 +3704,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
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
> index 89cafb572061..f1607729acb9 100644
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
> @@ -1085,8 +1080,19 @@ EXPORT_SYMBOL(file_path);
>   */
>  int vfs_open(const struct path *path, struct file *file)
>  {
> +       int ret;
> +
>         file->f_path =3D *path;
> -       return do_dentry_open(file, NULL);
> +       ret =3D do_dentry_open(file, NULL);
> +       if (!ret) {
> +               /*
> +                * Once we return a file with FMODE_OPENED, __fput() will=
 call
> +                * fsnotify_close(), so we need fsnotify_open() here for
> +                * symmetry.
> +                */
> +               fsnotify_open(file);
> +       }
> +       return ret;
>  }
>
>  struct file *dentry_open(const struct path *path, int flags,
> @@ -1177,8 +1183,10 @@ struct file *kernel_file_open(const struct path *p=
ath, int flags,
>         error =3D do_dentry_open(f, NULL);
>         if (error) {
>                 fput(f);
> -               f =3D ERR_PTR(error);
> +               return ERR_PTR(error);
>         }
> +
> +       fsnotify_open(f);
>         return f;
>  }
>  EXPORT_SYMBOL_GPL(kernel_file_open);
> --
> 2.35.3
>

