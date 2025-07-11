Return-Path: <linux-fsdevel+bounces-54641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EC6B01CE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 15:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4029917B9BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75942E3371;
	Fri, 11 Jul 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHhLHfOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810572E0418;
	Fri, 11 Jul 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239023; cv=none; b=RATGDAQ7Ga0g14v4JPRk2wYxvIOVV6g7T7SgdzgUgxJLVoxvnADUOHYwvKFl9dTi60GWTra/+pm2+TbFXQeSudqb552Jt0ZVoQ/1rYGYNCO241DqiXXIjs8fPLcRUPpAIrXDymu8YUS1be9QvwgvlOKC9GOqBY2BkhgWX5RgoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239023; c=relaxed/simple;
	bh=TxOoA8v7/MvIhiXKE8iTie05XzYsxbzMD41qQCz5YXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrIgEzpOwNCLgZLfl7Gh+FEWh55kxp8nQQX7iyAyB611rVHUO+MAqMT5Zmqpe8Cc8V+vXsATIK2qcR+VMAEbSsinwwAMe5rOBoJEcZQCVrl3bfK2G/OMsOTQfwjc7PnRo8eyjctUQYveD/+BPj8LoYpDZ+bNRgHc70z1c5Smh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHhLHfOs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so366253366b.1;
        Fri, 11 Jul 2025 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752239020; x=1752843820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElamLzf9bXGvboufQHryLqek8y70CNFhsDkF5qjGARc=;
        b=XHhLHfOsOTuSMjFqM9BmAMLg8zJvcagaZudj76tvVexP0phi5+Woav2K1UjGwzKFcl
         xbjx/j+CWofNPAXKxyKjxOTdF+w+fB+R0414KvhQnPnSYXm8fR361ObiElQuZwepOLJK
         Z1Ypw6XdOgJMBbnKuk1vGz7aObTA5Y9cwWlPKMU7bhBLdFtynov/XFvoLFoIcVnOQSQs
         sbxO6tR8u1yi0+KtbrZ4JPOm1cCKWedQ/RQ/qC9pcQ9e5nJAdDdzi43vBIDgYtaYnWqL
         UtJIOkMSsMrgqHnV2sSzedSXgWVE3klKDjG3WvOq9Xti5flw7I3P9o9hUnbCPPgwhTIn
         Vpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239020; x=1752843820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElamLzf9bXGvboufQHryLqek8y70CNFhsDkF5qjGARc=;
        b=uBmEwlXsFJMfa/cW7jV5RLIBJZ0/arJSpSdcHOK9pPIPHe5NoYiWFNKUQZZgokQ8N8
         Y6HVJTgVfg5i8KgwGWGz7V9VyjaXSWSImH4Atp27ULXIBv7LZlInNs26mexc42jDEI1R
         JWgvj6ua0nT2+tULJpiBQo0yvGWGq1pNnB2A239wRdFNCyYWoik25sgz7qRa70WfDazU
         UjR26Tgyb2CX4Mj5lktjpJtfxpVALqs1LjIHzIgesBDu7rSHxvh5rcsGs/PcRewl6yiQ
         XgzF9q1lk+GsD1TZXnOPnmmMW2FlVBpdSa+CVAlQ0aAUhoh1kMxuE0zVd86hqcrA6jp/
         mDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNkd/WZ2OwT7lJ8M1mpicSB1cvWsylk5rIRcGNCKNpBf+581KU4yiUa5OdCAbXXuDtl8zFgAHjmukpAYH/HA==@vger.kernel.org, AJvYcCWf6RS7JI+Vd68g43z84GRxmgtWza/pbCqrhEnsOumG2xaHinXmpUgYZhL5Cr7DKpO3aD2YICfNTr5dicQc@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3E9icZ9Iw/kEK6FhRVLDepSUOKSj1XMX6pRkKjA/6vjkgS4W
	hfqaxywLPrAX7FOmb5aYGMy8ssMC4Xz0RcbIEg4Vr3XtO5rUT74OXJIT+P0aeCkEtVujsQQKSF+
	C4mSGi5JbdZPgrK/fYct4P9sRDhDy7t1k3ygBKajG7w==
X-Gm-Gg: ASbGncslZa4eZx6+zLvNm4g7TENr7EFJwoP20v70fIm4ZPcK82ZkLnrX5PtHnlSg0Hl
	aUSrU250p9y7yeMhYS0De69/90qZQv+WJ3dvRuJDptDRU9vG3+wBbv9UklJKK9WLK//O8qW2mEQ
	tKWCdgu8X/fRCZOo7NmHNBunsaiSUKFAat1S7XKHbErG+1eiSsgiSrpV+IHVZFpy5jdvB2O9o30
	L6dgY4=
X-Google-Smtp-Source: AGHT+IFSPuit8ZzEAdst6XD5Zq4h0VzsA1MD5R1z9hPVrgicF+DSArpkDCNLrP9dg2ejQKIjPI2Fg3YsaPAPZ3v+o+E=
X-Received: by 2002:a17:907:3c84:b0:ae3:5887:4219 with SMTP id
 a640c23a62f3a-ae6fc136150mr321098766b.45.1752239017875; Fri, 11 Jul 2025
 06:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-9-neil@brown.name>
In-Reply-To: <20250710232109.3014537-9-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 15:03:26 +0200
X-Gm-Features: Ac12FXyOv56EE93kRZVEaTwLHALtT2Xd--YwgpnspUAlU3OOJbFICVrZvNvtREc
Message-ID: <CAOQ4uxiRBS14KdZRY4ad_6cOZ+u3dZp+0C+8WYjJ=qmqhjqQTg@mail.gmail.com>
Subject: Re: [PATCH 08/20] ovl: narrow locking in ovl_rename()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> Drop the rename lock immediately after the rename, and use
> ovl_cleanup_unlocked() for cleanup.
>
> This makes way for future changes where locks are taken on individual
> dentries rather than the whole directory.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/dir.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 687d5e12289c..d01e83f9d800 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1262,9 +1262,10 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>                             new_upperdir, newdentry, flags);
>         if (err)
>                 goto out_dput;
> +       unlock_rename(new_upperdir, old_upperdir);
>
>         if (cleanup_whiteout)
> -               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
> +               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
>
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
> @@ -1283,12 +1284,8 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         if (d_inode(new) && ovl_dentry_upper(new))
>                 ovl_copyattr(d_inode(new));
>
> -out_dput:
>         dput(newdentry);
> -out_dput_old:
>         dput(olddentry);
> -out_unlock:
> -       unlock_rename(new_upperdir, old_upperdir);
>  out_revert_creds:
>         ovl_revert_creds(old_cred);
>         if (update_nlink)
> @@ -1299,6 +1296,14 @@ static int ovl_rename(struct mnt_idmap *idmap, str=
uct inode *olddir,
>         dput(opaquedir);
>         ovl_cache_free(&list);
>         return err;
> +
> +out_dput:
> +       dput(newdentry);
> +out_dput_old:
> +       dput(olddentry);
> +out_unlock:
> +       unlock_rename(new_upperdir, old_upperdir);
> +       goto out_revert_creds;
>  }
>
>  static int ovl_create_tmpfile(struct file *file, struct dentry *dentry,
> --
> 2.49.0
>

I think we get end up with fewer and clearer to understand goto labels
with a relatively simple trick:

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fe493f3ed6b6..7cddaa7b263e 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1069,8 +1069,8 @@ static int ovl_rename(struct mnt_idmap *idmap,
struct inode *olddir,
        int err;
        struct dentry *old_upperdir;
        struct dentry *new_upperdir;
-       struct dentry *olddentry;
-       struct dentry *newdentry;
+       struct dentry *olddentry =3D NULL;
+       struct dentry *newdentry =3D NULL;
        struct dentry *trap;
        bool old_opaque;
        bool new_opaque;
@@ -1187,18 +1187,22 @@ static int ovl_rename(struct mnt_idmap *idmap,
struct inode *olddir,
        olddentry =3D ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
                                     old->d_name.len);
        err =3D PTR_ERR(olddentry);
-       if (IS_ERR(olddentry))
+       if (IS_ERR(olddentry)) {
+               olddentry =3D NULL;
                goto out_unlock;
+       }

        err =3D -ESTALE;
        if (!ovl_matches_upper(old, olddentry))
-               goto out_dput_old;
+               goto out_unlock;

        newdentry =3D ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
                                     new->d_name.len);
        err =3D PTR_ERR(newdentry);
-       if (IS_ERR(newdentry))
-               goto out_dput_old;
+       if (IS_ERR(newdentry)) {
+               newdentry =3D NULL;
+               goto out_unlock;
+       }

        old_opaque =3D ovl_dentry_is_opaque(old);
        new_opaque =3D ovl_dentry_is_opaque(new);
@@ -1207,28 +1211,28 @@ static int ovl_rename(struct mnt_idmap *idmap,
struct inode *olddir,
        if (d_inode(new) && ovl_dentry_upper(new)) {
                if (opaquedir) {
                        if (newdentry !=3D opaquedir)
-                               goto out_dput;
+                               goto out_unlock;
                } else {
                        if (!ovl_matches_upper(new, newdentry))
-                               goto out_dput;
+                               goto out_unlock;
                }
        } else {
                if (!d_is_negative(newdentry)) {
                        if (!new_opaque || !ovl_upper_is_whiteout(ofs,
newdentry))
-                               goto out_dput;
+                               goto out_unlock;
                } else {
                        if (flags & RENAME_EXCHANGE)
-                               goto out_dput;
+                               goto out_unlock;
                }
        }

        if (olddentry =3D=3D trap)
-               goto out_dput;
+               goto out_unlock;
        if (newdentry =3D=3D trap)
-               goto out_dput;
+               goto out_unlock;

        if (olddentry->d_inode =3D=3D newdentry->d_inode)
-               goto out_dput;
+               goto out_unlock;

        err =3D 0;
        if (ovl_type_merge_or_lower(old))
@@ -1236,7 +1240,7 @@ static int ovl_rename(struct mnt_idmap *idmap,
struct inode *olddir,
        else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
                err =3D ovl_set_opaque_xerr(old, olddentry, -EXDEV);
        if (err)
-               goto out_dput;
+               goto out_unlock;

        if (!overwrite && ovl_type_merge_or_lower(new))
                err =3D ovl_set_redirect(new, samedir);
@@ -1244,15 +1248,16 @@ static int ovl_rename(struct mnt_idmap *idmap,
struct inode *olddir,
                 ovl_type_merge(old->d_parent))
                err =3D ovl_set_opaque_xerr(new, newdentry, -EXDEV);
        if (err)
-               goto out_dput;
+               goto out_unlock;

        err =3D ovl_do_rename(ofs, old_upperdir->d_inode, olddentry,
                            new_upperdir->d_inode, newdentry, flags);
        if (err)
-               goto out_dput;
+               goto out_unlock;
+       unlock_rename(new_upperdir, old_upperdir);

        if (cleanup_whiteout)
-               ovl_cleanup(ofs, old_upperdir->d_inode, newdentry);
+               ovl_cleanup_unlocked(ofs, old_upperdir->d_inode, newdentry)=
;

        if (overwrite && d_inode(new)) {
                if (new_is_dir)
@@ -1271,12 +1276,6 @@ static int ovl_rename(struct mnt_idmap *idmap,
struct inode *olddir,
        if (d_inode(new) && ovl_dentry_upper(new))
                ovl_copyattr(d_inode(new));

-out_dput:
-       dput(newdentry);
-out_dput_old:
-       dput(olddentry);
-out_unlock:
-       unlock_rename(new_upperdir, old_upperdir);
 out_revert_creds:
        ovl_revert_creds(old_cred);
        if (update_nlink)
@@ -1284,9 +1283,15 @@ static int ovl_rename(struct mnt_idmap *idmap,
struct inode *olddir,
        else
                ovl_drop_write(old);
 out:
+       dput(newdentry);
+       dput(olddentry);
        dput(opaquedir);
        ovl_cache_free(&list);
        return err;
+
+out_unlock:
+       unlock_rename(new_upperdir, old_upperdir);
+       goto out_revert_creds;
 }

