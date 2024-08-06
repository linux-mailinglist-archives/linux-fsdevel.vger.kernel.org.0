Return-Path: <linux-fsdevel+bounces-25164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25149497F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9AD1C20CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12CD82876;
	Tue,  6 Aug 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7+7LAWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05C7580C;
	Tue,  6 Aug 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970994; cv=none; b=U9dMp1mKLUUHU3dl9Vl9566K7ruj4nOHET1BdgYiW8QaWsr/qHJ7PlbokF5wNOoihoz0EOqvSRxeOWvcQXykkPWBm111HXhk3AH4lMoa7UVJ7tgvLcDlovBJk6Vhy2A3i9JhdhzWIxF2o98EdhXYmeMtGhAm1BfJNARYCqxE12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970994; c=relaxed/simple;
	bh=Bp0oNZJxEYUtu8d6zx/YyyWK9ATHKzHNwx04mLel4vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e11sS2LqXjXilK0PQIMHAmmZNl2lIr11aS8UhrV2PhOk0aXksLfobZ2i+7gM25LLkUwghB99siAzxp4OjDLCIG3TgAy/qqyNhQn5aqpwolm8wxiafxvtLV+mu28g4y3bxBO51PxTFoXCbweW/3P/yg4tTiIhE5IQsvsBEy4fu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7+7LAWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63C3C32786;
	Tue,  6 Aug 2024 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970993;
	bh=Bp0oNZJxEYUtu8d6zx/YyyWK9ATHKzHNwx04mLel4vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7+7LAWqxvwWgAzAHjy+CSbAbQub19e2ggaVo6C6EK8w/B1/pk4e6zuUOi2+KAyPd
	 9nCO/NufWvr5rPgDjjR7WcF/aBgiYK8xZ9Mb0N6sSb+NfWYk9WRAZxQz7NqBxSuBOU
	 VNpAVRZCtL+du06DoK75arNK8F72uV6KkAFFgc2rS76S7v2NCoFO271LgNDV+3B8vD
	 II3dd6+DrRX4prbem64JUkUXYa/B/6ELeVNQCK+bJRC4bmGqa75E/1waJOFq+f5ybq
	 G8R402GvWK2rCVEDFH0zqCKqygYJzEA2rt3ZWoeFBsQOh9RElNFNYF1QaCirB+ApU9
	 yBZTkEQ7fEhJw==
Date: Tue, 6 Aug 2024 12:03:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 09/14] xfs: Update xfs_setattr_size() for forcealign
Message-ID: <20240806190313.GL623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-10-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:52PM +0000, John Garry wrote:
> For when an inode has forcealign, reserve blocks for same reason which we
> were doing for big RT alloc.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 1cdc8034f54d..6e017aa6f61d 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -926,12 +926,12 @@ xfs_setattr_size(
>  	}
>  
>  	/*
> -	 * For realtime inode with more than one block rtextsize, we need the
> +	 * For inodes with more than one block alloc unitsize, we need the
>  	 * block reservation for bmap btree block allocations/splits that can
>  	 * happen since it could split the tail written extent and convert the
>  	 * right beyond EOF one to unwritten.
>  	 */
> -	if (xfs_inode_has_bigrtalloc(ip))
> +	if (xfs_inode_alloc_fsbsize(ip) > 1)
>  		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
>  
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, resblks,
> -- 
> 2.31.1
> 
> 

