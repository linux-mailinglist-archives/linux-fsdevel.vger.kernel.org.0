Return-Path: <linux-fsdevel+bounces-54638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B3B01C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01F35A5D6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F62BE7DB;
	Fri, 11 Jul 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcJ9fhIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDC3C26;
	Fri, 11 Jul 2025 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237763; cv=none; b=NifAqnb/fQqEyYOrq7QhwiYD5L4IHzbkDaXNu7feEs3pvTKjdu9p8Fuz75tRukuFidfG4x0fswdin3sRl3gtQLgGVSCbPObXKwXGTt1AHiGf/NtncuFhI+7RUKkJp6CAyCm1Z5ELsy8YC9HtwPZ6R9FSBJJoRmeVhfYoMwcY6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237763; c=relaxed/simple;
	bh=SvfHp3ze32RIRhIz1/0RPHjxBBfAjV49KugAT+c2zKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnuMX0tuaW/0lf6gGNN1PcrxHFbz2lKpCxPMtoL46r4nmdmEFcAVzG4+nVMNYFFxtlCYdbOxkt/jHJ9AZzTPTX2SoxeSdzd19IMB0N5bObsfGY+S8iZnFZnoYroxNBZGA95S7ZhEDrUtfW5BHZLHpEHd1OYnd6D3aHjNItwE1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcJ9fhIg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so3963604a12.2;
        Fri, 11 Jul 2025 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752237760; x=1752842560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lh/JX7yuDBvia4ZQCVR2VMvqlDFZWpcjZ0kIrTa6Ky4=;
        b=TcJ9fhIgASWay3y9ihNzd6FTWn5IuTWjKfdPk/IUZUK88L8Lz5spMds7W7dB6hsKtz
         mkgtJMqq+aQfqFTea+edMsvhYC42Zhv7iWtLuHUfSrhuBJxkxZmYLDELctZ+FeG26nYV
         MabCsB+CZjyyGV1IHa+tTh19Ea4ErkKhgzAOP5rfVDkNr0q+ZgxW4WWahLzLIZQBdgvn
         A3eTNlXWVEDW53rZB8yuq4AGSVsCXpnbIO62NeSMHMlGfNqv7bSVauczHCxWB9U4PWNf
         lCOF1Wm8GPJQe/zypD1eRD6vKAeLqOJc/Nb2vRVJIlDXJe4/KzwTd8HrRJttUfIV8VMD
         2MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752237760; x=1752842560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lh/JX7yuDBvia4ZQCVR2VMvqlDFZWpcjZ0kIrTa6Ky4=;
        b=fSGjJcY9k/0cM0+D0z7HkO1nWptdewSwSrz5qhVrwcL9GBz2yixe9A5zPnZ9LXEF4K
         pGOZLbtrIOOUFk40GV7F5fd9OKrmClb0hpzAyAoUAm2csFEVEERTWK9NVRzkuZ6jtYoY
         DE9a7Z9RqkQEShXtsn5q25w2K8SuHPwsTFd0mScMKnujTYm+gLbWPoh2BWVuki8VV+oD
         OeBYiXeuIk2E47dJF068sfUVR9dOl/gVifc0qrfe9itdw0+NeIgnpSMF4/SNZ2hY5iAC
         doGLQdpv2WFiV9YTvLlwfnjcuhAmzoZRbO1P0L6FnZx9UYaAv7c5jdeMdps7bUK6c0hQ
         2dOA==
X-Forwarded-Encrypted: i=1; AJvYcCWGacoVglgVWAr+yRAwLtsMB6JV7oglJq8B7LoaqYxIWFDW0d56dZz8J9a1vLG9ZnCO3oo4099y2HS+dfAmeg==@vger.kernel.org, AJvYcCXls0IGv66ul0r8IW3M1DWeMtw0Gexjw06z7n0t0kScy0LiN1fu1JXJ94mZBie5apHDjopCJtxDY5z/6Jos@vger.kernel.org
X-Gm-Message-State: AOJu0YzxVWOZhjIpUwpe4BB3au1OS+5EaXJ/mWuTrfuXeED7m38QUX7N
	SIa2tImhDZCUfSnVGcoql6jjTN3wlqIUefGJjZNtRgtS6gwGd7Im9ZQxMgP/mxop/OsW7RSOL2+
	NiY4ZY3fwHzQEYztk01ZFM1K6Sx9A/6w=
X-Gm-Gg: ASbGncvuiPWjT716V3gf+OeMYaRebYH8aQyxaBrSv9H3blMPF5ZYmXQ1ruB+vi2kcvU
	aqal5kbZlS5m0l0pJfq51LRGk1r9RSSzOVlZ/3H8HHaFZe6VmW6m6nuJJiQf80OptDLddAZvolp
	0XqOCEsf89NNWijBxKF8ucyWwKfZB/9PX4/xCkwo4ESiu3SFTdjCa3o8X+cATX6zK4Hzdn4vVkD
	D+36Cq/4BMGFdEW3w==
X-Google-Smtp-Source: AGHT+IESgswL2GbI1CVVUnx9zDDc0X8aUu1dJIWO4oB+Ec5jvQ4a8PtH9uo5yqz68UEnVXYpEB7Sag4RP6cAcdY9tyU=
X-Received: by 2002:a17:907:960a:b0:ae2:4630:7de4 with SMTP id
 a640c23a62f3a-ae6fbfa7d5dmr321018766b.34.1752237759901; Fri, 11 Jul 2025
 05:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-8-neil@brown.name>
In-Reply-To: <20250710232109.3014537-8-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 14:42:27 +0200
X-Gm-Features: Ac12FXxHWDu2JZu2r-0h2Ut603buWJ-iA9ijFxhioDzZ7_cf14qxHpdpZGZ0bpI
Message-ID: <CAOQ4uxhzvbrvnaX5i-6N1h1Ju=13Q2mvLG+ofkTp3-ZHSkCQ-g@mail.gmail.com>
Subject: Re: [PATCH 07/20] ovl: narrow locking in ovl_create_over_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Unlock the parents immediately after the rename, and use
> ovl_cleanup_unlocked() for cleanup, which takes a separate lock.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index b3d858654f23..687d5e12289c 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -432,9 +432,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct dentry *workdir =3D ovl_workdir(dentry);
> -       struct inode *wdir =3D workdir->d_inode;
>         struct dentry *upperdir =3D ovl_dentry_upper(dentry->d_parent);
> -       struct inode *udir =3D upperdir->d_inode;
>         struct dentry *upper;
>         struct dentry *newdentry;
>         int err;
> @@ -505,22 +503,23 @@ static int ovl_create_over_whiteout(struct dentry *=
dentry, struct inode *inode,
>
>                 err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper,
>                                     RENAME_EXCHANGE);
> +               unlock_rename(workdir, upperdir);
>                 if (err)
> -                       goto out_cleanup_locked;
> +                       goto out_cleanup;
>
> -               ovl_cleanup(ofs, wdir, upper);
> +               ovl_cleanup_unlocked(ofs, workdir, upper);
>         } else {
>                 err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
> +               unlock_rename(workdir, upperdir);
>                 if (err)
> -                       goto out_cleanup_locked;
> +                       goto out_cleanup;
>         }

With my suggested changes to labels in patch 3, those lines would
change to out_cleanup =3D> out_cleanup_unlocked

Other that that feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>         ovl_dir_modified(dentry->d_parent, false);
>         err =3D ovl_instantiate(dentry, inode, newdentry, hardlink, NULL)=
;
>         if (err) {
> -               ovl_cleanup(ofs, udir, newdentry);
> +               ovl_cleanup_unlocked(ofs, upperdir, newdentry);
>                 dput(newdentry);
>         }
> -       unlock_rename(workdir, upperdir);
>  out_dput:
>         dput(upper);
>  out:
> --
> 2.49.0
>

