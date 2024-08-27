Return-Path: <linux-fsdevel+bounces-27408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA8E96140A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761021F247BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455C11CCB50;
	Tue, 27 Aug 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQftQseX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DF481CD;
	Tue, 27 Aug 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776085; cv=none; b=jRCNmxGm7ZQdk6tJtEWeod5F5pw5pzvT8kfUzVs7KwaCNj8mj5ttj24HFDzA9g5rfDEBdiHiF+kRej0SvVBAMwhixLTtbsdR+ey+y/9D89qA8nJReykK6k+fG0vY0k34+3aJF0426qHWpXjCAx9HXFyo6GRfGNvmtwDOPYeVbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776085; c=relaxed/simple;
	bh=sW9zbE4pMrWszlMUAxl9KDgJmOa52tnSzngp3psqU2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krWG8p6auxo0FGrdZTNyOqIYfI2tsVE7ARBZqQDGIMd3CH91R62ikMApypGAQW40yqX/LjAVfrVonq0b006zTQ1zxOl5XV3JGyc6RtwHovk6ZzxRU///KhXhdL2HlA2wYzFhQxWDOopew+XvPNa9GUF+JBL1YnKMeOjWBq66/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQftQseX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A94AC4CA10;
	Tue, 27 Aug 2024 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724776085;
	bh=sW9zbE4pMrWszlMUAxl9KDgJmOa52tnSzngp3psqU2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQftQseXZ0GX8LI6tn0uFQq9m3frir7oMnY+/sel5KQlupExXx/hWm7ya04529TFX
	 +m//IBJ9asPaz/ju+SJNSworJfgcwydDxX7I3XjK7RA346ZyUAUyH4c8iv6HaIiq/d
	 pnxmuyJH9OEDO01GD3MW65NGkXfXwAbvLlx2/7Q7tytxQAT40c3LBu9mHH1o8MoQZv
	 KiYYSL92YQfKE/Kqr5szCgY2APNhFv5iFn6KdFU0MjCoCHlg4Y8JUSqDp9QunIyQ1A
	 lqSx5lZt6Ka7ZAuzEZ7rEV7EsVdMIOYMc1T9tR4fohnd50aCBuMnp9y2nELabK+YGy
	 JuZAiUgUx+G5A==
Date: Tue, 27 Aug 2024 09:28:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/10] iomap: zeroing already holds invalidate_lock in
 iomap_file_buffered_write_punch_delalloc
Message-ID: <20240827162804.GY865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-5-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:51AM +0200, Christoph Hellwig wrote:
> All callers of iomap_zero_range already hold invalidate_lock, so we can't
> take it again in iomap_file_buffered_write_punch_delalloc.

What about the xfs_zero_range call in xfs_file_write_checks?  AFAICT we
don't hold the invalidate lock there.  Did I misread that?

Also, would nested takings of the invalidate lock cause a livelock?  Or
is this actually quite broken now?

--D

> Use the passed in flags argument to detect if we're called from a zeroing
> operation and don't take the lock again in this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 34de9f58794ad5..574ca413516443 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1198,8 +1198,8 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>   * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
>   * the code to subtle off-by-one bugs....
>   */
> -static int iomap_write_delalloc_release(struct inode *inode,
> -		loff_t start_byte, loff_t end_byte, iomap_punch_t punch)
> +static int iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> +		loff_t end_byte, unsigned flags, iomap_punch_t punch)
>  {
>  	loff_t punch_start_byte = start_byte;
>  	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
> @@ -1210,8 +1210,13 @@ static int iomap_write_delalloc_release(struct inode *inode,
>  	 * folios and dirtying them via ->page_mkwrite whilst we walk the
>  	 * cache and perform delalloc extent removal. Failing to do this can
>  	 * leave dirty pages with no space reservation in the cache.
> +	 *
> +	 * For zeroing operations the callers already hold invalidate_lock.
>  	 */
> -	filemap_invalidate_lock(inode->i_mapping);
> +	if (flags & IOMAP_ZERO)
> +		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
> +	else
> +		filemap_invalidate_lock(inode->i_mapping);
>  	while (start_byte < scan_end_byte) {
>  		loff_t		data_end;
>  
> @@ -1264,7 +1269,8 @@ static int iomap_write_delalloc_release(struct inode *inode,
>  		error = punch(inode, punch_start_byte,
>  				end_byte - punch_start_byte);
>  out_unlock:
> -	filemap_invalidate_unlock(inode->i_mapping);
> +	if (!(flags & IOMAP_ZERO))
> +		filemap_invalidate_unlock(inode->i_mapping);
>  	return error;
>  }
>  
> @@ -1328,7 +1334,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  	if (start_byte >= end_byte)
>  		return 0;
>  
> -	return iomap_write_delalloc_release(inode, start_byte, end_byte,
> +	return iomap_write_delalloc_release(inode, start_byte, end_byte, flags,
>  					punch);
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
> -- 
> 2.43.0
> 
> 

