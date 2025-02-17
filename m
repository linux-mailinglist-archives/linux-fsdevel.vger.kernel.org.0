Return-Path: <linux-fsdevel+bounces-41840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657B8A380B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2BE167AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CBE2165E2;
	Mon, 17 Feb 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOAyLK9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1995015C0;
	Mon, 17 Feb 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789499; cv=none; b=gx5r3ieNBJlR4FpaGk2RqHaLXHtePq87NytXI4sj8e71uSW8ui6XCSgwymb/qh//gobPxqMzKNKQqOyyshR8kCyjMUTpUoBJid94KCyU/odvqOxZyUiZUXTIdOGy4XJBspZhIXaXAgL7FqolrmlM/M7l0MUvbe+/2306tjmFk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789499; c=relaxed/simple;
	bh=e3Qx0gnqAglhKcbHEoHLuULFkgoI+XheJ9LCvrdQCo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qT2yXNBGLPhM0kdNPV1eMWQyR3V6rJDW7sOf9Vdh4xpIK3ektvlKOjtyQ6N44pxYqHnntDYXD+rp870mhraZNrbV6qDDbFXceWEeoP+oApGXQApwAklbRHHo9hg9rTwcdmbyenLP1w03UVfLjH5/5W6E1enuMdWCHVlQ0bdD5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOAyLK9g; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb8f586d68so161268366b.0;
        Mon, 17 Feb 2025 02:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789496; x=1740394296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHq/5XVsxHMGgFedLKkDDlbwP6eDc/KL+DKbjABJlPs=;
        b=KOAyLK9gdLusRGM2cT1EGIjbZIEbQV2L4GwPeAJVvs248Ztx8vUY4aplIJk6Hpulos
         EXU7HeJdyf/lit9bsOI9vODOrHpymx1RCY2ZkzRjLYfxgrapD8ZpP/dLwUecGVx+omtW
         z2Yp/o6HeNtsnoIUsOrh6SJ0qd6V18qJVx1biguSvukYavQr+SHwW7EjduQgViq+OZiZ
         a32ejQ5QHRmdPGj9Q5DpNRxWkyGbfTVGZ9aSrP3+VARZTMyve/sjKmCIoSGRZE13hLIe
         C6nhsIqnXcRfws9EC2whOKSSYtLqaEIBpqi9kX6kC9RpTtYD0DgnKyLB3hbDVaV5wMGz
         uYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789496; x=1740394296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHq/5XVsxHMGgFedLKkDDlbwP6eDc/KL+DKbjABJlPs=;
        b=QOgFMitwEyD9VgCO7ZpnraK2iXj6jsV9eGJ9bfzXD6WuIFie7jKObJ8CXWsZ7FemSF
         G9LiuA4f3Cl+pNoLdXVeK7Jsh6CE7XBtweBbb0wW2JC3cGUnZZZPu/4/crRd63Y30NbS
         X1gEZDjcOdPHZSDFwVyPN1c9hCn9hPPmAOJaYgwGPYdXP6o4zfogLd0+wktm5e66kX0f
         kYGfqZUbUa2PMP1RhbfjLy541uK/MIbJAeMhA+wmmEbRZAng3McfFrP+Os3vSoVdnMQr
         wDAwKIU25zrVpJO+cEvXXTFc6iKBivjnv7+IjyKY9XU8yhsolyctHcS+ij90+9vcq7ee
         C5sg==
X-Forwarded-Encrypted: i=1; AJvYcCVthtbR202O8ptEXwxv9n/beR77aWPXE6wVPHHKd4++srNgfTUVzGH926aPCCdLYfkhQfjp/mz8Jvoxflb4uw==@vger.kernel.org, AJvYcCWitlCkaMnbHuakg/IUBDQg2xkGYBIcAa9fXigSlycqLm+md2ngVku+YlVgxTYi9rB2jqeKnWlUepdf3sSE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4gE7t64gTNT33Cd5HHDCqLqLe938S2+YGBRQGRF2uljNHcRW
	bTxnKsZF3qPi8GI/IQaQNDfTUX59lsDOUdAJbBRa/Ea9PImP1A5KaNY5HBwySfiPI7EzhDKqsZh
	TCKawJxrXQP2myCBhmMlJn9+G/SA=
X-Gm-Gg: ASbGncseWLeIFqIrfM/va46OeNlJajXxQ6Lr5l7pN0ujK0Yvkr4Vidp/LFQiKln+hb4
	zriWJ0ff6NRKNknUgGzNsw+J5MpXdbC7tyboE+C4ViUIifXo4/oal/B340CKkjQ9vJeig5Lpy
X-Google-Smtp-Source: AGHT+IGNA4hZqXSKe2udftMfeV1J5/O40eO7buWDzZ3cVmts2P9y+2rdN067MP+HUqMolRtrWrXNa4KEEInnKNUrLkY=
X-Received: by 2002:a17:906:3290:b0:ab7:f2da:8126 with SMTP id
 a640c23a62f3a-abb7098261dmr883348466b.11.1739789495881; Mon, 17 Feb 2025
 02:51:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-work-overlayfs-v2-0-41dfe7718963@kernel.org> <20250217-work-overlayfs-v2-1-41dfe7718963@kernel.org>
In-Reply-To: <20250217-work-overlayfs-v2-1-41dfe7718963@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Feb 2025 11:51:23 +0100
X-Gm-Features: AWEUYZlGQSU1ZtHTqU04UOowHmA5TC9rpYl1Fswj9LWeu4_2GVCj1htju3I4QO8
Message-ID: <CAOQ4uxiPCe5UkO+6+n40Pkw1wbkR6-TFjvhTz5APhyKmFxh3=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/2] ovl: allow to specify override credentials
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 11:20=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Currently overlayfs uses the mounter's credentials for it's
> override_creds() calls. That provides a consistent permission model.
>
> This patches allows a caller to instruct overlayfs to use its
> credentials instead. The caller must be located in the same user
> namespace as the user namespace the overlayfs instance will be mounted
> in. This provides a consistent and simple security model.
>
> With this it is possible to e.g., mount an overlayfs instance where the
> mounter must have CAP_SYS_ADMIN but the credentials used for
> override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
> custom fs{g,u}id different from the callers and other tweaks.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

For the code:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

For non-RFC patch please add something to the
'Permission model' section in overlayfs.rst

This section refers to the "mounting task" which implies that the
"mounting task" credentials are constant throughout the mount
(which made sense until the new mount API).

I would add a [*] near "mounting task" and write a footnote that
"mounting task" credentials is referring to the mounting task
credentials at the time of mount() system call or at the some of
executing FSCONFIG_CMD_CREATE fsconfig() command or
(since kernel xxx) at the time of setting the mount option
"override_creds" using the fsconfig() system call.

Feel free to rephrase as you see fit.

Thanks,
Amir.


> ---
>  fs/overlayfs/params.c | 22 ++++++++++++++++++++++
>  fs/overlayfs/super.c  | 11 ++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 1115c22deca0..f2bc8acf6bf1 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -59,6 +59,7 @@ enum ovl_opt {
>         Opt_metacopy,
>         Opt_verity,
>         Opt_volatile,
> +       Opt_override_creds,
>  };
>
>  static const struct constant_table ovl_parameter_bool[] =3D {
> @@ -155,6 +156,7 @@ const struct fs_parameter_spec ovl_parameter_spec[] =
=3D {
>         fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_b=
ool),
>         fsparam_enum("verity",              Opt_verity, ovl_parameter_ver=
ity),
>         fsparam_flag("volatile",            Opt_volatile),
> +       fsparam_flag_no("override_creds",   Opt_override_creds),
>         {}
>  };
>
> @@ -662,6 +664,26 @@ static int ovl_parse_param(struct fs_context *fc, st=
ruct fs_parameter *param)
>         case Opt_userxattr:
>                 config->userxattr =3D true;
>                 break;
> +       case Opt_override_creds: {
> +               const struct cred *cred =3D ofs->creator_cred;
> +
> +               if (!result.negated) {
> +                       if (fc->user_ns !=3D current_user_ns()) {
> +                               err =3D -EINVAL;
> +                               break;
> +                       }
> +
> +                       ofs->creator_cred =3D prepare_creds();
> +                       if (!ofs->creator_cred) {
> +                               err =3D -EINVAL;
> +                               break;
> +                       }
> +               } else {
> +                       ofs->creator_cred =3D NULL;
> +               }
> +               put_cred(cred);
> +               break;
> +       }
>         default:
>                 pr_err("unrecognized mount option \"%s\" or missing value=
\n",
>                        param->key);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 86ae6f6da36b..a85071fe18fd 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1305,6 +1305,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>  {
>         struct ovl_fs *ofs =3D sb->s_fs_info;
>         struct ovl_fs_context *ctx =3D fc->fs_private;
> +       const struct cred *old_cred =3D NULL;
>         struct dentry *root_dentry;
>         struct ovl_entry *oe;
>         struct ovl_layer *layers;
> @@ -1318,10 +1319,15 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>         sb->s_d_op =3D &ovl_dentry_operations;
>
>         err =3D -ENOMEM;
> -       ofs->creator_cred =3D cred =3D prepare_creds();
> +       if (!ofs->creator_cred)
> +               ofs->creator_cred =3D cred =3D prepare_creds();
> +       else
> +               cred =3D (struct cred *)ofs->creator_cred;
>         if (!cred)
>                 goto out_err;
>
> +       old_cred =3D ovl_override_creds(sb);
> +
>         err =3D ovl_fs_params_verify(ctx, &ofs->config);
>         if (err)
>                 goto out_err;
> @@ -1481,6 +1487,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>
>         sb->s_root =3D root_dentry;
>
> +       ovl_revert_creds(old_cred);
>         return 0;
>
>  out_free_oe:
> @@ -1488,6 +1495,8 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>  out_err:
>         ovl_free_fs(ofs);
>         sb->s_fs_info =3D NULL;
> +       if (old_cred)
> +               ovl_revert_creds(old_cred);
>         return err;
>  }
>
>
> --
> 2.47.2
>

