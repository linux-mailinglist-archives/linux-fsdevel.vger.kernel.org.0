Return-Path: <linux-fsdevel+bounces-36432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C39E39AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B662A161065
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257871B415A;
	Wed,  4 Dec 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNUYGaEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31611B3944
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314577; cv=none; b=FJS7pjWBRJo9t1L0XXwH6yX8kac23utsAq7HLeVE8fsZMbRKhLiog5dnCTMUCM6ldwLc8/mtPtfPsg3Py/mloHHgV6sVYfNiVVPOo+d7gsDDwEhepskBLepGVLPl8b0L4j0uPIfl+DoC2b9nLuRsf7Fi4X5K8lCJkc1ZfWc9a1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314577; c=relaxed/simple;
	bh=yH2lc1vOe1dJ+S33MXmQsrWY+8omxVkp+Y6IgmuTGDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN+3QrDk2xDIrco5N303HjAcDov6OzE8U3Q/Y4otzf0ou2DHtyMbNGYBbqKbyz+L3PuiUm9W7zbIPgSYoDHtq0bc5hQEnWaswjS3NU7Mh8aRkc33NMxltHrHxQCZeUvyghw6nve23OE4jKLVS4swq3HGWN73YyyokAbGs8CtwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNUYGaEv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JG4ZxK8EE+KOPLX0iJwVt0KTiBtaXP/QySllgx3ZpBc=;
	b=WNUYGaEv3eh7VMXKMzPCQjeSA7EFNo6UWAahCNJR69Thcpf3byuwTsz7SHxjrt4mExiwe/
	zICw0HrbtteD68WCRQ/mtwEHs3+dg/j5XV+m3YLoPN4R8s1C0/dV+onKxUAXXNU86ITfpt
	mpFhM9RH4OVIAXsSooB9E7CjJQSanDQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-b9tGxvbgMY-ms-LQwysJlA-1; Wed,
 04 Dec 2024 07:16:03 -0500
X-MC-Unique: b9tGxvbgMY-ms-LQwysJlA-1
X-Mimecast-MFC-AGG-ID: b9tGxvbgMY-ms-LQwysJlA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CB7B1955F39;
	Wed,  4 Dec 2024 12:16:02 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCC391956048;
	Wed,  4 Dec 2024 12:15:59 +0000 (UTC)
Date: Wed, 4 Dec 2024 07:17:45 -0500
From: Brian Foster <bfoster@redhat.com>
To: Long Li <leo.lilong@huawei.com>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z1BIab8G3KmXuyfS@bfoster>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
 <Z03RlpfdJgsJ_glO@bfoster>
 <Z05oJqT7983ifKqv@dread.disaster.area>
 <Z1AaPNoN_z5EQxFQ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1AaPNoN_z5EQxFQ@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 04, 2024 at 05:00:44PM +0800, Long Li wrote:
> On Tue, Dec 03, 2024 at 01:08:38PM +1100, Dave Chinner wrote:
> > On Mon, Dec 02, 2024 at 10:26:14AM -0500, Brian Foster wrote:
> > > On Sat, Nov 30, 2024 at 09:39:29PM +0800, Long Li wrote:
> > > > When performing fsstress test with this patch set, there is a very low probability of
> > > > encountering an issue where isize is less than ioend->io_offset in iomap_add_to_ioend.
> > > > After investigation, this was found to be caused by concurrent with truncate operations.
> > > > Consider a scenario with 4K block size and a file size of 12K.
> > > > 
> > > > //write back [8K, 12K]           //truncate file to 4K
> > > > ----------------------          ----------------------
> > > > iomap_writepage_map             xfs_setattr_size
> > 
> > folio is locked here
> > 
> > > >   iomap_writepage_handle_eof
> > > >                                   truncate_setsize
> > > > 				    i_size_write(inode, newsize)  //update inode size to 4K
> > 
> > truncate_setsize() is supposed to invalidate whole pages beyond
> > EOF before completing, yes?
> > 
> > /**
> >  * truncate_setsize - update inode and pagecache for a new file size
> >  * @inode: inode
> >  * @newsize: new file size
> >  *
> >  * truncate_setsize updates i_size and performs pagecache truncation (if
> >  * necessary) to @newsize. It will be typically be called from the filesystem's
> >  * setattr function when ATTR_SIZE is passed in.
> >  *
> >  * Must be called with a lock serializing truncates and writes (generally
> >  * i_rwsem but e.g. xfs uses a different lock) and before all filesystem
> >  * specific block truncation has been performed.
> >  */
> > void truncate_setsize(struct inode *inode, loff_t newsize)
> > {
> >         loff_t oldsize = inode->i_size;
> > 
> >         i_size_write(inode, newsize);
> >         if (newsize > oldsize)
> >                 pagecache_isize_extended(inode, oldsize, newsize);
> >         truncate_pagecache(inode, newsize);
> > }
> > EXPORT_SYMBOL(truncate_setsize);
> > 
> > Note that this says "serialising truncates and writes" - the
> > emphasis needs to be placed on "writes" here, not "writeback". The
> > comment about XFS is also stale - it uses the i_rwsem here like
> > all other filesystems now.
> > 
> > The issue demonstrated above is -write back- racing against
> > truncate_setsize(), not writes. And -write back- is only serialised
> > against truncate_pagecache() by folio locks and state, not inode
> > locks. hence any change to the inode size in truncate can and will
> > race with writeback in progress.
> > 
> > Hence writeback needs to be able to handle folios end up beyond
> > EOF at any time during writeback. i.e. once we have a folio locked
> > in writeback and we've checked against i_size_read() for validity,
> > it needs to be considered a valid offset all the way through to
> > IO completion.
> > 
> > 
> > > >   iomap_writepage_map_blocks
> > > >     iomap_add_to_ioend
> > > >            < iszie < ioend->io_offset>
> > > > 	   <iszie = 4K,  ioend->io_offset=8K>
> > 
> > Ah, so the bug fix adds a new call to i_size_read() in the IO
> > submission path? I suspect that is the underlying problem leading
> > to the observed behaviour....
> > 
> > > > 
> > > > It appears that in extreme cases, folios beyond EOF might be written back,
> > > > resulting in situations where isize is less than pos. In such cases,
> > > > maybe we should not trim the io_size further.
> > > > 
> > > 
> > > Hmm.. it might be wise to characterize this further to determine whether
> > > there are potentially larger problems to address before committing to
> > > anything. For example, assuming truncate acquires ilock and does
> > > xfs_itruncate_extents() and whatnot before this ioend submits/completes,
> > 
> > I don't think xfs_itruncate_extents() is the concern here - that
> > happens after the page cache and writeback has been sorted out and
> > the ILOCK has been taken and the page cache state should
> > have already been sorted out. truncate_setsize() does that for us;
> > it guarantees that all writeback in the truncate down range has
> > been completed and the page cache invalidated.
> > 
> > We hold the MMAP_LOCK (filemap_invalidate_lock()) so no new pages
> > can be instantiated over the range whilst we are running
> > xfs_itruncate_extents(). hence once truncate_setsize() returns, we
> > are guaranteed that there will be no IO in progress or can be
> > started over the range we are removing.
> > 
> > Really, the issue is that writeback mappings have to be able to
> > handle the range being mapped suddenly appear to be beyond EOF.
> > This behaviour is a longstanding writeback constraint, and is what
> > iomap_writepage_handle_eof() is attempting to handle.
> > 
> > We handle this by only sampling i_size_read() whilst we have the
> > folio locked and can determine the action we should take with that
> > folio (i.e. nothing, partial zeroing, or skip altogether). Once
> > we've made the decision that the folio is within EOF and taken
> > action on it (i.e. moved the folio to writeback state), we cannot
> > then resample the inode size because a truncate may have started
> > and changed the inode size.
> > 
> 
> My understanding is the issue isn't that we can't sample the inode size. 
> The key point is that writeback mapping must be able to handle cases where
> the mapped range suddenly appears beyond EOF. If we can handle such
> cases properly, wouldn't sampling still be possible?
> 

I think so. I wouldn't harp too much on this as I think we're tripping
over words. ISTM the critical thing is that the folio is handled
properly wrt the truncate operation, which should be facilitated by the
folio lock.

> Coming back to our current issue, during writeback mapping, we sample
> the inode size to determine if the ioend is within EOF and attempt to
> trim io_size. Concurrent truncate operations may update the inode size,
> causing the pos of write back beyond EOF. In such cases, we simply don't
> trim io_size, which seems like a viable approach.
> 

Perhaps. I'm not claiming it isn't functional. But to Dave's (more
elaborated) point and in light of the racy i_size issue you've
uncovered, what bugs me also about this is that this creates an internal
inconsistency in the submission codepath.

I.e., the top level code does one thing based on one value of i_size,
then the ioend construction does another, and the logic is not directly
correlated so there is no real guarantee changes in one area correlate
to the other. IME, this increases potential for future bugs and adds
maintenance burden.

A simple example to consider might be.. suppose sometime in the future
we determine there is a selective case where we do want to allow a
post-eof writeback. As of right now, all that really requires is
adjustment to the "handle_eof()" logic and the rest of the codepath does
the right thing agnostic to outside operations like truncate. I think
there's value if we can preserve that invariant going forward.

FWIW, I'm not objecting to the alternative if something in the above
reasoning is wrong. I'm just trying to prioritize keeping things simple
and maintainable, particularly since truncate is kind of a complicated
beast as it is.

Brian

> Thanks,
> Long Li
> 


