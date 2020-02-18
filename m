Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996AD1620D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 07:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgBRGVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 01:21:53 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45504 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgBRGVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 01:21:53 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D25FD3A2514;
        Tue, 18 Feb 2020 17:21:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j3wGR-0006EU-Pg; Tue, 18 Feb 2020 17:21:47 +1100
Date:   Tue, 18 Feb 2020 17:21:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 08/19] mm: Add readahead address space operation
Message-ID: <20200218062147.GN10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-14-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217184613.19668-14-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=ZUKaNjAUM_NwrQaOQj4A:9
        a=JQFMNDVPDCAknBdf:21 a=DU4q-3mnrf8zicIu:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:45:54AM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This replaces ->readpages with a saner interface:
>  - Return void instead of an ignored error code.
>  - Pages are already in the page cache when ->readahead is called.

Might read better as:

 - Page cache is already populates with locked pages when
   ->readahead is called.

>  - Implementation looks up the pages in the page cache instead of
>    having them passed in a linked list.

Add:

 - cleanup of unused readahead handled by ->readahead caller, not
   the method implementation.

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/locking.rst |  6 +++++-
>  Documentation/filesystems/vfs.rst     | 13 +++++++++++++
>  include/linux/fs.h                    |  2 ++
>  include/linux/pagemap.h               | 18 ++++++++++++++++++
>  mm/readahead.c                        |  8 +++++++-
>  5 files changed, 45 insertions(+), 2 deletions(-)
> 
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

"... the pages that I/O is attempted on ..."

>  ->readpages() populates the pagecache with the passed pages and starts
>  I/O against them.  They come unlocked upon I/O completion.
>  
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 7d4d09dd5e6d..81ab30fbe45c 100644
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
> +	This interface is deprecated; implement readahead instead.

What is the removal schedule for the deprecated interface? 

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 3613154e79e4..bd4291f78f41 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -665,6 +665,24 @@ static inline void readahead_next(struct readahead_control *rac)
>  #define readahead_for_each(rac, page)					\
>  	for (; (page = readahead_page(rac)); readahead_next(rac))
>  
> +/* The byte offset into the file of this readahead block */
> +static inline loff_t readahead_offset(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->_start * PAGE_SIZE;
> +}

Urk. Didn't an early page use "offset" for the page index? That
was was "mm: Remove 'page_offset' from readahead loop" did, right?

That's just going to cause confusion to have different units for
readahead "offsets"....

> +
> +/* The number of bytes in this readahead block */
> +static inline loff_t readahead_length(struct readahead_control *rac)
> +{
> +	return (loff_t)rac->_nr_pages * PAGE_SIZE;
> +}
> +
> +/* The index of the first page in this readahead block */
> +static inline unsigned int readahead_index(struct readahead_control *rac)
> +{
> +	return rac->_start;
> +}

Based on this, I suspect the earlier patch should use "index" rather
than "offset" when walking the page cache indexes...

> +
>  /* The number of pages in this readahead block */
>  static inline unsigned int readahead_count(struct readahead_control *rac)
>  {
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 9e430daae42f..975ff5e387be 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -121,7 +121,13 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
>  
>  	blk_start_plug(&plug);
>  
> -	if (aops->readpages) {
> +	if (aops->readahead) {
> +		aops->readahead(rac);
> +		readahead_for_each(rac, page) {
> +			unlock_page(page);
> +			put_page(page);
> +		}

This needs a comment to explain the unwinding that needs to be done
here. I'm not going to remember in a year's time that this is just
for the pages that weren't submitted by ->readahead....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
