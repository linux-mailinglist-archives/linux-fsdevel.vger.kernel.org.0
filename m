Return-Path: <linux-fsdevel+bounces-117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693907C5D39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B471C20FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3C3A29B;
	Wed, 11 Oct 2023 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFzgnBJg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC0D3A265;
	Wed, 11 Oct 2023 18:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB26C433C8;
	Wed, 11 Oct 2023 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050587;
	bh=hTQdb/ySGtLR85GAVwxgYWWykHG8VYZMveF/cHAkxZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFzgnBJg9CMDm+kpGMDdGCTAAO4wz9N3Zt4O2jexdIgZxTLS4lVL08E3Bz6KrkB8Q
	 d6Vp09F4t8JkH6pGpUV0LIS+Ll3DAYtyqSfMRMlAzxNLbc0XsvsQEXK+WPKdgLbwZt
	 Bt8qk/3SXskxtFlyjspM4oSirPEswuFRi8a2eQ2M5xyu8N561JBX3XIKLKrnCH9ySq
	 7yMCfZ/yuUXZ7G0X9drvfdZ6GLAN5hezPNxRfbybV+na4deHc2o3ITDxUs8YevctT2
	 LNZ/xvs+Mq8VC+8+63e8QG4Y4RmgT+FmYIH1OaxG7A5uacYvcDiJzCptciAI2V1wwp
	 ns4RcgzNQU32g==
Date: Wed, 11 Oct 2023 11:56:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 20/28] xfs: add fs-verity ro-compat flag
Message-ID: <20231011185627.GT21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-21-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-21-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:14PM +0200, Andrey Albershteyn wrote:
> To mark inodes sealed with fs-verity the new XFS_DIFLAG2_VERITY flag
> will be added in further patch. This requires ro-compat flag to let
> older kernels know that fs with fs-verity can not be modified.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_format.h | 1 +
>  fs/xfs/libxfs/xfs_sb.c     | 2 ++
>  fs/xfs/xfs_mount.h         | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 371dc07233e0..ef617be2839c 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -353,6 +353,7 @@ xfs_sb_has_compat_feature(
>  #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>  #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>  #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> +#define XFS_SB_FEAT_RO_COMPAT_VERITY   (1 << 4)		/* fs-verity */
>  #define XFS_SB_FEAT_RO_COMPAT_ALL \
>  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> index 4191da4fb669..236f3b833fa4 100644
> --- a/fs/xfs/libxfs/xfs_sb.c
> +++ b/fs/xfs/libxfs/xfs_sb.c
> @@ -162,6 +162,8 @@ xfs_sb_version_to_features(
>  		features |= XFS_FEAT_REFLINK;
>  	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
>  		features |= XFS_FEAT_INOBTCNT;
> +	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_VERITY)
> +		features |= XFS_FEAT_VERITY;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
>  		features |= XFS_FEAT_FTYPE;
>  	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 3d77844b255e..95fba704f60e 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -288,6 +288,7 @@ typedef struct xfs_mount {
>  #define XFS_FEAT_BIGTIME	(1ULL << 24)	/* large timestamps */
>  #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
>  #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
> +#define XFS_FEAT_VERITY		(1ULL << 27)	/* fs-verity */
>  
>  /* Mount features */
>  #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
> @@ -351,6 +352,7 @@ __XFS_HAS_FEAT(inobtcounts, INOBTCNT)
>  __XFS_HAS_FEAT(bigtime, BIGTIME)
>  __XFS_HAS_FEAT(needsrepair, NEEDSREPAIR)
>  __XFS_HAS_FEAT(large_extent_counts, NREXT64)
> +__XFS_HAS_FEAT(verity, VERITY)
>  
>  /*
>   * Mount features
> -- 
> 2.40.1
> 

