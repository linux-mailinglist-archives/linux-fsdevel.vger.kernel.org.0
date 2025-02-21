Return-Path: <linux-fsdevel+bounces-42287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13861A3FE77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 19:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AD93B7D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA242528FB;
	Fri, 21 Feb 2025 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twbwQNrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FB2500B1;
	Fri, 21 Feb 2025 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161496; cv=none; b=MXe6sclauTiz0DhBvYDN/aL5wgR4V5PG0enLXO9CDM1u9Z2uQcJmocdK1EA8Tbrg4lZ7H3R3pHLB0PYcRVoe9GvnerdLMUqKO9cPvqTRkZyEOrdd5qOXAudzV+Qj9krpOxXwMhYjdxlnfQuYaO1VfqrnMW5r8N48b5rp+tx6FDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161496; c=relaxed/simple;
	bh=Q5rq+xEARHuJUUCQ4+qMB09sJq9Ogw0gx0NFBabFv8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLPvbKtdaiTXDuWDwHt4p4eT98Z+Evn/PWOY7aHqeTDDB+tZQCHq94wqKQl+LbXYgFkYz1xlaNes1oUA5TPZcgBEGWjwSXod+uc9HsuzuntbSkiFcGf81jH5LHQt81lU2RAJTTHb+CUI3+SYxyvgvk9Kqj/vvk0UR5VB5aCZneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twbwQNrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C591C4CED6;
	Fri, 21 Feb 2025 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740161496;
	bh=Q5rq+xEARHuJUUCQ4+qMB09sJq9Ogw0gx0NFBabFv8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twbwQNrI8NBky7gxEQz1Sp9afJgdr6HMvf9vBHDGlKfl2W61C+ajw5DQvd0yARdzx
	 6IqK6Dta/AzKAOg+oZCOuzfhqfYJNoM1PU06w/jz41Vt+iBFPeOZsr7WDKfEcVHOd+
	 wRMx0kuj0pmY5GVmHB8Ln/wHSn266MnENVFcYyj0SE7LpvoYjMypvZIjvBoa2Y2F1d
	 Z2mJvJVKolFfz0xIV4hpOeFKvnRi0A/C5cUbEnjCP6XeNE5iQtLrSknKeA8Tv16I4/
	 DoBR2WPKBAsUg1Z5A45KC7jb6AS2qE8O2CvXsjhXKHa8ui8jr+NLK37hsdDvyP+y5Q
	 ajxDXXxKA16RQ==
Date: Fri, 21 Feb 2025 10:11:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
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
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <20250221181135.GW21808@frogsfrogsfrogs>
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org>

On Tue, Feb 11, 2025 at 06:22:47PM +0100, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> extended attributes/flags. The syscalls take parent directory fd and
> path to the child together with struct fsxattr.
> 
> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> that file don't need to be open as we can reference it with a path
> instead of fd. By having this we can manipulated inode extended
> attributes not only on regular files but also on special ones. This
> is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> we can not call ioctl() directly on the filesystem inode using fd.
> 
> This patch adds two new syscalls which allows userspace to get/set
> extended inode attributes on special files by using parent directory
> and a path - *at() like syscall.
> 
> Also, as vfs_fileattr_set() is now will be called on special files
> too, let's forbid any other attributes except projid and nextents
> (symlink can have an extent).
> 
> CC: linux-api@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
> v1:
> https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/
> 
> Previous discussion:
> https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
> 
> XFS has project quotas which could be attached to a directory. All
> new inodes in these directories inherit project ID set on parent
> directory.
> 
> The project is created from userspace by opening and calling
> FS_IOC_FSSETXATTR on each inode. This is not possible for special
> files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
> with empty project ID. Those inodes then are not shown in the quota
> accounting but still exist in the directory. Moreover, in the case
> when special files are created in the directory with already
> existing project quota, these inode inherit extended attributes.
> This than leaves them with these attributes without the possibility
> to clear them out. This, in turn, prevents userspace from
> re-creating quota project on these existing files.
> ---
> Changes in v3:
> - Remove unnecessary "dfd is dir" check as it checked in user_path_at()
> - Remove unnecessary "same filesystem" check
> - Use CLASS() instead of directly calling fdget/fdput
> - Link to v2: https://lore.kernel.org/r/20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org
> ---
>  arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
>  arch/arm/tools/syscall.tbl                  |  2 +
>  arch/arm64/tools/syscall_32.tbl             |  2 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
>  arch/s390/kernel/syscalls/syscall.tbl       |  2 +
>  arch/sh/kernel/syscalls/syscall.tbl         |  2 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
>  fs/inode.c                                  | 75 +++++++++++++++++++++++++++++
>  fs/ioctl.c                                  | 16 +++++-
>  include/linux/fileattr.h                    |  1 +
>  include/linux/syscalls.h                    |  4 ++
>  include/uapi/asm-generic/unistd.h           |  8 ++-
>  21 files changed, 133 insertions(+), 3 deletions(-)
> 

<cut to the syscall definitions>

> diff --git a/fs/inode.c b/fs/inode.c
> index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..b2dddd9db4fabaf67a6cbf541a86978b290411ec 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -23,6 +23,9 @@
>  #include <linux/rw_hint.h>
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
> +#include <linux/syscalls.h>
> +#include <linux/fileattr.h>
> +#include <linux/namei.h>
>  #include <trace/events/writeback.h>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/timestamp.h>
> @@ -2953,3 +2956,75 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  	return mode & ~S_ISGID;
>  }
>  EXPORT_SYMBOL(mode_strip_sgid);
> +
> +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr __user *, fsx, unsigned int, at_flags)

Should the kernel require userspace to pass the size of the fsx buffer?
That way we avoid needing to rev the interface when we decide to grow
the structure.

--D

> +{
> +	CLASS(fd, dir)(dfd);
> +	struct fileattr fa;
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_FOLLOW)
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (fd_empty(dir))
> +		return -EBADF;
> +
> +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> +	if (error)
> +		return error;
> +
> +	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (!error)
> +		error = copy_fsxattr_to_user(&fa, fsx);
> +
> +	path_put(&filepath);
> +	return error;
> +}
> +
> +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr __user *, fsx, unsigned int, at_flags)
> +{
> +	CLASS(fd, dir)(dfd);
> +	struct fileattr fa;
> +	struct path filepath;
> +	int error;
> +	unsigned int lookup_flags = 0;
> +
> +	if ((at_flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (at_flags & AT_SYMLINK_FOLLOW)
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (at_flags & AT_EMPTY_PATH)
> +		lookup_flags |= LOOKUP_EMPTY;
> +
> +	if (fd_empty(dir))
> +		return -EBADF;
> +
> +	if (copy_fsxattr_from_user(&fa, fsx))
> +		return -EFAULT;
> +
> +	error = user_path_at(dfd, filename, lookup_flags, &filepath);
> +	if (error)
> +		return error;
> +
> +	error = mnt_want_write(filepath.mnt);
> +	if (!error) {
> +		error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)),
> +					 filepath.dentry, &fa);
> +		mnt_drop_write(filepath.mnt);
> +	}
> +
> +	path_put(&filepath);
> +	return error;
> +}
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 638a36be31c14afc66a7fd6eb237d9545e8ad997..dc160c2ef145e4931d625f1f93c2a8ae7f87abf3 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -558,8 +558,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
>  }
>  EXPORT_SYMBOL(copy_fsxattr_to_user);
>  
> -static int copy_fsxattr_from_user(struct fileattr *fa,
> -				  struct fsxattr __user *ufa)
> +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
>  {
>  	struct fsxattr xfa;
>  
> @@ -646,6 +645,19 @@ static int fileattr_set_prepare(struct inode *inode,
>  	if (fa->fsx_cowextsize == 0)
>  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
>  
> +	/*
> +	 * The only use case for special files is to set project ID, forbid any
> +	 * other attributes
> +	 */
> +	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> +		if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
> +			return -EINVAL;
> +		if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
> +			return -EINVAL;
> +		if (fa->fsx_extsize || fa->fsx_cowextsize)
> +			return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 47c05a9851d0600964b644c9c7218faacfd865f8..8598e94b530b8b280a2697eaf918dd60f573d6ee 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -34,6 +34,7 @@ struct fileattr {
>  };
>  
>  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
> +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa);
>  
>  void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
>  void fileattr_fill_flags(struct fileattr *fa, u32 flags);
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index c6333204d45130eb022f6db460eea34a1f6e91db..3134d463d9af64c6e78adb37bff4b91f77b5305f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -371,6 +371,10 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
>  asmlinkage long sys_lremovexattr(const char __user *path,
>  				 const char __user *name);
>  asmlinkage long sys_fremovexattr(int fd, const char __user *name);
> +asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
> +				 struct fsxattr *fsx, unsigned int at_flags);
> +asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
> +				 struct fsxattr *fsx, unsigned int at_flags);
>  asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
>  asmlinkage long sys_eventfd2(unsigned int count, int flags);
>  asmlinkage long sys_epoll_create1(int flags);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c..50be2e1007bc2779120d05c6e9512a689f86779c 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -850,8 +850,14 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
>  #define __NR_removexattrat 466
>  __SYSCALL(__NR_removexattrat, sys_removexattrat)
>  
> +/* fs/inode.c */
> +#define __NR_getfsxattrat 467
> +__SYSCALL(__NR_getfsxattrat, sys_getfsxattrat)
> +#define __NR_setfsxattrat 468
> +__SYSCALL(__NR_setfsxattrat, sys_setfsxattrat)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 467
> +#define __NR_syscalls 469
>  
>  /*
>   * 32 bit systems traditionally used different
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250114-xattrat-syscall-6a1136d2db59
> 
> Best regards,
> -- 
> Andrey Albershteyn <aalbersh@kernel.org>
> 
> 

