Return-Path: <linux-fsdevel+bounces-53565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C765FAF02CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88704A79E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1191275AE5;
	Tue,  1 Jul 2025 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j68Tw1vM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAD15C0;
	Tue,  1 Jul 2025 18:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751394667; cv=none; b=X4uGKZM1fzNIru9kV9TI0bZctfPd49rygXpXa9ywdNlOttBev0Eq/mcLFlA1Otpk5zoBFdhb4vK6KFMH/9d+IgOfKQBFFdYO99m0xPMjRta9VmEgexZdFk5Ju3PP88YYGnNZdR0drw1udbGQ9aRKvjuhwhH1AjTjqcXujYOSyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751394667; c=relaxed/simple;
	bh=1qF0uAAhy9rWjNvzqRhzklZFFFDFguMIVmmdg9roblg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbBzkV6spSqiafdWz/HusiYtXMKUDln7FSp0ZYZX6Fa4ivXNbrH94aAwxFSSl08zkh3GohapgsQYHu+ckOl5NAjBOMAnpXjk9Q+z64tAMeshC2ZBx9/VApPskpRk4N1wVQpvcjjN2+A8UdhtmLu6BZwlV+xqsc7h+3HIJXC0bIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j68Tw1vM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E1EC4CEEB;
	Tue,  1 Jul 2025 18:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751394666;
	bh=1qF0uAAhy9rWjNvzqRhzklZFFFDFguMIVmmdg9roblg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j68Tw1vMHd3CBwu5wORUjPIgRxKDcVWXQZ91Xc6t0yQl5XJD/8eR6UQThtZA69P8o
	 Yyo7aFRoAa1Rk1pze9iuQO8lJauXOukS+eznJccF39+TgqOccXSETnvsuP3uLmhrOK
	 ALyKxhcCFMDoC5b0Uasn9aPykaC/kJ3Lx1ZvJawcUZkd9OadI051vrX1S6MIXcfF2M
	 MYkQZv20gqam69c+xh2VlJRIe4Vfn9cEhNUzxOaM9CiTaW2UWMIsqaDCFPnWe4+1t7
	 3M7mkCD2U22BxE/RiQ+tTXNxDSF3JWFmEjup9ACXEP0OpbRkmEgcCGPtGQ/eWWa0U0
	 u4/GgxJC+/Zqg==
Date: Tue, 1 Jul 2025 11:31:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 5/6] fs: prepare for extending file_get/setattr()
Message-ID: <20250701183105.GP10009@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630-xattrat-syscall-v6-5-c4e3bc35227b@kernel.org>

On Mon, Jun 30, 2025 at 06:20:15PM +0200, Andrey Albershteyn wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> We intend to add support for more xflags to selective filesystems and
> We cannot rely on copy_struct_from_user() to detect this extension.
> 
> In preparation of extending the API, do not allow setting xflags unknown
> by this kernel version.
> 
> Also do not pass the read-only flags and read-only field fsx_nextents to
> filesystem.
> 
> These changes should not affect existing chattr programs that use the
> ioctl to get fsxattr before setting the new values.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Andrey Albershteyn <aalbersh@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/file_attr.c           |  8 +++++++-
>  include/linux/fileattr.h | 20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 4e85fa00c092..62f08872d4ad 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -99,9 +99,10 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>  int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
>  {
>  	struct fsxattr xfa;
> +	__u32 mask = FS_XFLAGS_MASK;
>  
>  	memset(&xfa, 0, sizeof(xfa));
> -	xfa.fsx_xflags = fa->fsx_xflags;
> +	xfa.fsx_xflags = fa->fsx_xflags & mask;

I wonder, should it be an error if a filesystem sets an fsx_xflags bit
outside of FS_XFLAGS_MASK?  I guess that's one way to prevent
filesystems from overriding the VFS bits. ;)

Though couldn't that be:

	xfa.fsx_xflags = fa->fsx_xflags & FS_XFLAGS_MASK;

instead?  And same below?

>  	xfa.fsx_extsize = fa->fsx_extsize;
>  	xfa.fsx_nextents = fa->fsx_nextents;
>  	xfa.fsx_projid = fa->fsx_projid;
> @@ -118,11 +119,16 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
>  				  struct fsxattr __user *ufa)
>  {
>  	struct fsxattr xfa;
> +	__u32 mask = FS_XFLAGS_MASK;
>  
>  	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
>  		return -EFAULT;
>  
> +	if (xfa.fsx_xflags & ~mask)
> +		return -EINVAL;

I wonder if you want EOPNOTSUPP here?  We don't know how to support
unknown xflags.  OTOH if you all have beaten this to death while I was
out then don't start another round just for me. :P

--D

> +
>  	fileattr_fill_xflags(fa, xfa.fsx_xflags);
> +	fa->fsx_xflags &= ~FS_XFLAG_RDONLY_MASK;
>  	fa->fsx_extsize = xfa.fsx_extsize;
>  	fa->fsx_nextents = xfa.fsx_nextents;
>  	fa->fsx_projid = xfa.fsx_projid;
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 6030d0bf7ad3..e2a2f4ae242d 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -14,6 +14,26 @@
>  	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
>  	 FS_XFLAG_PROJINHERIT)
>  
> +/* Read-only inode flags */
> +#define FS_XFLAG_RDONLY_MASK \
> +	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
> +
> +/* Flags to indicate valid value of fsx_ fields */
> +#define FS_XFLAG_VALUES_MASK \
> +	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
> +
> +/* Flags for directories */
> +#define FS_XFLAG_DIRONLY_MASK \
> +	(FS_XFLAG_RTINHERIT | FS_XFLAG_NOSYMLINKS | FS_XFLAG_EXTSZINHERIT)
> +
> +/* Misc settable flags */
> +#define FS_XFLAG_MISC_MASK \
> +	(FS_XFLAG_REALTIME | FS_XFLAG_NODEFRAG | FS_XFLAG_FILESTREAM)
> +
> +#define FS_XFLAGS_MASK \
> +	(FS_XFLAG_COMMON | FS_XFLAG_RDONLY_MASK | FS_XFLAG_VALUES_MASK | \
> +	 FS_XFLAG_DIRONLY_MASK | FS_XFLAG_MISC_MASK)
> +
>  /*
>   * Merged interface for miscellaneous file attributes.  'flags' originates from
>   * ext* and 'fsx_flags' from xfs.  There's some overlap between the two, which
> 
> -- 
> 2.47.2
> 
> 

