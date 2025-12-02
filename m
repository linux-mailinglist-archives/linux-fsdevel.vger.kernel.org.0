Return-Path: <linux-fsdevel+bounces-70455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E512C9B9F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 14:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C8F34E359E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389530FC39;
	Tue,  2 Dec 2025 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCaBHLKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193C3148B1
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682645; cv=none; b=PsrDaGgfbapQsjAg2x1Cgo2Fh53+VcuW3l/tWhqu8f1aPdbSWaQmITBA61luBW0NjJzFvPT6ypXBQS4s9QJqBwPLGicQ3JZtOMjNmUjdgTPpsQUGhBruuLIuWlHDXTH3KYIMicDkpA22eN3g52/27u71hujvgZ/uau3F2nM9Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682645; c=relaxed/simple;
	bh=eUC/s5SL7Kmrdqg5QjeyaScbFhzIfys8Z4WTDksDFdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGTY8CZU5DuG/JJNViaxtkr396CZwJTYrI41a0mKFj2OnoV2zr7XYgSsT3zBqAqPJrt7LE9L3awQIr59aWr1ZxNoFZMwuNEIIkrSMsNkIr1cdSpwafUz1qSE8RavPbZCjtHdY+/lkfKN0+AVJIy9iV6oclRZ1hcvFV2KXokJcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCaBHLKf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764682641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcUzrAb3qq7Vvs6dUFvuelg7qtX7KSoqzyWKBZU1do4=;
	b=WCaBHLKfHnpYlEtpVQc4tWrDdP8OM6hZGdKucJfjD3mi0KpLD3T7LfpkaB5XA4nGyQ7nQy
	EG8T3+HESrjczaiZFWtgDvx32c9qGr7wXRNlRWQdQPVpMaYOYXXHQKop/cxLwzQvvnF4vT
	I81UHwtReub11dIl0AjBTxkczJSejrM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-0GKU8OQsNdmTT_A2xVojrg-1; Tue,
 02 Dec 2025 08:37:17 -0500
X-MC-Unique: 0GKU8OQsNdmTT_A2xVojrg-1
X-Mimecast-MFC-AGG-ID: 0GKU8OQsNdmTT_A2xVojrg_1764682635
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A3C31800473;
	Tue,  2 Dec 2025 13:37:15 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 209D730001B9;
	Tue,  2 Dec 2025 13:37:13 +0000 (UTC)
Date: Tue, 2 Dec 2025 08:37:11 -0500
From: Brian Foster <bfoster@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] iomap: replace folio_batch allocation with stack
 allocation
Message-ID: <aS7rhw7kG-ppddVY@bfoster>
References: <20251113135404.553339-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113135404.553339-1-bfoster@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 13, 2025 at 08:54:04AM -0500, Brian Foster wrote:
> Zhang Yi points out that the dynamic folio_batch allocation in
> iomap_fill_dirty_folios() is problematic for the ext4 on iomap work
> that is under development because it doesn't sufficiently handle the
> allocation failure case (by allowing a retry, for example).
> 
> The dynamic allocation was initially added for simplicity and to
> help indicate whether the batch was used or not by the calling fs.
> To address this issue, put the batch on the stack of
> iomap_zero_range() and use a flag to control whether the batch
> should be used in the iomap folio lookup path. This keeps things
> simple and eliminates the concern for ext4 on iomap.
> 
> While here, also clean up the fill helper signature to be more
> consistent with the underlying filemap helper. Pass through the
> return value of the filemap helper (folio count) and update the
> lookup offset via an out param.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Acked-by: Dave Chinner <dchinner@redhat.com>
> ---

Ping..

Christoph, Darrick,

Any further thoughts on this one? The batch allocation seems to still be
implicated in syzbot reports, so it would be nice to have that knocked
out (and to get this one into test machinery sooner if possible).

Brian

> 
> v2:
> - Reworked fill function to return folio count and pass flags as param.
> - Updated commit log to note function signature changes.
> v1: https://lore.kernel.org/linux-fsdevel/20251111175047.321869-1-bfoster@redhat.com/
> 
>  fs/iomap/buffered-io.c | 50 +++++++++++++++++++++++++++++-------------
>  fs/iomap/iter.c        |  6 ++---
>  fs/xfs/xfs_iomap.c     | 11 +++++-----
>  include/linux/iomap.h  |  8 +++++--
>  4 files changed, 50 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9b0b9cf7caa7..bc8b2ebb3330 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -772,7 +772,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> -	if (iter->fbatch) {
> +	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
>  		struct folio *folio = folio_batch_next(iter->fbatch);
>  
>  		if (!folio)
> @@ -869,7 +869,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
>  	 * process so return and let the caller iterate and refill the batch.
>  	 */
>  	if (!folio) {
> -		WARN_ON_ONCE(!iter->fbatch);
> +		WARN_ON_ONCE(!(iter->iomap.flags & IOMAP_F_FOLIO_BATCH));
>  		return 0;
>  	}
>  
> @@ -1483,23 +1483,39 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
>  	return status;
>  }
>  
> -loff_t
> +/**
> + * iomap_fill_dirty_folios - fill a folio batch with dirty folios
> + * @iter: Iteration structure
> + * @start: Start offset of range. Updated based on lookup progress.
> + * @end: End offset of range
> + * @iomap_flags: Flags to set on the associated iomap to track the batch.
> + *
> + * Returns the folio count directly. Also returns the associated control flag if
> + * the the batch lookup is performed and the expected offset of a subsequent
> + * lookup via out params. The caller is responsible to set the flag on the
> + * associated iomap.
> + */
> +unsigned int
>  iomap_fill_dirty_folios(
>  	struct iomap_iter	*iter,
> -	loff_t			offset,
> -	loff_t			length)
> +	loff_t			*start,
> +	loff_t			end,
> +	unsigned int		*iomap_flags)
>  {
>  	struct address_space	*mapping = iter->inode->i_mapping;
> -	pgoff_t			start = offset >> PAGE_SHIFT;
> -	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
> +	pgoff_t			pstart = *start >> PAGE_SHIFT;
> +	pgoff_t			pend = (end - 1) >> PAGE_SHIFT;
> +	unsigned int		count;
>  
> -	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
> -	if (!iter->fbatch)
> -		return offset + length;
> -	folio_batch_init(iter->fbatch);
> +	if (!iter->fbatch) {
> +		*start = end;
> +		return 0;
> +	}
>  
> -	filemap_get_folios_dirty(mapping, &start, end, iter->fbatch);
> -	return (start << PAGE_SHIFT);
> +	count = filemap_get_folios_dirty(mapping, &pstart, pend, iter->fbatch);
> +	*start = (pstart << PAGE_SHIFT);
> +	*iomap_flags |= IOMAP_F_FOLIO_BATCH;
> +	return count;
>  }
>  EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
>  
> @@ -1508,17 +1524,21 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private)
>  {
> +	struct folio_batch fbatch;
>  	struct iomap_iter iter = {
>  		.inode		= inode,
>  		.pos		= pos,
>  		.len		= len,
>  		.flags		= IOMAP_ZERO,
>  		.private	= private,
> +		.fbatch		= &fbatch,
>  	};
>  	struct address_space *mapping = inode->i_mapping;
>  	int ret;
>  	bool range_dirty;
>  
> +	folio_batch_init(&fbatch);
> +
>  	/*
>  	 * To avoid an unconditional flush, check pagecache state and only flush
>  	 * if dirty and the fs returns a mapping that might convert on
> @@ -1529,11 +1549,11 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  	while ((ret = iomap_iter(&iter, ops)) > 0) {
>  		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
>  
> -		if (WARN_ON_ONCE(iter.fbatch &&
> +		if (WARN_ON_ONCE((iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
>  				 srcmap->type != IOMAP_UNWRITTEN))
>  			return -EIO;
>  
> -		if (!iter.fbatch &&
> +		if (!(iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
>  		    (srcmap->type == IOMAP_HOLE ||
>  		     srcmap->type == IOMAP_UNWRITTEN)) {
>  			s64 status;
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 8692e5e41c6d..c04796f6e57f 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -8,10 +8,10 @@
>  
>  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
>  {
> -	if (iter->fbatch) {
> +	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
>  		folio_batch_release(iter->fbatch);
> -		kfree(iter->fbatch);
> -		iter->fbatch = NULL;
> +		folio_batch_reinit(iter->fbatch);
> +		iter->iomap.flags &= ~IOMAP_F_FOLIO_BATCH;
>  	}
>  
>  	iter->status = 0;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 04f39ea15898..37a1b33e9045 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1831,7 +1831,6 @@ xfs_buffered_write_iomap_begin(
>  	 */
>  	if (flags & IOMAP_ZERO) {
>  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> -		u64 end;
>  
>  		if (isnullstartblock(imap.br_startblock) &&
>  		    offset_fsb >= eof_fsb)
> @@ -1851,12 +1850,14 @@ xfs_buffered_write_iomap_begin(
>  		 */
>  		if (imap.br_state == XFS_EXT_UNWRITTEN &&
>  		    offset_fsb < eof_fsb) {
> -			loff_t len = min(count,
> -					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> +			loff_t foffset = offset, fend;
>  
> -			end = iomap_fill_dirty_folios(iter, offset, len);
> +			fend = offset +
> +			       min(count, XFS_FSB_TO_B(mp, imap.br_blockcount));
> +			iomap_fill_dirty_folios(iter, &foffset, fend,
> +						&iomap_flags);
>  			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> -					XFS_B_TO_FSB(mp, end));
> +					XFS_B_TO_FSB(mp, foffset));
>  		}
>  
>  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8b1ac08c7474..ce2c9fbd8e16 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -88,6 +88,9 @@ struct vm_fault;
>  /*
>   * Flags set by the core iomap code during operations:
>   *
> + * IOMAP_F_FOLIO_BATCH indicates that the folio batch mechanism is active
> + * for this operation, set by iomap_fill_dirty_folios().
> + *
>   * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
>   * has changed as the result of this write operation.
>   *
> @@ -95,6 +98,7 @@ struct vm_fault;
>   * range it covers needs to be remapped by the high level before the operation
>   * can proceed.
>   */
> +#define IOMAP_F_FOLIO_BATCH	(1U << 13)
>  #define IOMAP_F_SIZE_CHANGED	(1U << 14)
>  #define IOMAP_F_STALE		(1U << 15)
>  
> @@ -352,8 +356,8 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
>  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops);
> -loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
> -		loff_t length);
> +unsigned int iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t *start,
> +		loff_t end, unsigned int *iomap_flags);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>  		bool *did_zero, const struct iomap_ops *ops,
>  		const struct iomap_write_ops *write_ops, void *private);
> -- 
> 2.51.1
> 
> 


