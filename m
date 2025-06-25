Return-Path: <linux-fsdevel+bounces-52969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04762AE8E04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B894A6B91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962012E0B52;
	Wed, 25 Jun 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+fslFL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CD2E06E5;
	Wed, 25 Jun 2025 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878260; cv=none; b=UPM3ccMGEvgro7arZqkS/ve/XFyJHISJjsEj5e5izZB7Ar5PDRkOEhhqmBCCifMXkiXsvoen0prxAvQp8H+cCaGOJTwozMIrY3WtID1wcjzSz9JSN6ku7algcekHTknrB+w+JMk5/HSPiLxeogpd4ys3vL11CUZu2fd9fJEW+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878260; c=relaxed/simple;
	bh=tg8shNhxRgpl6L2E33YhlVwup13+v6sqt3Rj6yfUFsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ft5mALlLs20kM231BJ5QRVODwHkrfP2dS+TTDqyBBdkbLenV2auys4sBEjgpJaCPGgHkK0Qzdf0IbFB/rw/x71VQzFNe43QC4A4AEC6zJvsYC9N1dh+yGervgIh4mnqC1ffoLd6lAHGniOaJAa4jUtdNk6y3T8/QfyvvDSsd5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+fslFL5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad1b94382b8so48207266b.0;
        Wed, 25 Jun 2025 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750878256; x=1751483056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpsZiuqDmhsZCQlIAyiNSSSQl0u6y09sDZngajNIq7A=;
        b=F+fslFL5u8U85zZDM1q8zWkmHiUJaSuSw8lea8zm8G5usp1AJOXo14h8L8jz8DF2tk
         24wq7vVpuN7WSXjnjgyhUjklKOi1ZNagXEJHUXn9jQ4gSajqMAOb8vy33kmnDiJ9ZPdl
         O/CgiSYxFn92H0b7tjVhwzXjL2H0ENCuYNWPZL6Yih9V4Ek0CcbyfxRCUVuqsL7j20Au
         olXOSj5NOlO/6B0giDm7znHOzUSX5VxVhyKjI+FYlXdG7nsDoQt/LCrXutvenv9KFRM+
         9swdkqd/PmG5QpZ95Lg/xd8hCHffwNGK9Wctxtvu+XfKZYU4tL6ekDp6w0FdaGCoYqwe
         rWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750878256; x=1751483056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpsZiuqDmhsZCQlIAyiNSSSQl0u6y09sDZngajNIq7A=;
        b=cRbO9cKlBbzY8KxMkiby4PJZHfh0uHV7ikNuqF7cZDxdME4JJGdz7BBi1qZI+HTY3L
         GXRLJdIA4RRM9alGs6Dk1tljo1gAomHl/sJTYZKfo7Nj8+og+OJlcVR0n0zSr9f3IhFf
         y0pfnCk6aV8MI77KoP6a3G4JNKUnZ+YE67cbQqL/UIFIX/WYW1eemFxXTe4O8eC3c1S2
         AydYafCaLy64YD4/ATIFJfeinCLACCb4tDebFaK/d+bdtu7oHbCSMhiMtcbxirU6Fm5M
         AQMGl6DEfNdYfnnsXFCR2ZprSpo6ZLPME0xIajowD9C865Nfw6Kdw+rH4jQk+BlX7pBQ
         5Erw==
X-Forwarded-Encrypted: i=1; AJvYcCU2K35DY+eimnqOQNtO95nF8sqXcJPkakwbXVhIHF9B+gxMpHbXfG2o3IhELtAhK5IZ+Ea/Es/BSiCrbXuIyQ==@vger.kernel.org, AJvYcCXoz6uKt+4NKbjrvsWxd5R/Ku+0wvhY7tT5Jh908pxetHt4cz4iquG2nfa1Jb/eemqWpDAn9akduIVJEfiP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm76/A2wkkHPqGUlh9cmx89gqD2tWUGYRdPC7A47LWG39Y9Ero
	5n0kO6eufJ5uLbR+5AL7VcfsOEcn3486iMKbDA4Dkkk0FLB7uDMeMQxkwsj0hayZu+waouIaR5s
	TlS/vdUREhprLu50TsspCJiJPrE30sVo=
X-Gm-Gg: ASbGncvZPwLe6W2Aknmxs3TedQBN5V0U3UyK4G35FyAoqb5E3VDFZ8G8ZxO/rSa5GWH
	HM5Nku7+nr/zDvuh9G4//VSZTgx6+DkBMRxweKksM8bjs3rA1yl3OY2BRTnZ+dvKAq16q0jQkDC
	2SNjsuqiVsiCD9CatlTfivAM/pprePuPBIU5Rh0ucKiahBvSlF7Yb3fw==
X-Google-Smtp-Source: AGHT+IGd8t7a/8Nfa1KWfu3CHRtSBGar1fxvSzdFY65WqS1xkDVhfY03/fazCbiK+QWopU/Tvw/VuVNVwRW0Z/An0Uw=
X-Received: by 2002:a17:906:5784:b0:ade:7f2:a160 with SMTP id
 a640c23a62f3a-ae0bea2ebe4mr339906266b.48.1750878256130; Wed, 25 Jun 2025
 12:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-11-neil@brown.name>
In-Reply-To: <20250624230636.3233059-11-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 21:04:05 +0200
X-Gm-Features: Ac12FXyDKMU9mLHLk-75AX3OU7td_WlMNFph8LVCHcjgO_mKqZLl90L_SEPVyjo
Message-ID: <CAOQ4uxgbhgGHcW+x1F=9Fo5T6ALjADC9SJhzp_mSooqUb8_6sA@mail.gmail.com>
Subject: Re: [PATCH 10/12] ovl: narrow locking in ovl_check_rename_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> ovl_check_rename_whiteout() now only holds the directory lock when
> needed, and takes it again if necessary.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/super.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 3583e359655f..8331667b8101 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -554,7 +554,6 @@ static int ovl_get_upper(struct super_block *sb, stru=
ct ovl_fs *ofs,
>  static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
>  {
>         struct dentry *workdir =3D ofs->workdir;
> -       struct inode *dir =3D d_inode(workdir);
>         struct dentry *temp;
>         struct dentry *dest;
>         struct dentry *whiteout;
> @@ -571,19 +570,22 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>         err =3D PTR_ERR(dest);
>         if (IS_ERR(dest)) {
>                 dput(temp);
> -               goto out_unlock;
> +               unlock_rename(workdir, workdir);
> +               goto out;

dont use unlock_rename hack please
and why not return err?

>         }
>
>         /* Name is inline and stable - using snapshot as a copy helper */
>         take_dentry_name_snapshot(&name, temp);
>         err =3D ovl_do_rename(ofs, workdir, temp, workdir, dest, RENAME_W=
HITEOUT);
> +       unlock_rename(workdir, workdir);
>         if (err) {
>                 if (err =3D=3D -EINVAL)
>                         err =3D 0;
>                 goto cleanup_temp;
>         }
>
> -       whiteout =3D ovl_lookup_upper(ofs, name.name.name, workdir, name.=
name.len);
> +       whiteout =3D ovl_lookup_upper_unlocked(ofs, name.name.name,
> +                                            workdir, name.name.len);
>         err =3D PTR_ERR(whiteout);
>         if (IS_ERR(whiteout))
>                 goto cleanup_temp;
> @@ -592,18 +594,16 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>
>         /* Best effort cleanup of whiteout and temp file */
>         if (err)
> -               ovl_cleanup(ofs, dir, whiteout);
> +               ovl_cleanup_unlocked(ofs, workdir, whiteout);
>         dput(whiteout);
>
>  cleanup_temp:
> -       ovl_cleanup(ofs, dir, temp);
> +       ovl_cleanup_unlocked(ofs, workdir, temp);
>         release_dentry_name_snapshot(&name);
>         dput(temp);
>         dput(dest);
>
> -out_unlock:
> -       unlock_rename(workdir, workdir);
> -
> +out:
>         return err;
>  }

I dont see the point in creating those out goto targets
that just return err.
I do not mind keeping them around if they use to do something and now
they don't or when replacing goto out_unlock with goto out,
but that is not the case here.

Thanks,
Amir.

