Return-Path: <linux-fsdevel+bounces-55100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4BB06EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABDA501C28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44728B3EF;
	Wed, 16 Jul 2025 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTCWW9Sk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8180289E03;
	Wed, 16 Jul 2025 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650094; cv=none; b=guqe/vEadu/V/1Lf6AixzXI0xWLvhoaw9xIRhZyDmaeWa+3o96EJJKELb7+iRcUikzTypBBGdoWrhoAN3SJdON8UnIHfEoDEq1TugtYjMks1EFQDeR1gnAXHY/BfNbbKds8TpowyIUo0z8epB9bUSQxWvL3VqKk7tPl4EToGxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650094; c=relaxed/simple;
	bh=jbYSwYq/LrNQC5RrA3+i4aSqmoLMCmK9jiU6GIW3XA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SI7km4jhjDItyGj0XWB+048+0Ir155PFcXfJ7ysejGHB0rPMAwH9oNBtjkcUR3MfJUudvKdNNmTEaK/u2vxvBnoWpKWFoSOGtPjXLqJHTTUZ0JljxvBL1JLaCsIyjQSYB9vD1sl6reKvarZanr7kAK0Qjdy5dch0IGustGrqu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTCWW9Sk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so9198555a12.2;
        Wed, 16 Jul 2025 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752650091; x=1753254891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVpSzoalFSkAUuoDNylavvpUDY4sFeCO3gIKEnRxr5E=;
        b=JTCWW9Sk4cPVTSiWbgWyDIdl6iYdToLOeV4psh0TAO1RMm83YTsCvtiCRUBwd+MGpP
         EedhqSvqKctFC98DaURQ+StQ4k5yyzhSpqd5sxTo+2nXvOOH6QYt9GlKGUs7FS6WQoJA
         uUMPIXElNHkc1FJsvVArRKBfmKiVddoOlkOUeoOFg+/iLxAqcYqng7rlMsnyHkBmhlWL
         FMP3cEMNU7B/KnxqX9vBRqSYrTval7hZZxFFcBwZa0uXvR1Uroad03RAusD+FDAJUYrM
         Xu4rgnLV6U5+x4G/QzcFWSYnuOIwkL+NOW9eDDEflYyrXKU7HT779EdXvIhZbo9Vw1hZ
         Ogdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752650091; x=1753254891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVpSzoalFSkAUuoDNylavvpUDY4sFeCO3gIKEnRxr5E=;
        b=TCNY53DUXT9Bj0sbjUBueNjKDhq+bVWiJr4QjhgomqM3bSK+4hLm7p+SXGhN4hdheo
         p7UToH++Qku38XqAAZH7HG50bDOfEGlZlDhSXoInSpUKBIr/LClTT0wDdDcbGY2f+skq
         tEP5iz+5KQkxkDKqOEQLv5iFKPOoctzNZCFiDpiF7hP1kHxA2d9923wgCF0s0EUIQyrg
         aVuvxVdgcuorjQzLap82kyNvYbB+8UI8s7XoeWG/MD6c97xfDDOBUNOwayqbWdp2SOul
         CKAO8vaHomil0XjbU/FrMO+uDKMMsjBKgwrNglUQCT3LbnLK5EOY4gp4Jwll7S6JpsGQ
         lhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf1i1j6VXVOgFu4XuTiSYZBN3Nr6hycdWHxl6pY95XUWE1/oKkjngdkfN5/aPS42UZdRKz1TPvqxbw5DwkPQ==@vger.kernel.org, AJvYcCXrTcxXAEa+fcCR6JbsJEzYok3rlS3tY4VxIbFsPHwNqh1iEwXlR1h2mEs4+e4Mxv3m311ZAZ2TTh66NsRe@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoKP9jFQ1fkPvPnQRadXKFWE7jIuYygYtfEX4u+mgf+rzWGvh
	g6QL86EGf8vRd/N+PJ/9xYzqIlmp5bbX/t9Ujb+kZLUE0m70n+wU1bXI1AJd8Y8SuMgQg2moSJ/
	OH9wVceXW/SURmUreo9NJ+Kq4Qnrv1Zk=
X-Gm-Gg: ASbGnctCvZ+tZGn5ny0rwCnAun92hTF0csU/9O2SgSftNIzSXF2YC3HbbSKJm9Qi1Lv
	iwG8C0gLiV4Fu2xsBYo5UXUr0/OCuys9GsyvqoZEHM7YuhiYU3T1DCD6Q69vdmvn6FItVUfTSkh
	hIo9mWObs+8Ow48As9J4jmBoRON8cILowHH1tbTeTlxU1EVdCBUbSA2cFHyv4qV6fkUz+qII/Xb
	Uzu4mU=
X-Google-Smtp-Source: AGHT+IH1MkGmKPTz2JdzhzEFtUehI9hgAHStWeOT4xdJYTEfnJ78AVllDK2PiYGi9rJCvNYtt3MWW3CKefSvFF7JPoo=
X-Received: by 2002:a17:906:c106:b0:ad8:9d41:371e with SMTP id
 a640c23a62f3a-ae9c9ac1696mr244436066b.36.1752650090725; Wed, 16 Jul 2025
 00:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-22-neil@brown.name>
In-Reply-To: <20250716004725.1206467-22-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:14:39 +0200
X-Gm-Features: Ac12FXzHQ8QXwm1OMjdpujggW250y4Q6xmzdAauv0funwD6oOYUMtqOXcDp-Dmc
Message-ID: <CAOQ4uxjjrkSrVZ9sWjfZ1tG4XH8tuCwoD_YXaHFZYqOZSCKYvA@mail.gmail.com>
Subject: Re: [PATCH v3 21/21] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> The only remaining user of ovl_cleanup() is ovl_cleanup_locked(), so we
> no longer need both.
>
> This patch renames ovl_cleanup() to ovl_cleanup_locked() and makes it
> static.
> ovl_cleanup_unlocked() is renamed to ovl_cleanup().
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/copy_up.c   |  4 ++--
>  fs/overlayfs/dir.c       | 27 ++++++++++++++-------------
>  fs/overlayfs/overlayfs.h |  3 +--
>  fs/overlayfs/readdir.c   | 10 +++++-----
>  fs/overlayfs/super.c     |  4 ++--
>  fs/overlayfs/util.c      |  2 +-
>  6 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 8f8dbe8a1d54..c4d7c281d473 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -569,7 +569,7 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>         ovl_parent_unlock(indexdir);
>  out:
>         if (err)
> -               ovl_cleanup_unlocked(ofs, indexdir, temp);
> +               ovl_cleanup(ofs, indexdir, temp);
>         dput(temp);
>  free_name:
>         kfree(name.name);
> @@ -854,7 +854,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  cleanup:
>         unlock_rename(c->workdir, c->destdir);
>  cleanup_unlocked:
> -       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> +       ovl_cleanup(ofs, c->workdir, temp);
>         dput(temp);
>         goto out;
>  }
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index dedf89546e5f..30619777f0f6 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -24,7 +24,8 @@ MODULE_PARM_DESC(redirect_max,
>
>  static int ovl_set_redirect(struct dentry *dentry, bool samedir);
>
> -int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *w=
dentry)
> +static int ovl_cleanup_locked(struct ovl_fs *ofs, struct inode *wdir,
> +                             struct dentry *wdentry)
>  {
>         int err;
>
> @@ -43,8 +44,8 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir,=
 struct dentry *wdentry)
>         return err;
>  }
>
> -int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> -                        struct dentry *wdentry)
> +int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
> +               struct dentry *wdentry)
>  {
>         int err;
>
> @@ -52,7 +53,7 @@ int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct den=
try *workdir,
>         if (err)
>                 return err;
>
> -       ovl_cleanup(ofs, workdir->d_inode, wdentry);
> +       ovl_cleanup_locked(ofs, workdir->d_inode, wdentry);
>         ovl_parent_unlock(workdir);
>
>         return 0;
> @@ -149,14 +150,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
ruct dentry *dir,
>         if (err)
>                 goto kill_whiteout;
>         if (flags)
> -               ovl_cleanup_unlocked(ofs, ofs->workdir, dentry);
> +               ovl_cleanup(ofs, ofs->workdir, dentry);
>
>  out:
>         dput(whiteout);
>         return err;
>
>  kill_whiteout:
> -       ovl_cleanup_unlocked(ofs, ofs->workdir, whiteout);
> +       ovl_cleanup(ofs, ofs->workdir, whiteout);
>         goto out;
>  }
>
> @@ -351,7 +352,7 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>         return 0;
>
>  out_cleanup:
> -       ovl_cleanup_unlocked(ofs, upperdir, newdentry);
> +       ovl_cleanup(ofs, upperdir, newdentry);
>         dput(newdentry);
>         return err;
>  }
> @@ -411,7 +412,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>                 goto out_cleanup_unlocked;
>
>         ovl_cleanup_whiteouts(ofs, upper, list);
> -       ovl_cleanup_unlocked(ofs, workdir, upper);
> +       ovl_cleanup(ofs, workdir, upper);
>
>         /* dentry's upper doesn't match now, get rid of it */
>         d_drop(dentry);
> @@ -421,7 +422,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  out_cleanup:
>         unlock_rename(workdir, upperdir);
>  out_cleanup_unlocked:
> -       ovl_cleanup_unlocked(ofs, workdir, opaquedir);
> +       ovl_cleanup(ofs, workdir, opaquedir);
>         dput(opaquedir);
>  out:
>         return ERR_PTR(err);
> @@ -516,7 +517,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>                 if (err)
>                         goto out_cleanup_unlocked;
>
> -               ovl_cleanup_unlocked(ofs, workdir, upper);
> +               ovl_cleanup(ofs, workdir, upper);
>         } else {
>                 err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
>                 unlock_rename(workdir, upperdir);
> @@ -526,7 +527,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>         ovl_dir_modified(dentry->d_parent, false);
>         err =3D ovl_instantiate(dentry, inode, newdentry, hardlink, NULL)=
;
>         if (err) {
> -               ovl_cleanup_unlocked(ofs, upperdir, newdentry);
> +               ovl_cleanup(ofs, upperdir, newdentry);
>                 dput(newdentry);
>         }
>  out_dput:
> @@ -541,7 +542,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>  out_cleanup:
>         unlock_rename(workdir, upperdir);
>  out_cleanup_unlocked:
> -       ovl_cleanup_unlocked(ofs, workdir, newdentry);
> +       ovl_cleanup(ofs, workdir, newdentry);
>         dput(newdentry);
>         goto out_dput;
>  }
> @@ -1268,7 +1269,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>                 goto out_revert_creds;
>
>         if (cleanup_whiteout)
> -               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
> +               ovl_cleanup(ofs, old_upperdir, newdentry);
>
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index b1e31e060157..56de6e83d24e 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -857,8 +857,7 @@ struct ovl_cattr {
>  struct dentry *ovl_create_real(struct ovl_fs *ofs,
>                                struct dentry *parent, struct dentry *newd=
entry,
>                                struct ovl_cattr *attr);
> -int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *de=
ntry);
> -int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, str=
uct dentry *dentry);
> +int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir, struct dentr=
y *dentry);
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r);
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>                                struct ovl_cattr *attr);
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index ecbf39a49d57..b65cdfce31ce 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -1048,7 +1048,7 @@ void ovl_cleanup_whiteouts(struct ovl_fs *ofs, stru=
ct dentry *upper,
>                         continue;
>                 }
>                 if (dentry->d_inode)
> -                       ovl_cleanup_unlocked(ofs, upper, dentry);
> +                       ovl_cleanup(ofs, upper, dentry);
>                 dput(dentry);
>         }
>  }
> @@ -1156,7 +1156,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct =
dentry *parent,
>         int err;
>
>         if (!d_is_dir(dentry) || level > 1)
> -               return ovl_cleanup_unlocked(ofs, parent, dentry);
> +               return ovl_cleanup(ofs, parent, dentry);
>
>         err =3D ovl_parent_lock(parent, dentry);
>         if (err)
> @@ -1168,7 +1168,7 @@ int ovl_workdir_cleanup(struct ovl_fs *ofs, struct =
dentry *parent,
>
>                 err =3D ovl_workdir_cleanup_recurse(ofs, &path, level + 1=
);
>                 if (!err)
> -                       err =3D ovl_cleanup_unlocked(ofs, parent, dentry)=
;
> +                       err =3D ovl_cleanup(ofs, parent, dentry);
>         }
>
>         return err;
> @@ -1217,7 +1217,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         goto next;
>                 } else if (err =3D=3D -ESTALE) {
>                         /* Cleanup stale index entries */
> -                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
> +                       err =3D ovl_cleanup(ofs, indexdir, index);
>                 } else if (err !=3D -ENOENT) {
>                         /*
>                          * Abort mount to avoid corrupting the index if
> @@ -1233,7 +1233,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
>                         err =3D ovl_cleanup_and_whiteout(ofs, indexdir, i=
ndex);
>                 } else {
>                         /* Cleanup orphan index entries */
> -                       err =3D ovl_cleanup_unlocked(ofs, indexdir, index=
);
> +                       err =3D ovl_cleanup(ofs, indexdir, index);
>                 }
>
>                 if (err)
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 9fd0b3acd1a4..4afa91882075 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -600,11 +600,11 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
*ofs)
>
>         /* Best effort cleanup of whiteout and temp file */
>         if (err)
> -               ovl_cleanup_unlocked(ofs, workdir, whiteout);
> +               ovl_cleanup(ofs, workdir, whiteout);
>         dput(whiteout);
>
>  cleanup_temp:
> -       ovl_cleanup_unlocked(ofs, workdir, temp);
> +       ovl_cleanup(ofs, workdir, temp);
>         release_dentry_name_snapshot(&name);
>         dput(temp);
>         dput(dest);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 3df0f3efe592..62f809cf8ba9 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1116,7 +1116,7 @@ static void ovl_cleanup_index(struct dentry *dentry=
)
>                                                indexdir, index);
>         } else {
>                 /* Cleanup orphan index entries */
> -               err =3D ovl_cleanup_unlocked(ofs, indexdir, index);
> +               err =3D ovl_cleanup(ofs, indexdir, index);
>         }
>         if (err)
>                 goto fail;
> --
> 2.49.0
>

