Return-Path: <linux-fsdevel+bounces-54951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201BDB05A47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BD756057E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83C2E03E4;
	Tue, 15 Jul 2025 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK3Jh508"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6422DA77D
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582740; cv=none; b=Q0O7g4xcsslb9dDW/fFMTwd/cbOphq9A0y3hZp0wfsym0ub+q/vWUo2VYoiq7oOA3ZJHQUoUGbFmaxRO58K+tpeF9mavwMva976dzI3j0OryhaXzLHiw8zX0QC7SVDShMxYT670x8hAsBxymIzDPgPj7j4t2d1sKfVACyqdWuoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582740; c=relaxed/simple;
	bh=QhxxavKEeslk4mvgCW4mccrCCAQZPOApxboINqcRKbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqrD6IBHFFpQMaBSnS8C3MDFhmlrz3JY5HsympOabaEPQRMyq+kwji5oiuWQF1x6pfs3FO8U9jjWT/VILY2wvLtoHR5+TMebmvwGg7TTDRvlY3ZWOtUHJJGQgp3IKLYkzjJ2+Y8OvNCk+KyI/jVeLz18jQpRJI2dYr58/wSKo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aK3Jh508; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752582737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PMWLDsaxYk3mtycE5KTlBYX1K5MmGbSOcv51c5mvkh8=;
	b=aK3Jh508hYm7EGAeLyYowgaz8Awndf3xcd73XimJTDzHtTM9ezG5brsID5fLZMiOkK2+np
	Louf11UZ/Jz5H4tdk1Qlt8UC/za2AlFluqMeFIrQAF4ksAw+u9vhbayQZRffTCFuVYE3ya
	l/wyW4UFOn51gQlHHUjYegh69nYNmY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-TC3fsio2O-iujKV3UFtL8w-1; Tue,
 15 Jul 2025 08:32:12 -0400
X-MC-Unique: TC3fsio2O-iujKV3UFtL8w-1
X-Mimecast-MFC-AGG-ID: TC3fsio2O-iujKV3UFtL8w_1752582731
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 507B018001E2;
	Tue, 15 Jul 2025 12:32:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.43])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1655195609D;
	Tue, 15 Jul 2025 12:32:09 +0000 (UTC)
Date: Tue, 15 Jul 2025 08:35:51 -0400
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <aHZLJyPmZPmDtLE_@bfoster>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-6-bfoster@redhat.com>
 <20250715052811.GQ2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715052811.GQ2672049@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Jul 14, 2025 at 10:28:11PM -0700, Darrick J. Wong wrote:
> On Mon, Jul 14, 2025 at 04:41:20PM -0400, Brian Foster wrote:
> > Use the iomap folio batch mechanism to select folios to zero on zero
> > range of unwritten mappings. Trim the resulting mapping if the batch
> > is filled (unlikely for current use cases) to distinguish between a
> > range to skip and one that requires another iteration due to a full
> > batch.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index b5cf5bc6308d..63054f7ead0e 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1691,6 +1691,8 @@ xfs_buffered_write_iomap_begin(
> >  	struct iomap		*iomap,
> >  	struct iomap		*srcmap)
> >  {
> > +	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
> > +						     iomap);
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > @@ -1762,6 +1764,7 @@ xfs_buffered_write_iomap_begin(
> >  	 */
> >  	if (flags & IOMAP_ZERO) {
> >  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> > +		u64 end;
> >  
> >  		if (isnullstartblock(imap.br_startblock) &&
> >  		    offset_fsb >= eof_fsb)
> > @@ -1769,6 +1772,26 @@ xfs_buffered_write_iomap_begin(
> >  		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
> >  			end_fsb = eof_fsb;
> >  
> > +		/*
> > +		 * Look up dirty folios for unwritten mappings within EOF.
> > +		 * Providing this bypasses the flush iomap uses to trigger
> > +		 * extent conversion when unwritten mappings have dirty
> > +		 * pagecache in need of zeroing.
> > +		 *
> > +		 * Trim the mapping to the end pos of the lookup, which in turn
> > +		 * was trimmed to the end of the batch if it became full before
> > +		 * the end of the mapping.
> > +		 */
> > +		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> > +		    offset_fsb < eof_fsb) {
> > +			loff_t len = min(count,
> > +					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> > +
> > +			end = iomap_fill_dirty_folios(iter, offset, len);
> > +			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> > +					XFS_B_TO_FSB(mp, end));
> 
> Hrmm.  XFS_B_TO_FSB and not _FSBT?  Can the rounding up behavior result
> in a missed byte range?  I think the answer is no because @end should be
> aligned to a folio boundary, and folios can't be smaller than an
> fsblock.
> 

Hmm.. not that I'm aware of..? Please elaborate if there's a case you're
suspicious of because I could have certainly got my wires crossed.

My thinking is that end_fsb reflects the first fsb beyond the target
range. I.e., it's calculated and used as such in xfs_iomap_end_fsb() and
the various xfs_trim_extent() calls throughout the rest of the function.

Brian

> If the answer to the second question is indeed "no" then I think this is
> ok and
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> 
> > +		}
> > +
> >  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> >  	}
> >  
> > -- 
> > 2.50.0
> > 
> > 
> 


