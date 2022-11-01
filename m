Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E161615191
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 19:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKASb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKASb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:31:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E41ADBF;
        Tue,  1 Nov 2022 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qBLHlADSVQYJJAga91iK1vdxN6g7v8WADT/OUBV0m2g=; b=P7B1fXOBgO5orKrJzyAqbLXIWM
        Y3WxBfOUknWBjVH+BTs4EVlsA/evht7/yQD58hs0nkXI8buVJycbOPp98xA7ksc2bie+XT5CYPSaJ
        I91PNt5SN1Pk3Dt/fPTREPNTcInb4T2WAuS1BKvpTUBhhn9YKa9ZCZ+gxm6STPBzQFuElnLgSyVij
        3tKq0aREX7WIT+iilF9dtzB+IZoH4t4n1HY9jf7JQLuFHVHy/oCJvhN1+wXRBZQ/93ve1HhfBCAgx
        xa6s8zrc4XpoFWcDFJbYIV8YLFQv2fFNm3VT8mI8bNHJDuC3nRc5IiUJn9qShKyEhJZGCJ7dU/chR
        xwT9FJwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opw2o-004pvT-Ez; Tue, 01 Nov 2022 18:31:26 +0000
Date:   Tue, 1 Nov 2022 18:31:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
Message-ID: <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101175326.13265-4-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:53:24AM -0700, Vishal Moola (Oracle) wrote:
> Replaces lru_cache_add() and lru_cache_add_inactive_or_unevictable()
> with folio_add_lru() and folio_add_lru_vma(). This is in preparation for
> the removal of lru_cache_add().

Ummmmm.  Reviewing this patch reveals a bug (not introduced by your
patch).  Look:

mfill_atomic_install_pte:
        bool page_in_cache = page->mapping;

mcontinue_atomic_pte:
        ret = shmem_get_folio(inode, pgoff, &folio, SGP_NOALLOC);
...
        page = folio_file_page(folio, pgoff);
        ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
                                       page, false, wp_copy);

That says pretty plainly that mfill_atomic_install_pte() can be passed
a tail page from shmem, and if it is ...

        if (page_in_cache) {
...
        } else {
                page_add_new_anon_rmap(page, dst_vma, dst_addr);
                lru_cache_add_inactive_or_unevictable(page, dst_vma);
        }

it'll get put on the rmap as an anon page!

> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  mm/userfaultfd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e24e8a47ce8a..2560973b00d8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -66,6 +66,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	bool page_in_cache = page->mapping;
>  	spinlock_t *ptl;
> +	struct folio *folio;
>  	struct inode *inode;
>  	pgoff_t offset, max_off;
>  
> @@ -113,14 +114,15 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	if (!pte_none_mostly(*dst_pte))
>  		goto out_unlock;
>  
> +	folio = page_folio(page);
>  	if (page_in_cache) {
>  		/* Usually, cache pages are already added to LRU */
>  		if (newly_allocated)
> -			lru_cache_add(page);
> +			folio_add_lru(folio);
>  		page_add_file_rmap(page, dst_vma, false);
>  	} else {
>  		page_add_new_anon_rmap(page, dst_vma, dst_addr);
> -		lru_cache_add_inactive_or_unevictable(page, dst_vma);
> +		folio_add_lru_vma(folio, dst_vma);
>  	}
>  
>  	/*
> -- 
> 2.38.1
> 
> 
