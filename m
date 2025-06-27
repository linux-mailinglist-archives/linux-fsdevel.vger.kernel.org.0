Return-Path: <linux-fsdevel+bounces-53194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D4AEBB41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 17:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9E87AE438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0052E9EC9;
	Fri, 27 Jun 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEVtVQ00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BB2E92B3
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037047; cv=none; b=fQnVYpLqu4qAvSVePWNj0gdmzoKEhNGeZ43Qbt8eDH5GVEghEHgMDErgfuynfeDKeK0aCL1CmLTMrYRnU4wrxsoD6YL7Og+TlRlLz49OtcPpaUI09tnoKPm/YXqbyBK5CWldkFiohd/B4DpzXkOl2NK0qmmEicPc11LAo3PUtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037047; c=relaxed/simple;
	bh=HGQP5li3WrDmekPHoDU6eYqYM6dVY+DNgStsNX78FP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eofrThEC4R31VA0JL5MugXabP0/LREWQOUgkyjQmiJ3Tps8JRLcBsW6NpfCNBZ5KwU4dg0ABYX6xUrX2PDX9Np8NLSnHyI3EPtlH67ZodQJG/Ps0u7Dh8ma+lYvcn2pROeEnawS/XbvA71FB57arH9u2YntnQDBMkSN4SMpAo0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEVtVQ00; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751037044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llX20R4Mozg/Ao8YukcDDKaOGW1Jv50RqZhYbfy5PRM=;
	b=YEVtVQ00ynt+pBTJedMLZPIjn7JSVW7eK3+GJjaTWbFiB4cjEuU9/vuDBSQODJYmy3v3j8
	9vyh+S0tBU4qYNsSkWQ8t6rirmT4cHGpi76Gi217/1fG42oPsG4TfhiiOJhKAtAdY/8VHX
	MBpJ44gtN/WXLEn504MngEC/VMKMEao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-ctA2miMtOz2s3DgGnIcO6Q-1; Fri,
 27 Jun 2025 11:10:41 -0400
X-MC-Unique: ctA2miMtOz2s3DgGnIcO6Q-1
X-Mimecast-MFC-AGG-ID: ctA2miMtOz2s3DgGnIcO6Q_1751037039
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7A5D1801BD8;
	Fri, 27 Jun 2025 15:10:39 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCC9E1956095;
	Fri, 27 Jun 2025 15:10:37 +0000 (UTC)
Date: Fri, 27 Jun 2025 11:14:15 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 04/12] iomap: hide ioends from the generic writeback code
Message-ID: <aF61R1RjzsAQdVW3@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627070328.975394-5-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Jun 27, 2025 at 09:02:37AM +0200, Christoph Hellwig wrote:
> Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
> one to facilitate non-block, non-ioend writeback for use.  Rename
> the submit_ioend method to writeback_submit and make it mandatory so
> that the generic writeback code stops seeing ioends and bios.
> 
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  .../filesystems/iomap/operations.rst          | 16 +---
>  block/fops.c                                  |  1 +
>  fs/gfs2/bmap.c                                |  1 +
>  fs/iomap/buffered-io.c                        | 91 ++++++++++---------
>  fs/xfs/xfs_aops.c                             | 60 ++++++------
>  fs/zonefs/file.c                              |  1 +
>  include/linux/iomap.h                         | 19 ++--
>  7 files changed, 93 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> index 3c7989ee84ff..7073c1a3ede3 100644
> --- a/Documentation/filesystems/iomap/operations.rst
> +++ b/Documentation/filesystems/iomap/operations.rst
> @@ -285,7 +285,7 @@ The ``ops`` structure must be specified and is as follows:
>   struct iomap_writeback_ops {
>      int (*writeback_range)(struct iomap_writeback_ctx *wpc,
>      		struct folio *folio, u64 pos, unsigned int len, u64 end_pos);
> -    int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
> +    int (*writeback_submit)(struct iomap_writeback_ctx *wpc, int error);
>   };
>  
>  The fields are as follows:
> @@ -307,13 +307,7 @@ The fields are as follows:
>      purpose.
>      This function must be supplied by the filesystem.
>  
> -  - ``submit_ioend``: Allows the file systems to hook into writeback bio
> -    submission.
> -    This might include pre-write space accounting updates, or installing
> -    a custom ``->bi_end_io`` function for internal purposes, such as
> -    deferring the ioend completion to a workqueue to run metadata update
> -    transactions from process context before submitting the bio.
> -    This function is optional.
> +  - ``writeback_submit``: Submit the previous built writeback context.
>  
>  Pagecache Writeback Completion
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -328,12 +322,6 @@ the address space.
>  This can happen in interrupt or process context, depending on the
>  storage device.
>  
> -Filesystems that need to update internal bookkeeping (e.g. unwritten
> -extent conversions) should provide a ``->submit_ioend`` function to
> -set ``struct iomap_end::bio::bi_end_io`` to its own function.
> -This function should call ``iomap_finish_ioends`` after finishing its
> -own work (e.g. unwritten extent conversion).
> -
>  Some filesystems may wish to `amortize the cost of running metadata
>  transactions
>  <https://lore.kernel.org/all/20220120034733.221737-1-david@fromorbit.com/>`_
> diff --git a/block/fops.c b/block/fops.c
> index 692be63a4aa0..777f2318eca2 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -560,6 +560,7 @@ static ssize_t blkdev_writeback_range(struct iomap_writeback_ctx *wpc,
>  
>  static const struct iomap_writeback_ops blkdev_writeback_ops = {
>  	.writeback_range	= blkdev_writeback_range,
> +	.writeback_submit	= ioend_writeback_submit,
>  };
>  
>  static int blkdev_writepages(struct address_space *mapping,
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index ff72e04a4788..eb49e49f2db4 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -2490,4 +2490,5 @@ static ssize_t gfs2_writeback_range(struct iomap_writeback_ctx *wpc,
>  
>  const struct iomap_writeback_ops gfs2_writeback_ops = {
>  	.writeback_range	= gfs2_writeback_range,
> +	.writeback_submit	= ioend_writeback_submit,
>  };
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a54b14817cd0..a72ab487c8ab 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1579,7 +1579,7 @@ u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend)
>  	return folio_count;
>  }
>  
> -static void iomap_writepage_end_bio(struct bio *bio)
> +static void ioend_writeback_end_bio(struct bio *bio)
>  {
>  	struct iomap_ioend *ioend = iomap_ioend_from_bio(bio);
>  
> @@ -1588,42 +1588,30 @@ static void iomap_writepage_end_bio(struct bio *bio)
>  }
>  
>  /*
> - * Submit an ioend.
> - *
> - * If @error is non-zero, it means that we have a situation where some part of
> - * the submission process has failed after we've marked pages for writeback.
> - * We cannot cancel ioend directly in that case, so call the bio end I/O handler
> - * with the error status here to run the normal I/O completion handler to clear
> - * the writeback bit and let the file system proess the errors.
> + * We cannot cancel the ioend directly in case of an error, so call the bio end
> + * I/O handler with the error status here to run the normal I/O completion
> + * handler.
>   */
> -static int iomap_submit_ioend(struct iomap_writeback_ctx *wpc, int error)
> +int ioend_writeback_submit(struct iomap_writeback_ctx *wpc, int error)
>  {
> -	if (!wpc->ioend)
> -		return error;
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
>  
> -	/*
> -	 * Let the file systems prepare the I/O submission and hook in an I/O
> -	 * comletion handler.  This also needs to happen in case after a
> -	 * failure happened so that the file system end I/O handler gets called
> -	 * to clean up.
> -	 */
> -	if (wpc->ops->submit_ioend) {
> -		error = wpc->ops->submit_ioend(wpc, error);
> -	} else {
> -		if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> -			error = -EIO;
> -		if (!error)
> -			submit_bio(&wpc->ioend->io_bio);
> -	}
> +	if (!ioend->io_bio.bi_end_io)
> +		ioend->io_bio.bi_end_io = ioend_writeback_end_bio;
> +
> +	if (WARN_ON_ONCE(wpc->iomap.flags & IOMAP_F_ANON_WRITE))
> +		error = -EIO;
>  
>  	if (error) {
> -		wpc->ioend->io_bio.bi_status = errno_to_blk_status(error);
> -		bio_endio(&wpc->ioend->io_bio);
> +		ioend->io_bio.bi_status = errno_to_blk_status(error);
> +		bio_endio(&ioend->io_bio);
> +		return error;
>  	}
>  
> -	wpc->ioend = NULL;
> -	return error;
> +	submit_bio(&ioend->io_bio);
> +	return 0;
>  }
> +EXPORT_SYMBOL_GPL(ioend_writeback_submit);
>  
>  static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writeback_ctx *wpc,
>  		loff_t pos, u16 ioend_flags)
> @@ -1634,7 +1622,6 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writeback_ctx *wpc,
>  			       REQ_OP_WRITE | wbc_to_write_flags(wpc->wbc),
>  			       GFP_NOFS, &iomap_ioend_bioset);
>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
> -	bio->bi_end_io = iomap_writepage_end_bio;
>  	bio->bi_write_hint = wpc->inode->i_write_hint;
>  	wbc_init_bio(wpc->wbc, bio);
>  	wpc->nr_folios = 0;
> @@ -1644,16 +1631,17 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writeback_ctx *wpc,
>  static bool iomap_can_add_to_ioend(struct iomap_writeback_ctx *wpc, loff_t pos,
>  		u16 ioend_flags)
>  {
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
> +
>  	if (ioend_flags & IOMAP_IOEND_BOUNDARY)
>  		return false;
>  	if ((ioend_flags & IOMAP_IOEND_NOMERGE_FLAGS) !=
> -	    (wpc->ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
> +	    (ioend->io_flags & IOMAP_IOEND_NOMERGE_FLAGS))
>  		return false;
> -	if (pos != wpc->ioend->io_offset + wpc->ioend->io_size)
> +	if (pos != ioend->io_offset + ioend->io_size)
>  		return false;
>  	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
> -	    iomap_sector(&wpc->iomap, pos) !=
> -	    bio_end_sector(&wpc->ioend->io_bio))
> +	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
>  		return false;
>  	/*
>  	 * Limit ioend bio chain lengths to minimise IO completion latency. This
> @@ -1679,6 +1667,7 @@ static bool iomap_can_add_to_ioend(struct iomap_writeback_ctx *wpc, loff_t pos,
>  ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len)
>  {
> +	struct iomap_ioend *ioend = wpc->wb_ctx;
>  	struct iomap_folio_state *ifs = folio->private;
>  	size_t poff = offset_in_folio(folio, pos);
>  	unsigned int ioend_flags = 0;
> @@ -1709,15 +1698,17 @@ ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
>  	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
>  		ioend_flags |= IOMAP_IOEND_BOUNDARY;
>  
> -	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
> +	if (!ioend || !iomap_can_add_to_ioend(wpc, pos, ioend_flags)) {
>  new_ioend:
> -		error = iomap_submit_ioend(wpc, 0);
> -		if (error)
> -			return error;
> -		wpc->ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
> +		if (ioend) {
> +			error = wpc->ops->writeback_submit(wpc, 0);
> +			if (error)
> +				return error;
> +		}
> +		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
>  	}
>  
> -	if (!bio_add_folio(&wpc->ioend->io_bio, folio, map_len, poff))
> +	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
>  		goto new_ioend;
>  
>  	if (ifs)
> @@ -1764,9 +1755,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
>  	 * Note that this defeats the ability to chain the ioends of
>  	 * appending writes.
>  	 */
> -	wpc->ioend->io_size += map_len;
> -	if (wpc->ioend->io_offset + wpc->ioend->io_size > end_pos)
> -		wpc->ioend->io_size = end_pos - wpc->ioend->io_offset;
> +	ioend->io_size += map_len;
> +	if (ioend->io_offset + ioend->io_size > end_pos)
> +		ioend->io_size = end_pos - ioend->io_offset;
>  
>  	wbc_account_cgroup_owner(wpc->wbc, folio, map_len);
>  	return map_len;
> @@ -1956,6 +1947,18 @@ iomap_writepages(struct iomap_writeback_ctx *wpc)
>  
>  	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
>  		error = iomap_writepage_map(wpc, folio);
> -	return iomap_submit_ioend(wpc, error);
> +
> +	/*
> +	 * If @error is non-zero, it means that we have a situation where some
> +	 * part of the submission process has failed after we've marked pages
> +	 * for writeback.
> +	 *
> +	 * We cannot cancel the writeback directly in that case, so always call
> +	 * ->writeback_submit to run the I/O completion handler to clear the
> +	 * writeback bit and let the file system proess the errors.
> +	 */
> +	if (wpc->wb_ctx)
> +		return wpc->ops->writeback_submit(wpc, error);
> +	return error;
>  }
>  EXPORT_SYMBOL_GPL(iomap_writepages);
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index ce4ed03db21d..193000e9ca7b 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -514,41 +514,40 @@ xfs_ioend_needs_wq_completion(
>  }
>  
>  static int
> -xfs_submit_ioend(
> -	struct iomap_writeback_ctx *wpc,
> -	int			status)
> +xfs_writeback_submit(
> +	struct iomap_writeback_ctx	*wpc,
> +	int				error)
>  {
> -	struct iomap_ioend	*ioend = wpc->ioend;
> -	unsigned int		nofs_flag;
> +	struct iomap_ioend		*ioend = wpc->wb_ctx;
>  
>  	/*
> -	 * We can allocate memory here while doing writeback on behalf of
> -	 * memory reclaim.  To avoid memory allocation deadlocks set the
> -	 * task-wide nofs context for the following operations.
> +	 * Convert CoW extents to regular.
> +	 *
> +	 * We can allocate memory here while doing writeback on behalf of memory
> +	 * reclaim.  To avoid memory allocation deadlocks, set the task-wide
> +	 * nofs context.
>  	 */
> -	nofs_flag = memalloc_nofs_save();
> +	if (!error && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
> +		unsigned int		nofs_flag;
>  
> -	/* Convert CoW extents to regular */
> -	if (!status && (ioend->io_flags & IOMAP_IOEND_SHARED)) {
> -		status = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
> +		nofs_flag = memalloc_nofs_save();
> +		error = xfs_reflink_convert_cow(XFS_I(ioend->io_inode),
>  				ioend->io_offset, ioend->io_size);
> +		memalloc_nofs_restore(nofs_flag);
>  	}
>  
> -	memalloc_nofs_restore(nofs_flag);
> -
> -	/* send ioends that might require a transaction to the completion wq */
> +	/*
> +	 * Send ioends that might require a transaction to the completion wq.
> +	 */
>  	if (xfs_ioend_needs_wq_completion(ioend))
>  		ioend->io_bio.bi_end_io = xfs_end_bio;
>  
> -	if (status)
> -		return status;
> -	submit_bio(&ioend->io_bio);
> -	return 0;
> +	return ioend_writeback_submit(wpc, error);
>  }
>  
>  static const struct iomap_writeback_ops xfs_writeback_ops = {
>  	.writeback_range	= xfs_writeback_range,
> -	.submit_ioend		= xfs_submit_ioend,
> +	.writeback_submit	= xfs_writeback_submit,
>  };
>  
>  struct xfs_zoned_writepage_ctx {
> @@ -646,20 +645,25 @@ xfs_zoned_writeback_range(
>  }
>  
>  static int
> -xfs_zoned_submit_ioend(
> -	struct iomap_writeback_ctx *wpc,
> -	int			status)
> +xfs_zoned_writeback_submit(
> +	struct iomap_writeback_ctx	*wpc,
> +	int				error)
>  {
> -	wpc->ioend->io_bio.bi_end_io = xfs_end_bio;
> -	if (status)
> -		return status;
> -	xfs_zone_alloc_and_submit(wpc->ioend, &XFS_ZWPC(wpc)->open_zone);
> +	struct iomap_ioend		*ioend = wpc->wb_ctx;
> +
> +	ioend->io_bio.bi_end_io = xfs_end_bio;
> +	if (error) {
> +		ioend->io_bio.bi_status = errno_to_blk_status(error);
> +		bio_endio(&ioend->io_bio);
> +		return error;
> +	}
> +	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
>  	return 0;
>  }
>  
>  static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
>  	.writeback_range	= xfs_zoned_writeback_range,
> -	.submit_ioend		= xfs_zoned_submit_ioend,
> +	.writeback_submit	= xfs_zoned_writeback_submit,
>  };
>  
>  STATIC int
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index cb3d380c4651..a0ce6c97b9e5 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -151,6 +151,7 @@ static ssize_t zonefs_writeback_range(struct iomap_writeback_ctx *wpc,
>  
>  static const struct iomap_writeback_ops zonefs_writeback_ops = {
>  	.writeback_range	= zonefs_writeback_range,
> +	.writeback_submit	= ioend_writeback_submit,
>  };
>  
>  static int zonefs_writepages(struct address_space *mapping,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index e346475a023d..b65951cdb0b5 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -391,8 +391,7 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
>  /*
>   * Structure for writeback I/O completions.
>   *
> - * File systems implementing ->submit_ioend (for buffered I/O) or ->submit_io
> - * for direct I/O) can split a bio generated by iomap.  In that case the parent
> + * File systems can split a bio generated by iomap.  In that case the parent
>   * ioend it was split from is recorded in ioend->io_parent.
>   */
>  struct iomap_ioend {
> @@ -416,7 +415,7 @@ static inline struct iomap_ioend *iomap_ioend_from_bio(struct bio *bio)
>  
>  struct iomap_writeback_ops {
>  	/*
> -	 * Required, performs writeback on the passed in range
> +	 * Performs writeback on the passed in range
>  	 *
>  	 * Can map arbitrarily large regions, but we need to call into it at
>  	 * least once per folio to allow the file systems to synchronize with
> @@ -432,23 +431,22 @@ struct iomap_writeback_ops {
>  			u64 end_pos);
>  
>  	/*
> -	 * Optional, allows the file systems to hook into bio submission,
> -	 * including overriding the bi_end_io handler.
> +	 * Submit a writeback context previously build up by ->writeback_range.
>  	 *
> -	 * Returns 0 if the bio was successfully submitted, or a negative
> -	 * error code if status was non-zero or another error happened and
> -	 * the bio could not be submitted.
> +	 * Returns 0 if the context was successfully submitted, or a negative
> +	 * error code if not.  If @error is non-zero a failure occurred, and
> +	 * the writeback context should be completed with an error.
>  	 */
> -	int (*submit_ioend)(struct iomap_writeback_ctx *wpc, int status);
> +	int (*writeback_submit)(struct iomap_writeback_ctx *wpc, int error);
>  };
>  
>  struct iomap_writeback_ctx {
>  	struct iomap		iomap;
>  	struct inode		*inode;
>  	struct writeback_control *wbc;
> -	struct iomap_ioend	*ioend;
>  	const struct iomap_writeback_ops *ops;
>  	u32			nr_folios;	/* folios added to the ioend */
> +	void			*wb_ctx;	/* pending writeback context */
>  };
>  
>  struct iomap_ioend *iomap_init_ioend(struct inode *inode, struct bio *bio,
> @@ -461,6 +459,7 @@ void iomap_ioend_try_merge(struct iomap_ioend *ioend,
>  void iomap_sort_ioends(struct list_head *ioend_list);
>  ssize_t iomap_add_to_ioend(struct iomap_writeback_ctx *wpc, struct folio *folio,
>  		loff_t pos, loff_t end_pos, unsigned int dirty_len);
> +int ioend_writeback_submit(struct iomap_writeback_ctx *wpc, int error);
>  int iomap_writepages(struct iomap_writeback_ctx *wpc);
>  
>  /*
> -- 
> 2.47.2
> 
> 


