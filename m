Return-Path: <linux-fsdevel+bounces-25415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403D94BCD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB82289F21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44D18C90C;
	Thu,  8 Aug 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt1zTWnB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21418C347
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118517; cv=none; b=c4XSaaR/TnQ5jD5EyeF6esbHWord82osmW7kpdQLIz7BY2WPpFtGX95oikI1H/y3GJJKfaA0xjhTR1bXwBDWkei8GPD/KYKy5Ax1UWhFCJsg308q+yTKQGZlI81QFpTCav05VjybWNieztz0FLMzRH/JT8vJc8OB2qJ+nTI6bF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118517; c=relaxed/simple;
	bh=1RGrZQS4JJrBMsJg66HYxVDQYce2rnsfjGxA/KNExiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzYUjPc1y5qx0AfyMejBC4FPgSJsDsZ6JB4O9CAX9McFe1Rty6kCedgYK/WN3GwvdvWhXYIzvkjN0gANyCdwQv9fDthXdfYKQYC0VOy5c9Rw8JnMgKrNMlcx+bU6VFzEIlDpL5kKpQG1F0wqveJY87D2i3W7tNkCC6mr0A0Vh+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt1zTWnB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a3375015f8so60008185a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723118514; x=1723723314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAYQCPU+AgT0FqXqZ8xsWEj7iWMyUaAjd7bToeLw8sU=;
        b=Dt1zTWnBv9jg1KFoc4cHrq2N4NdWcC8hJzGBXsbCHMBwCxXqjBWe2dAofx1T578DqS
         yRqPIqbblnTAM2J0rdH48+ny2goFySIfswRJb2SgQQmq71KFSNE90JeUTWjbN/8JLhG9
         u/kw9wchmGgJjydNc4c1qB2dW0MjWXtdVEV2Jb/Q+aOjOt+yURzZA01KMPD4RYNwAqgB
         7VRLmJqZymNa/O3B76gRByssW61vMCjfN32JrYcgpCWIJNJ4FKpD77y1iavwLCrzw2x2
         3igcGkp00wsHqE7d45of5OmfKK1VElKYfnEw6GXpv9OWYiy265SAo4qik3l+ULbKuosa
         j3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723118514; x=1723723314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAYQCPU+AgT0FqXqZ8xsWEj7iWMyUaAjd7bToeLw8sU=;
        b=dyda6NlwsEmUAtf1R1H1V9lU2MhrzMpo/xPYYyKLjcPLueYQsThHs7cYz3Fv/tXZz2
         VIFjdGzd9gskZyNWJcXWhpFmez58hPwMgRXQJ9cIl4A0J/v4t7MbR8QKixXu2FxRZ1GQ
         0z7FdrXGXfGISB4TPRzyEVWreIVgA9zV6lC9rZQqcLEy00tKjX+LvAmbxaXgrAvn4WZw
         +sNGWY7N6vhIsa0k/4zu/vvvmyUS+V37Tve+0tIpI4cUyv4Saf7Bm0GnDXQuFoFiZTxP
         /26WSwuDM8G+k2AxHefkRMvki56JPyoVi0XF+0PeoYMYsRh+RYCUCWBJk61eNEcml9gw
         W5dA==
X-Gm-Message-State: AOJu0Yy/kvSo2MhHfsFKqiDhhAVUWLVn9qBNuaeniEcJaojFaG78W1xK
	zZ4PnN1WbtKo00aEbanENvcMl3XpodFL0fdAa6X1GHOTUQ6xC6K3no0IEQGD3ayvQGS2C9DKH7+
	tP/gY9bDmSX+6x5VtXWiGSISVHnWVKGb1tPo=
X-Google-Smtp-Source: AGHT+IGM8ZaxLoa6mpj7ddUJss0XURTjOvrpjEIVHq5HqQWZsm35krwdyTghxjGjCio/2U+cFmL2bCEKr9QG8lz4KwI=
X-Received: by 2002:a05:620a:4722:b0:79c:b8c:8e1f with SMTP id
 af79cd13be357-7a3818a41bemr174310885a.48.1723118514275; Thu, 08 Aug 2024
 05:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807180706.30713-1-jack@suse.cz> <20240807183003.23562-7-jack@suse.cz>
In-Reply-To: <20240807183003.23562-7-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 Aug 2024 14:01:42 +0200
Message-ID: <CAOQ4uxgp-XrcMc9Oqf-hpkd+qz2r7=tf8vva+Eqb5T+9042x3Q@mail.gmail.com>
Subject: Re: [PATCH 07/13] overlayfs: Make ovl_start_write() return error
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> sb_start_write() will be returning error for a shutdown filesystem.
> Teach all ovl_start_write() to handle the error and bail out.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/overlayfs/copy_up.c   | 42 +++++++++++++++++++++++++++++++---------
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/util.c      |  3 ++-
>  3 files changed, 36 insertions(+), 11 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index a5ef2005a2cc..6ebfd9c7b260 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -584,7 +584,9 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
>         struct ovl_fs *ofs =3D OVL_FS(c->dentry->d_sb);
>         struct inode *udir =3D d_inode(upperdir);
>
> -       ovl_start_write(c->dentry);
> +       err =3D ovl_start_write(c->dentry);
> +       if (err)
> +               return err;
>
>         /* Mark parent "impure" because it may now contain non-pure upper=
 */
>         err =3D ovl_set_impure(c->parent, upperdir);
> @@ -744,6 +746,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>         struct path path =3D { .mnt =3D ovl_upper_mnt(ofs) };
>         struct dentry *temp, *upper, *trap;
>         struct ovl_cu_creds cc;
> +       bool frozen =3D false;

frozen is not a descriptive name for taking sb_writers?

>         int err;
>         struct ovl_cattr cattr =3D {
>                 /* Can't properly set mode on creation because of the uma=
sk */
> @@ -756,7 +759,11 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>         if (err)
>                 return err;
>
> -       ovl_start_write(c->dentry);
> +       err =3D ovl_start_write(c->dentry);
> +       if (err) {
> +               ovl_revert_cu_creds(&cc);
> +               return err;
> +       }
>         inode_lock(wdir);
>         temp =3D ovl_create_temp(ofs, c->workdir, &cattr);
>         inode_unlock(wdir);
> @@ -778,7 +785,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>          * ovl_copy_up_data(), so lock workdir and destdir and make sure =
that
>          * temp wasn't moved before copy up completion or cleanup.
>          */
> -       ovl_start_write(c->dentry);
> +       if (!err) {

This is confusing, I admit, but !err is not checked because ovl_cleanup()
needs sb_writers held.

Suggest something like:

err2 =3D ovl_start_write(c->dentry);
if (err2) {
     dput(temp);
     return err ?: err2;
}

> +               err =3D ovl_start_write(c->dentry);
> +               frozen =3D !err;
> +       }
>         trap =3D lock_rename(c->workdir, c->destdir);
>         if (trap || temp->d_parent !=3D c->workdir) {
>                 /* temp or workdir moved underneath us? abort without cle=
anup */
> @@ -827,7 +837,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>  unlock:
>         unlock_rename(c->workdir, c->destdir);
>  out:
> -       ovl_end_write(c->dentry);
> +       if (frozen)
> +               ovl_end_write(c->dentry);
>
>         return err;
>
> @@ -851,7 +862,11 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ct=
x *c)
>         if (err)
>                 return err;
>
> -       ovl_start_write(c->dentry);
> +       err =3D ovl_start_write(c->dentry);
> +       if (err) {
> +               ovl_revert_cu_creds(&cc);
> +               return err;
> +       }
>         tmpfile =3D ovl_do_tmpfile(ofs, c->workdir, c->stat.mode);
>         ovl_end_write(c->dentry);
>         ovl_revert_cu_creds(&cc);
> @@ -865,7 +880,9 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx=
 *c)
>                         goto out_fput;
>         }
>
> -       ovl_start_write(c->dentry);
> +       err =3D ovl_start_write(c->dentry);
> +       if (err)
> +               goto out_fput;
>
>         err =3D ovl_copy_up_metadata(c, temp);
>         if (err)
> @@ -964,7 +981,9 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
>                  * Mark parent "impure" because it may now contain non-pu=
re
>                  * upper
>                  */
> -               ovl_start_write(c->dentry);
> +               err =3D ovl_start_write(c->dentry);
> +               if (err)
> +                       goto out_free_fh;
>                 err =3D ovl_set_impure(c->parent, c->destdir);
>                 ovl_end_write(c->dentry);
>                 if (err)
> @@ -982,7 +1001,9 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
>         if (c->indexed)
>                 ovl_set_flag(OVL_INDEX, d_inode(c->dentry));
>
> -       ovl_start_write(c->dentry);
> +       err =3D ovl_start_write(c->dentry);
> +       if (err)
> +               goto out;
>         if (to_index) {
>                 /* Initialize nlink for copy up of disconnected dentry */
>                 err =3D ovl_set_nlink_upper(c->dentry);
> @@ -1088,7 +1109,10 @@ static int ovl_copy_up_meta_inode_data(struct ovl_=
copy_up_ctx *c)
>          * Writing to upper file will clear security.capability xattr. We
>          * don't want that to happen for normal copy-up operation.
>          */
> -       ovl_start_write(c->dentry);
> +       err =3D ovl_start_write(c->dentry);
> +       if (err)
> +               goto out_free;
> +
>         if (capability) {
>                 err =3D ovl_do_setxattr(ofs, upperpath.dentry, XATTR_NAME=
_CAPS,
>                                       capability, cap_size, 0);
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 0bfe35da4b7b..ee8f2b28159a 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -423,7 +423,7 @@ static inline int ovl_do_getattr(const struct path *p=
ath, struct kstat *stat,
>  /* util.c */
>  int ovl_get_write_access(struct dentry *dentry);
>  void ovl_put_write_access(struct dentry *dentry);
> -void ovl_start_write(struct dentry *dentry);
> +int __must_check ovl_start_write(struct dentry *dentry);
>  void ovl_end_write(struct dentry *dentry);
>  int ovl_want_write(struct dentry *dentry);
>  void ovl_drop_write(struct dentry *dentry);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index edc9216f6e27..b53fa14506a9 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -25,10 +25,11 @@ int ovl_get_write_access(struct dentry *dentry)
>  }
>
>  /* Get write access to upper sb - may block if upper sb is frozen */
> -void ovl_start_write(struct dentry *dentry)
> +int __must_check ovl_start_write(struct dentry *dentry)
>  {
>         struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         sb_start_write(ovl_upper_mnt(ofs)->mnt_sb);
> +       return 0;
>  }

Is this an unintentional omission of sb_start_write() return value or
fixed later on?

Thanks,
Amir.

