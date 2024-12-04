Return-Path: <linux-fsdevel+bounces-36401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A19E361C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 10:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205AE280F24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F218BC19;
	Wed,  4 Dec 2024 09:03:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04118C031;
	Wed,  4 Dec 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302994; cv=none; b=hTPaTm24nWzLG7AaO0shH4QdskFrPAbmMYwI5cbY0gQBLuD+SPjHRxO3x5wYkX349CK0ccYCLzm5LiVQLQB6dyzYvvNGb9vOA81KApVvDbCzScx1y5xxZK5Wt4CMh97kfnCBAHsb8r4oRJHoBgroAvN/ujF4eseTYEn/+MNHGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302994; c=relaxed/simple;
	bh=HROzeJLETPZ4gwq0lfGcgHnaTNlPktp8ocg7HqEdJ7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyk7Y9+VHCYr3or4VXuwPMoW0tM1QSTVgvD4DP9H3HfEI2Upd9DuQPkp29MYA2wTxZeFMMaLH+iQSHKNVXegwz5cxo1OPwpxRLvCvWI5xO6iTbyvjb/0y40pcjZhh/XhYEhfpGqB2Vg4yNU9EYUR+dXRKmt+/8MMV9oj9LqfWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Y3BMt69LpzRhrv;
	Wed,  4 Dec 2024 17:01:30 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E413140134;
	Wed,  4 Dec 2024 17:03:08 +0800 (CST)
Received: from localhost (10.175.112.188) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 17:03:08 +0800
Date: Wed, 4 Dec 2024 17:00:44 +0800
From: Long Li <leo.lilong@huawei.com>
To: Dave Chinner <david@fromorbit.com>, Brian Foster <bfoster@redhat.com>
CC: <brauner@kernel.org>, <djwong@kernel.org>, <cem@kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z1AaPNoN_z5EQxFQ@localhost.localdomain>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
 <Z03RlpfdJgsJ_glO@bfoster>
 <Z05oJqT7983ifKqv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <Z05oJqT7983ifKqv@dread.disaster.area>
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Tue, Dec 03, 2024 at 01:08:38PM +1100, Dave Chinner wrote:
> On Mon, Dec 02, 2024 at 10:26:14AM -0500, Brian Foster wrote:
> > On Sat, Nov 30, 2024 at 09:39:29PM +0800, Long Li wrote:
> > > When performing fsstress test with this patch set, there is a very low probability of
> > > encountering an issue where isize is less than ioend->io_offset in iomap_add_to_ioend.
> > > After investigation, this was found to be caused by concurrent with truncate operations.
> > > Consider a scenario with 4K block size and a file size of 12K.
> > > 
> > > //write back [8K, 12K]           //truncate file to 4K
> > > ----------------------          ----------------------
> > > iomap_writepage_map             xfs_setattr_size
> 
> folio is locked here
> 
> > >   iomap_writepage_handle_eof
> > >                                   truncate_setsize
> > > 				    i_size_write(inode, newsize)  //update inode size to 4K
> 
> truncate_setsize() is supposed to invalidate whole pages beyond
> EOF before completing, yes?
> 
> /**
>  * truncate_setsize - update inode and pagecache for a new file size
>  * @inode: inode
>  * @newsize: new file size
>  *
>  * truncate_setsize updates i_size and performs pagecache truncation (if
>  * necessary) to @newsize. It will be typically be called from the filesystem's
>  * setattr function when ATTR_SIZE is passed in.
>  *
>  * Must be called with a lock serializing truncates and writes (generally
>  * i_rwsem but e.g. xfs uses a different lock) and before all filesystem
>  * specific block truncation has been performed.
>  */
> void truncate_setsize(struct inode *inode, loff_t newsize)
> {
>         loff_t oldsize = inode->i_size;
> 
>         i_size_write(inode, newsize);
>         if (newsize > oldsize)
>                 pagecache_isize_extended(inode, oldsize, newsize);
>         truncate_pagecache(inode, newsize);
> }
> EXPORT_SYMBOL(truncate_setsize);
> 
> Note that this says "serialising truncates and writes" - the
> emphasis needs to be placed on "writes" here, not "writeback". The
> comment about XFS is also stale - it uses the i_rwsem here like
> all other filesystems now.
> 
> The issue demonstrated above is -write back- racing against
> truncate_setsize(), not writes. And -write back- is only serialised
> against truncate_pagecache() by folio locks and state, not inode
> locks. hence any change to the inode size in truncate can and will
> race with writeback in progress.
> 
> Hence writeback needs to be able to handle folios end up beyond
> EOF at any time during writeback. i.e. once we have a folio locked
> in writeback and we've checked against i_size_read() for validity,
> it needs to be considered a valid offset all the way through to
> IO completion.
> 
> 
> > >   iomap_writepage_map_blocks
> > >     iomap_add_to_ioend
> > >            < iszie < ioend->io_offset>
> > > 	   <iszie = 4K,  ioend->io_offset=8K>
> 
> Ah, so the bug fix adds a new call to i_size_read() in the IO
> submission path? I suspect that is the underlying problem leading
> to the observed behaviour....
> 
> > > 
> > > It appears that in extreme cases, folios beyond EOF might be written back,
> > > resulting in situations where isize is less than pos. In such cases,
> > > maybe we should not trim the io_size further.
> > > 
> > 
> > Hmm.. it might be wise to characterize this further to determine whether
> > there are potentially larger problems to address before committing to
> > anything. For example, assuming truncate acquires ilock and does
> > xfs_itruncate_extents() and whatnot before this ioend submits/completes,
> 
> I don't think xfs_itruncate_extents() is the concern here - that
> happens after the page cache and writeback has been sorted out and
> the ILOCK has been taken and the page cache state should
> have already been sorted out. truncate_setsize() does that for us;
> it guarantees that all writeback in the truncate down range has
> been completed and the page cache invalidated.
> 
> We hold the MMAP_LOCK (filemap_invalidate_lock()) so no new pages
> can be instantiated over the range whilst we are running
> xfs_itruncate_extents(). hence once truncate_setsize() returns, we
> are guaranteed that there will be no IO in progress or can be
> started over the range we are removing.
> 
> Really, the issue is that writeback mappings have to be able to
> handle the range being mapped suddenly appear to be beyond EOF.
> This behaviour is a longstanding writeback constraint, and is what
> iomap_writepage_handle_eof() is attempting to handle.
> 
> We handle this by only sampling i_size_read() whilst we have the
> folio locked and can determine the action we should take with that
> folio (i.e. nothing, partial zeroing, or skip altogether). Once
> we've made the decision that the folio is within EOF and taken
> action on it (i.e. moved the folio to writeback state), we cannot
> then resample the inode size because a truncate may have started
> and changed the inode size.
> 

My understanding is the issue isn't that we can't sample the inode size. 
The key point is that writeback mapping must be able to handle cases where
the mapped range suddenly appears beyond EOF. If we can handle such
cases properly, wouldn't sampling still be possible?

Coming back to our current issue, during writeback mapping, we sample
the inode size to determine if the ioend is within EOF and attempt to
trim io_size. Concurrent truncate operations may update the inode size,
causing the pos of write back beyond EOF. In such cases, we simply don't
trim io_size, which seems like a viable approach.

Thanks,
Long Li

