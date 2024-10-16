Return-Path: <linux-fsdevel+bounces-32145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774469A139D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10222B203A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B92170A8;
	Wed, 16 Oct 2024 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6vQ30zw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAB2144C3;
	Wed, 16 Oct 2024 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109634; cv=none; b=nNnpH8gHSXfxAeODilLcxXdb00iRmYAkLhJOWBK+w2A/vAMXeEFQWJGI/rCXovxdhMaQnKVJFRB0TmpYx3gGixUw5K09/Lfe+mr7h8c699fFohoC9ScBzbLmsFLGVva93sNVpQqJ//zYPtNt/MXWPYFNS6H5J7jf6MpcDGIZLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109634; c=relaxed/simple;
	bh=VgjQ478YncvsdTabXKQrMpIeuCGxwKtvvuK8UNlZgNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBd198g3pIMsaVSo0b4DWowSqpL3ydUsgdrpoEcJyR1LC10WgSuuEjX9qkZhed8MwYqT/zvmAS5vBKQBACIpXM06EOoOGcTj3UEbuCYWUhwkIJ4zt2MabeLN4tfVWAQRZS7KN79hAzat8Ag5EswZNyL85IRubjuJJzWKcJDDrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6vQ30zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283A3C4CEC5;
	Wed, 16 Oct 2024 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729109634;
	bh=VgjQ478YncvsdTabXKQrMpIeuCGxwKtvvuK8UNlZgNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6vQ30zwmphZ0bxRiDwuaOKD5DTXX4cVU0SH4moU5ODvqWcnRye1kpALnEwcuPTfZ
	 JLRSXCQJRkkSR00UJkZwfTOH/B87uqcMeHNQdAmsgd6d5mqdyAHEWhXOZLM2M1pefk
	 uy7js/8y/03I05tXr501BWqGoCA0k0ZBWwmEAMFNOcLIxeX40lIRbQTPGNm4x38VNE
	 1yQ98DMX9l0RWIL0hU8HUQJ042zsp8i1PE05p9G82Sa41ChcSFPP8qd5BwTJEcFm1d
	 9sXIO4ogjo1hhi6EekCszaPAPQP07wbaaT0KIVvNmYl0b/Sq6uQkZVlcovdyriyDyh
	 N3LHWyB2iXg+Q==
Date: Wed, 16 Oct 2024 13:13:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v9 8/8] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <20241016201353.GR21853@frogsfrogsfrogs>
References: <20241016100325.3534494-1-john.g.garry@oracle.com>
 <20241016100325.3534494-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016100325.3534494-9-john.g.garry@oracle.com>

On Wed, Oct 16, 2024 at 10:03:25AM +0000, John Garry wrote:
> Set FMODE_CAN_ATOMIC_WRITE flag if we can atomic write for that inode.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Woot!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 1ccbc1eb75c9..ca47cae5a40a 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1253,6 +1253,8 @@ xfs_file_open(
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
> +		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
>  }
>  
> -- 
> 2.31.1
> 
> 

