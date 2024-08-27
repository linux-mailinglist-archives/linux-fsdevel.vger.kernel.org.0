Return-Path: <linux-fsdevel+bounces-27413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C083F961479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33A31C232EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829CF1CDFCE;
	Tue, 27 Aug 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWHBZ37P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36654767;
	Tue, 27 Aug 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777063; cv=none; b=tRnau/hjM1maHQi9V4KoaezAJqRup8sf70BEnjTs6SnjAl5k4S0p7hp5f/BogSFg3d3e6jjdE/Cbg6tELcH0s/pceTYd+tEhhg1aGzAbzEnPxAMk/pECzz5joPIx/iEl0NJL0g9M5RzyNW/01T0w3Ss9PJgwuOMjx3Srpg9JoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777063; c=relaxed/simple;
	bh=VN6cQGsnO5/8cJus66iv2wOADXB0MOhwt1/jNYbsIUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGhl6638YuygFtj6aB8HZ0bEXkPOloZMn4L+u6nfzFXu898eN5nMKlmsTNTaf48oH66YY7XkDlz4zo7GTDE4Zl1aSUdiBmgGvYa92+tV/TGCjUwtBH8/R94gaDR3DL7XnN+qra7n/ty0eiwxpWMFXGxW5pNx+YW0sOSGxrw3tNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWHBZ37P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642B7C4AF0C;
	Tue, 27 Aug 2024 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724777062;
	bh=VN6cQGsnO5/8cJus66iv2wOADXB0MOhwt1/jNYbsIUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWHBZ37PONMTx6IKSlZr+Vd2+s5a9lCx47MM84M6moKyc+lit6f2JMIIQOMAYsNUY
	 IoquVLFjyLIDRrwzZkAbE1dndnMoQTGud1JrMtJ/YohalAFMwupzLgcBsn6R9Mu4il
	 5iqKusEHoNeSobHOZ20835QflxvH5/FFSim08eH9EhROH8F6PT0bQ1IcNYFH5RV0dY
	 h6HRTDddNVWuLjaUbXleCwA7AuHplC1SKD9qS/NeN9OREBIKNaeqbqdxUljDjw5UNN
	 zF/1RSFZkzKKzZXsiuJe16M46iErAbuAzfWE8WCfhGVjspn59iZUj6YTkKe9bWdxgW
	 cskWHaFe5U/Tg==
Date: Tue, 27 Aug 2024 09:44:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/10] xfs: set IOMAP_F_SHARED for all COW fork
 allocations
Message-ID: <20240827164421.GD865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-10-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:56AM +0200, Christoph Hellwig wrote:
> Change to always set xfs_buffered_write_iomap_begin for COW fork
> allocations even if they don't overlap existing data fork extents,
> which will allow the iomap_end callback to detect if it has to punch
> stale delalloc blocks from the COW fork instead of the data fork.  It
> also means we sample the sequence counter for both the data and the COW
> fork when writing to the COW fork, which ensures we properly revalidate
> when only COW fork changes happens.
> 
> This is essentially a revert of commit 72a048c1056a ("xfs: only set
> IOMAP_F_SHARED when providing a srcmap to a write"). This is fine because
> the problem that the commit fixed has now been dealt with in iomap by
> only looking at the actual srcmap and not the fallback to the write
> iomap.
> 
> Note that the direct I/O path was never changed and has always set
> IOMAP_F_SHARED for all COW fork allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

That was fun to compare your revert vs. a patch from 3 years ago. $)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index e0dc6393686c01..22e9613a995f12 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1186,20 +1186,19 @@ xfs_buffered_write_iomap_begin(
>  	return 0;
>  
>  found_cow:
> -	seq = xfs_iomap_inode_sequence(ip, 0);
>  	if (imap.br_startoff <= offset_fsb) {
> -		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0,
> +				xfs_iomap_inode_sequence(ip, 0));
>  		if (error)
>  			goto out_unlock;
> -		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
> -		xfs_iunlock(ip, lockmode);
> -		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> -					 IOMAP_F_SHARED, seq);
> +	} else {
> +		xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
>  	}
>  
> -	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
> +	iomap_flags = IOMAP_F_SHARED;
> +	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
>  	xfs_iunlock(ip, lockmode);
> -	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
>  
>  out_unlock:
>  	xfs_iunlock(ip, lockmode);
> -- 
> 2.43.0
> 
> 

