Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70AB15D1B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 06:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgBNFg2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 00:36:28 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12665 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgBNFg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:36:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4631cc0000>; Thu, 13 Feb 2020 21:36:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Feb 2020 21:36:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Feb 2020 21:36:26 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Feb
 2020 05:36:26 +0000
Subject: Re: [PATCH v5 04/13] mm: Add readahead address space operation
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-5-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <755399a8-8fdf-bfac-9f23-81579ff63ddf@nvidia.com>
Date:   Thu, 13 Feb 2020 21:36:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211010348.6872-5-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581658572; bh=jFmHRz3KzJ7pGUGyJHtPddwQAzni8ex0m/VPpC4rgNI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=VG9MzNksLXKPMuMvOt5DLrhtoGbczUxSeokBbTXRy1YA0jiaUy9Wwu2liRu6JC7cN
         vrSbhyW0Nl7uJ95FVGeKJhAGQiDACPCUp8XvwpnyDRTSCnc776So8CeWw9ET3xwhmK
         EOKwJTDWC4m7+/+eQInPOwtcsaGEUQR4pm4MGjSL8PbEoK73a7y46tJNWMVGvIOKjz
         a1mrpi35JzEcX/2mTlyuNmCYTSxJ+/XhZJ23buXiwir0gl0mFP8/rdiu0jyDx6Kt8t
         skJpu3F1zzXvrM3C6ei0m/mPgJdtVh5ciEFDZnVw3m9pO4O74nYQbMCK8byJV0Kojy
         08R+1NsMrbCHA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/10/20 5:03 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This replaces ->readpages with a saner interface:
>  - Return void instead of an ignored error code.
>  - Pages are already in the page cache when ->readahead is called.
>  - Implementation looks up the pages in the page cache instead of
>    having them passed in a linked list.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/locking.rst |  6 ++-
>  Documentation/filesystems/vfs.rst     | 13 +++++++
>  include/linux/fs.h                    |  2 +
>  include/linux/pagemap.h               | 54 +++++++++++++++++++++++++++
>  mm/readahead.c                        | 48 ++++++++++++++----------
>  5 files changed, 102 insertions(+), 21 deletions(-)
> 

A minor question below, but either way you can add:

    Reviewed-by: John Hubbard <jhubbard@nvidia.com>



> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 5057e4d9dcd1..0ebc4491025a 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -239,6 +239,7 @@ prototypes::
>  	int (*readpage)(struct file *, struct page *);
>  	int (*writepages)(struct address_space *, struct writeback_control *);
>  	int (*set_page_dirty)(struct page *page);
> +	void (*readahead)(struct readahead_control *);
>  	int (*readpages)(struct file *filp, struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages);
>  	int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -271,7 +272,8 @@ writepage:		yes, unlocks (see below)
>  readpage:		yes, unlocks
>  writepages:
>  set_page_dirty		no
> -readpages:
> +readahead:		yes, unlocks
> +readpages:		no
>  write_begin:		locks the page		 exclusive
>  write_end:		yes, unlocks		 exclusive
>  bmap:
> @@ -295,6 +297,8 @@ the request handler (/dev/loop).
>  ->readpage() unlocks the page, either synchronously or via I/O
>  completion.
>  
> +->readahead() unlocks the pages like ->readpage().
> +
>  ->readpages() populates the pagecache with the passed pages and starts
>  I/O against them.  They come unlocked upon I/O completion.
>  
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..cabee16b7406 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -706,6 +706,7 @@ cache in your filesystem.  The following members are defined:
>  		int (*readpage)(struct file *, struct page *);
>  		int (*writepages)(struct address_space *, struct writeback_control *);
>  		int (*set_page_dirty)(struct page *page);
> +		void (*readahead)(struct readahead_control *);
>  		int (*readpages)(struct file *filp, struct address_space *mapping,
>  				 struct list_head *pages, unsigned nr_pages);
>  		int (*write_begin)(struct file *, struct address_space *mapping,
> @@ -781,12 +782,24 @@ cache in your filesystem.  The following members are defined:
>  	If defined, it should set the PageDirty flag, and the
>  	PAGECACHE_TAG_DIRTY tag in the radix tree.
>  
> +``readahead``
> +	Called by the VM to read pages associated with the address_space
> +	object.  The pages are consecutive in the page cache and are
> +	locked.  The implementation should decrement the page refcount
> +	after starting I/O on each page.  Usually the page will be
> +	unlocked by the I/O completion handler.  If the function does
> +	not attempt I/O on some pages, the caller will decrement the page
> +	refcount and unlock the pages for you.	Set PageUptodate if the
> +	I/O completes successfully.  Setting PageError on any page will
> +	be ignored; simply unlock the page if an I/O error occurs.
> +
>  ``readpages``
>  	called by the VM to read pages associated with the address_space
>  	object.  This is essentially just a vector version of readpage.
>  	Instead of just one page, several pages are requested.
>  	readpages is only used for read-ahead, so read errors are
>  	ignored.  If anything goes wrong, feel free to give up.
> +        This interface is deprecated; implement readahead instead.
>  
>  ``write_begin``
>  	Called by the generic buffered write code to ask the filesystem
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..d4e2d2964346 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -292,6 +292,7 @@ enum positive_aop_returns {
>  struct page;
>  struct address_space;
>  struct writeback_control;
> +struct readahead_control;
>  
>  /*
>   * Write life time hint values.
> @@ -375,6 +376,7 @@ struct address_space_operations {
>  	 */
>  	int (*readpages)(struct file *filp, struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages);
> +	void (*readahead)(struct readahead_control *);
>  
>  	int (*write_begin)(struct file *, struct address_space *mapping,
>  				loff_t pos, unsigned len, unsigned flags,
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ccb14b6a16b5..13efafaf7e1f 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -630,6 +630,60 @@ static inline int add_to_page_cache(struct page *page,
>  	return error;
>  }
>  
> +/*
> + * Readahead is of a block of consecutive pages.
> + */
> +struct readahead_control {
> +	struct file *file;
> +	struct address_space *mapping;
> +/* private: use the readahead_* accessors instead */
> +	pgoff_t start;
> +	unsigned int nr_pages;
> +	unsigned int batch_count;
> +};
> +
> +static inline struct page *readahead_page(struct readahead_control *rac)
> +{
> +	struct page *page;
> +
> +	if (!rac->nr_pages)
> +		return NULL;
> +
> +	page = xa_load(&rac->mapping->i_pages, rac->start);


Is it worth asserting that the page was found:

	VM_BUG_ON_PAGE(!page || xa_is_value(page), page);

? Or is that overkill here?


> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	rac->batch_count = hpage_nr_pages(page);
> +	rac->start += rac->batch_count;


The above was surprising, until I saw the other thread with Dave and you.
I was reviewing this patchset in order to have a chance at understanding the 
follow-on patchset ("Large pages in the page cache"), and it seems like that
feature has a solid head start here. :)  


thanks,
-- 
John Hubbard
NVIDIA

> +
> +	return page;
> +}
> +
> +#define readahead_for_each(rac, page)					\
> +	for (; (page = readahead_page(rac)); rac->nr_pages -= rac->batch_count)
> +
> +/* The byte offset into the file of this readahead block */
> +static inline loff_t readahead_offset(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->start * PAGE_SIZE;
> +}
> +
> +/* The number of bytes in this readahead block */
> +static inline loff_t readahead_length(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->nr_pages * PAGE_SIZE;
> +}
> +
> +/* The index of the first page in this readahead block */
> +static inline unsigned int readahead_index(struct readahead_control *rac)
> +{
> +	return rac->start;
> +}
> +
> +/* The number of pages in this readahead block */
> +static inline unsigned int readahead_count(struct readahead_control *rac)
> +{
> +	return rac->nr_pages;
> +}
> +
>  static inline unsigned long dir_pages(struct inode *inode)
>  {
>  	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 96c6ca68a174..933b32e0c90a 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -113,25 +113,30 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
>  
>  EXPORT_SYMBOL(read_cache_pages);
>  
> -static void read_pages(struct address_space *mapping, struct file *filp,
> -		struct list_head *pages, pgoff_t start,
> -		unsigned int nr_pages)
> +static void read_pages(struct readahead_control *rac, struct list_head *pages)
>  {
> +	struct page *page;
>  	struct blk_plug plug;
> +	const struct address_space_operations *aops = rac->mapping->a_ops;
> +
> +	if (rac->nr_pages == 0)
> +		return;
>  
>  	blk_start_plug(&plug);
>  
> -	if (mapping->a_ops->readpages) {
> -		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
> +	if (aops->readahead) {
> +		aops->readahead(rac);
> +		readahead_for_each(rac, page) {
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +	} else if (aops->readpages) {
> +		aops->readpages(rac->file, rac->mapping, pages, rac->nr_pages);
>  		/* Clean up the remaining pages */
>  		put_pages_list(pages);
>  	} else {
> -		struct page *page;
> -		unsigned long index;
> -
> -		xa_for_each_range(&mapping->i_pages, index, page, start,
> -				start + nr_pages - 1) {
> -			mapping->a_ops->readpage(filp, page);
> +		readahead_for_each(rac, page) {
> +			aops->readpage(rac->file, page);
>  			put_page(page);
>  		}
>  	}
> @@ -156,10 +161,15 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
>  	LIST_HEAD(page_pool);
>  	int page_idx;
>  	pgoff_t page_offset = start;
> -	unsigned long nr_pages = 0;
>  	loff_t isize = i_size_read(inode);
>  	gfp_t gfp_mask = readahead_gfp_mask(mapping);
>  	bool use_list = mapping->a_ops->readpages;
> +	struct readahead_control rac = {
> +		.mapping = mapping,
> +		.file = filp,
> +		.start = start,
> +		.nr_pages = 0,
> +	};
>  
>  	if (isize == 0)
>  		goto out;
> @@ -206,15 +216,14 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
>  
>  		if (page_idx == nr_to_read - lookahead_size)
>  			SetPageReadahead(page);
> -		nr_pages++;
> +		rac.nr_pages++;
>  		page_offset++;
>  		continue;
>  skip:
> -		if (nr_pages)
> -			read_pages(mapping, filp, &page_pool, start, nr_pages);
> -		nr_pages = 0;
> +		read_pages(&rac, &page_pool);
> +		rac.nr_pages = 0;
>  		page_offset++;
> -		start = page_offset;
> +		rac.start = page_offset;
>  	}
>  
>  	/*
> @@ -222,11 +231,10 @@ unsigned long __do_page_cache_readahead(struct address_space *mapping,
>  	 * uptodate then the caller will launch readpage again, and
>  	 * will then handle the error.
>  	 */
> -	if (nr_pages)
> -		read_pages(mapping, filp, &page_pool, start, nr_pages);
> +	read_pages(&rac, &page_pool);
>  	BUG_ON(!list_empty(&page_pool));
>  out:
> -	return nr_pages;
> +	return rac.nr_pages;
>  }
>  
>  /*
> 



