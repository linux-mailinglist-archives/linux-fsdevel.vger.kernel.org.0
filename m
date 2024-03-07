Return-Path: <linux-fsdevel+bounces-13939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD48759F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E3A1C21E97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80313DB87;
	Thu,  7 Mar 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab/jy4yr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973B135A5C;
	Thu,  7 Mar 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849341; cv=none; b=pV5R2hUOiE20xlO3rS8lp/3XQpvV5NfXH2f20q2AyNG0P5HrHxi69nYW7teIcen5kIKLLVUJ8FnWxfJljyej6RevGbxUn5z69tE1xNkPaGIhTqnpjnP0UjK7l8ol5//cPtip//7+rRKm/lV0LrMy6EVSpiFplSd6U4j8C7o/kzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849341; c=relaxed/simple;
	bh=4oFCXK3f06MMFZR4uf9Ps4p8GReHgR3Sr/2meJQg5xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxigshYoDjAvg6Bm/YJvzs1YeUEFSi0oCJyX7gmyxhJV31SycA/WrX7M6U6bQH8yyUNvDM82goOJE5fGujXz+mePpunYRKUh+hysPmYk+t/55OHRTEEoJWJiEhFphswV0q95++JsuB9FPsP9t2luWeQI82psa+CE1HZ2pD4HP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab/jy4yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FFFC433C7;
	Thu,  7 Mar 2024 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849341;
	bh=4oFCXK3f06MMFZR4uf9Ps4p8GReHgR3Sr/2meJQg5xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ab/jy4yrz3JM/IzK5JR44EGuQwi5MQq2Rg9h2AQnx7Kt76u+H4sGwRJwb9ZqUcEre
	 lGheqpf0e/I9EM5GLOVQsu07SVIxGjMQxCNeDlMoYIjGADKiT26Ap96SNNcNUysXdv
	 J8FFl2AN7Ho2NkhO/zasmnyOO/KOTwpwADd2wDffnad92ustjLQHksfC608ufdKor7
	 uxctg1M0Zj1m0uuU2oKFSb68vU8Lu8BGE47W5zcDVvBkalGLlIwJ9YOfKMQRncMZMz
	 38JB/V4gRk2BPbCCJRojU/Gc18tXJrvHeoCwIJpTYEmO3apE76+/Lt3r21I4YXicmE
	 2g9+5f8r9x+iA==
Date: Thu, 7 Mar 2024 14:09:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 18/24] xfs: initialize fs-verity on file open and
 cleanup on inode destruction
Message-ID: <20240307220900.GV1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-20-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-20-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:41PM +0100, Andrey Albershteyn wrote:
> fs-verity will read and attach metadata (not the tree itself) from
> a disk for those inodes which already have fs-verity enabled.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_file.c  | 8 ++++++++
>  fs/xfs/xfs_super.c | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 632653e00906..17404c2e7e31 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -31,6 +31,7 @@
>  #include <linux/mman.h>
>  #include <linux/fadvise.h>
>  #include <linux/mount.h>
> +#include <linux/fsverity.h>
>  
>  static const struct vm_operations_struct xfs_file_vm_ops;
>  
> @@ -1228,10 +1229,17 @@ xfs_file_open(
>  	struct inode	*inode,
>  	struct file	*file)
>  {
> +	int		error = 0;

Not sure why error needs an initializer here?

Otherwise this patch looks good to me.

--D

> +
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC |
>  			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
> +
> +	error = fsverity_file_open(inode, file);
> +	if (error)
> +		return error;
> +
>  	return generic_file_open(inode, file);
>  }
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index afa32bd5e282..9f9c35cff9bf 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -49,6 +49,7 @@
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
> +#include <linux/fsverity.h>
>  
>  static const struct super_operations xfs_super_operations;
>  
> @@ -663,6 +664,7 @@ xfs_fs_destroy_inode(
>  	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
>  	XFS_STATS_INC(ip->i_mount, vn_rele);
>  	XFS_STATS_INC(ip->i_mount, vn_remove);
> +	fsverity_cleanup_inode(inode);
>  	xfs_inode_mark_reclaimable(ip);
>  }
>  
> -- 
> 2.42.0
> 
> 

