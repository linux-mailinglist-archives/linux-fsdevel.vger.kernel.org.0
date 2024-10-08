Return-Path: <linux-fsdevel+bounces-31358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF439955DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA98F1F256D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00220B1FB;
	Tue,  8 Oct 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOw9PViU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FA20B1ED;
	Tue,  8 Oct 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409184; cv=none; b=gvCDhrtlkshlcFNF9osfYrkXutHrU+9w2ltSGTfpDmiWGd4Fzfv5PpXwcDUfLBqgpMKlQh38a1YD4QgJv2nr7OCnM9OGi+h2oAwJm4gXBd5Vc7Zwd2TWMSMJlIwQe75ZZw/czHxeAmbbi/CeY0TBk9f+f+8qEIjW/6Ln3lHAKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409184; c=relaxed/simple;
	bh=Z2MbNxcDvsfdgDaNR3y6hbACd+gqp+Qk7xVytopU3Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNmVLDtyT4LWglwt8l+VLrAEVYfoYbN2hs1DMh23QCbjp3QvIMsbpyan6mpper6PyZsvwUuNh1sXx38V/VWN1HOkfv9JGwc7zHFdw4DU5LgNsYOAbLn3kgdesWOZXXNhyo9X2P5U93lmDwTOa9Rrcm9EQvGy4xNhVR17by7WMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOw9PViU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50432C4CECE;
	Tue,  8 Oct 2024 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728409184;
	bh=Z2MbNxcDvsfdgDaNR3y6hbACd+gqp+Qk7xVytopU3Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOw9PViUGPvUIm3FfR2A9HKaclq4iHf1gSzqBQS7CK6W8S9PDbDu0nXH9AeBI35F+
	 fEKgDxxWiIaygwd+exClb94JR5jl2OdfUees7GZo/eDdioV2nXSihfeOESY4KIX8r4
	 rpzJUTPjFJsPU7XNlsVJeYK7YR7pX/gWAvFw+tT4s6buPIO+tJkWfbjeZ23YROK3/a
	 Hwob4hoawvJRGEUPruEXX7J2rSUojlH4Ta2ZrVEyH/cNznSDasnV3ieomJGDHRHSOK
	 NZR9lieAsHkw4WVBJyxtiZZLY0g3aATskUxEXE61pRXjf5HpCzHuic+tTfUgziOQky
	 Ew9yXoQf8CDaQ==
Date: Tue, 8 Oct 2024 10:39:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/10] xfs: IOMAP_ZERO and IOMAP_UNSHARE already hold
 invalidate_lock
Message-ID: <20241008173943.GS21853@frogsfrogsfrogs>
References: <20241008085939.266014-1-hch@lst.de>
 <20241008085939.266014-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008085939.266014-7-hch@lst.de>

On Tue, Oct 08, 2024 at 10:59:17AM +0200, Christoph Hellwig wrote:
> All XFS callers of iomap_zero_range and iomap_file_unshare already hold
> invalidate_lock, so we can't take it again in
> iomap_file_buffered_write_punch_delalloc.
> 
> Use the passed in flags argument to detect if we're called from a zero
> or unshare operation and don't take the lock again in this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for fixing the bug I reported,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 4fa4d66dc37761..17170d9b9ff78a 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1239,10 +1239,18 @@ xfs_buffered_write_iomap_end(
>  	if (start_byte >= end_byte)
>  		return 0;
>  
> -	filemap_invalidate_lock(inode->i_mapping);
> -	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
> -			xfs_buffered_write_delalloc_punch);
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	/* For zeroing operations the callers already hold invalidate_lock. */
> +	if (flags & (IOMAP_UNSHARE | IOMAP_ZERO)) {
> +		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
> +		iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
> +				iomap, xfs_buffered_write_delalloc_punch);
> +	} else {
> +		filemap_invalidate_lock(inode->i_mapping);
> +		iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
> +				iomap, xfs_buffered_write_delalloc_punch);
> +		filemap_invalidate_unlock(inode->i_mapping);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.45.2
> 
> 

