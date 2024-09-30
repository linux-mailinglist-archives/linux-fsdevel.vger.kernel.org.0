Return-Path: <linux-fsdevel+bounces-30391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C798AA0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58706B25AB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB806195FD1;
	Mon, 30 Sep 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtvppcTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CA18F2D4;
	Mon, 30 Sep 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714493; cv=none; b=bF0/yd8Bt1rvGgb++eBrpta2O0GJkTyQ3TtWjHOr5hENQ3UJ4ZAuAMerPl71nVtFfxZm1Dx8M6OveSeafsKEz76WjuLpOXQChpObHmRaHDWpyWqVPArgzCnvk52/SJBVSvRyPCfJGkEZz+I5XY8rt9liIRuyMxcNOlgRJ6zjsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714493; c=relaxed/simple;
	bh=1coCZtPIlem9r2aOca7Bq6JfUeE4Sx1YImfzkb+He6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2GcBP3l3nt0q61E1zJCbOIByIRY9owmZcrRdekwM/DEN//N4pBUjXONyR81fUa1NFOIMtKlg46VRTMycK3qCtRb3tHQa7SYacGSb3+k82J8as30CJbhXt3kCJ2OQsI8NHx7iLL/maY+Tffbc8xZfe7MLvpIbdMSFffx97ZnfYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtvppcTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DE2C4CEC7;
	Mon, 30 Sep 2024 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714490;
	bh=1coCZtPIlem9r2aOca7Bq6JfUeE4Sx1YImfzkb+He6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtvppcTeHQaEI7o00rbs7e1NtJXT0MdSbeelfzZkQuubN4n230tEBRITeUj+4TGlr
	 BZbvH/0NlThjulMRferPO+c5ICyAT8LV1y2u7Yk5XA6O8O0QhvtQC/aOHEXxG+G11n
	 +pZnxKqzLdRjENS8ObdCN7zYufGk+B95QrfaFDZEZU4aImBsrOZ0bmvqq4iouITf/P
	 2k0th3l3CXXwFFvcUHWxRvgxW4ZMHiO390YVD6R1l3cJF5wzSsUsIp0tHQCmcSSivI
	 4jxDGMUHhHKbLQWIgEGujiYhiHvyPsIXiF3iTbADCwKOlaUvFXLWbRDGbXawe1q+x+
	 D0ebLYFkX6Ewg==
Date: Mon, 30 Sep 2024 09:41:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <20240930164130.GQ21853@frogsfrogsfrogs>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-8-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930125438.2501050-8-john.g.garry@oracle.com>

On Mon, Sep 30, 2024 at 12:54:38PM +0000, John Garry wrote:
> For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
> flag. Only direct IO is currently supported, so check for that also.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index fa6a44b88ecc..a358657a1ae6 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1208,6 +1208,16 @@ xfs_file_remap_range(
>  	return remapped > 0 ? remapped : ret;
>  }
>  
> +static bool
> +xfs_file_open_can_atomicwrite(
> +	struct inode		*inode,
> +	struct file		*file)
> +{
> +	if (!(file->f_flags & O_DIRECT))
> +		return false;
> +	return xfs_inode_can_atomicwrite(XFS_I(inode));
> +}
> +
>  STATIC int
>  xfs_file_open(
>  	struct inode	*inode,
> @@ -1216,6 +1226,8 @@ xfs_file_open(
>  	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
>  		return -EIO;
>  	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +	if (xfs_file_open_can_atomicwrite(inode, file))
> +		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
>  	return generic_file_open(inode, file);
>  }
>  
> -- 
> 2.31.1
> 
> 

