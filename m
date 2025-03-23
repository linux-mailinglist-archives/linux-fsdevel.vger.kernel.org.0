Return-Path: <linux-fsdevel+bounces-44827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463DA6CEC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 11:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A51516F5AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 10:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F5204C1E;
	Sun, 23 Mar 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAbd7AT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C8202C31;
	Sun, 23 Mar 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725970; cv=none; b=ZUduXTbo7p6KAQJNq9giAn3IqMTjbFNlDjCVZGGSeh7lIzfciBRgo0vir0vaD3IiAMdbJtRBs5rpurp4WBIUTJfDUJVAt3Tv+zdooVMb/MzUGcWEOF9VokFEFaswZXs0yzqSZ54cVGFDMQtWyS55RvH15uNtoteUT2zM1Pnv1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725970; c=relaxed/simple;
	bh=22IN0QCxwLGn5bz1ZuEjWluuK6xzFnnzFoh8o64RIEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwp52Z0UVzWHvVyPX986hluAhneOwRsc8czfJcP1Xhb57I5m5lmKIK7V6etunO10jEMs64TIydaFd/xiINAa3xr7Xqg61mEcVFiDQEj/9ADOjozx5UbAqSZzksSadZV7uerBttBlCSUDLriy8QfyGUSDMNVqjVKsVjasnzolBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAbd7AT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C78C4CEEA;
	Sun, 23 Mar 2025 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742725970;
	bh=22IN0QCxwLGn5bz1ZuEjWluuK6xzFnnzFoh8o64RIEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAbd7AT3HTEufIBq7Y/BHCtHUyO6C5+vfu3hHINcSwZrvjvYPGc+DMZUpYzvZq5HM
	 P8FcJ7W8e7MHHIG+18pKes7wb/LHdtGp53ICPBxBiwe1cJmBmvQ9SM4dYmxa21ct+l
	 bDC8jknBMPn9kJAY/TwdYqb7pwUoE8R7T5YdzECI8eqFK2Xe5jTSZ8nFoDJofZiFiM
	 d5CUi8s5Za7RqyGgDhHGuiFdSeCDUgH90LVTc0DUxGs62l4SBpIeNYy+d4qQklLlAf
	 7zwquXf2QXRJHQxMWJyGxHHb5ycc7IeHnb3eBfiaA3LSDAjlTILSGkQY0pFGZ0GTrK
	 I/OzBltEL3ynw==
Received: by pali.im (Postfix)
	id C505F7DE; Sun, 23 Mar 2025 11:32:34 +0100 (CET)
Date: Sun, 23 Mar 2025 11:32:34 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] fs: introduce getfsxattrat and setfsxattrat
 syscalls
Message-ID: <20250323103234.2mwhpsbigpwtiby4@pali>
References: <20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org>
 <CAOQ4uxjQDUg8HFG+mSxMkR54zen7nC2jttzOKqh13Bx-uosh3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjQDUg8HFG+mSxMkR54zen7nC2jttzOKqh13Bx-uosh3Q@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Sunday 23 March 2025 09:45:06 Amir Goldstein wrote:
> On Fri, Mar 21, 2025 at 8:50 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > This patchset introduced two new syscalls getfsxattrat() and
> > setfsxattrat(). These syscalls are similar to FS_IOC_FSSETXATTR ioctl()
> > except they use *at() semantics. Therefore, there's no need to open the
> > file to get an fd.
> >
> > These syscalls allow userspace to set filesystem inode attributes on
> > special files. One of the usage examples is XFS quota projects.
> >
> > XFS has project quotas which could be attached to a directory. All
> > new inodes in these directories inherit project ID set on parent
> > directory.
> >
> > The project is created from userspace by opening and calling
> > FS_IOC_FSSETXATTR on each inode. This is not possible for special
> > files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> > with empty project ID. Those inodes then are not shown in the quota
> > accounting but still exist in the directory. This is not critical but in
> > the case when special files are created in the directory with already
> > existing project quota, these new inodes inherit extended attributes.
> > This creates a mix of special files with and without attributes.
> > Moreover, special files with attributes don't have a possibility to
> > become clear or change the attributes. This, in turn, prevents userspace
> > from re-creating quota project on these existing files.
> >
> > Christian, if this get in some mergeable state, please don't merge it
> > yet. Amir suggested these syscalls better to use updated struct fsxattr
> > with masking from Pali Rohár patchset, so, let's see how it goes.
> 
> Andrey,
> 
> To be honest I don't think it would be fair to delay your syscalls more
> than needed.

I agree.

> If Pali can follow through and post patches on top of your syscalls for
> next merge window that would be great, but otherwise, I think the
> minimum requirement is that the syscalls return EINVAL if fsx_pad
> is not zero. we can take it from there later.

IMHO SYS_getfsxattrat is fine in this form.

For SYS_setfsxattrat I think there are needed some modifications
otherwise we would have problem again with backward compatibility as
is with ioctl if the syscall wants to be extended in future.

I would suggest for following modifications for SYS_setfsxattrat:

- return EINVAL if fsx_xflags contains some reserved or unsupported flag

- add some flag to completely ignore fsx_extsize, fsx_projid, and
  fsx_cowextsize fields, so SYS_setfsxattrat could be used just to
  change fsx_xflags, and so could be used without the preceding
  SYS_getfsxattrat call.

What do you think about it?

Use cases for future without breaking backward compatibility:
- atomically / race-free do set or clear just one flag in fsx_xflags
  (so avoid getfsxattrat - modify buffer - setfsxattrat roundtrip)
- use fsx_pad[] for some new purposes 

> We can always also increase the size of struct fsxattr, but let's first
> use the padding space already available.
> 
> Thanks,
> Amir.
> 
> >
> > NAME
> >
> >         getfsxattrat/setfsxattrat - get/set filesystem inode attributes
> >
> > SYNOPSIS
> >
> >         #include <sys/syscall.h>    /* Definition of SYS_* constants */
> >         #include <unistd.h>
> >
> >         long syscall(SYS_getfsxattrat, int dirfd, const char *pathname,
> >                 struct fsxattr *fsx, size_t size,
> >                 unsigned int at_flags);
> >         long syscall(SYS_setfsxattrat, int dirfd, const char *pathname,
> >                 struct fsxattr *fsx, size_t size,
> >                 unsigned int at_flags);
> >
> >         Note: glibc doesn't provide for getfsxattrat()/setfsxattrat(),
> >         use syscall(2) instead.
> >
> > DESCRIPTION
> >
> >         The syscalls take fd and path to the child together with struct
> >         fsxattr. If path is absolute, fd is not used. If path is empty,
> >         inode under fd is used to get/set attributes on.
> >
> >         This is an alternative to FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR
> >         ioctl with a difference that file don't need to be open as we
> >         can reference it with a path instead of fd. By having this we
> >         can manipulated filesystem inode attributes not only on regular
> >         files but also on special ones. This is not possible with
> >         FS_IOC_FSSETXATTR ioctl as with special files we can not call
> >         ioctl() directly on the filesystem inode using file descriptor.
> >
> > RETURN VALUE
> >
> >         On success, 0 is returned.  On error, -1 is returned, and errno
> >         is set to indicate the error.
> >
> > ERRORS
> >
> >         EINVAL          Invalid at_flag specified (only
> >                         AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH is
> >                         supported).
> >
> >         EINVAL          Size was smaller than any known version of
> >                         struct fsxattr.
> >
> >         EINVAL          Invalid combination of parameters provided in
> >                         fsxattr for this type of file.
> >
> >         E2BIG           Size of input argument **struct fsxattr** is too
> >                         big.
> >
> >         EBADF           Invalid file descriptor was provided.
> >
> >         EPERM           No permission to change this file.
> >
> >         EOPNOTSUPP      Filesystem does not support setting attributes
> >                         on this type of inode
> >
> > HISTORY
> >
> >         Added in Linux 6.14.
> >
> > EXAMPLE
> >
> > Create directory and file "mkdir ./dir && touch ./dir/foo" and then
> > execute the following program:
> >
> >         #include <fcntl.h>
> >         #include <errno.h>
> >         #include <string.h>
> >         #include <linux/fs.h>
> >         #include <stdio.h>
> >         #include <sys/syscall.h>
> >         #include <unistd.h>
> >
> >         int
> >         main(int argc, char **argv) {
> >                 int dfd;
> >                 int error;
> >                 struct fsxattr fsx;
> >
> >                 dfd = open("./dir", O_RDONLY);
> >                 if (dfd == -1) {
> >                         printf("can not open ./dir");
> >                         return dfd;
> >                 }
> >
> >                 error = syscall(467, dfd, "./foo", &fsx, 0);
> >                 if (error) {
> >                         printf("can not call 467: %s", strerror(errno));
> >                         return error;
> >                 }
> >
> >                 printf("dir/foo flags: %d\n", fsx.fsx_xflags);
> >
> >                 fsx.fsx_xflags |= FS_XFLAG_NODUMP;
> >                 error = syscall(468, dfd, "./foo", &fsx, 0);
> >                 if (error) {
> >                         printf("can not call 468: %s", strerror(errno));
> >                         return error;
> >                 }
> >
> >                 printf("dir/foo flags: %d\n", fsx.fsx_xflags);
> >
> >                 return error;
> >         }
> >
> > SEE ALSO
> >
> >         ioctl(2), ioctl_iflags(2), ioctl_xfs_fsgetxattr(2)
> >
> > ---
> > Changes in v4:
> > - Use getname_maybe_null() for correct handling of dfd + path semantic
> > - Remove restriction for special files on which flags are allowed
> > - Utilize copy_struct_from_user() for better future compatibility
> > - Add draft man page to cover letter
> > - Convert -ENOIOCTLCMD to -EOPNOSUPP as more appropriate for syscall
> > - Add missing __user to header declaration of syscalls
> > - Link to v3: https://lore.kernel.org/r/20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org
> >
> > Changes in v3:
> > - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> > - Remove unnecessary "same filesystem" check
> > - Use CLASS() instead of directly calling fdget/fdput
> > - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org
> >
> > v1:
> > https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/
> >
> > Previous discussion:
> > https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
> >
> > ---
> > Andrey Albershteyn (3):
> >       lsm: introduce new hooks for setting/getting inode fsxattr
> >       fs: split fileattr/fsxattr converters into helpers
> >       fs: introduce getfsxattrat and setfsxattrat syscalls
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/arm/tools/syscall.tbl                  |   2 +
> >  arch/arm64/tools/syscall_32.tbl             |   2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
> >  fs/inode.c                                  | 130 ++++++++++++++++++++++++++++
> >  fs/ioctl.c                                  |  39 ++++++---
> >  include/linux/fileattr.h                    |   2 +
> >  include/linux/lsm_hook_defs.h               |   4 +
> >  include/linux/security.h                    |  16 ++++
> >  include/linux/syscalls.h                    |   6 ++
> >  include/uapi/asm-generic/unistd.h           |   8 +-
> >  include/uapi/linux/fs.h                     |   3 +
> >  security/security.c                         |  32 +++++++
> >  25 files changed, 259 insertions(+), 13 deletions(-)
> > ---
> > base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> > change-id: 20250114-xattrat-syscall-6a1136d2db59
> >
> > Best regards,
> > --
> > Andrey Albershteyn <aalbersh@kernel.org>
> >
> >

