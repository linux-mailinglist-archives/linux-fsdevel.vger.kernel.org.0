Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF80B3CF852
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhGTKHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237361AbhGTKGR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:06:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CF836120C;
        Tue, 20 Jul 2021 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626778015;
        bh=4f6YnMgD2RU9zg52iddrIGKgcdG3x9kyvHxgH0wPP/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWJxuVCvtttXfrkmqS8dtMizbfcc5C/RxNVIuTMN0U+87QVm/tPKxCELgnAwaFUBL
         kg40BLodTEeYi56mvWycACQWRTwAKO6fLUnxeCa+XAXSz6YyRfQRG7NydwPRkIJnEq
         O2T9ofBOZzc9aWifrOHBR2FtMMeYJU7WpepZbHPY42TthTWUUuX37MuNs3i5JtusJ+
         sBtOnJY6PNjgwj62LIqq3uSNdIeJKpHf97Yfq6pSBMsMumhCRjw61t5hISIaWjCe8r
         hUQYZwZ8TSDyQqgkEj7nWXSSVDAWpbCfn+CijVH5zvw5kFszEA2W+x1diWJccMnF6T
         Fw8IbALBvI4wg==
Date:   Tue, 20 Jul 2021 13:46:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v14 026/138] mm/writeback: Add folio_wait_stable()
Message-ID: <YPapl78Qv/Y4Lt6d@kernel.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715033704.692967-27-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:35:12AM +0100, Matthew Wilcox (Oracle) wrote:
> Move wait_for_stable_page() into the folio compatibility file.
> folio_wait_stable() avoids a call to compound_head() and is 14 bytes
> smaller than wait_for_stable_page() was.  The net text size grows by 16
> bytes as a result of this patch.  We can also remove thp_head() as this
> was the last user.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/huge_mm.h | 15 ---------------
>  include/linux/pagemap.h |  1 +
>  mm/folio-compat.c       |  6 ++++++
>  mm/page-writeback.c     | 24 ++++++++++++++----------
>  4 files changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f123e15d966e..f280f33ff223 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -250,15 +250,6 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
>  		return NULL;
>  }
>  
> -/**
> - * thp_head - Head page of a transparent huge page.
> - * @page: Any page (tail, head or regular) found in the page cache.

kerneldoc will warn about missing return description

> - */
> -static inline struct page *thp_head(struct page *page)
> -{
> -	return compound_head(page);
> -}
> -
>  /**
>   * thp_order - Order of a transparent huge page.
>   * @page: Head page of a transparent huge page.
> @@ -336,12 +327,6 @@ static inline struct list_head *page_deferred_list(struct page *page)
>  #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
>  #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
>  
> -static inline struct page *thp_head(struct page *page)
> -{
> -	VM_BUG_ON_PGFLAGS(PageTail(page), page);
> -	return page;
> -}
> -
>  static inline unsigned int thp_order(struct page *page)
>  {
>  	VM_BUG_ON_PGFLAGS(PageTail(page), page);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 0c5f53368fe9..96b62a2331fb 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -772,6 +772,7 @@ int folio_wait_writeback_killable(struct folio *folio);
>  void end_page_writeback(struct page *page);
>  void folio_end_writeback(struct folio *folio);
>  void wait_for_stable_page(struct page *page);
> +void folio_wait_stable(struct folio *folio);
>  
>  void __set_page_dirty(struct page *, struct address_space *, int warn);
>  int __set_page_dirty_nobuffers(struct page *page);
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index 41275dac7a92..3c83f03b80d7 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -29,3 +29,9 @@ void wait_on_page_writeback(struct page *page)
>  	return folio_wait_writeback(page_folio(page));
>  }
>  EXPORT_SYMBOL_GPL(wait_on_page_writeback);
> +
> +void wait_for_stable_page(struct page *page)
> +{
> +	return folio_wait_stable(page_folio(page));
> +}
> +EXPORT_SYMBOL_GPL(wait_for_stable_page);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index c2c00e1533ad..a078e9786cc4 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2877,17 +2877,21 @@ int folio_wait_writeback_killable(struct folio *folio)
>  EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
>  
>  /**
> - * wait_for_stable_page() - wait for writeback to finish, if necessary.
> - * @page:	The page to wait on.
> + * folio_wait_stable() - wait for writeback to finish, if necessary.
> + * @folio: The folio to wait on.
>   *
> - * This function determines if the given page is related to a backing device
> - * that requires page contents to be held stable during writeback.  If so, then
> - * it will wait for any pending writeback to complete.
> + * This function determines if the given folio is related to a backing
> + * device that requires folio contents to be held stable during writeback.
> + * If so, then it will wait for any pending writeback to complete.
> + *
> + * Context: Sleeps.  Must be called in process context and with
> + * no spinlocks held.  Caller should hold a reference on the folio.
> + * If the folio is not locked, writeback may start again after writeback
> + * has finished.
>   */
> -void wait_for_stable_page(struct page *page)
> +void folio_wait_stable(struct folio *folio)
>  {
> -	page = thp_head(page);
> -	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
> -		wait_on_page_writeback(page);
> +	if (folio->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
> +		folio_wait_writeback(folio);
>  }
> -EXPORT_SYMBOL_GPL(wait_for_stable_page);
> +EXPORT_SYMBOL_GPL(folio_wait_stable);
> -- 
> 2.30.2
> 
> 

-- 
Sincerely yours,
Mike.
