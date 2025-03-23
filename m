Return-Path: <linux-fsdevel+bounces-44825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC65A6CE65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 09:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F7116BD49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 08:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD4202F70;
	Sun, 23 Mar 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAAfNB21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCF48CFC;
	Sun, 23 Mar 2025 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742719521; cv=none; b=A58PE9VYCoNHfmvXNTxYKCSbW1L2VYXZrES1lfoz3MMuLqBPP12ww2Dn2K+jzNSZqHn0dKDCc1koovdK7CopcWczofGUzJnzd4A8t8miD/ax9yaaFPDx1anCDzcKJaSvHaFv1p5240uYfstXGSRO3tqEs5UwsHn4taqWY6Dv3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742719521; c=relaxed/simple;
	bh=b7msV9pgJYlhEyRge9PfEcB6ipwT555t51j3Jg4i4JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zg92qAbM6MpvfuCxFzKyzi17WxBU8UloE4FnwEEpFDkj78OY6CHkgE1O/PSWZ2RpkHDpW4AMt+GwaW0oupyjGwA1WryFOUkXY4KSpNi3qk/Y+qJxDPjYgqS8bJZ6IZK+S4YWdCcoye7xWvqQChlBjEVgJ2qapDxYQP8flRkhz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAAfNB21; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so6317781a12.0;
        Sun, 23 Mar 2025 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742719517; x=1743324317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jxIP2TIUbDJlhhIEkW541D6lu1Z7/8FzD6NZfb9i/w=;
        b=WAAfNB216UMy7CKSShnqnY+mjW47ObBF+cghNpRQlgyFL0J+F21tXzfwjW9UxT6TL6
         wT9iJxH3qzPBcVIpgvX0QHyO0bBNz87otlgPCR+NqYgtFTegDt4Ieq8rURLTkA0WeOFe
         NZPijf0zeYuSEsT/X13oSBH3J4Dq06CD0LXPgSN00o6uAwH9JAS7ucPTwKLp1dstf7XR
         KHNeu+FSM63XJ+KuX5hzs7GB2Fr9U9YrKjfqvR+Ivaj3zzs98QTH+bfSmZoWmsWWV9na
         2K4Z6aXu2eQhOBtHxI0dAFZJnSUFVSDAOQ7tqICcxXuYO96D1eac0kix2P9NkrSVYLwB
         A48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742719517; x=1743324317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jxIP2TIUbDJlhhIEkW541D6lu1Z7/8FzD6NZfb9i/w=;
        b=YTJF+jOSM+HsPv0QJp8otAA9lOsf7p68SwsdEBqAFzZQ8BjWoA7VlLLdlJyC2FTb8k
         aa+M5trHjKFi1Zivz0sVif2jlWuLo398YkUv5KWD5jbTa0/POLUSyXeph/vP8EQ5qq4k
         8a5vt3ISiVgsSwulUbpBN2JUSlLnPhIx4LcUIU+bI3DxSk+TQVuBZhg2Zf9kq2BKPL7w
         2LscRJQkY+lZl6mkcrDmypnJFq0NU/gEWzvzVM/5s5dutc/9Ng1RRWaiIATtTOYM7cBY
         IprrjP7qA0sqrRK3cIjH3o5kP6AJ7YBwsGUAlbQliEEHvMwbUP5bJzx2SFXhwG6l/PWv
         1IBw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ttjF/xWrM+HlJPtQmvjQuPxvbZ3VkcgivhLZdfoSjk99/KjDv7IEtFJRn0gNqVEyD15a9glRztD1RKkYCL90iJ4Ky8i9@vger.kernel.org, AJvYcCUAnZSPSH4D4Q5PFZS1IyMx0s+aWKxblKVi4arAZC8E2JAmg9LytzMkCG3RYPSjI0iah5ZijrtUk3v+8g==@vger.kernel.org, AJvYcCULdxeqkdoYqiSHYnyCDjYeUMQ2hZOn27F4+lFKgYQUxYgckWucW3QXGnbuy6nAOLjaVBvP76SncWQ=@vger.kernel.org, AJvYcCUQ4cluKDU/Vk5im62fIJrsECSddB72Q6WuiR8VsXQc5NqeLDLSnILxjONBoO04Wjt6Nl9D9wn3cNmoQg==@vger.kernel.org, AJvYcCUXw7D9MA0V1jmqlCJe1nGuCYo2IOQofO/K6nSkPqw255rtroF5UVvrLj62u0CK2qOgRZZUBlNVu5iPBSh0@vger.kernel.org, AJvYcCUZaooI7mSenRN9gwZirHX1jo8JwiuIEyF0aOL9DaxhsP9ZhPiwcKzNfQx4ILgrnU5VwRoYzsfZ2CzmRA==@vger.kernel.org, AJvYcCUbIcjpa0DmDLasACLEYNeKBdP1i5eK1goIuNMDLjAlJyHvGhYz02+VKlwoyceVSb7MgH5X4ikKESuflIhX@vger.kernel.org, AJvYcCWL9fFQsleDgCCko7RnjWXOb3ZvyJ7ho5/lF/zPGAHw9NJMrat8dVrg1GGRIQIJ3gBQanNvRcsOag==@vger.kernel.org, AJvYcCWM/yrdkyhAJyOw65kJVfjvANvbVDKr6CyY/KszL+Pq0u6vV7LaypAUneNyI6M/XqY1lA399aP6doyf@vger.kernel.org, AJvYcCWdfrjdarAL
 IaXl2JMPt153iZnju5AbuM68rtbArvdwQBuPgKeGMRfc6aU0MZcyseH+VYysmF1sSTOw@vger.kernel.org, AJvYcCXP/nMWmU2tIxm7JfJnM2waQVp+E0toS3QjzYIdNCtrZeMK9HDTgUmLRMCnwuy7V8RAiJo1P+BnAr4bmg==@vger.kernel.org, AJvYcCXp2RYc7nUUiNFaO95rW/EDYOtGEwdUgWuMTbFosrHJMlbNppU+lSJ+ORjXxvALRqd5cMSDeNsfCt7MBw==@vger.kernel.org, AJvYcCXwrXGrI33v4dT8PARvYeQ+FV5BCgUXevqqajr1i0ZgseLncByRV/FvFVfS1bshwAeO3LZYIYrRjALY6ZNHHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaomk2nfLx+0x3p30ej185JpUWGnEvZBFbQoqwt+Aa70Kl1U2
	2+TA6AY86Y7XkUw6VmdCgOi+oOGJl4q6Pj1RCoaPOEzphzFYWOr6OA25l0QEEdNwlfHaGccqLhv
	BjAKkGVe2fTrH4r9uiyFD578M818=
X-Gm-Gg: ASbGncuC6hUmK5HAqANgVa6OC1mOIE6AiVyy8TCmlUQ7ZLPnhxO+gcSWluHVQmbVvm/
	DwGzAoaKkldfaAFXUby/pGL82wFSnCkdbCZ8uXYXaDmYtogRNS82GlT3tw2BqQb37ptBjW31lmW
	s8Nfc/vriGzubd8Dx85BXaV0SLwH+x0VAjReS903my5GP9wrClIyzxhKrRSH4=
X-Google-Smtp-Source: AGHT+IGKn4NZALUSEG+rHMaGWglZZduHpRclHK5w+Kv4NN031fphTZKyVC6h710/5c6HAafbvHO3fjsZw2YzDAeWHLw=
X-Received: by 2002:a05:6402:42c9:b0:5e5:854d:4d17 with SMTP id
 4fb4d7f45d1cf-5eb9a017821mr12555025a12.11.1742719516454; Sun, 23 Mar 2025
 01:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
In-Reply-To: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 23 Mar 2025 09:45:06 +0100
X-Gm-Features: AQ5f1JqljvGQqYT8xQtG-jZ8bGx-mNtzX8tKytu1uegIaEXtua4XQMAbrGMEflk
Message-ID: <CAOQ4uxjQDUg8HFG+mSxMkR54zen7nC2jttzOKqh13Bx-uosh3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: introduce getfsxattrat and setfsxattrat syscalls
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, selinux@vger.kernel.org, 
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 8:50=E2=80=AFPM Andrey Albershteyn <aalbersh@redhat=
.com> wrote:
>
> This patchset introduced two new syscalls getfsxattrat() and
> setfsxattrat(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> except they use *at() semantics. Therefore, there's no need to open the
> file to get an fd.
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
> Christian, if this get in some mergeable state, please don't merge it
> yet. Amir suggested these syscalls better to use updated struct fsxattr
> with masking from Pali Roh=C3=A1r patchset, so, let's see how it goes.

Andrey,

To be honest I don't think it would be fair to delay your syscalls more
than needed.

If Pali can follow through and post patches on top of your syscalls for
next merge window that would be great, but otherwise, I think the
minimum requirement is that the syscalls return EINVAL if fsx_pad
is not zero. we can take it from there later.

We can always also increase the size of struct fsxattr, but let's first
use the padding space already available.

Thanks,
Amir.

>
> NAME
>
>         getfsxattrat/setfsxattrat - get/set filesystem inode attributes
>
> SYNOPSIS
>
>         #include <sys/syscall.h>    /* Definition of SYS_* constants */
>         #include <unistd.h>
>
>         long syscall(SYS_getfsxattrat, int dirfd, const char *pathname,
>                 struct fsxattr *fsx, size_t size,
>                 unsigned int at_flags);
>         long syscall(SYS_setfsxattrat, int dirfd, const char *pathname,
>                 struct fsxattr *fsx, size_t size,
>                 unsigned int at_flags);
>
>         Note: glibc doesn't provide for getfsxattrat()/setfsxattrat(),
>         use syscall(2) instead.
>
> DESCRIPTION
>
>         The syscalls take fd and path to the child together with struct
>         fsxattr. If path is absolute, fd is not used. If path is empty,
>         inode under fd is used to get/set attributes on.
>
>         This is an alternative to FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR
>         ioctl with a difference that file don't need to be open as we
>         can reference it with a path instead of fd. By having this we
>         can manipulated filesystem inode attributes not only on regular
>         files but also on special ones. This is not possible with
>         FS_IOC_FSSETXATTR ioctl as with special files we can not call
>         ioctl() directly on the filesystem inode using file descriptor.
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
>                         struct fsxattr.
>
>         EINVAL          Invalid combination of parameters provided in
>                         fsxattr for this type of file.
>
>         E2BIG           Size of input argument **struct fsxattr** is too
>                         big.
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
>         Added in Linux 6.14.
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
>         int
>         main(int argc, char **argv) {
>                 int dfd;
>                 int error;
>                 struct fsxattr fsx;
>
>                 dfd =3D open("./dir", O_RDONLY);
>                 if (dfd =3D=3D -1) {
>                         printf("can not open ./dir");
>                         return dfd;
>                 }
>
>                 error =3D syscall(467, dfd, "./foo", &fsx, 0);
>                 if (error) {
>                         printf("can not call 467: %s", strerror(errno));
>                         return error;
>                 }
>
>                 printf("dir/foo flags: %d\n", fsx.fsx_xflags);
>
>                 fsx.fsx_xflags |=3D FS_XFLAG_NODUMP;
>                 error =3D syscall(468, dfd, "./foo", &fsx, 0);
>                 if (error) {
>                         printf("can not call 468: %s", strerror(errno));
>                         return error;
>                 }
>
>                 printf("dir/foo flags: %d\n", fsx.fsx_xflags);
>
>                 return error;
>         }
>
> SEE ALSO
>
>         ioctl(2), ioctl_iflags(2), ioctl_xfs_fsgetxattr(2)
>
> ---
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
> Andrey Albershteyn (3):
>       lsm: introduce new hooks for setting/getting inode fsxattr
>       fs: split fileattr/fsxattr converters into helpers
>       fs: introduce getfsxattrat and setfsxattrat syscalls
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
>  fs/inode.c                                  | 130 ++++++++++++++++++++++=
++++++
>  fs/ioctl.c                                  |  39 ++++++---
>  include/linux/fileattr.h                    |   2 +
>  include/linux/lsm_hook_defs.h               |   4 +
>  include/linux/security.h                    |  16 ++++
>  include/linux/syscalls.h                    |   6 ++
>  include/uapi/asm-generic/unistd.h           |   8 +-
>  include/uapi/linux/fs.h                     |   3 +
>  security/security.c                         |  32 +++++++
>  25 files changed, 259 insertions(+), 13 deletions(-)
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250114-xattrat-syscall-6a1136d2db59
>
> Best regards,
> --
> Andrey Albershteyn <aalbersh@kernel.org>
>
>

