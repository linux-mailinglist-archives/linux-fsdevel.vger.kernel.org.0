Return-Path: <linux-fsdevel+bounces-53414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC138AEEE1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A5F17F588
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF35244671;
	Tue,  1 Jul 2025 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+7l9i9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712423C4E0;
	Tue,  1 Jul 2025 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349961; cv=none; b=E93E/ApcYNym6v/WNWfgEkezJcBR/imDBFb0vjtL6opDg5chUuW6vtIWOCDM20AchFbCjo5p2OCdXZkkoS75bw6d+5v3A1G7C1yU0DOR1evRPz1lUNOj83+Ey+9m387NNXDeJpSfSLb4LL2LZMGL8awosi+TDA0647d7LRz+vmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349961; c=relaxed/simple;
	bh=SeIXvbsKD/6wDDdSTrLiwRGd6Sf5ThDoHRlhISLn+Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfqbSM88jJ+ViVscZipIsyvFo5NXKOm+uGKkR9rgWtSokymFzJTrzEtdw9WmsR9NaHZk5HBz6J1UCzSZsrnE+H9syiG1IT3KMD4HbLA0z/WNYo8SM6vwlPoyn3dHvUAKQmvJnXvlYVpbyyF3m5pZtWWpR6kuKr3VHGFCN1RPvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+7l9i9k; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae361e8ec32so673412466b.3;
        Mon, 30 Jun 2025 23:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751349957; x=1751954757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuEXV07Z9sdbVmePGAe0RiLvhvhMH/ORTr8Xg5rdgBA=;
        b=E+7l9i9kLtEE34rjEnLqXnObXKxQG8uarocPhssHFhRLMtiYQJ51/JzvaC0hHDRWgP
         Lg1i+BQsM4PsjssKs1wCY1kDZksLO6le/3qm/MR4S3Dqcmxqcv5kzekJYEFXR3WLIVe7
         67uoT9e18BhrolXeD17nMqz/n1uaYxAl58tLnkXS2oxge9y/R1Pf1+jmroV0NTyPPnJa
         DQnn0Qb93OPO2HpWYTWDs9cBQiBH5wz5hjMt19GPjQjxsQRImsV25hXogPb+wXi1EpFt
         PHjppMRV9rifLt9BXbvxeIzPX6iaKLzj4GdJ+unD86opUTjEX45wMSgzobUwIf7MG8gq
         s0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751349957; x=1751954757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuEXV07Z9sdbVmePGAe0RiLvhvhMH/ORTr8Xg5rdgBA=;
        b=n5ulsoLnbikljCGnezbvwfcO0wE/LxXAjkAK05CkWV+Yl/N2PU6chsICCcAwoSMYNQ
         SO41BPkp5agov6o4foO253xGKgQraEwDYYuO5kL5c9PdOMTuUfcQKOAmXB7lHQFnfAmU
         JvKBFFNZuGI/4wBmY8P0RQ4ZClHXIIH8v5RpwSncnNhV+JMQK8Moo9hayNT7d6ekyVzM
         TdR0zDK3TFjCKMwiTzD6HrtG2cC9sGljh35rtkZXhTfYezu0RC3v2LenC5+74APQDKah
         IPO4BHaEqRc0/a4zMgwKwE/mxFp8lFqVNGJe6n4r9VBS2TN4qjy/m8s43bQh900D5I/O
         MjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmSB1KUDgjiGXUjkQrAsa7zQZnntcf9QrUryBKMzjH19ObiCs8+Ut++eFAP+vx5BStztJOYG+NVGk=@vger.kernel.org, AJvYcCVcWpg6Qgob1Jf1Y4EpmoetTYDJHGcAFwJnPtVkUMf3H+219YJ3GAHvjcsjqJ/n651y3iTYu3prfSMdjux1@vger.kernel.org, AJvYcCVwu0GoisU0ro3/YRFc08E8OO2CtjMelZuoSdAO0QfCekGO6Wesuv6+ZxbYvw/5xM1FUuRfMJduTS4G@vger.kernel.org, AJvYcCWI80asZIAWQjrfWFu0+SDCuUHom/i7W9WY/egtDOb3DT9+RwD+JIfm7X8bCbAHU0swdhKWZrb34A==@vger.kernel.org, AJvYcCWM3leqCJ2p8y14KcFDRUGF6/C0Am40R/2caqBK000qPACA0ooSaCiXqiL8oRwu8AXs/mUXq4LxVuzGO1udQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuxxuLLJOLHhtP8Gfi1hKyQu4+EzvxNOpK8dnCqmq/NpRW0Iv
	EkLVAZ8259z/iXXelas+OdwqzhTxTyDxJXOafqTIgmRluj63xxKYKIlb8nXoqIOqV7SE3BbRd64
	nOLt1TvFMiKNdxm86ii2WiE3PiocX2Bo=
X-Gm-Gg: ASbGncsFbZApAC6agFGx/x3p3Hcvi2B0MqiXAl2oWOKeMaDY3BT4r3K9cjkcNGOLJfu
	X88dnQ5iXIaa0qOrMug2olPTaz3wq9nurAHsWodhBbwvvCbfInkndAZAGni+5Pz/mvCFx2baVZq
	aBP13KzfOziQ4JqMXDy/jKVuzsj2fkjLhw+5gDaTbwTYc=
X-Google-Smtp-Source: AGHT+IE8ltAVUHmG0o8AJsNM6aS+AMGdPwBTV6jSAOtvjhmVYfBdldq1gqGOmPM/QRe73Xswe0K6G48qYHzvM8ukRGI=
X-Received: by 2002:a17:906:4fd5:b0:ae3:5ebc:7a3c with SMTP id
 a640c23a62f3a-ae35ebc87a5mr1309732366b.11.1751349956866; Mon, 30 Jun 2025
 23:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org> <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 1 Jul 2025 08:05:45 +0200
X-Gm-Features: Ac12FXxgSnJQgGdAHWGW1XZ5QTb4sHxkxo40tOuCn_ldUpIgeYyBQujjKbItCiM
Message-ID: <CAOQ4uxgbeMEqx7FtBc3KnrCjOHHRniSjBPLzk7_S9SjYKcY_ag@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 6:20=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> Future patches will add new syscalls which use these functions. As
> this interface won't be used for ioctls only, the EOPNOSUPP is more
> appropriate return code.
>
> This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/ecryptfs/inode.c  |  8 +++++++-
>  fs/file_attr.c       | 12 ++++++++++--
>  fs/overlayfs/inode.c |  2 +-
>  3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 493d7f194956..a55c1375127f 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -1126,7 +1126,13 @@ static int ecryptfs_removexattr(struct dentry *den=
try, struct inode *inode,
>
>  static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr =
*fa)
>  {
> -       return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +       int rc;
> +
> +       rc =3D vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +       if (rc =3D=3D -EOPNOTSUPP)
> +               rc =3D -ENOIOCTLCMD;
> +
> +       return rc;
>  }
>

I think the semantics should be
"This patch converts return code of vfs_fileattr_[gs]et and ->fileattr_[gs]=
et()
from ENOIOCTLCMD to EOPNOSUPP"

ENOIOCTLCMD belongs only in the ioctl frontend, so above conversion
is not needed.

>  static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index be62d97cc444..4e85fa00c092 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -79,7 +79,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct file=
attr *fa)
>         int error;
>
>         if (!inode->i_op->fileattr_get)
> -               return -ENOIOCTLCMD;
> +               return -EOPNOTSUPP;
>
>         error =3D security_inode_file_getattr(dentry, fa);
>         if (error)
> @@ -229,7 +229,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct =
dentry *dentry,
>         int err;
>
>         if (!inode->i_op->fileattr_set)
> -               return -ENOIOCTLCMD;
> +               return -EOPNOTSUPP;
>
>         if (!inode_owner_or_capable(idmap, inode))
>                 return -EPERM;
> @@ -271,6 +271,8 @@ int ioctl_getflags(struct file *file, unsigned int __=
user *argp)
>         int err;
>
>         err =3D vfs_fileattr_get(file->f_path.dentry, &fa);
> +       if (err =3D=3D -EOPNOTSUPP)
> +               err =3D -ENOIOCTLCMD;
>         if (!err)
>                 err =3D put_user(fa.flags, argp);
>         return err;
> @@ -292,6 +294,8 @@ int ioctl_setflags(struct file *file, unsigned int __=
user *argp)
>                         fileattr_fill_flags(&fa, flags);
>                         err =3D vfs_fileattr_set(idmap, dentry, &fa);
>                         mnt_drop_write_file(file);
> +                       if (err =3D=3D -EOPNOTSUPP)
> +                               err =3D -ENOIOCTLCMD;
>                 }
>         }
>         return err;
> @@ -304,6 +308,8 @@ int ioctl_fsgetxattr(struct file *file, void __user *=
argp)
>         int err;
>
>         err =3D vfs_fileattr_get(file->f_path.dentry, &fa);
> +       if (err =3D=3D -EOPNOTSUPP)
> +               err =3D -ENOIOCTLCMD;
>         if (!err)
>                 err =3D copy_fsxattr_to_user(&fa, argp);
>
> @@ -324,6 +330,8 @@ int ioctl_fssetxattr(struct file *file, void __user *=
argp)
>                 if (!err) {
>                         err =3D vfs_fileattr_set(idmap, dentry, &fa);
>                         mnt_drop_write_file(file);
> +                       if (err =3D=3D -EOPNOTSUPP)
> +                               err =3D -ENOIOCTLCMD;
>                 }
>         }
>         return err;
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 6f0e15f86c21..096d44712bb1 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *realpath=
, struct fileattr *fa)
>                 return err;
>
>         err =3D vfs_fileattr_get(realpath->dentry, fa);
> -       if (err =3D=3D -ENOIOCTLCMD)
> +       if (err =3D=3D -EOPNOTSUPP)
>                 err =3D -ENOTTY;
>         return err;
>  }

That's the wrong way, because it hides the desired -EOPNOTSUPP
return code from ovl_fileattr_get().

The conversion to -ENOTTY was done for
5b0a414d06c3 ("ovl: fix filattr copy-up failure"),
so please do this instead:

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -722,7 +722,7 @@ int ovl_real_fileattr_get(const struct path
*realpath, struct fileattr *fa)

        err =3D vfs_fileattr_get(realpath->dentry, fa);
        if (err =3D=3D -ENOIOCTLCMD)
-               err =3D -ENOTTY;
+               err =3D -EOPNOTSUPP;
        return err;
 }

--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -178,7 +178,7 @@ static int ovl_copy_fileattr(struct inode *inode,
const struct path *old,
        err =3D ovl_real_fileattr_get(old, &oldfa);
        if (err) {
                /* Ntfs-3g returns -EINVAL for "no fileattr support" */
-               if (err =3D=3D -ENOTTY || err =3D=3D -EINVAL)
+               if (err =3D=3D -ENOTTY || err =3D=3D -EINVAL || err =3D=3D =
-EOPNOTSUPP)
                        return 0;
                pr_warn("failed to retrieve lower fileattr (%pd2, err=3D%i)=
\n",
                        old->dentry, err);


Thanks,
Amir.

