Return-Path: <linux-fsdevel+bounces-27406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08919613E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D304284DF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE71CBE8F;
	Tue, 27 Aug 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+QONV2m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FC374C3;
	Tue, 27 Aug 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775750; cv=none; b=UGTh/Dvwd3tXh4jET1PAWqWoPNeIMHbrFnnW6slgyctPjZuSZUqR/aJuXtIbpdOptCcOktkjh/kdtKez2hVpIVNwSi9Rx9gJK7ch8JIfXqG/2TImrEOIuFjskccS5fsUyvVT6RLUO3nzpVlThg25MD4hrA3DHaBoTapklHpcGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775750; c=relaxed/simple;
	bh=Fooc4/XVE9XFnfhfwTXkSG71NFjps/XG/iuKIaRVlKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPQfM7kYK9p5FQmSR3prHgkmaM+FNAAXrfnBssWajc5uDXRJk61fQVePDVF5slhR7NcOrswwhm/Yk2qfdPBhzLQFU+Rk5NXmeFFlqLflP78XTBpMnWLpf4grzOtnPSR8HsQN8cGuXS254TNIvopbqc4VUdhJjooY/HF6xVlOMnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+QONV2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C8C4DE00;
	Tue, 27 Aug 2024 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724775750;
	bh=Fooc4/XVE9XFnfhfwTXkSG71NFjps/XG/iuKIaRVlKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+QONV2mDS+BK4MyWPwHjXqi8ObsYD8TMfRuXBsnGC8dtpsAYq/puZT0kDPnkAxh3
	 7h0MKsvgLxdgM8NdE6ZMopPdKxxPXKpa4+KYGIUaqE8RfwzOv11c4d0dmfT/D8rINf
	 FiZddCcPRpf5imxuEyGfLDwMegVEBxbcRdFeahv55cYkq1g2Bgx5PZE3MTnQ2xa3cF
	 KtfQP+K5ZHKdPeOg9eKkYlHzoq6vBx3YXNj0mchdGlGlqBYgBozvmYCMbvdIn0V7yp
	 NhzQ5xSG/xuCvZQQwzVE1qXSj34Fv9yDJRVXxXPwNUonxtMNCvP6JQeOAeWceBhleh
	 ddNhFO2uf5n+g==
Date: Tue, 27 Aug 2024 09:22:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/10] iomap: pass flags to
 iomap_file_buffered_write_punch_delalloc
Message-ID: <20240827162229.GX865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827051028.1751933-4-hch@lst.de>

On Tue, Aug 27, 2024 at 07:09:50AM +0200, Christoph Hellwig wrote:
> To fix short write error handling, We'll need to figure out what operation
> iomap_file_buffered_write_punch_delalloc is called for.  Pass the flags
> argument on to it, and reorder the argument list to match that of
> ->iomap_end so that the compiler only has to add the new punch argument
> to the end of it instead of reshuffling the registers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c |  5 ++---
>  fs/xfs/xfs_iomap.c     |  5 +++--
>  include/linux/iomap.h  | 10 ++++++----
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 737a005082e035..34de9f58794ad5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -23,7 +23,6 @@
>  
>  #define IOEND_BATCH_SIZE	4096
>  
> -typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
>  /*
>   * Structure allocated for each folio to track per-block uptodate, dirty state
>   * and I/O completions.
> @@ -1300,8 +1299,8 @@ static int iomap_write_delalloc_release(struct inode *inode,
>   *         internal filesystem allocation lock
>   */
>  int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
> -		struct iomap *iomap, loff_t pos, loff_t length,
> -		ssize_t written, iomap_punch_t punch)
> +		loff_t pos, loff_t length, ssize_t written, unsigned flags,
> +		struct iomap *iomap, iomap_punch_t punch)
>  {
>  	loff_t			start_byte;
>  	loff_t			end_byte;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 72c981e3dc9211..47b5c83588259e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1231,8 +1231,9 @@ xfs_buffered_write_iomap_end(
>  	struct xfs_mount	*mp = XFS_M(inode->i_sb);
>  	int			error;
>  
> -	error = iomap_file_buffered_write_punch_delalloc(inode, iomap, offset,
> -			length, written, &xfs_buffered_write_delalloc_punch);
> +	error = iomap_file_buffered_write_punch_delalloc(inode, offset, length,
> +			written, flags, iomap,
> +			&xfs_buffered_write_delalloc_punch);
>  	if (error && !xfs_is_shutdown(mp)) {
>  		xfs_alert(mp, "%s: unable to clean up ino 0x%llx",
>  			__func__, XFS_I(inode)->i_ino);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 6fc1c858013d1e..83da37d64d1144 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -258,10 +258,6 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
>  
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
> -int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
> -		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
> -		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
> -
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
> @@ -277,6 +273,12 @@ int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>  		const struct iomap_ops *ops);
>  vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>  			const struct iomap_ops *ops);
> +
> +typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
> +int iomap_file_buffered_write_punch_delalloc(struct inode *inode, loff_t pos,
> +		loff_t length, ssize_t written, unsigned flag,
> +		struct iomap *iomap, iomap_punch_t punch);
> +
>  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len, const struct iomap_ops *ops);
>  loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
> -- 
> 2.43.0
> 
> 

