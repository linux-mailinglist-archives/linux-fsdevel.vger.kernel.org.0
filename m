Return-Path: <linux-fsdevel+bounces-40981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86738A29B1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12420163F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DBF212B3E;
	Wed,  5 Feb 2025 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTnK0sBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2120CCF4
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787038; cv=none; b=niMc5+E1KRWNfLSMCyrP8nnbwizx3RXLDqZRoryCxV51aptSbgH4ZSF+6f4g/gC1D/578q1BbWkp8v7n/GSXqo+AN12dk6MA9Tq2YpYYImmFdSRYyKFEBJ2zqGkAF5+7OxopLxPSAtqw3/YrK+ei5+DxUe8kvJvHnXgMMQpoKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787038; c=relaxed/simple;
	bh=tHkUhIPhE3VeHoXxBvQZsaaBg3RXB43QfetKq3ISqZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnDCBgioldQzHHdgEGovfbNPvwa/CvVhNWdTuOe+qguRMdO0c8sr/slXU7CNLpepAbdDLnhblvrcawnv/+6929aca5807+IhtDpu/ARQiYOuLAHShUv3Z9tuvtQO+f8+UDQgG3NHyuZAHrot2VMRwy94W0m+iDQO9eGUhwYHqhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTnK0sBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738787035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KMsDWoYNJ51FU3ENt2+m2uMzfE5oWYP336jqZ2X6VjY=;
	b=cTnK0sBuhTeQYCLvHXwbZdQEmNlOfdkw7lForNAcZ62/2ljBTve+ld9Bsu2+ouA26FlhB+
	copKXkzs3Ju3qc3R5F+6S6hvQZ01SBMkrBIaeg+fuJ4EELZJOD5iSOMp4lLPahemr91xO2
	U+Eb0VQtTBKDksfuc/PsahNf0Ned3wo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-4Fm7eMmmPW6uaX4VAMIvPg-1; Wed,
 05 Feb 2025 15:23:52 -0500
X-MC-Unique: 4Fm7eMmmPW6uaX4VAMIvPg-1
X-Mimecast-MFC-AGG-ID: 4Fm7eMmmPW6uaX4VAMIvPg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63F5B1956086;
	Wed,  5 Feb 2025 20:23:51 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E2691800267;
	Wed,  5 Feb 2025 20:23:50 +0000 (UTC)
Date: Wed, 5 Feb 2025 15:26:12 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 07/10] iomap: support incremental iomap_iter advances
Message-ID: <Z6PJZDMzWNtE2Qrq@bfoster>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-8-bfoster@redhat.com>
 <20250205191016.GQ21808@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205191016.GQ21808@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Feb 05, 2025 at 11:10:16AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 05, 2025 at 08:58:18AM -0500, Brian Foster wrote:
> > The current iomap_iter iteration model reads the mapping from the
> > filesystem, processes the subrange of the operation associated with
> > the current mapping, and returns the number of bytes processed back
> > to the iteration code. The latter advances the position and
> > remaining length of the iter in preparation for the next iteration.
> > 
> > At the _iter() handler level, this tends to produce a processing
> > loop where the local code pulls the current position and remaining
> > length out of the iter, iterates it locally based on file offset,
> > and then breaks out when the associated range has been fully
> > processed.
> > 
> > This works well enough for current handlers, but upcoming
> > enhancements require a bit more flexibility in certain situations.
> > Enhancements for zero range will lead to a situation where the
> > processing loop is no longer a pure ascending offset walk, but
> > rather dictated by pagecache state and folio lookup. Since folio
> > lookup and write preparation occur at different levels, it is more
> > difficult to manage position and length outside of the iter.
> > 
> > To provide more flexibility to certain iomap operations, introduce
> > support for incremental iomap_iter advances from within the
> > operation itself. This allows more granular advances for operations
> > that might not use the typical file offset based walk.
> > 
> > Note that the semantics for operations that use incremental advances
> > is slightly different than traditional operations. Operations that
> > advance the iter directly are expected to return success or failure
> > (i.e. 0 or negative error code) in iter.processed rather than the
> > number of bytes processed.
> 
> I think this needs to be documented in the code comments for @processed
> in iomap.h:
> 
>   * @processed: The iteration loop body should set this to a negative
>   *     errno if an error occurs during processing; zero if it advanced
>   *     the iter itself with iomap_iter_advance; or the number of bytes
>   *     processed if it needs iomap_iter to advance the iter.
> 

Note that this would be shortlived content re: my previous comments on
the advance going away, but sure I can change it.

Brian

> --D
> 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/iter.c       | 32 +++++++++++++++++++++++++-------
> >  include/linux/iomap.h |  3 +++
> >  2 files changed, 28 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> > index cdba24dbbfd7..9273ef36d5ae 100644
> > --- a/fs/iomap/iter.c
> > +++ b/fs/iomap/iter.c
> > @@ -35,6 +35,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
> >  	WARN_ON_ONCE(iter->iomap.offset + iter->iomap.length <= iter->pos);
> >  	WARN_ON_ONCE(iter->iomap.flags & IOMAP_F_STALE);
> >  
> > +	iter->iter_start_pos = iter->pos;
> > +
> >  	trace_iomap_iter_dstmap(iter->inode, &iter->iomap);
> >  	if (iter->srcmap.type != IOMAP_HOLE)
> >  		trace_iomap_iter_srcmap(iter->inode, &iter->srcmap);
> > @@ -58,6 +60,8 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
> >  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  {
> >  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
> > +	ssize_t advanced = iter->processed > 0 ? iter->processed : 0;
> > +	u64 olen = iter->len;
> >  	s64 processed;
> >  	int ret;
> >  
> > @@ -66,11 +70,22 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  	if (!iter->iomap.length)
> >  		goto begin;
> >  
> > +	/*
> > +	 * If iter.processed is zero, the op may still have advanced the iter
> > +	 * itself. Calculate the advanced and original length bytes based on how
> > +	 * far pos has advanced for ->iomap_end().
> > +	 */
> > +	if (!advanced) {
> > +		advanced = iter->pos - iter->iter_start_pos;
> > +		olen += advanced;
> > +	}
> > +
> >  	if (ops->iomap_end) {
> > -		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
> > -				iter->processed > 0 ? iter->processed : 0,
> > -				iter->flags, &iter->iomap);
> > -		if (ret < 0 && !iter->processed)
> > +		ret = ops->iomap_end(iter->inode, iter->iter_start_pos,
> > +				iomap_length_trim(iter, iter->iter_start_pos,
> > +						  olen),
> > +				advanced, iter->flags, &iter->iomap);
> > +		if (ret < 0 && !advanced)
> >  			return ret;
> >  	}
> >  
> > @@ -81,8 +96,11 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  	}
> >  
> >  	/*
> > -	 * Advance the iter and clear state from the previous iteration. Use
> > -	 * iter->len to determine whether to continue onto the next mapping.
> > +	 * Advance the iter and clear state from the previous iteration. This
> > +	 * passes iter->processed because that reflects the bytes processed but
> > +	 * not yet advanced by the iter handler.
> > +	 *
> > +	 * Use iter->len to determine whether to continue onto the next mapping.
> >  	 * Explicitly terminate in the case where the current iter has not
> >  	 * advanced at all (i.e. no work was done for some reason) unless the
> >  	 * mapping has been marked stale and needs to be reprocessed.
> > @@ -90,7 +108,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
> >  	ret = iomap_iter_advance(iter, &processed);
> >  	if (!ret && iter->len > 0)
> >  		ret = 1;
> > -	if (ret > 0 && !iter->processed && !stale)
> > +	if (ret > 0 && !advanced && !stale)
> >  		ret = 0;
> >  	iomap_iter_reset_iomap(iter);
> >  	if (ret <= 0)
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index f304c602e5fe..0135a7f8dd83 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -211,6 +211,8 @@ struct iomap_ops {
> >   *	calls to iomap_iter().  Treat as read-only in the body.
> >   * @len: The remaining length of the file segment we're operating on.
> >   *	It is updated at the same time as @pos.
> > + * @iter_start_pos: The original start pos for the current iomap. Used for
> > + *	incremental iter advance.
> >   * @processed: The number of bytes processed by the body in the most recent
> >   *	iteration, or a negative errno. 0 causes the iteration to stop.
> >   * @flags: Zero or more of the iomap_begin flags above.
> > @@ -221,6 +223,7 @@ struct iomap_iter {
> >  	struct inode *inode;
> >  	loff_t pos;
> >  	u64 len;
> > +	loff_t iter_start_pos;
> >  	s64 processed;
> >  	unsigned flags;
> >  	struct iomap iomap;
> > -- 
> > 2.48.1
> > 
> > 
> 


