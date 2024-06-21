Return-Path: <linux-fsdevel+bounces-22146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85920912DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F142B263E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD817B505;
	Fri, 21 Jun 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOyrrsvo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525316849B;
	Fri, 21 Jun 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996923; cv=none; b=JSZ54bLEOQ3Gsy8FOHVzTBzv+OUivvfcs1RsVlDD0Vau42qKqau+Da0YeDdDkld4zFXQBUiMvbkUVTokBDAyEb5IYQOH/XpoIu5NdgFxjMg5fXsHqLxuXo2xrSBCB68eKdl+cH906okf2HL/vmwacBo8xz/qFohIG8dezjdW2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996923; c=relaxed/simple;
	bh=5OufThjKNtNOHUxuwtp23KhyPdY9MR9cOGItOEOZ35I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Umz0WkQlTgRPO9uCgrSlHBwJrzpnDAecvQ16CgnYYxPJxDruwEJjrdQckLVt+qZoU/SOkPGUBP7duxvO0/UwiWWJd6cIv9xZkf5yZrtKVMYTss7KuRh46dq/ZdcIj0t+ceMGWgXtTnrowt2ye+s7VxC4qkwq4S/ICg9brxU7hEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOyrrsvo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0426C2BBFC;
	Fri, 21 Jun 2024 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718996922;
	bh=5OufThjKNtNOHUxuwtp23KhyPdY9MR9cOGItOEOZ35I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOyrrsvoUAmZEnbGFCLRTbYdaJFIFLh4J6mC7xU+SsDCak9df2qtFGpnw2IwRrLrc
	 I4KFs19iHp6p4a/vu/DU9Kz5eG8EvEai2d/g9EWm8RtHWP8ORw7IsOdjBRAdjTKHCd
	 2D7FoNiysjMdGHwipReXEa9EO/J5SwQeOps3YdTCNh6SB1bnSxwCCtpaKeRZEO5SHx
	 Zi2pa6HNdEOXUu3p1b4j+uk0Y5jb4ausfMS762Z20fpNJ4Ye11n1PbU+PGpHng4Ux8
	 tyzu4xavQTxW6H10slctxwdB4U2x5IfZB/7qoYKxsS4FrUVEoirsQ0BEZlEAFkyMDV
	 2UoGzwbbpqgqw==
Date: Fri, 21 Jun 2024 12:08:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 08/13] xfs: Do not free EOF blocks for forcealign
Message-ID: <20240621190842.GN3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-9-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-9-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:35AM +0000, John Garry wrote:
> For when forcealign is enabled, we want the EOF to be aligned as well, so
> do not free EOF blocks.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_bmap_util.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index e5d893f93522..56b80a7c0992 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -539,8 +539,13 @@ xfs_can_free_eofblocks(
>  	 * forever.
>  	 */
>  	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
> -	if (xfs_inode_has_bigrtalloc(ip))
> +
> +	/* Do not free blocks when forcing extent sizes */

"Only try to free blocks beyond the allocation unit that crosses EOF" ?

Otherwise seems fine to me
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +	if (xfs_inode_has_forcealign(ip))
> +		end_fsb = roundup_64(end_fsb, ip->i_extsize);
> +	else if (xfs_inode_has_bigrtalloc(ip))
>  		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
> +
>  	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
>  	if (last_fsb <= end_fsb)
>  		return false;
> -- 
> 2.31.1
> 
> 

