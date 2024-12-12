Return-Path: <linux-fsdevel+bounces-37215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F369EF9EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D7629235D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55E0223304;
	Thu, 12 Dec 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImT1gaNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC7222D45;
	Thu, 12 Dec 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026107; cv=none; b=T3QdOMHhfEbpBa+JnKr4TFdXjcE7CqYYCR9p9TiZe0tRwmt07SyenITnyF1moxlQRBeV1qG4gDP52s0nAJr1KKcvzz2gXjb6IHFqYSNrlqvo3jMBZ0xx75fD96+gRZzN6/DX8YBf/QaUiRiRPBo6Ch5MLiu+z7OZS+rJEJ1scr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026107; c=relaxed/simple;
	bh=12CoQJ+YyZHHpV6ASXEt5ysao4GAhJ4p5slVIVsawYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RilNbeHxiDMuodKJpwoFzVOZ5Wegoi5ePZ+4HSs8YcSZXRO6hkFsEal+Dp9AmPW8nFVu6HYnUu8g97hcL1d7X+5VZeBKXRuI4bbfYKaiL8JySKtO8DKInixz1E2QzO07Eu7Mtic/uNuOS4v1N2ZeTYZcetSmEn5lXztXVy0K0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImT1gaNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1C4C4CEDE;
	Thu, 12 Dec 2024 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026105;
	bh=12CoQJ+YyZHHpV6ASXEt5ysao4GAhJ4p5slVIVsawYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ImT1gaNtWDpKzRT9nHZEsFr1Cvyk02VGSXfVlgM241ZqumIF4aISoI5lP9gZcWBsV
	 lCsP/heRhGYnZoFY7dq9l9aG+34nVhXTHn9Wd7mkWj2WYEJAhllRDUMQn6wOB9KNLd
	 atFnKsZ6RuAlwfvZnODgJhTBux1agOsTa6+TyAX/bz+MYZx/sVbgCjyeSw08XoRV2R
	 Z5DJ9tgM1x2+cmQkcwn44Dw5+hzXJ/J8FAWHdZDejcw5JAAaW/uGPmHCJL/2mmF11y
	 ogHFSuBA597soPQY0/E6BXM9MqmONiHPxoAx29BdZ58yTqDWzr+meSfrxsPnt1lHRR
	 M3NvHDoxlso6w==
Date: Thu, 12 Dec 2024 09:55:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] iomap: simplify io_flags and io_type in struct
 iomap_ioend
Message-ID: <20241212175504.GF6678@frogsfrogsfrogs>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085420.1380396-3-hch@lst.de>

On Wed, Dec 11, 2024 at 09:53:42AM +0100, Christoph Hellwig wrote:
> The ioend fields for distinct types of I/O are a bit complicated.
> Consolidate them into a single io_flag field with it's own flags
> decoupled from the iomap flags.  This also prepares for adding a new
> flag that is unrelated to both of the iomap namespaces.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 39 ++++++++++++++++++++++-----------------
>  fs/xfs/xfs_aops.c      | 12 ++++++------
>  include/linux/iomap.h  | 16 ++++++++++++++--
>  3 files changed, 42 insertions(+), 25 deletions(-)
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
> index c0339678d798..1d8658c7beb8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -327,13 +327,25 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
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
> +#define IOMAP_IOEND_NOMERGE_FLAGS \
> +	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)

Hmm.  At first I wondered "Why wouldn't BOUNDARY be in here too?  It
also prevents merging of ioends."  Then I remembered that BOUNDARY is an
explicit nomerge flag, whereas what NOMERGE_FLAGS provides is that we
always split ioends whenever the ioend work changes.

How about a comment?

/* split ioends when the type of completion work changes */
#define IOMAP_IOEND_NOMERGE_FLAGS \
	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN)

Otherwise this looks fine to me.

--D

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

