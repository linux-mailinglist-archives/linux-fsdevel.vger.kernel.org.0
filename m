Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC5246D5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 18:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbgHQQy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 12:54:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:42596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389113AbgHQQxr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:53:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07A5DAE25;
        Mon, 17 Aug 2020 16:54:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 86E271E12CB; Mon, 17 Aug 2020 18:53:39 +0200 (CEST)
Date:   Mon, 17 Aug 2020 18:53:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 02/20] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200817165339.GA22500@quack2.suse.cz>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-3-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 07-08-20 15:55:08, Vivek Goyal wrote:
> virtiofs device has a range of memory which is mapped into file inodes
> using dax. This memory is mapped in qemu on host and maps different
> sections of real file on host. Size of this memory is limited
> (determined by administrator) and depending on filesystem size, we will
> soon reach a situation where all the memory is in use and we need to
> reclaim some.
> 
> As part of reclaim process, we will need to make sure that there are
> no active references to pages (taken by get_user_pages()) on the memory
> range we are trying to reclaim. I am planning to use
> dax_layout_busy_page() for this. But in current form this is per inode
> and scans through all the pages of the inode.
> 
> We want to reclaim only a portion of memory (say 2MB page). So we want
> to make sure that only that 2MB range of pages do not have any
> references  (and don't want to unmap all the pages of inode).
> 
> Hence, create a range version of this function named
> dax_layout_busy_page_range() which can be used to pass a range which
> needs to be unmapped.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-nvdimm@lists.01.org
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

The API looks OK. Some comments WRT the implementation below.

> diff --git a/fs/dax.c b/fs/dax.c
> index 11b16729b86f..0d51b0fbb489 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -558,27 +558,20 @@ static void *grab_mapping_entry(struct xa_state *xas,
>  	return xa_mk_internal(VM_FAULT_FALLBACK);
>  }
>  
> -/**
> - * dax_layout_busy_page - find first pinned page in @mapping
> - * @mapping: address space to scan for a page with ref count > 1
> - *
> - * DAX requires ZONE_DEVICE mapped pages. These pages are never
> - * 'onlined' to the page allocator so they are considered idle when
> - * page->count == 1. A filesystem uses this interface to determine if
> - * any page in the mapping is busy, i.e. for DMA, or other
> - * get_user_pages() usages.
> - *
> - * It is expected that the filesystem is holding locks to block the
> - * establishment of new mappings in this address_space. I.e. it expects
> - * to be able to run unmap_mapping_range() and subsequently not race
> - * mapping_mapped() becoming true.
> +/*
> + * Partial pages are included. If end is LLONG_MAX, pages in the range from
> + * start to end of the file are inluded.
>   */

I think the big kerneldoc comment should stay with
dax_layout_busy_page_range() since dax_layout_busy_page() will be just a
trivial wrapper around it..

> -struct page *dax_layout_busy_page(struct address_space *mapping)
> +struct page *dax_layout_busy_page_range(struct address_space *mapping,
> +					loff_t start, loff_t end)
>  {
> -	XA_STATE(xas, &mapping->i_pages, 0);
>  	void *entry;
>  	unsigned int scanned = 0;
>  	struct page *page = NULL;
> +	pgoff_t start_idx = start >> PAGE_SHIFT;
> +	pgoff_t end_idx = end >> PAGE_SHIFT;
> +	XA_STATE(xas, &mapping->i_pages, start_idx);
> +	loff_t len, lstart = round_down(start, PAGE_SIZE);
>  
>  	/*
>  	 * In the 'limited' case get_user_pages() for dax is disabled.
> @@ -589,6 +582,22 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
>  		return NULL;
>  
> +	/* If end == LLONG_MAX, all pages from start to till end of file */
> +	if (end == LLONG_MAX) {
> +		end_idx = ULONG_MAX;
> +		len = 0;
> +	} else {
> +		/* length is being calculated from lstart and not start.
> +		 * This is due to behavior of unmap_mapping_range(). If
> +		 * start is say 4094 and end is on 4096 then we want to
> +		 * unamp two pages, idx 0 and 1. But unmap_mapping_range()
> +		 * will unmap only page at idx 0. If we calculate len
> +		 * from the rounded down start, this problem should not
> +		 * happen.
> +		 */
> +		len = end - lstart + 1;
> +	}

Maybe it would be more understandable to use
	unmap_mapping_pages(mapping, start_idx, end_idx - start_idx + 1);
below and avoid all this rounding and special-casing.

> +
>  	/*
>  	 * If we race get_user_pages_fast() here either we'll see the
>  	 * elevated page count in the iteration and wait, or
> @@ -601,10 +610,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	 * guaranteed to either see new references or prevent new
>  	 * references from being established.
>  	 */
> -	unmap_mapping_range(mapping, 0, 0, 0);
> +	unmap_mapping_range(mapping, start, len, 0);
>  
>  	xas_lock_irq(&xas);
> -	xas_for_each(&xas, entry, ULONG_MAX) {
> +	xas_for_each(&xas, entry, end_idx) {
>  		if (WARN_ON_ONCE(!xa_is_value(entry)))
>  			continue;
>  		if (unlikely(dax_is_locked(entry)))
> @@ -625,6 +634,27 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	xas_unlock_irq(&xas);
>  	return page;
>  }
> +EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
> +
> +/**
> + * dax_layout_busy_page - find first pinned page in @mapping
> + * @mapping: address space to scan for a page with ref count > 1
> + *
> + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> + * 'onlined' to the page allocator so they are considered idle when
> + * page->count == 1. A filesystem uses this interface to determine if
> + * any page in the mapping is busy, i.e. for DMA, or other
> + * get_user_pages() usages.
> + *
> + * It is expected that the filesystem is holding locks to block the
> + * establishment of new mappings in this address_space. I.e. it expects
> + * to be able to run unmap_mapping_range() and subsequently not race
> + * mapping_mapped() becoming true.
> + */
> +struct page *dax_layout_busy_page(struct address_space *mapping)
> +{
> +	return dax_layout_busy_page_range(mapping, 0, 0);

Should the 'end' rather be LLONG_MAX?

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
