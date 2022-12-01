Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D175563F4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 17:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiLAQO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLAQOz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:14:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC6B54443;
        Thu,  1 Dec 2022 08:14:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAC3062056;
        Thu,  1 Dec 2022 16:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5C5C433C1;
        Thu,  1 Dec 2022 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669911293;
        bh=RA+oYTRjg5pJois2KzjtgaU2E3HhxewyaArdgu/qh4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHG04wr1uG6lJKID3geDq5590EAVNGQa5BbtUYJ3uN2I/iu+Mm6ylnKRwH28/G7YX
         QfuGBwTCyl1vBS8bZD7EXBvSujfrEKzMD8DRtEuRsIjY6gE07nhs2S0gkbjIiS2gmz
         Y6Ged32jEWtITYeUAwZWHyF/0AFgc0no/Ac9cNIgeJmKg7uYJG7cMLgacWAEtui60B
         W6MGnz/A8+XZKQ3zwWLrchrv8AtkHdF325qqXiLjtIyU2SCa+qwPgm3Oy3iqtEXiZ/
         m8e57TxoG7P41iCRCwgjy/d47Le65e31WloOgK2Wj2R+wkBD/7echONk/PHVKk9jd+
         7lKpQcltG6ZJg==
Date:   Thu, 1 Dec 2022 08:14:52 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/8] fsdax: introduce page->share for fsdax in reflink
 mode
Message-ID: <Y4jS/F7VH3zKdsBi@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669908538-55-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:28:51PM +0000, Shiyang Ruan wrote:
> fsdax page is used not only when CoW, but also mapread. To make the it
> easily understood, use 'share' to indicate that the dax page is shared
> by more than one extent.  And add helper functions to use it.
> 
> Also, the flag needs to be renamed to PAGE_MAPPING_DAX_SHARED.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c                   | 38 ++++++++++++++++++++++----------------
>  include/linux/mm_types.h   |  5 ++++-
>  include/linux/page-flags.h |  2 +-
>  3 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 1c6867810cbd..85b81963ea31 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -334,35 +334,41 @@ static unsigned long dax_end_pfn(void *entry)
>  	for (pfn = dax_to_pfn(entry); \
>  			pfn < dax_end_pfn(entry); pfn++)
>  
> -static inline bool dax_mapping_is_cow(struct address_space *mapping)
> +static inline bool dax_mapping_is_shared(struct page *page)

dax_page_is_shared?

>  {
> -	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
> +	return (unsigned long)page->mapping == PAGE_MAPPING_DAX_SHARED;
>  }
>  
>  /*
> - * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
> + * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> + * refcount.
>   */
> -static inline void dax_mapping_set_cow(struct page *page)
> +static inline void dax_mapping_set_shared(struct page *page)

It's odd that a function of a struct page still has 'mapping' in the
name.

dax_page_increase_shared?

or perhaps simply

dax_page_bump_sharing and dax_page_drop_sharing?

Otherwise this mechanical change looks pretty straightforward.

--D

>  {
> -	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
> +	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_SHARED) {
>  		/*
>  		 * Reset the index if the page was already mapped
>  		 * regularly before.
>  		 */
>  		if (page->mapping)
> -			page->index = 1;
> -		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
> +			page->share = 1;
> +		page->mapping = (void *)PAGE_MAPPING_DAX_SHARED;
>  	}
> -	page->index++;
> +	page->share++;
> +}
> +
> +static inline unsigned long dax_mapping_decrease_shared(struct page *page)
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
> +			dax_mapping_set_shared(page);
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
> +		if (dax_mapping_is_shared(page)) {
> +			/* keep the shared flag if this page is still shared */
> +			if (dax_mapping_decrease_shared(page) > 0)
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
> index 0b0ae5084e60..c8a3aa02278d 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -641,7 +641,7 @@ PAGEFLAG_FALSE(VmemmapSelfHosted, vmemmap_self_hosted)
>   * Different with flags above, this flag is used only for fsdax mode.  It
>   * indicates that this page->mapping is now under reflink case.
>   */
> -#define PAGE_MAPPING_DAX_COW	0x1
> +#define PAGE_MAPPING_DAX_SHARED	0x1
>  
>  static __always_inline bool folio_mapping_flags(struct folio *folio)
>  {
> -- 
> 2.38.1
> 
