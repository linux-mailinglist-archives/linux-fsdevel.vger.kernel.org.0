Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8164667A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Dec 2022 02:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLHB0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 20:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHB0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:26:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD28900D5;
        Wed,  7 Dec 2022 17:26:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDA19B82144;
        Thu,  8 Dec 2022 01:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692E2C433C1;
        Thu,  8 Dec 2022 01:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670462803;
        bh=w4h8E1rUddz+mzBNAte5bv9cCRd0SRyTRAA9Do+iWsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/ohPV9MwZHrqQxBjPgAylUX9/OWK8wUbAmjSnllSWuL9w/F268nHhTJPdqm+UXnK
         xVQjr4FOPp6VuPT7WuWgpKihnO7ecRzKodBcEU5uQ3qBcNoHK/1PTIdU35ID7Pfz8/
         k1wJtkUDXn4MZQIV8mfPxXCg8qlaPyoCs6KU0jb+euz/XKnEq9boQDckirgwuaI/BJ
         L/1kmvzTJKPR5Y7gsHwXoZ/9ii8Rh8MZvjGL+dl6lKpgFfcesJWEDlEVo0OEQs6oUZ
         bEgdDCt2logJCy+AO7HUSAn6rl19IsGNqDrUzna79Y/QlZ2FujKA1dUtqNM6j1Edtq
         tgp0nj466NesA==
Date:   Wed, 7 Dec 2022 17:26:42 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, akpm@linux-foundation.org,
        allison.henderson@oracle.com
Subject: Re: [PATCH v2.2 1/8] fsdax: introduce page->share for fsdax in
 reflink mode
Message-ID: <Y5E9UgUyidulL2yp@magnolia>
References: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
 <1670381359-53-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1670381359-53-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:49:19AM +0000, Shiyang Ruan wrote:
> fsdax page is used not only when CoW, but also mapread. To make the it
> easily understood, use 'share' to indicate that the dax page is shared
> by more than one extent.  And add helper functions to use it.
> 
> Also, the flag needs to be renamed to PAGE_MAPPING_DAX_SHARED.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

Looks fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c                   | 38 ++++++++++++++++++++++----------------
>  include/linux/mm_types.h   |  5 ++++-
>  include/linux/page-flags.h |  2 +-
>  3 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 1c6867810cbd..84fadea08705 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
>  	for (pfn = dax_to_pfn(entry); \
>  			pfn < dax_end_pfn(entry); pfn++)
>  
> -static inline bool dax_mapping_is_cow(struct address_space *mapping)
> +static inline bool dax_page_is_shared(struct page *page)
>  {
> -	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
> +	return page->mapping == PAGE_MAPPING_DAX_SHARED;
>  }
>  
>  /*
> - * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
> + * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> + * refcount.
>   */
> -static inline void dax_mapping_set_cow(struct page *page)
> +static inline void dax_page_share_get(struct page *page)
>  {
> -	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
> +	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
>  		/*
>  		 * Reset the index if the page was already mapped
>  		 * regularly before.
>  		 */
>  		if (page->mapping)
> -			page->index = 1;
> -		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
> +			page->share = 1;
> +		page->mapping = PAGE_MAPPING_DAX_SHARED;
>  	}
> -	page->index++;
> +	page->share++;
> +}
> +
> +static inline unsigned long dax_page_share_put(struct page *page)
> +{
> +	return --page->share;
>  }
>  
>  /*
> - * When it is called in dax_insert_entry(), the cow flag will indicate that
> + * When it is called in dax_insert_entry(), the shared flag will indicate that
>   * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * FS_DAX_MAPPING_COW, and use page->index as refcount.
> + * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
>   */
>  static void dax_associate_entry(void *entry, struct address_space *mapping,
> -		struct vm_area_struct *vma, unsigned long address, bool cow)
> +		struct vm_area_struct *vma, unsigned long address, bool shared)
>  {
>  	unsigned long size = dax_entry_size(entry), pfn, index;
>  	int i = 0;
> @@ -374,8 +380,8 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		if (cow) {
> -			dax_mapping_set_cow(page);
> +		if (shared) {
> +			dax_page_share_get(page);
>  		} else {
>  			WARN_ON_ONCE(page->mapping);
>  			page->mapping = mapping;
> @@ -396,9 +402,9 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  		struct page *page = pfn_to_page(pfn);
>  
>  		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		if (dax_mapping_is_cow(page->mapping)) {
> -			/* keep the CoW flag if this page is still shared */
> -			if (page->index-- > 0)
> +		if (dax_page_is_shared(page)) {
> +			/* keep the shared flag if this page is still shared */
> +			if (dax_page_share_put(page) > 0)
>  				continue;
>  		} else
>  			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 500e536796ca..f46cac3657ad 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -103,7 +103,10 @@ struct page {
>  			};
>  			/* See page-flags.h for PAGE_MAPPING_FLAGS */
>  			struct address_space *mapping;
> -			pgoff_t index;		/* Our offset within mapping. */
> +			union {
> +				pgoff_t index;		/* Our offset within mapping. */
> +				unsigned long share;	/* share count for fsdax */
> +			};
>  			/**
>  			 * @private: Mapping-private opaque data.
>  			 * Usually used for buffer_heads if PagePrivate.
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 0b0ae5084e60..d8e94f2f704a 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -641,7 +641,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>   * Different with flags above, this flag is used only for fsdax mode.  It
>   * indicates that this page->mapping is now under reflink case.
>   */
> -#define PAGE_MAPPING_DAX_COW	0x1
> +#define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
>  
>  static __always_inline bool folio_mapping_flags(struct folio *folio)
>  {
> -- 
> 2.38.1
> 
