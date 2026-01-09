Return-Path: <linux-fsdevel+bounces-73077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 889A3D0BCD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB48301E6AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 18:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FCC366DCB;
	Fri,  9 Jan 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMumko4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8EA1A256E;
	Fri,  9 Jan 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982483; cv=none; b=AHTAdwF5j7thp7f2NpkWDjc1s7U5+TEudX+nvsSpVHQS8SRdkbWfmIYy8zWf8cAyy2LMXah8kxm1Yz3nUwYp9bwdOkKUK4cFWffNJq/9g5tTC9cYLgvZV4o5QjmTCF1pc0cDFCId4fqoTVLsOvjVDQjgVMNJicXjjDrsT8s6du4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982483; c=relaxed/simple;
	bh=D3sAcAQ7a72l6rkZ0vUO4cd30Fr3P4FlXUAXDmvF250=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYmBHxY8ZH6XS+KtnYJ1AxTn0E6HuOopld1S9Aw/QaQxzJYmBEWdfc3ScGMMfcj1SWcQtCedgnJHYjINu4ACne2kEz9KnjMv10Rgm5ZJyKy4yMr+Qid0kGocTuQVgOL+pyirr+A5zqQNL5ZKsQNH2dZ9VkcI86p8CuIe7Go+rgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMumko4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C48C4CEF1;
	Fri,  9 Jan 2026 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767982483;
	bh=D3sAcAQ7a72l6rkZ0vUO4cd30Fr3P4FlXUAXDmvF250=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMumko4LbvmJitdMGI1Z305NZuO/VqFkUoxywLmzdQvYoQfqYRsT4dmoWb3mtUkmE
	 MWLTKQx0A2r6o5xK07beirTFpxuZXyZnK18i7DvSp7ncmLl+U9UaWf2IensqNEEzmt
	 aALnWUzCHmvoQfQZdCmmtPd3OIzsvFBYVkMW7g6HUefOCnBQWYknpRkOWWVXG2JwNT
	 vNp4AQi2PD8nRM1xe0XK/Qe9LvTezvXicCt8KbTqPI0+sAe8sn2l3t4GZNlzUCjpfj
	 xHwsqZ88RFZsNIGIezRadirwxZo6LfDIpqud6ZgAXAsARPOf5tQvtA0LmPVw62af2/
	 7uo2WfqXOkDbQ==
Date: Fri, 9 Jan 2026 10:14:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hsiangkao@linux.alibaba.com, chao@kernel.org, brauner@kernel.org,
	amir73il@gmail.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
Message-ID: <20260109181442.GA15532@frogsfrogsfrogs>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109102856.598531-2-lihongbo22@huawei.com>

On Fri, Jan 09, 2026 at 10:28:47AM +0000, Hongbo Li wrote:
> It's useful to get filesystem-specific information using the
> existing private field in the @iomap_iter passed to iomap_{begin,end}
> for advanced usage for iomap buffered reads, which is much like the
> current iomap DIO.
> 
> For example, EROFS needs it to:
> 
>  - implement an efficient page cache sharing feature, since iomap
>    needs to apply to anon inode page cache but we'd like to get the
>    backing inode/fs instead, so filesystem-specific private data is
>    needed to keep such information;
> 
>  - pass in both struct page * and void * for inline data to avoid
>    kmap_to_page() usage (which is bogus).
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

This looks like a dead simple patch to allow iomap pagecache users to
set iomap_iter::private, so no objections here:

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/file.c         | 4 ++--
>  fs/iomap/buffered-io.c | 6 ++++--
>  include/linux/iomap.h  | 8 ++++----
>  3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..f5d8887c1922 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -979,7 +979,7 @@ static int fuse_read_folio(struct file *file, struct folio *folio)
>  		return -EIO;
>  	}
>  
> -	iomap_read_folio(&fuse_iomap_ops, &ctx);
> +	iomap_read_folio(&fuse_iomap_ops, &ctx, NULL);
>  	fuse_invalidate_atime(inode);
>  	return 0;
>  }
> @@ -1081,7 +1081,7 @@ static void fuse_readahead(struct readahead_control *rac)
>  	if (fuse_is_bad(inode))
>  		return;
>  
> -	iomap_readahead(&fuse_iomap_ops, &ctx);
> +	iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
>  }
>  
>  static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e5c1ca440d93..5f7dcbabbda3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -555,13 +555,14 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
>  }
>  
>  void iomap_read_folio(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, void *private)
>  {
>  	struct folio *folio = ctx->cur_folio;
>  	struct iomap_iter iter = {
>  		.inode		= folio->mapping->host,
>  		.pos		= folio_pos(folio),
>  		.len		= folio_size(folio),
> +		.private	= private,
>  	};
>  	size_t bytes_submitted = 0;
>  	int ret;
> @@ -620,13 +621,14 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>   * the filesystem to be reentered.
>   */
>  void iomap_readahead(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx)
> +		struct iomap_read_folio_ctx *ctx, void *private)
>  {
>  	struct readahead_control *rac = ctx->rac;
>  	struct iomap_iter iter = {
>  		.inode	= rac->mapping->host,
>  		.pos	= readahead_pos(rac),
>  		.len	= readahead_length(rac),
> +		.private = private,
>  	};
>  	size_t cur_bytes_submitted;
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 520e967cb501..441d614e9fdf 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -341,9 +341,9 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private);
>  void iomap_read_folio(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx);
> +		struct iomap_read_folio_ctx *ctx, void *private);
>  void iomap_readahead(const struct iomap_ops *ops,
> -		struct iomap_read_folio_ctx *ctx);
> +		struct iomap_read_folio_ctx *ctx, void *private);
>  bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
>  struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
>  bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
> @@ -595,7 +595,7 @@ static inline void iomap_bio_read_folio(struct folio *folio,
>  		.cur_folio	= folio,
>  	};
>  
> -	iomap_read_folio(ops, &ctx);
> +	iomap_read_folio(ops, &ctx, NULL);
>  }
>  
>  static inline void iomap_bio_readahead(struct readahead_control *rac,
> @@ -606,7 +606,7 @@ static inline void iomap_bio_readahead(struct readahead_control *rac,
>  		.rac		= rac,
>  	};
>  
> -	iomap_readahead(ops, &ctx);
> +	iomap_readahead(ops, &ctx, NULL);
>  }
>  #endif /* CONFIG_BLOCK */
>  
> -- 
> 2.22.0
> 
> 

