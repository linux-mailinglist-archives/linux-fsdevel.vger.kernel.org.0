Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C438287128
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgJHJBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 05:01:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:32886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgJHJBh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:01:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3232EAC3C;
        Thu,  8 Oct 2020 09:01:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD5DA1E1305; Thu,  8 Oct 2020 11:01:35 +0200 (CEST)
Date:   Thu, 8 Oct 2020 11:01:35 +0200
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
Subject: Re: [PATCH v2] ext4/xfs: add page refcount helper
Message-ID: <20201008090135.GA3486@quack2.suse.cz>
References: <20201007214925.11181-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007214925.11181-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-10-20 14:49:25, Ralph Campbell wrote:
> There are several places where ZONE_DEVICE struct pages assume a reference
> count == 1 means the page is idle and free. Instead of open coding this,
> add helper functions to hide this detail.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
> Acked-by: Theodore Ts'o <tytso@mit.edu> # for fs/ext4/inode.c

The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Changes in v2:
> I strongly resisted the idea of extending this patch but after Jan
> Kara's comment about there being more places that could be cleaned
> up, I felt compelled to make this one tensy wensy change to add
> a dax_wakeup_page() to match the dax_wait_page().
> I kept the Reviewed/Acked-bys since I don't think this substantially
> changes the patch.
> 
>  fs/dax.c            |  4 ++--
>  fs/ext4/inode.c     |  5 +----
>  fs/xfs/xfs_file.c   |  4 +---
>  include/linux/dax.h | 15 +++++++++++++++
>  mm/memremap.c       |  3 ++-
>  5 files changed, 21 insertions(+), 10 deletions(-)
> 
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
> index b52f084aa643..e2da78e87338 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -243,6 +243,21 @@ static inline bool dax_mapping(struct address_space *mapping)
>  	return mapping->host && IS_DAX(mapping->host);
>  }
>  
> +static inline bool dax_layout_is_idle_page(struct page *page)
> +{
> +	return page_ref_count(page) == 1;
> +}
> +
> +static inline void dax_wakeup_page(struct page *page)
> +{
> +	wake_up_var(&page->_refcount);
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
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 2bb276680837..504a10ff2edf 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -12,6 +12,7 @@
>  #include <linux/types.h>
>  #include <linux/wait_bit.h>
>  #include <linux/xarray.h>
> +#include <linux/dax.h>
>  
>  static DEFINE_XARRAY(pgmap_array);
>  
> @@ -508,7 +509,7 @@ void free_devmap_managed_page(struct page *page)
>  {
>  	/* notify page idle for dax */
>  	if (!is_device_private_page(page)) {
> -		wake_up_var(&page->_refcount);
> +		dax_wakeup_page(page);
>  		return;
>  	}
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
