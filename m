Return-Path: <linux-fsdevel+bounces-55097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A1B06E9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4986A1A6553D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26AB28A727;
	Wed, 16 Jul 2025 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btFvP44V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334428A73B;
	Wed, 16 Jul 2025 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650035; cv=none; b=m+z+zLNOcCh6GWOJWLqgiTbg0DGlLu28dJ9MwijnfqactDcbLmmPzhucAvBrMy9GzV7ga5k+wi6fCN9RzqyxM3LcOfB1km+lxo7AR7zyUZcYwi6lvNiytem5BIZUT5RQfgn3+DPEsm3j5+7alzw0G4WogKsRzLdxeebJRcDejb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650035; c=relaxed/simple;
	bh=CqWg8tXdAp29riMfkJZq7S9gFWNfpUhhSTvwTAwlgxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nv/6P7DjXWdq7tLJZgRr92HFXNj3+ICGEScxf7OJgSqgKVrlrhPYRlPMsjFrHh9CgJlzZOWReiuvspx46Pj6pLsLQK+3D7wKBI/vnwvzvoXat7M0b5XS4u6ZiAqHFSSfva5Sp9UveKsbPdkwfavDCwlqCqxXnPEyzqc3TuhEXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btFvP44V; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0de1c378fso1014506366b.3;
        Wed, 16 Jul 2025 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650032; x=1753254832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn+mnMKuhF/pRKJEON8d0oA07yDIGQKLvdFVYt4T7Sc=;
        b=btFvP44VM1jYieptDn/4r7Uw5xNzZBZLkx+cmfWBzw+zRuc0tHmnILIglyhB0H78jH
         IiXmb+qMJG/CmlCaHxSSdhulP2QSlyLiwUcsgxEj8tNoWT/OgTUn4PYGPNlwux80bkRc
         mBXCdyLwvCLg6txINQKqB/aYbAXToIeK/SjWP2LowjO/jSNIrQs2nVXLKHR5S+DsC5T0
         Ya4erCCgA18nHLTdQttfKoG4LNCoAQPsN+Q2FuwO7R+NHsZqf1Z93yHSrR9aajpl9WC0
         bdCvjOgt9xccXKCCsdFVZRR6E5G0GqTRFCYnPww80sOyZU/TBV/2dJmN/Z6WUsRq4TKl
         H8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650032; x=1753254832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn+mnMKuhF/pRKJEON8d0oA07yDIGQKLvdFVYt4T7Sc=;
        b=ety83O4schjXgJVcuKh2cqOILlXQzekWHQOXsh5T7QAMvdceMyrkf8AU2aefiC0Au9
         ww8TcED8mTmcdJLJLBrr9dOSP24etSV5V2RIAGpeGHCuvrDZYNYfnDrxv1oPyjVBuDDA
         9EfMjO3F8A1AIP4lrrneQKPHM/pUL/M65Lh/dGJ1uBRxoz0PDmrgKWFjK6WxE0HYXyiR
         L2i9ngJnQmGs3VJNpD9YXXpEcQrrAs1JuzZpT8hHjHuMaiYVQpQML44BBGh2rIRagNKI
         EnqenI3hv0MjR4/OMB38F6+GEBkAd2Ab+B7Bgpf0qGdlv3FoT4FZfmkc1+sG8MSGYZi2
         W+qw==
X-Forwarded-Encrypted: i=1; AJvYcCW7mn0KsBzpgvQJUOouW1a8fI1YoRTFX41KVe/Yr/vMziprRw0Y7vP8PUj8bHTRkFIJ+Bk92NwgBWlFtEGF+Q==@vger.kernel.org, AJvYcCXSAkduMCdiDEz1JB3aPtlaNVOGvdmPbhFEhg0Yqpa03Yy5G4P9dhwJiU3UYiW7/F5bpwbrXoKNNzuaen9V@vger.kernel.org
X-Gm-Message-State: AOJu0YxccZ/u/Od5N1pTJjsN1mOGUmqHy+1yR6shobb6cujTGzYLAiAj
	s5h5A/+sD+GROOcaMFdSzPyo57oQV7mr4hH9wjan/0Nr7LJtOxitGOw2FaqZZ0/6FP0e0ZXPO70
	yAnbW5roCRHARSvieN4AXyV+TavGTQXg=
X-Gm-Gg: ASbGncuxCJU1+fJYAWJv/C/35Aurb/IRwRx3LXpemS1pC49hzNW9yh3/pWqv9UXM5+d
	Is/rIDVzikLK6QhRs2Q8IfNl+/ZOtDPxpWR/U0p0O4NojSjj9A8c+1o4L8WkeUQHVi9a43iH5dI
	DjkK2Mn/JdOexA8R2TbQCDSao2GrkmczkTVJMS3PWSKp1R9eHHTLQEveJksudlpzLh29fdWvF11
	LuOuUA=
X-Google-Smtp-Source: AGHT+IEyGHNNZIz7Nh/r/B4tmLrHJ1Y9WE+0YCRBQDh5pX9WI2MTt1iy9he+SIX53pUYZrAWv1aV3uYDAxCoX29RvRE=
X-Received: by 2002:a17:907:d40e:b0:ade:c108:c5bf with SMTP id
 a640c23a62f3a-ae9ce10ca5amr113783366b.43.1752650031260; Wed, 16 Jul 2025
 00:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-9-neil@brown.name>
In-Reply-To: <20250716004725.1206467-9-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:13:39 +0200
X-Gm-Features: Ac12FXyXf4Db2hK21ITBAVAiIm_lXbRMx6Ps7LFt8-IAP1SPkW8XTcrPidoF3WM
Message-ID: <CAOQ4uxgoArVv-BUPWphhyVhqjAto5efHNMf7xerB-sjsVm8AkQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] ovl: simplify gotos in ovl_rename()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Rather than having three separate goto label: out_unlock, out_dput_old,
> and out_dput, make use of that fact that dput() happily accepts a NULL
> pointer to reduce this to just one goto label: out_unlock.
>
> olddentry and newdentry are initialised to NULL and only set once a
> value dentry is found.  They are then dput() late in the function.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 54 +++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 7c92ffb6e312..138dd85d2242 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1082,9 +1082,9 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         int err;
>         struct dentry *old_upperdir;
>         struct dentry *new_upperdir;
> -       struct dentry *olddentry;
> -       struct dentry *newdentry;
> -       struct dentry *trap;
> +       struct dentry *olddentry =3D NULL;
> +       struct dentry *newdentry =3D NULL;
> +       struct dentry *trap, *de;
>         bool old_opaque;
>         bool new_opaque;
>         bool cleanup_whiteout =3D false;
> @@ -1197,21 +1197,23 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                 goto out_revert_creds;
>         }
>
> -       olddentry =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdi=
r,
> -                                    old->d_name.len);
> -       err =3D PTR_ERR(olddentry);
> -       if (IS_ERR(olddentry))
> +       de =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
> +                             old->d_name.len);
> +       err =3D PTR_ERR(de);
> +       if (IS_ERR(de))
>                 goto out_unlock;
> +       olddentry =3D de;
>
>         err =3D -ESTALE;
>         if (!ovl_matches_upper(old, olddentry))
> -               goto out_dput_old;
> +               goto out_unlock;
>
> -       newdentry =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdi=
r,
> -                                    new->d_name.len);
> -       err =3D PTR_ERR(newdentry);
> -       if (IS_ERR(newdentry))
> -               goto out_dput_old;
> +       de =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
> +                             new->d_name.len);
> +       err =3D PTR_ERR(de);
> +       if (IS_ERR(de))
> +               goto out_unlock;
> +       newdentry =3D de;
>
>         old_opaque =3D ovl_dentry_is_opaque(old);
>         new_opaque =3D ovl_dentry_is_opaque(new);
> @@ -1220,28 +1222,28 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new)) {
>                 if (opaquedir) {
>                         if (newdentry !=3D opaquedir)
> -                               goto out_dput;
> +                               goto out_unlock;
>                 } else {
>                         if (!ovl_matches_upper(new, newdentry))
> -                               goto out_dput;
> +                               goto out_unlock;
>                 }
>         } else {
>                 if (!d_is_negative(newdentry)) {
>                         if (!new_opaque || !ovl_upper_is_whiteout(ofs, ne=
wdentry))
> -                               goto out_dput;
> +                               goto out_unlock;
>                 } else {
>                         if (flags & RENAME_EXCHANGE)
> -                               goto out_dput;
> +                               goto out_unlock;
>                 }
>         }
>
>         if (olddentry =3D=3D trap)
> -               goto out_dput;
> +               goto out_unlock;
>         if (newdentry =3D=3D trap)
> -               goto out_dput;
> +               goto out_unlock;
>
>         if (olddentry->d_inode =3D=3D newdentry->d_inode)
> -               goto out_dput;
> +               goto out_unlock;
>
>         err =3D 0;
>         if (ovl_type_merge_or_lower(old))
> @@ -1249,7 +1251,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
>                 err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>
>         if (!overwrite && ovl_type_merge_or_lower(new))
>                 err =3D ovl_set_redirect(new, samedir);
> @@ -1257,12 +1259,12 @@ static int ovl_rename(struct mnt_idmap *idmap, st=
ruct inode *olddir,
>                  ovl_type_merge(old->d_parent))
>                 err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>
>         err =3D ovl_do_rename(ofs, old_upperdir, olddentry,
>                             new_upperdir, newdentry, flags);
>         if (err)
> -               goto out_dput;
> +               goto out_unlock;
>
>         if (cleanup_whiteout)
>                 ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> @@ -1284,10 +1286,6 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new))
>                 ovl_copyattr(d_inode(new));
>
> -out_dput:
> -       dput(newdentry);
> -out_dput_old:
> -       dput(olddentry);
>  out_unlock:
>         unlock_rename(new_upperdir, old_upperdir);
>  out_revert_creds:
> @@ -1297,6 +1295,8 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         else
>                 ovl_drop_write(old);
>  out:
> +       dput(newdentry);
> +       dput(olddentry);
>         dput(opaquedir);
>         ovl_cache_free(&list);
>         return err;
> --
> 2.49.0
>

