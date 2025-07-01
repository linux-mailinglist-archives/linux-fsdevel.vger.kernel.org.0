Return-Path: <linux-fsdevel+bounces-53493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6EAEF8A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E06444E75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245E273819;
	Tue,  1 Jul 2025 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPBrvXR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD11F0E4B;
	Tue,  1 Jul 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373294; cv=none; b=WRrDQQRuw+rrhpmgSpaMWmcPUdGNg/mPWwmTTR04tzOR3SjEY0/7LIKIKYPsa57YWjNvxTW9b/vGDZ21Xw/InVpcvnBdTY/8QpXKMPUVTkNh6/TAG/MsfUHC14TyyrsSxCJVHsDTpP7xCa6LvwoR4BtkKI+p+uTRURdMeDNDRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373294; c=relaxed/simple;
	bh=jbSx3mcsy8vYVQFwQ81B7a/fSORBoSGIxCC555aUqhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo8rsdQl1pkHe0moWDS63mD9f5SkIIpiWci08vf6+wEZRh8uF9GkWIG2CjtF2htU60XQaBQ/6y0mVoRrgmuo87f1ldsPYZMo546tUiZNSaOc2j3tFgKs/rhyGucb7DoH6NbiYci3LXH9tbMCTpAvlJSdk/5Zm0qt8MgUbBHG0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPBrvXR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74125C4CEEB;
	Tue,  1 Jul 2025 12:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751373294;
	bh=jbSx3mcsy8vYVQFwQ81B7a/fSORBoSGIxCC555aUqhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPBrvXR6DszbA2Zg65derq50osJPadgbdG4Y9ywfjrOXPdyXGhCCl3eauQqCzckn5
	 VuBDD7kjPNUobZPoW5+MV5l2+ITSyMkfhkHbkBeloXk6yovsqbYV5mkLbzbU+JsfEn
	 9s9LqNkjpfegAeI5gQkKy/mYG8DDE4IyIiwXi43nMyUizmzBWi59vDF5Z77a2NWc7Z
	 DKtmF4/bJ86LnWQBmQpy5glNk0bEAkVpysJALlbjaA8/VrYigBZOQxcu2z2NMQUSWV
	 z/DgOKhd2oMQxXh9a+YbV8Osa8ifGWoA2Fzx/CzUMmcB6x1ldbOfGr7oHh03X8035P
	 T1bZEn5h9Nwuw==
Date: Tue, 1 Jul 2025 14:34:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250701-bauzaun-riskieren-595464ef81c4@brauner>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>

On Mon, Jun 30, 2025 at 06:20:16PM +0200, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Introduce file_getattr() and file_setattr() syscalls to manipulate inode
> extended attributes. The syscalls takes pair of file descriptor and
> pathname. Then it operates on inode opened accroding to openat()
> semantics. The struct fsx_fileattr is passed to obtain/change extended
> attributes.
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
> CC: linux-api@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
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
>  fs/file_attr.c                              | 148 ++++++++++++++++++++++++++++
>  include/linux/syscalls.h                    |   6 ++
>  include/uapi/asm-generic/unistd.h           |   8 +-
>  include/uapi/linux/fs.h                     |  18 ++++
>  scripts/syscall.tbl                         |   2 +
>  21 files changed, 213 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
> index 2dd6340de6b4..16dca28ebf17 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -507,3 +507,5 @@
>  575	common	listxattrat			sys_listxattrat
>  576	common	removexattrat			sys_removexattrat
>  577	common	open_tree_attr			sys_open_tree_attr
> +578	common	file_getattr			sys_file_getattr
> +579	common	file_setattr			sys_file_setattr
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 27c1d5ebcd91..b07e699aaa3c 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -482,3 +482,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
> index 0765b3a8d6d6..8d9088bc577d 100644
> --- a/arch/arm64/tools/syscall_32.tbl
> +++ b/arch/arm64/tools/syscall_32.tbl
> @@ -479,3 +479,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 9fe47112c586..f41d38dfbf13 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -467,3 +467,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 7b6e97828e55..580af574fe73 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -473,3 +473,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index aa70e371bb54..d824ffe9a014 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -406,3 +406,5 @@
>  465	n32	listxattrat			sys_listxattrat
>  466	n32	removexattrat			sys_removexattrat
>  467	n32	open_tree_attr			sys_open_tree_attr
> +468	n32	file_getattr			sys_file_getattr
> +469	n32	file_setattr			sys_file_setattr
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 1e8c44c7b614..7a7049c2c307 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -382,3 +382,5 @@
>  465	n64	listxattrat			sys_listxattrat
>  466	n64	removexattrat			sys_removexattrat
>  467	n64	open_tree_attr			sys_open_tree_attr
> +468	n64	file_getattr			sys_file_getattr
> +469	n64	file_setattr			sys_file_setattr
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 114a5a1a6230..d330274f0601 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -455,3 +455,5 @@
>  465	o32	listxattrat			sys_listxattrat
>  466	o32	removexattrat			sys_removexattrat
>  467	o32	open_tree_attr			sys_open_tree_attr
> +468	o32	file_getattr			sys_file_getattr
> +469	o32	file_setattr			sys_file_setattr
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 94df3cb957e9..88a788a7b18d 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -466,3 +466,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 9a084bdb8926..b453e80dfc00 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -558,3 +558,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index a4569b96ef06..8a6744d658db 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -470,3 +470,5 @@
>  465  common	listxattrat		sys_listxattrat			sys_listxattrat
>  466  common	removexattrat		sys_removexattrat		sys_removexattrat
>  467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
> +468  common	file_getattr		sys_file_getattr		sys_file_getattr
> +469  common	file_setattr		sys_file_setattr		sys_file_setattr
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index 52a7652fcff6..5e9c9eff5539 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -471,3 +471,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 83e45eb6c095..ebb7d06d1044 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -513,3 +513,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index ac007ea00979..4877e16da69a 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -473,3 +473,5 @@
>  465	i386	listxattrat		sys_listxattrat
>  466	i386	removexattrat		sys_removexattrat
>  467	i386	open_tree_attr		sys_open_tree_attr
> +468	i386	file_getattr		sys_file_getattr
> +469	i386	file_setattr		sys_file_setattr
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index cfb5ca41e30d..92cf0fe2291e 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -391,6 +391,8 @@
>  465	common	listxattrat		sys_listxattrat
>  466	common	removexattrat		sys_removexattrat
>  467	common	open_tree_attr		sys_open_tree_attr
> +468	common	file_getattr		sys_file_getattr
> +469	common	file_setattr		sys_file_setattr
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index f657a77314f8..374e4cb788d8 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -438,3 +438,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 62f08872d4ad..fda9d847eee5 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -3,6 +3,10 @@
>  #include <linux/security.h>
>  #include <linux/fscrypt.h>
>  #include <linux/fileattr.h>
> +#include <linux/syscalls.h>
> +#include <linux/namei.h>
> +
> +#include "internal.h"
>  
>  /**
>   * fileattr_fill_xflags - initialize fileattr with xflags
> @@ -89,6 +93,19 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  }
>  EXPORT_SYMBOL(vfs_fileattr_get);
>  
> +static void fileattr_to_fsx_fileattr(const struct fileattr *fa,
> +				     struct fsx_fileattr *fsx)
> +{
> +	__u32 mask = FS_XFLAGS_MASK;
> +
> +	memset(fsx, 0, sizeof(struct fsx_fileattr));

Fwiw, what also works is:

*fsx = (struct fsx_fileattr){
	.fsx_xflags	= fa->fsx_xflags & mask,
	.fsx_extsize	= fa->fsx_extsize,
	.fsx_nextents	= fa->fsx_nextents,
	.fsx_projid	= fa->fsx_projid,
	.fsx_cowextsize	= fa->fsx_cowextsize,
}

avoiding the memset(). Anyway, all minor nits.

> +	fsx->fsx_xflags = fa->fsx_xflags & mask;
> +	fsx->fsx_extsize = fa->fsx_extsize;
> +	fsx->fsx_nextents = fa->fsx_nextents;
> +	fsx->fsx_projid = fa->fsx_projid;
> +	fsx->fsx_cowextsize = fa->fsx_cowextsize;
> +}
> +
>  /**
>   * copy_fsxattr_to_user - copy fsxattr to userspace.
>   * @fa:		fileattr pointer
> @@ -115,6 +132,23 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
>  }
>  EXPORT_SYMBOL(copy_fsxattr_to_user);
>  
> +static int fsx_fileattr_to_fileattr(const struct fsx_fileattr *fsx,
> +				    struct fileattr *fa)
> +{
> +	__u32 mask = FS_XFLAGS_MASK;
> +
> +	if (fsx->fsx_xflags & ~mask)
> +		return -EINVAL;
> +
> +	fileattr_fill_xflags(fa, fsx->fsx_xflags);
> +	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
> +	fa->fsx_extsize = fsx->fsx_extsize;
> +	fa->fsx_projid = fsx->fsx_projid;
> +	fa->fsx_cowextsize = fsx->fsx_cowextsize;
> +
> +	return 0;
> +}
> +
>  static int copy_fsxattr_from_user(struct fileattr *fa,
>  				  struct fsxattr __user *ufa)
>  {
> @@ -343,3 +377,117 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  	return err;
>  }
>  EXPORT_SYMBOL(ioctl_fssetxattr);
> +
> +SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
> +		struct fsx_fileattr __user *, ufsx, size_t, usize,
> +		unsigned int, at_flags)
> +{
> +	struct fileattr fa;
> +	struct path filepath __free(path_put) = {};
> +	int error;
> +	unsigned int lookup_flags = 0;
> +	struct filename *name __free(putname) = NULL;

Fwiw, cleanup guards should always be grouped together at the top like:

struct path filepath __free(path_put) = {};
struct filename *name __free(putname) = NULL;
struct fileattr fa;
int error;
unsigned int lookup_flags = 0;

This makes it easy to spot them when reading a function with multiple
variables on top.

> +	struct fsx_fileattr fsx;

> +	struct fsx_fileattr fsx;
> +
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) < FSX_FILEATTR_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) != FSX_FILEATTR_SIZE_LATEST);
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	if (usize < FSX_FILEATTR_SIZE_VER0)
> +		return -EINVAL;
> +
> +	name = getname_maybe_null(filename, at_flags);
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);
> +
> +	if (!name && dfd >= 0) {
> +		CLASS(fd, f)(dfd);
> +
> +		filepath = fd_file(f)->f_path;
> +		path_get(&filepath);
> +	} else {
> +		error = filename_lookup(dfd, name, lookup_flags, &filepath,
> +					NULL);
> +		if (error)
> +			return error;
> +	}
> +
> +	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (error)
> +		return error;
> +
> +	fileattr_to_fsx_fileattr(&fa, &fsx);
> +	error = copy_struct_to_user(ufsx, usize, &fsx,
> +				    sizeof(struct fsx_fileattr), NULL);
> +
> +	return error;
> +}
> +
> +SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
> +		struct fsx_fileattr __user *, ufsx, size_t, usize,
> +		unsigned int, at_flags)
> +{
> +	struct fileattr fa;
> +	struct path filepath __free(path_put) = {};
> +	int error;
> +	unsigned int lookup_flags = 0;
> +	struct filename *name __free(putname) = NULL;
> +	struct fsx_fileattr fsx;
> +
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) < FSX_FILEATTR_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) != FSX_FILEATTR_SIZE_LATEST);
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	if (usize < FSX_FILEATTR_SIZE_VER0)
> +		return -EINVAL;
> +
> +	error = copy_struct_from_user(&fsx, sizeof(struct fsx_fileattr), ufsx,
> +				      usize);
> +	if (error)
> +		return error;
> +
> +	error = fsx_fileattr_to_fileattr(&fsx, &fa);
> +	if (error)
> +		return error;
> +
> +	name = getname_maybe_null(filename, at_flags);
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);
> +
> +	if (!name && dfd >= 0) {
> +		CLASS(fd, f)(dfd);
> +
> +		filepath = fd_file(f)->f_path;
> +		path_get(&filepath);
> +	} else {
> +		error = filename_lookup(dfd, name, lookup_flags, &filepath,
> +					NULL);
> +		if (error)
> +			return error;
> +	}
> +
> +	error = mnt_want_write(filepath.mnt);
> +	if (!error) {
> +		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
> +					 filepath.dentry, &fa);
> +		mnt_drop_write(filepath.mnt);
> +	}

Note-to-self: I really want scoped_guard()s for mnt_want_write() going forward...

> +
> +	return error;
> +}
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e5603cc91963..179acbe28fec 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -371,6 +371,12 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
>  asmlinkage long sys_lremovexattr(const char __user *path,
>  				 const char __user *name);
>  asmlinkage long sys_fremovexattr(int fd, const char __user *name);
> +asmlinkage long sys_file_getattr(int dfd, const char __user *filename,
> +				 struct fsx_fileattr __user *ufsx, size_t usize,
> +				 unsigned int at_flags);
> +asmlinkage long sys_file_setattr(int dfd, const char __user *filename,
> +				 struct fsx_fileattr __user *ufsx, size_t usize,
> +				 unsigned int at_flags);
>  asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
>  asmlinkage long sys_eventfd2(unsigned int count, int flags);
>  asmlinkage long sys_epoll_create1(int flags);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 2892a45023af..04e0077fb4c9 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -852,8 +852,14 @@ __SYSCALL(__NR_removexattrat, sys_removexattrat)
>  #define __NR_open_tree_attr 467
>  __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
>  
> +/* fs/inode.c */
> +#define __NR_file_getattr 468
> +__SYSCALL(__NR_file_getattr, sys_file_getattr)
> +#define __NR_file_setattr 469
> +__SYSCALL(__NR_file_setattr, sys_file_setattr)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 468
> +#define __NR_syscalls 470
>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 0098b0ce8ccb..0784f2033ba4 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -148,6 +148,24 @@ struct fsxattr {
>  	unsigned char	fsx_pad[8];
>  };
>  
> +/*
> + * Variable size structure for file_[sg]et_attr().
> + *
> + * Note. This is alternative to the structure 'struct fileattr'/'struct fsxattr'.
> + * As this structure is passed to/from userspace with its size, this can
> + * be versioned based on the size.
> + */
> +struct fsx_fileattr {
> +	__u32	fsx_xflags;	/* xflags field value (get/set) */
> +	__u32	fsx_extsize;	/* extsize field value (get/set)*/
> +	__u32	fsx_nextents;	/* nextents field value (get)   */
> +	__u32	fsx_projid;	/* project identifier (get/set) */
> +	__u32	fsx_cowextsize;	/* CoW extsize field value (get/set) */

This misses a:

__u32 __spare;

so there's no holes in the struct. :)

> +};
> +
> +#define FSX_FILEATTR_SIZE_VER0 20
> +#define FSX_FILEATTR_SIZE_LATEST FSX_FILEATTR_SIZE_VER0
> +
>  /*
>   * Flags for the fsx_xflags field
>   */
> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index 580b4e246aec..d1ae5e92c615 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -408,3 +408,5 @@
>  465	common	listxattrat			sys_listxattrat
>  466	common	removexattrat			sys_removexattrat
>  467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr
> 
> -- 
> 2.47.2
> 

