Return-Path: <linux-fsdevel+bounces-54597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55EB015E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C010F765DDA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E720AF98;
	Fri, 11 Jul 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/Le467p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D9202F9C;
	Fri, 11 Jul 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222329; cv=none; b=SENdezvKTDJos7yKodMrT66Wy76JeFJs7GpNGeH4VRcqadJAkHYRvVFL8m0l5cMCKThpHxRxKTkDrOWfCk90nc9xJMxK4sCr6m2slyyKr/5ryMTaJtrUuUx/5g1sS2Yy+rcnCLE5GawXIasBzg1tkbXWuGiO+LXshxLIEXx4WHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222329; c=relaxed/simple;
	bh=chtgV9g7OXXhg+ZVaIk/BlOyR774jSDhlUgVqqD41iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEY9DrB23O+DL311ro5bJzrLWWb55n4+wY4PLeila0lCxuCCoqnAa83AXsU7pTCzcaj5IZgBhATMrAV5N3u4r/Rak5XaTIIhKLcb5xLnkM3wkGUCpfv/I1Qhfbc397Su8dCH4/53zk/1gH95eIXn5s41WHdOPyULdEAblw+R5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/Le467p; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so327317866b.0;
        Fri, 11 Jul 2025 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752222326; x=1752827126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBtRVNrPDueYB7FTA+ViEznKwsHfcDITP+EI95uTzM8=;
        b=H/Le467pwLKk9feIzRO5RoaUdtxv7dA/UzjHYSERlLD6w/NAIy7sXyTU+yDDlfkgip
         7JEeDRrWqVyBxVe0wkjia9nL8vF+8B3OZ4OqT3CQ96noeXMDUKx6I4oMksHNUO1eMYKF
         4T9thxs0F1WOnTWbftfwUS3hBIum91UKLJvaU3zgFT8+//NBQw6SGT0LjFPSXIoEnDv1
         BAHO+1E+9bMpqfNrNByZ6NqZc1Dg1/WN6blAnpvDoKeLkKzq1unfmhl4LlxyjR80LmbU
         P7ant+X3JzokplwcVyqvJ2MnLidjSdL9Xdr5l9W7rPVBzJeXqvIFB32UU6MKSp0KTn9r
         s1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222326; x=1752827126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBtRVNrPDueYB7FTA+ViEznKwsHfcDITP+EI95uTzM8=;
        b=mehSSz3g2NyqB3Jpd2OVjV02xyFM52C+ao+T0coTxFBCT8CRxJwPoUyqsEqHNP9lw3
         pxmFAiHIfJEWI0gGoLUKlOY5U1+Dmck7iS7uY5pXgmGuuTqbFmwmqbx5pIXWtuMv7hQt
         u9cqKHthiQPnA1WovTmJownxieOkQrRZFXY0mefsfy5T2w9aUinz6dUuOhAf3ao+XyX7
         Ttzy8HDsk2p85qLoAlMDiiQ+XBbtw5Fmq3cPKizhC1Juzeb8DmA6TIK4DTQ+zkPV2gD0
         oVOjj7Mh6yjc2I7jGrLNaEvG77Ccqv6QStoIg65Ajg+l4LqR+IhkcZxtjVISKYilIv3L
         /CPg==
X-Forwarded-Encrypted: i=1; AJvYcCX1zdSkpQpmAlAoAQionaj41rQdBKZGrDS6y5xEVRBwPntQPacLpl6bLOkEYzqKJgeiR8d3u7fy26prOjTieA==@vger.kernel.org, AJvYcCXKWaGMc9PoWkctyxALoEGcJnkssx8QR1n9nIKxqpW9WAorkfXExFb61MVYivWERh/Yxvjnb9uJkY/23+yd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Rc+P6YZMub4GbIQFTHHDTia0uYvLcZQNrmA/wL+8CLyC49BU
	4c4jhss6GRc9c4JanWfqyb1Q+yOAg2MdRliQ22/eaYrBytvFJ098PaUdrOaoh9jLY+m1VYXL9Xh
	rYTV8nU7NFRzdcM1Vi7jssYqg8AyEE+k=
X-Gm-Gg: ASbGncsJ+aM9ZgPP7zyAraXV5o+7IY+G/kzmIfxPt4HAjmYqDuccHy1M8CVwPIjmwhn
	D8DXKpFJBpN3TPhkUg9h04AMUJELVE6bncCIIeN46VsEYXlHWQrfYsEA/WeQ2smrAlFJ2Oqzay1
	p1pTfOpb5cjoUuoZJJ/bkt3EaJMtMt8bzBt7BelNAuMFS6rgqF8l/pNZzVR1s4w2x6l8FdlopC4
	8mgEuk=
X-Google-Smtp-Source: AGHT+IE/LRf4+t/SZD7Zt/u3ni60wdO5lCzirxys+dE5Ijep9eifzIMxtWp4pbPl/N/aOeeiPph0fxq61glPz2cau9s=
X-Received: by 2002:a17:907:c1c:b0:add:fb01:c64a with SMTP id
 a640c23a62f3a-ae6fcac8546mr245511766b.43.1752222325168; Fri, 11 Jul 2025
 01:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-2-neil@brown.name>
In-Reply-To: <20250710232109.3014537-2-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 10:25:13 +0200
X-Gm-Features: Ac12FXxXagrTGe4cYfeV3GNTYj6Ki9MJWq-SJ0ylNBxoaXN5PEk4jI2doHZIy6o
Message-ID: <CAOQ4uxh6fb6GQcC0_mj=Ft5NbLco7Nb0brhn9d3f7LzMLkRYaw@mail.gmail.com>
Subject: Re: [PATCH 01/20] ovl: simplify an error path in ovl_copy_up_workdir()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> If ovl_copy_up_data() fails the error is not immediately handled but the
> code continues on to call ovl_start_write() and lock_rename(),
> presumably because both of these locks are needed for the cleanup.
> On then (if the lock was successful) is the error checked.
>
> This makes the code a little hard to follow and could be fragile.
>
> This patch changes to handle the error immediately.  A new
> ovl_cleanup_unlocked() is created which takes the required directory
> lock (though it doesn't take the write lock on the filesystem).  This
> will be used extensively in later patches.
>
> In general we need to check the parent is still correct after taking the
> lock (as ovl_copy_up_workdir() does after a successful lock_rename()) so
> that is included in ovl_cleanup_unlocked() using new lock_parent() and
> unlock_parent() calls (it is planned to move this API into VFS code
> eventually, though in a slightly different form).

Since you are not planning to move it to VFS with this name
AND since I assume you want to merge this ovl cleanup prior
to the rest of of patches, please use an ovl helper without
the ovl_ namespace prefix and you have a typo above
its parent_lock() not lock_parent().

And apropos lock helper names, at the tip of your branch
the lock helpers used in ovl_cleanup() are named:
lock_and_check_dentry()/dentry_unlock()

I have multiple comments on your choice of names for those helpers:
1. Please use a consistent name pattern for lock/unlock.
    The pattern <obj-or-lock-type>_{lock,unlock}_* is far more common
    then the pattern lock_<obj-or-lock-type> in the kernel, but at least
    be consistent with dentry_lock_and_check() or better yet
    parent_lock() and later parent_lock_get_child()
2. dentry_unlock() is a very strange name for a helper that
    unlocks the parent. The fact that you document what it does
    in Kernel-doc does not stop people reading the code using it
    from being confused and writing bugs.
3. Why not call it parnet_unlock() like I suggested and like you
    used in this patch set and why not introduce it in VFS to begin with?
    For that matter parent_unlock_{put,return}_child() is more clear IMO.
4. The name dentry_unlock_rename(&rd) also does not balance nicely with
    the name lookup_and_lock_rename(&rd) and has nothing to do with the
    dentry_ prefix. How about lookup_done_and_unlock_rename(&rd)?

Hope this is not too much complaining for review of a small cleanup patch :=
-p

>
> A fresh cleanup block is added which doesn't share code with other
> cleanup blocks.  It will get a new users in the next patch.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/copy_up.c   | 12 ++++++++++--
>  fs/overlayfs/dir.c       | 15 +++++++++++++++
>  fs/overlayfs/overlayfs.h |  6 ++++++
>  fs/overlayfs/util.c      | 10 ++++++++++
>  4 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 8a3c0d18ec2e..5d21b8d94a0a 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -794,6 +794,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>          */
>         path.dentry =3D temp;
>         err =3D ovl_copy_up_data(c, &path);
> +       if (err)
> +               goto cleanup_need_write;
> +
>         /*
>          * We cannot hold lock_rename() throughout this helper, because o=
f
>          * lock ordering with sb_writers, which shouldn't be held when ca=
lling
> @@ -809,8 +812,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
>                 if (IS_ERR(trap))
>                         goto out;
>                 goto unlock;
> -       } else if (err) {
> -               goto cleanup;
>         }
>
>         err =3D ovl_copy_up_metadata(c, temp);
> @@ -857,6 +858,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ct=
x *c)
>         ovl_cleanup(ofs, wdir, temp);
>         dput(temp);
>         goto unlock;
> +
> +cleanup_need_write:
> +       ovl_start_write(c->dentry);
> +       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> +       ovl_end_write(c->dentry);
> +       dput(temp);
> +       return err;
>  }
>

Sorry, I will not accept more messy goto routines.
I rewrote your simplification based on the tip of your branch.
Much simpler and no need for this extra routine.
Just always use ovl_cleanup_unlocked() in this function and
ovl_start_write() before goto cleanup_unlocked:

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -794,13 +794,16 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
         */
        path.dentry =3D temp;
        err =3D ovl_copy_up_data(c, &path);
+       ovl_start_write(c->dentry);
+       if (err)
+               goto cleanup_unlocked;
+
        /*
         * We cannot hold lock_rename() throughout this helper, because of
         * lock ordering with sb_writers, which shouldn't be held when call=
ing
         * ovl_copy_up_data(), so lock workdir and destdir and make sure th=
at
         * temp wasn't moved before copy up completion or cleanup.
         */
-       ovl_start_write(c->dentry);
        trap =3D lock_rename(c->workdir, c->destdir);
        if (trap || temp->d_parent !=3D c->workdir) {
                /* temp or workdir moved underneath us? abort without clean=
up */
@@ -809,8 +812,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *=
c)
                if (IS_ERR(trap))
                        goto out;
                goto unlock;
-       } else if (err) {
-               goto cleanup;
        }

        err =3D ovl_copy_up_metadata(c, temp);
@@ -846,17 +847,17 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx=
 *c)
        ovl_inode_update(inode, temp);
        if (S_ISDIR(inode->i_mode))
                ovl_set_flag(OVL_WHITEOUTS, inode);
-unlock:
-       unlock_rename(c->workdir, c->destdir);
 out:
        ovl_end_write(c->dentry);

        return err;

 cleanup:
-       ovl_cleanup(ofs, wdir, temp);
+       unlock_rename(c->workdir, c->destdir);
+cleanup_unlocked:
+       ovl_cleanup_unlocked(ofs, wdir, temp);
        dput(temp);
-       goto unlock;
+       goto out;
 }
---

>  /* Copyup using O_TMPFILE which does not require cross dir locking */
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 4fc221ea6480..cee35d69e0e6 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -43,6 +43,21 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir=
, struct dentry *wdentry)
>         return err;
>  }
>
> +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> +                        struct dentry *wdentry)
> +{
> +       int err;
> +
> +       err =3D parent_lock(workdir, wdentry);
> +       if (err)
> +               return err;
> +
> +       ovl_cleanup(ofs, workdir->d_inode, wdentry);
> +       parent_unlock(workdir);
> +
> +       return err;
> +}
> +
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
>  {
>         struct dentry *temp;
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 42228d10f6b9..68dc78c712a8 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -416,6 +416,11 @@ static inline bool ovl_open_flags_need_copy_up(int f=
lags)
>  }
>
>  /* util.c */
> +int parent_lock(struct dentry *parent, struct dentry *child);
> +static inline void parent_unlock(struct dentry *parent)
> +{
> +       inode_unlock(parent->d_inode);
> +}

ovl_parent_unlock() or move to vfs please.

>  int ovl_get_write_access(struct dentry *dentry);
>  void ovl_put_write_access(struct dentry *dentry);
>  void ovl_start_write(struct dentry *dentry);
> @@ -843,6 +848,7 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs,
>                                struct inode *dir, struct dentry *newdentr=
y,
>                                struct ovl_cattr *attr);
>  int ovl_cleanup(struct ovl_fs *ofs, struct inode *dir, struct dentry *de=
ntry);
> +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir, str=
uct dentry *dentry);
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r);
>  struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdi=
r,
>                                struct ovl_cattr *attr);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 2b4754c645ee..a5105d68f6b4 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1544,3 +1544,13 @@ void ovl_copyattr(struct inode *inode)
>         i_size_write(inode, i_size_read(realinode));
>         spin_unlock(&inode->i_lock);
>  }
> +
> +int parent_lock(struct dentry *parent, struct dentry *child)
> +{
> +       inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
> +       if (!child || child->d_parent =3D=3D parent)
> +               return 0;
> +
> +       inode_unlock(parent->d_inode);
> +       return -EINVAL;
> +}

ovl_parent_lock() or move to vfs please.

Thanks,
Amir.

