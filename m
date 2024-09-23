Return-Path: <linux-fsdevel+bounces-29876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96F97EF12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602F0282C43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5026519F133;
	Mon, 23 Sep 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBLyn8Sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76F19E98E;
	Mon, 23 Sep 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108393; cv=none; b=BhocqqkE192fOSN9VrZzzXcFT+K4mmrjuh/HKWVhIdPJyT44FGmFrVf/EcgdlbBcMSxvIpsq8VUvrQTOyKkzsFlIlvbbojLc8T9aDOcd2w0RULs7MwdbPZcsdHn/VGYspKajOgLWgtBQdHcKS97AxscFScVkMZdsY/p7oY1lKwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108393; c=relaxed/simple;
	bh=ARZo98DO1jXKoOJYI+Dqa5cnfci5I+18g6Rzta4jlRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcHncqbYVkCjSX3dMaYDKudfwrrJq3emOWsVrMMMGw254YZujxo8xB/7piU1VhxIBBjMhgi4GcuOo8E8hcZh4diDKVhDIDapFBy1kBQhvrfNflfsqHvRV1YCacADSCzG/Dup7SI1qMw5MPC9erXEhY4tfihbCh+KjchDpBzmPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBLyn8Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FA1C4CEC4;
	Mon, 23 Sep 2024 16:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727108393;
	bh=ARZo98DO1jXKoOJYI+Dqa5cnfci5I+18g6Rzta4jlRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBLyn8Sw4mPS3Z9aJKh+9EmtKxWqjoJxyHSNRFf1qf8iq9bSp5Gu0Cho371Cu1CYP
	 jkTCNwFu/BLgny7EMIdCVPby3XChO8NoE/pHIkZ43Q/hCv3e42OlCXTmc74fnXP4kl
	 ZTlWIVx16TI235CHfhRwsjF2PLE79xpwwy6KR7OB8HcB+LAElBOa8vUljJ6JDJve2q
	 O2aiGMtASv1GQan6CLNOL+1nvQRTDJ8egdnMGfPe6QCT8yd9xBICUF+pAxH6q/sAVl
	 APPzgvOzIIUo52PpkaJL76LToE5Fv3+oVcBCQjx2AVw9DM1XhGSZW5tOEdjBFU8CZi
	 Jfe1Xck5sJOiw==
Date: Mon, 23 Sep 2024 09:19:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/10] iomap: move locking out of
 iomap_write_delalloc_release
Message-ID: <20240923161952.GF21877@frogsfrogsfrogs>
References: <20240923152904.1747117-1-hch@lst.de>
 <20240923152904.1747117-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923152904.1747117-4-hch@lst.de>

On Mon, Sep 23, 2024 at 05:28:17PM +0200, Christoph Hellwig wrote:
> XFS (which currently is the only user of iomap_write_delalloc_release)
> already holds invalidate_lock for most zeroing operations.  To be able
> to avoid a deadlock it needs to stop taking the lock, but doing so
> in iomap would leak XFS locking details into iomap.
> 
> To avoid this require the caller to hold invalidate_lock when calling
> iomap_write_delalloc_release instead of taking it there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes, I like this much better.  I'm glad that Dave pointed out the
inconsistency of the locking (iomap doesn't take locks, filesystems take
locks) model in this one odd case.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 17 ++++++++---------
>  fs/xfs/xfs_iomap.c     |  2 ++
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 237aeb883166df..232aaa1e86451a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1211,12 +1211,13 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
>  
>  	/*
> -	 * Lock the mapping to avoid races with page faults re-instantiating
> -	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> -	 * cache and perform delalloc extent removal. Failing to do this can
> -	 * leave dirty pages with no space reservation in the cache.
> +	 * The caller must hold invalidate_lock to avoid races with page faults
> +	 * re-instantiating folios and dirtying them via ->page_mkwrite whilst
> +	 * we walk the cache and perform delalloc extent removal.  Failing to do
> +	 * this can leave dirty pages with no space reservation in the cache.
>  	 */
> -	filemap_invalidate_lock(inode->i_mapping);
> +	lockdep_assert_held_write(&inode->i_mapping->invalidate_lock);
> +
>  	while (start_byte < scan_end_byte) {
>  		loff_t		data_end;
>  
> @@ -1233,7 +1234,7 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		if (start_byte == -ENXIO || start_byte == scan_end_byte)
>  			break;
>  		if (WARN_ON_ONCE(start_byte < 0))
> -			goto out_unlock;
> +			return;
>  		WARN_ON_ONCE(start_byte < punch_start_byte);
>  		WARN_ON_ONCE(start_byte > scan_end_byte);
>  
> @@ -1244,7 +1245,7 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
>  				scan_end_byte, SEEK_HOLE);
>  		if (WARN_ON_ONCE(data_end < 0))
> -			goto out_unlock;
> +			return;
>  
>  		/*
>  		 * If we race with post-direct I/O invalidation of the page cache,
> @@ -1266,8 +1267,6 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  	if (punch_start_byte < end_byte)
>  		punch(inode, punch_start_byte, end_byte - punch_start_byte,
>  				iomap);
> -out_unlock:
> -	filemap_invalidate_unlock(inode->i_mapping);
>  }
>  EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
>  
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 30f2530b6d5461..01324da63fcfc7 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1239,8 +1239,10 @@ xfs_buffered_write_iomap_end(
>  	if (start_byte >= end_byte)
>  		return 0;
>  
> +	filemap_invalidate_lock(inode->i_mapping);
>  	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
>  			xfs_buffered_write_delalloc_punch);
> +	filemap_invalidate_unlock(inode->i_mapping);
>  	return 0;
>  }
>  
> -- 
> 2.45.2
> 

