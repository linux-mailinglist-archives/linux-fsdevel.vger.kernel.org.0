Return-Path: <linux-fsdevel+bounces-13938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E08759F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E529B23DA9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5313EFE6;
	Thu,  7 Mar 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3XSjeSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD813BAFA;
	Thu,  7 Mar 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849193; cv=none; b=rwNnhHGL8cFNvzD9xdaVufO5GWXVU2lWTHpNYPxBD4o9/hLShUlBR7ghH6mW6fa/UjEuJMGuF4C8ErSK1BufowRNQcOTzOVa1RzriqlPQ8YU4Cyhedm/o81K56DuUuIZcJhdoANDbNuI/1bbI0p/o4CeaJs2fwnJnL3FZSYSaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849193; c=relaxed/simple;
	bh=+MYk8RwYFjZoDbM8OeRIO1JSKDi6WTOFlMApfhs7yJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck3R6QEoxYXBKk+JrY4sdd6ZtGFkPKTqVI5eoSs3441TIeJBiZukAxi9qZAcZe9TZIO5NoCElGWAX+FC4v81WH8+puELHKMVjJPLroEFAy8DbAYaDTOKNfI+nHBKGJ9erHzh1fL/oj4x0OFj/6XXrtmL90yz9D9wh4BsfUxl5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3XSjeSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEB9C433F1;
	Thu,  7 Mar 2024 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849192;
	bh=+MYk8RwYFjZoDbM8OeRIO1JSKDi6WTOFlMApfhs7yJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3XSjeSrfXsH9/P+jGvo/2A7Dz8Jhq96crx/z+MLp8XauK5lZ48qhYb+yVeU4NaMV
	 /e3a3RltnoGRQhpA5n2j8wj7CqUue8n+HbYa8K/ob/fRoOKuRvZF0f7Ywk7tN/PG27
	 PgoXuCc/lvNV581/e5qqt47gSnbCZUbN6ThvZ8L25IUUtY3V945bZ3i5wTgGrSdvrL
	 Dgx+scYAYsO4maC9OBUdvipa39hmDZu7eRMSvnOYe3kut0QvtMiKnl8t3ztViDS4aF
	 pLfvf3k/ZCyQYMwYv0gSPVfvBJiWIoFeRrSL9NZjs9xvmkj/cq8xixxcuqd+W6ja0M
	 CFytrSx6MLorw==
Date: Thu, 7 Mar 2024 14:06:32 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 17/24] xfs: add inode on-disk VERITY flag
Message-ID: <20240307220632.GU1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-19-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-19-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:40PM +0100, Andrey Albershteyn wrote:
> Add flag to mark inodes which have fs-verity enabled on them (i.e.
> descriptor exist and tree is built).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_format.h | 4 +++-
>  fs/xfs/xfs_inode.c         | 2 ++
>  fs/xfs/xfs_iops.c          | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 93d280eb8451..3ce2902101bc 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -1085,16 +1085,18 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
>  #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
>  #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
>  #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
> +#define XFS_DIFLAG2_VERITY_BIT	5	/* inode sealed by fsverity */
>  
>  #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
>  #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
>  #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
>  #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
>  #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
> +#define XFS_DIFLAG2_VERITY	(1 << XFS_DIFLAG2_VERITY_BIT)
>  
>  #define XFS_DIFLAG2_ANY \
>  	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
> -	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
> +	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | XFS_DIFLAG2_VERITY)
>  
>  static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
>  {
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index ea48774f6b76..59446e9e1719 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -607,6 +607,8 @@ xfs_ip2xflags(
>  			flags |= FS_XFLAG_DAX;
>  		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
>  			flags |= FS_XFLAG_COWEXTSIZE;
> +		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
> +			flags |= FS_XFLAG_VERITY;
>  	}
>  
>  	if (xfs_inode_has_attr_fork(ip))
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 66f8c47642e8..0e5cdb82b231 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1241,6 +1241,8 @@ xfs_diflags_to_iflags(
>  		flags |= S_NOATIME;
>  	if (init && xfs_inode_should_enable_dax(ip))
>  		flags |= S_DAX;
> +	if (xflags & FS_XFLAG_VERITY)
> +		flags |= S_VERITY;
>  
>  	/*
>  	 * S_DAX can only be set during inode initialization and is never set by
> -- 
> 2.42.0
> 
> 

