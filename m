Return-Path: <linux-fsdevel+bounces-26711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39495B373
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEC31F2283A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679E183CA0;
	Thu, 22 Aug 2024 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUFK1Y5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928818C31;
	Thu, 22 Aug 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324817; cv=none; b=gTOPTwjyUvVEOnZGLa7jy/GUOyDdVdrsUbJDWf9GDhdkVE/UHBLTgtSVGEH1VPgL5ANOjCi1pgfcKvNW8HUIH+0FS6V8ftBRkK+Fl3l+CR9B/MXsLuC984V0p1wdzQTVqiOZL+o2OxgS6EV9Y0YMM7XfDuuJyTdha7Ig95xP8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324817; c=relaxed/simple;
	bh=0ZVpt94+DygDIwnohKVIUXL+sJL6EPM8sAViHuwMpdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOmPch51zCYbZtx9o/JwYC1h98RT62j2sICBWIBYFZWk3cwMnV2kYjUyD1MQiDisqJz7orjtNBnaIOBVX7Zu1V00TbgjQQVYYGB5m85WLhzK3W9koH/aFQmeqrk67yL35ziA40TcZZ90jek3TfpyuZ4UiyWid8CKREwSZml6JWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUFK1Y5X; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a66b813847so41490085a.2;
        Thu, 22 Aug 2024 04:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724324814; x=1724929614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhFLnSRnRhZUdmCU6NCqfN24MhIGO7x9kdWysvQtjLA=;
        b=AUFK1Y5X/5IhGcD5oslhiBqABEYG2RV7yY01xo35J9kPTJ6QnRFKrtDp/mq3K+Qrtq
         FyVrv3BGCkjrRqKZMZl9tiJ0lWjNtfiNy3pmk8yH8QOzdE9l1yjNk4AMEbrvI9VEgL2W
         1ugSS9BrdWqfNZTcLIrI0rpttYObvvKMDTWrDDEVVr5nM1wwB/WfBQcjFydTezuL+DvW
         MVuF8s0SWoyu0AbcLcQ7T2K43vNxTPcEyNT6kmcq1YaWYU2Jz5G2W5iiyFupobP0HIsE
         39T0rbeI2nQ9e2PeZVv6Ut+HzwIMXYCQEmypayS/12LuzB+8W2mRH9bQkwES6OolPU4h
         ZOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724324814; x=1724929614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhFLnSRnRhZUdmCU6NCqfN24MhIGO7x9kdWysvQtjLA=;
        b=TzaUBHEnTiaxgnL7u5w4UlBIOYGwzYMFFudSW1zf3OtCxOrO/K4OuYO/7iqvzk0KG3
         ZNf17kKQK0CXlP1jxHWW5vKIthh5HIDndqDkgonOM+cJMKT1Z5bM7MObLzzqq4FIYGLG
         VPcyRF4zpmZmiYLZJBbkx03kWlboi+zXntYMCnqzflltzKjJYaxkUFGBfdat4CdcjmLq
         KEInYwFX53to0fPXwVONiGNJvrtVNmhT8r4TswNLmg6FtNhLUfwunvg9QBi7npQUcVx3
         7NRdhb0TD3LgAJIOXFv99nD0mCFysy/LW409GdlLxFbHjhgHcAjSJSbJmj6WTt4dzTCC
         ka5A==
X-Forwarded-Encrypted: i=1; AJvYcCUfzSY/DEfhuqLiYK1Uue0yhpPxKviOz1FLqmZL8NJQ8r2qCbX3ceuaQRBiVnBwbD8Gr1aeOSXfZVyGRZkL@vger.kernel.org, AJvYcCUnyysh8fjV7kTDp8tPq3n4qwkFPhCMDgAMQ2Rj7+zRzRG61drSMl6B29xBWGrM2HlVlf1wbtXxrRVTM5uW@vger.kernel.org, AJvYcCVTg6j4NCoHWfaUKziqad02eRLi474DPXYZvwTT8warE63kD8/zoJmTSbtmn4CdmE32/kOmasJQjDvZbhAdHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1EBl+BxK11iiWEbuDOlvQ9m54FlFmUCn6eq4M+UwVy7flOGXG
	jODTI4IrXNYueI7Gk3SnhtU4fb789rkjftxKPr+WkxoKTOb72wx8iKEStZf+vpX4DZdxLmL315d
	qFY+Sqt9ow+dN5qXywA5cg5HBrnw=
X-Google-Smtp-Source: AGHT+IEOccYNjVZJV3Oe3jkHximYHlg6BEScKfw/qP43q003vFP7IKNX1itUZnwJ2e7FDx+FmLXrYCLh148vgrhTeXU=
X-Received: by 2002:a05:620a:244d:b0:7a1:d431:8408 with SMTP id
 af79cd13be357-7a674047d73mr609271685a.37.1724324813779; Thu, 22 Aug 2024
 04:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-11-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-11-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 Aug 2024 13:06:42 +0200
Message-ID: <CAOQ4uxizZ0wM4LPUkAnpJT7ouJGeEa7FPUZqe9M17xL1w_gddQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] overlayfs/file: Convert to cred_guard()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 3:25=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Replace the override_creds_light()/revert_creds_light() pairs of
> operations with cred_guard()/cred_scoped_guard().
>
> Only ovl_copyfile() and ovl_fallocate() use cred_scoped_guard(),
> because of 'goto', which can cause the cleanup flow to run on garbage
> memory.
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  fs/overlayfs/file.c | 64 ++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 39 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 5533fedcbc47..97aa657e6916 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -31,7 +31,6 @@ static struct file *ovl_open_realfile(const struct file=
 *file,
>         struct inode *inode =3D file_inode(file);
>         struct mnt_idmap *real_idmap;
>         struct file *realfile;
> -       const struct cred *old_cred;
>         int flags =3D file->f_flags | OVL_OPEN_FLAGS;
>         int acc_mode =3D ACC_MODE(flags);
>         int err;
> @@ -39,7 +38,7 @@ static struct file *ovl_open_realfile(const struct file=
 *file,
>         if (flags & O_APPEND)
>                 acc_mode |=3D MAY_APPEND;
>
> -       old_cred =3D ovl_override_creds_light(inode->i_sb);
> +       cred_guard(ovl_creds(inode->i_sb));
>         real_idmap =3D mnt_idmap(realpath->mnt);
>         err =3D inode_permission(real_idmap, realinode, MAY_OPEN | acc_mo=
de);
>         if (err) {
> @@ -51,7 +50,6 @@ static struct file *ovl_open_realfile(const struct file=
 *file,
>                 realfile =3D backing_file_open(&file->f_path, flags, real=
path,
>                                              current_cred());
>         }
> -       revert_creds_light(old_cred);
>
>         pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
>                  file, file, ovl_whatisit(inode, realinode), file->f_flag=
s,
> @@ -182,7 +180,6 @@ static loff_t ovl_llseek(struct file *file, loff_t of=
fset, int whence)
>  {
>         struct inode *inode =3D file_inode(file);
>         struct fd real;
> -       const struct cred *old_cred;
>         loff_t ret;
>
>         /*
> @@ -211,9 +208,8 @@ static loff_t ovl_llseek(struct file *file, loff_t of=
fset, int whence)
>         ovl_inode_lock(inode);
>         real.file->f_pos =3D file->f_pos;
>
> -       old_cred =3D ovl_override_creds_light(inode->i_sb);
> +       cred_guard(ovl_creds(inode->i_sb));
>         ret =3D vfs_llseek(real.file, offset, whence);
> -       revert_creds_light(old_cred);
>
>         file->f_pos =3D real.file->f_pos;
>         ovl_inode_unlock(inode);
> @@ -385,7 +381,6 @@ static ssize_t ovl_splice_write(struct pipe_inode_inf=
o *pipe, struct file *out,
>  static int ovl_fsync(struct file *file, loff_t start, loff_t end, int da=
tasync)
>  {
>         struct fd real;
> -       const struct cred *old_cred;
>         int ret;
>
>         ret =3D ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
> @@ -398,9 +393,8 @@ static int ovl_fsync(struct file *file, loff_t start,=
 loff_t end, int datasync)
>
>         /* Don't sync lower file for fear of receiving EROFS error */
>         if (file_inode(real.file) =3D=3D ovl_inode_upper(file_inode(file)=
)) {
> -               old_cred =3D ovl_override_creds_light(file_inode(file)->i=
_sb);
> +               cred_guard(ovl_creds(file_inode(file)->i_sb));
>                 ret =3D vfs_fsync_range(real.file, start, end, datasync);
> -               revert_creds_light(old_cred);
>         }
>
>         fdput(real);
> @@ -424,7 +418,6 @@ static long ovl_fallocate(struct file *file, int mode=
, loff_t offset, loff_t len
>  {
>         struct inode *inode =3D file_inode(file);
>         struct fd real;
> -       const struct cred *old_cred;
>         int ret;
>
>         inode_lock(inode);
> @@ -438,9 +431,8 @@ static long ovl_fallocate(struct file *file, int mode=
, loff_t offset, loff_t len
>         if (ret)
>                 goto out_unlock;
>
> -       old_cred =3D ovl_override_creds_light(file_inode(file)->i_sb);
> -       ret =3D vfs_fallocate(real.file, mode, offset, len);
> -       revert_creds_light(old_cred);
> +       cred_scoped_guard(ovl_creds(file_inode(file)->i_sb))
> +               ret =3D vfs_fallocate(real.file, mode, offset, len);
>

I find this syntax confusing. Even though it is a valid syntax,
I prefer that if there is a scope we use explicit brackets for it even
if the scope is
a single line.

How about using:
       {
               cred_guard(ovl_creds(file_inode(file)->i_sb));
               ret =3D vfs_fallocate(real.file, mode, offset, len);
       }

It is more clear and helps averting the compiler bug(?).

>         /* Update size */
>         ovl_file_modified(file);
> @@ -456,16 +448,14 @@ static long ovl_fallocate(struct file *file, int mo=
de, loff_t offset, loff_t len
>  static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int=
 advice)
>  {
>         struct fd real;
> -       const struct cred *old_cred;
>         int ret;
>
>         ret =3D ovl_real_fdget(file, &real);
>         if (ret)
>                 return ret;
>
> -       old_cred =3D ovl_override_creds_light(file_inode(file)->i_sb);
> +       cred_guard(ovl_creds(file_inode(file)->i_sb));
>         ret =3D vfs_fadvise(real.file, offset, len, advice);
> -       revert_creds_light(old_cred);
>
>         fdput(real);
>
> @@ -484,7 +474,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff=
_t pos_in,
>  {
>         struct inode *inode_out =3D file_inode(file_out);
>         struct fd real_in, real_out;
> -       const struct cred *old_cred;
>         loff_t ret;
>
>         inode_lock(inode_out);
> @@ -506,26 +495,25 @@ static loff_t ovl_copyfile(struct file *file_in, lo=
ff_t pos_in,
>                 goto out_unlock;
>         }
>
> -       old_cred =3D ovl_override_creds_light(file_inode(file_out)->i_sb)=
;
> -       switch (op) {
> -       case OVL_COPY:
> -               ret =3D vfs_copy_file_range(real_in.file, pos_in,
> -                                         real_out.file, pos_out, len, fl=
ags);
> -               break;
> -
> -       case OVL_CLONE:
> -               ret =3D vfs_clone_file_range(real_in.file, pos_in,
> -                                          real_out.file, pos_out, len, f=
lags);
> -               break;
> -
> -       case OVL_DEDUPE:
> -               ret =3D vfs_dedupe_file_range_one(real_in.file, pos_in,
> -                                               real_out.file, pos_out, l=
en,
> -                                               flags);
> -               break;
> +       cred_scoped_guard(ovl_creds(file_inode(file_out)->i_sb)) {
> +               switch (op) {
> +               case OVL_COPY:
> +                       ret =3D vfs_copy_file_range(real_in.file, pos_in,
> +                                                 real_out.file, pos_out,=
 len, flags);
> +                       break;
> +
> +               case OVL_CLONE:
> +                       ret =3D vfs_clone_file_range(real_in.file, pos_in=
,
> +                                                  real_out.file, pos_out=
, len, flags);
> +                       break;
> +
> +               case OVL_DEDUPE:
> +                       ret =3D vfs_dedupe_file_range_one(real_in.file, p=
os_in,
> +                                                       real_out.file, po=
s_out, len,
> +                                                       flags);
> +                       break;
> +               }
>         }
> -       revert_creds_light(old_cred);
> -
>         /* Update size */
>         ovl_file_modified(file_out);
>

Maybe we should just place cred_guard(ovl_creds(file_inode(file_out)->i_sb)=
)
in ovl_copy_file_range()?

I don't think that the order of ovl_override_creds() vs. inode_lock()
really matters?

Thanks,
Amir.

