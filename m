Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9930DA67E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfICL5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:57:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbfICL5u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:57:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F385AE16;
        Tue,  3 Sep 2019 11:57:48 +0000 (UTC)
Date:   Tue, 3 Sep 2019 13:57:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 1/2] mm: Allow the page cache to allocate large pages
Message-ID: <20190903115748.GS14028@dhcp22.suse.cz>
References: <20190902092341.26712-1-william.kucharski@oracle.com>
 <20190902092341.26712-2-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902092341.26712-2-william.kucharski@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 02-09-19 03:23:40, William Kucharski wrote:
> Add an 'order' argument to __page_cache_alloc() and
> do_read_cache_page(). Ensure the allocated pages are compound pages.

Why do we need to touch all the existing callers and change them to use
order 0 when none is actually converted to a different order? This just
seem to add a lot of code churn without a good reason. If anything I
would simply add __page_cache_alloc_order and make __page_cache_alloc
call it with order 0 argument.

Also is it so much to ask callers to provide __GFP_COMP explicitly?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  fs/afs/dir.c            |  2 +-
>  fs/btrfs/compression.c  |  2 +-
>  fs/cachefiles/rdwr.c    |  4 ++--
>  fs/ceph/addr.c          |  2 +-
>  fs/ceph/file.c          |  2 +-
>  include/linux/pagemap.h | 10 ++++++----
>  mm/filemap.c            | 20 +++++++++++---------
>  mm/readahead.c          |  2 +-
>  net/ceph/pagelist.c     |  4 ++--
>  net/ceph/pagevec.c      |  2 +-
>  10 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 139b4e3cc946..ca8f8e77e012 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -274,7 +274,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
>  				afs_stat_v(dvnode, n_inval);
>  
>  			ret = -ENOMEM;
> -			req->pages[i] = __page_cache_alloc(gfp);
> +			req->pages[i] = __page_cache_alloc(gfp, 0);
>  			if (!req->pages[i])
>  				goto error;
>  			ret = add_to_page_cache_lru(req->pages[i],
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 60c47b417a4b..5280e7477b7e 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -466,7 +466,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  		}
>  
>  		page = __page_cache_alloc(mapping_gfp_constraint(mapping,
> -								 ~__GFP_FS));
> +								 ~__GFP_FS), 0);
>  		if (!page)
>  			break;
>  
> diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
> index 44a3ce1e4ce4..11d30212745f 100644
> --- a/fs/cachefiles/rdwr.c
> +++ b/fs/cachefiles/rdwr.c
> @@ -259,7 +259,7 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
>  			goto backing_page_already_present;
>  
>  		if (!newpage) {
> -			newpage = __page_cache_alloc(cachefiles_gfp);
> +			newpage = __page_cache_alloc(cachefiles_gfp, 0);
>  			if (!newpage)
>  				goto nomem_monitor;
>  		}
> @@ -495,7 +495,7 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
>  				goto backing_page_already_present;
>  
>  			if (!newpage) {
> -				newpage = __page_cache_alloc(cachefiles_gfp);
> +				newpage = __page_cache_alloc(cachefiles_gfp, 0);
>  				if (!newpage)
>  					goto nomem;
>  			}
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index b3c8b886bf64..7c1c3857fbb9 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1708,7 +1708,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
>  		if (len > PAGE_SIZE)
>  			len = PAGE_SIZE;
>  	} else {
> -		page = __page_cache_alloc(GFP_NOFS);
> +		page = __page_cache_alloc(GFP_NOFS, 0);
>  		if (!page) {
>  			err = -ENOMEM;
>  			goto out;
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 685a03cc4b77..ae58d7c31aa4 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1305,7 +1305,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		struct page *page = NULL;
>  		loff_t i_size;
>  		if (retry_op == READ_INLINE) {
> -			page = __page_cache_alloc(GFP_KERNEL);
> +			page = __page_cache_alloc(GFP_KERNEL, 0);
>  			if (!page)
>  				return -ENOMEM;
>  		}
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c7552459a15f..92e026d9a6b7 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -208,17 +208,19 @@ static inline int page_cache_add_speculative(struct page *page, int count)
>  }
>  
>  #ifdef CONFIG_NUMA
> -extern struct page *__page_cache_alloc(gfp_t gfp);
> +extern struct page *__page_cache_alloc(gfp_t gfp, unsigned int order);
>  #else
> -static inline struct page *__page_cache_alloc(gfp_t gfp)
> +static inline struct page *__page_cache_alloc(gfp_t gfp, unsigned int order)
>  {
> -	return alloc_pages(gfp, 0);
> +	if (order > 0)
> +		gfp |= __GFP_COMP;
> +	return alloc_pages(gfp, order);
>  }
>  #endif
>  
>  static inline struct page *page_cache_alloc(struct address_space *x)
>  {
> -	return __page_cache_alloc(mapping_gfp_mask(x));
> +	return __page_cache_alloc(mapping_gfp_mask(x), 0);
>  }
>  
>  static inline gfp_t readahead_gfp_mask(struct address_space *x)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d0cf700bf201..38b46fc00855 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -954,22 +954,25 @@ int add_to_page_cache_lru(struct page *page, struct address_space *mapping,
>  EXPORT_SYMBOL_GPL(add_to_page_cache_lru);
>  
>  #ifdef CONFIG_NUMA
> -struct page *__page_cache_alloc(gfp_t gfp)
> +struct page *__page_cache_alloc(gfp_t gfp, unsigned int order)
>  {
>  	int n;
>  	struct page *page;
>  
> +	if (order > 0)
> +		gfp |= __GFP_COMP;
> +
>  	if (cpuset_do_page_mem_spread()) {
>  		unsigned int cpuset_mems_cookie;
>  		do {
>  			cpuset_mems_cookie = read_mems_allowed_begin();
>  			n = cpuset_mem_spread_node();
> -			page = __alloc_pages_node(n, gfp, 0);
> +			page = __alloc_pages_node(n, gfp, order);
>  		} while (!page && read_mems_allowed_retry(cpuset_mems_cookie));
>  
>  		return page;
>  	}
> -	return alloc_pages(gfp, 0);
> +	return alloc_pages(gfp, order);
>  }
>  EXPORT_SYMBOL(__page_cache_alloc);
>  #endif
> @@ -1665,7 +1668,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
>  		if (fgp_flags & FGP_NOFS)
>  			gfp_mask &= ~__GFP_FS;
>  
> -		page = __page_cache_alloc(gfp_mask);
> +		page = __page_cache_alloc(gfp_mask, 0);
>  		if (!page)
>  			return NULL;
>  
> @@ -2802,15 +2805,14 @@ static struct page *wait_on_page_read(struct page *page)
>  static struct page *do_read_cache_page(struct address_space *mapping,
>  				pgoff_t index,
>  				int (*filler)(void *, struct page *),
> -				void *data,
> -				gfp_t gfp)
> +				void *data, unsigned int order, gfp_t gfp)
>  {
>  	struct page *page;
>  	int err;
>  repeat:
>  	page = find_get_page(mapping, index);
>  	if (!page) {
> -		page = __page_cache_alloc(gfp);
> +		page = __page_cache_alloc(gfp, order);
>  		if (!page)
>  			return ERR_PTR(-ENOMEM);
>  		err = add_to_page_cache_lru(page, mapping, index, gfp);
> @@ -2917,7 +2919,7 @@ struct page *read_cache_page(struct address_space *mapping,
>  				int (*filler)(void *, struct page *),
>  				void *data)
>  {
> -	return do_read_cache_page(mapping, index, filler, data,
> +	return do_read_cache_page(mapping, index, filler, data, 0,
>  			mapping_gfp_mask(mapping));
>  }
>  EXPORT_SYMBOL(read_cache_page);
> @@ -2939,7 +2941,7 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
>  				pgoff_t index,
>  				gfp_t gfp)
>  {
> -	return do_read_cache_page(mapping, index, NULL, NULL, gfp);
> +	return do_read_cache_page(mapping, index, NULL, NULL, 0, gfp);
>  }
>  EXPORT_SYMBOL(read_cache_page_gfp);
>  
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 2fe72cd29b47..954760a612ea 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -193,7 +193,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
>  			continue;
>  		}
>  
> -		page = __page_cache_alloc(gfp_mask);
> +		page = __page_cache_alloc(gfp_mask, 0);
>  		if (!page)
>  			break;
>  		page->index = page_offset;
> diff --git a/net/ceph/pagelist.c b/net/ceph/pagelist.c
> index 65e34f78b05d..0c3face908dc 100644
> --- a/net/ceph/pagelist.c
> +++ b/net/ceph/pagelist.c
> @@ -56,7 +56,7 @@ static int ceph_pagelist_addpage(struct ceph_pagelist *pl)
>  	struct page *page;
>  
>  	if (!pl->num_pages_free) {
> -		page = __page_cache_alloc(GFP_NOFS);
> +		page = __page_cache_alloc(GFP_NOFS, 0);
>  	} else {
>  		page = list_first_entry(&pl->free_list, struct page, lru);
>  		list_del(&page->lru);
> @@ -107,7 +107,7 @@ int ceph_pagelist_reserve(struct ceph_pagelist *pl, size_t space)
>  	space = (space + PAGE_SIZE - 1) >> PAGE_SHIFT;   /* conv to num pages */
>  
>  	while (space > pl->num_pages_free) {
> -		struct page *page = __page_cache_alloc(GFP_NOFS);
> +		struct page *page = __page_cache_alloc(GFP_NOFS, 0);
>  		if (!page)
>  			return -ENOMEM;
>  		list_add_tail(&page->lru, &pl->free_list);
> diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
> index 64305e7056a1..1d07e639216d 100644
> --- a/net/ceph/pagevec.c
> +++ b/net/ceph/pagevec.c
> @@ -45,7 +45,7 @@ struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags)
>  	if (!pages)
>  		return ERR_PTR(-ENOMEM);
>  	for (i = 0; i < num_pages; i++) {
> -		pages[i] = __page_cache_alloc(flags);
> +		pages[i] = __page_cache_alloc(flags, 0);
>  		if (pages[i] == NULL) {
>  			ceph_release_page_vector(pages, i);
>  			return ERR_PTR(-ENOMEM);
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
