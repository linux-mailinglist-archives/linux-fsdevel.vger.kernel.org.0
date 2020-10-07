Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAA285A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 10:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgJGIZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 04:25:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:52014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgJGIZX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:25:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 96FFBABD1;
        Wed,  7 Oct 2020 08:25:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E96721E1305; Wed,  7 Oct 2020 10:25:17 +0200 (CEST)
Date:   Wed, 7 Oct 2020 10:25:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ext4/xfs: add page refcount helper
Message-ID: <20201007082517.GC6984@quack2.suse.cz>
References: <20201006230930.3908-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006230930.3908-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 06-10-20 16:09:30, Ralph Campbell wrote:
> There are several places where ZONE_DEVICE struct pages assume a reference
> count == 1 means the page is idle and free. Instead of open coding this,
> add a helper function to hide this detail.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks as sane direction but if we are going to abstract checks when
ZONE_DEVICE page is idle, we should also update e.g.
mm/swap.c:put_devmap_managed_page() or
mm/gup.c:__unpin_devmap_managed_user_page() (there may be more places like
this but I found at least these two...). Maybe Dan has more thoughts about
this.

								Honza

> diff --git a/fs/dax.c b/fs/dax.c
> index 5b47834f2e1b..85c63f735909 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -358,7 +358,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> +		WARN_ON_ONCE(trunc && !dax_layout_is_idle_page(page));
>  		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
>  		page->mapping = NULL;
>  		page->index = 0;
> @@ -372,7 +372,7 @@ static struct page *dax_busy_page(void *entry)
>  	for_each_mapped_pfn(entry, pfn) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		if (page_ref_count(page) > 1)
> +		if (!dax_layout_is_idle_page(page))
>  			return page;
>  	}
>  	return NULL;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 771ed8b1fadb..132620cbfa13 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3937,10 +3937,7 @@ int ext4_break_layouts(struct inode *inode)
>  		if (!page)
>  			return 0;
>  
> -		error = ___wait_var_event(&page->_refcount,
> -				atomic_read(&page->_refcount) == 1,
> -				TASK_INTERRUPTIBLE, 0, 0,
> -				ext4_wait_dax_page(ei));
> +		error = dax_wait_page(ei, page, ext4_wait_dax_page);
>  	} while (error == 0);
>  
>  	return error;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 3d1b95124744..a5304aaeaa3a 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -749,9 +749,7 @@ xfs_break_dax_layouts(
>  		return 0;
>  
>  	*retry = true;
> -	return ___wait_var_event(&page->_refcount,
> -			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
> -			0, 0, xfs_wait_dax_page(inode));
> +	return dax_wait_page(inode, page, xfs_wait_dax_page);
>  }
>  
>  int
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..8909a91cd381 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -243,6 +243,16 @@ static inline bool dax_mapping(struct address_space *mapping)
>  	return mapping->host && IS_DAX(mapping->host);
>  }
>  
> +static inline bool dax_layout_is_idle_page(struct page *page)
> +{
> +	return page_ref_count(page) == 1;
> +}
> +
> +#define dax_wait_page(_inode, _page, _wait_cb)				\
> +	___wait_var_event(&(_page)->_refcount,				\
> +		dax_layout_is_idle_page(_page),				\
> +		TASK_INTERRUPTIBLE, 0, 0, _wait_cb(_inode))
> +
>  #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>  void hmem_register_device(int target_nid, struct resource *r);
>  #else
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
