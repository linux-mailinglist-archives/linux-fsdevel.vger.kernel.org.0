Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3526A348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 12:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIOKjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 06:39:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:37594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOKjl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:39:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 570CEADCD;
        Tue, 15 Sep 2020 10:39:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 766FE1E12EF; Tue, 15 Sep 2020 12:39:38 +0200 (CEST)
Date:   Tue, 15 Sep 2020 12:39:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Kernel Benchmarking
Message-ID: <20200915103938.GL4863@quack2.suse.cz>
References: <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <803672c0-7c57-9d25-ffb4-cde891eac4d3@MichaelLarabel.com>
 <20200915033210.GA5449@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915033210.GA5449@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew!

On Tue 15-09-20 04:32:10, Matthew Wilcox wrote:
> On Sat, Sep 12, 2020 at 09:44:15AM -0500, Michael Larabel wrote:
> > Interesting, I'll fire up some cross-filesystem benchmarks with those tests
> > today and report back shortly with the difference.
> 
> If you have time, perhaps you'd like to try this patch.  It tries to
> handle page faults locklessly when possible, which should be the case
> where you're seeing page lock contention.  I've tried to be fairly
> conservative in this patch; reducing page lock acquisition should be
> possible in more cases.

So I'd be somewhat uneasy with this optimization. The thing is that e.g.
page migration relies on page lock protecting page from being mapped? How
does your patch handle that? I'm also not sure if the rmap code is really
ready for new page reverse mapping being added without holding page lock...

								Honza
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ca6e6a81576b..a14785b7fca7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -416,6 +416,7 @@ extern pgprot_t protection_map[16];
>   * @FAULT_FLAG_REMOTE: The fault is not for current task/mm.
>   * @FAULT_FLAG_INSTRUCTION: The fault was during an instruction fetch.
>   * @FAULT_FLAG_INTERRUPTIBLE: The fault can be interrupted by non-fatal signals.
> + * @FAULT_FLAG_UPTODATE_ONLY: The fault handler returned @VM_FAULT_UPTODATE.
>   *
>   * About @FAULT_FLAG_ALLOW_RETRY and @FAULT_FLAG_TRIED: we can specify
>   * whether we would allow page faults to retry by specifying these two
> @@ -446,6 +447,7 @@ extern pgprot_t protection_map[16];
>  #define FAULT_FLAG_REMOTE			0x80
>  #define FAULT_FLAG_INSTRUCTION  		0x100
>  #define FAULT_FLAG_INTERRUPTIBLE		0x200
> +#define FAULT_FLAG_UPTODATE_ONLY		0x400
>  
>  /*
>   * The default fault flags that should be used by most of the
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 496c3ff97cce..632eabcad2f7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -689,6 +689,8 @@ typedef __bitwise unsigned int vm_fault_t;
>   * @VM_FAULT_NEEDDSYNC:		->fault did not modify page tables and needs
>   *				fsync() to complete (for synchronous page faults
>   *				in DAX)
> + * @VM_FAULT_UPTODATE:		Page is not locked; must check it is still
> + *				uptodate under the page table lock
>   * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
>   *
>   */
> @@ -706,6 +708,7 @@ enum vm_fault_reason {
>  	VM_FAULT_FALLBACK       = (__force vm_fault_t)0x000800,
>  	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
>  	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
> +	VM_FAULT_UPTODATE       = (__force vm_fault_t)0x004000,
>  	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
>  };
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1aaea26556cc..38f87dd86312 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2602,6 +2602,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		}
>  	}
>  
> +	if (fpin)
> +		goto out_retry;
> +	if (likely(PageUptodate(page))) {
> +		ret |= VM_FAULT_UPTODATE;
> +		goto uptodate;
> +	}
> +
>  	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
>  		goto out_retry;
>  
> @@ -2630,19 +2637,19 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  		goto out_retry;
>  	}
>  
> -	/*
> -	 * Found the page and have a reference on it.
> -	 * We must recheck i_size under page lock.
> -	 */
> +	ret |= VM_FAULT_LOCKED;
> +	/* Must recheck i_size after getting a stable reference to the page */
> +uptodate:
>  	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
>  	if (unlikely(offset >= max_off)) {
> -		unlock_page(page);
> +		if (ret & VM_FAULT_LOCKED)
> +			unlock_page(page);
>  		put_page(page);
>  		return VM_FAULT_SIGBUS;
>  	}
>  
>  	vmf->page = page;
> -	return ret | VM_FAULT_LOCKED;
> +	return ret;
>  
>  page_not_uptodate:
>  	/*
> diff --git a/mm/memory.c b/mm/memory.c
> index 469af373ae76..53c8ef2bb38b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3460,11 +3460,6 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  		return VM_FAULT_HWPOISON;
>  	}
>  
> -	if (unlikely(!(ret & VM_FAULT_LOCKED)))
> -		lock_page(vmf->page);
> -	else
> -		VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page);
> -
>  	return ret;
>  }
>  
> @@ -3646,12 +3641,13 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
>  		return VM_FAULT_NOPAGE;
>  	}
>  
> -	flush_icache_page(vma, page);
> -	entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
> -	if (write)
> -		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> -	/* copy-on-write page */
> +	/*
> +	 * If the page isn't locked, truncate or invalidate2 may be
> +	 * trying to remove it at the same time.  Both paths will check
> +	 * the page's mapcount after clearing the PageUptodate bit,
> +	 * so if we increment the mapcount here before checking the
> +	 * Uptodate bit, the page will be unmapped by the other thread.
> +	 */
>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>  		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  		page_add_new_anon_rmap(page, vma, vmf->address, false);
> @@ -3660,6 +3656,25 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
>  		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
>  		page_add_file_rmap(page, false);
>  	}
> +	smp_mb__after_atomic();
> +
> +	if ((vmf->flags & FAULT_FLAG_UPTODATE_ONLY) && !PageUptodate(page)) {
> +		page_remove_rmap(page, false);
> +		if (write && !(vma->vm_flags & VM_SHARED)) {
> +			dec_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
> +			/* lru_cache_remove_inactive_or_unevictable? */
> +		} else {
> +			dec_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
> +		}
> +		return VM_FAULT_NOPAGE;
> +	}
> +
> +	flush_icache_page(vma, page);
> +	entry = mk_pte(page, vma->vm_page_prot);
> +	entry = pte_sw_mkyoung(entry);
> +	if (write)
> +		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	/* copy-on-write page */
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>  
>  	/* no need to invalidate: a not-present page won't be cached */
> @@ -3844,8 +3859,18 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
>  		return ret;
>  
> +	if (ret & VM_FAULT_UPTODATE)
> +		vmf->flags |= FAULT_FLAG_UPTODATE_ONLY;
> +	else if (unlikely(!(ret & VM_FAULT_LOCKED)))
> +		lock_page(vmf->page);
> +	else
> +		VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page);
> +
>  	ret |= finish_fault(vmf);
> -	unlock_page(vmf->page);
> +	if (ret & VM_FAULT_UPTODATE)
> +		vmf->flags &= ~FAULT_FLAG_UPTODATE_ONLY;
> +	else
> +		unlock_page(vmf->page);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
>  		put_page(vmf->page);
>  	return ret;
> @@ -3875,6 +3900,11 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
>  	if (ret & VM_FAULT_DONE_COW)
>  		return ret;
>  
> +	if (!(ret & VM_FAULT_LOCKED))
> +		lock_page(vmf->page);
> +	else
> +		VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page);
> +
>  	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
>  	__SetPageUptodate(vmf->cow_page);
>  
> @@ -3898,6 +3928,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
>  		return ret;
>  
> +	if (!(ret & VM_FAULT_LOCKED))
> +		lock_page(vmf->page);
> +	else
> +		VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page);
> +
>  	/*
>  	 * Check if the backing address space wants to know that the page is
>  	 * about to become writable
> diff --git a/mm/truncate.c b/mm/truncate.c
> index dd9ebc1da356..96a0408804a7 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -176,6 +176,8 @@ void do_invalidatepage(struct page *page, unsigned int offset,
>  static void
>  truncate_cleanup_page(struct address_space *mapping, struct page *page)
>  {
> +	ClearPageUptodate(page);
> +	smp_mb__before_atomic();
>  	if (page_mapped(page)) {
>  		pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
>  		unmap_mapping_pages(mapping, page->index, nr, false);
> @@ -655,6 +657,12 @@ invalidate_complete_page2(struct address_space *mapping, struct page *page)
>  		mapping->a_ops->freepage(page);
>  
>  	put_page(page);	/* pagecache ref */
> +
> +	/* An unlocked page fault may have inserted an entry */
> +	ClearPageUptodate(page);
> +	smp_mb__before_atomic();
> +	if (page_mapped(page))
> +		unmap_mapping_pages(mapping, page->index, 1, false);
>  	return 1;
>  failed:
>  	xa_unlock_irqrestore(&mapping->i_pages, flags);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
