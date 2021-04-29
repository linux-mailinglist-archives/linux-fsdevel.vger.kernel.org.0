Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B936E801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 11:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhD2JbA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 05:31:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230392AbhD2Ja7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:30:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90553AE8D;
        Thu, 29 Apr 2021 09:30:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 140851E37A2; Thu, 29 Apr 2021 11:30:12 +0200 (CEST)
Date:   Thu, 29 Apr 2021 11:30:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/12] shmem: Convert to using invalidate_lock
Message-ID: <20210429093012.GB11234@quack2.suse.cz>
References: <20210423171010.12-1-jack@suse.cz>
 <20210423173018.23133-9-jack@suse.cz>
 <alpine.LSU.2.11.2104282025170.10848@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104282025170.10848@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 28-04-21 21:12:36, Hugh Dickins wrote:
> On Fri, 23 Apr 2021, Jan Kara wrote:
> 
> > Shmem uses a home-grown mechanism for serializing hole punch with page
> > fault. Use mapping->invalidate_lock for it instead. Admittedly the
> > home-grown mechanism locks out only the range being actually punched out
> > while invalidate_lock locks the whole mapping so it is serializing more.
> > But hole punch doesn't seem to be that critical operation and the
> > simplification is noticeable.
> 
> Home-grown indeed (and went through several different bugginesses,
> Linus fixing issues in its waitq handling found years later).
> 
> I'd love to remove it all (rather than replace it by a new rwsem),
> but never enough courage+time to do so: on optimistic days (that is,
> rarely) I like to think that none of it would be needed nowadays;
> but its gestation was difficult, and I cannot easily reproduce the
> testing that demanded it (Sasha and Vlastimil helped a lot).
> 
> If you're interested in the history, I cannot point to one thread,
> but "shmem: fix faulting into a hole while it's punched" finds
> some of them, June/July 2014.  You've pushed me into re-reading
> there, but I've not yet found the crucial evidence that stopped us
> from reverting this mechanism, once we had abandoned the hole-punch
> "pincer" in shmem_undo_range().
> 
> tmpfs's problem with faulting versus hole-punch was not the data
> integrity issue you are attacking with invalidate_lock, but a
> starvation issue triggered in Trinity fuzzing.
> 
> If invalidate_lock had existed at the time, I might have reused it
> for this purpose too - I certainly wanted to avoid enlarging the
> inode with another rwsem just for this; but also reluctant to add
> another layer of locking to the common path (maybe I'm just silly
> to try to avoid an rwsem which is so rarely taken for writing?).
> 
> But the code as it stands is working satisfactorily with minimal
> overhead: so I'm not in a rush to remove or replace it yet. Thank
> you for including tmpfs in your reach, but I think for the moment
> I'd prefer you to leave this change out of the series. Maybe later
> when it's settled in the fs/ filesystems (perhaps making guarantees
> that we might want to extend to tmpfs) we could make this change -
> but I'd still rather let hole-punch and fault race freely without it.

OK, I'll remove the patch from the series for now. As you say, tmpfs is not
buggy so we can postpone the cleanup for later.

> But your 01/12, fixing mm comments mentioning i_mutex, looked good:
> Acked-by: Hugh Dickins <hughd@google.com>
> to that one.  But I think it would be better extracted from this
> invalidate_lock series, and just sent to akpm cc linux-mm on its own.

Thanks for review and yes, I guess I can send that patch to Andrew earlier.

								Honza

> > 
> > CC: Hugh Dickins <hughd@google.com>
> > CC: <linux-mm@kvack.org>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  mm/shmem.c | 98 ++++--------------------------------------------------
> >  1 file changed, 7 insertions(+), 91 deletions(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 55b2888db542..f34162ac46de 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -95,12 +95,11 @@ static struct vfsmount *shm_mnt;
> >  #define SHORT_SYMLINK_LEN 128
> >  
> >  /*
> > - * shmem_fallocate communicates with shmem_fault or shmem_writepage via
> > - * inode->i_private (with i_rwsem making sure that it has only one user at
> > - * a time): we would prefer not to enlarge the shmem inode just for that.
> > + * shmem_fallocate communicates with shmem_writepage via inode->i_private (with
> > + * i_rwsem making sure that it has only one user at a time): we would prefer
> > + * not to enlarge the shmem inode just for that.
> >   */
> >  struct shmem_falloc {
> > -	wait_queue_head_t *waitq; /* faults into hole wait for punch to end */
> >  	pgoff_t start;		/* start of range currently being fallocated */
> >  	pgoff_t next;		/* the next page offset to be fallocated */
> >  	pgoff_t nr_falloced;	/* how many new pages have been fallocated */
> > @@ -1378,7 +1377,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
> >  			spin_lock(&inode->i_lock);
> >  			shmem_falloc = inode->i_private;
> >  			if (shmem_falloc &&
> > -			    !shmem_falloc->waitq &&
> >  			    index >= shmem_falloc->start &&
> >  			    index < shmem_falloc->next)
> >  				shmem_falloc->nr_unswapped++;
> > @@ -2025,18 +2023,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >  	return error;
> >  }
> >  
> > -/*
> > - * This is like autoremove_wake_function, but it removes the wait queue
> > - * entry unconditionally - even if something else had already woken the
> > - * target.
> > - */
> > -static int synchronous_wake_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
> > -{
> > -	int ret = default_wake_function(wait, mode, sync, key);
> > -	list_del_init(&wait->entry);
> > -	return ret;
> > -}
> > -
> >  static vm_fault_t shmem_fault(struct vm_fault *vmf)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> > @@ -2046,65 +2032,6 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
> >  	int err;
> >  	vm_fault_t ret = VM_FAULT_LOCKED;
> >  
> > -	/*
> > -	 * Trinity finds that probing a hole which tmpfs is punching can
> > -	 * prevent the hole-punch from ever completing: which in turn
> > -	 * locks writers out with its hold on i_rwsem.  So refrain from
> > -	 * faulting pages into the hole while it's being punched.  Although
> > -	 * shmem_undo_range() does remove the additions, it may be unable to
> > -	 * keep up, as each new page needs its own unmap_mapping_range() call,
> > -	 * and the i_mmap tree grows ever slower to scan if new vmas are added.
> > -	 *
> > -	 * It does not matter if we sometimes reach this check just before the
> > -	 * hole-punch begins, so that one fault then races with the punch:
> > -	 * we just need to make racing faults a rare case.
> > -	 *
> > -	 * The implementation below would be much simpler if we just used a
> > -	 * standard mutex or completion: but we cannot take i_rwsem in fault,
> > -	 * and bloating every shmem inode for this unlikely case would be sad.
> > -	 */
> > -	if (unlikely(inode->i_private)) {
> > -		struct shmem_falloc *shmem_falloc;
> > -
> > -		spin_lock(&inode->i_lock);
> > -		shmem_falloc = inode->i_private;
> > -		if (shmem_falloc &&
> > -		    shmem_falloc->waitq &&
> > -		    vmf->pgoff >= shmem_falloc->start &&
> > -		    vmf->pgoff < shmem_falloc->next) {
> > -			struct file *fpin;
> > -			wait_queue_head_t *shmem_falloc_waitq;
> > -			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
> > -
> > -			ret = VM_FAULT_NOPAGE;
> > -			fpin = maybe_unlock_mmap_for_io(vmf, NULL);
> > -			if (fpin)
> > -				ret = VM_FAULT_RETRY;
> > -
> > -			shmem_falloc_waitq = shmem_falloc->waitq;
> > -			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> > -					TASK_UNINTERRUPTIBLE);
> > -			spin_unlock(&inode->i_lock);
> > -			schedule();
> > -
> > -			/*
> > -			 * shmem_falloc_waitq points into the shmem_fallocate()
> > -			 * stack of the hole-punching task: shmem_falloc_waitq
> > -			 * is usually invalid by the time we reach here, but
> > -			 * finish_wait() does not dereference it in that case;
> > -			 * though i_lock needed lest racing with wake_up_all().
> > -			 */
> > -			spin_lock(&inode->i_lock);
> > -			finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
> > -			spin_unlock(&inode->i_lock);
> > -
> > -			if (fpin)
> > -				fput(fpin);
> > -			return ret;
> > -		}
> > -		spin_unlock(&inode->i_lock);
> > -	}
> > -
> >  	sgp = SGP_CACHE;
> >  
> >  	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > @@ -2113,8 +2040,10 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
> >  	else if (vma->vm_flags & VM_HUGEPAGE)
> >  		sgp = SGP_HUGE;
> >  
> > +	down_read(&inode->i_mapping->invalidate_lock);
> >  	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, sgp,
> >  				  gfp, vma, vmf, &ret);
> > +	up_read(&inode->i_mapping->invalidate_lock);
> >  	if (err)
> >  		return vmf_error(err);
> >  	return ret;
> > @@ -2715,7 +2644,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  		struct address_space *mapping = file->f_mapping;
> >  		loff_t unmap_start = round_up(offset, PAGE_SIZE);
> >  		loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
> > -		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(shmem_falloc_waitq);
> >  
> >  		/* protected by i_rwsem */
> >  		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
> > @@ -2723,24 +2651,13 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  			goto out;
> >  		}
> >  
> > -		shmem_falloc.waitq = &shmem_falloc_waitq;
> > -		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
> > -		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
> > -		spin_lock(&inode->i_lock);
> > -		inode->i_private = &shmem_falloc;
> > -		spin_unlock(&inode->i_lock);
> > -
> > +		down_write(&mapping->invalidate_lock);
> >  		if ((u64)unmap_end > (u64)unmap_start)
> >  			unmap_mapping_range(mapping, unmap_start,
> >  					    1 + unmap_end - unmap_start, 0);
> >  		shmem_truncate_range(inode, offset, offset + len - 1);
> >  		/* No need to unmap again: hole-punching leaves COWed pages */
> > -
> > -		spin_lock(&inode->i_lock);
> > -		inode->i_private = NULL;
> > -		wake_up_all(&shmem_falloc_waitq);
> > -		WARN_ON_ONCE(!list_empty(&shmem_falloc_waitq.head));
> > -		spin_unlock(&inode->i_lock);
> > +		up_write(&mapping->invalidate_lock);
> >  		error = 0;
> >  		goto out;
> >  	}
> > @@ -2763,7 +2680,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >  		goto out;
> >  	}
> >  
> > -	shmem_falloc.waitq = NULL;
> >  	shmem_falloc.start = start;
> >  	shmem_falloc.next  = start;
> >  	shmem_falloc.nr_falloced = 0;
> > -- 
> > 2.26.2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
