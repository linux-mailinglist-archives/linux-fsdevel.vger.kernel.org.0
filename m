Return-Path: <linux-fsdevel+bounces-27414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D22961480
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F686282E81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EA1CDFBD;
	Tue, 27 Aug 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tptp5/vZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6C1CF2A1;
	Tue, 27 Aug 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777082; cv=none; b=DxPpMAilNcKicDNAZSkch8GnXoTQGqt4U+CQe3L+0V0TEqka5m38yh6xQjUCvhTUPNXI/OGo074z1eYz3QIHYrAAI0KmthHHFIU/Dk4HXH3vIp10A2Yy+YWQuZ8iStCvSmAurs/oeAbzDIgBxfVdCrK2UeLa/24EFo6DnyMQHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777082; c=relaxed/simple;
	bh=aiItVTsDzXc6IYjmIKuU0NOE//Uk0yBuL1z4m19bF+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JztCJW08z0efzkJ4s6q1SQpkqNdyOKTnBCcFHAfHrDO1lYDaqB39uTbQKH4UbxcRyFpQU7UEYNXVM6XYK8bm8NO38LC7BAdanwadRjjvyyN6PnfwDBBjwEFp4MuRUnECYTbFdcMoot0Y4+nC5+MG7Bt4R9kEZ1Pu+zJqWS514lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tptp5/vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2157DC4AF0C;
	Tue, 27 Aug 2024 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724777081;
	bh=aiItVTsDzXc6IYjmIKuU0NOE//Uk0yBuL1z4m19bF+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tptp5/vZihiwSYCyDpB4+quRmZ/oPeHwN1KSlXoS8WKhRLGSHVZNWXFB91unjrL3R
	 pC+/mMVgvaEHfR4wmJmPtvZ+NRklFtiqDvY6kHatgV1TxxONlFm6Z39ZlDWhDJfEFI
	 D6ySiC7DoDPE/YItKXWIr67SEt+1sdCVSczy586FLXME54NM/DE2mu/Q/GQnu+57/7
	 MBoIHfgHX/16+QwVjuwv7bAGPVvQMjRkYOM9Dq1Vqk6qtIc+WFOJiIzvpKz9m1MxAz
	 yTh1HX5+gYAJa07aifhB0FY6eP0DvwSu7DbsdIC13re3jK8ozzHs5YRnyV0CLGkFop
	 bANHUzZPa1Qww==
Date: Tue, 27 Aug 2024 09:44:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/10] xfs: punch delalloc extents from the COW fork for
 COW writes
Message-ID: <20240827164440.GE865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-11-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:57AM +0200, Christoph Hellwig wrote:
> When ->iomap_end is called on a short write to the COW fork it needs to
> punch stale delalloc data from the COW fork and not the data fork.
> 
> Ensure that IOMAP_F_NEW is set for new COW fork allocations in
> xfs_buffered_write_iomap_begin, and then use the IOMAP_F_SHARED flag
> in xfs_buffered_write_delalloc_punch to decide which fork to punch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 22e9613a995f12..4113e09cb836a8 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1195,7 +1195,7 @@ xfs_buffered_write_iomap_begin(
>  		xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
>  	}
>  
> -	iomap_flags = IOMAP_F_SHARED;
> +	iomap_flags |= IOMAP_F_SHARED;
>  	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
>  	xfs_iunlock(ip, lockmode);
>  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
> @@ -1212,8 +1212,10 @@ xfs_buffered_write_delalloc_punch(
>  	loff_t			length,
>  	struct iomap		*iomap)
>  {
> -	xfs_bmap_punch_delalloc_range(XFS_I(inode), XFS_DATA_FORK, offset,
> -			offset + length);
> +	xfs_bmap_punch_delalloc_range(XFS_I(inode),
> +			(iomap->flags & IOMAP_F_SHARED) ?
> +				XFS_COW_FORK : XFS_DATA_FORK,
> +			offset, offset + length);
>  }
>  
>  static int
> -- 
> 2.43.0
> 
> 

