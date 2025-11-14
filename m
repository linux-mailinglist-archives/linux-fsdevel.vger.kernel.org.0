Return-Path: <linux-fsdevel+bounces-68471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB05C5CE60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E534DF93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F94314A95;
	Fri, 14 Nov 2025 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb1SQ2kU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D18313294
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763120462; cv=none; b=KYRjeBVdD4N1RZgCrfZOYKyOenWBSb9PyW1ZFs863Sl78IJ2LFsav+VcNKtuhkDLSFh8m3EVqGxXh8CXs2ghOnNgo997HyltMqXUga+rR5iukYDi95Rn5lCrfHVZgUuQgPqTfcebmhRW9gcY/oY/bm5APD1dds5d9/IxtmaWpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763120462; c=relaxed/simple;
	bh=1oOVxW9E1tiKTn/6IWaX0aOxtjFOX7jpbXxx7pcOB7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiLQc0pwjyBH9QbPTFgZvVYsezNYYOAGCnTEUDxl7ehWUskhogpV2hUn1LMrG5ADpEeOuzThzN/B7AeydLt9TxmWgshSv3ufDKffO3PNlfTol91VEZSefunZWvNtsScFYolknQ46sLzcaoud+puDhBgQE8uIhrBlMa+YM3wputQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb1SQ2kU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3169857a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 03:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763120458; x=1763725258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5oJbCCfMjKZTBM19Ms4JBV8hzYnz4qzAWkgC6tGXMU=;
        b=lb1SQ2kUB9/S5khd5B3ahF86BSuNfP60HMjkXkpKU+OInaHeQv//DjPSk4LS5jbhvz
         a4GfOf/X0+vc9+vZ5KP6VgBLi1OaF6D5zWJoWl8kx8ZdxHEoUkSOg29yGvDXAoB+qDZf
         /EA1lY/YNvfRGYa9OKSTJo7yGZue6EZ7hyZQf6mh37mCv1TPkyBscq2egdSMuizm4BmZ
         moxQlT8eWeFLgU5H0Ua0P/6QUIm2i+5DecrmyMV+yvShUYV/HUvq49uYFbyYIWUU6xLn
         6Gp4+fi3cwxdt0HgroRbwnW/ooUgi1L2DQzWm6SQUBo07XWlrrPGAU0xpQ9H7tgYQS6U
         y5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763120458; x=1763725258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5oJbCCfMjKZTBM19Ms4JBV8hzYnz4qzAWkgC6tGXMU=;
        b=Ymz2rI3NHKVlwn4FfHgadyPfV4mF0dum2X/yQEvbJ7SVEVhDycQOuoFEEe70Z6X8S7
         yWUkRORYuQT84p/6y2uUQikgg9o1j0BQ0CFlvktNGr5IlJk4Q0Rtas84dFyqN5Lf48fy
         bkt2qFp6aBirI+vU1l/OEdFZvH5eAyBUxhU4rWLovrSdpdD89jyiS/BajZIor+potqDS
         Er7CH3krfUiTwmbmjFS95Z5rETrO7qihZ5m1wHzrjFRSP+iNOd6xxLQ6Ou7k2uAjSrfV
         HB0djttabZM860iKn/pn4duRlKZleeTK6FEhy17oFQkrC6TVwmVRs1tZVxMrDkzGWLpU
         k24Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOlYMhMjalBhT7dmU+8gIv+2xvL9cISCgWlm729xqeFyiygXLjuihop5AUodYVQkgWNuvF0W/QyDyg4GWQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyAaH4NiFF8lo+bwaZ7Jw5T3C2JlwyB2s/xx9jIXildH5e3QiQk
	1PBzKrmzQ6EA4Go3/Mwuc2eRkm/K6xyhBz8CzNUDek0P0cwXMhXJLGa2vebq9YwyEo4PEPNQKJq
	UFyByw+QnFtavFjE0d9YUfSlmVLtva8nx+PJhlPdDnA==
X-Gm-Gg: ASbGncsFDo/zzoIat19jCtYk/iseUxAa+prmaShoomxkmg9DSPNfT0gR59YT/JWHGxR
	zn8Q7CdGkFZi8Eyqwb+z1sZwWhddU5/3R1CWcCDt9a0lpd7f3/4Hccm9Km6m5fqJa2rWUyCjXPh
	wPOmvo/GeNFH4+ey9t0fm2LkGe58uV7c2dOs/zbl/Cg210RvswUIN5Su54R52rCx2ssj4rHOKuA
	Hy9q1tfq6UxGlRD5rCVcLA570m3CBT8Sq4nzK/XKdeJlBSsDIydRB2IRF4dKY0sacQ6EC4E8lib
	aj6EKQPyhh/Xajb1BuHLGse38OHT6w==
X-Google-Smtp-Source: AGHT+IFCUX+g4UhvxSRaKEbX8Hqx/rv343OKMl8lUiRejGtQdQsfKUQsIZV/CdM1Mz1hWzGJEWfv4c4G7+xvH5u/2Do=
X-Received: by 2002:a05:6402:13cb:b0:640:bc0b:887d with SMTP id
 4fb4d7f45d1cf-64350e00abdmr2334062a12.2.1763120458231; Fri, 14 Nov 2025
 03:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-40-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-40-b35ec983efc1@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 12:40:46 +0100
X-Gm-Features: AWmQ_bkOpOm5Nz9thMjahRZdsG2whDHw0P6RjfOIgGaDWmcM0O9fH2oEaHxrrDg
Message-ID: <CAOQ4uxi43BPTsdxScnpT2vHJHo1npgnF4FD8hJSPsbOQBn=qVg@mail.gmail.com>
Subject: Re: [PATCH v3 40/42] ovl: refactor ovl_fill_super()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:33=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Split the core into a separate helper in preparation of converting the
> caller to the scoped ovl cred guard.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 91 +++++++++++++++++++++++++++-------------------=
------
>  1 file changed, 48 insertions(+), 43 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 43ee4c7296a7..e3781fccaef8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1369,53 +1369,35 @@ static void ovl_set_d_op(struct super_block *sb)
>         set_default_d_op(sb, &ovl_dentry_operations);
>  }
>
> -int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> +static int do_ovl_fill_super(struct fs_context *fc, struct super_block *=
sb)
>  {
>         struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct cred *creator_cred =3D (struct cred *)ofs->creator_cred;
>         struct ovl_fs_context *ctx =3D fc->fs_private;
> -       const struct cred *old_cred =3D NULL;
> -       struct dentry *root_dentry;
> -       struct ovl_entry *oe;
>         struct ovl_layer *layers;
> -       struct cred *cred;
> +       struct ovl_entry *oe =3D NULL;
>         int err;
>
> -       err =3D -EIO;
> -       if (WARN_ON(fc->user_ns !=3D current_user_ns()))
> -               goto out_err;
> -
> -       ovl_set_d_op(sb);
> -
> -       err =3D -ENOMEM;
> -       if (!ofs->creator_cred)
> -               ofs->creator_cred =3D cred =3D prepare_creds();
> -       else
> -               cred =3D (struct cred *)ofs->creator_cred;
> -       if (!cred)
> -               goto out_err;
> -
> -       old_cred =3D ovl_override_creds(sb);
> -
>         err =3D ovl_fs_params_verify(ctx, &ofs->config);
>         if (err)
> -               goto out_err;
> +               return err;
>
>         err =3D -EINVAL;
>         if (ctx->nr =3D=3D 0) {
>                 if (!(fc->sb_flags & SB_SILENT))
>                         pr_err("missing 'lowerdir'\n");
> -               goto out_err;
> +               return err;
>         }
>
>         err =3D -ENOMEM;
>         layers =3D kcalloc(ctx->nr + 1, sizeof(struct ovl_layer), GFP_KER=
NEL);
>         if (!layers)
> -               goto out_err;
> +               return err;
>
>         ofs->config.lowerdirs =3D kcalloc(ctx->nr + 1, sizeof(char *), GF=
P_KERNEL);
>         if (!ofs->config.lowerdirs) {
>                 kfree(layers);
> -               goto out_err;
> +               return err;
>         }
>         ofs->layers =3D layers;
>         /*
> @@ -1448,12 +1430,12 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>                 err =3D -EINVAL;
>                 if (!ofs->config.workdir) {
>                         pr_err("missing 'workdir'\n");
> -                       goto out_err;
> +                       return err;
>                 }
>
>                 err =3D ovl_get_upper(sb, ofs, &layers[0], &ctx->upper);
>                 if (err)
> -                       goto out_err;
> +                       return err;
>
>                 upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
>                 if (!ovl_should_sync(ofs)) {
> @@ -1461,13 +1443,13 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>                         if (errseq_check(&upper_sb->s_wb_err, ofs->errseq=
)) {
>                                 err =3D -EIO;
>                                 pr_err("Cannot mount volatile when upperd=
ir has an unseen error. Sync upperdir fs to clear state.\n");
> -                               goto out_err;
> +                               return err;
>                         }
>                 }
>
>                 err =3D ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work)=
;
>                 if (err)
> -                       goto out_err;
> +                       return err;
>
>                 if (!ofs->workdir)
>                         sb->s_flags |=3D SB_RDONLY;
> @@ -1478,7 +1460,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>         oe =3D ovl_get_lowerstack(sb, ctx, ofs, layers);
>         err =3D PTR_ERR(oe);
>         if (IS_ERR(oe))
> -               goto out_err;
> +               return err;
>
>         /* If the upper fs is nonexistent, we mark overlayfs r/o too */
>         if (!ovl_upper_mnt(ofs))
> @@ -1531,7 +1513,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>                 sb->s_export_op =3D &ovl_export_fid_operations;
>
>         /* Never override disk quota limits or use reserved space */
> -       cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
> +       cap_lower(creator_cred->cap_effective, CAP_SYS_RESOURCE);
>
>         sb->s_magic =3D OVERLAYFS_SUPER_MAGIC;
>         sb->s_xattr =3D ovl_xattr_handlers(ofs);
> @@ -1549,27 +1531,50 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>         sb->s_iflags |=3D SB_I_EVM_HMAC_UNSUPPORTED;
>
>         err =3D -ENOMEM;
> -       root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);
> -       if (!root_dentry)
> +       sb->s_root =3D ovl_get_root(sb, ctx->upper.dentry, oe);
> +       if (!sb->s_root)
>                 goto out_free_oe;
>
> -       sb->s_root =3D root_dentry;
> -
> -       ovl_revert_creds(old_cred);
>         return 0;
>
>  out_free_oe:
>         ovl_free_entry(oe);
> -out_err:
> -       /*
> -        * Revert creds before calling ovl_free_fs() which will call
> -        * put_cred() and put_cred() requires that the cred's that are
> -        * put are not the caller's creds, i.e., current->cred.
> -        */
> -       if (old_cred)
> +       return err;
> +}
> +
> +int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       const struct cred *old_cred =3D NULL;
> +       struct cred *cred;
> +       int err;
> +
> +       err =3D -EIO;
> +       if (WARN_ON(fc->user_ns !=3D current_user_ns()))
> +               goto out_err;
> +
> +       ovl_set_d_op(sb);
> +
> +       err =3D -ENOMEM;
> +       if (!ofs->creator_cred)
> +               ofs->creator_cred =3D cred =3D prepare_creds();
> +       else
> +               cred =3D (struct cred *)ofs->creator_cred;
> +       if (!cred)
> +               goto out_err;
> +
> +       old_cred =3D ovl_override_creds(sb);
> +
> +       err =3D do_ovl_fill_super(fc, sb);
> +
>         ovl_revert_creds(old_cred);
> +
> +out_err:
> +       if (err) {
>                 ovl_free_fs(ofs);
>                 sb->s_fs_info =3D NULL;
> +       }
> +
>         return err;
>  }
>
>
> --
> 2.47.3
>

Considering Miklos' complaint about do_ovl_ helpers, how about:

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1369,10 +1369,10 @@ static void ovl_set_d_op(struct super_block *sb)
        set_default_d_op(sb, &ovl_dentry_operations);
 }

-static int do_ovl_fill_super(struct fs_context *fc, struct super_block *sb=
)
+static int ovl_fill_super_cred(struct fs_context *fc, struct super_block *=
sb,
+                              struct cred *creator_cred)
 {
        struct ovl_fs *ofs =3D sb->s_fs_info;
-       struct cred *creator_cred =3D (struct cred *)ofs->creator_cred;
        struct ovl_fs_context *ctx =3D fc->fs_private;
        struct ovl_layer *layers;
        struct ovl_entry *oe =3D NULL;
@@ -1545,6 +1545,7 @@ static int do_ovl_fill_super(struct fs_context
*fc, struct super_block *sb)
 int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
        struct ovl_fs *ofs =3D sb->s_fs_info;
+       struct cred *cred =3D (struct cred *)ofs->creator_cred;
        int err;

        err =3D -EIO;
@@ -1555,13 +1556,13 @@ int ovl_fill_super(struct super_block *sb,
struct fs_context *fc)

        if (!ofs->creator_cred) {
                err =3D -ENOMEM;
-               ofs->creator_cred =3D prepare_creds();
-               if (!ofs->creator_cred)
+               ofs->creator_cred =3D cred =3D prepare_creds();
+               if (!cred)
                        goto out_err;
        }

        with_ovl_creds(sb)
-               err =3D do_ovl_fill_super(fc, sb);
+               err =3D ovl_fill_super_cred(fc, sb, cred);

---

Which is also a bit more explicit about the fact that the helper
is modifying the creator_cred.

Thanks,
Amir.

