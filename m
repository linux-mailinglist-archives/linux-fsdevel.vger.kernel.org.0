Return-Path: <linux-fsdevel+bounces-37166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2C9EE7A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 14:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1837318887E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05472144BE;
	Thu, 12 Dec 2024 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL73UxNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2D21421C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010001; cv=none; b=Z0/x73b4sH2x6pACvDYMiEamendfCMlRgwEj4ObJoDBJaJdXzBgl1VzFBV+vzs+B/OXjoKvN+DB/mJMnUBNieMLIM5u/OSd0uWczg3x8+4T/oLxF9DSzEVuvnSq5w8teWYS8qNPMEFVX65t4/9pHkcUbFnRhi1iVqiZW4Er8qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010001; c=relaxed/simple;
	bh=u+dmpNG8Yj8BcGE5i4DtJvzd73IcK3nhueSWatmvk8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY3lrWIbZzppd6GOJSfFBBlTncxo+jwq9EtuXEuL3aOl2RPToynTVzeJkWZg6ooYY/95tCytAE/og/xcKMnZ7sTlJAlra5jMyP6qiVNBIMZ81rlil/CPFywmvfmtU7K9XWXp6MIZ9lVUcjSJrfv+seOqYqnSfJBtiKwFq3ujQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TL73UxNB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734009998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3YvNJkl05maIGuNuzoWVYbhwHtKq/NS+r9OpCLbvxXo=;
	b=TL73UxNB8qI2s8juygDWOkNmWf7WrFDQ5WuXSaMLgFVUQFDRsGIZpssAivE+WILj7Hvyao
	eGEOUAMMk+Wef+vMx5p26VgZrTQUtP23mi7J0JnS48k4xq1yE8u7F+udBCwGqehft5rAtL
	ZmTlxkSD3vgrc5BabEJnvPEmpohrBAw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-OapHiv5aNu68T3XbCFz4hA-1; Thu,
 12 Dec 2024 08:26:34 -0500
X-MC-Unique: OapHiv5aNu68T3XbCFz4hA-1
X-Mimecast-MFC-AGG-ID: OapHiv5aNu68T3XbCFz4hA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9C741956088;
	Thu, 12 Dec 2024 13:26:32 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 867EB1956052;
	Thu, 12 Dec 2024 13:26:31 +0000 (UTC)
Date: Thu, 12 Dec 2024 08:28:17 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/8] iomap: split bios to zone append limits in the
 submission handlers
Message-ID: <Z1rk8YriBRX637h6@bfoster>
References: <20241211085420.1380396-1-hch@lst.de>
 <20241211085420.1380396-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085420.1380396-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 11, 2024 at 09:53:44AM +0100, Christoph Hellwig wrote:
> Provide helpers for file systems to split bios in the direct I/O and
> writeback I/O submission handlers.
> 
> This Follows btrfs' lead and don't try to build bios to hardware limits
> for zone append commands, but instead build them as normal unconstrained
> bios and split them to the hardware limits in the I/O submission handler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/Makefile      |  1 +
>  fs/iomap/buffered-io.c | 43 ++++++++++++++-----------
>  fs/iomap/ioend.c       | 73 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h  |  9 ++++++
>  4 files changed, 108 insertions(+), 18 deletions(-)
>  create mode 100644 fs/iomap/ioend.c
> 
...
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> new file mode 100644
> index 000000000000..f3d98121c593
> --- /dev/null
> +++ b/fs/iomap/ioend.c
...

It might be useful to add a small comment here to point out this splits
from the front of the ioend (i.e. akin to bio_split()), documents the
params, and maybe mentions the ioend relationship requirements (i.e.
according to bio_split(), the split ioend bio refers to the vectors in
the original ioend bio).

Brian

> +struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend, bool is_append,
> +		unsigned int *alloc_len)
> +{
> +	struct bio *bio = &ioend->io_bio;
> +	struct iomap_ioend *split_ioend;
> +	struct bio *split;
> +	int sector_offset;
> +	unsigned int nr_segs;
> +
> +	if (is_append) {
> +		struct queue_limits *lim = bdev_limits(bio->bi_bdev);
> +
> +		sector_offset = bio_split_rw_at(bio, lim, &nr_segs,
> +			min(lim->max_zone_append_sectors << SECTOR_SHIFT,
> +			    *alloc_len));
> +		if (!sector_offset)
> +			return NULL;
> +	} else {
> +		if (bio->bi_iter.bi_size <= *alloc_len)
> +			return NULL;
> +		sector_offset = *alloc_len >> SECTOR_SHIFT;
> +	}
> +
> +	/* ensure the split ioend is still block size aligned */
> +	sector_offset = ALIGN_DOWN(sector_offset << SECTOR_SHIFT,
> +			i_blocksize(ioend->io_inode)) >> SECTOR_SHIFT;
> +
> +	split = bio_split(bio, sector_offset, GFP_NOFS, &iomap_ioend_bioset);
> +	if (!split)
> +		return NULL;
> +	split->bi_private = bio->bi_private;
> +	split->bi_end_io = bio->bi_end_io;
> +
> +	split_ioend = iomap_init_ioend(ioend->io_inode, split, ioend->io_offset,
> +			ioend->io_flags);
> +	split_ioend->io_parent = ioend;
> +
> +	atomic_inc(&ioend->io_remaining);
> +	ioend->io_offset += split_ioend->io_size;
> +	ioend->io_size -= split_ioend->io_size;
> +
> +	split_ioend->io_sector = ioend->io_sector;
> +	if (!is_append)
> +		ioend->io_sector += (split_ioend->io_size >> SECTOR_SHIFT);
> +
> +	*alloc_len -= split->bi_iter.bi_size;
> +	return split_ioend;
> +}
> +EXPORT_SYMBOL_GPL(iomap_split_ioend);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 173d490c20ba..eaa8cb9083eb 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -354,6 +354,9 @@ struct iomap_ioend {
>  	struct list_head	io_list;	/* next ioend in chain */
>  	u16			io_flags;	/* IOMAP_IOEND_* */
>  	struct inode		*io_inode;	/* file being written to */
> +	atomic_t		io_remaining;	/* completetion defer count */
> +	int			io_error;	/* stashed away status */
> +	struct iomap_ioend	*io_parent;	/* parent for completions */
>  	size_t			io_size;	/* size of the extent */
>  	loff_t			io_offset;	/* offset in the file */
>  	sector_t		io_sector;	/* start sector of ioend */
> @@ -404,6 +407,10 @@ struct iomap_writepage_ctx {
>  	u32			nr_folios;	/* folios added to the ioend */
>  };
>  
> +struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
> +		loff_t file_offset, u16 flags);
> +struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend, bool is_append,
> +		unsigned int *alloc_len);
>  void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
>  void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  		struct list_head *more_ioends);
> @@ -475,4 +482,6 @@ int iomap_swapfile_activate(struct swap_info_struct *sis,
>  # define iomap_swapfile_activate(sis, swapfile, pagespan, ops)	(-EIO)
>  #endif /* CONFIG_SWAP */
>  
> +extern struct bio_set iomap_ioend_bioset;
> +
>  #endif /* LINUX_IOMAP_H */
> -- 
> 2.45.2
> 
> 


