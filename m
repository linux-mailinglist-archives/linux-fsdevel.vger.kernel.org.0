Return-Path: <linux-fsdevel+bounces-55102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D27B06EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7767B169C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B971A289E16;
	Wed, 16 Jul 2025 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9eW/CB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62A2C190;
	Wed, 16 Jul 2025 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650145; cv=none; b=DdUn50/oNxr4TpdjB2WvXoJjTDooak+CVfH2W+7XFRn8e6dZzzHUf24n+yuxEK1tFeAQ22RV6HgAwihKFo+efiMsgjVn1b4mTSOfomWUFkc4/cYR8AQg9ic9BwsytMaa527NOWwS/jLnR7PnOYrBDnhYd4u+DIiWwLQB6FYLI/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650145; c=relaxed/simple;
	bh=L6E+9V59qA9RHZlOyKipzsokxgh7+tRMh1OxpOTKyog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0N20IXH8U3UztDW27IyCSuyZOq1PJvHLsfuyzpEwSgXOyiNhD2ibp0A1elGyWwU8ubgPxDDRvMz2ZsqMwZMk2fQs2XZL8N0CRth5gCTA4BtxPOAKh99Kp1x1ZmywzB7exIQ3jicgqsay5tdfRHAKWwCD3nE+rcxqw4B5R3J0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9eW/CB7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso10443270a12.2;
        Wed, 16 Jul 2025 00:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650142; x=1753254942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m67bHFFRzomLikP8q1so28xHHB2+YeiOHjuiNnD8les=;
        b=i9eW/CB7lzwHtCec95DBjZ8KcWnv3bqjfd04VqlwtgMUHLtz+mV39nuwhNP9QxrUIn
         R2rmdLJw699gUIF3PoFf8dMIZfALQhs4kGFuhv56NOiE0dCY+GxpGbDZRIbYxThktkd5
         PA6AiiEH1ILgWAqN++NvLs/BlcQFUtcSsJkkmCOBJe4hMujZVxuIXxP6x5WCvHloxc4f
         bYZ3PoyliONZ53d1ahLEi/p6zplKNz+Pci5ZZdGO9G46tpXEGoOOpDrcjiWPsOYq9k2c
         K5gagW8mDoguvUvODPOXJRfVJSIEUvQ0vhe1FHDcWIBjgy2a14+Npf6Rq8CX6EzqRmd/
         8RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650142; x=1753254942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m67bHFFRzomLikP8q1so28xHHB2+YeiOHjuiNnD8les=;
        b=R2tdhgCJNYxjBIuDgyTF3KLpPYIOWfb17595VZa7I75jTF4ziiRhjtOyGfUJU2YSsO
         /ylMKoeUTLdt4xMGAr1hf3K3in+nDJq1KbNobroP62PhtWdKdwHiq69CHk3yUW3m1zJK
         0gADopBXmqEac19aQI0CH7Tl8yBT9t0Y93gdv1dHsrRgfnnBLP2mnmwLi/fKkf1wiFkH
         5fIMKbrLl6Hdxqbs6kP31IJe6Ot5/790g0guLHYKwsPu6aqgqUon3YHSTY/IdJap0EvI
         1DzoF8ojwx31cJnI3kqasUQZPdAwuHd76Qf/dGtAMKqrCIyJwLz3S1woBDtgw62iNkqI
         1hDA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5WbUY/XvadEQfozxzRlKKl44bNcI4tvGjQQx/1bV5ZbJZi0tduMmGCOJbvECI25awp2axObvrjxuXqRK/Q==@vger.kernel.org, AJvYcCXUzguFuVY2jPzPcg4YnJrrt6f29iJGPoxyiXzjWwtAUQ7J749OeaUWmOydLZNICkmLaNypYt4zftG0FMu7@vger.kernel.org
X-Gm-Message-State: AOJu0YyfV7H6wGLb07/yek4NgxV9aHWfjL3Ynu4cl5WRsyVpCZQH34Ad
	/Kik/uqO5tn6eRuiToyXJxnm++CqRo5k2KoFx6ScNQXukn3ING+mvDcrumzNcFlVSNRk6WvyIX+
	6qbvEO80nulKda0xF53rL3eCcKy13q0A=
X-Gm-Gg: ASbGncvq5H4xyNduKDHOJnYcdiVuTedjzVPWcUqCD5zZOB8ttYuQkIVYr0+qY2P7tPQ
	KfOPpVME0CYusIpKKjBQOeDwynDDIm92omnkYbnAx8svAGA2OtSJMHdzfEOJ2IZ223XNEC1J5G+
	2zIN4n6gWss20eW5skBhZLHj+UiEWbGUZymV5UK2mLkooiWzkgllhGRN4PXVNxwwIiAmAeuAmFB
	OSeCr0=
X-Google-Smtp-Source: AGHT+IHrqP7RssEZbXju9W5eGVtaw4onjTyWL/m4YmQcVuuv3imCIVZLFv+NnlMRcKKK8s15n207t3iQulMgw4aOaQ4=
X-Received: by 2002:a17:907:3c93:b0:ada:4b3c:ea81 with SMTP id
 a640c23a62f3a-ae9ce0b7e59mr134158466b.39.1752650141447; Wed, 16 Jul 2025
 00:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-13-neil@brown.name>
In-Reply-To: <20250716004725.1206467-13-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:15:30 +0200
X-Gm-Features: Ac12FXxIQuGnFlfiXu6-aw50xO_y-_J60jlwH3p_spHCIQMS8pfXwGYPtinA93I
Message-ID: <CAOQ4uxhLdXMUM=ssgALBAR1Qf0N-7nHrrar32OihW3mv=x0btw@mail.gmail.com>
Subject: Re: [PATCH v3 12/21] ovl: narrow locking in ovl_workdir_create()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> In ovl_workdir_create() don't hold the dir lock for the whole time, but
> only take it when needed.
>
> It now gets taken separately for ovl_workdir_cleanup().  A subsequent
> patch will move the locking into that function.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 2e6b25bde83f..cb2551a155d8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -299,8 +299,8 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>         int err;
>         bool retried =3D false;
>
> -       inode_lock_nested(dir, I_MUTEX_PARENT);
>  retry:
> +       inode_lock_nested(dir, I_MUTEX_PARENT);
>         work =3D ovl_lookup_upper(ofs, name, ofs->workbasedir, strlen(nam=
e));
>
>         if (!IS_ERR(work)) {
> @@ -311,23 +311,28 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>
>                 if (work->d_inode) {
>                         err =3D -EEXIST;
> +                       inode_unlock(dir);
>                         if (retried)
>                                 goto out_dput;
>
>                         if (persist)
> -                               goto out_unlock;
> +                               return work;
>
>                         retried =3D true;
> -                       err =3D ovl_workdir_cleanup(ofs, dir, mnt, work, =
0);
> -                       dput(work);
> -                       if (err =3D=3D -EINVAL) {
> -                               work =3D ERR_PTR(err);
> -                               goto out_unlock;
> +                       err =3D ovl_parent_lock(ofs->workbasedir, work);
> +                       if (!err) {
> +                               err =3D ovl_workdir_cleanup(ofs, dir, mnt=
, work, 0);
> +                               ovl_parent_unlock(ofs->workbasedir);
>                         }
> +                       dput(work);
> +                       if (err =3D=3D -EINVAL)
> +                               return ERR_PTR(err);
> +
>                         goto retry;
>                 }
>
>                 work =3D ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
> +               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 if (IS_ERR(work))
>                         goto out_err;
> @@ -365,11 +370,10 @@ static struct dentry *ovl_workdir_create(struct ovl=
_fs *ofs,
>                 if (err)
>                         goto out_dput;
>         } else {
> +               inode_unlock(dir);
>                 err =3D PTR_ERR(work);
>                 goto out_err;
>         }
> -out_unlock:
> -       inode_unlock(dir);
>         return work;
>
>  out_dput:
> @@ -377,8 +381,7 @@ static struct dentry *ovl_workdir_create(struct ovl_f=
s *ofs,
>  out_err:
>         pr_warn("failed to create directory %s/%s (errno: %i); mounting r=
ead-only\n",
>                 ofs->config.workdir, name, -err);
> -       work =3D NULL;
> -       goto out_unlock;
> +       return NULL;
>  }
>
>  static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs=
,
> --
> 2.49.0
>

