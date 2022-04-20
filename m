Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF891508E91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 19:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381217AbiDTRij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 13:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381214AbiDTRie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:38:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C851EC74;
        Wed, 20 Apr 2022 10:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B8B3CE1F59;
        Wed, 20 Apr 2022 17:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A180EC385A1;
        Wed, 20 Apr 2022 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650476144;
        bh=ljESuRoLb1/++hDFndJum//OyZ+DqpARLA7sSB7A75s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anTnL4/aDGAaDm/5uqTOlNi2FZv5zZzBdQPr76oPUpGOFAuxmvRgG0j01u2X/Rao3
         727v94LeraJ4ybEyWEROZH686/CIutSW83FpjbPQ/5+WMENa2Gx6HolKrJGRVqZV43
         rcQwVFboOBEqi5UR0FFoonZDXKA9sOsD2hDv0X/jNnwsu7W5o5onIxZLatp4F+zdAX
         kicZYw2z6wdOxTYOpDTeX6Vrs0lMSgSv0J9cVFpl4mnm4En6UjFp9NaJEUOcYcSVnd
         BXPMncnUXwpQ4Q1EUycKFiHeAPMk59lXSJcuQ4Dn0dzaPaCLCLvM3CeGhOkPWrpv7r
         eCiLgZSYyfRFw==
Date:   Wed, 20 Apr 2022 10:35:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v13 7/7] fsdax: set a CoW flag when associate reflink
 mappings
Message-ID: <20220420173544.GU17025@magnolia>
References: <20220419045045.1664996-1-ruansy.fnst@fujitsu.com>
 <20220419045045.1664996-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419045045.1664996-8-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 12:50:45PM +0800, Shiyang Ruan wrote:
> Introduce a PAGE_MAPPING_DAX_COW flag to support association with CoW file
> mappings.  In this case, since the dax-rmap has already took the
> responsibility to look up for shared files by given dax page,
> the page->mapping is no longer to used for rmap but for marking that
> this dax page is shared.  And to make sure disassociation works fine, we
> use page->index as refcount, and clear page->mapping to the initial
> state when page->index is decreased to 0.
> 
> With the help of this new flag, it is able to distinguish normal case
> and CoW case, and keep the warning in normal case.
> 
> ==
> PS: The @cow added for dax_associate_entry(), is used to let it know
> whether the entry is to be shared during iomap operation.  It is decided
> by iomap,srcmap's flag, and will be used in another patchset(
> fsdax,xfs: Add reflink&dedupe support for fsdax[1]).
> 
> In this patch, we set @cow always false for now.
> 
> [1] https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/
> ==
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c                   | 50 +++++++++++++++++++++++++++++++-------
>  include/linux/page-flags.h |  6 +++++
>  2 files changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 57efd3f73655..4d3dfc8bee33 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -334,13 +334,35 @@ static unsigned long dax_end_pfn(void *entry)
>  	for (pfn = dax_to_pfn(entry); \
>  			pfn < dax_end_pfn(entry); pfn++)
>  
> +static inline bool dax_mapping_is_cow(struct address_space *mapping)
> +{
> +	return (unsigned long)mapping == PAGE_MAPPING_DAX_COW;
> +}
> +
>  /*
> - * TODO: for reflink+dax we need a way to associate a single page with
> - * multiple address_space instances at different linear_page_index()
> - * offsets.
> + * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
> + */
> +static inline void dax_mapping_set_cow(struct page *page)
> +{
> +	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
> +		/*
> +		 * Reset the index if the page was already mapped
> +		 * regularly before.
> +		 */
> +		if (page->mapping)
> +			page->index = 1;
> +		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
> +	}
> +	page->index++;
> +}
> +
> +/*
> + * When it is called in dax_insert_entry(), the cow flag will indicate that
> + * whether this entry is shared by multiple files.  If so, set the page->mapping
> + * FS_DAX_MAPPING_COW, and use page->index as refcount.
>   */
>  static void dax_associate_entry(void *entry, struct address_space *mapping,
> -		struct vm_area_struct *vma, unsigned long address)
> +		struct vm_area_struct *vma, unsigned long address, bool cow)
>  {
>  	unsigned long size = dax_entry_size(entry), pfn, index;
>  	int i = 0;
> @@ -352,9 +374,13 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		WARN_ON_ONCE(page->mapping);
> -		page->mapping = mapping;
> -		page->index = index + i++;
> +		if (cow) {
> +			dax_mapping_set_cow(page);
> +		} else {
> +			WARN_ON_ONCE(page->mapping);
> +			page->mapping = mapping;
> +			page->index = index + i++;
> +		}
>  	}
>  }
>  
> @@ -370,7 +396,12 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  		struct page *page = pfn_to_page(pfn);
>  
>  		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> +		if (dax_mapping_is_cow(page->mapping)) {
> +			/* keep the CoW flag if this page is still shared */
> +			if (page->index-- > 0)
> +				continue;
> +		} else
> +			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>  		page->mapping = NULL;
>  		page->index = 0;
>  	}
> @@ -829,7 +860,8 @@ static void *dax_insert_entry(struct xa_state *xas,
>  		void *old;
>  
>  		dax_disassociate_entry(entry, mapping, false);
> -		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
> +		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
> +				false);
>  		/*
>  		 * Only swap our new entry into the page cache if the current
>  		 * entry is a zero page or an empty entry.  If a normal PTE or
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index d725a2d17806..5b601e375773 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -650,6 +650,12 @@ __PAGEFLAG(Reported, reported, PF_NO_COMPOUND)
>  #define PAGE_MAPPING_KSM	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
>  #define PAGE_MAPPING_FLAGS	(PAGE_MAPPING_ANON | PAGE_MAPPING_MOVABLE)
>  
> +/*
> + * Different with flags above, this flag is used only for fsdax mode.  It
> + * indicates that this page->mapping is now under reflink case.
> + */
> +#define PAGE_MAPPING_DAX_COW	0x1

The logic looks sound enough, I guess.

Though I do wonder -- if this were defined like this:

#define PAGE_MAPPING_DAX_COW	((struct address_space *)0x1)

Could you then avoid all uintptr_t/unsigned long casts above?

It's probably not worth holding up the whole patchset though, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  static __always_inline int PageMappingFlags(struct page *page)
>  {
>  	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) != 0;
> -- 
> 2.35.1
> 
> 
> 
