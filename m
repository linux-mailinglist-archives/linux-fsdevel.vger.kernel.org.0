Return-Path: <linux-fsdevel+bounces-67148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA8FC3667E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8FB1A21411
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2626C334387;
	Wed,  5 Nov 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWOVpr88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9544432ED55
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356211; cv=none; b=cvWIo8ZheRo/Z64qOpFoNDIDBVZcgldDYrRGdoXzkF55K8K2wpaf2o5kuk/5Zn2b+UUWHVT4fkfQCyGG6nAzlhN//D1u77UaIQvws1bTjfFX8n7GDKQXm1FEtBE6YCQOx5Z/Bhi5ExRIlWJh8qhyrKQgLfla5nia3XRZeMRlghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356211; c=relaxed/simple;
	bh=ag5YoTPdrPFC4dkdITJ1pF8E3Z5xpwBr6rSWH351Has=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+itiCMjFD7hL9DTiWoxT6B+0fHXZm0DcVQJr82xOI/ldyiPuv8bPEZgWSL3BuGJCg3a8MqJuL30j36sIc73ZNRwdqrWCtp1JufKSWo2gzlh9uocnt0v/L+GohdNUuazAhlOSGsoW3QPEfX+IDilEpTTOQQj5XICPOUhMuY+IuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWOVpr88; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762356208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7PJUr+f5olR/jyN7nRxBruG+NMIS0PyWOocDj5Lcsb8=;
	b=NWOVpr88hsZckmeona6pdh5ure5a07GCTY7pm5jAL6+RY45/HtzQp8VigUJIWbFnruukum
	W/Kp1TRwxQRMsyQ2z1o298DIwABW9jmxkNi4mKFArJUnkuWKvd8RRuU8pUKQaFxD6Gqaxp
	3qYKNpoappUfKah5Y+CHE5pBaAorm68=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-pjbQSGADOQmuiNDrZXIr9Q-1; Wed,
 05 Nov 2025 10:23:25 -0500
X-MC-Unique: pjbQSGADOQmuiNDrZXIr9Q-1
X-Mimecast-MFC-AGG-ID: pjbQSGADOQmuiNDrZXIr9Q_1762356204
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14C7D1800350;
	Wed,  5 Nov 2025 15:23:24 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.135])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4DC10180035F;
	Wed,  5 Nov 2025 15:23:23 +0000 (UTC)
Date: Wed, 5 Nov 2025 10:27:52 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/6] iomap: replace folio_batch allocation with stack
 allocation
Message-ID: <aQts-Fg2YUoIbVsV@bfoster>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-2-bfoster@redhat.com>
 <20251105000716.GU196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105000716.GU196370@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Nov 04, 2025 at 04:07:16PM -0800, Darrick J. Wong wrote:
> On Thu, Oct 16, 2025 at 03:02:58PM -0400, Brian Foster wrote:
> > Zhang Yi points out that the dynamic folio_batch allocation in
> > iomap_fill_dirty_folios() is problematic for the ext4 on iomap work
> > that is under development because it doesn't sufficiently handle the
> > allocation failure case (by allowing a retry, for example).
> > 
> > The dynamic allocation was initially added for simplicity and to
> > help indicate whether the batch was used or not by the calling fs.
> > To address this issue, put the batch on the stack of
> > iomap_zero_range() and use a flag to control whether the batch
> > should be used in the iomap folio lookup path. This keeps things
> > simple and eliminates the concern for ext4 on iomap.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> Hrmm, so who kmallocs the fbatch array now?  Is that left as an exercise
> to the filesystem?  I'm confused because I don't see the kmalloc call
> reappear elsewhere, at least not in this patch.
> 

It's no longer dynamically allocated. It's allocated on the stack in
iomap_zero_range(), and a flag is set on the iomap if the pagecache
lookup occurs. The allocation is a potential problem for the ext4 on
iomap port, so this elides the need for dealing with alloc failures and
whatnot.

This is probably how it should have been done from the start, but when
the flag related feedback came along it was deep enough in test/review
cycle that I preferred to do it separately.

Brian

> --D
> 
> > ---
> >  fs/iomap/buffered-io.c | 45 ++++++++++++++++++++++++++++--------------
> >  fs/iomap/iter.c        |  6 +++---
> >  fs/xfs/xfs_iomap.c     | 11 ++++++-----
> >  include/linux/iomap.h  |  8 ++++++--
> >  4 files changed, 45 insertions(+), 25 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 51ecb6d48feb..05ff82c5432e 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -761,7 +761,7 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter,
> >  	if (!mapping_large_folio_support(iter->inode->i_mapping))
> >  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
> >  
> > -	if (iter->fbatch) {
> > +	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
> >  		struct folio *folio = folio_batch_next(iter->fbatch);
> >  
> >  		if (!folio)
> > @@ -858,7 +858,7 @@ static int iomap_write_begin(struct iomap_iter *iter,
> >  	 * process so return and let the caller iterate and refill the batch.
> >  	 */
> >  	if (!folio) {
> > -		WARN_ON_ONCE(!iter->fbatch);
> > +		WARN_ON_ONCE(!(iter->iomap.flags & IOMAP_F_FOLIO_BATCH));
> >  		return 0;
> >  	}
> >  
> > @@ -1473,23 +1473,34 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero,
> >  	return status;
> >  }
> >  
> > -loff_t
> > +/**
> > + * iomap_fill_dirty_folios - fill a folio batch with dirty folios
> > + * @iter: Iteration structure
> > + * @start: Start offset of range. Updated based on lookup progress.
> > + * @end: End offset of range
> > + *
> > + * Returns the associated control flag if the folio batch is available and the
> > + * lookup performed. The caller is responsible to set the flag on the associated
> > + * iomap.
> > + */
> > +unsigned int
> >  iomap_fill_dirty_folios(
> >  	struct iomap_iter	*iter,
> > -	loff_t			offset,
> > -	loff_t			length)
> > +	loff_t			*start,
> > +	loff_t			end)
> >  {
> >  	struct address_space	*mapping = iter->inode->i_mapping;
> > -	pgoff_t			start = offset >> PAGE_SHIFT;
> > -	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
> > +	pgoff_t			pstart = *start >> PAGE_SHIFT;
> > +	pgoff_t			pend = (end - 1) >> PAGE_SHIFT;
> >  
> > -	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
> > -	if (!iter->fbatch)
> > -		return offset + length;
> > -	folio_batch_init(iter->fbatch);
> > +	if (!iter->fbatch) {
> > +		*start = end;
> > +		return 0;
> > +	}
> >  
> > -	filemap_get_folios_dirty(mapping, &start, end, iter->fbatch);
> > -	return (start << PAGE_SHIFT);
> > +	filemap_get_folios_dirty(mapping, &pstart, pend, iter->fbatch);
> > +	*start = (pstart << PAGE_SHIFT);
> > +	return IOMAP_F_FOLIO_BATCH;
> >  }
> >  EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);
> >  
> > @@ -1498,17 +1509,21 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  		const struct iomap_ops *ops,
> >  		const struct iomap_write_ops *write_ops, void *private)
> >  {
> > +	struct folio_batch fbatch;
> >  	struct iomap_iter iter = {
> >  		.inode		= inode,
> >  		.pos		= pos,
> >  		.len		= len,
> >  		.flags		= IOMAP_ZERO,
> >  		.private	= private,
> > +		.fbatch		= &fbatch,
> >  	};
> >  	struct address_space *mapping = inode->i_mapping;
> >  	int ret;
> >  	bool range_dirty;
> >  
> > +	folio_batch_init(&fbatch);
> > +
> >  	/*
> >  	 * To avoid an unconditional flush, check pagecache state and only flush
> >  	 * if dirty and the fs returns a mapping that might convert on
> > @@ -1519,11 +1534,11 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  	while ((ret = iomap_iter(&iter, ops)) > 0) {
> >  		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
> >  
> > -		if (WARN_ON_ONCE(iter.fbatch &&
> > +		if (WARN_ON_ONCE((iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
> >  				 srcmap->type != IOMAP_UNWRITTEN))
> >  			return -EIO;
> >  
> > -		if (!iter.fbatch &&
> > +		if (!(iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
> >  		    (srcmap->type == IOMAP_HOLE ||
> >  		     srcmap->type == IOMAP_UNWRITTEN)) {
> >  			s64 status;
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index 66ca12aac57d..026d85823c76 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > @@ -8,10 +8,10 @@
> >  
> >  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
> >  {
> > -	if (iter->fbatch) {
> > +	if (iter->iomap.flags & IOMAP_F_FOLIO_BATCH) {
> >  		folio_batch_release(iter->fbatch);
> > -		kfree(iter->fbatch);
> > -		iter->fbatch = NULL;
> > +		folio_batch_reinit(iter->fbatch);
> > +		iter->iomap.flags &= ~IOMAP_F_FOLIO_BATCH;
> >  	}
> >  
> >  	iter->status = 0;
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 535bf3b8705d..01833aca37ac 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1775,7 +1775,6 @@ xfs_buffered_write_iomap_begin(
> >  	 */
> >  	if (flags & IOMAP_ZERO) {
> >  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > -		u64 end;
> >  
> >  		if (isnullstartblock(imap.br_startblock) &&
> >  		    offset_fsb >= eof_fsb)
> > @@ -1795,12 +1794,14 @@ xfs_buffered_write_iomap_begin(
> >  		 */
> >  		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> >  		    offset_fsb < eof_fsb) {
> > -			loff_t len = min(count,
> > -					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> > +			loff_t foffset = offset, fend;
> >  
> > -			end = iomap_fill_dirty_folios(iter, offset, len);
> > +			fend = offset +
> > +			       min(count, XFS_FSB_TO_B(mp, imap.br_blockcount));
> > +			iomap_flags |= iomap_fill_dirty_folios(iter, &foffset,
> > +							       fend);
> >  			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> > -					XFS_B_TO_FSB(mp, end));
> > +					XFS_B_TO_FSB(mp, foffset));
> >  		}
> >  
> >  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index cd0f573156d6..79da917ff45e 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -87,6 +87,9 @@ struct vm_fault;
> >  /*
> >   * Flags set by the core iomap code during operations:
> >   *
> > + * IOMAP_F_FOLIO_BATCH indicates that the folio batch mechanism is active
> > + * for this operation, set by iomap_fill_dirty_folios().
> > + *
> >   * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
> >   * has changed as the result of this write operation.
> >   *
> > @@ -94,6 +97,7 @@ struct vm_fault;
> >   * range it covers needs to be remapped by the high level before the operation
> >   * can proceed.
> >   */
> > +#define IOMAP_F_FOLIO_BATCH	(1U << 13)
> >  #define IOMAP_F_SIZE_CHANGED	(1U << 14)
> >  #define IOMAP_F_STALE		(1U << 15)
> >  
> > @@ -351,8 +355,8 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
> >  int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> >  		const struct iomap_ops *ops,
> >  		const struct iomap_write_ops *write_ops);
> > -loff_t iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t offset,
> > -		loff_t length);
> > +unsigned int iomap_fill_dirty_folios(struct iomap_iter *iter, loff_t *start,
> > +		loff_t end);
> >  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
> >  		bool *did_zero, const struct iomap_ops *ops,
> >  		const struct iomap_write_ops *write_ops, void *private);
> > -- 
> > 2.51.0
> > 
> > 
> 


