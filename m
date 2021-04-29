Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D841D36E3F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 06:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbhD2EN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 00:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhD2ENZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:13:25 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF768C06138B
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 21:12:39 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j3so31950985qvs.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 21:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vV2Drh2IH1e4h0UJu/AMeNQVNTABZ8GUFrKtqQXkuxM=;
        b=r0EdLnAxgDeCeqTFnkEQUOoM3lqZzcOnbJ/J7ONwLfV0EaaInQ/ppW3kwzw8AV47zV
         H/B1IxMaWKhG3L578unDSbH963BdTVJxtsmZTM1ToXzo6dJiRLMrn95XOgXhWY5e0JGq
         aPJluAIKpQUTg6m1K0sQNJCKv8hh/b86XCcOUl2j9W9UIZkvb2Y+/d5S2PFEybs3tj7m
         oQurdqXnxz7BS17kPSk8u5ahmmw8Hmz0hOWiQ+tVEOA3G378ENaWxMtCb9f2yMp8ttiq
         AaJf8Cz5WcwxI2fnNMCQf4lJxLQH0DgEhetvupObkDCd+lF36w4UknHTwRZMFyvgEZ5t
         qdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vV2Drh2IH1e4h0UJu/AMeNQVNTABZ8GUFrKtqQXkuxM=;
        b=Klu43y5oklw5D2NZ8DWfkSRWtnPz0LwAWOuEllCl0ihGK4fjL1DTWnVlKNJ+hlsPIP
         W3Bx1aIlRqCRCwmALx/S8jd8co2rVqX5uWt4RmVkiocmm0w648EKqzO9Wl4sQ5B1pJtR
         tzWhoyBTWDaLQLvLQU1tDjyA5E4qP0EzvYViUquXX0YfJQY5eJsy3JZEV8pNc3m3X3mK
         kZWVU2mK10Q2gYxlQy4rLKs1A8MpkTi2FUnmcqwNAkQpmeKZFJeuPjVokHFbgnqCiL8b
         vvg0E+8oy8lg8e+2EJbKrozMxMf+LmwM2efFY8tTNmdB4/uhw+xoOiMyQTXsv0vukxVK
         viXA==
X-Gm-Message-State: AOAM533oWiW3VnaeaiFkH79H1g09g+i1ep4C58IwIZEmzZ5Hv78WvzsW
        uUazG9R8w4PSPmsro4lwGx7vQQ==
X-Google-Smtp-Source: ABdhPJwWp0meRnSuqUNtKMZreZHdcTMXaup6d9jVUUEFV99Cun0JwiS9eF/j50Z1vRuwblUv/QYJKw==
X-Received: by 2002:a0c:e586:: with SMTP id t6mr32813411qvm.40.1619669558838;
        Wed, 28 Apr 2021 21:12:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e10sm1370070qka.56.2021.04.28.21.12.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 28 Apr 2021 21:12:38 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:12:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jan Kara <jack@suse.cz>
cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH 09/12] shmem: Convert to using invalidate_lock
In-Reply-To: <20210423173018.23133-9-jack@suse.cz>
Message-ID: <alpine.LSU.2.11.2104282025170.10848@eggly.anvils>
References: <20210423171010.12-1-jack@suse.cz> <20210423173018.23133-9-jack@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Apr 2021, Jan Kara wrote:

> Shmem uses a home-grown mechanism for serializing hole punch with page
> fault. Use mapping->invalidate_lock for it instead. Admittedly the
> home-grown mechanism locks out only the range being actually punched out
> while invalidate_lock locks the whole mapping so it is serializing more.
> But hole punch doesn't seem to be that critical operation and the
> simplification is noticeable.

Home-grown indeed (and went through several different bugginesses,
Linus fixing issues in its waitq handling found years later).

I'd love to remove it all (rather than replace it by a new rwsem),
but never enough courage+time to do so: on optimistic days (that is,
rarely) I like to think that none of it would be needed nowadays;
but its gestation was difficult, and I cannot easily reproduce the
testing that demanded it (Sasha and Vlastimil helped a lot).

If you're interested in the history, I cannot point to one thread,
but "shmem: fix faulting into a hole while it's punched" finds
some of them, June/July 2014.  You've pushed me into re-reading
there, but I've not yet found the crucial evidence that stopped us
from reverting this mechanism, once we had abandoned the hole-punch
"pincer" in shmem_undo_range().

tmpfs's problem with faulting versus hole-punch was not the data
integrity issue you are attacking with invalidate_lock, but a
starvation issue triggered in Trinity fuzzing.

If invalidate_lock had existed at the time, I might have reused it
for this purpose too - I certainly wanted to avoid enlarging the
inode with another rwsem just for this; but also reluctant to add
another layer of locking to the common path (maybe I'm just silly
to try to avoid an rwsem which is so rarely taken for writing?).

But the code as it stands is working satisfactorily with minimal
overhead: so I'm not in a rush to remove or replace it yet. Thank
you for including tmpfs in your reach, but I think for the moment
I'd prefer you to leave this change out of the series. Maybe later
when it's settled in the fs/ filesystems (perhaps making guarantees
that we might want to extend to tmpfs) we could make this change -
but I'd still rather let hole-punch and fault race freely without it.

But your 01/12, fixing mm comments mentioning i_mutex, looked good:
Acked-by: Hugh Dickins <hughd@google.com>
to that one.  But I think it would be better extracted from this
invalidate_lock series, and just sent to akpm cc linux-mm on its own.

Thanks,
Hugh

> 
> CC: Hugh Dickins <hughd@google.com>
> CC: <linux-mm@kvack.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  mm/shmem.c | 98 ++++--------------------------------------------------
>  1 file changed, 7 insertions(+), 91 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 55b2888db542..f34162ac46de 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -95,12 +95,11 @@ static struct vfsmount *shm_mnt;
>  #define SHORT_SYMLINK_LEN 128
>  
>  /*
> - * shmem_fallocate communicates with shmem_fault or shmem_writepage via
> - * inode->i_private (with i_rwsem making sure that it has only one user at
> - * a time): we would prefer not to enlarge the shmem inode just for that.
> + * shmem_fallocate communicates with shmem_writepage via inode->i_private (with
> + * i_rwsem making sure that it has only one user at a time): we would prefer
> + * not to enlarge the shmem inode just for that.
>   */
>  struct shmem_falloc {
> -	wait_queue_head_t *waitq; /* faults into hole wait for punch to end */
>  	pgoff_t start;		/* start of range currently being fallocated */
>  	pgoff_t next;		/* the next page offset to be fallocated */
>  	pgoff_t nr_falloced;	/* how many new pages have been fallocated */
> @@ -1378,7 +1377,6 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>  			spin_lock(&inode->i_lock);
>  			shmem_falloc = inode->i_private;
>  			if (shmem_falloc &&
> -			    !shmem_falloc->waitq &&
>  			    index >= shmem_falloc->start &&
>  			    index < shmem_falloc->next)
>  				shmem_falloc->nr_unswapped++;
> @@ -2025,18 +2023,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	return error;
>  }
>  
> -/*
> - * This is like autoremove_wake_function, but it removes the wait queue
> - * entry unconditionally - even if something else had already woken the
> - * target.
> - */
> -static int synchronous_wake_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
> -{
> -	int ret = default_wake_function(wait, mode, sync, key);
> -	list_del_init(&wait->entry);
> -	return ret;
> -}
> -
>  static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> @@ -2046,65 +2032,6 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	int err;
>  	vm_fault_t ret = VM_FAULT_LOCKED;
>  
> -	/*
> -	 * Trinity finds that probing a hole which tmpfs is punching can
> -	 * prevent the hole-punch from ever completing: which in turn
> -	 * locks writers out with its hold on i_rwsem.  So refrain from
> -	 * faulting pages into the hole while it's being punched.  Although
> -	 * shmem_undo_range() does remove the additions, it may be unable to
> -	 * keep up, as each new page needs its own unmap_mapping_range() call,
> -	 * and the i_mmap tree grows ever slower to scan if new vmas are added.
> -	 *
> -	 * It does not matter if we sometimes reach this check just before the
> -	 * hole-punch begins, so that one fault then races with the punch:
> -	 * we just need to make racing faults a rare case.
> -	 *
> -	 * The implementation below would be much simpler if we just used a
> -	 * standard mutex or completion: but we cannot take i_rwsem in fault,
> -	 * and bloating every shmem inode for this unlikely case would be sad.
> -	 */
> -	if (unlikely(inode->i_private)) {
> -		struct shmem_falloc *shmem_falloc;
> -
> -		spin_lock(&inode->i_lock);
> -		shmem_falloc = inode->i_private;
> -		if (shmem_falloc &&
> -		    shmem_falloc->waitq &&
> -		    vmf->pgoff >= shmem_falloc->start &&
> -		    vmf->pgoff < shmem_falloc->next) {
> -			struct file *fpin;
> -			wait_queue_head_t *shmem_falloc_waitq;
> -			DEFINE_WAIT_FUNC(shmem_fault_wait, synchronous_wake_function);
> -
> -			ret = VM_FAULT_NOPAGE;
> -			fpin = maybe_unlock_mmap_for_io(vmf, NULL);
> -			if (fpin)
> -				ret = VM_FAULT_RETRY;
> -
> -			shmem_falloc_waitq = shmem_falloc->waitq;
> -			prepare_to_wait(shmem_falloc_waitq, &shmem_fault_wait,
> -					TASK_UNINTERRUPTIBLE);
> -			spin_unlock(&inode->i_lock);
> -			schedule();
> -
> -			/*
> -			 * shmem_falloc_waitq points into the shmem_fallocate()
> -			 * stack of the hole-punching task: shmem_falloc_waitq
> -			 * is usually invalid by the time we reach here, but
> -			 * finish_wait() does not dereference it in that case;
> -			 * though i_lock needed lest racing with wake_up_all().
> -			 */
> -			spin_lock(&inode->i_lock);
> -			finish_wait(shmem_falloc_waitq, &shmem_fault_wait);
> -			spin_unlock(&inode->i_lock);
> -
> -			if (fpin)
> -				fput(fpin);
> -			return ret;
> -		}
> -		spin_unlock(&inode->i_lock);
> -	}
> -
>  	sgp = SGP_CACHE;
>  
>  	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> @@ -2113,8 +2040,10 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
>  	else if (vma->vm_flags & VM_HUGEPAGE)
>  		sgp = SGP_HUGE;
>  
> +	down_read(&inode->i_mapping->invalidate_lock);
>  	err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, sgp,
>  				  gfp, vma, vmf, &ret);
> +	up_read(&inode->i_mapping->invalidate_lock);
>  	if (err)
>  		return vmf_error(err);
>  	return ret;
> @@ -2715,7 +2644,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>  		struct address_space *mapping = file->f_mapping;
>  		loff_t unmap_start = round_up(offset, PAGE_SIZE);
>  		loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
> -		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(shmem_falloc_waitq);
>  
>  		/* protected by i_rwsem */
>  		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
> @@ -2723,24 +2651,13 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>  			goto out;
>  		}
>  
> -		shmem_falloc.waitq = &shmem_falloc_waitq;
> -		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
> -		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
> -		spin_lock(&inode->i_lock);
> -		inode->i_private = &shmem_falloc;
> -		spin_unlock(&inode->i_lock);
> -
> +		down_write(&mapping->invalidate_lock);
>  		if ((u64)unmap_end > (u64)unmap_start)
>  			unmap_mapping_range(mapping, unmap_start,
>  					    1 + unmap_end - unmap_start, 0);
>  		shmem_truncate_range(inode, offset, offset + len - 1);
>  		/* No need to unmap again: hole-punching leaves COWed pages */
> -
> -		spin_lock(&inode->i_lock);
> -		inode->i_private = NULL;
> -		wake_up_all(&shmem_falloc_waitq);
> -		WARN_ON_ONCE(!list_empty(&shmem_falloc_waitq.head));
> -		spin_unlock(&inode->i_lock);
> +		up_write(&mapping->invalidate_lock);
>  		error = 0;
>  		goto out;
>  	}
> @@ -2763,7 +2680,6 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>  		goto out;
>  	}
>  
> -	shmem_falloc.waitq = NULL;
>  	shmem_falloc.start = start;
>  	shmem_falloc.next  = start;
>  	shmem_falloc.nr_falloced = 0;
> -- 
> 2.26.2
