Return-Path: <linux-fsdevel+bounces-37863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C899F82D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D33189092E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DEF1A38E4;
	Thu, 19 Dec 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6cr/+N/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909B197A8F;
	Thu, 19 Dec 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630962; cv=none; b=VbbdcSQHuQc7BYLEjGbDVGizpdrK5ErWZey16+EkiRsYI6RD8j0WogJ15itCgtP+RtZ5Y2vR9dNX4VEMOh5tBEpcA/S79QuWMdUzxMkIbU4KaCSZ2+3j3xte/yupY/sHDR/YyOYlWdZgzKIk7Xg+4Q4IrUboJ4HVEn7JIqtQ1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630962; c=relaxed/simple;
	bh=DAzSeCDqtlZuR8cAXPinbFoede2W+nq3x90M1Vu0FK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsZbOJ15ygWJkROG6en72oc064617GKxchoE8asRzCjVkQQk54r4MJqrvHBMaijQJ9q7DDW8xR+Xw+RVRh/fRNubXsDtCV++kI9cIDl+OEaCWYZw9x1OGqSjIAxpF7ND0rrkSgF4qam/MtRwIz3i3cobOqLWBlX4RWN1C3HApR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6cr/+N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742BAC4CECE;
	Thu, 19 Dec 2024 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734630961;
	bh=DAzSeCDqtlZuR8cAXPinbFoede2W+nq3x90M1Vu0FK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6cr/+N/Zxp0qNFmysIWLO0K6RketWJi4SMoiiH/wrUtEp/SDKlSFERFhKzqAsMBn
	 Zlfgb6T0skoURxsT6x4Reh2s7ctmvhj0AqNIfUgLZsCDPe8VbzW/XaVXBM8hzIjFCX
	 ZIslbAw7IEt+cHpP/32nRuoSYUVLs0hR5+3cJj/XmwxtENyctLYXW4lJR71TxGqygl
	 rUtN9ipmjxyzmlHPnfWE5rEW2II3dzfxRhMMqAsYREbEJUNGNZFGWo/Df/WYruBBWk
	 MHE+hFuF5I9s4cVpcyJbZnJn3YQinhVbg+nkF4okz2bPgkRQ/ppjdIuatR6ZD9/BzS
	 0qooDZHGmqmPQ==
Date: Thu, 19 Dec 2024 09:56:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: simplify io_flags and io_type in struct
 iomap_ioend
Message-ID: <20241219175600.GB6156@frogsfrogsfrogs>
References: <20241219173954.22546-1-hch@lst.de>
 <20241219173954.22546-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219173954.22546-3-hch@lst.de>

On Thu, Dec 19, 2024 at 05:39:07PM +0000, Christoph Hellwig wrote:
> The ioend fields for distinct types of I/O are a bit complicated.
> Consolidate them into a single io_flag field with it's own flags
> decoupled from the iomap flags.  This also prepares for adding a new
> flag that is unrelated to both of the iomap namespaces.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++-----------------
>  fs/xfs/xfs_aops.c      | 12 ++++++------
>  include/linux/iomap.h  | 20 ++++++++++++++++++--
>  3 files changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cdccf11bb3be..3176dc996fb7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1605,13 +1605,10 @@ iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
>  {
>  	if (ioend->io_bio.bi_status != next->io_bio.bi_status)
>  		return false;
> -	if (next->io_flags & IOMAP_F_BOUNDARY)
> +	if (next->io_flags & IOMAP_IOEND_BOUNDARY)
>  		return false;
> -	if ((ioend->io_flags & IOMAP_F_SHARED) ^
> -	    (next->io_flags & IOMAP_F_SHARED))
> -		return false;
> -	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
> -	    (next->io_type == IOMAP_UNWRITTEN))
> +	if ((ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> +	    (next->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
>  		return false;
>  	if (ioend->io_offset + ioend->io_size != next->io_offset)
>  		return false;
> @@ -1709,7 +1706,8 @@ static int iomap_submit_ioend(struct iomap_writepage_ctx *wpc, int error)
>  }
>  
>  static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
> -		struct writeback_control *wbc, struct inode *inode, loff_t pos)
> +		struct writeback_control *wbc, struct inode *inode, loff_t pos,
> +		u16 ioend_flags)
>  {
>  	struct iomap_ioend *ioend;
>  	struct bio *bio;
> @@ -1724,8 +1722,7 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  
>  	ioend = iomap_ioend_from_bio(bio);
>  	INIT_LIST_HEAD(&ioend->io_list);
> -	ioend->io_type = wpc->iomap.type;
> -	ioend->io_flags = wpc->iomap.flags;
> +	ioend->io_flags = ioend_flags;
>  	if (pos > wpc->iomap.offset)
>  		wpc->iomap.flags &= ~IOMAP_F_BOUNDARY;
>  	ioend->io_inode = inode;
> @@ -1737,14 +1734,13 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>  	return ioend;
>  }
>  
> -static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos)
> +static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
> +		u16 ioend_flags)
>  {
> -	if (wpc->iomap.offset == pos && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> -		return false;
> -	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
> -	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
> +	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
>  		return false;
> -	if (wpc->iomap.type != wpc->ioend->io_type)
> +	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> +	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
>  		return false;
>  	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
>  		return false;
> @@ -1778,14 +1774,23 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
> +	unsigned int ioend_flags = 0;
>  	int error;
>  
> -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos)) {
> +	if (wpc->iomap.type == IOMAP_UNWRITTEN)
> +		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
> +	if (wpc->iomap.flags & IOMAP_F_SHARED)
> +		ioend_flags |= IOMAP_IOEND_SHARED;
> +	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
> +		ioend_flags |= IOMAP_IOEND_BOUNDARY;
> +
> +	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
>  new_ioend:
>  		error = iomap_submit_ioend(wpc, 0);
>  		if (error)
>  			return error;
> -		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos);
> +		wpc->ioend = iomap_alloc_ioend(wpc, wbc, inode, pos,
> +				ioend_flags);
>  	}
>  
>  	if (!bio_add_folio(&wpc->ioend->io_bio, folio, len, poff))
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index d175853da5ae..d35ac4c19fb2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -114,7 +114,7 @@ xfs_end_ioend(
>  	 */
>  	error = blk_status_to_errno(ioend->io_bio.bi_status);
>  	if (unlikely(error)) {
> -		if (ioend->io_flags & IOMAP_F_SHARED) {
> +		if (ioend->io_flags & IOMAP_IOEND_SHARED) {
>  			xfs_reflink_cancel_cow_range(ip, offset, size, true);
>  			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, offset,
>  					offset + size);
> @@ -125,9 +125,9 @@ xfs_end_ioend(
>  	/*
>  	 * Success: commit the COW or unwritten blocks if needed.
>  	 */
> -	if (ioend->io_flags & IOMAP_F_SHARED)
> +	if (ioend->io_flags & IOMAP_IOEND_SHARED)
>  		error = xfs_reflink_end_cow(ip, offset, size);
> -	else if (ioend->io_type == IOMAP_UNWRITTEN)
> +	else if (ioend->io_flags & IOMAP_IOEND_UNWRITTEN)
>  		error = xfs_iomap_write_unwritten(ip, offset, size, false);
>  
>  	if (!error && xfs_ioend_is_append(ioend))
> @@ -410,7 +410,7 @@ xfs_submit_ioend(
>  	nofs_flag = memalloc_nofs_save();
>  
>  	/* Convert CoW extents to regular */
> -	if (!status && (ioend->io_flags & IOMAP_F_SHARED)) {
> +	if (!status && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
>  		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
>  				ioend->io_offset, ioend->io_size);
>  	}
> @@ -418,8 +418,8 @@ xfs_submit_ioend(
>  	memalloc_nofs_restore(nofs_flag);
>  
>  	/* send ioends that might require a transaction to the completion wq */
> -	if (xfs_ioend_is_append(ioend) || ioend->io_type == IOMAP_UNWRITTEN ||
> -	    (ioend->io_flags & IOMAP_F_SHARED))
> +	if (xfs_ioend_is_append(ioend) ||
> +	    (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED)))
>  		ioend->io_bio.bi_end_io = xfs_end_bio;
>  
>  	if (status)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index c0339678d798..31857d4750a9 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -327,13 +327,29 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
>  sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>  		const struct iomap_ops *ops);
>  
> +/*
> + * Flags for iomap_ioend->io_flags.
> + */
> +/* shared COW extent */
> +#define IOMAP_IOEND_SHARED		(1U << 0)
> +/* unwritten extent */
> +#define IOMAP_IOEND_UNWRITTEN		(1U << 1)
> +/* don't merge into previous ioend */
> +#define IOMAP_IOEND_BOUNDARY		(1U << 2)
> +
> +/*
> + * Flags that if set on either ioend prevent the merge of two ioends.
> + * (IOMAP_IOEND_BOUNDARY also prevents merged, but only one-way)

                                          merges

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> + */
> +#define IOMAP_IOEND_NOMERGE_FLAGS \
> +	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)
> +
>  /*
>   * Structure for writeback I/O completions.
>   */
>  struct iomap_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
> -	u16			io_type;
> -	u16			io_flags;	/* IOMAP_F_* */
> +	u16			io_flags;	/* IOMAP_IOEND_* */
>  	struct inode		*io_inode;	/* file being written to */
>  	size_t			io_size;	/* size of the extent */
>  	loff_t			io_offset;	/* offset in the file */
> -- 
> 2.45.2
> 
> 

