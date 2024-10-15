Return-Path: <linux-fsdevel+bounces-32010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B7299F288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23CA1F234ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D761D515B;
	Tue, 15 Oct 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5SufUZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7D158DD8;
	Tue, 15 Oct 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009099; cv=none; b=FwTX3ba3X2Q0feQ90ZlB8UVSUuVg+a0D0NFsapQZ+/Flgix/VctEpoQndld8QNdpf1oX1b16IK4WqI11BxH7SKuLU8TLxmlnCgMjYedY2xbej30TjlxE9JzNQPACKHmq3ENLNfcoBtqHxxX98AwE2odxK83v5ysj9TY8xG/6TyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009099; c=relaxed/simple;
	bh=Bk49CuJokSHPaab62GUaULtutUpU6OzNlpWflEjwOcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgpAi8WQAeN3papiMHH3PJ56fet9bLH5uOAku5EFz1mjIaft5BjLuadx6CpJh4DX8K1sVpYxlx+Kts73pubf0LXjtuwbNQQbMqE7YwO8GpE7IZHED+muSkj1YroWAut77baaIhIC4QnTJd6lgOEpCkwB+GDOONkWVB4rUm9ZIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5SufUZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A03C4CEC6;
	Tue, 15 Oct 2024 16:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729009099;
	bh=Bk49CuJokSHPaab62GUaULtutUpU6OzNlpWflEjwOcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5SufUZWl61Jcm7xuFgHRIHPLssGxS254lFv92PYN+eXBDrr5tNbx5defeW4lYpux
	 tI2U60FkxdRmunm+0H3IC11rhG+MjZKvsxvTfOmyAwns1zhLeRRyAOQeOg/lrkMvoO
	 HtMRjvIDVgsuVqQ///eBxjZUIOInZ6GEYceLnW/X3bIVWU5UBC+W6WhI8SBYApt19w
	 HC9MAdmC2QRFwWsbx9EzXDnefRXOrsM/axQDmXfaTwVtQmhxIDCh64fEjKefpRQOMx
	 IHlrwwcrPT7Ok7hl30Az9kqqavglv8bTM/J/MFdcGEqHb+9xiiZHVLO1EMsDOcOj/d
	 LmLz115VVK3JQ==
Date: Tue, 15 Oct 2024 09:18:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iomap: turn iomap_want_unshare_iter into an inline
 function
Message-ID: <20241015161818.GV21853@frogsfrogsfrogs>
References: <20241015041350.118403-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241015041350.118403-1-hch@lst.de>

On Tue, Oct 15, 2024 at 06:13:50AM +0200, Christoph Hellwig wrote:
> iomap_want_unshare_iter currently sits in fs/iomap/buffered-io.c, which
> depends on CONFIG_BLOCK.  It is also in used in fs/dax.c whіch has no
> such dependency.  Given that it is a trivial check turn it into an inline
> in include/linux/iomap.h to fix the DAX && !BLOCK build.
> 
> Fixes: 6ef6a0e821d3 ("iomap: share iomap_unshare_iter predicate code with fsdax")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Heh, whoops.  I forgot (a) that DAX && !BLOCK is a thing; and that
FS_DAX != DAX and was puzzling over this report yesterday.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 17 -----------------
>  include/linux/iomap.h  | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 604f786be4bc54..ef0b68bccbb612 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1270,23 +1270,6 @@ void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
>  }
>  EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
>  
> -bool iomap_want_unshare_iter(const struct iomap_iter *iter)
> -{
> -	/*
> -	 * Don't bother with blocks that are not shared to start with; or
> -	 * mappings that cannot be shared, such as inline data, delalloc
> -	 * reservations, holes or unwritten extents.
> -	 *
> -	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
> -	 * unsharing requires providing a separate source map, and the presence
> -	 * of one is a good indicator that unsharing is needed, unlike
> -	 * IOMAP_F_SHARED which can be set for any data that goes into the COW
> -	 * fork for XFS.
> -	 */
> -	return (iter->iomap.flags & IOMAP_F_SHARED) &&
> -		iter->srcmap.type == IOMAP_MAPPED;
> -}
> -
>  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e04c060e8fe185..664c5f2f0aaa2d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -270,6 +270,25 @@ static inline loff_t iomap_last_written_block(struct inode *inode, loff_t pos,
>  	return round_up(pos + written, i_blocksize(inode));
>  }
>  
> +/*
> + * Check if the range needs to be unshared for a FALLOC_FL_UNSHARE_RANGE
> + * operation.
> + *
> + * Don't bother with blocks that are not shared to start with; or mappings that
> + * cannot be shared, such as inline data, delalloc reservations, holes or
> + * unwritten extents.
> + *
> + * Note that we use srcmap directly instead of iomap_iter_srcmap as unsharing
> + * requires providing a separate source map, and the presence of one is a good
> + * indicator that unsharing is needed, unlike IOMAP_F_SHARED which can be set
> + * for any data that goes into the COW fork for XFS.
> + */
> +static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
> +{
> +	return (iter->iomap.flags & IOMAP_F_SHARED) &&
> +		iter->srcmap.type == IOMAP_MAPPED;
> +}
> +
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops, void *private);
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
> -- 
> 2.45.2
> 
> 

