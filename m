Return-Path: <linux-fsdevel+bounces-42060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A22A3BD59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 12:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A581899348
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF2E1DF265;
	Wed, 19 Feb 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZEE40Cm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26391DC98A;
	Wed, 19 Feb 2025 11:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965500; cv=none; b=A36kZ9XaVNDGqTxzdn0x61awgAmLeR8Hy7QK+aKsau83G2qwPQJKIjTX1KX57YL5zbCsjHpPYPF3xGYtg9g+fhX00VMmf3KplDxYpRO3iuzpyolojvO1YQm86TcwMi+RTEyVoltJgY3YV37NcBMpgFDmaEeBBVq/iF0GQWqAWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965500; c=relaxed/simple;
	bh=As1cE36VD31Tk1Qnvxul0k0GvQnalmspBJG9KqdG8SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfvHUi9KM4+jCdD+VtDaIWq1Jn0P1KfoiwIy4vLEHDSO0MQYCB/gH1e4yyiVh4t/A2y2J3U/DS4JpkbCgLlrRPbTXDiSeMC7Nn3sxGalEIIH1VTHKCuGtF68rRHsL/zqRG9LGM75fHnxZNyrGyEilCFe1ic0jIVSr3iKCzfSamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZEE40Cm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so1481494a12.1;
        Wed, 19 Feb 2025 03:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739965497; x=1740570297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4rL17RBA3ahHT8WHzeb+l/7UV4sIuJ1Gz95ekUeQRY=;
        b=MZEE40Cm28Z/+oZ7jqmeWS/aQQVN0DCuD+FFukOrOMjOwIJBrZoJ+ONJ0fmFZ5+TLX
         VNbt7ui2+M0XF0G41OVjubxz0bfYz3nW/VzX4mkKNkHvvkSWavXpzEgYhnC2dvBj0Qh4
         M64Mr6FQ1G/hNoGpaSAosuqX1btksBmPiYeYpTkUms1RR53NeFidtiREwU+6wSnzAJVZ
         pKjMfekZO9hXdoxMvP2yPjKQqb6xwtEluqY1NMPmUBUK9g/CYUG8EI7WcVr2BOtz7zD8
         CuV7CdrKeB9WhqTQXEpyM8RQuVWxN45TVnmfBMx60Q1P1Q7eKSnla791BWIniXC2FR0d
         HK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965497; x=1740570297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4rL17RBA3ahHT8WHzeb+l/7UV4sIuJ1Gz95ekUeQRY=;
        b=fDB/WmnEbtwTJTdwn4oi9tEaEzptbZliAGP9tjVejtiySoNv07cRafPPo6Hqr+P5iq
         HiViZZqwwJrQZOPtcu1bx1PozRh/x3mK2ld4QBw+J4v4WiY0AMPLc+Vy37dUxmI3B0dk
         Lhk9TGT+JI3T5Klcz3LvOLde8oxPXzmejQ2iiv9y0B/lHu7GdXOc3Wo6ZbZfrR772DlJ
         WsZpOGwro15RLT2E9qdNlhj+2Wu4rkQcCiUzxsZqj7UkWAm1dcE0Q1v5j3juSoAxqvy0
         1hK5u9pU8X3RsDkDG+tjCHyTVMG48WNcugE0FtdA0Sl6zMW6SLVNKILHFTteCoHXDwjF
         yP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhd4ucZOiASP8cEE5mCJf7NukcCS4G2bzye0cu65iQ/4MhibBepxgE3nr/6kb1K9hMfn7PdB1W8tWF9N57Lw==@vger.kernel.org, AJvYcCWyw3N9nMzT35XzgVOhITArYzhh32/1ff2ttoumyGaH+/cmuFo+DdxWixOJW3F2Ynm1aJzXIQYDODfrOis0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhng+U9VKHI0zfXT0FKZrd2Z1qz/CdtaMjMpO2BqAO/f7RhZD0
	inRzR3Fdud3QfAeSW3LrgeNPN/3ryC6J9qRC/ehlf45itSR1bYDvMrh72DGn1qhljDy3DiVBpzZ
	FOVVmN5expHidc7CxNYfYQm+gIHU=
X-Gm-Gg: ASbGncsgWmqXQ2q1OD7ZDgwJUSAZOIbbZgwzlLhsdUPpwF1VkusTq22D8p4vpgGpM/Y
	RC6TuuysLhDDbFlRNJ15f2W+s+klCxhebrVSBwecKn4rMbnyNyAsoENfndLfWYJ4LvkL3GMCm
X-Google-Smtp-Source: AGHT+IE10O5g/v1jLp7WcTdfqqGONSNchctRG2QVAHE/5OmqX6LgTB46CdxDrDYjNKzany2uzV4AHvrJ5XWbZJMB2cs=
X-Received: by 2002:a05:6402:2089:b0:5e0:7fc9:8605 with SMTP id
 4fb4d7f45d1cf-5e088da324emr2973387a12.6.1739965496587; Wed, 19 Feb 2025
 03:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219-work-overlayfs-v3-0-46af55e4ceda@kernel.org> <20250219-work-overlayfs-v3-1-46af55e4ceda@kernel.org>
In-Reply-To: <20250219-work-overlayfs-v3-1-46af55e4ceda@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Feb 2025 12:44:45 +0100
X-Gm-Features: AWEUYZk3yMgIVNN6P72G0lxD3avFmupTufJdJFIgGO5ep8iC5n9QwZrnVtgJmoo
Message-ID: <CAOQ4uxgU7fH=uwEaWo=ZaHSTzMfn4tBR5Oa+hc6LOqBCiS9cVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ovl: allow to specify override credentials
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 11:02=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Currently overlayfs uses the mounter's credentials for it's
> override_creds() calls. That provides a consistent permission model.
>
> This patches allows a caller to instruct overlayfs to use its
> credentials instead. The caller must be located in the same user
> namespace hierarchy as the user namespace the overlayfs instance will be
> mounted in. This provides a consistent and simple security model.
>
> With this it is possible to e.g., mount an overlayfs instance where the
> mounter must have CAP_SYS_ADMIN but the credentials used for
> override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
> custom fs{g,u}id different from the callers and other tweaks.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  Documentation/filesystems/overlayfs.rst | 24 +++++++++++++++++++-----
>  fs/overlayfs/params.c                   | 25 +++++++++++++++++++++++++
>  fs/overlayfs/super.c                    | 16 +++++++++++++++-
>  3 files changed, 59 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/file=
systems/overlayfs.rst
> index 6245b67ae9e0..2db379b4b31e 100644
> --- a/Documentation/filesystems/overlayfs.rst
> +++ b/Documentation/filesystems/overlayfs.rst
> @@ -292,13 +292,27 @@ rename or unlink will of course be noticed and hand=
led).
>  Permission model
>  ----------------
>
> +An overlay filesystem stashes credentials that will be used when
> +accessing lower or upper filesystems.
> +
> +In the old mount api the credentials of the task calling mount(2) are
> +stashed. In the new mount api the credentials of the task creating the
> +superblock through FSCONFIG_CMD_CREATE command of fsconfig(2) are
> +stashed.
> +
> +Starting with kernel v6.15 it is possible to use the "override_creds"
> +mount option which will cause the credentials of the calling task to be
> +recorded. Note that "override_creds" is only meaningful when used with
> +the new mount api as the old mount api combines setting options and
> +superblock creation in a single mount(2) syscall.
> +
>  Permission checking in the overlay filesystem follows these principles:
>
>   1) permission check SHOULD return the same result before and after copy=
 up
>
>   2) task creating the overlay mount MUST NOT gain additional privileges
>
> - 3) non-mounting task MAY gain additional privileges through the overlay=
,
> + 3) task[*] MAY gain additional privileges through the overlay,
>      compared to direct access on underlying lower or upper filesystems
>
>  This is achieved by performing two permission checks on each access:
> @@ -306,7 +320,7 @@ This is achieved by performing two permission checks =
on each access:
>   a) check if current task is allowed access based on local DAC (owner,
>      group, mode and posix acl), as well as MAC checks
>
> - b) check if mounting task would be allowed real operation on lower or
> + b) check if stashed credentials would be allowed real operation on lowe=
r or
>      upper layer based on underlying filesystem permissions, again includ=
ing
>      MAC checks
>
> @@ -315,10 +329,10 @@ are copied up.  On the other hand it can result in =
server enforced
>  permissions (used by NFS, for example) being ignored (3).
>
>  Check (b) ensures that no task gains permissions to underlying layers th=
at
> -the mounting task does not have (2).  This also means that it is possibl=
e
> +the stashed credentials do not have (2).  This also means that it is pos=
sible
>  to create setups where the consistency rule (1) does not hold; normally,
> -however, the mounting task will have sufficient privileges to perform al=
l
> -operations.
> +however, the stashed credentials will have sufficient privileges to
> +perform all operations.
>
>  Another way to demonstrate this model is drawing parallels between::
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 1115c22deca0..6a94a56f14fb 100644
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
> @@ -662,6 +664,29 @@ static int ovl_parse_param(struct fs_context *fc, st=
ruct fs_parameter *param)
>         case Opt_userxattr:
>                 config->userxattr =3D true;
>                 break;
> +       case Opt_override_creds: {
> +               const struct cred *cred =3D NULL;
> +
> +               if (result.negated) {
> +                       swap(cred, ofs->creator_cred);
> +                       put_cred(cred);
> +                       break;
> +               }
> +
> +               if (!current_in_userns(fc->user_ns)) {
> +                       err =3D -EINVAL;
> +                       break;
> +               }
> +
> +               cred =3D prepare_creds();
> +               if (cred)
> +                       swap(cred, ofs->creator_cred);
> +               else
> +                       err =3D -EINVAL;

Did you mean ENOMEM?

> +
> +               put_cred(cred);
> +               break;
> +       }
>         default:
>                 pr_err("unrecognized mount option \"%s\" or missing value=
\n",
>                        param->key);
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 86ae6f6da36b..cf0d8f1b6710 100644
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
> @@ -1481,11 +1487,19 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>
>         sb->s_root =3D root_dentry;
>
> +       ovl_revert_creds(old_cred);
>         return 0;
>
>  out_free_oe:
>         ovl_free_entry(oe);
>  out_err:
> +       /*
> +        * Revert creds before calling ovl_free_fs() which will call
> +        * put_cred() and put_cred() requires that the cred's that are
> +        * put are current->cred.
> +        */
> +       if (old_cred)
> +               ovl_revert_creds(old_cred);

Did you mean that cred's that are NOT current->cred?

With those fixes you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

