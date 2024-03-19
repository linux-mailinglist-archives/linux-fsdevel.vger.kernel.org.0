Return-Path: <linux-fsdevel+bounces-14834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C7F880671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B491C21E55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C8D3FBB6;
	Tue, 19 Mar 2024 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3cEqb4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE33E49E;
	Tue, 19 Mar 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882097; cv=none; b=fP0s5m5bdlDbBcysCOpvQa8hE6X89rDcEtvwCWQJqgmEG4dN0BbYgsG5WzjhsR997/PCwjYVyslRVsXfUBAmIdxzN4BU2T34ZFQr2OZMAXpBoWpBC98n7P4JmP7Oyf7ZVWIYSGuXzwzi54wfLuY0OVyswmFtu1xRVWtcZacbofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882097; c=relaxed/simple;
	bh=TUDK+7jOKxIiMqZBYocYJtdQ1g4v4seILGRV0DTt3xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyMWQdL5gwtWj4NNEzBVKZ8GnBDhLJxA9jSrcJ/BoKJqqnKTYHW6trBWaHS4nG9dWqwxTff3JGr6DGfArVpNvZV2PTCmUXvtyQACrBY73YvlbADfnTuuO4wjXpRpI1LXSZMQOGkqYhgG6S8VUBQ8l6+9dPFcD16l40p0n3UR/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3cEqb4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7C1C43399;
	Tue, 19 Mar 2024 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882097;
	bh=TUDK+7jOKxIiMqZBYocYJtdQ1g4v4seILGRV0DTt3xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3cEqb4UBKeDtRpOlfjZg01BhZfzqr7+Qtjy5Ntn7aqW7F//V6PeDgVrE1p4M6lYb
	 5hvSbxMvV8ItPjuMQhAs/XBHc8ht1HQyE7d474kcKHPYw22M1SDTVjH4r8wEuw4LEN
	 /5nMeQvyZtoi/j4Gj+xiYPGM+iN3yVZIpyA5wyRsxsL5lkGTtjuXboT3hlBi+kMEnG
	 drQOC+llGExWHRqPYC2PLuTHc7cElbaEzQq7Jwag0k10CmXP2iHueDCNVHQyPtXYyV
	 kurmwvwSwDbqZDbZgDs5sz/pijuka5A5mDEjNQeIpi1j91mN3Jn/c11xx0jp/EjEvR
	 VDl/OJmN//xhA==
Date: Tue, 19 Mar 2024 14:01:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 2/9] xfs: make the seq argument to
 xfs_bmapi_convert_delalloc() optional
Message-ID: <20240319210136.GI1927156@frogsfrogsfrogs>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319011102.2929635-3-yi.zhang@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:10:55AM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Allow callers to pass a NULLL seq argument if they don't care about
> the fork sequence number.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Aha, you want this because xfs_bmbt_to_iomap will set the iomap validity
cookie for us, whereas writeback wants to track the per-fork cookie in
the xfs writeback structure.  Ok.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_bmap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index f362345467fa..07dc35de8ce5 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -4574,7 +4574,8 @@ xfs_bmapi_convert_delalloc(
>  	if (!isnullstartblock(bma.got.br_startblock)) {
>  		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
>  				xfs_iomap_inode_sequence(ip, flags));
> -		*seq = READ_ONCE(ifp->if_seq);
> +		if (seq)
> +			*seq = READ_ONCE(ifp->if_seq);
>  		goto out_trans_cancel;
>  	}
>  
> @@ -4623,7 +4624,8 @@ xfs_bmapi_convert_delalloc(
>  	ASSERT(!isnullstartblock(bma.got.br_startblock));
>  	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
>  				xfs_iomap_inode_sequence(ip, flags));
> -	*seq = READ_ONCE(ifp->if_seq);
> +	if (seq)
> +		*seq = READ_ONCE(ifp->if_seq);
>  
>  	if (whichfork == XFS_COW_FORK)
>  		xfs_refcount_alloc_cow_extent(tp, bma.blkno, bma.length);
> -- 
> 2.39.2
> 
> 

