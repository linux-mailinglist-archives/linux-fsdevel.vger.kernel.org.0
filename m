Return-Path: <linux-fsdevel+bounces-53569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17DAF02F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68EB16C836
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D027FB3F;
	Tue,  1 Jul 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwD/gItj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCB26B2AA;
	Tue,  1 Jul 2025 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751395399; cv=none; b=IXlp2suVySceBuVOZTuIFDDLopQMuRtERCDwnYMWPOs2lVgsAdlZbDF/D1fiSoOXiKzeL/328de9eaD/JSylIqSFisMAH2+uluNGaa8pd0hSlMScySIijyMySVAEM5HZLzQtGGpcjerPReqp4SKEps4qqXNr1Elm8UBPhZ2gXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751395399; c=relaxed/simple;
	bh=st9TTbuw9eE4bbi3qT1g6AMOzooHD90mIKVljY6K6Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrj90GZnDPCXULHKoFrawPWeWHOFoAiS0ShePyPyf4de7+gMo62yDsv53+HSWy5RqdWF/8zImNOvaGN0pjR8ZbDhh0u1Pour27skYIV7uwUwhJODQO6/76o7YrSlOCfoiYo+/8KrJGTEt7WF/5oSmZIxcV6PECXOrr8u6TbtwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwD/gItj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D482C4CEEB;
	Tue,  1 Jul 2025 18:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751395398;
	bh=st9TTbuw9eE4bbi3qT1g6AMOzooHD90mIKVljY6K6Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwD/gItjO9VtgQ/NtPziOW0nlPHce6+cQCI6BETvirK97/569slxDBoLwPrmlHiyD
	 3GEUQWu/YtQnFnlKA70YMQTJGlftUZ9F1hDLKgBnoMPhukTk+vuAHfVlCeDE2v5FE/
	 B13zoC1G3sbXaoXYkUcU9h2HQymrp5p7f2RKI4skNIBhr61v5z5e3BqeCv/8YCrXYr
	 CcXgUY9DTsT2nptAmNFa59NZrIpIYjMXG7wkp1TidihNkPlioxxS7ke1/Zo/QmotRw
	 +GY3q5aDxzq6zskgcjb039RAcpVjPTYyfYKaIKlYmomEegyMbwxcYZ7s5upU2j3j5o
	 s+dL2Bv19GK6A==
Date: Tue, 1 Jul 2025 11:43:17 -0700
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
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <20250701184317.GQ10009@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

<snip syscall table>

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

Er... "fsx_fileattr" is the struct that the system call uses?

That's a little confusing considering that xfs already has a
xfs_fill_fsxattr function that actually fills a struct fileattr.
That could be renamed xfs_fill_fileattr.

I dunno.  There's a part of me that would really rather that the
file_getattr and file_setattr syscalls operate on a struct file_attr.

More whining/bikeshedding to come.

<snip stuff that looks ok to me>

<<well, I still dislike the CLASS(fd, fd)(fd) syntax...>>

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

Should this to be __u64 from the start?  Seeing as (a) this struct is
not already a multiple of 8 bytes and (b) it's likely that we'll have to
add a u64 field at some point.  That would also address brauner's
comment about padding.

--D

> +	__u32	fsx_extsize;	/* extsize field value (get/set)*/
> +	__u32	fsx_nextents;	/* nextents field value (get)   */
> +	__u32	fsx_projid;	/* project identifier (get/set) */
> +	__u32	fsx_cowextsize;	/* CoW extsize field value (get/set) */
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
> 

