Return-Path: <linux-fsdevel+bounces-14137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB848783EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0900AB22B11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269EF482C3;
	Mon, 11 Mar 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2BdW5k2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12E47F7F;
	Mon, 11 Mar 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171256; cv=none; b=YrRYzO09xkb6ofOEzjZK9AAjAq7Lr35KVMNGAH0YGneexu3OsHRNnBuP+bTGEcTO6iHjo3uLHLSoqCshKqoVgcXhYOFSTCscx+BP8pp/V1R76nX0UtlbucAW3FrABYUm4Stia5lD3wetrhPSTBzpiX4xbZGXHBsrA3s5CcBESDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171256; c=relaxed/simple;
	bh=az3hhnUgV3G0rSZ98uoM1GKIqe+YbSINpP+L4RTj85A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj/o/lU8eORa2MH+3wsv+ZXq4FZIU6IFkZdlMCUom9wrPtHAgtvCUHMQEkJpp2jtB8tHa+GNbufaG6HXsCc3CUyvrZUlI5eHKMUSDZH7PayzIQGD7Wc0Gg7ck7T7Rqe/WVvolVaVXAta9eNY/tyCDHVxkuze6TICsex7VEfK1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2BdW5k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C8C43390;
	Mon, 11 Mar 2024 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710171255;
	bh=az3hhnUgV3G0rSZ98uoM1GKIqe+YbSINpP+L4RTj85A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2BdW5k2Cu65uIcNFqXDlZBA+nowIy/eRey38lRWlsqzk1vTqPpmeP0ejOPEX4IkZ
	 5EPWk3nyQgzRAIKRGlWMN+wsjtRmHegrcFqv7PU7dJ1ziV9Q1KgY+yo4wUCguskrfM
	 GwJ4UIpSW+wY+XWsFOFMM2Vp4oiFOQWZ9tKThY9WZS8S2UFbCZbRABjRpQFuIaMv/A
	 ipn/pEpBuIdP4wP9XTBZjE75j1V0VDLTj9U215/jdroBk3OhBl4KVPqeQ/Bi6qgxGA
	 6iC1P1zawza1PD2v0uXT36a2hb9YtMUn82sV3uwWNOzgoGmWb7mvEq1S7dzBr7dxnK
	 Qyb28Ej5VQHmw==
Date: Mon, 11 Mar 2024 08:34:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 1/4] xfs: match lock mode in
 xfs_buffered_write_iomap_begin()
Message-ID: <20240311153415.GS1927156@frogsfrogsfrogs>
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311122255.2637311-2-yi.zhang@huaweicloud.com>

On Mon, Mar 11, 2024 at 08:22:52PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Commit 1aa91d9c9933 ("xfs: Add async buffered write support") replace
> xfs_ilock(XFS_ILOCK_EXCL) with xfs_ilock_for_iomap() when locking the
> writing inode, and a new variable lockmode is used to indicate the lock
> mode. Although the lockmode should always be XFS_ILOCK_EXCL, it's still
> better to use this variable instead of useing XFS_ILOCK_EXCL directly
> when unlocking the inode.
> 
> Fixes: 1aa91d9c9933 ("xfs: Add async buffered write support")

AFAICT, xfs_ilock_for_iomap can change lockmode from SHARED->EXCL, but
never changed away from EXCL, right?  And xfs_buffered_write_iomap_begin
sets it to EXCL (and never changes it), right?

This seems like more of a code cleanup/logic bomb removal than an actual
defect that someone could actually hit, correct?

If the answers are {yes, yes, yes} then:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/xfs/xfs_iomap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 18c8f168b153..ccf83e72d8ca 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1149,13 +1149,13 @@ xfs_buffered_write_iomap_begin(
>  	 * them out if the write happens to fail.
>  	 */
>  	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	xfs_iunlock(ip, lockmode);
>  	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
>  
>  found_imap:
>  	seq = xfs_iomap_inode_sequence(ip, 0);
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	xfs_iunlock(ip, lockmode);
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>  
>  found_cow:
> @@ -1165,17 +1165,17 @@ xfs_buffered_write_iomap_begin(
>  		if (error)
>  			goto out_unlock;
>  		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
> -		xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +		xfs_iunlock(ip, lockmode);
>  		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
>  					 IOMAP_F_SHARED, seq);
>  	}
>  
>  	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	xfs_iunlock(ip, lockmode);
>  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
>  
>  out_unlock:
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	xfs_iunlock(ip, lockmode);
>  	return error;
>  }
>  
> -- 
> 2.39.2
> 
> 

