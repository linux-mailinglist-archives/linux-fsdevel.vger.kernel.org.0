Return-Path: <linux-fsdevel+bounces-41774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CABA36D2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 11:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0971E3B1B47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF919E7ED;
	Sat, 15 Feb 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2HAmND0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA2C2ED;
	Sat, 15 Feb 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739613771; cv=none; b=NKkryUKcz5NM8JOqVEQkYtc76ClheYLz0SyDTfapfDa704spx9TtspwjMQvxWca8VI7idsK7je63TrERQc31bj4Yb/O8R6LS7U1ysxVgWg7sB3s86gP0ReBk79dvT/Fl5zB+Eywjt1uKBT/voci0Q0RIrt60EHmkrAVkqDuvS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739613771; c=relaxed/simple;
	bh=Dsqx6ltlYvLB7mdp/GM5KjCi3QZxaw1BFlvvfc4i8SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN10a1elckWmpn5nFK9Wkzs0zzkFLMkGpRydHW2zUHSYlEGvgvd9u7fhZgKAFSfAZhJqXRAPIWOfxVc+OG1VBxaC/EMIv599ScxGS6+bIrzLsHl19O0VQ7zLJaXcqlnqwpKyu7X7E9TL7aeNAm2EU+Vs06GolNyjxzR4JmUOLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2HAmND0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so6255688a12.3;
        Sat, 15 Feb 2025 02:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739613767; x=1740218567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJLpXRCHqsYg/hKbfo0O3x2rqU5ktrblNiEK1UnDr8c=;
        b=K2HAmND0qGfnN+isx/xDDCV6bmMM69AcJJA3kkDhYH6gk98J8yO18tHFaC/jXlFgb2
         rYAlzOezFbCkGsYTA73hFK0B3P9xWxFGYxTh0fmz3BTPKNIWvrYmBVnTg62KXroQ9G7p
         nkhEQJPTa1RbzdxGxwTEhMMVsGNvWwMn71cYt9Kcky5NixIa2GOD4ABaxUAr0/1xj8WO
         JJDnsCBwdrKSwYV/BUQ23ZxzV9IpaHRrtIaHY2Cdc0A99GGs81OSDBAA5Dz6TbaKHsLl
         1RUwAsSB2plSKJBWKL7qS0gprs+zuw3yyIRLjvYLSksTCYwOWzHfYTOmfWD9QuJSZBxh
         ylCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739613767; x=1740218567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJLpXRCHqsYg/hKbfo0O3x2rqU5ktrblNiEK1UnDr8c=;
        b=GqKB9Co2w6aS1KXr9hbL023PIcdHOtqjtBmx4P/N9mdeRG9gVqmlkjzMHWxuTU0W+0
         x9cCOXGLuiryKweMEs8Y/pJZiViTM18StYHBTrXNqQrTYLe0+q0/Cayl+KxHRvTQAIAh
         QfoFtecolqgb2cLz4VbeQwNWhuE3rTCy3uisrz4fk5Lgryb1hjSTl9okU02yfXbNrX1x
         2MCl3UAFLvWVgJ/QTK0cll5oIaLjLNwyyUHLmWN7lsQbH2ht5I+sEFhEs6isQtVLf2AL
         XL+reatLqQvX/D+1ZIV2dBfb5zHzrnyVHDcvAPIcXUf/+O7TJCT8Zg2PJx9Tmtd/GskV
         Uniw==
X-Forwarded-Encrypted: i=1; AJvYcCUKBXMWXPvZJwV9jPVRy5Ij/0TbyanuZCiiekljZnim4Oj4JX1V/oyhRpsG4D1cANC0zVbONLpi19dXzRLfNw==@vger.kernel.org, AJvYcCXlVMTNwff1OTt55zNHsPxqltheSi4vy5YCpTLk0GitwTjHJ1xl/PWzYMVIzPRS4bVWFopbRmckn9Earyk3@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZCSHafauVJ6EPYZwkRZMjXtN2UpbtiScuCtDyseuU05qdbns
	UnGMbnDpH49NzO4AKJAdynvGXjydKgwN40EDPKgQY1S7ktnHYssg3fKG3gNbkzgriMD60NMhc/+
	71xMYdubmK/zAraXfkqNKjNdGrWoCqQa4R10=
X-Gm-Gg: ASbGncvmFXNy2RgeyZ26Lha9zmycquljKvanRolDRug3Ka2d3n0FX5UboncgejH25+B
	8yAMQ08fiEDhZkaliYkzy+iRDJwXrIbCNfnt8X9UJ6I1HZnyat4KurCW1pIQK92TEWCTV5pg0
X-Google-Smtp-Source: AGHT+IGdNtJNKfuTMSWgGX9jCMa212c6oXSXaOb52QTuCMII5iuSPU579QMwps2wZGQ8aFjNw/6B6BZgyEoLSj9bfqA=
X-Received: by 2002:a17:906:3087:b0:ab7:b643:edd3 with SMTP id
 a640c23a62f3a-abb70921ademr205728366b.11.1739613767016; Sat, 15 Feb 2025
 02:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org> <20250214-work-overlayfs-v1-1-465d1867d3d4@kernel.org>
In-Reply-To: <20250214-work-overlayfs-v1-1-465d1867d3d4@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 15 Feb 2025 11:02:35 +0100
X-Gm-Features: AWEUYZniiL5hg5CDL_JO6yXArih1EhkKN79A6e8zvmEkt10ej3-PLTmy3Maz8HU
Message-ID: <CAOQ4uxgTZGSC0uYKJA10E_CuEE_tw-20t7kaZkp6=rGVZQURZg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] ovl: allow to specify override credentials
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Seth Forshee <sforshee@kernel.org>, 
	Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:46=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
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
> ---
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/params.c    | 25 +++++++++++++++++++++++++
>  fs/overlayfs/super.c     | 13 ++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index cb449ab310a7..ed45553943e1 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -19,6 +19,7 @@ struct ovl_config {
>         bool metacopy;
>         bool userxattr;
>         bool ovl_volatile;
> +       bool ovl_credentials;

IMO this is not a configuration...

>  };
>
>  struct ovl_sb {
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index 1115c22deca0..5dad23d6f121 100644
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
> @@ -662,6 +664,27 @@ static int ovl_parse_param(struct fs_context *fc, st=
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
> +                       if (!ofs->creator_cred)
> +                               err =3D -EINVAL;
> +                       else
> +                               config->ovl_credentials =3D true;
> +               } else {
> +                       ofs->creator_cred =3D NULL;
> +                       config->ovl_credentials =3D false;
> +               }
> +               put_cred(cred);
> +               break;
> +       }
>         default:
>                 pr_err("unrecognized mount option \"%s\" or missing value=
\n",
>                        param->key);
> @@ -1071,5 +1094,7 @@ int ovl_show_options(struct seq_file *m, struct den=
try *dentry)
>         if (ofs->config.verity_mode !=3D ovl_verity_mode_def())
>                 seq_printf(m, ",verity=3D%s",
>                            ovl_verity_mode(&ofs->config));
> +       if (ofs->config.ovl_credentials)
> +               seq_puts(m, ",override_creds");

...and there is no meaning to showing it in mount options, because this
is not a replayable configuration.
If you strap ",override_creds" to a normal shell command line mount
it means nothing and showing this option does not carry any information
about how (in which context) it was executed.
I am willing to be convinced otherwise.


>         return 0;
>  }
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 86ae6f6da36b..157ab9e8f6f8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -654,6 +654,7 @@ static int ovl_make_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>                             const struct path *workpath)
>  {
>         struct vfsmount *mnt =3D ovl_upper_mnt(ofs);
> +       const struct cred *old_cred;
>         struct dentry *workdir;
>         struct file *tmpfile;
>         bool rename_whiteout;
> @@ -665,6 +666,8 @@ static int ovl_make_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>         if (err)
>                 return err;
>
> +       old_cred =3D ovl_override_creds(sb);
> +
>         workdir =3D ovl_workdir_create(ofs, OVL_WORKDIR_NAME, false);
>         err =3D PTR_ERR(workdir);
>         if (IS_ERR_OR_NULL(workdir))
> @@ -788,6 +791,7 @@ static int ovl_make_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>                 ofs->config.nfs_export =3D false;
>         }
>  out:
> +       ovl_revert_creds(old_cred);
>         mnt_drop_write(mnt);
>         return err;
>  }
> @@ -830,6 +834,7 @@ static int ovl_get_indexdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>                             struct ovl_entry *oe, const struct path *uppe=
rpath)
>  {
>         struct vfsmount *mnt =3D ovl_upper_mnt(ofs);
> +       const struct cred *old_cred;
>         struct dentry *indexdir;
>         struct dentry *origin =3D ovl_lowerstack(oe)->dentry;
>         const struct ovl_fh *fh;
> @@ -843,6 +848,8 @@ static int ovl_get_indexdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>         if (err)
>                 goto out_free_fh;
>
> +       old_cred =3D ovl_override_creds(sb);
> +
>         /* Verify lower root is upper root origin */
>         err =3D ovl_verify_origin_fh(ofs, upperpath->dentry, fh, true);
>         if (err) {
> @@ -893,6 +900,7 @@ static int ovl_get_indexdir(struct super_block *sb, s=
truct ovl_fs *ofs,
>                 pr_warn("try deleting index dir or mounting with '-o inde=
x=3Doff' to disable inodes index.\n");
>
>  out:
> +       ovl_revert_creds(old_cred);
>         mnt_drop_write(mnt);
>  out_free_fh:
>         kfree(fh);
> @@ -1318,7 +1326,10 @@ int ovl_fill_super(struct super_block *sb, struct =
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

Is there any reason not to scope the rest of ovl_fill_super()
with the alternative override_creds instead of scoping
helper functions?
If there is a reason then I do not see what it is.

My opinion is that it does not change the permission model if we
switch one mounter_creds with another, as long as we execute all
operations on underlying layers with a consistent set of creds
(give or take CAP_SYS_RESOURCE).

If we scope the entire ovl_fill_super() with the override_creds used
later on, then we get this consistent property.

I should note that before the new mount API, it was obvious that
all operations on underlying layers are performed with "mounter creds".
with new API, "mounter creds" are really "fsconfig setup creds", and
kern_path() doing lookup when parsing string *dir=3D mount options
may be executed with different creds than fsconfig setup creds.

So the way I see it, the override_creds option is more of a command,
which allows better control over the single consistent set of ovl creds.

Thanks,
Amir.

