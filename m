Return-Path: <linux-fsdevel+bounces-119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA6B7C5D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C2328284D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6591412E4D;
	Wed, 11 Oct 2023 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9wryYZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCF3A29B;
	Wed, 11 Oct 2023 19:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8C1C433C9;
	Wed, 11 Oct 2023 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050851;
	bh=il6XIFzKh3auCiOTJQOAhU40etXtr6zEXI2tiA6s+eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9wryYZO4f60j6ILdmC39Ynh6Vs6xrGnkrYTva11Zta85T4QTAcH839BSqsq0dJWs
	 PKBw69cmMy0bD4xj1irqChJdkJ4Rknn0+9uyf3dgiOHgVR1UShYQSkRg3qmFD+zCJ0
	 gVRrZDVJtirInU8ijfjlT6ijODopCQ1oFgv/05CmOoL1vvfLAqqWeP0nNNKdU9Jfyo
	 W1TfenjvNv23lMhTjJrpYPPNlIs/iO1PnMIhbVChiTGlxDethOL6MF7z6cgTLHN+b2
	 BeRNzAUNfBVkXEL8RUmbYy+ukde/88EDE0LNMx3l4pqETILCwib/t/W2UYvAAF+vtx
	 kF3mK5RWiZgzg==
Date: Wed, 11 Oct 2023 12:00:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 23/28] xfs: don't allow to enable DAX on fs-verity
 sealsed inode
Message-ID: <20231011190050.GV21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-24-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-24-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:17PM +0200, Andrey Albershteyn wrote:
> fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
> inodes which already have fs-verity enabled. The opposite is checked
> when fs-verity is enabled, it won't be enabled if DAX is.

Why can't we allow S_DAX and S_VERITY at the same time?  Is there a
design problem that prohibits checking the verity data when we go to
copy the pmem to userspace or take a read fault, or is S_DAX support
simply not implemented?

--D

> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_iops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 9f2d5c2505ae..3153767f0d6f 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1209,6 +1209,8 @@ xfs_inode_should_enable_dax(
>  		return false;
>  	if (!xfs_inode_supports_dax(ip))
>  		return false;
> +	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
> +		return false;
>  	if (xfs_has_dax_always(ip->i_mount))
>  		return true;
>  	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
> -- 
> 2.40.1
> 

