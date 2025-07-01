Return-Path: <linux-fsdevel+bounces-53564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC97AF02BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5C916EF0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACF281370;
	Tue,  1 Jul 2025 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFGMcxEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3E1DAC92;
	Tue,  1 Jul 2025 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393937; cv=none; b=AqIOAt2nkKYxp7Snsfv/U4geghkMUZ06qvPvPP+LLe2nKwWzD/5pUcd+xjpwrAuE9gZQp0GZu3c8tESd4hrWa98gBG140ADk+T+PBrsqcb97JsXmQyn6tpQUz04LcaNrFpyK/f4pFSR4IVq+Ndi6h956f1YhgRwfEDgGc+PZxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393937; c=relaxed/simple;
	bh=d8FTo34ty0WYM5mj8kHcyxfr0mB+ShOj5L9RhZEp8NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKK+k+prR7OyRtQeFzOQrZwH5QEe1yM3lgrEIrJ1ELPJS/x4/AZ71gB3yfX1xIr4jYfuxVLpy6GgF64HXDXF++9Qz+mUuzwSVGNdHVrOBOAIUqSQoXqD/yY9WYEM25bqMZvmQYQjv9SgEvIVOBMhVYRwb5c3UJ5cr6kpyj6seTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFGMcxEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7254C4CEEB;
	Tue,  1 Jul 2025 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751393936;
	bh=d8FTo34ty0WYM5mj8kHcyxfr0mB+ShOj5L9RhZEp8NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFGMcxEUhXbzVzazXZrk8+oO0ViL05gNGwYoY8TfqJSe2aJ93LtoGHQWzKs5GEY4s
	 +t6aP/xGnUyOJVtJPmjtRm9ZPyuwM2bPRlUvXs+5RWqcnVHqRf16/n1RsrlO0jcyDW
	 syQXhoOKGOUpYb5ygd60TqFL4fSWFppvGhP883DrunYS1qwiXOxi1MyZc0S+nndqcO
	 rnxQ24huvTuH2pzsrsggxp3mcy4Xu14bYrsuUw0LG9JerheR7mRcPy3E+Y46AxbKpQ
	 CITymzDx/2OuQu6QSa9cH0LiTzY+jzWmR3HEcdzNJHVYBqslc74QedlRSxdui4q5su
	 BsgQMaiwgg5Ew==
Date: Tue, 1 Jul 2025 11:18:56 -0700
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
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Message-ID: <20250701181856.GO10009@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>

On Mon, Jun 30, 2025 at 06:20:14PM +0200, Andrey Albershteyn wrote:
> Future patches will add new syscalls which use these functions. As
> this interface won't be used for ioctls only, the EOPNOSUPP is more
> appropriate return code.
> 
> This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

With EOPNOSUPP -> EOPNOTSUPP corrected,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> @@ -1126,7 +1126,13 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
>  
>  static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  {
> -	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +	int rc;
> +
> +	rc = vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
> +	if (rc == -EOPNOTSUPP)
> +		rc = -ENOIOCTLCMD;
> +
> +	return rc;
>  }
>  
>  static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index be62d97cc444..4e85fa00c092 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -79,7 +79,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  	int error;
>  
>  	if (!inode->i_op->fileattr_get)
> -		return -ENOIOCTLCMD;
> +		return -EOPNOTSUPP;
>  
>  	error = security_inode_file_getattr(dentry, fa);
>  	if (error)
> @@ -229,7 +229,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  	int err;
>  
>  	if (!inode->i_op->fileattr_set)
> -		return -ENOIOCTLCMD;
> +		return -EOPNOTSUPP;
>  
>  	if (!inode_owner_or_capable(idmap, inode))
>  		return -EPERM;
> @@ -271,6 +271,8 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
>  	int err;
>  
>  	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (err == -EOPNOTSUPP)
> +		err = -ENOIOCTLCMD;
>  	if (!err)
>  		err = put_user(fa.flags, argp);
>  	return err;
> @@ -292,6 +294,8 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
>  			fileattr_fill_flags(&fa, flags);
>  			err = vfs_fileattr_set(idmap, dentry, &fa);
>  			mnt_drop_write_file(file);
> +			if (err == -EOPNOTSUPP)
> +				err = -ENOIOCTLCMD;
>  		}
>  	}
>  	return err;
> @@ -304,6 +308,8 @@ int ioctl_fsgetxattr(struct file *file, void __user *argp)
>  	int err;
>  
>  	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (err == -EOPNOTSUPP)
> +		err = -ENOIOCTLCMD;
>  	if (!err)
>  		err = copy_fsxattr_to_user(&fa, argp);
>  
> @@ -324,6 +330,8 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  		if (!err) {
>  			err = vfs_fileattr_set(idmap, dentry, &fa);
>  			mnt_drop_write_file(file);
> +			if (err == -EOPNOTSUPP)
> +				err = -ENOIOCTLCMD;
>  		}
>  	}
>  	return err;
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 6f0e15f86c21..096d44712bb1 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
>  		return err;
>  
>  	err = vfs_fileattr_get(realpath->dentry, fa);
> -	if (err == -ENOIOCTLCMD)
> +	if (err == -EOPNOTSUPP)
>  		err = -ENOTTY;
>  	return err;
>  }
> 
> -- 
> 2.47.2
> 
> 

