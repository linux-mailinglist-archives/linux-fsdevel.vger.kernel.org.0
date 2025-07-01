Return-Path: <linux-fsdevel+bounces-53416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8716AEEE60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE083AF5BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0082459C5;
	Tue,  1 Jul 2025 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iapz9K7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B618DB27;
	Tue,  1 Jul 2025 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751350308; cv=none; b=ArDv4Eu9K7i4iH4WUIidFyH17iQ1jGgfx9zyNll37hhHdEOOghIVxkVD7+aMaYuCo68qw4oiOf0710zMdPMAqcNCikdmh8yNXVaHJDvuJjs5pKpnt12cFpSW5vepNQN6fQLuvt7p9aiCKatqL5XnOpapd1YT2/09X7+TdQVlAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751350308; c=relaxed/simple;
	bh=n2dl/8a7llNIU/OodNwWqanLy/3qmsHLyKdFTD18JgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMLBjsWjgOhxy/X1a/nhXD7nKgNYhrMHSwX5CeJv2zzpPwK2GJGzavnq6q62h102RNqLp28zoKzJ2oWmRzw8zfAqfLtWIl/qgPv9ubH78BmM0gofUDQzlKk8k9PHnvf4seLsnKrSyHvmHkdNrY5tCPAgMdlcv95By6eVmogB4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iapz9K7K; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae361e8ec32so674117866b.3;
        Mon, 30 Jun 2025 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751350305; x=1751955105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/S7xKhKUEdY/AyCleM182IPYw8qNSHgtzf/4Oaf5ZUo=;
        b=Iapz9K7KcnFVEzr8IkbPaqLm3dnoNvo1fmZv01CznYOXbnSoeqdKWpiADFOY130lAG
         RYDNH92PWzs4lEuHkQu557eZDyOQ2DOQGlriOcHnBRDRvg3c8t7MG3r++T9/5LOGSgOV
         aqOaJdkZtT+1CNTiUuWulC6zatu4WRGATmJqalcVE3gLjBMCshXY0X++O1StI7kjVWmW
         LYJogvr944HgVOn3DtCQFpIkV8/gudvQNWCYFvVbdQlDdpdQq3NQbxKjzWXxCvOMc0fM
         8lB3RRo9/U5se1K00974XxU7TPylnYhyj9IAxv0YKKmQx8ffc+hpIO9A3Vx/TsevgrPA
         2Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751350305; x=1751955105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S7xKhKUEdY/AyCleM182IPYw8qNSHgtzf/4Oaf5ZUo=;
        b=d+1G0e7OI40N1QBl8ZLQxp8VY01DCCorC6L6trRHf6C6AEVWYVETMQCqeLasLecD4H
         +h5LwXmHb5bZ237TUHX6p9Sl+X03i8SkbltsSt9FIBM4orSq5pRPitQxUdirkthBg7+h
         hdkiaEWG6FIdw12vhHjH+EUpr37uj735TMiq1J4zkLl0DSuPzyDyNnZRTsHX8LlIm3Vm
         n5m0lQHi+WyD0jmx7xeudpu8rEiYKPkxvheJOcgwNU9qt2O7WInFZsesJTWpGMGw98ul
         0oGQO1YF08QuU0rfvtao4WqNolSlN8Tl57Lr8kzUWx3MbxzwMrbHWp+U+tbEHJgYPOGR
         HPvg==
X-Forwarded-Encrypted: i=1; AJvYcCVf+JraJah0QDu9YBk7fUzUXeYV9kv9kn7Cg29M7begsKTqv+LV306UdPSV+4tdZ3IA2n1GY28pNoFR@vger.kernel.org, AJvYcCWa5ltKWrZsJPEG6NsV/uRO4MLiUk+19S74FV19bpY6W7FlB09e1i9AkChoDi/qOWsMYpbWzjUbx04=@vger.kernel.org, AJvYcCWlrqy658vgX/mJIhhQHHb2lbPw73DsW52/bdIifQeIFzPLTu4FNbWZpl++GszuYCxIMmlZW0+YHoTghBOv9w==@vger.kernel.org, AJvYcCWqg63N8WJ98lafKhYRz+oJOQbAM70b+0gKUGeR+OYpmcgHeXDU+iEQ3UUzBzp3arQqI+J9DyhEcunDUTER@vger.kernel.org, AJvYcCX1cMD/Uo7A8sVq9YKIF/xc3B9p0aDSxWy4HKQIVNROMN68VZTwjtVGbC0OFQMYgm3GmFmI0hUJMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXu/s9VbM3GxSbnekL79zOwXt21hbiMIFXkQAHtIQE2yXG7rg
	AeRf9Pb2RULt2bI3YWaRFc1lEJOS08Anxq+wejYMDk2vEZrjwUWSzJcuKRmM+VvR9rUhq646bUb
	4SFc/FISFWK7ukQKImK4nj5Bmut651PQ=
X-Gm-Gg: ASbGncvLUyfpppyb8Ss9ia4q/ily/Om0ViLyjLgPzCkZpsHaytL8Fnba5veHETuBTXC
	gRm8rcmO2i9IUcBenaC2I68G7KO2xmE14lJcTGephAO2/yWUXc+p1AZgubzF2TfNCm09tUGO43Y
	MO9yo0Vv6GFKBGVfWLhnLIx4YE0nyCefkIROdU9FaSZAI=
X-Google-Smtp-Source: AGHT+IGy0jqNDqIw+R0AspukOFhh0zQZqG8vgG9Cye+LYJ84zh+3r3d6fSa8S3xkKlvRzSPIM/XgMRb4dD/PnbOmYK4=
X-Received: by 2002:a17:907:728e:b0:add:ede0:b9d4 with SMTP id
 a640c23a62f3a-ae34fb41ad9mr1497620366b.0.1751350304536; Mon, 30 Jun 2025
 23:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 1 Jul 2025 08:11:33 +0200
X-Gm-Features: Ac12FXxCo_XqKi1DpO_nF_8Ztxb-HD2hD0sbrXROo0RZf5-pz3YZZ2U-IPVQT7g
Message-ID: <CAOQ4uxgEK7zQFBTmg1cK=LWfBmZk7FhceHjJROP0RWP00--Tvg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] fs: introduce file_getattr and file_setattr syscalls
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
> This patchset introduced two new syscalls file_getattr() and
> file_setattr(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> except they use *at() semantics. Therefore, there's no need to open the
> file to get a fd.
>
> These syscalls allow userspace to set filesystem inode attributes on
> special files. One of the usage examples is XFS quota projects.
>
> XFS has project quotas which could be attached to a directory. All
> new inodes in these directories inherit project ID set on parent
> directory.
>
> The project is created from userspace by opening and calling
> FS_IOC_FSSETXATTR on each inode. This is not possible for special
> files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> with empty project ID. Those inodes then are not shown in the quota
> accounting but still exist in the directory. This is not critical but in
> the case when special files are created in the directory with already
> existing project quota, these new inodes inherit extended attributes.
> This creates a mix of special files with and without attributes.
> Moreover, special files with attributes don't have a possibility to
> become clear or change the attributes. This, in turn, prevents userspace
> from re-creating quota project on these existing files.
>
> An xfstests test generic/766 with basic coverage is at:
> https://github.com/alberand/xfstests/commits/b4/file-attr/
>
> NAME
>
>         file_getattr/file_setattr - get/set filesystem inode attributes
>
> SYNOPSIS
>
>         #include <sys/syscall.h>    /* Definition of SYS_* constants */
>         #include <unistd.h>
>
>         long syscall(SYS_file_getattr, int dirfd, const char *pathname,
>                 struct fsx_fileattr *fsx, size_t size,
>                 unsigned int at_flags);
>         long syscall(SYS_file_setattr, int dirfd, const char *pathname,
>                 struct fsx_fileattr *fsx, size_t size,
>                 unsigned int at_flags);
>
>         Note: glibc doesn't provide for file_getattr()/file_setattr(),
>         use syscall(2) instead.
>
> DESCRIPTION
>
>         The file_getattr()/file_setattr() are used to set extended file
>         attributes. These syscalls take dirfd in conjunction with the
>         pathname argument. The syscall then operates on inode opened
>         according to openat(2) semantics.
>
>         This is an alternative to FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR
>         ioctl with a difference that file don't need to be open as file
>         can be referenced with a path instead of fd. By having this one
>         can manipulated filesystem inode attributes not only on regular
>         files but also on special ones. This is not possible with
>         FS_IOC_FSSETXATTR ioctl as ioctl() can not be called on special
>         files directly for the filesystem inode.
>
>         at_flags can be set to AT_SYMLINK_NOFOLLOW or AT_EMPTY_PATH.
>
> RETURN VALUE
>
>         On success, 0 is returned.  On error, -1 is returned, and errno
>         is set to indicate the error.
>
> ERRORS
>
>         EINVAL          Invalid at_flag specified (only
>                         AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH is
>                         supported).
>
>         EINVAL          Size was smaller than any known version of
>                         struct fsx_fileattr.
>
>         EINVAL          Invalid combination of parameters provided in
>                         fsx_fileattr for this type of file.
>
>         E2BIG           Size of input argument struct fsx_fileattr
>                         is too big.
>
>         EBADF           Invalid file descriptor was provided.
>
>         EPERM           No permission to change this file.
>
>         EOPNOTSUPP      Filesystem does not support setting attributes
>                         on this type of inode
>
> HISTORY
>
>         Added in Linux 6.16.
>
> EXAMPLE
>
> Create directory and file "mkdir ./dir && touch ./dir/foo" and then
> execute the following program:
>
>         #include <fcntl.h>
>         #include <errno.h>
>         #include <string.h>
>         #include <linux/fs.h>
>         #include <stdio.h>
>         #include <sys/syscall.h>
>         #include <unistd.h>
>
>         #if !defined(SYS_file_getattr) && defined(__x86_64__)
>         #define SYS_file_getattr 468
>         #define SYS_file_setattr 469
>
>         struct fsx_fileattr {
>                __u32           fsx_xflags;
>                __u32           fsx_extsize;
>                __u32           fsx_nextents;
>                __u32           fsx_projid;
>                __u32           fsx_cowextsize;
>         };
>         #endif
>
>         int
>         main(int argc, char **argv) {
>                 int dfd;
>                 int error;
>                 struct fsx_fileattr fsx;
>
>                 dfd =3D open("./dir", O_RDONLY);
>                 if (dfd =3D=3D -1) {
>                         printf("can not open ./dir");
>                         return dfd;
>                 }
>
>                 error =3D syscall(SYS_file_getattr, dfd, "./foo", &fsx,
>                                 sizeof(struct fsx_fileattr), 0);
>                 if (error) {
>                         printf("can not call SYS_file_getattr: %s",
>                                 strerror(errno));
>                         return error;
>                 }
>
>                 printf("./dir/foo flags: %d\n", fsx.fsx_xflags);
>
>                 fsx.fsx_xflags |=3D FS_XFLAG_NODUMP;
>                 error =3D syscall(SYS_file_setattr, dfd, "./foo", &fsx,
>                                 sizeof(struct fsx_fileattr), 0);
>                 if (error) {
>                         printf("can not call SYS_file_setattr: %s",
>                                 strerror(errno));
>                         return error;
>                 }
>
>                 printf("./dir/foo flags: %d\n", fsx.fsx_xflags);
>
>                 return error;
>         }
>
> SEE ALSO
>
>         ioctl(2), ioctl_iflags(2), ioctl_xfs_fsgetxattr(2), openat(2)
>
> ---
> Changes in v6:
> - Update cover letter example and docs
> - Applied __free() attribute for syscall stack objects
> - Introduced struct fsx_fileattr
> - Replace 'struct fsxattr' with 'struct fsx_fileattr'
> - Add helper to fill in fsx_fileattr from fileattr
> - Dropped copy_fsx_to_user() header declaration
> - Link to v5: https://lore.kernel.org/r/20250513-xattrat-syscall-v5-0-22b=
b9c6c767f@kernel.org
>

Series looks good.
For mine and Pali's minor comments on patch 4 no need to resend.
I think they could be fixed on commit.

Thanks,
Amir.

> Changes in v5:
> - Remove setting of LOOKUP_EMPTY flags which does not have any effect
> - Return -ENOSUPP from vfs_fileattr_set()
> - Add fsxattr masking (by Amir)
> - Fix UAF issue dentry
> - Fix getname_maybe_null() issue with NULL path
> - Implement file_getattr/file_setattr hooks
> - Return LSM return code from file_setattr
> - Rename from getfsxattrat/setfsxattrat to file_getattr/file_setattr
> - Link to v4: https://lore.kernel.org/r/20250321-xattrat-syscall-v4-0-3e8=
2e6fb3264@kernel.org
>
> Changes in v4:
> - Use getname_maybe_null() for correct handling of dfd + path semantic
> - Remove restriction for special files on which flags are allowed
> - Utilize copy_struct_from_user() for better future compatibility
> - Add draft man page to cover letter
> - Convert -ENOIOCTLCMD to -EOPNOSUPP as more appropriate for syscall
> - Add missing __user to header declaration of syscalls
> - Link to v3: https://lore.kernel.org/r/20250211-xattrat-syscall-v3-1-a07=
d15f898b2@kernel.org
>
> Changes in v3:
> - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> - Remove unnecessary "same filesystem" check
> - Use CLASS() instead of directly calling fdget/fdput
> - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b3=
60d4fbcb2@kernel.org
>
> v1:
> https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@ker=
nel.org/
>
> Previous discussion:
> https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat=
.com/
>
> ---
> Amir Goldstein (1):
>       fs: prepare for extending file_get/setattr()
>
> Andrey Albershteyn (5):
>       fs: split fileattr related helpers into separate file
>       lsm: introduce new hooks for setting/getting inode fsxattr
>       selinux: implement inode_file_[g|s]etattr hooks
>       fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
>       fs: introduce file_getattr and file_setattr syscalls
>
>  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
>  arch/arm/tools/syscall.tbl                  |   2 +
>  arch/arm64/tools/syscall_32.tbl             |   2 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
>  fs/Makefile                                 |   3 +-
>  fs/ecryptfs/inode.c                         |   8 +-
>  fs/file_attr.c                              | 493 ++++++++++++++++++++++=
++++++
>  fs/ioctl.c                                  | 309 -----------------
>  fs/overlayfs/inode.c                        |   2 +-
>  include/linux/fileattr.h                    |  24 ++
>  include/linux/lsm_hook_defs.h               |   2 +
>  include/linux/security.h                    |  16 +
>  include/linux/syscalls.h                    |   6 +
>  include/uapi/asm-generic/unistd.h           |   8 +-
>  include/uapi/linux/fs.h                     |  18 +
>  scripts/syscall.tbl                         |   2 +
>  security/security.c                         |  30 ++
>  security/selinux/hooks.c                    |  14 +
>  30 files changed, 654 insertions(+), 313 deletions(-)
> ---
> base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af
> change-id: 20250114-xattrat-syscall-6a1136d2db59
>
> Best regards,
> --
> Andrey Albershteyn <aalbersh@kernel.org>
>

