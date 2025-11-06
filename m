Return-Path: <linux-fsdevel+bounces-67340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E137C3C2AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723DF1898E10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63432E130;
	Thu,  6 Nov 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs6IhAOZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73A32AADD
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444148; cv=none; b=gzrRv6JCJ8BOyfFgnYK6yzQB9uqdAAFJSUgcStVIVM992kYzgQ99gVnM9h/6x7Fqdl+jSOPqIpr/QpvJnp1uAONXQVJOesX7W7lgh9uV+IZ6Qt/kG9K3ORRSOMTkmk5xdWghf61bwhNx/0nCrE9y4wKIrZgq83mDwIwBvXhKMbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444148; c=relaxed/simple;
	bh=RsD9gD+c8mzpiCWgPcSjchRv1Gi9fsZ7DxP8IbufyhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZXC6WMGMj3DNAUwDpt2Bc1u6bB3RJ+ltVvtwX84LQfkhThHEzfyYWBfBlhC9CKTCBh2mQgzAn/gpT8qQClj7kTEH6LkD7TL6aHm3w7c5wuBDerkx6XwjPEZA4Mb290JQm7Bt6lPwDu437AMUHfIdLKTm8OkFjJnSgkqqMhCRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gs6IhAOZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762444143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVcAGRzZwHlVl2fhSAFXgvU2Ck+KPoFTTbeyJpqT2WA=;
	b=gs6IhAOZZRm8puZghF9yGUaVoDusPSem2cHnRrsIdu6zNAELSfUIo2craer7rQF5naMru5
	51UJgHvwrTjgegDEN7Wv6lu6SoN/LNMIUie1XylNqwGrvJ8lX0gBktecGZ296TJvsItstI
	X0s384akP5OF04uBwhAtKhxmVB/eejs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-JHJmxbs4MFmse2DR-awrPQ-1; Thu,
 06 Nov 2025 10:48:53 -0500
X-MC-Unique: JHJmxbs4MFmse2DR-awrPQ-1
X-Mimecast-MFC-AGG-ID: JHJmxbs4MFmse2DR-awrPQ_1762444129
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CD4B19560A2;
	Thu,  6 Nov 2025 15:48:49 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C106319560A7;
	Thu,  6 Nov 2025 15:48:48 +0000 (UTC)
Date: Thu, 6 Nov 2025 10:53:18 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: replace zero range flush with folio batch
Message-ID: <aQzEbqc3nRTWfdtB@bfoster>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-7-bfoster@redhat.com>
 <20251105223715.GI196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105223715.GI196370@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Nov 05, 2025 at 02:37:15PM -0800, Darrick J. Wong wrote:
> On Thu, Oct 16, 2025 at 03:03:03PM -0400, Brian Foster wrote:
> > Now that the zero range pagecache flush is purely isolated to
> > providing zeroing correctness in this case, we can remove it and
> > replace it with the folio batch mechanism that is used for handling
> > unwritten extents.
> > 
> > This is still slightly odd in that XFS reports a hole vs. a mapping
> > that reflects the COW fork extents, but that has always been the
> > case in this situation and so a separate issue. We drop the iomap
> > warning that assumes the folio batch is always associated with
> > unwritten mappings, but this is mainly a development assertion as
> > otherwise the core iomap fbatch code doesn't care much about the
> > mapping type if it's handed the set of folios to process.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c |  4 ----
> >  fs/xfs/xfs_iomap.c     | 16 ++++------------
> >  2 files changed, 4 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index d6de689374c3..7bc4b8d090ee 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1534,10 +1534,6 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  	while ((ret = iomap_iter(&iter, ops)) > 0) {
> >  		const struct iomap *srcmap = iomap_iter_srcmap(&iter);
> >  
> > -		if (WARN_ON_ONCE((iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
> > -				 srcmap->type != IOMAP_UNWRITTEN))
> > -			return -EIO;
> > -
> >  		if (!(iter.iomap.flags & IOMAP_F_FOLIO_BATCH) &&
> >  		    (srcmap->type == IOMAP_HOLE ||
> >  		     srcmap->type == IOMAP_UNWRITTEN)) {
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 29f1462819fa..5a845a0ded79 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1704,7 +1704,6 @@ xfs_buffered_write_iomap_begin(
> >  {
> >  	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
> >  						     iomap);
> > -	struct address_space	*mapping = inode->i_mapping;
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > @@ -1736,7 +1735,6 @@ xfs_buffered_write_iomap_begin(
> >  	if (error)
> >  		return error;
> >  
> > -restart:
> >  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> >  	if (error)
> >  		return error;
> > @@ -1812,16 +1810,10 @@ xfs_buffered_write_iomap_begin(
> >  		xfs_trim_extent(&imap, offset_fsb,
> >  			    cmap.br_startoff + cmap.br_blockcount - offset_fsb);
> >  		start = XFS_FSB_TO_B(mp, imap.br_startoff);
> > -		end = XFS_FSB_TO_B(mp,
> > -				   imap.br_startoff + imap.br_blockcount) - 1;
> > -		if (filemap_range_needs_writeback(mapping, start, end)) {
> > -			xfs_iunlock(ip, lockmode);
> > -			error = filemap_write_and_wait_range(mapping, start,
> > -							     end);
> > -			if (error)
> > -				return error;
> > -			goto restart;
> > -		}
> > +		end = XFS_FSB_TO_B(mp, imap.br_startoff + imap.br_blockcount);
> > +		iomap_flags |= iomap_fill_dirty_folios(iter, &start, end);
> > +		xfs_trim_extent(&imap, offset_fsb,
> > +				XFS_B_TO_FSB(mp, start) - offset_fsb);
> 
> Hrm, ok.  This replaces the pagecache flush with passing in folios and
> letting iomap zero the folios regardless of whatever's in the mapping.
> That seems to me like a reasonable way to solve the immediate problem
> without the huge reengineering ->iomap_begin project.
> 

Yeah.. modulo a potential clean up to have this actually report the COW
mapping which might be incrementally cleaner. I'll take a closer look at
that when I get back to this..

> The changes here mostly look ok to me, though I wonder how well this all
> meshes with all the other iomap work headed to 6.19...
> 

The batch stuff is already in -next I believe. It might be good to get
the first patch in sooner, but I don't think the rest should be too bad
provided it stays isolated to XFS and zero range.

Brian

> --D
> 
> >  
> >  		goto found_imap;
> >  	}
> > -- 
> > 2.51.0
> > 
> > 
> 


