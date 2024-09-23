Return-Path: <linux-fsdevel+bounces-29878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51D97EF20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE90D1C213DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F319F105;
	Mon, 23 Sep 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka2WUAmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DE14A8B;
	Mon, 23 Sep 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108570; cv=none; b=k/ZIR8QkubJDG8R/fzZHvIOpMkp93DIy08qw5IUWiITMFrvdb5NCy2rbYBfCqOM/77exNtQynhakWlPDfPNEauaqU0Gw0gB3RHV698CYgu3Yhkzff4/sBVAqj4YQ+IceOY3CHtW+POd4VTJMb1lBdOL3X+2AeikJyMEAviZ2E1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108570; c=relaxed/simple;
	bh=zJAagt1XUf++FOvKvALjy5CzHt0oCXtony+Yb3h9sy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehahApiJL+KpTGclkip6QV0xxWjaE86cI3M2gHuUyWrsjl8IiYeCdeMTIp5ZrI/4b4L1JASs5c78MbsRBGYCdu1GGRf99F4fTm2Y//C5c79z5yzS2ME+V1pk26tmluVd9at0WyJMOHn2ON0P4j4p0jXuQuarpFdOSQOez0Qt/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka2WUAmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14155C4CEC4;
	Mon, 23 Sep 2024 16:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727108570;
	bh=zJAagt1XUf++FOvKvALjy5CzHt0oCXtony+Yb3h9sy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ka2WUAmXh+gVCcsisBoRha+l0Wo7k3DfYq0x0fCMnXb2TgRkk0ruBnrLvsazziu16
	 uNrmQhNQpbpNk+4VLRzpLxHBKEZWm5jLwtcB37/iZ8zxV+5vG1+KZgiwaOlom0LR8w
	 WWLOuIN6rzGnLs3CDRLOfOCNhneTOwlEeNXrp8tVM2ZjeWTifCIR/6oFRr0odAN6X+
	 nPcHOx3eioJFh0GYg67prkKfL2+PRt9P6ZhZpsbk9/aWYGyeZO5hQ1KhCDyLmA04sv
	 54KCiTQIhVRq35V1hbePrskLUjfi3aqcnYn+3WsmyMcHsZj/W6V2VTIkQu0IUnxLKI
	 QegsgLsinY+zg==
Date: Mon, 23 Sep 2024 09:22:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/10] xfs: zeroing already holds invalidate_lock
Message-ID: <20240923162249.GH21877@frogsfrogsfrogs>
References: <20240923152904.1747117-1-hch@lst.de>
 <20240923152904.1747117-7-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923152904.1747117-7-hch@lst.de>

On Mon, Sep 23, 2024 at 05:28:20PM +0200, Christoph Hellwig wrote:
> All XFS callers of iomap_zero_range already hold invalidate_lock, so we can't
> take it again in iomap_file_buffered_write_punch_delalloc.
> 
> Use the passed in flags argument to detect if we're called from a zeroing
> operation and don't take the lock again in this case.

Shouldn't this be a part of the previous patch?  AFAICT taking the
invalidation lock in xfs_file_write_zero_eof is why we need the change
to rwsem_assert_held_write here, right?

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_iomap.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 4fa4d66dc37761..0f5fa3de6d3ecc 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1239,10 +1239,17 @@ xfs_buffered_write_iomap_end(
>  	if (start_byte >= end_byte)
>  		return 0;
>  
> -	filemap_invalidate_lock(inode->i_mapping);
> +	/* For zeroing operations the callers already hold invalidate_lock. */
> +	if (flags & IOMAP_ZERO)
> +		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
> +	else
> +		filemap_invalidate_lock(inode->i_mapping);
> +
>  	iomap_write_delalloc_release(inode, start_byte, end_byte, flags, iomap,
>  			xfs_buffered_write_delalloc_punch);
> -	filemap_invalidate_unlock(inode->i_mapping);
> +
> +	if (!(flags & IOMAP_ZERO))
> +		filemap_invalidate_unlock(inode->i_mapping);
>  	return 0;
>  }
>  
> -- 
> 2.45.2
> 

