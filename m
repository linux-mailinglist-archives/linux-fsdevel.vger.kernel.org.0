Return-Path: <linux-fsdevel+bounces-54610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A1B018EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7276B5C0D96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6E27EC76;
	Fri, 11 Jul 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUNqKgfM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7527CB06;
	Fri, 11 Jul 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227861; cv=none; b=N5i5bl0TpaV7lKuxMxt6lpa8SQNKSA13dL0vJUFRgkoQojQxCsPqrx+4LvRICXAVPi0j0wBPBOFnIDznrHjyYzYc1I3L8DErpKMqpg5Rs5DRRJw4GOMtjP6hE/pmuhkwObniO6W2Di96ATxKQRMOTndTe2s1uucHkXe5AAtgxNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227861; c=relaxed/simple;
	bh=++CtauXKJHWrUeF7POMYKuTma+f2RfJ3W6lanIiH5/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXaaiNOHRaDK6AeftapA1MfoaP1me9seM7geo7ZFxfyDgvkpNx1K+o59+LkScbLhtSTHhxEjDm/wog6dHktlpKlJ67zszbHXtOsARx7JV90vGProk/df8+DqLcw0wh8w/IIr4WQbjk++bhcvjiASSCg5dj5BGSu3PH/xiiuhke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUNqKgfM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso3541956a12.0;
        Fri, 11 Jul 2025 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752227858; x=1752832658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJPntwySAiel8+L4mYO8uFmxRV+frgBxg8/toynT7gc=;
        b=EUNqKgfM3+Rh93MS/xgBQyqs+ivU1oLJfOUbs4R9VZHYOFhejzI1Dfekr/SxoPbaot
         3WRCm4ab7ttQOJrMiCDkkqtaJ1lCCwEC4+K6bc4oW8GUItcewkqiQdjGs/AD4awh+lm/
         3DEwbsCcFAqCAthYOlvyq4SNXiePlCccu3Bvur2WbJkbrT/HC0G3P0gRCnqOlr8SM1wi
         wuyXoSdOm3EelHCEDrtnOMRhPubiTR62x/lDTN2de0jyx7MSN4o5bfWBs0myTpJqd5PK
         hNtgFcEalcoW11uDvY7lhnAMPpdb4cBAkHt/x8lorA5Y6Nku7klCrXCLIPRJx9wbI+MY
         CcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227858; x=1752832658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJPntwySAiel8+L4mYO8uFmxRV+frgBxg8/toynT7gc=;
        b=wBF5EhHfngJHQencIM2F5VagjoHBtX4kg4MWxfFwANNPfwTZrEnBpx/oM1ASZroua5
         hlA0suXYfE6YHigkLl3WC3CiTcRbCpeKboxw2co3xZnHaCutWmLzmyqFT8LlYquQbmdJ
         m5C2ngjl9uEKe77+wdoY7jo1CyPgFeEnbeb419VyjCM5hEnaEM5kC5/z8GI3wzC5itiZ
         Re+N1HKqS06G2zzVPEGlJSY3fI39qvsioTWgvBY74imm7m49llrNA5T1MqdPGfMDE7wx
         ISaPrmgHXibX/TdmXAzFFUM4YYLHu2fNq8FPQ36TOXTH1BNJ7qTnD2+aHutRpjPRDqPr
         3YJg==
X-Forwarded-Encrypted: i=1; AJvYcCWKYC5jFc167bC0nMs4toiEB7JsGJHwB8Cgq+Z/XkhzhKi4t4eLBXrEq9alIP9PYl7HS/XBoaacS3WAt516aA==@vger.kernel.org, AJvYcCWaE9WDECa3xjEYSIgYacmWDcHPdkYZcBwstIHbZd/sH/mqZ4UFE59OnQl5YU4k5B+xWQwAnilT2pzV9/61@vger.kernel.org
X-Gm-Message-State: AOJu0YxMEBHQnRB4+djKIHIHGS8feT3xvqBGLTImV4T4vteDglJxvzq6
	+nyPKbR1zMyCKepOZsuxoV7hbItDgImFkYwRbUUpyrYpfRkSsmW9k3Sqz35CRB8nM3UA4ZwfYWP
	wdBaxirIy3ptuBAs6XICN8RN2ViAoy2o=
X-Gm-Gg: ASbGncuS7nJSTZ82ww1ZCSvEm3HWfhxFdBRPHhTNq0VPyamnVujhect2+lWmyMaNPB7
	ZDRaCvhpvrrlUVXOIUnUwx2BGPpfq/uPYB1/Tlx8iWnuV5sUK83uAeyZpc9ZfKaVJ4z7lcmfQS0
	wMd7mCrYS4x7HdAq118Q9zV/9hQm5NP+BBr7bbaSX9lyZpDPeJoRLRvCZBU6iAcNbBM6+WEHMQs
	zAzvGmAkwk/nuHvWA==
X-Google-Smtp-Source: AGHT+IFQnrbpOFYegCic6m1jl6t7Z+6C4ab2HoFpjmvznttuPDy69rSCAlXFTeT7xvo2bq24XAZ8nlASK75OJhmDeaM=
X-Received: by 2002:a17:907:cd07:b0:ae3:64ec:5eb0 with SMTP id
 a640c23a62f3a-ae6fbc55069mr263493166b.11.1752227857325; Fri, 11 Jul 2025
 02:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710232109.3014537-1-neil@brown.name> <20250710232109.3014537-21-neil@brown.name>
In-Reply-To: <20250710232109.3014537-21-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 11:57:26 +0200
X-Gm-Features: Ac12FXz9SeyKvncrE3PYSHtNU7yyePbg_V5cr2DZZ_6ngnnE9_bwBvIsOLFwC-E
Message-ID: <CAOQ4uxg65W0ot9Pp9BZJfmgX2O2QpY1V1Dq_bkWwdgr2qAUftA@mail.gmail.com>
Subject: Re: [PATCH 20/20] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Don't worry I did not work through the entire patch set.
I 'm just reviewing the easy one as a snack when I am tired/hungry ;)

On Fri, Jul 11, 2025 at 1:21=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> The only remaining user of ovl_cleanup() is ovl_cleanup_locked(), so we

You meant ovl_cleanup_unlocked()

> no longer need both.
>
> This patch moves ovl_cleanup() code into ovl_cleanup_locked(), and then
> renames ovl_cleanup_locked() to ovl_cleanup().

I know I wrote in v1 review that it may be ok to combine the helpers,
but looking at this patch I think I prefer to keep it a rename only

ovl_cleanup() =3D> ovl_cleanup_locked()
ovl_cleanup_unlocked() =3D> ovl_cleanup()

You can either leave ovl_cleanup_locked() exported or make it static
I am fine with either way.

Thanks,
Amir.

>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/overlayfs/copy_up.c   |  6 ++---
>  fs/overlayfs/dir.c       | 52 ++++++++++++++++------------------------
>  fs/overlayfs/overlayfs.h |  3 +--
>  fs/overlayfs/readdir.c   | 10 ++++----
>  fs/overlayfs/super.c     |  4 ++--
>  fs/overlayfs/util.c      |  2 +-
>  6 files changed, 33 insertions(+), 44 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 7b84a39c081f..f345f2899ccf 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -570,7 +570,7 @@ static int ovl_create_index(struct dentry *dentry, co=
nst struct ovl_fh *fh,
>         parent_unlock(indexdir);
>  out:
>         if (err)
> -               ovl_cleanup_unlocked(ofs, indexdir, temp);
> +               ovl_cleanup(ofs, indexdir, temp);
>         ovl_end_write(dentry);
>         dput(temp);
>  free_name:
> @@ -856,13 +856,13 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_c=
tx *c)
>  cleanup:
>         unlock_rename(c->workdir, c->destdir);
>  cleanup_unlocked:
> -       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> +       ovl_cleanup(ofs, c->workdir, temp);
>         dput(temp);
>         goto out;
>
>  cleanup_need_write:
>         ovl_start_write(c->dentry);
> -       ovl_cleanup_unlocked(ofs, c->workdir, temp);
> +       ovl_cleanup(ofs, c->workdir, temp);
>         ovl_end_write(c->dentry);
>         dput(temp);
>         return err;
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 58078ce67d6a..7e7f701c7ae4 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -24,16 +24,21 @@ MODULE_PARM_DESC(redirect_max,
>
>  static int ovl_set_redirect(struct dentry *dentry, bool samedir);
>
> -int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *w=
dentry)
> +int ovl_cleanup(struct ovl_fs *ofs, struct dentry *workdir,
> +                        struct dentry *wdentry)
>  {
>         int err;
>
> -       dget(wdentry);
> -       if (d_is_dir(wdentry))
> -               err =3D ovl_do_rmdir(ofs, wdir, wdentry);
> -       else
> -               err =3D ovl_do_unlink(ofs, wdir, wdentry);
> -       dput(wdentry);
> +       err =3D parent_lock(workdir, wdentry);
> +       if (!err) {
> +               dget(wdentry);
> +               if (d_is_dir(wdentry))
> +                       err =3D ovl_do_rmdir(ofs, workdir->d_inode, wdent=
ry);
> +               else
> +                       err =3D ovl_do_unlink(ofs, workdir->d_inode, wden=
try);
> +               dput(wdentry);
> +               parent_unlock(workdir);
> +       }
>
>         if (err) {
>                 pr_err("cleanup of '%pd2' failed (%i)\n",
> @@ -43,21 +48,6 @@ int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir=
, struct dentry *wdentry)
>         return err;
>  }
>
> -int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> -                        struct dentry *wdentry)
> -{
> -       int err;
> -
> -       err =3D parent_lock(workdir, wdentry);
> -       if (err)
> -               return err;
> -
> -       ovl_cleanup(ofs, workdir->d_inode, wdentry);
> -       parent_unlock(workdir);
> -
> -       return err;
> -}
> -
>  struct dentry *ovl_lookup_temp(struct ovl_fs *ofs, struct dentry *workdi=
r)
>  {
>         struct dentry *temp;
> @@ -148,14 +138,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, st=
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
> @@ -350,7 +340,7 @@ static int ovl_create_upper(struct dentry *dentry, st=
ruct inode *inode,
>         return 0;
>
>  out_cleanup:
> -       ovl_cleanup_unlocked(ofs, upperdir, newdentry);
> +       ovl_cleanup(ofs, upperdir, newdentry);
>         dput(newdentry);
>         return err;
>  }
> @@ -409,7 +399,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>         unlock_rename(workdir, upperdir);
>
>         ovl_cleanup_whiteouts(ofs, upper, list);
> -       ovl_cleanup_unlocked(ofs, workdir, upper);
> +       ovl_cleanup(ofs, workdir, upper);
>
>         /* dentry's upper doesn't match now, get rid of it */
>         d_drop(dentry);
> @@ -419,7 +409,7 @@ static struct dentry *ovl_clear_empty(struct dentry *=
dentry,
>  out_cleanup:
>         unlock_rename(workdir, upperdir);
>  out_cleanup_unlocked:
> -       ovl_cleanup_unlocked(ofs, workdir, opaquedir);
> +       ovl_cleanup(ofs, workdir, opaquedir);
>         dput(opaquedir);
>  out:
>         return ERR_PTR(err);
> @@ -514,7 +504,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>                 if (err)
>                         goto out_cleanup;
>
> -               ovl_cleanup_unlocked(ofs, workdir, upper);
> +               ovl_cleanup(ofs, workdir, upper);
>         } else {
>                 err =3D ovl_do_rename(ofs, workdir, newdentry, upperdir, =
upper, 0);
>                 unlock_rename(workdir, upperdir);
> @@ -524,7 +514,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
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
> @@ -539,7 +529,7 @@ static int ovl_create_over_whiteout(struct dentry *de=
ntry, struct inode *inode,
>  out_cleanup_locked:
>         unlock_rename(workdir, upperdir);
>  out_cleanup:
> -       ovl_cleanup_unlocked(ofs, workdir, newdentry);
> +       ovl_cleanup(ofs, workdir, newdentry);
>         dput(newdentry);
>         goto out_dput;
>  }
> @@ -1266,7 +1256,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>         unlock_rename(new_upperdir, old_upperdir);
>
>         if (cleanup_whiteout)
> -               ovl_cleanup_unlocked(ofs, old_upperdir, newdentry);
> +               ovl_cleanup(ofs, old_upperdir, newdentry);
>
>         if (overwrite && d_inode(new)) {
>                 if (new_is_dir)
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index bda25287c510..1bebfdcd4d90 100644
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
> index 4127d1f160b3..5a05842c60c5 100644
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
>         err =3D parent_lock(parent, dentry);
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
> index 3c012c8f7c88..e3dd60c459e2 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -603,11 +603,11 @@ static int ovl_check_rename_whiteout(struct ovl_fs =
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
> index 5218a477551b..c91c3a9187b0 100644
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

