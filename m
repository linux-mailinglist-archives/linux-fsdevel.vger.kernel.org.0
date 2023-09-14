Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76077A0C44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 20:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbjINSLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINSLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:11:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638971BDC;
        Thu, 14 Sep 2023 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ORBqcLA5UYGcOpCfudEExpJWN0m+G42/NaIXhLRFNIk=; b=s7gjWgZw5yP97NiIINyAWtd3AG
        GHo1vA2AlAzS0Mc0j9pOSWHEGUU46zIIAIFGcOhVOdWBBszSMn15utpeZnUU3oPBKIsf0MYjgb5Rd
        /gMOXVQA/L9ADMn5aLhzOWXafiojZ20V7+4wvBaw+6C2oSjcuqwDViZ4diIJdXKcnTGSYHMAnd22W
        yu8AqZISvEm3xMvW0mB1hPHmxXOfTY1eLB0xA0mlxsWaMXkrPeIdjM69HaX3lZ2JfUNY3gra5xMbg
        KhdIUnuDBb2XF8yGYmxtZcfTEMDrj9XHWlRwC1pbuZzilsScTno/IGcfNe7BhcBjBh+zpQmQO4QSd
        hTgNOSFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgqoH-004PI8-7U; Thu, 14 Sep 2023 18:11:25 +0000
Date:   Thu, 14 Sep 2023 19:11:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
Message-ID: <ZQNMze6SXdIm13CW@casper.infradead.org>
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914152620.2743033-3-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:26:12AM -0700, Suren Baghdasaryan wrote:
> +++ b/include/linux/userfaultfd_k.h
> @@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
>  extern long uffd_wp_range(struct vm_area_struct *vma,
>  			  unsigned long start, unsigned long len, bool enable_wp);
>  
> +/* remap_pages */
> +extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> +extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> +extern ssize_t remap_pages(struct mm_struct *dst_mm,
> +			   struct mm_struct *src_mm,
> +			   unsigned long dst_start,
> +			   unsigned long src_start,
> +			   unsigned long len, __u64 flags);
> +extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> +				struct mm_struct *src_mm,
> +				pmd_t *dst_pmd, pmd_t *src_pmd,
> +				pmd_t dst_pmdval,
> +				struct vm_area_struct *dst_vma,
> +				struct vm_area_struct *src_vma,
> +				unsigned long dst_addr,
> +				unsigned long src_addr);

Drop the 'extern' markers from function declarations.

> +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> +			 struct mm_struct *src_mm,
> +			 pmd_t *dst_pmd, pmd_t *src_pmd,
> +			 pmd_t dst_pmdval,
> +			 struct vm_area_struct *dst_vma,
> +			 struct vm_area_struct *src_vma,
> +			 unsigned long dst_addr,
> +			 unsigned long src_addr)
> +{
> +	pmd_t _dst_pmd, src_pmdval;
> +	struct page *src_page;
> +	struct anon_vma *src_anon_vma, *dst_anon_vma;
> +	spinlock_t *src_ptl, *dst_ptl;
> +	pgtable_t pgtable;
> +	struct mmu_notifier_range range;
> +
> +	src_pmdval = *src_pmd;
> +	src_ptl = pmd_lockptr(src_mm, src_pmd);
> +
> +	BUG_ON(!pmd_trans_huge(src_pmdval));
> +	BUG_ON(!pmd_none(dst_pmdval));
> +	BUG_ON(!spin_is_locked(src_ptl));
> +	mmap_assert_locked(src_mm);
> +	mmap_assert_locked(dst_mm);
> +	BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> +	BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> +
> +	src_page = pmd_page(src_pmdval);
> +	BUG_ON(!PageHead(src_page));
> +	BUG_ON(!PageAnon(src_page));

Better to add a src_folio = page_folio(src_page);
and then folio_test_anon() here.

> +	if (unlikely(page_mapcount(src_page) != 1)) {

Brr, this is going to miss PTE mappings of this folio.  I think you
actually want folio_mapcount() instead, although it'd be more efficient
to look at folio->_entire_mapcount == 1 and _nr_pages_mapped == 0.
Not wure what a good name for that predicate would be.

> +	get_page(src_page);

folio_get()

> +	/* block all concurrent rmap walks */
> +	lock_page(src_page);

folio_lock()

> +	/*
> +	 * split_huge_page walks the anon_vma chain without the page
> +	 * lock. Serialize against it with the anon_vma lock, the page
> +	 * lock is not enough.
> +	 */
> +	src_anon_vma = folio_get_anon_vma(page_folio(src_page));

...

> +	if (!src_anon_vma) {
> +		unlock_page(src_page);

folio_unlock()

> +		put_page(src_page);

folio_put()

> +	if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
> +		     !pmd_same(*dst_pmd, dst_pmdval) ||
> +		     page_mapcount(src_page) != 1)) {

similar folio_total_mapcount()

> +		double_pt_unlock(src_ptl, dst_ptl);
> +		anon_vma_unlock_write(src_anon_vma);
> +		put_anon_vma(src_anon_vma);
> +		unlock_page(src_page);
> +		put_page(src_page);

...

> +	BUG_ON(!PageHead(src_page));
> +	BUG_ON(!PageAnon(src_page));
> +	/* the PT lock is enough to keep the page pinned now */
> +	put_page(src_page);

...

> +	dst_anon_vma = (void *) dst_vma->anon_vma + PAGE_MAPPING_ANON;
> +	WRITE_ONCE(src_page->mapping, (struct address_space *) dst_anon_vma);
> +	WRITE_ONCE(src_page->index, linear_page_index(dst_vma, dst_addr));

Definitely want to use the folio here.

> +	/* unblock rmap walks */
> +	unlock_page(src_page);

...

> +static int remap_pages_pte(struct mm_struct *dst_mm,
> +			   struct mm_struct *src_mm,
> +			   pmd_t *dst_pmd,
> +			   pmd_t *src_pmd,
> +			   struct vm_area_struct *dst_vma,
> +			   struct vm_area_struct *src_vma,
> +			   unsigned long dst_addr,
> +			   unsigned long src_addr,
> +			   __u64 mode)
> +{
> +	swp_entry_t entry;
> +	pte_t orig_src_pte, orig_dst_pte;
> +	spinlock_t *src_ptl, *dst_ptl;
> +	pte_t *src_pte = NULL;
> +	pte_t *dst_pte = NULL;
> +
> +	struct folio *src_folio = NULL;
> +	struct anon_vma *src_anon_vma = NULL;
> +	struct anon_vma *dst_anon_vma;
> +	struct mmu_notifier_range range;
> +	int err = 0;
> +
> +retry:
> +	dst_pte = pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &dst_ptl);
> +
> +	/* If an huge pmd materialized from under us fail */
> +	if (unlikely(!dst_pte)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	src_pte = pte_offset_map_nolock(src_mm, src_pmd, src_addr, &src_ptl);
> +
> +	/*
> +	 * We held the mmap_lock for reading so MADV_DONTNEED
> +	 * can zap transparent huge pages under us, or the
> +	 * transparent huge page fault can establish new
> +	 * transparent huge pages under us.
> +	 */
> +	if (unlikely(!src_pte)) {
> +		err = -EFAULT;
> +		goto out;
> +	}
> +
> +	BUG_ON(pmd_none(*dst_pmd));
> +	BUG_ON(pmd_none(*src_pmd));
> +	BUG_ON(pmd_trans_huge(*dst_pmd));
> +	BUG_ON(pmd_trans_huge(*src_pmd));
> +
> +	spin_lock(dst_ptl);
> +	orig_dst_pte = *dst_pte;
> +	spin_unlock(dst_ptl);
> +	if (!pte_none(orig_dst_pte)) {
> +		err = -EEXIST;
> +		goto out;
> +	}
> +
> +	spin_lock(src_ptl);
> +	orig_src_pte = *src_pte;
> +	spin_unlock(src_ptl);
> +	if (pte_none(orig_src_pte)) {
> +		if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES))
> +			err = -ENOENT;
> +		else /* nothing to do to remap a hole */
> +			err = 0;
> +		goto out;
> +	}
> +
> +	if (pte_present(orig_src_pte)) {
> +		if (!src_folio) {
> +			struct folio *folio;
> +
> +			/*
> +			 * Pin the page while holding the lock to be sure the
> +			 * page isn't freed under us
> +			 */
> +			spin_lock(src_ptl);
> +			if (!pte_same(orig_src_pte, *src_pte)) {
> +				spin_unlock(src_ptl);
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +
> +			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
> +			if (!folio || !folio_test_anon(folio) ||
> +			    folio_estimated_sharers(folio) != 1) {

I wonder if we also want to fail if folio_test_large()?  While we don't
have large anon folios today, it seems to me that trying to migrate one
of them like this is just not going to work.

