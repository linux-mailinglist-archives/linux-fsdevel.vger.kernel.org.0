Return-Path: <linux-fsdevel+bounces-54999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20C0B0641E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7523A49CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06F2459F7;
	Tue, 15 Jul 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pzxj/D6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185884A3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596203; cv=none; b=a9btDhV0wQu+OfD+trffJBNY7rxHWWse2Qez692o6z8svbrciyI2ATrBweD0s8c8F0Rs/FULTYKTPgnflo/1X1DYkVdfGJ6Qv26pXAoNzLPVOW03j58zbej7UDuSVhT7O5iYwqZ8gAC+Pgej79HX/bW/CjTeeLjHCZo5Lbi7nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596203; c=relaxed/simple;
	bh=8cXGOXH0NmsGA9LMeMB3nYmE7IQt/S/JV4bLliS9PAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX6h0WKQd0GYlVM4yrsLv5QYQbgS1cWi1qYSQeIqN4DeetHp7JHWX40A2BQLR7sB+h3Rq/A9D8Cc4KEVQWdXRDQjNSfrc/X/5MQnE0ePOFc+1zccQV7U1SiizYNAqF/bEs4yxip8jc04O8g5BAW0T6rqeh2OboRk9myC6G4cums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pzxj/D6e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752596200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjzkI9qth/2TE7efHICxEZZlRM5MU26dY9ECAyolYoQ=;
	b=Pzxj/D6eKbTJZELtHpjct6tFYitoPLm3WZ1ufjQuiiiTmSQaDoxPxIMa0IZlpt1cRJOEGB
	ecSk2VP30+jeuhjn6mv6MFA1tuEQu+rUKc0CWFGGmrAhD3TOYrihV2pJD0yt6Gk5FRxOdd
	h8BzHPolRqVS3trwsYx/rrbfvETaDmo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-ZjihElmHNuubUzssVe7u3A-1; Tue,
 15 Jul 2025 12:16:36 -0400
X-MC-Unique: ZjihElmHNuubUzssVe7u3A-1
X-Mimecast-MFC-AGG-ID: ZjihElmHNuubUzssVe7u3A_1752596195
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DCDD19560B7;
	Tue, 15 Jul 2025 16:16:35 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34259180035C;
	Tue, 15 Jul 2025 16:16:33 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:20:14 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 6/7] iomap: remove old partial eof zeroing optimization
Message-ID: <aHZ_vnMnph_4zg_o@bfoster>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-7-bfoster@redhat.com>
 <20250715053417.GR2672049@frogsfrogsfrogs>
 <aHZLZid5gggmDD09@bfoster>
 <20250715143733.GO2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715143733.GO2672029@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jul 15, 2025 at 07:37:33AM -0700, Darrick J. Wong wrote:
> On Tue, Jul 15, 2025 at 08:36:54AM -0400, Brian Foster wrote:
> > On Mon, Jul 14, 2025 at 10:34:17PM -0700, Darrick J. Wong wrote:
> > > On Mon, Jul 14, 2025 at 04:41:21PM -0400, Brian Foster wrote:
> > > > iomap_zero_range() optimizes the partial eof block zeroing use case
> > > > by force zeroing if the mapping is dirty. This is to avoid frequent
> > > > flushing on file extending workloads, which hurts performance.
> > > > 
> > > > Now that the folio batch mechanism provides a more generic solution
> > > > and is used by the only real zero range user (XFS), this isolated
> > > > optimization is no longer needed. Remove the unnecessary code and
> > > > let callers use the folio batch or fall back to flushing by default.
> > > > 
> > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > 
> > > Heh, I was staring at this last Friday chasing fuse+iomap bugs in
> > > fallocate zerorange and straining to remember what this does.
> > > Is this chunk still needed if the ->iomap_begin implementation doesn't
> > > (or forgets to) grab the folio batch for iomap?
> > > 
> > 
> > No, the hunk removed by this patch is just an optimization. The fallback
> > code here flushes the range if it's dirty and retries the lookup (i.e.
> > picking up unwritten conversions that were pending via dirty pagecache).
> > That flush logic caused a performance regression in a particular
> > workload, so this was introduced to mitigate that regression by just
> > doing the zeroing for the first block or so if the folio is dirty. [1]
> > 
> > The reason for removing it is more just for maintainability. XFS is
> > really the only user here and it is changing over to the more generic
> > batch mechanism, which effectively provides the same optimization, so
> > this basically becomes dead/duplicate code. If an fs doesn't use the
> > batch mechanism it will just fall back to the flush and retry approach,
> > which can be slower but is functionally correct.
> 
> Oh ok thanks for the reminder.
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> > > My bug turned out to be a bug in my fuse+iomap design -- with the way
> > > iomap_zero_range does things, you have to flush+unmap, punch the range
> > > and zero the range.  If you punch and realloc the range and *then* try
> > > to zero the range, the new unwritten extents cause iomap to miss dirty
> > > pages that fuse should've unmapped.  Ooops.
> > > 
> > 
> > I don't quite follow. How do you mean it misses dirty pages?
> 
> Oops, I misspoke, the folios were clean.  Let's say the pagecache is
> sparsely populated with some folios for written space:
> 
> -------fffff-------fffffff
> wwwwwwwwwwwwwwwwwwwwwwwwww
> 
> Now you tell it to go zero range the middle.  fuse's fallocate code
> issues the upcall to userspace, whch changes some mappings:
> 
> -------fffff-------fffffff
> wwwwwuuuuuuuuuuuwwwwwwwwww
> 
> Only after the upcall returns does the kernel try to do the pagecache
> zeroing.  Unfortunately, the mapping changed to unwritten so
> iomap_zero_range doesn't see the "fffff" and leaves its contents intact.
> 

Ah, interesting. So presumably the fuse fs is not doing any cache
managment, and this creates an unexpected inconsistency between
pagecache and block state.

So what's the solution to this for fuse+iomap? Invalidate the cache
range before or after the callback or something?

Brian

> (Note: Non-iomap fuse defers everything to the fuse server so this isn't
> a problem if the fuse server does all the zeroing itself.)
> 
> --D
> 
> > Brian
> > 
> > [1] Details described in the commit log of fde4c4c3ec1c ("iomap: elide
> > flush from partial eof zero range").
> > 
> > > --D
> > > 
> > > > ---
> > > >  fs/iomap/buffered-io.c | 24 ------------------------
> > > >  1 file changed, 24 deletions(-)
> > > > 
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index 194e3cc0857f..d2bbed692c06 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -1484,33 +1484,9 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> > > >  		.private	= private,
> > > >  	};
> > > >  	struct address_space *mapping = inode->i_mapping;
> > > > -	unsigned int blocksize = i_blocksize(inode);
> > > > -	unsigned int off = pos & (blocksize - 1);
> > > > -	loff_t plen = min_t(loff_t, len, blocksize - off);
> > > >  	int ret;
> > > >  	bool range_dirty;
> > > >  
> > > > -	/*
> > > > -	 * Zero range can skip mappings that are zero on disk so long as
> > > > -	 * pagecache is clean. If pagecache was dirty prior to zero range, the
> > > > -	 * mapping converts on writeback completion and so must be zeroed.
> > > > -	 *
> > > > -	 * The simplest way to deal with this across a range is to flush
> > > > -	 * pagecache and process the updated mappings. To avoid excessive
> > > > -	 * flushing on partial eof zeroing, special case it to zero the
> > > > -	 * unaligned start portion if already dirty in pagecache.
> > > > -	 */
> > > > -	if (!iter.fbatch && off &&
> > > > -	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
> > > > -		iter.len = plen;
> > > > -		while ((ret = iomap_iter(&iter, ops)) > 0)
> > > > -			iter.status = iomap_zero_iter(&iter, did_zero);
> > > > -
> > > > -		iter.len = len - (iter.pos - pos);
> > > > -		if (ret || !iter.len)
> > > > -			return ret;
> > > > -	}
> > > > -
> > > >  	/*
> > > >  	 * To avoid an unconditional flush, check pagecache state and only flush
> > > >  	 * if dirty and the fs returns a mapping that might convert on
> > > > -- 
> > > > 2.50.0
> > > > 
> > > > 
> > > 
> > 
> > 
> 


