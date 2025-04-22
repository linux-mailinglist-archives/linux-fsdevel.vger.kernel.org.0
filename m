Return-Path: <linux-fsdevel+bounces-46981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD16A97127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 17:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B486188A216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507628F51D;
	Tue, 22 Apr 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNCi+Qtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8B1494A8;
	Tue, 22 Apr 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336162; cv=none; b=oxd6bAZJrxfR/Gv/J3omjr+4S7UHjz/beGx3pdkhZPEU/Ddp5ol8PPuy9NELQIl7/YDPQw1Xe5ZzjvvgcKchKT664VKLg/osVolQ7ilJCL5Ft5YLnTkroWhmu8HM2O1KnelcGLrnjgLtyEmQKSyrzDqtjQ+Lyf7ZJYpNr3KxmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336162; c=relaxed/simple;
	bh=mPUjzTsoFC/NJnHC63CpAKhwboTnx8d1kgG3aqCLZmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpVLF4Q6S/dhdJlWihPC25jbbrow0mBmpldfNq5T2EftZMOwvhAfeDav3qmEsVr+Z/9poM+cERWlTq3sH/LATmjaPnUzJk2WhDIDEJUZroiAwFle9AcM4F6jcxxsr/TkpDIXWQHTLzD0rYJfa5/zin8qB9kzdkRp1jabWm9Cemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNCi+Qtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB819C4CEE9;
	Tue, 22 Apr 2025 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745336161;
	bh=mPUjzTsoFC/NJnHC63CpAKhwboTnx8d1kgG3aqCLZmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNCi+QtlmV3zMddqk2AxBkg13aO6TKuCcLsUovdpOGQPNpLStJPME4FMt8ji8KSNQ
	 07/3fLS3oUys8Af/ghB5nx/U28u7S3ucANeLNt1b3Ndf26wdnmkCBDYXAQOAQdOlSq
	 Mcy/vKD6HO8+1d/N62//eUDtkx6Dlh2GUmlKqqaESrH3uaJLytH+ljiUcaEEiv8puj
	 CsjQ14zFex5k0ClOBTlxYym9hNAh/WRpWBkPMHchg8TLysprWkZxRkr4pe21pPXsOw
	 5TifmZAZG5rTMRGFQwiZDC/sHvA0F+gRi3rHU0WHpc2GXeq0vIMuXds4+cLYQDyInx
	 /7nFYP0/IrrCQ==
Date: Tue, 22 Apr 2025 17:35:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: hch <hch@lst.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"djwong@kernel.org" <djwong@kernel.org>, "ebiggers@google.com" <ebiggers@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Xiao Ni <xni@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422-goldkette-hitzig-95ddd8f86168@brauner>
References: <20250417064042.712140-1-hch@lst.de>
 <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3>
 <20250422055149.GB29356@lst.de>
 <20250422-angepackt-reisen-bc24fbec2702@brauner>
 <20250422081736.GA674@lst.de>
 <20250422141505.GA25426@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422141505.GA25426@lst.de>

On Tue, Apr 22, 2025 at 04:15:05PM +0200, hch wrote:
> Turns out this doesn't work.  We used to have the request_mask, but it
> got removed in 25fbcd62d2e1 ("bdev: use bdev_io_min() for statx block
> size") so that stat can expose the block device min I/O size in
> st_blkdev, and as the blksize doesn't have it's own request_mask flag
> is hard to special case.
> 
> So maybe the better question is why devtmpfs even calls into
> vfs_getattr?  As far as I can tell handle_remove is only ever called on
> the actual devtmpfs file system, so we don't need to go through the
> VFS to query i_mode.  i.e. the patch should also fix the issue.  The

Hm, yes. Just looked at the history and it dates back to Kay's original
devtmpfs patch.

> modify_change is probably not needed either, but for now I'm aiming
> for the minimal fix.
> 
> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
> index 6dd1a8860f1c..53fb0829eb7b 100644
> --- a/drivers/base/devtmpfs.c
> +++ b/drivers/base/devtmpfs.c
> @@ -296,7 +296,7 @@ static int delete_path(const char *nodepath)
>  	return err;
>  }
>  
> -static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *stat)
> +static int dev_mynode(struct device *dev, struct inode *inode)
>  {
>  	/* did we create it */
>  	if (inode->i_private != &thread)

It seems off that there are deletion requests coming in for a files that
weren't created by devtmpfsd. But maybe that can somehow happen.

> @@ -304,13 +304,13 @@ static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *sta
>  
>  	/* does the dev_t match */
>  	if (is_blockdev(dev)) {
> -		if (!S_ISBLK(stat->mode))
> +		if (!S_ISBLK(inode->i_mode))
>  			return 0;
>  	} else {
> -		if (!S_ISCHR(stat->mode))
> +		if (!S_ISCHR(inode->i_mode))
>  			return 0;
>  	}
> -	if (stat->rdev != dev->devt)
> +	if (inode->i_rdev != dev->devt)
>  		return 0;
>  
>  	/* ours */
> @@ -321,8 +321,7 @@ static int handle_remove(const char *nodename, struct device *dev)
>  {
>  	struct path parent;
>  	struct dentry *dentry;
> -	struct kstat stat;
> -	struct path p;
> +	struct inode *inode;
>  	int deleted = 0;
>  	int err;
>  
> @@ -330,11 +329,8 @@ static int handle_remove(const char *nodename, struct device *dev)
>  	if (IS_ERR(dentry))
>  		return PTR_ERR(dentry);
>  
> -	p.mnt = parent.mnt;
> -	p.dentry = dentry;
> -	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
> -			  AT_STATX_SYNC_AS_STAT);
> -	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
> +	inode = d_inode(dentry);
> +	if (dev_mynode(dev, inode)) {
>  		struct iattr newattrs;
>  		/*
>  		 * before unlinking this node, reset permissions
> @@ -342,7 +338,7 @@ static int handle_remove(const char *nodename, struct device *dev)
>  		 */
>  		newattrs.ia_uid = GLOBAL_ROOT_UID;
>  		newattrs.ia_gid = GLOBAL_ROOT_GID;
> -		newattrs.ia_mode = stat.mode & ~0777;
> +		newattrs.ia_mode = inode->i_mode & ~0777;
>  		newattrs.ia_valid =
>  			ATTR_UID|ATTR_GID|ATTR_MODE;
>  		inode_lock(d_inode(dentry));

