Return-Path: <linux-fsdevel+bounces-110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C17C5B5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D32D282498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BF1D522;
	Wed, 11 Oct 2023 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mao3dMGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8522333;
	Wed, 11 Oct 2023 18:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A6CC433C8;
	Wed, 11 Oct 2023 18:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697049077;
	bh=xywoNZHTIjOgSEZpS/CJ26pYFuxLplcZpEbx9VCc2zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mao3dMGvCIY6d2pVkTU6DcoBcoSF+GmWoSYR8NEYEdxlwiS8sI5eQKadRFTmuf1DJ
	 3nsR8vfo2RLiB19tdotmy4nJFS468VWkYiA/tR0p63DUwMvWU/JIZ5lA7UteDl7oqf
	 cgFJmzeE0f/CqpgRaMiDcTsuOFTaVRFX+KkPeS7uVJlJPJ8jNmzHQKGRoV6j9lU0dt
	 wOSL1k/gaPwnX3MARLKrliFZtHVM3yGBZP+0H1p3nKab8fPbSFwhljpz4CvFEC8dHC
	 X4zQ/gahxXJcSYTd0Y3rlyuG+sUeEDW5w/c42qqJIDGcfvw4WZO90QNXyIIhQAfpPB
	 ksTtA3PZGP1iA==
Date: Wed, 11 Oct 2023 11:31:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 11/28] iomap: pass readpage operation to read path
Message-ID: <20231011183117.GN21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-12-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-12-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:05PM +0200, Andrey Albershteyn wrote:
> Preparation for allowing filesystems to provide bio_set and
> ->submit_io() for read path. This will allow fs to do an additional
> processing of ioend on ioend completion.
> 
> Make iomap_read_end_io() exportable, so, it can be called back from
> filesystem callout after verification is done.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/erofs/data.c        |  4 ++--
>  fs/gfs2/aops.c         |  4 ++--
>  fs/iomap/buffered-io.c | 13 ++++++++++---
>  fs/xfs/xfs_aops.c      |  4 ++--
>  fs/zonefs/file.c       |  4 ++--
>  include/linux/iomap.h  | 21 +++++++++++++++++++--
>  6 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0c2c99c58b5e..3f5482d6cedb 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -357,12 +357,12 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   */
>  static int erofs_read_folio(struct file *file, struct folio *folio)
>  {
> -	return iomap_read_folio(folio, &erofs_iomap_ops);
> +	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
>  }
>  
>  static void erofs_readahead(struct readahead_control *rac)
>  {
> -	return iomap_readahead(rac, &erofs_iomap_ops);
> +	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
>  }
>  
>  static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index c26d48355cc2..9c09ff75e586 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -456,7 +456,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
>  
>  	if (!gfs2_is_jdata(ip) ||
>  	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
> -		error = iomap_read_folio(folio, &gfs2_iomap_ops);
> +		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
>  	} else if (gfs2_is_stuffed(ip)) {
>  		error = stuffed_readpage(ip, &folio->page);
>  		folio_unlock(folio);
> @@ -534,7 +534,7 @@ static void gfs2_readahead(struct readahead_control *rac)
>  	else if (gfs2_is_jdata(ip))
>  		mpage_readahead(rac, gfs2_block_map);
>  	else
> -		iomap_readahead(rac, &gfs2_iomap_ops);
> +		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
>  }
>  
>  /**
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 644479ccefbd..ca78c7f62527 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -264,7 +264,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
>  		folio_unlock(folio);
>  }
>  
> -static void iomap_read_end_io(struct bio *bio)
> +void iomap_read_end_io(struct bio *bio)
>  {
>  	int error = blk_status_to_errno(bio->bi_status);
>  	struct folio_iter fi;
> @@ -273,12 +273,14 @@ static void iomap_read_end_io(struct bio *bio)
>  		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
>  	bio_put(bio);
>  }
> +EXPORT_SYMBOL_GPL(iomap_read_end_io);
>  
>  struct iomap_readpage_ctx {
>  	struct folio		*cur_folio;
>  	bool			cur_folio_in_bio;
>  	struct bio		*bio;
>  	struct readahead_control *rac;
> +	const struct iomap_readpage_ops *ops;
>  };
>  
>  /**
> @@ -402,7 +404,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	return pos - orig_pos + plen;
>  }
>  
> -int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
> +int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> +		const struct iomap_readpage_ops *readpage_ops)
>  {
>  	struct iomap_iter iter = {
>  		.inode		= folio->mapping->host,
> @@ -411,6 +414,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	};
>  	struct iomap_readpage_ctx ctx = {
>  		.cur_folio	= folio,
> +		.ops		= readpage_ops,
>  	};
>  	int ret;
>  
> @@ -468,6 +472,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
>   * iomap_readahead - Attempt to read pages from a file.
>   * @rac: Describes the pages to be read.
>   * @ops: The operations vector for the filesystem.
> + * @readpage_ops: Filesystem supplied folio processiong operation
>   *
>   * This function is for filesystems to call to implement their readahead
>   * address_space operation.
> @@ -479,7 +484,8 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
>   * function is called with memalloc_nofs set, so allocations will not cause
>   * the filesystem to be reentered.
>   */
> -void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
> +void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
> +		const struct iomap_readpage_ops *readpage_ops)
>  {
>  	struct iomap_iter iter = {
>  		.inode	= rac->mapping->host,
> @@ -488,6 +494,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	};
>  	struct iomap_readpage_ctx ctx = {
>  		.rac	= rac,
> +		.ops	= readpage_ops,
>  	};
>  
>  	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 465d7630bb21..b413a2dbcc18 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -553,14 +553,14 @@ xfs_vm_read_folio(
>  	struct file		*unused,
>  	struct folio		*folio)
>  {
> -	return iomap_read_folio(folio, &xfs_read_iomap_ops);
> +	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
>  }
>  
>  STATIC void
>  xfs_vm_readahead(
>  	struct readahead_control	*rac)
>  {
> -	iomap_readahead(rac, &xfs_read_iomap_ops);
> +	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
>  }
>  
>  static int
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index b2c9b35df8f7..29428c012150 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
>  
>  static int zonefs_read_folio(struct file *unused, struct folio *folio)
>  {
> -	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
> +	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
>  }
>  
>  static void zonefs_readahead(struct readahead_control *rac)
>  {
> -	iomap_readahead(rac, &zonefs_read_iomap_ops);
> +	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
>  }
>  
>  /*
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 96dd0acbba44..3565c449f3c9 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -262,8 +262,25 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
>  		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
>  		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
>  
> -int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
> -void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
> +struct iomap_readpage_ops {
> +	/*
> +	 * Filesystems wishing to attach private information to a direct io bio
> +	 * must provide a ->submit_io method that attaches the additional
> +	 * information to the bio and changes the ->bi_end_io callback to a
> +	 * custom function.  This function should, at a minimum, perform any
> +	 * relevant post-processing of the bio and end with a call to
> +	 * iomap_read_end_io.
> +	 */
> +	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
> +			loff_t file_offset);
> +	struct bio_set *bio_set;

Needs a comment to mention that iomap will allocate bios from @bio_set
if non-null; or its own internal bioset if null.

> +};

It's odd that this patch adds this ops structure but doesn't actually
start using it until the next patch.

--D

> +
> +void iomap_read_end_io(struct bio *bio);
> +int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
> +		const struct iomap_readpage_ops *readpage_ops);
> +void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
> +		const struct iomap_readpage_ops *readpage_ops);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
> -- 
> 2.40.1
> 

