Return-Path: <linux-fsdevel+bounces-113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64617C5B9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E711C20FD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5D1D54E;
	Wed, 11 Oct 2023 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmvM1TrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26971D524;
	Wed, 11 Oct 2023 18:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA2AC433C8;
	Wed, 11 Oct 2023 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050117;
	bh=jbbfJiF62YBYzMD/pdwAlQvbc8jryuoyLG9lrd9hXAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmvM1TrK3oFqA63mewqBXYw1vtbL/dH4zd88ElOSON47K9Sc5Ir7fOvTP/pOeMQe+
	 LoSLKygV63WMpmEhVFKjOtNYyi1gqgtBtoh+g887d1Leca/IU4vbkvkXD9p4pjKzAn
	 9HJPEDzF3JgaKiN73JJy+jYKYGaV8ORne/o7PMr4I6gBJSZ/1s0gSrj1oINq8BrYpJ
	 5Ai7qaK6kR5IsrhrZTmSHyDH9kHOgQW8iyyNqCUYsY3WXGRq8Am+sJTzLq19Dxmkuf
	 OEiPjDft2vubQ2tGxwEcqqLbQTQPF7kWT32eNcKBmTWJYJzs6pFyAAIFWE6tKzPtPg
	 VKORKQbI3CoDg==
Date: Wed, 11 Oct 2023 11:48:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 17/28] xfs: add attribute type for fs-verity
Message-ID: <20231011184836.GQ21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-18-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-18-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:11PM +0200, Andrey Albershteyn wrote:
> The Merkle tree blocks and descriptor are stored in the extended
> attributes of the inode. Add new attribute type for fs-verity
> metadata. Add XFS_ATTR_INTERNAL_MASK to skip parent pointer and
> fs-verity attributes as those are only for internal use. While we're
> at it add a few comments in relevant places that internally visible
> attributes are not suppose to be handled via interface defined in
> xfs_xattr.c.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/libxfs/xfs_da_format.h  | 10 +++++++++-
>  fs/xfs/libxfs/xfs_log_format.h |  1 +
>  fs/xfs/xfs_ioctl.c             |  5 +++++
>  fs/xfs/xfs_trace.h             |  1 +
>  fs/xfs/xfs_xattr.c             |  9 +++++++++
>  5 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
> index 6deefe03207f..b56bdae83563 100644
> --- a/fs/xfs/libxfs/xfs_da_format.h
> +++ b/fs/xfs/libxfs/xfs_da_format.h
> @@ -699,14 +699,22 @@ struct xfs_attr3_leafblock {
>  #define	XFS_ATTR_ROOT_BIT	1	/* limit access to trusted attrs */
>  #define	XFS_ATTR_SECURE_BIT	2	/* limit access to secure attrs */
>  #define	XFS_ATTR_PARENT_BIT	3	/* parent pointer attrs */
> +#define	XFS_ATTR_VERITY_BIT	4	/* verity merkle tree and descriptor */
>  #define	XFS_ATTR_INCOMPLETE_BIT	7	/* attr in middle of create/delete */
>  #define XFS_ATTR_LOCAL		(1u << XFS_ATTR_LOCAL_BIT)
>  #define XFS_ATTR_ROOT		(1u << XFS_ATTR_ROOT_BIT)
>  #define XFS_ATTR_SECURE		(1u << XFS_ATTR_SECURE_BIT)
>  #define XFS_ATTR_PARENT		(1u << XFS_ATTR_PARENT_BIT)
> +#define XFS_ATTR_VERITY		(1u << XFS_ATTR_VERITY_BIT)
>  #define XFS_ATTR_INCOMPLETE	(1u << XFS_ATTR_INCOMPLETE_BIT)
>  #define XFS_ATTR_NSP_ONDISK_MASK \
> -			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT)
> +			(XFS_ATTR_ROOT | XFS_ATTR_SECURE | XFS_ATTR_PARENT | \
> +			 XFS_ATTR_VERITY)
> +
> +/*
> + * Internal attributes not exposed to the user
> + */
> +#define XFS_ATTR_INTERNAL_MASK (XFS_ATTR_PARENT | XFS_ATTR_VERITY)
>  
>  /*
>   * Alignment for namelist and valuelist entries (since they are mixed
> diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
> index 0bc1749fb7bb..c42cc58cd152 100644
> --- a/fs/xfs/libxfs/xfs_log_format.h
> +++ b/fs/xfs/libxfs/xfs_log_format.h
> @@ -975,6 +975,7 @@ struct xfs_icreate_log {
>  #define XFS_ATTRI_FILTER_MASK		(XFS_ATTR_ROOT | \
>  					 XFS_ATTR_SECURE | \
>  					 XFS_ATTR_PARENT | \
> +					 XFS_ATTR_VERITY | \
>  					 XFS_ATTR_INCOMPLETE)
>  
>  /*
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 55bb01173cde..3d6d680b6cf3 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -351,6 +351,11 @@ static unsigned int
>  xfs_attr_filter(
>  	u32			ioc_flags)
>  {
> +	/*
> +	 * Only externally visible attributes should be specified here.
> +	 * Internally used attributes (such as parent pointers or fs-verity)
> +	 * should not be exposed to userspace.
> +	 */
>  	if (ioc_flags & XFS_IOC_ATTR_ROOT)
>  		return XFS_ATTR_ROOT;
>  	if (ioc_flags & XFS_IOC_ATTR_SECURE)
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 3926cf7f2a6e..3696709907bf 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -82,6 +82,7 @@ struct xfs_perag;
>  #define XFS_ATTR_FILTER_FLAGS \
>  	{ XFS_ATTR_ROOT,	"ROOT" }, \
>  	{ XFS_ATTR_SECURE,	"SECURE" }, \
> +	{ XFS_ATTR_VERITY,	"VERITY" }, \
>  	{ XFS_ATTR_INCOMPLETE,	"INCOMPLETE" }
>  
>  DECLARE_EVENT_CLASS(xfs_attr_list_class,
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index a3975f325f4e..56f7f4122fcb 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -20,6 +20,12 @@
>  
>  #include <linux/posix_acl_xattr.h>
>  
> +/*
> + * This file defines interface to work with externally visible extended
> + * attributes, such as those in system or security namespaces. This interface

"...such as those in user, system, or security namespaces."

With that fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> + * should not be used for internally used attributes (consider xfs_attr.c).
> + */
> +
>  /*
>   * Get permission to use log-assisted atomic exchange of file extents.
>   *
> @@ -241,6 +247,9 @@ xfs_xattr_put_listent(
>  
>  	ASSERT(context->count >= 0);
>  
> +	if (flags & XFS_ATTR_INTERNAL_MASK)
> +		return;
> +
>  	if (flags & XFS_ATTR_ROOT) {
>  #ifdef CONFIG_XFS_POSIX_ACL
>  		if (namelen == SGI_ACL_FILE_SIZE &&
> -- 
> 2.40.1
> 

