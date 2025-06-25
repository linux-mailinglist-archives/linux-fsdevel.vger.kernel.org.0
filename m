Return-Path: <linux-fsdevel+bounces-52972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8907AE8E17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 21:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72415189E3C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8AF2E11C4;
	Wed, 25 Jun 2025 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNXFipl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B72E1733;
	Wed, 25 Jun 2025 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878524; cv=none; b=uzMePjMtgM+1h5jkt4Q3o5/qLCiQqhbW5ZsFeYxPm7rVoh9jwOEid2DAbLTA6HLgEBfG4BUQYzIIHReK78Lc6zFQyUMlfHl1RXjIeJlaEc/xe1KPg/ywM0jQNQ6Na4VIO78ge3dRH855UGVT+4+sBN9JqxyV6iOeJelIHddRpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878524; c=relaxed/simple;
	bh=pX744MFiESRzqaYn0eNGpr+/wRJUYQoc3z32ienNUXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsqMjWvyKGb41qq3Z3lzYcFZGrMyZNFRwmydCAsC4TxvyUGjKRkyizRh0RGxfWo1ygmYRELYOmVlL5c/ZdhO2qz7HdPP6F+9YKpppH5gHYu+tUnNc/rg23jnXdUBazQqGhMaAvh9751Wow9RmYK7gL7OJPjED2b7P4rMHnYLH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNXFipl3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adeaa4f3d07so42953366b.0;
        Wed, 25 Jun 2025 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750878521; x=1751483321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iO9j7hgrbrZX29EUKQ9vDHwjEDNsq7wFcbb3HBUJRvk=;
        b=SNXFipl3gv1ehuXoGqq0oH1YusebS4G6PhBomClpS02Eu/zbzEaIb6gLh+r3mXZ7Lo
         42txvBUNGNabb0Cx2Jm8DhCxFcFnURpAeOBqlS57zyr8Z3FNQKnFiwkLU3bi+Z+mGqR0
         gKJdJ5FgETKRoRrAoOAiKLhZDq5+5JTEgQs3/e8pF6wFQmAntoGG//3JKk2C7+nvlo7H
         ViRX/5794+I6miBwxNEGZBO6FOvLBbb1kJuEqCyGc6e/GZz4JyKsWCGW1Y13M0aGyeK4
         wRKJK9yJu4a2MGxcBO12WUXoaTaUFRH/I/yTMng9R7AB2OSTbiLeL068U1HW6E0gbOoQ
         OKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750878521; x=1751483321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO9j7hgrbrZX29EUKQ9vDHwjEDNsq7wFcbb3HBUJRvk=;
        b=BoasKnBpfZb86n286I16J+gUcKPNiSNzdd22Q3h5DUGa5DoZ3cj97iYbVx4FoGcXe3
         CzVg+UuNu8AjSHLhODMCYgLhvCq2Jrg2N4440aZqqI+5RErDo6qi2noX6uOLHpfFAwMC
         ccw9XH2+EJRUkt9cjsA00BxZiHWxN432DJxRFP5AVRzf+2dRkNyBg/mpRNxmHPSinoAg
         A0R9NYJNHuZuYBF9SyHVIoqxqwCU1XWLElLQvKxc6TSwV28j9dHnvO4gY8gEQ98bYanv
         f8AYsbYccn8WZerCgdzYLfAUfA1A6jjNiRAmOpQvMiA6AeVRnYQZFclfHnFHknV4WTUY
         1D6A==
X-Forwarded-Encrypted: i=1; AJvYcCV2F5x9FyzLdRL8sdYjL5Dy/hu7LCz5QiSgyJTRUA/rUjdLDwMxcS69r0wMsWq1sGAPvFqjaGuwOwvUvLV2Og==@vger.kernel.org, AJvYcCWwl3SOdb3Vap7pC+kN/lU34bFXvcHauVwgmSuqArvnw0IkPZEUlH2IujUe788mVPqKBLXLFyKeSBNyUd0u@vger.kernel.org
X-Gm-Message-State: AOJu0YxECkwMjtQyvCECOxEL1b9Q/J2d9sPj3iCl1q77T2aGJ+xLNNtH
	cUNPwM9TpKgHd0Rq0g8PRnLE2ErN3JnhtjToR4JsMZAetGAKPg2tTDu3g6drgTGY5ufKOexa66N
	Z2Vllb2/U80pQUT7ag3SUrMo4Nb4lwkM=
X-Gm-Gg: ASbGncufnIOVd7Q9TflykgHeS3ZAoXAHHGuy0bxE7D6KrcPOcKDFf21uc8FiADYbHWF
	m4iAhMHfGiDYe6Yw39FC/bhd2d/Kf9djVvF7GD38xbmXglZa2oxu1LVYdSoxi4azLXD1GeD82RD
	9TM/5vXnayIl3IqQedTg3xeTbvjH1gUBrFl79NmFlYTsQ=
X-Google-Smtp-Source: AGHT+IH62q6V8iGQuf3ic1SWfsQHq6/dd1yj0QdHpRraiGiVJpgqy9rPxAjH4nLzFdmK4ZVNyF9bvm/zEKEMuZ/SdhA=
X-Received: by 2002:a17:907:1809:b0:ae0:685b:5e9f with SMTP id
 a640c23a62f3a-ae0be7fd648mr470365666b.3.1750878521053; Wed, 25 Jun 2025
 12:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624230636.3233059-1-neil@brown.name> <20250624230636.3233059-7-neil@brown.name>
In-Reply-To: <20250624230636.3233059-7-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Jun 2025 21:08:30 +0200
X-Gm-Features: Ac12FXyk84SSp0qamg2HCJiq15ij-ejOHAlpX59aZWk785_I05UcaVqaFhKzMuY
Message-ID: <CAOQ4uxhyoZn+jytmn-_q8ZjFNJ+Ow-RvEE4ZkJGnCGFFT5nETQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] ovl: narrow locking in ovl_create_over_whiteout()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 1:07=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Unlock the parents immediately after the rename, and use
> ovl_cleanup_unlocked() for cleanup, which takes a separate lock.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>

FYI I am not reviewing this one because the code was made too much
spaghetti to my taste by patch 2, so I will wait for a better version

Thanks,
Amir.

> ---
>  fs/overlayfs/dir.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index e3ea7d02219f..2b879d7c386e 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -440,9 +440,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
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
> @@ -513,22 +511,23 @@ static int ovl_create_over_whiteout(struct dentry *=
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
>

