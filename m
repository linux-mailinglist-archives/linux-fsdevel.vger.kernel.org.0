Return-Path: <linux-fsdevel+bounces-60214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD69B42B91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 23:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54621BC6911
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0232EAD13;
	Wed,  3 Sep 2025 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCAh3ZlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9212EAD10;
	Wed,  3 Sep 2025 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933900; cv=none; b=aVDJmwMxeoLNez8GwykKAspM6o5Qu1DTzERaqJPEiugHxS7oXkgKCPbqGvZDZoIC1LfZT/aVqMNVX/gnPmBB12JdtYLTZ26NAq+FA7HyZHjxI1DG6wjG71dkrz0NmRnI5K62dWj5dmWyrkaZq7pbnuIWyNt6yFprgR5O5sPRyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933900; c=relaxed/simple;
	bh=d0xtjmly9mcFy7mWaXY9Mo1CjZigSOkfjLlfz5GT4zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKoXJA6J80M8HByKjgR18k7UDZWS4FAwy7mx4hkVK3F0tG+j7oXc4/ZModYvYP5kOT1RBNZoJOzva2vxa1CPvfiEtvGMy1lsn/5NGKwQYr+JGqLfWbVn9WsGpOVYyM72WLvXAZ1lWDe2vPEamZNAZWvEBJOmPXpV5eqZf1EJg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCAh3ZlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD33C4CEE7;
	Wed,  3 Sep 2025 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756933900;
	bh=d0xtjmly9mcFy7mWaXY9Mo1CjZigSOkfjLlfz5GT4zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCAh3ZlObJGH+D7rJgIvHd7iAGAeoQrlm71o30EEvVJNk0C9Zg2szpvFGVG681v22
	 5pOS8uU8mc6U4TGBK2bg1IC1SZxyr61pkSPJ0AU/Os5dMVLLBfDlrckuWbu7nTr1b+
	 JEbWsbzEngrySqdYuaHUbNqYtQbA3OsX32XS05R2ZvGB2KvsZeb8DhAQPd2NbV07Dc
	 pvnY6MApV1NcmFU1d09AP87mMr3IK7zLoIBW8L4YkZG0b/IlsW48UfR7k3DQxGHOem
	 5U+dQJGfN/mSKNtsoM5suojv471YcUR/bjE8Lcv1/1mXVSCinC+ZNNkqNiXRoMgOj7
	 kVseLGWL+cDqw==
Date: Wed, 3 Sep 2025 14:11:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 13/16] iomap: add a private arg for read and readahead
Message-ID: <20250903211139.GU1587915@frogsfrogsfrogs>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-14-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-14-joannelkoong@gmail.com>

On Fri, Aug 29, 2025 at 04:56:24PM -0700, Joanne Koong wrote:
> Add a void *private arg for read and readahead which filesystems that
> pass in custom read callbacks can use. Stash this in the existing
> private field in the iomap_iter.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Seems reasonable to me, though what happens if an iomap user passes a
non-NULL private pointer here but no folio ops; and then iomap_readahead
tries to store a bio in there?

(This is why I disliked that previous patch so strongly)

--D

> ---
>  block/fops.c           | 4 ++--
>  fs/erofs/data.c        | 4 ++--
>  fs/gfs2/aops.c         | 4 ++--
>  fs/iomap/buffered-io.c | 8 ++++++--
>  fs/xfs/xfs_aops.c      | 4 ++--
>  fs/zonefs/file.c       | 4 ++--
>  include/linux/iomap.h  | 4 ++--
>  7 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index b42e16d0eb35..57ae886c7b1a 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -533,12 +533,12 @@ const struct address_space_operations def_blk_aops = {
>  #else /* CONFIG_BUFFER_HEAD */
>  static int blkdev_read_folio(struct file *file, struct folio *folio)
>  {
> -	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL);
> +	return iomap_read_folio(folio, &blkdev_iomap_ops, NULL, NULL);
>  }
>  
>  static void blkdev_readahead(struct readahead_control *rac)
>  {
> -	iomap_readahead(rac, &blkdev_iomap_ops, NULL);
> +	iomap_readahead(rac, &blkdev_iomap_ops, NULL, NULL);
>  }
>  
>  static ssize_t blkdev_writeback_range(struct iomap_writepage_ctx *wpc,
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index ea451f233263..2ea338448ca1 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -371,7 +371,7 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
>  {
>  	trace_erofs_read_folio(folio, true);
>  
> -	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
> +	return iomap_read_folio(folio, &erofs_iomap_ops, NULL, NULL);
>  }
>  
>  static void erofs_readahead(struct readahead_control *rac)
> @@ -379,7 +379,7 @@ static void erofs_readahead(struct readahead_control *rac)
>  	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
>  					readahead_count(rac), true);
>  
> -	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
> +	return iomap_readahead(rac, &erofs_iomap_ops, NULL, NULL);
>  }
>  
>  static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index bf531bcfd8a0..211a0f7b1416 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -428,7 +428,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
>  
>  	if (!gfs2_is_jdata(ip) ||
>  	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
> -		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
> +		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL, NULL);
>  	} else if (gfs2_is_stuffed(ip)) {
>  		error = stuffed_read_folio(ip, folio);
>  	} else {
> @@ -503,7 +503,7 @@ static void gfs2_readahead(struct readahead_control *rac)
>  	else if (gfs2_is_jdata(ip))
>  		mpage_readahead(rac, gfs2_block_map);
>  	else
> -		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
> +		iomap_readahead(rac, &gfs2_iomap_ops, NULL, NULL);
>  }
>  
>  /**
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 06f2c857de64..d68dd7f63923 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -539,12 +539,13 @@ static void iomap_readfolio_complete(const struct iomap_iter *iter,
>  }
>  
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> -		const struct iomap_read_ops *read_ops)
> +		const struct iomap_read_ops *read_ops, void *private)
>  {
>  	struct iomap_iter iter = {
>  		.inode		= folio->mapping->host,
>  		.pos		= folio_pos(folio),
>  		.len		= folio_size(folio),
> +		.private	= private,
>  	};
>  	struct iomap_readfolio_ctx ctx = {
>  		.cur_folio	= folio,
> @@ -591,6 +592,8 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>   * @rac: Describes the pages to be read.
>   * @ops: The operations vector for the filesystem.
>   * @read_ops: Optional ops callers can pass in if they want custom handling.
> + * @private: If passed in, this will be usable by the caller in any
> + * read_ops callbacks.
>   *
>   * This function is for filesystems to call to implement their readahead
>   * address_space operation.
> @@ -603,12 +606,13 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>   * the filesystem to be reentered.
>   */
>  void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
> -		const struct iomap_read_ops *read_ops)
> +		const struct iomap_read_ops *read_ops, void *private)
>  {
>  	struct iomap_iter iter = {
>  		.inode	= rac->mapping->host,
>  		.pos	= readahead_pos(rac),
>  		.len	= readahead_length(rac),
> +		.private = private,
>  	};
>  	struct iomap_readfolio_ctx ctx = {
>  		.rac	= rac,
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index fb2150c0825a..5e71a3888e6d 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -742,14 +742,14 @@ xfs_vm_read_folio(
>  	struct file		*unused,
>  	struct folio		*folio)
>  {
> -	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
> +	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL, NULL);
>  }
>  
>  STATIC void
>  xfs_vm_readahead(
>  	struct readahead_control	*rac)
>  {
> -	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
> +	iomap_readahead(rac, &xfs_read_iomap_ops, NULL, NULL);
>  }
>  
>  static int
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 96470daf4d3f..182bb473a82b 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
>  
>  static int zonefs_read_folio(struct file *unused, struct folio *folio)
>  {
> -	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
> +	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL, NULL);
>  }
>  
>  static void zonefs_readahead(struct readahead_control *rac)
>  {
> -	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
> +	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL, NULL);
>  }
>  
>  /*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index a7247439aeb5..9bc7900dd448 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -355,9 +355,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> -		const struct iomap_read_ops *read_ops);
> +		const struct iomap_read_ops *read_ops, void *private);
>  void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
> -		const struct iomap_read_ops *read_ops);
> +		const struct iomap_read_ops *read_ops, void *private);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
> -- 
> 2.47.3
> 
> 

