Return-Path: <linux-fsdevel+bounces-34366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA79C4B7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 02:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14200B2B2FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19162204937;
	Tue, 12 Nov 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwGY6DjE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E52AF06;
	Tue, 12 Nov 2024 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373318; cv=none; b=Na/a+QmVXTO3PfMDAZhKW8Z3lPwc4YolSEPocZVzLNb15pzlSaV9DBJ3Q1fMAxUtYeSuRR5adC0BeZfC109fkIkkHmwlnzPVkWF+camOgYxS7rT3UTm7Y5eDQRgG/kGNA+vmwS6E7FODpnXG030er4hZjei1jIZL5RHj1/T1Rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373318; c=relaxed/simple;
	bh=k80a+SD4Pue7a8iqtHCLrHC9JuTq32V81o15OKln5Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo55S6MR/v0dgfh5k0KeAMpSiFrQrvFqrg71oOoFmU6v57jxCh2/KtYECSqDkGxCxdwm1JVoYkKKcw64Eg2MLQw+wI4D5A7GYuC9OsWkisRJVtCsOJFaST5gfRQapnGETp3rbflu1ElJni1a737uGjb2PsyGa7RKGilQLT51uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwGY6DjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA23C4CECF;
	Tue, 12 Nov 2024 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731373317;
	bh=k80a+SD4Pue7a8iqtHCLrHC9JuTq32V81o15OKln5Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwGY6DjEaUcuyCloXySi6ub9344kqsHf43g6l5Kl9rHB77QnV5/1zbsGSI1QU26+K
	 nuNbySMenT4Khhx58ELYoqw9EQ9V8Tp3LVMCRuJj2GiKVFcorzjaIUMJJD8CajunfY
	 mdwvytRjx6mafLXqHuikx4sp0dKnKzCHLBdRjRSJ0DyC5WS1v3WirnjPZaEVvj3dcT
	 gn5/8zRCeSbFqsUZQbwgxh+4eCPG05JWcH79PVJcuE7HGBtdpXHHz9pnfzE7PTKLJR
	 Ra4rxMkdA85NFV2ZRPDnSvlzZ2RIb9sYnc3f3gJzyB2YyE7or6bOYzLNy/a1kDcDT6
	 j8j3I4P32oV3Q==
Date: Mon, 11 Nov 2024 17:01:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/16] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <20241112010157.GE9421@frogsfrogsfrogs>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-14-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234842.2024180-14-axboe@kernel.dk>

On Mon, Nov 11, 2024 at 04:37:40PM -0700, Jens Axboe wrote:
> Add iomap buffered write support for RWF_UNCACHED. If RWF_UNCACHED is
> set for a write, mark the folios being written with drop_writeback. Then
> writeback completion will drop the pages. The write_iter handler simply
> kicks off writeback for the pages, and writeback completion will take
> care of the rest.
> 
> This still needs the user of the iomap buffered write helpers to call
> iocb_uncached_write() upon successful issue of the writes.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/iomap/buffered-io.c | 15 +++++++++++++--
>  include/linux/iomap.h  |  4 +++-
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ef0b68bccbb6..2f2a5db04a68 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -603,6 +603,8 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
>  
>  	if (iter->flags & IOMAP_NOWAIT)
>  		fgp |= FGP_NOWAIT;
> +	if (iter->flags & IOMAP_UNCACHED)
> +		fgp |= FGP_UNCACHED;
>  	fgp |= fgf_set_order(len);
>  
>  	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> @@ -1023,8 +1025,9 @@ ssize_t
>  iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  		const struct iomap_ops *ops, void *private)
>  {
> +	struct address_space *mapping = iocb->ki_filp->f_mapping;
>  	struct iomap_iter iter = {
> -		.inode		= iocb->ki_filp->f_mapping->host,
> +		.inode		= mapping->host,
>  		.pos		= iocb->ki_pos,
>  		.len		= iov_iter_count(i),
>  		.flags		= IOMAP_WRITE,
> @@ -1034,9 +1037,14 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iter.flags |= IOMAP_NOWAIT;
> +	if (iocb->ki_flags & IOCB_UNCACHED)
> +		iter.flags |= IOMAP_UNCACHED;
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		if (iocb->ki_flags & IOCB_UNCACHED)
> +			iter.iomap.flags |= IOMAP_F_UNCACHED;
>  		iter.processed = iomap_write_iter(&iter, i);
> +	}
>  
>  	if (unlikely(iter.pos == iocb->ki_pos))
>  		return ret;
> @@ -1770,6 +1778,9 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  	size_t poff = offset_in_folio(folio, pos);
>  	int error;
>  
> +	if (folio_test_uncached(folio))
> +		wpc->iomap.flags |= IOMAP_F_UNCACHED;
> +
>  	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
>  new_ioend:
>  		error = iomap_submit_ioend(wpc, 0);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f61407e3b121..2efc72df19a2 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -64,6 +64,7 @@ struct vm_fault;
>  #define IOMAP_F_BUFFER_HEAD	0
>  #endif /* CONFIG_BUFFER_HEAD */
>  #define IOMAP_F_XATTR		(1U << 5)
> +#define IOMAP_F_UNCACHED	(1U << 6)

This value ^^^ is set only by the core iomap code, right?

>  /*
>   * Flags set by the core iomap code during operations:

...in which case it should be set down here.  It probably ought to have
a description of what it does, too:

"IOMAP_F_UNCACHED is set to indicate that writes to the page cache (and
hence writeback) will result in folios being evicted as soon as the
updated bytes are written back to the storage."

If the writeback fails, does that mean that the dirty data will /not/ be
retained in the page cache?  IIRC we finally got to the point where the
major filesystems leave pagecache alone after writeback EIO.

The rest of the mechanics looks nifty to me; there's plenty of places
where this could be useful to me personally. :)

--D

> @@ -173,8 +174,9 @@ struct iomap_folio_ops {
>  #define IOMAP_NOWAIT		(1 << 5) /* do not block */
>  #define IOMAP_OVERWRITE_ONLY	(1 << 6) /* only pure overwrites allowed */
>  #define IOMAP_UNSHARE		(1 << 7) /* unshare_file_range */
> +#define IOMAP_UNCACHED		(1 << 8) /* uncached IO */
>  #ifdef CONFIG_FS_DAX
> -#define IOMAP_DAX		(1 << 8) /* DAX mapping */
> +#define IOMAP_DAX		(1 << 9) /* DAX mapping */
>  #else
>  #define IOMAP_DAX		0
>  #endif /* CONFIG_FS_DAX */
> -- 
> 2.45.2
> 
> 

