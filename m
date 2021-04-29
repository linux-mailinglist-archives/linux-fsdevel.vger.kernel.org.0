Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA25B36E7D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhD2JVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 05:21:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233997AbhD2JVj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:21:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 613F2AE8D;
        Thu, 29 Apr 2021 09:20:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C27991E37A2; Thu, 29 Apr 2021 11:20:52 +0200 (CEST)
Date:   Thu, 29 Apr 2021 11:20:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        linux-mm@kvack.org
Subject: Re: [PATCH 10/12] shmem: Use invalidate_lock to protect fallocate
Message-ID: <20210429092052.GA11234@quack2.suse.cz>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-10-jack@suse.cz>
 <alpine.LSU.2.11.2104282004410.10848@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104282004410.10848@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-04-21 20:24:59, Hugh Dickins wrote:
> On Fri, 23 Apr 2021, Jan Kara wrote:
> 
> > We have to handle pages added by currently running shmem_fallocate()
> > specially in shmem_writepage(). For this we use serialization mechanism
> > using structure attached to inode->i_private field. If we protect
> > allocation of pages in shmem_fallocate() with invalidate_lock instead,
> > we are sure added pages cannot be dirtied until shmem_fallocate() is done
> > (invalidate_lock blocks faults, i_rwsem blocks writes) and thus we
> > cannot see those pages in shmem_writepage() and there's no need for the
> > serialization mechanism.
> 
> Appealing diffstat, but NAK, this patch is based on a false premise.
> 
> All those pages that are added by shmem_fallocate() are marked dirty:
> see the set_page_dirty(page) and comment above it in shmem_fallocate().

Aha, I missed that set_page_dirty(). Thanks for correcting me.

> It's intentional, that they should percolate through to shmem_writepage()
> when memory is tight, and give feedback to fallocate that it should stop
> (instead of getting into that horrid OOM-kill flurry that never even
> frees any tmpfs anyway).

I understand the reason, I just feel there should be a better way of
communicating memory pressure than ->writepage talking to ->fallocate
through structure attached to inode->i_private. But now I see it isn't as
simple as I thought ;) Anyway for now I'll just remove this patch. Thanks
for review!

								Honza

> > CC: Hugh Dickins <hughd@google.com>
> > CC: <linux-mm@kvack.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  mm/shmem.c | 61 ++++++------------------------------------------------
> >  1 file changed, 6 insertions(+), 55 deletions(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index f34162ac46de..7a2b0744031e 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -94,18 +94,6 @@ static struct vfsmount *shm_mnt;
> >  /* Symlink up to this size is kmalloc'ed instead of using a swappable page */
> >  #define SHORT_SYMLINK_LEN 128
> >  
> > -/*
> > - * shmem_fallocate communicates with shmem_writepage via inode->i_private (with
> > - * i_rwsem making sure that it has only one user at a time): we would prefer
> > - * not to enlarge the shmem inode just for that.
> > - */
> > -struct shmem_falloc {
> > -	pgoff_t start;		/* start of range currently being fallocated */
> > -	pgoff_t next;		/* the next page offset to be fallocated */
> > -	pgoff_t nr_falloced;	/* how many new pages have been fallocated */
> > -	pgoff_t nr_unswapped;	/* how often writepage refused to swap out */
> > -};
> > -
> >  struct shmem_options {
> >  	unsigned long long blocks;
> >  	unsigned long long inodes;
> > @@ -1364,28 +1352,11 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
> >  	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
> >  	 * value into swapfile.c, the only way we can correctly account for a
> >  	 * fallocated page arriving here is now to initialize it and write it.
> > -	 *
> > -	 * That's okay for a page already fallocated earlier, but if we have
> > -	 * not yet completed the fallocation, then (a) we want to keep track
> > -	 * of this page in case we have to undo it, and (b) it may not be a
> > -	 * good idea to continue anyway, once we're pushing into swap.  So
> > -	 * reactivate the page, and let shmem_fallocate() quit when too many.
> 
> (b) there commenting on communicating back to fallocate by nr_unswapped.
> 
> > +	 * Since a page added by currently running fallocate call cannot be
> > +	 * dirtied and thus arrive here we know the fallocate has already
> > +	 * completed and we are fine writing it out.
> >  	 */
> >  	if (!PageUptodate(page)) {
> > -		if (inode->i_private) {
> > -			struct shmem_falloc *shmem_falloc;
> > -			spin_lock(&inode->i_lock);
> > -			shmem_falloc = inode->i_private;
> > -			if (shmem_falloc &&
> > -			    index >= shmem_falloc->start &&
> > -			    index < shmem_falloc->next)
> > -				shmem_falloc->nr_unswapped++;
> > -			else
> > -				shmem_falloc = NULL;
> > -			spin_unlock(&inode->i_lock);
> > -			if (shmem_falloc)
> > -				goto redirty;
> > -		}
> >  		clear_highpage(page);
> >  		flush_dcache_page(page);
> >  		SetPageUptodate(page);
> > @@ -2629,9 +2600,9 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  							 loff_t len)
> >  {
> >  	struct inode *inode = file_inode(file);
> > +	struct address_space *mapping = file->f_mapping;
> >  	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> >  	struct shmem_inode_info *info = SHMEM_I(inode);
> > -	struct shmem_falloc shmem_falloc;
> >  	pgoff_t start, index, end;
> >  	int error;
> >  
> > @@ -2641,7 +2612,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  	inode_lock(inode);
> >  
> >  	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > -		struct address_space *mapping = file->f_mapping;
> >  		loff_t unmap_start = round_up(offset, PAGE_SIZE);
> >  		loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
> >  
> > @@ -2680,14 +2650,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  		goto out;
> >  	}
> >  
> > -	shmem_falloc.start = start;
> > -	shmem_falloc.next  = start;
> > -	shmem_falloc.nr_falloced = 0;
> > -	shmem_falloc.nr_unswapped = 0;
> > -	spin_lock(&inode->i_lock);
> > -	inode->i_private = &shmem_falloc;
> > -	spin_unlock(&inode->i_lock);
> > -
> > +	down_write(&mapping->invalidate_lock);
> >  	for (index = start; index < end; index++) {
> >  		struct page *page;
> >  
> > @@ -2697,8 +2660,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  		 */
> >  		if (signal_pending(current))
> >  			error = -EINTR;
> > -		else if (shmem_falloc.nr_unswapped > shmem_falloc.nr_falloced)
> > -			error = -ENOMEM;
> >  		else
> >  			error = shmem_getpage(inode, index, &page, SGP_FALLOC);
> >  		if (error) {
> > @@ -2711,14 +2672,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  			goto undone;
> >  		}
> >  
> > -		/*
> > -		 * Inform shmem_writepage() how far we have reached.
> > -		 * No need for lock or barrier: we have the page lock.
> > -		 */
> > -		shmem_falloc.next++;
> > -		if (!PageUptodate(page))
> > -			shmem_falloc.nr_falloced++;
> > -
> >  		/*
> >  		 * If !PageUptodate, leave it that way so that freeable pages
> >  		 * can be recognized if we need to rollback on error later.
> 
> Which goes on to say:
> 
> 		 * But set_page_dirty so that memory pressure will swap rather
> 		 * than free the pages we are allocating (and SGP_CACHE pages
> 		 * might still be clean: we now need to mark those dirty too).
> 		 */
> 		set_page_dirty(page);
> 		unlock_page(page);
> 		put_page(page);
> 		cond_resched();
> 
> > @@ -2736,9 +2689,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  		i_size_write(inode, offset + len);
> >  	inode->i_ctime = current_time(inode);
> >  undone:
> > -	spin_lock(&inode->i_lock);
> > -	inode->i_private = NULL;
> > -	spin_unlock(&inode->i_lock);
> > +	up_write(&mapping->invalidate_lock);
> >  out:
> >  	inode_unlock(inode);
> >  	return error;
> > -- 
> > 2.26.2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
