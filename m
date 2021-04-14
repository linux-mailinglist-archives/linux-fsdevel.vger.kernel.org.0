Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6457C35F396
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350851AbhDNMXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 08:23:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:50124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhDNMXl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:23:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E8ACABE2;
        Wed, 14 Apr 2021 12:23:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 25A9D1F2B5F; Wed, 14 Apr 2021 14:23:19 +0200 (CEST)
Date:   Wed, 14 Apr 2021 14:23:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210414122319.GD31323@quack2.suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
 <20210414000113.GG63242@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414000113.GG63242@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 14-04-21 10:01:13, Dave Chinner wrote:
> On Tue, Apr 13, 2021 at 01:28:46PM +0200, Jan Kara wrote:
> >   *
> >   *  ->mmap_lock
> >   *    ->i_mmap_rwsem
> > @@ -85,7 +86,8 @@
> >   *        ->i_pages lock	(arch-dependent flush_dcache_mmap_lock)
> >   *
> >   *  ->mmap_lock
> > - *    ->lock_page		(access_process_vm)
> > + *    ->i_mapping_sem		(filemap_fault)
> > + *      ->lock_page		(filemap_fault, access_process_vm)
> >   *
> >   *  ->i_rwsem			(generic_perform_write)
> >   *    ->mmap_lock		(fault_in_pages_readable->do_page_fault)
> > @@ -2276,16 +2278,28 @@ static int filemap_update_page(struct kiocb *iocb,
> >  {
> >  	int error;
> >  
> > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > +		if (!down_read_trylock(&mapping->host->i_mapping_sem))
> > +			return -EAGAIN;
> > +	} else {
> > +		down_read(&mapping->host->i_mapping_sem);
> > +	}
> 
> We really need a lock primitive for this. The number of times this
> exact lock pattern is being replicated all through the IO path is
> getting out of hand.
> 
> static inline bool
> down_read_try_or_lock(struct rwsem *sem, bool try)
> {
> 	if (try) {
> 		if (!down_read_trylock(sem))
> 			return false;
> 	} else {
> 		down_read(&mapping->host->i_mapping_sem);
> 	}
> 	return true;
> }
> 
> and the callers become:
> 
> 	if (!down_read_try_or_lock(sem, (iocb->ki_flags & IOCB_NOWAIT)))
> 		return -EAGAIN;
> 
> We can do the same with mutex_try_or_lock(), down_try_or_lock(), etc
> and we don't need to rely on cargo cult knowledge to propagate this
> pattern anymore. Because I'm betting relatively few people actually
> know why the code is written this way because the only place it is
> documented is in an XFS commit message....
> 
> Doing this is a separate cleanup, though, and not something that
> needs to be done in this patchset.

Yep, good idea but let's do it in a separate patch set.

> > index c5b0457415be..ac5bb50b3a4c 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -192,6 +192,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> >  	 */
> >  	unsigned int nofs = memalloc_nofs_save();
> >  
> > +	down_read(&mapping->host->i_mapping_sem);
> >  	/*
> >  	 * Preallocate as many pages as we will need.
> >  	 */
> 
> I can't say I'm a great fan of having the mapping reach back up to
> the host to lock the host. THis seems the wrong way around to me
> given that most of the locking in the IO path is in "host locks
> mapping" and "mapping locks internal mapping structures" order...
> 
> I also come back to the naming confusion here, in that when we look
> at this in long hand from the inode perspective, this chain actually
> looks like:
> 
> 	lock(inode->i_mapping->inode->i_mapping_sem)
> 
> i.e. the mapping is reaching back up outside it's scope to lock
> itself against other inode->i_mapping operations. Smells of layering
> violations to me.
> 
> So, next question: should this truncate semanphore actually be part
> of the address space, not the inode? This patch is actually moving
> the page fault serialisation from the inode into the address space
> operations when page faults and page cache operations are done, so
> maybe the lock should also make that move? That would help clear up
> the naming problem, because now we can name it based around what it
> serialises in the address space, not the address space as a whole...

I think that moving the lock to address_space makes some sence although the
lock actually protects consistency of inode->i_mapping->i_pages with
whatever the filesystem has in its file_offset->disk_block mapping
structures (which are generally associated with the inode). So it is not
only about inode->i_mapping contents but I agree that struct address_space
is probably a bit more logical place than struct inode.

Regarding the name: How about i_pages_rwsem? The lock is protecting
invalidation of mapping->i_pages and needs to be held until insertion of
pages into i_pages is safe again...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
