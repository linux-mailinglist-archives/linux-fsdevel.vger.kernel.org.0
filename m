Return-Path: <linux-fsdevel+bounces-53408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4BAEEDDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B136A4404E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 05:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDBD23AB8B;
	Tue,  1 Jul 2025 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et2/Zven"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34D5205AD7;
	Tue,  1 Jul 2025 05:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751348364; cv=none; b=Tg50LFxQ11h730FBdIjcxNnSmyt2TeDuhZOo/IkYyXYF9NylDaS0kIiAd9O9vxl19a0+ODIrWmHG5kuvwR+UlwWEOQVPA4Pf6DgYvApkRiUrshg0S+6e9KodSLNhzDKU3kUL+dVCZWpkc6MzT8bZeIWd0oUexwdI/FXOnGardkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751348364; c=relaxed/simple;
	bh=VXCo/gnIh1HdrPQixp0tFBGeAJGgLfvfyEkdUZ1LlGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLVwBVsGi0n6iNEKkPq3awVwVPA7Qd+MNMulnPa96dUdzteM93JK7cz2W0KSMRbqc+9dUFWSwhYyt4vht15Cx6XAmvU6zRf7OBuUXglzKkVKIX6fXCx22kS9tiJ58x/z4Wr0A8yMPNFsyNHS1Dkn5/LUPQo2sR/TQXYzQC3qFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et2/Zven; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0d4451a3fso513182766b.1;
        Mon, 30 Jun 2025 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751348360; x=1751953160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8ddENVTOE2lhzeSvPH8FSac00chEOCVvxKJ/Gje2kw=;
        b=Et2/Zven3LPs+/IKTetHIXcX4x8CtRBRye9OERDYqJI61MXH3Ao9HwUGY6QlLpBJPw
         G8WduoMuqIyJ6CaHt7CwEe7NM3zwcQPtf2rjsD/deNw7zER8zMn32GXq2YXxpJNDA/g+
         e63XJBackDAIXpeBw82Vclw9vItjX7ALbCcOU1DqpP48rgGvIKxmeT0gCwt1goS0Z9CF
         gpMFCV0knS6u8dkTwCcAcMZXmbjvglCMiFUwaOy1Cl3f2iTEqF64J0RQ2ROA6rSsgKAB
         cjkm3mHTukK4YKWmPBsDfmso8hfB6MJL/blOx9RKak1eG7b0auGFSWkTXzM9ZbiZySWx
         p1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751348360; x=1751953160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8ddENVTOE2lhzeSvPH8FSac00chEOCVvxKJ/Gje2kw=;
        b=h0N+B20VsijeQmeSFiiz2nTG2w/WxhWBu3Mej4QoaLmeiBUr+lKKAFNJrRbm82KWBw
         dAEXtbVkioENReCw60ROnd9X0dJkUjc15vQlkeh0cnCgHK15wcmWLW4Hm2mSra46F7Z3
         rgFMjnBMSL9RBFGVcca80/rNq91RCZvk6T6zRPHVqoTr9+P/pyzW7gKcx1ba82QM8NRc
         YIV3DM3mCaMxEQ8Z3oz+RgmU3SjNUu854SBWjaklDtBxpIq677E5Zd8te8zb8VpkxdHA
         35M4zjjiPqSCNB4MXJ1hasVJWBkA4TAqym8+OP3dvCVjzsnfGzQJiW3dyosUPMsdUMPX
         UBww==
X-Forwarded-Encrypted: i=1; AJvYcCU+wEjW5mOgOc8+QdNgTKOOaEmLtPx8fs1PebF9hJuwoRCuPFO9pNZ+r4dLXdMFZ6MF9CAb6bj9C/wp@vger.kernel.org, AJvYcCUpRIGwdfqmcvmFyaxsVb5ZOk6to8jPAQzChnZ8kRl7wqbnQeRLXiQ8pO2m1BR+rFPgyHLozJWmGIJyE/N1@vger.kernel.org, AJvYcCVYOpFkjgVBBR4RvpK57aPaMFEIMtHzPz+ZdmqExlBkPTS/CqAr2J8hkVB6Y8h32eNXBGZM9r4nTQ==@vger.kernel.org, AJvYcCVqER0AuSg9K5Q/C/HmLqBVnjHEccsYhpjmbcS1dgRwdG5SMNrglVxoHsjkPMau2n6FnA6PsPBSKZ6M2dbj0Q==@vger.kernel.org, AJvYcCXBoqY0xoqzoM25tVLMZ9GXayU9UziBbIRjYFIIzuZEoADPrZh7pW2o34GG2BYS0c6lWRbEXQJyP6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWGVW+CnnEy+Cchx+8rF9w7I032rTFHNZ8oKsePHsmVDyQNbR5
	ogpnD0g/i976BLf7M+bUmbnNMYLujnLHuut5cpk7Sk6a02PBInVO6ja9HUzxtI1VDpuMnON4ouI
	EV96ieZf24LciXKYfX1F2i+uHZzdxRB4=
X-Gm-Gg: ASbGncuJtj8JB3UAnaSF2graUAgeaz0ot+Y2+DMweJPDid5aZOvVOsuN4fOMYBaBt6J
	BfjMoi0VyYCSlZv4MekITr2cstKMvE4G/lDpH+vd6NNIN97bqsVXR1wKiTaOo8eUTRtPo6E6Ooo
	VLQcMCeqz64oP17V3wjvlw4VEdVn3iZ7u5PYXEdiyFMML100pa5IYpqw==
X-Google-Smtp-Source: AGHT+IFdllFX8rkahSEkryHNQ1kMbfnaYoBEBmDRqbmEjhfQ5DAUj6EID2O8WxJX3xTQ1BGCygdkE1iocLWDpZu4I5g=
X-Received: by 2002:a17:907:9408:b0:ade:316e:bfc with SMTP id
 a640c23a62f3a-ae34fdbb622mr1531075366b.21.1751348359428; Mon, 30 Jun 2025
 22:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org> <20250630-xattrat-syscall-v6-1-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-1-c4e3bc35227b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 1 Jul 2025 07:39:07 +0200
X-Gm-Features: Ac12FXw2tH2VJIc6JLDX7WkHZgUA2EFfA6JrulAZe_GN7OwvOmd3PgQ1fyjXNSk
Message-ID: <CAOQ4uxh0v84AGUX8s1EAgDv1fFPdN7pZBjPc7T=piNMQfU0HiA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] fs: split fileattr related helpers into separate file
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
> From: Andrey Albershteyn <aalbersh@kernel.org>
>
> This patch moves function related to file extended attributes
> manipulations to separate file. Refactoring only.
>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/Makefile              |   3 +-
>  fs/file_attr.c           | 318 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/ioctl.c               | 309 -----------------------------------------=
----
>  include/linux/fileattr.h |   4 +
>  4 files changed, 324 insertions(+), 310 deletions(-)
>
> diff --git a/fs/Makefile b/fs/Makefile
> index 79c08b914c47..334654f9584b 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -15,7 +15,8 @@ obj-y :=3D      open.o read_write.o file_table.o super.=
o \
>                 pnode.o splice.o sync.o utimes.o d_path.o \
>                 stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
>                 fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
> -               kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o
> +               kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o =
\
> +               file_attr.o
>
>  obj-$(CONFIG_BUFFER_HEAD)      +=3D buffer.o mpage.o
>  obj-$(CONFIG_PROC_FS)          +=3D proc_namespace.o
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> new file mode 100644
> index 000000000000..2910b7047721
> --- /dev/null
> +++ b/fs/file_attr.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/fs.h>
> +#include <linux/security.h>
> +#include <linux/fscrypt.h>
> +#include <linux/fileattr.h>
> +
> +/**
> + * fileattr_fill_xflags - initialize fileattr with xflags
> + * @fa:                fileattr pointer
> + * @xflags:    FS_XFLAG_* flags
> + *
> + * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> + * other fields are zeroed.
> + */
> +void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
> +{
> +       memset(fa, 0, sizeof(*fa));
> +       fa->fsx_valid =3D true;
> +       fa->fsx_xflags =3D xflags;
> +       if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> +               fa->flags |=3D FS_IMMUTABLE_FL;
> +       if (fa->fsx_xflags & FS_XFLAG_APPEND)
> +               fa->flags |=3D FS_APPEND_FL;
> +       if (fa->fsx_xflags & FS_XFLAG_SYNC)
> +               fa->flags |=3D FS_SYNC_FL;
> +       if (fa->fsx_xflags & FS_XFLAG_NOATIME)
> +               fa->flags |=3D FS_NOATIME_FL;
> +       if (fa->fsx_xflags & FS_XFLAG_NODUMP)
> +               fa->flags |=3D FS_NODUMP_FL;
> +       if (fa->fsx_xflags & FS_XFLAG_DAX)
> +               fa->flags |=3D FS_DAX_FL;
> +       if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
> +               fa->flags |=3D FS_PROJINHERIT_FL;
> +}
> +EXPORT_SYMBOL(fileattr_fill_xflags);
> +
> +/**
> + * fileattr_fill_flags - initialize fileattr with flags
> + * @fa:                fileattr pointer
> + * @flags:     FS_*_FL flags
> + *
> + * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> + * All other fields are zeroed.
> + */
> +void fileattr_fill_flags(struct fileattr *fa, u32 flags)
> +{
> +       memset(fa, 0, sizeof(*fa));
> +       fa->flags_valid =3D true;
> +       fa->flags =3D flags;
> +       if (fa->flags & FS_SYNC_FL)
> +               fa->fsx_xflags |=3D FS_XFLAG_SYNC;
> +       if (fa->flags & FS_IMMUTABLE_FL)
> +               fa->fsx_xflags |=3D FS_XFLAG_IMMUTABLE;
> +       if (fa->flags & FS_APPEND_FL)
> +               fa->fsx_xflags |=3D FS_XFLAG_APPEND;
> +       if (fa->flags & FS_NODUMP_FL)
> +               fa->fsx_xflags |=3D FS_XFLAG_NODUMP;
> +       if (fa->flags & FS_NOATIME_FL)
> +               fa->fsx_xflags |=3D FS_XFLAG_NOATIME;
> +       if (fa->flags & FS_DAX_FL)
> +               fa->fsx_xflags |=3D FS_XFLAG_DAX;
> +       if (fa->flags & FS_PROJINHERIT_FL)
> +               fa->fsx_xflags |=3D FS_XFLAG_PROJINHERIT;
> +}
> +EXPORT_SYMBOL(fileattr_fill_flags);
> +
> +/**
> + * vfs_fileattr_get - retrieve miscellaneous file attributes
> + * @dentry:    the object to retrieve from
> + * @fa:                fileattr pointer
> + *
> + * Call i_op->fileattr_get() callback, if exists.
> + *
> + * Return: 0 on success, or a negative error on failure.
> + */
> +int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +
> +       if (!inode->i_op->fileattr_get)
> +               return -ENOIOCTLCMD;
> +
> +       return inode->i_op->fileattr_get(dentry, fa);
> +}
> +EXPORT_SYMBOL(vfs_fileattr_get);
> +
> +/**
> + * copy_fsxattr_to_user - copy fsxattr to userspace.
> + * @fa:                fileattr pointer
> + * @ufa:       fsxattr user pointer
> + *
> + * Return: 0 on success, or -EFAULT on failure.
> + */
> +int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __use=
r *ufa)
> +{
> +       struct fsxattr xfa;
> +
> +       memset(&xfa, 0, sizeof(xfa));
> +       xfa.fsx_xflags =3D fa->fsx_xflags;
> +       xfa.fsx_extsize =3D fa->fsx_extsize;
> +       xfa.fsx_nextents =3D fa->fsx_nextents;
> +       xfa.fsx_projid =3D fa->fsx_projid;
> +       xfa.fsx_cowextsize =3D fa->fsx_cowextsize;
> +
> +       if (copy_to_user(ufa, &xfa, sizeof(xfa)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(copy_fsxattr_to_user);
> +
> +static int copy_fsxattr_from_user(struct fileattr *fa,
> +                                 struct fsxattr __user *ufa)
> +{
> +       struct fsxattr xfa;
> +
> +       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> +               return -EFAULT;
> +
> +       fileattr_fill_xflags(fa, xfa.fsx_xflags);
> +       fa->fsx_extsize =3D xfa.fsx_extsize;
> +       fa->fsx_nextents =3D xfa.fsx_nextents;
> +       fa->fsx_projid =3D xfa.fsx_projid;
> +       fa->fsx_cowextsize =3D xfa.fsx_cowextsize;
> +
> +       return 0;
> +}
> +
> +/*
> + * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values an=
d reject
> + * any invalid configurations.
> + *
> + * Note: must be called with inode lock held.
> + */
> +static int fileattr_set_prepare(struct inode *inode,
> +                             const struct fileattr *old_ma,
> +                             struct fileattr *fa)
> +{
> +       int err;
> +
> +       /*
> +        * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> +        * the relevant capability.
> +        */
> +       if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL=
) &&
> +           !capable(CAP_LINUX_IMMUTABLE))
> +               return -EPERM;
> +
> +       err =3D fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags)=
;
> +       if (err)
> +               return err;
> +
> +       /*
> +        * Project Quota ID state is only allowed to change from within t=
he init
> +        * namespace. Enforce that restriction only if we are trying to c=
hange
> +        * the quota ID state. Everything else is allowed in user namespa=
ces.
> +        */
> +       if (current_user_ns() !=3D &init_user_ns) {
> +               if (old_ma->fsx_projid !=3D fa->fsx_projid)
> +                       return -EINVAL;
> +               if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
> +                               FS_XFLAG_PROJINHERIT)
> +                       return -EINVAL;
> +       } else {
> +               /*
> +                * Caller is allowed to change the project ID. If it is b=
eing
> +                * changed, make sure that the new value is valid.
> +                */
> +               if (old_ma->fsx_projid !=3D fa->fsx_projid &&
> +                   !projid_valid(make_kprojid(&init_user_ns, fa->fsx_pro=
jid)))
> +                       return -EINVAL;
> +       }
> +
> +       /* Check extent size hints. */
> +       if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode=
))
> +               return -EINVAL;
> +
> +       if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> +                       !S_ISDIR(inode->i_mode))
> +               return -EINVAL;
> +
> +       if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> +           !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +               return -EINVAL;
> +
> +       /*
> +        * It is only valid to set the DAX flag on regular files and
> +        * directories on filesystems.
> +        */
> +       if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +           !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> +               return -EINVAL;
> +
> +       /* Extent size hints of zero turn off the flags. */
> +       if (fa->fsx_extsize =3D=3D 0)
> +               fa->fsx_xflags &=3D ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZIN=
HERIT);
> +       if (fa->fsx_cowextsize =3D=3D 0)
> +               fa->fsx_xflags &=3D ~FS_XFLAG_COWEXTSIZE;
> +
> +       return 0;
> +}
> +
> +/**
> + * vfs_fileattr_set - change miscellaneous file attributes
> + * @idmap:     idmap of the mount
> + * @dentry:    the object to change
> + * @fa:                fileattr pointer
> + *
> + * After verifying permissions, call i_op->fileattr_set() callback, if
> + * exists.
> + *
> + * Verifying attributes involves retrieving current attributes with
> + * i_op->fileattr_get(), this also allows initializing attributes that h=
ave
> + * not been set by the caller to current values.  Inode lock is held
> + * thoughout to prevent racing with another instance.
> + *
> + * Return: 0 on success, or a negative error on failure.
> + */
> +int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
> +                    struct fileattr *fa)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct fileattr old_ma =3D {};
> +       int err;
> +
> +       if (!inode->i_op->fileattr_set)
> +               return -ENOIOCTLCMD;
> +
> +       if (!inode_owner_or_capable(idmap, inode))
> +               return -EPERM;
> +
> +       inode_lock(inode);
> +       err =3D vfs_fileattr_get(dentry, &old_ma);
> +       if (!err) {
> +               /* initialize missing bits from old_ma */
> +               if (fa->flags_valid) {
> +                       fa->fsx_xflags |=3D old_ma.fsx_xflags & ~FS_XFLAG=
_COMMON;
> +                       fa->fsx_extsize =3D old_ma.fsx_extsize;
> +                       fa->fsx_nextents =3D old_ma.fsx_nextents;
> +                       fa->fsx_projid =3D old_ma.fsx_projid;
> +                       fa->fsx_cowextsize =3D old_ma.fsx_cowextsize;
> +               } else {
> +                       fa->flags |=3D old_ma.flags & ~FS_COMMON_FL;
> +               }
> +               err =3D fileattr_set_prepare(inode, &old_ma, fa);
> +               if (!err)
> +                       err =3D inode->i_op->fileattr_set(idmap, dentry, =
fa);
> +       }
> +       inode_unlock(inode);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL(vfs_fileattr_set);
> +
> +int ioctl_getflags(struct file *file, unsigned int __user *argp)
> +{
> +       struct fileattr fa =3D { .flags_valid =3D true }; /* hint only */
> +       int err;
> +
> +       err =3D vfs_fileattr_get(file->f_path.dentry, &fa);
> +       if (!err)
> +               err =3D put_user(fa.flags, argp);
> +       return err;
> +}
> +EXPORT_SYMBOL(ioctl_getflags);
> +
> +int ioctl_setflags(struct file *file, unsigned int __user *argp)
> +{
> +       struct mnt_idmap *idmap =3D file_mnt_idmap(file);
> +       struct dentry *dentry =3D file->f_path.dentry;
> +       struct fileattr fa;
> +       unsigned int flags;
> +       int err;
> +
> +       err =3D get_user(flags, argp);
> +       if (!err) {
> +               err =3D mnt_want_write_file(file);
> +               if (!err) {
> +                       fileattr_fill_flags(&fa, flags);
> +                       err =3D vfs_fileattr_set(idmap, dentry, &fa);
> +                       mnt_drop_write_file(file);
> +               }
> +       }
> +       return err;
> +}
> +EXPORT_SYMBOL(ioctl_setflags);
> +
> +int ioctl_fsgetxattr(struct file *file, void __user *argp)
> +{
> +       struct fileattr fa =3D { .fsx_valid =3D true }; /* hint only */
> +       int err;
> +
> +       err =3D vfs_fileattr_get(file->f_path.dentry, &fa);
> +       if (!err)
> +               err =3D copy_fsxattr_to_user(&fa, argp);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL(ioctl_fsgetxattr);
> +
> +int ioctl_fssetxattr(struct file *file, void __user *argp)
> +{
> +       struct mnt_idmap *idmap =3D file_mnt_idmap(file);
> +       struct dentry *dentry =3D file->f_path.dentry;
> +       struct fileattr fa;
> +       int err;
> +
> +       err =3D copy_fsxattr_from_user(&fa, argp);
> +       if (!err) {
> +               err =3D mnt_want_write_file(file);
> +               if (!err) {
> +                       err =3D vfs_fileattr_set(idmap, dentry, &fa);
> +                       mnt_drop_write_file(file);
> +               }
> +       }
> +       return err;
> +}
> +EXPORT_SYMBOL(ioctl_fssetxattr);
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 69107a245b4c..0248cb8db2d3 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -453,315 +453,6 @@ static int ioctl_file_dedupe_range(struct file *fil=
e,
>         return ret;
>  }
>
> -/**
> - * fileattr_fill_xflags - initialize fileattr with xflags
> - * @fa:                fileattr pointer
> - * @xflags:    FS_XFLAG_* flags
> - *
> - * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> - * other fields are zeroed.
> - */
> -void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
> -{
> -       memset(fa, 0, sizeof(*fa));
> -       fa->fsx_valid =3D true;
> -       fa->fsx_xflags =3D xflags;
> -       if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> -               fa->flags |=3D FS_IMMUTABLE_FL;
> -       if (fa->fsx_xflags & FS_XFLAG_APPEND)
> -               fa->flags |=3D FS_APPEND_FL;
> -       if (fa->fsx_xflags & FS_XFLAG_SYNC)
> -               fa->flags |=3D FS_SYNC_FL;
> -       if (fa->fsx_xflags & FS_XFLAG_NOATIME)
> -               fa->flags |=3D FS_NOATIME_FL;
> -       if (fa->fsx_xflags & FS_XFLAG_NODUMP)
> -               fa->flags |=3D FS_NODUMP_FL;
> -       if (fa->fsx_xflags & FS_XFLAG_DAX)
> -               fa->flags |=3D FS_DAX_FL;
> -       if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
> -               fa->flags |=3D FS_PROJINHERIT_FL;
> -}
> -EXPORT_SYMBOL(fileattr_fill_xflags);
> -
> -/**
> - * fileattr_fill_flags - initialize fileattr with flags
> - * @fa:                fileattr pointer
> - * @flags:     FS_*_FL flags
> - *
> - * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> - * All other fields are zeroed.
> - */
> -void fileattr_fill_flags(struct fileattr *fa, u32 flags)
> -{
> -       memset(fa, 0, sizeof(*fa));
> -       fa->flags_valid =3D true;
> -       fa->flags =3D flags;
> -       if (fa->flags & FS_SYNC_FL)
> -               fa->fsx_xflags |=3D FS_XFLAG_SYNC;
> -       if (fa->flags & FS_IMMUTABLE_FL)
> -               fa->fsx_xflags |=3D FS_XFLAG_IMMUTABLE;
> -       if (fa->flags & FS_APPEND_FL)
> -               fa->fsx_xflags |=3D FS_XFLAG_APPEND;
> -       if (fa->flags & FS_NODUMP_FL)
> -               fa->fsx_xflags |=3D FS_XFLAG_NODUMP;
> -       if (fa->flags & FS_NOATIME_FL)
> -               fa->fsx_xflags |=3D FS_XFLAG_NOATIME;
> -       if (fa->flags & FS_DAX_FL)
> -               fa->fsx_xflags |=3D FS_XFLAG_DAX;
> -       if (fa->flags & FS_PROJINHERIT_FL)
> -               fa->fsx_xflags |=3D FS_XFLAG_PROJINHERIT;
> -}
> -EXPORT_SYMBOL(fileattr_fill_flags);
> -
> -/**
> - * vfs_fileattr_get - retrieve miscellaneous file attributes
> - * @dentry:    the object to retrieve from
> - * @fa:                fileattr pointer
> - *
> - * Call i_op->fileattr_get() callback, if exists.
> - *
> - * Return: 0 on success, or a negative error on failure.
> - */
> -int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> -{
> -       struct inode *inode =3D d_inode(dentry);
> -
> -       if (!inode->i_op->fileattr_get)
> -               return -ENOIOCTLCMD;
> -
> -       return inode->i_op->fileattr_get(dentry, fa);
> -}
> -EXPORT_SYMBOL(vfs_fileattr_get);
> -
> -/**
> - * copy_fsxattr_to_user - copy fsxattr to userspace.
> - * @fa:                fileattr pointer
> - * @ufa:       fsxattr user pointer
> - *
> - * Return: 0 on success, or -EFAULT on failure.
> - */
> -int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __use=
r *ufa)
> -{
> -       struct fsxattr xfa;
> -
> -       memset(&xfa, 0, sizeof(xfa));
> -       xfa.fsx_xflags =3D fa->fsx_xflags;
> -       xfa.fsx_extsize =3D fa->fsx_extsize;
> -       xfa.fsx_nextents =3D fa->fsx_nextents;
> -       xfa.fsx_projid =3D fa->fsx_projid;
> -       xfa.fsx_cowextsize =3D fa->fsx_cowextsize;
> -
> -       if (copy_to_user(ufa, &xfa, sizeof(xfa)))
> -               return -EFAULT;
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL(copy_fsxattr_to_user);
> -
> -static int copy_fsxattr_from_user(struct fileattr *fa,
> -                                 struct fsxattr __user *ufa)
> -{
> -       struct fsxattr xfa;
> -
> -       if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> -               return -EFAULT;
> -
> -       fileattr_fill_xflags(fa, xfa.fsx_xflags);
> -       fa->fsx_extsize =3D xfa.fsx_extsize;
> -       fa->fsx_nextents =3D xfa.fsx_nextents;
> -       fa->fsx_projid =3D xfa.fsx_projid;
> -       fa->fsx_cowextsize =3D xfa.fsx_cowextsize;
> -
> -       return 0;
> -}
> -
> -/*
> - * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values an=
d reject
> - * any invalid configurations.
> - *
> - * Note: must be called with inode lock held.
> - */
> -static int fileattr_set_prepare(struct inode *inode,
> -                             const struct fileattr *old_ma,
> -                             struct fileattr *fa)
> -{
> -       int err;
> -
> -       /*
> -        * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> -        * the relevant capability.
> -        */
> -       if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL=
) &&
> -           !capable(CAP_LINUX_IMMUTABLE))
> -               return -EPERM;
> -
> -       err =3D fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags)=
;
> -       if (err)
> -               return err;
> -
> -       /*
> -        * Project Quota ID state is only allowed to change from within t=
he init
> -        * namespace. Enforce that restriction only if we are trying to c=
hange
> -        * the quota ID state. Everything else is allowed in user namespa=
ces.
> -        */
> -       if (current_user_ns() !=3D &init_user_ns) {
> -               if (old_ma->fsx_projid !=3D fa->fsx_projid)
> -                       return -EINVAL;
> -               if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
> -                               FS_XFLAG_PROJINHERIT)
> -                       return -EINVAL;
> -       } else {
> -               /*
> -                * Caller is allowed to change the project ID. If it is b=
eing
> -                * changed, make sure that the new value is valid.
> -                */
> -               if (old_ma->fsx_projid !=3D fa->fsx_projid &&
> -                   !projid_valid(make_kprojid(&init_user_ns, fa->fsx_pro=
jid)))
> -                       return -EINVAL;
> -       }
> -
> -       /* Check extent size hints. */
> -       if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode=
))
> -               return -EINVAL;
> -
> -       if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> -                       !S_ISDIR(inode->i_mode))
> -               return -EINVAL;
> -
> -       if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> -           !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> -               return -EINVAL;
> -
> -       /*
> -        * It is only valid to set the DAX flag on regular files and
> -        * directories on filesystems.
> -        */
> -       if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> -           !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> -               return -EINVAL;
> -
> -       /* Extent size hints of zero turn off the flags. */
> -       if (fa->fsx_extsize =3D=3D 0)
> -               fa->fsx_xflags &=3D ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZIN=
HERIT);
> -       if (fa->fsx_cowextsize =3D=3D 0)
> -               fa->fsx_xflags &=3D ~FS_XFLAG_COWEXTSIZE;
> -
> -       return 0;
> -}
> -
> -/**
> - * vfs_fileattr_set - change miscellaneous file attributes
> - * @idmap:     idmap of the mount
> - * @dentry:    the object to change
> - * @fa:                fileattr pointer
> - *
> - * After verifying permissions, call i_op->fileattr_set() callback, if
> - * exists.
> - *
> - * Verifying attributes involves retrieving current attributes with
> - * i_op->fileattr_get(), this also allows initializing attributes that h=
ave
> - * not been set by the caller to current values.  Inode lock is held
> - * thoughout to prevent racing with another instance.
> - *
> - * Return: 0 on success, or a negative error on failure.
> - */
> -int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
> -                    struct fileattr *fa)
> -{
> -       struct inode *inode =3D d_inode(dentry);
> -       struct fileattr old_ma =3D {};
> -       int err;
> -
> -       if (!inode->i_op->fileattr_set)
> -               return -ENOIOCTLCMD;
> -
> -       if (!inode_owner_or_capable(idmap, inode))
> -               return -EPERM;
> -
> -       inode_lock(inode);
> -       err =3D vfs_fileattr_get(dentry, &old_ma);
> -       if (!err) {
> -               /* initialize missing bits from old_ma */
> -               if (fa->flags_valid) {
> -                       fa->fsx_xflags |=3D old_ma.fsx_xflags & ~FS_XFLAG=
_COMMON;
> -                       fa->fsx_extsize =3D old_ma.fsx_extsize;
> -                       fa->fsx_nextents =3D old_ma.fsx_nextents;
> -                       fa->fsx_projid =3D old_ma.fsx_projid;
> -                       fa->fsx_cowextsize =3D old_ma.fsx_cowextsize;
> -               } else {
> -                       fa->flags |=3D old_ma.flags & ~FS_COMMON_FL;
> -               }
> -               err =3D fileattr_set_prepare(inode, &old_ma, fa);
> -               if (!err)
> -                       err =3D inode->i_op->fileattr_set(idmap, dentry, =
fa);
> -       }
> -       inode_unlock(inode);
> -
> -       return err;
> -}
> -EXPORT_SYMBOL(vfs_fileattr_set);
> -
> -static int ioctl_getflags(struct file *file, unsigned int __user *argp)
> -{
> -       struct fileattr fa =3D { .flags_valid =3D true }; /* hint only */
> -       int err;
> -
> -       err =3D vfs_fileattr_get(file->f_path.dentry, &fa);
> -       if (!err)
> -               err =3D put_user(fa.flags, argp);
> -       return err;
> -}
> -
> -static int ioctl_setflags(struct file *file, unsigned int __user *argp)
> -{
> -       struct mnt_idmap *idmap =3D file_mnt_idmap(file);
> -       struct dentry *dentry =3D file->f_path.dentry;
> -       struct fileattr fa;
> -       unsigned int flags;
> -       int err;
> -
> -       err =3D get_user(flags, argp);
> -       if (!err) {
> -               err =3D mnt_want_write_file(file);
> -               if (!err) {
> -                       fileattr_fill_flags(&fa, flags);
> -                       err =3D vfs_fileattr_set(idmap, dentry, &fa);
> -                       mnt_drop_write_file(file);
> -               }
> -       }
> -       return err;
> -}
> -
> -static int ioctl_fsgetxattr(struct file *file, void __user *argp)
> -{
> -       struct fileattr fa =3D { .fsx_valid =3D true }; /* hint only */
> -       int err;
> -
> -       err =3D vfs_fileattr_get(file->f_path.dentry, &fa);
> -       if (!err)
> -               err =3D copy_fsxattr_to_user(&fa, argp);
> -
> -       return err;
> -}
> -
> -static int ioctl_fssetxattr(struct file *file, void __user *argp)
> -{
> -       struct mnt_idmap *idmap =3D file_mnt_idmap(file);
> -       struct dentry *dentry =3D file->f_path.dentry;
> -       struct fileattr fa;
> -       int err;
> -
> -       err =3D copy_fsxattr_from_user(&fa, argp);
> -       if (!err) {
> -               err =3D mnt_want_write_file(file);
> -               if (!err) {
> -                       err =3D vfs_fileattr_set(idmap, dentry, &fa);
> -                       mnt_drop_write_file(file);
> -               }
> -       }
> -       return err;
> -}
> -
>  static int ioctl_getfsuuid(struct file *file, void __user *argp)
>  {
>         struct super_block *sb =3D file_inode(file)->i_sb;
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 47c05a9851d0..6030d0bf7ad3 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -55,5 +55,9 @@ static inline bool fileattr_has_fsx(const struct fileat=
tr *fa)
>  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
>  int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>                      struct fileattr *fa);
> +int ioctl_getflags(struct file *file, unsigned int __user *argp);
> +int ioctl_setflags(struct file *file, unsigned int __user *argp);
> +int ioctl_fsgetxattr(struct file *file, void __user *argp);
> +int ioctl_fssetxattr(struct file *file, void __user *argp);
>
>  #endif /* _LINUX_FILEATTR_H */
>
> --
> 2.47.2
>

