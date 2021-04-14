Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0947535E9D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 02:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhDNABi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 20:01:38 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42794 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229747AbhDNABh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:01:37 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id ECEA01042B72;
        Wed, 14 Apr 2021 10:01:14 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lWSy1-006oBD-BU; Wed, 14 Apr 2021 10:01:13 +1000
Date:   Wed, 14 Apr 2021 10:01:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210414000113.GG63242@dread.disaster.area>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413112859.32249-2-jack@suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=DX6uKfG-f7m7lB0TV10A:9 a=zNJWZbXuTLNWGvKL:21 a=zPXtcYt7zDS9-pWJ:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 01:28:46PM +0200, Jan Kara wrote:
> Currently, serializing operations such as page fault, read, or readahead
> against hole punching is rather difficult. The basic race scheme is
> like:
> 
> fallocate(FALLOC_FL_PUNCH_HOLE)			read / fault / ..
>   truncate_inode_pages_range()
> 						  <create pages in page
> 						   cache here>
>   <update fs block mapping and free blocks>
> 
> Now the problem is in this way read / page fault / readahead can
> instantiate pages in page cache with potentially stale data (if blocks
> get quickly reused). Avoiding this race is not simple - page locks do
> not work because we want to make sure there are *no* pages in given
> range. inode->i_rwsem does not work because page fault happens under
> mmap_sem which ranks below inode->i_rwsem. Also using it for reads makes
> the performance for mixed read-write workloads suffer.
> 
> So create a new rw_semaphore in the inode - i_mapping_sem - that
> protects adding of pages to page cache for page faults / reads /
> readahead.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
....
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bd7c50e060a9..bc82a7856d3e 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -77,7 +77,8 @@
>   *        ->i_pages lock
>   *
>   *  ->i_rwsem
> - *    ->i_mmap_rwsem		(truncate->unmap_mapping_range)
> + *    ->i_mapping_sem		(acquired by fs in truncate path)
> + *      ->i_mmap_rwsem		(truncate->unmap_mapping_range)

This is now officially a confusing mess.

We have inode->i_mapping that points to an address space, which has
an internal i_mmap variable and an i_mmap_rwsem that serialises
access to the i_mmap tree.

Now we have a inode->i_mapping_sem (which is actually a rwsem, not a
sem) that sorta serialises additions to the mapping tree
(inode->i_mapping->i_pages) against truncate, but it does not
serialise accesses to the rest of the inode->i_mapping structure
itself despite the similarlities in naming.

Then we have the inode_lock() API and the i_mmap_lock() API that
wrap around the i_rwsem and i_mmap_rwsem, but there's no API for
inode_mapping_lock()...

THen we have the mmap_lock in the page fault path as well, which is
also an rwsem despite the name, and that protects something
completely different to the i_mmap and the i_mapping.

IOWs, we have 4 layers of entwined structures and locking here
that pretty much all have the same name but protect different things
and not always the obvious thing the name suggests. This makes it
really difficult to actually read the code and understand that the
correct lock is being used in the correct place...


>   *
>   *  ->mmap_lock
>   *    ->i_mmap_rwsem
> @@ -85,7 +86,8 @@
>   *        ->i_pages lock	(arch-dependent flush_dcache_mmap_lock)
>   *
>   *  ->mmap_lock
> - *    ->lock_page		(access_process_vm)
> + *    ->i_mapping_sem		(filemap_fault)
> + *      ->lock_page		(filemap_fault, access_process_vm)
>   *
>   *  ->i_rwsem			(generic_perform_write)
>   *    ->mmap_lock		(fault_in_pages_readable->do_page_fault)
> @@ -2276,16 +2278,28 @@ static int filemap_update_page(struct kiocb *iocb,
>  {
>  	int error;
>  
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!down_read_trylock(&mapping->host->i_mapping_sem))
> +			return -EAGAIN;
> +	} else {
> +		down_read(&mapping->host->i_mapping_sem);
> +	}

We really need a lock primitive for this. The number of times this
exact lock pattern is being replicated all through the IO path is
getting out of hand.

static inline bool
down_read_try_or_lock(struct rwsem *sem, bool try)
{
	if (try) {
		if (!down_read_trylock(sem))
			return false;
	} else {
		down_read(&mapping->host->i_mapping_sem);
	}
	return true;
}

and the callers become:

	if (!down_read_try_or_lock(sem, (iocb->ki_flags & IOCB_NOWAIT)))
		return -EAGAIN;

We can do the same with mutex_try_or_lock(), down_try_or_lock(), etc
and we don't need to rely on cargo cult knowledge to propagate this
pattern anymore. Because I'm betting relatively few people actually
know why the code is written this way because the only place it is
documented is in an XFS commit message....

Doing this is a separate cleanup, though, and not something that
needs to be done in this patchset.

> index c5b0457415be..ac5bb50b3a4c 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -192,6 +192,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 */
>  	unsigned int nofs = memalloc_nofs_save();
>  
> +	down_read(&mapping->host->i_mapping_sem);
>  	/*
>  	 * Preallocate as many pages as we will need.
>  	 */

I can't say I'm a great fan of having the mapping reach back up to
the host to lock the host. THis seems the wrong way around to me
given that most of the locking in the IO path is in "host locks
mapping" and "mapping locks internal mapping structures" order...

I also come back to the naming confusion here, in that when we look
at this in long hand from the inode perspective, this chain actually
looks like:

	lock(inode->i_mapping->inode->i_mapping_sem)

i.e. the mapping is reaching back up outside it's scope to lock
itself against other inode->i_mapping operations. Smells of layering
violations to me.

So, next question: should this truncate semanphore actually be part
of the address space, not the inode? This patch is actually moving
the page fault serialisation from the inode into the address space
operations when page faults and page cache operations are done, so
maybe the lock should also make that move? That would help clear up
the naming problem, because now we can name it based around what it
serialises in the address space, not the address space as a whole...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
