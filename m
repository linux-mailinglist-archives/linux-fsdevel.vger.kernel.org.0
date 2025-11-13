Return-Path: <linux-fsdevel+bounces-68280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF919C57FE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 208734EA4D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EAB2C21C6;
	Thu, 13 Nov 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPkOhLmw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1922173F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044353; cv=none; b=o0stOMkyWYl3NY95admuH2JCi1G8V0KnQWMQ3+PU0jkfgJCnEkHWyPEV9NKu6kX4GuVq6Umt9v2wpV+2RFcOrpbw2vCwIe446pegkPJiIq1Ub3uKwpwNjU5/cUq1EHWD9NHA9de+OEDhBRdq5YaBLsnXcvNVKg02BHNoxL8TsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044353; c=relaxed/simple;
	bh=ZZnbd6cARc7lJ3ZZQoH0a/1iFflrGZXppeP7jpapmns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfaA0OnLSaHo6aEbNdMDUlZ4l9Wf8jL4XHn6aU2+xxauZrMK6zx1Tr6/Cm7buiU3i0Lf9+AIWjTXQqs5TBTmmdNmmdVr7hecL0EOyG3wWMP9YVyFb+r314o7B0RYGYwouYqgWPplEFWtGZbWZLypbGF2ljwFMzbjvYD5gWULgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPkOhLmw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso1620367a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763044350; x=1763649150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAhF2eLpYaOqCK6MlvD+fQR519G4iUM7+64EMGSN770=;
        b=PPkOhLmwjKqB+/tOh6LEL28PQEZfgnU7B7e6TXYlNUC2LaO6kalb6ElunW1ldPtRBE
         mgOiSE4cUy2WVbwT97dvUSSTNFOwGFux3cU8lU7YUoI9+cO8v7mn3QnjsZ1Z6AyZQ2Tr
         rADP/i92CfjQEKAv1p41yMSEMLqp/j3O9cz5B3AK+uNOr+MZFL3R/QtmGOwiacOQVX3T
         KwzfDch2yNSGier3ncMzeg9Dz/dhz5LokgxxVcr0EHShr8yv7+lhrCESiRPiBMqsce77
         AWhJGeqUo8cb8uepJ8OCDvzy53Gn+bhD3ExsDeG+QvpdplVPaR+HFx2oK/8Kj4Z9kfmI
         6hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044350; x=1763649150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAhF2eLpYaOqCK6MlvD+fQR519G4iUM7+64EMGSN770=;
        b=O44SWxRbrE+WK6+K63FOajVbGImFyWSjJ+Y9q8p1j5i8ztX9kCQXgV6A5JPqzI6gqu
         G0XHqQLj0AF5FRWmRwL/v24SmqlHuCfjgl54cU7W9wLsi2jX+x2/dots/AS9hmFgfCRb
         eR8FLNvo1rZl3FBBy26GeTgxNyn3b0Ky/QaQzpUC4DcDfPCFHwrpmSs7jj7hw6ZvHlo4
         1HQnD7XDVNzzB8lZEJG2PmBxyYQwJYs36vCXlVpnxWlnoRGQddjNGBrwlrHaHPKGtTEh
         Z2Ypqv1p2scWqmAL6vLegMLPRqGK+abJbkO/9VN6eXhO9fmkW8J0YZiEy9elufnHWwUd
         i1fw==
X-Forwarded-Encrypted: i=1; AJvYcCWPUZgof7BrAO18MvYl4UCwfyvYOYjMnroq0KqqAJdHUmBr84lRMaF0ed4YJ2f1qWzYRohPVOA5Fwjgc3W0@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2i6HWWSsbV9NAN3umu7F+ZEC/yxM+hpwzk2JbZZHthtvLHea
	yEonzE99PdTUbIcLcAp8xfFZqgTiaWvfEZqmonXc27T1HICf2mixP8WwBTWTHIe0db5eT37g//U
	ikt7ptOuiDC/k6kJZ3b60qyLiAIOi4V4=
X-Gm-Gg: ASbGncvbgE6NJz9XGyMonv4UIiMK+8xje3kYoEoxIhOav34vwyK71DEFyMH220Q6uRd
	JGX1/g1/kLnDbNVY/nyaY2eazSNVwJBthUdIw/CgY3mfmPWBIcAY0WRkazXBU2sZ7+MSUGyr2cn
	sAS1ba2yhlQCUGqd/EYyJ7M2wsLfOyYBcrbG1dkIdPpguNxfZLyG4nkgXyOsAH1RlTAEk+4y+n1
	IjmqCFQyujNcrKjc0fgz4NWL2lFVcLG2dH9ygJUxXlothEUBfN+O4h28WwijG5IuUTUvvqug6Do
	9fAqABGPtZ3KtVkJs6iRMQFAGqJ6YA==
X-Google-Smtp-Source: AGHT+IFXsOMq+ykAMuJK0RKIKvf0nWh6eYiMvOjokhjbelwJJ960E7erdD9Yr892dWXuq/ivOzzUON0nL9zUAbv5XGs=
X-Received: by 2002:a05:6402:35cd:b0:640:a356:e796 with SMTP id
 4fb4d7f45d1cf-6431a4968c4mr6632708a12.5.1763044349794; Thu, 13 Nov 2025
 06:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org> <20251113-work-ovl-cred-guard-v1-40-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-40-fa9887f17061@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Nov 2025 15:32:16 +0100
X-Gm-Features: AWmQ_bn3A1WKNVs-XY7d6boIEU4fKnSj2ka-7SOW677GYJcVTqk82kj0XCcIDok
Message-ID: <CAOQ4uxjwg2Nx=J8UtKCkGddq4TE0ix4BdTNVPLZ8-EDmB9vW9w@mail.gmail.com>
Subject: Re: [PATCH RFC 40/42] ovl: refactor ovl_fill_super()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:03=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Split the core into a separate helper in preparation of converting the
> caller to the scoped ovl cred guard.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 119 +++++++++++++++++++++++++++------------------=
------
>  1 file changed, 62 insertions(+), 57 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 43ee4c7296a7..6876406c120a 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1369,53 +1369,35 @@ static void ovl_set_d_op(struct super_block *sb)
>         set_default_d_op(sb, &ovl_dentry_operations);
>  }
>
> -int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> +static int do_ovl_fill_super(struct super_block *sb, struct ovl_fs *ofs,
> +                             struct fs_context *fc)
>  {
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> -       struct ovl_fs_context *ctx =3D fc->fs_private;
> -       const struct cred *old_cred =3D NULL;
> -       struct dentry *root_dentry;
> -       struct ovl_entry *oe;
> +       struct ovl_fs_context *fsctx =3D fc->fs_private;
>         struct ovl_layer *layers;
> -       struct cred *cred;
> +       struct ovl_entry *oe =3D NULL;
> +       struct cred *cred =3D (struct cred *)ofs->creator_cred;
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
> -       err =3D ovl_fs_params_verify(ctx, &ofs->config);
> +       err =3D ovl_fs_params_verify(fsctx, &ofs->config);

The rename of ctx var seems like unneeded churn.
Am I missing something?

Thanks,
Amir.

>         if (err)
> -               goto out_err;
> +               return err;
>
>         err =3D -EINVAL;
> -       if (ctx->nr =3D=3D 0) {
> +       if (fsctx->nr =3D=3D 0) {
>                 if (!(fc->sb_flags & SB_SILENT))
>                         pr_err("missing 'lowerdir'\n");
> -               goto out_err;
> +               return err;
>         }
>
>         err =3D -ENOMEM;
> -       layers =3D kcalloc(ctx->nr + 1, sizeof(struct ovl_layer), GFP_KER=
NEL);
> +       layers =3D kcalloc(fsctx->nr + 1, sizeof(struct ovl_layer), GFP_K=
ERNEL);
>         if (!layers)
> -               goto out_err;
> +               return err;
>
> -       ofs->config.lowerdirs =3D kcalloc(ctx->nr + 1, sizeof(char *), GF=
P_KERNEL);
> +       ofs->config.lowerdirs =3D kcalloc(fsctx->nr + 1, sizeof(char *), =
GFP_KERNEL);
>         if (!ofs->config.lowerdirs) {
>                 kfree(layers);
> -               goto out_err;
> +               return err;
>         }
>         ofs->layers =3D layers;
>         /*
> @@ -1423,8 +1405,8 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>          * config.lowerdirs[0] is used for storing the user provided colo=
n
>          * separated lowerdir string.
>          */
> -       ofs->config.lowerdirs[0] =3D ctx->lowerdir_all;
> -       ctx->lowerdir_all =3D NULL;
> +       ofs->config.lowerdirs[0] =3D fsctx->lowerdir_all;
> +       fsctx->lowerdir_all =3D NULL;
>         ofs->numlayer =3D 1;
>
>         sb->s_stack_depth =3D 0;
> @@ -1448,12 +1430,12 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>                 err =3D -EINVAL;
>                 if (!ofs->config.workdir) {
>                         pr_err("missing 'workdir'\n");
> -                       goto out_err;
> +                       return err;
>                 }
>
> -               err =3D ovl_get_upper(sb, ofs, &layers[0], &ctx->upper);
> +               err =3D ovl_get_upper(sb, ofs, &layers[0], &fsctx->upper)=
;
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
> -               err =3D ovl_get_workdir(sb, ofs, &ctx->upper, &ctx->work)=
;
> +               err =3D ovl_get_workdir(sb, ofs, &fsctx->upper, &fsctx->w=
ork);
>                 if (err)
> -                       goto out_err;
> +                       return err;
>
>                 if (!ofs->workdir)
>                         sb->s_flags |=3D SB_RDONLY;
> @@ -1475,10 +1457,10 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>                 sb->s_stack_depth =3D upper_sb->s_stack_depth;
>                 sb->s_time_gran =3D upper_sb->s_time_gran;
>         }
> -       oe =3D ovl_get_lowerstack(sb, ctx, ofs, layers);
> +       oe =3D ovl_get_lowerstack(sb, fsctx, ofs, layers);
>         err =3D PTR_ERR(oe);
>         if (IS_ERR(oe))
> -               goto out_err;
> +               return err;
>
>         /* If the upper fs is nonexistent, we mark overlayfs r/o too */
>         if (!ovl_upper_mnt(ofs))
> @@ -1489,11 +1471,11 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>                 ofs->config.uuid =3D OVL_UUID_NULL;
>         } else if (ovl_has_fsid(ofs) && ovl_upper_mnt(ofs)) {
>                 /* Use per instance persistent uuid/fsid */
> -               ovl_init_uuid_xattr(sb, ofs, &ctx->upper);
> +               ovl_init_uuid_xattr(sb, ofs, &fsctx->upper);
>         }
>
>         if (!ovl_force_readonly(ofs) && ofs->config.index) {
> -               err =3D ovl_get_indexdir(sb, ofs, oe, &ctx->upper);
> +               err =3D ovl_get_indexdir(sb, ofs, oe, &fsctx->upper);
>                 if (err)
>                         goto out_free_oe;
>
> @@ -1549,27 +1531,50 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>         sb->s_iflags |=3D SB_I_EVM_HMAC_UNSUPPORTED;
>
>         err =3D -ENOMEM;
> -       root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);
> -       if (!root_dentry)
> +       sb->s_root =3D ovl_get_root(sb, fsctx->upper.dentry, oe);
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
> +       err =3D do_ovl_fill_super(sb, ofs, fc);
> +
> +       ovl_revert_creds(old_cred);
> +
>  out_err:
> -       /*
> -        * Revert creds before calling ovl_free_fs() which will call
> -        * put_cred() and put_cred() requires that the cred's that are
> -        * put are not the caller's creds, i.e., current->cred.
> -        */
> -       if (old_cred)
> -               ovl_revert_creds(old_cred);
> -       ovl_free_fs(ofs);
> -       sb->s_fs_info =3D NULL;
> +       if (err) {
> +               ovl_free_fs(ofs);
> +               sb->s_fs_info =3D NULL;
> +       }
> +
>         return err;
>  }
>
>
> --
> 2.47.3
>

