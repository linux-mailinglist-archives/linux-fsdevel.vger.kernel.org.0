Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC131267CA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 00:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgILWcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgILWcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 18:32:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87BAC061573;
        Sat, 12 Sep 2020 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HUKRNYzCs7ABQrgTXMnIasKGkOwF/bPPs+kH60q++fY=; b=h4Kf3rw72fkGxNGGyUKXCa7NKJ
        nEq65GQhblELmcqbIp6Wp5Hf4PtWGXr77RHOCcTqriW7rldta0wDVYJFspJuTZgO2u1kgZrzc78VR
        yGX5GxLOryCfhS3w/qey+z2ky9mBeuZ0v8mrMFWuXLjyi4WokM/5Re/OEFTG5yqw4OIsS/UnzD8La
        6SkBM4iwD7P5XxtMHj4xEwS0N0mIuh1H4nkZC57VdqbkcS8PRT3RgbHGaq7qpyvCozOD9GczzV4Ez
        GrxjZKkOdkG4J/99CnBXomWLsMeJWf3wDZ9iWqbzlpPS/K+Mr2HGNDEzwT7htfNrzeraSxgsU1SvP
        WAfkS0Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHE40-00081s-08; Sat, 12 Sep 2020 22:32:08 +0000
Date:   Sat, 12 Sep 2020 23:32:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200912223207.GD6583@casper.infradead.org>
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 10:59:40AM -0700, Linus Torvalds wrote:
> Anyway, I don't have a great solution. I have a few options (roughly
> ordered by "simplest to most complex"):
> 
>  (a) just revert
>  (b) add some busy-spinning
>  (c) reader-writer page lock
>  (d) try to de-emphasize the page lock
> 
> Option (d) is "we already have a locking in many filesystems that give
> us exclusion between faulting in a page, and the truncate/hole punch,
> so we shouldn't use the page lock at all".
> 
> I do think that the locking that filesystems do is in many ways
> inferior - it's done on a per-inode basis rather than on a per-page
> basis. But if the filesystems end up doing that *anyway*, what's the
> advantage of the finer granularity one? And *because* the common case
> is all about the reading case, the bigger granularity tends to work
> very well in practice, and basically never sees contention.

I guess this is option (e).  Completely untested; not even compiled,
but it might be a design that means filesystems don't need to take
per-inode locks.  I probably screwed up the drop-mmap-lock-for-io
parts of filemap_fault.  I definitely didn't update DAX for the
new parameter for finish_fault(), and now I think about it, I didn't
update the header file either, so it definitely won't compile.

diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..3909613f1c9c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2602,8 +2602,22 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		}
 	}
 
+	if (fpin)
+		goto out_retry;
+	if (likely(PageUptodate(page)))
+		goto uptodate;
+
 	if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
 		goto out_retry;
+	VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
+
+	/* Did somebody else update it for us? */
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		if (fpin)
+			goto out_retry;
+		goto uptodate;
+	}
 
 	/* Did it get truncated? */
 	if (unlikely(compound_head(page)->mapping != mapping)) {
@@ -2611,14 +2625,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		put_page(page);
 		goto retry_find;
 	}
-	VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
-
-	/*
-	 * We have a locked page in the page cache, now we need to check
-	 * that it's up-to-date. If not, it is going to be due to an error.
-	 */
-	if (unlikely(!PageUptodate(page)))
-		goto page_not_uptodate;
 
 	/*
 	 * We've made it this far and we had to drop our mmap_lock, now is the
@@ -2641,10 +2647,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		return VM_FAULT_SIGBUS;
 	}
 
-	vmf->page = page;
-	return ret | VM_FAULT_LOCKED;
-
-page_not_uptodate:
 	/*
 	 * Umm, take care of errors if the page isn't up-to-date.
 	 * Try to re-read it _once_. We do this synchronously,
@@ -2680,6 +2682,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (fpin)
 		fput(fpin);
 	return ret | VM_FAULT_RETRY;
+
+uptodate:
+	vmf->page = page;
+	return ret | VM_FAULT_UPTODATE;
 }
 EXPORT_SYMBOL(filemap_fault);
 
diff --git a/mm/memory.c b/mm/memory.c
index 469af373ae76..48fb04e75a3a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3460,6 +3460,8 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 		return VM_FAULT_HWPOISON;
 	}
 
+	if (ret & VM_FAULT_UPTODATE)
+		return ret;
 	if (unlikely(!(ret & VM_FAULT_LOCKED)))
 		lock_page(vmf->page);
 	else
@@ -3684,7 +3686,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
  *
  * Return: %0 on success, %VM_FAULT_ code in case of error.
  */
-vm_fault_t finish_fault(struct vm_fault *vmf)
+vm_fault_t finish_fault(struct vm_fault *vmf, vm_fault_t ret2)
 {
 	struct page *page;
 	vm_fault_t ret = 0;
@@ -3704,9 +3706,17 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = check_stable_address_space(vmf->vma->vm_mm);
 	if (!ret)
 		ret = alloc_set_pte(vmf, page);
+	if (ret2 & VM_FAULT_UPTODATE) {
+		if (!PageUptodate(page)) {
+			/* probably other things to do here */
+			page_remove_rmap(page);
+			pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
+			put_page(page);
+		}
+	}
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-	return ret;
+	return ret | ret2;
 }
 
 static unsigned long fault_around_bytes __read_mostly =
@@ -3844,8 +3854,9 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		return ret;
 
-	ret |= finish_fault(vmf);
-	unlock_page(vmf->page);
+	ret = finish_fault(vmf, ret);
+	if (!(ret & VM_FAULT_UPTODATE))
+		unlock_page(vmf->page);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		put_page(vmf->page);
 	return ret;
@@ -3878,8 +3889,9 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
 	__SetPageUptodate(vmf->cow_page);
 
-	ret |= finish_fault(vmf);
-	unlock_page(vmf->page);
+	ret = finish_fault(vmf, ret);
+	if (!(ret & VM_FAULT_UPTODATE))
+		unlock_page(vmf->page);
 	put_page(vmf->page);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		goto uncharge_out;
@@ -3912,10 +3924,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 		}
 	}
 
-	ret |= finish_fault(vmf);
+	ret = finish_fault(vmf, ret);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
 					VM_FAULT_RETRY))) {
-		unlock_page(vmf->page);
+		if (!(ret & VM_FAULT_UPTODATE))
+			unlock_page(vmf->page);
 		put_page(vmf->page);
 		return ret;
 	}
diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..649381703f31 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -176,6 +176,7 @@ void do_invalidatepage(struct page *page, unsigned int offset,
 static void
 truncate_cleanup_page(struct address_space *mapping, struct page *page)
 {
+	ClearPageUptodate(page);
 	if (page_mapped(page)) {
 		pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
 		unmap_mapping_pages(mapping, page->index, nr, false);
@@ -738,7 +739,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 								1, false);
 				}
 			}
-			BUG_ON(page_mapped(page));
 			ret2 = do_launder_page(mapping, page);
 			if (ret2 == 0) {
 				if (!invalidate_complete_page2(mapping, page))
