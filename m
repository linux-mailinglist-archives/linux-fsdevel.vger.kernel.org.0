Return-Path: <linux-fsdevel+bounces-46121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A5BA82D57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0546550B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896F27700D;
	Wed,  9 Apr 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG4C8JoY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554C277002;
	Wed,  9 Apr 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218690; cv=none; b=LvVu9i55x0gDwbBDZ9kNprY9F8vBnuxU7ZNGetYIlhznSLlHgOYzI1swME66/m7F/xqtBN8LbE/vV/lYHX5PUiiCogOC/v87dfFl2M4pGmDHpo4BtwHRyujwQlL+h6mujfReAOa7lTLgqCocipES3WbROBBK4s6lNPvZ876uFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218690; c=relaxed/simple;
	bh=D6BVn03W4IKZEe/MCFk1MNoxK/IQ47mQ0uyL6OtZ8EM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfvPtX9wPeCnXHNztRESiqz66Q+yOnpgIh6a9HnDAxj9C4/NRKA5Bj+a/6JaHOljvcfgdR2Zvy/52cwsSkcZlW099TLSVVv2h/I82sxUHo6l8iw8n+xg8XJDjd1EtW97RMH8O9v8SNhJHSJzkhmF1ZoYqJd7EcmgoZnzL6l6uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG4C8JoY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so10561528a12.2;
        Wed, 09 Apr 2025 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744218687; x=1744823487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylDrT2YMOpwFaEsR9XQfKs+Xj9kBsGYPmtVt1tViWc0=;
        b=bG4C8JoYVWzQfa6Wd/tW0V5CwqsDxplduCEKphvj67I8h6plCvYmgZ+yLKjtWExy+i
         oKTi7InIhTlCwgsD+DGOEzSWU9tpeq2TeK3zxg/Ex6hit7CdpakiBvgDyOri+ghe+83+
         1+fl+jx79nhCMeKbWxSt8fZ6itTZRX/RY+ZVoCI1BGLKK5VbwQlnUS67yI7yZJ/GMqDN
         4C3daq/pN2yAvwpfDw42AW3z8vMln2ii8UC05m9PY3V5GWbqPD4sTr/21mOVAfu7KyPL
         xKTxDeocJ84RMFQrleol/J6w6oqbLD+5TXUkqF/1YX0jalEKQhus/BIc+O5gq5fSoPNX
         2mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744218687; x=1744823487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylDrT2YMOpwFaEsR9XQfKs+Xj9kBsGYPmtVt1tViWc0=;
        b=chVd2AtfJlw7kSnb9evTL+nwJkKvdbP+0WxkIIdbPfw0/Rja8JbqvKVLIC1Alag8U4
         VJPkYjGg8qUB2NzJoWnlaILtKr+65HE5vEFG3gnr0REWoD6VU8oiJk8ve/Zgks8s9oIL
         2cs25AcqkMfHLI80C7BSO21gKTvlqrLYw9XoRkvC8b5lUeBQ8VJ856NeBLs8Vmh+N5Md
         O//jVN/ZBYOqy6nuGcr/Z8YSF4+GBj2y5JPoJ9r/EyvZg1b+IyobfPapz2pQYndmae9o
         376zxAzWr+eMKFBgYxpgsxhP8b6UbT8berWW0+3u5oKWrxYGqS2/dqB65YPsjcbeKLmI
         fE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz/oy5G2WpqBaQUYPuPOo0CCh80p7FrLkrQtFQezetTQufYuMRoO/ooxAPxJvRHw0blcLBk23z6tGxy5n8@vger.kernel.org, AJvYcCXN8razJURZ8G92Ligv4Vw3qMjlI5fMkHPz+0HfJA2bMPSeE1qgzwsxOr5yiIgW/OurvHgufXFzAB3L98qCmQ==@vger.kernel.org, AJvYcCXOPfvGi4G5rdQahvO312yeO9ShGbxTyduomIDigcbejkTp3DP55OIbWQcaSkE1Vwi9D7Ll94ppvINmlkjy@vger.kernel.org
X-Gm-Message-State: AOJu0YworAU9BxzN1WZpJPJy4TbfhBLRMc8WOWBFedD6Ic+ULu+le2W9
	k+c0oeznCAYIpPAsdEJXV9Prt3r5WFVq+4s0W/aY83Hc9Q7pqG0gkSKlz9XNwioa4ORfl6QZo2X
	0ZpoHvxenHNrpqm7n0BVVTPiEgW8=
X-Gm-Gg: ASbGncsbvLtdaFMv1Q4kLuBxuG1jl5a2S8ZUzZuwE9A+kVo95Ci09160DmXjHP7Vt8L
	zD0jioZNBia4jHqmN3f9uLr7x1UTNF7E61fSMpZavGj3/d6U2lkEkSVQ7xbU5dlOhrnOG5LXiZz
	ksLJtzrwRmjF6SRiRio36lJA==
X-Google-Smtp-Source: AGHT+IFMi4DahhOFJeO26fMjVb7AIcnezeeOJc4AEg+4JuObcPNLWYHgjpzjbSOdAbAL7OA5hICBd/vdP9/YgryTi1o=
X-Received: by 2002:a05:6402:1e96:b0:5ee:497:67d6 with SMTP id
 4fb4d7f45d1cf-5f2f77573e3mr3606997a12.33.1744218686735; Wed, 09 Apr 2025
 10:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com> <20250409-tonyk-overlayfs-v1-2-3991616fe9a3@igalia.com>
In-Reply-To: <20250409-tonyk-overlayfs-v1-2-3991616fe9a3@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 9 Apr 2025 19:11:15 +0200
X-Gm-Features: ATxdqUErSC32zqmZdURY7CsPA7SOb5uoyIOnGn5UfJAupYrKAMpX0onYca1Dqm0
Message-ID: <CAOQ4uxit5nYeGPN1_uB7c37=eKQi_T-0LtoQaTZHVisAUDoBsg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ovl: Make ovl_dentry_weird() accept casefold dentries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 5:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> ovl_dentry_weird() is used to avoid problems with filesystems that has
> their d_hash and d_compare implementations. Create an exception for this
> function, where only casefold filesystems are eligible to use their own
> d_hash and d_compare functions, allowing to support casefold
> filesystems.

What do you mean by this sentence?
Any casefold fs can be on any layer?
All layers on the same casefold sb? same casefold fstype?


>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  fs/overlayfs/namei.c     | 11 ++++++-----
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/params.c    |  3 ++-
>  fs/overlayfs/util.c      | 12 +++++++-----
>  4 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index be5c65d6f8484b1fba6b3fee379ba1d034c0df8a..140bc609ffebe00151cbb4467=
20f5106dbeb2ef2 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -192,7 +192,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs,=
 struct ovl_fh *fh,
>                 return real;
>         }
>
> -       if (ovl_dentry_weird(real)) {
> +       if (ovl_dentry_weird(real, ofs)) {
>                 dput(real);
>                 return NULL;
>         }
> @@ -244,7 +244,7 @@ static int ovl_lookup_single(struct dentry *base, str=
uct ovl_lookup_data *d,
>                 goto out_err;
>         }
>
> -       if (ovl_dentry_weird(this)) {
> +       if (ovl_dentry_weird(this, ofs)) {
>                 /* Don't support traversing automounts and other weirdnes=
s */
>                 err =3D -EREMOTE;
>                 goto out_err;
> @@ -365,6 +365,7 @@ static int ovl_lookup_data_layer(struct dentry *dentr=
y, const char *redirect,
>                                  struct path *datapath)
>  {
>         int err;
> +       struct ovl_fs *ovl =3D OVL_FS(layer->fs->sb);

ofs please

>
>         err =3D vfs_path_lookup(layer->mnt->mnt_root, layer->mnt, redirec=
t,
>                         LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS | LOOKUP_NO_X=
DEV,
> @@ -376,7 +377,7 @@ static int ovl_lookup_data_layer(struct dentry *dentr=
y, const char *redirect,
>                 return err;
>
>         err =3D -EREMOTE;
> -       if (ovl_dentry_weird(datapath->dentry))
> +       if (ovl_dentry_weird(datapath->dentry, ovl))
>                 goto out_path_put;
>
>         err =3D -ENOENT;
> @@ -767,7 +768,7 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, s=
truct ovl_fh *fh)
>
>         if (ovl_is_whiteout(index))
>                 err =3D -ESTALE;
> -       else if (ovl_dentry_weird(index))
> +       else if (ovl_dentry_weird(index, ofs))
>                 err =3D -EIO;
>         else
>                 return index;
> @@ -815,7 +816,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, s=
truct dentry *upper,
>                 dput(index);
>                 index =3D ERR_PTR(-ESTALE);
>                 goto out;
> -       } else if (ovl_dentry_weird(index) || ovl_is_whiteout(index) ||
> +       } else if (ovl_dentry_weird(index, ofs) || ovl_is_whiteout(index)=
 ||
>                    inode_wrong_type(inode, d_inode(origin)->i_mode)) {
>                 /*
>                  * Index should always be of the same file type as origin
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 6f2f8f4cfbbc177fbd5441483395d7ff72efe332..f3de013517598c44c15ca9f95=
0f6c2f0a5c2084b 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -445,7 +445,7 @@ void ovl_dentry_init_reval(struct dentry *dentry, str=
uct dentry *upperdentry,
>                            struct ovl_entry *oe);
>  void ovl_dentry_init_flags(struct dentry *dentry, struct dentry *upperde=
ntry,
>                            struct ovl_entry *oe, unsigned int mask);
> -bool ovl_dentry_weird(struct dentry *dentry);
> +bool ovl_dentry_weird(struct dentry *dentry, struct ovl_fs *ovl);
>  enum ovl_path_type ovl_path_type(struct dentry *dentry);
>  void ovl_path_upper(struct dentry *dentry, struct path *path);
>  void ovl_path_lower(struct dentry *dentry, struct path *path);
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 6759f7d040c89d3b3c01572579c854a900411157..459e8bddf1777c12c9fa0bdfc=
150e2ea22eaafc3 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -277,6 +277,7 @@ static int ovl_mount_dir_check(struct fs_context *fc,=
 const struct path *path,
>                                enum ovl_opt layer, const char *name, bool=
 upper)
>  {
>         struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct ovl_fs *ovl =3D fc->s_fs_info;

ofs pls

>
>         if (!d_is_dir(path->dentry))
>                 return invalfc(fc, "%s is not a directory", name);
> @@ -290,7 +291,7 @@ static int ovl_mount_dir_check(struct fs_context *fc,=
 const struct path *path,
>         if (sb_has_encoding(path->mnt->mnt_sb))
>                 return invalfc(fc, "case-insensitive capable filesystem o=
n %s not supported", name);
>
> -       if (ovl_dentry_weird(path->dentry))
> +       if (ovl_dentry_weird(path->dentry, ovl))
>                 return invalfc(fc, "filesystem on %s not supported", name=
);
>
>         /*
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 0819c739cc2ffce0dfefa84d3ff8f9f103eec191..4dd523a1a13ab0a6cf51d967d=
0b712873e6d8580 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -200,15 +200,17 @@ void ovl_dentry_init_flags(struct dentry *dentry, s=
truct dentry *upperdentry,
>         spin_unlock(&dentry->d_lock);
>  }
>
> -bool ovl_dentry_weird(struct dentry *dentry)
> +bool ovl_dentry_weird(struct dentry *dentry, struct ovl_fs *ovl)

ovl_fs *ofs as first argument please

>  {
> +       int flags =3D DCACHE_NEED_AUTOMOUNT | DCACHE_MANAGE_TRANSIT;
> +
> +       if (!ovl->casefold)
> +               flags |=3D DCACHE_OP_HASH | DCACHE_OP_COMPARE;
> +
>         if (!d_can_lookup(dentry) && !d_is_file(dentry) && !d_is_symlink(=
dentry))
>                 return true;
>
> -       return dentry->d_flags & (DCACHE_NEED_AUTOMOUNT |
> -                                 DCACHE_MANAGE_TRANSIT |
> -                                 DCACHE_OP_HASH |
> -                                 DCACHE_OP_COMPARE);
> +       return dentry->d_flags & flags;
>  }
>
>  enum ovl_path_type ovl_path_type(struct dentry *dentry)
>
> --
> 2.49.0
>

