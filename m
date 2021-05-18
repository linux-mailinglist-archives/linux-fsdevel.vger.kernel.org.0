Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6140F3876AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 12:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242722AbhERKkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 06:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:49820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242136AbhERKkG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 06:40:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48F38AF37;
        Tue, 18 May 2021 10:38:47 +0000 (UTC)
Subject: Re: [PATCH v10 22/33] mm/filemap: Add __folio_lock_or_retry
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-23-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <76184de4-4ab9-0f04-ab37-8637f4b22566@suse.cz>
Date:   Tue, 18 May 2021 12:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-23-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> Convert __lock_page_or_retry() to __folio_lock_or_retry().  This actually
> saves 4 bytes in the only caller of lock_page_or_retry() (due to better
> register allocation) and saves the 20 byte cost of calling page_folio()
> in __folio_lock_or_retry() for a total saving of 24 bytes.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/pagemap.h |  9 ++++++---
>  mm/filemap.c            | 10 ++++------
>  mm/memory.c             |  8 ++++----
>  3 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 41224e4ca8cc..21e394964288 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -640,7 +640,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
>  
>  void __folio_lock(struct folio *folio);
>  int __folio_lock_killable(struct folio *folio);
> -extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
> +int __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>  				unsigned int flags);
>  void unlock_page(struct page *page);
>  void folio_unlock(struct folio *folio);
> @@ -701,13 +701,16 @@ static inline int lock_page_killable(struct page *page)
>   * caller indicated that it can handle a retry.
>   *
>   * Return value and mmap_lock implications depend on flags; see
> - * __lock_page_or_retry().
> + * __folio_lock_or_retry().
>   */
>  static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
>  				     unsigned int flags)
>  {
> +	struct folio *folio;
>  	might_sleep();
> -	return trylock_page(page) || __lock_page_or_retry(page, mm, flags);
> +
> +	folio = page_folio(page);
> +	return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
>  }
>  
>  /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 67334eb3fd94..28bf50041671 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1623,20 +1623,18 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
>  
>  /*
>   * Return values:
> - * 1 - page is locked; mmap_lock is still held.
> - * 0 - page is not locked.
> + * 1 - folio is locked; mmap_lock is still held.
> + * 0 - folio is not locked.
>   *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
>   *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
>   *     which case mmap_lock is still held.
>   *
>   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 1
> - * with the page locked and the mmap_lock unperturbed.
> + * with the folio locked and the mmap_lock unperturbed.
>   */
> -int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
> +int __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
>  			 unsigned int flags)
>  {
> -	struct folio *folio = page_folio(page);
> -
>  	if (fault_flag_allow_retry_first(flags)) {
>  		/*
>  		 * CAUTION! In this case, mmap_lock is not released

A bit later in this branch, 'page' is accessed, but it no longer exists. And
thus as expected, it doesn't compile. Assuming it's fixed later, but
bisectability etc...

> diff --git a/mm/memory.c b/mm/memory.c
> index 86ba6c1f6821..fc3f50d0702c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4065,7 +4065,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>   * We enter with non-exclusive mmap_lock (to exclude vma changes,
>   * but allow concurrent faults).
>   * The mmap_lock may have been released depending on flags and our
> - * return value.  See filemap_fault() and __lock_page_or_retry().
> + * return value.  See filemap_fault() and __folio_lock_or_retry().
>   * If mmap_lock is released, vma may become invalid (for example
>   * by other thread calling munmap()).
>   */
> @@ -4307,7 +4307,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
>   * concurrent faults).
>   *
>   * The mmap_lock may have been released depending on flags and our return value.
> - * See filemap_fault() and __lock_page_or_retry().
> + * See filemap_fault() and __folio_lock_or_retry().
>   */
>  static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  {
> @@ -4411,7 +4411,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>   * By the time we get here, we already hold the mm semaphore
>   *
>   * The mmap_lock may have been released depending on flags and our
> - * return value.  See filemap_fault() and __lock_page_or_retry().
> + * return value.  See filemap_fault() and __folio_lock_or_retry().
>   */
>  static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		unsigned long address, unsigned int flags)
> @@ -4567,7 +4567,7 @@ static inline void mm_account_fault(struct pt_regs *regs,
>   * By the time we get here, we already hold the mm semaphore
>   *
>   * The mmap_lock may have been released depending on flags and our
> - * return value.  See filemap_fault() and __lock_page_or_retry().
> + * return value.  See filemap_fault() and __folio_lock_or_retry().
>   */
>  vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>  			   unsigned int flags, struct pt_regs *regs)
> 

