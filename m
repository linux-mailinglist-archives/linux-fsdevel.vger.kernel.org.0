Return-Path: <linux-fsdevel+bounces-39212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BA9A115D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93D8168AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA03D76;
	Wed, 15 Jan 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEFeyh9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89D17C;
	Wed, 15 Jan 2025 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899535; cv=none; b=bAP2DBJ1cuBisRcyYUNGENq4E8ms1ourf2AHctbHaTY9ubTAO/IsRwthEwinIt+AEkZaoayvcKMR0wPTQK9iXx/BmkTkksS68RSSUTi/jby6WINQkVGv3/Znso8yVUQnFyNTmGv5BIyewiC9LSVjaYOUjvDXrBtekPfZcyY50B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899535; c=relaxed/simple;
	bh=j3gjgbcQIhEKIfeqQZrPdGfl/Z3CtqDX29xeugDBeS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVpzcgy1d+gNd3Y/G2MOzyJFYQsLgENmBp8kucLRvAfbyWFlkwcckoK9jOxkyvTgxYO+B5NmaukTES6jhNwP+HG0RMsi0lETZTk8OcQ+Mu1AURiFDbsAwz30vF9ti5QeMQUWKeh4cJeaqYO/YWnksCr9AgMfVAPLNnbTUitaxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEFeyh9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F2DC4CEDD;
	Wed, 15 Jan 2025 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736899535;
	bh=j3gjgbcQIhEKIfeqQZrPdGfl/Z3CtqDX29xeugDBeS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEFeyh9q7AVq5K8I5WhOSU9DOIByeoscMTIp+0VGDrAqCHvMSniS7AfKZgYNvW7fq
	 AVLz13FrYIR3Yq8egVQhozXo+n5gxAEcJ2Fvp9pDLwhoY0LN0p8WnD8VyXcvhAn5U3
	 8jOVew/S9tRtpboXL/ft40/Q4E5MLg3RF0FcP3apcY82ctde7CjHZn2HKXqbWvIN9I
	 5mMTxHs99c9yvTazCzXC9nxsxBy41qt9YgNdZhI5DxXLmQYPMgoDrKTzHEWdTPKaZv
	 EREYeHOzxHMXY36idswzIJgyObpTL/100tJhgdkF1N53ycoC9qSvrXBVv3UlbDR9Di
	 QJeJAhcrHBx6A==
Date: Tue, 14 Jan 2025 16:05:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	monstr@monstr.eu, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	chris@zankel.net, jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, arnd@arndb.de,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <20250115000534.GB3557695@frogsfrogsfrogs>
References: <20250109174540.893098-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109174540.893098-1-aalbersh@kernel.org>

On Thu, Jan 09, 2025 at 06:45:40PM +0100, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> extended attributes/flags. The syscalls take parent directory FD and
> path to the child together with struct fsxattr.
> 
> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> that file don't need to be open. By having this we can manipulated
> inode extended attributes not only on normal files but also on
> special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
> opening special files returns VFS special inode instead of
> underlying filesystem one.
> 
> This patch adds two new syscalls which allows userspace to set
> extended inode attributes on special files by using parent directory
> to open FS inode.
> 
> Also, as vfs_fileattr_set() is now will be called on special files
> too, let's forbid any other attributes except projid and nextents
> (symlink can have an extent).
> 
> CC: linux-api@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
> 
> Notes:
>     Previous discussion:
>     https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/
>     
>     XFS has project quotas which could be attached to a directory. All
>     new inodes in these directories inherit project ID set on parent
>     directory.
>     
>     The project is created from userspace by opening and calling
>     FS_IOC_FSSETXATTR on each inode. This is not possible for special
>     files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
>     with empty project ID. Those inodes then are not shown in the quota
>     accounting but still exist in the directory. Moreover, in the case
>     when special files are created in the directory with already
>     existing project quota, these inode inherit extended attributes.
>     This than leaves them with these attributes without the possibility
>     to clear them out. This, in turn, prevents userspace from
>     re-creating quota project on these existing files.
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
>  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
>  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
>  fs/inode.c                                  | 105 ++++++++++++++++++++
>  fs/ioctl.c                                  |  17 +++-
>  include/linux/fileattr.h                    |   1 +
>  include/linux/syscalls.h                    |   4 +
>  include/uapi/asm-generic/unistd.h           |   8 +-
>  16 files changed, 154 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index c59d53d6d3f3..4b9e687494c1 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -506,3 +506,5 @@
>  574	common	getxattrat			sys_getxattrat
>  575	common	listxattrat			sys_listxattrat
>  576	common	removexattrat			sys_removexattrat
> +577	common	getfsxattrat			sys_getfsxattrat
> +578	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index f5ed71f1910d..159476387f39 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -466,3 +466,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 680f568b77f2..a6d59ee740b5 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -472,3 +472,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index d9fc94c86965..b3578fac43d6 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -465,3 +465,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index d8b4ab78bef0..808045d82c94 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -557,3 +557,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index e9115b4d8b63..78dfc2c184d4 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -469,3 +469,5 @@
>  464  common	getxattrat		sys_getxattrat			sys_getxattrat
>  465  common	listxattrat		sys_listxattrat			sys_listxattrat
>  466  common	removexattrat		sys_removexattrat		sys_removexattrat
> +467  common	getfsxattrat		sys_getfsxattrat		sys_getfsxattrat
> +468  common	setfsxattrat		sys_setfsxattrat		sys_setfsxattrat
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index c8cad33bf250..d5a5c8339f0e 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -470,3 +470,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 727f99d333b3..817dcd8603bc 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -512,3 +512,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 4d0fb2fba7e2..b4842c027c5d 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -472,3 +472,5 @@
>  464	i386	getxattrat		sys_getxattrat
>  465	i386	listxattrat		sys_listxattrat
>  466	i386	removexattrat		sys_removexattrat
> +467	i386	getfsxattrat		sys_getfsxattrat
> +468	i386	setfsxattrat		sys_setfsxattrat
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 5eb708bff1c7..b6f0a7236aae 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -390,6 +390,8 @@
>  464	common	getxattrat		sys_getxattrat
>  465	common	listxattrat		sys_listxattrat
>  466	common	removexattrat		sys_removexattrat
> +467	common	getfsxattrat		sys_getfsxattrat
> +468	common	setfsxattrat		sys_setfsxattrat
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index 37effc1b134e..425d56be337d 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -437,3 +437,5 @@
>  464	common	getxattrat			sys_getxattrat
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
> +467	common	getfsxattrat			sys_getfsxattrat
> +468	common	setfsxattrat			sys_setfsxattrat
> diff --git a/fs/inode.c b/fs/inode.c
> index 6b4c77268fc0..fc8939c6c8a7 100644
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
> @@ -2953,3 +2956,105 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  	return mode & ~S_ISGID;
>  }
>  EXPORT_SYMBOL(mode_strip_sgid);
> +
> +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr *, fsx, int, at_flags)
> +{
> +	struct fd dir;
> +	struct fileattr fa;
> +	struct path filepath;
> +	struct inode *inode;
> +	int error;
> +
> +	if (at_flags)
> +		return -EINVAL;
> +
> +	if (!capable(CAP_FOWNER))
> +		return -EPERM;
> +
> +	dir = fdget(dfd);
> +	if (!fd_file(dir))
> +		return -EBADF;
> +
> +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> +		error = -EBADF;
> +		goto out;
> +	}
> +
> +	error = user_path_at(dfd, filename, at_flags, &filepath);

Same comments as Jan, but I wanted to point out that the third argument
to user_path_at() is LOOKUP_*, not AT_*.  Right now you don't allow any
AT_* flags, but that's something to fix before the next revision.

--D

> +	if (error)
> +		goto out;
> +
> +	inode = filepath.dentry->d_inode;
> +	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
> +		error = -EBADF;
> +		goto out_path;
> +	}
> +
> +	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (error)
> +		goto out_path;
> +
> +	if (copy_fsxattr_to_user(&fa, fsx))
> +		error = -EFAULT;
> +
> +out_path:
> +	path_put(&filepath);
> +out:
> +	fdput(dir);
> +	return error;
> +}
> +
> +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr *, fsx, int, at_flags)
> +{
> +	struct fd dir;
> +	struct fileattr fa;
> +	struct inode *inode;
> +	struct path filepath;
> +	int error;
> +
> +	if (at_flags)
> +		return -EINVAL;
> +
> +	if (!capable(CAP_FOWNER))
> +		return -EPERM;
> +
> +	dir = fdget(dfd);
> +	if (!fd_file(dir))
> +		return -EBADF;
> +
> +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> +		error = -EBADF;
> +		goto out;
> +	}
> +
> +	if (copy_fsxattr_from_user(&fa, fsx)) {
> +		error = -EFAULT;
> +		goto out;
> +	}
> +
> +	error = user_path_at(dfd, filename, at_flags, &filepath);
> +	if (error)
> +		goto out;
> +
> +	inode = filepath.dentry->d_inode;
> +	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
> +		error = -EBADF;
> +		goto out_path;
> +	}
> +
> +	error = mnt_want_write(filepath.mnt);
> +	if (error)
> +		goto out_path;
> +
> +	error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)), filepath.dentry,
> +				 &fa);
> +	mnt_drop_write(filepath.mnt);
> +
> +out_path:
> +	path_put(&filepath);
> +out:
> +	fdput(dir);
> +	return error;
> +}
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 638a36be31c1..df14f1868165 100644
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
> @@ -574,6 +573,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(copy_fsxattr_from_user);
>  
>  /*
>   * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
> @@ -646,6 +646,19 @@ static int fileattr_set_prepare(struct inode *inode,
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
> index 47c05a9851d0..8598e94b530b 100644
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
> index c6333204d451..a983023d21ab 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -371,6 +371,10 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
>  asmlinkage long sys_lremovexattr(const char __user *path,
>  				 const char __user *name);
>  asmlinkage long sys_fremovexattr(int fd, const char __user *name);
> +asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
> +				 struct fsxattr *fsx, int at_flags);
> +asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
> +				 struct fsxattr *fsx, int at_flags);
>  asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
>  asmlinkage long sys_eventfd2(unsigned int count, int flags);
>  asmlinkage long sys_epoll_create1(int flags);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 88dc393c2bca..50be2e1007bc 100644
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
> -- 
> 2.47.0
> 
> 

