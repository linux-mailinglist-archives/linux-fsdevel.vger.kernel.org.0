Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364B79B32E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbfHWPS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 11:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733205AbfHWPS1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AB713090FD6;
        Fri, 23 Aug 2019 15:18:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2CAF6A50D;
        Fri, 23 Aug 2019 15:18:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 72B0C223CFC; Fri, 23 Aug 2019 11:18:26 -0400 (EDT)
Date:   Fri, 23 Aug 2019 11:18:26 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 06/19] fs/ext4: Teach dax_layout_busy_page() to
 operate on a sub-range
Message-ID: <20190823151826.GB11009@redhat.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809225833.6657-7-ira.weiny@intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 23 Aug 2019 15:18:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 09, 2019 at 03:58:20PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Callers of dax_layout_busy_page() are only rarely operating on the
> entire file of concern.
> 
> Teach dax_layout_busy_page() to operate on a sub-range of the
> address_space provided.  Specifying 0 - ULONG_MAX however, will continue
> to operate on the "entire file" and XFS is split out to a separate patch
> by this method.
> 
> This could potentially speed up dax_layout_busy_page() as well.

I need this functionality as well for virtio_fs and posted a patch for
this.

https://lkml.org/lkml/2019/8/21/825

Given this is an optimization which existing users can benefit from already,
this patch could probably be pushed upstream independently.

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from RFC v1
> 	Fix 0-day build errors
> 
>  fs/dax.c            | 15 +++++++++++----
>  fs/ext4/ext4.h      |  2 +-
>  fs/ext4/extents.c   |  6 +++---
>  fs/ext4/inode.c     | 19 ++++++++++++-------
>  fs/xfs/xfs_file.c   |  3 ++-
>  include/linux/dax.h |  6 ++++--
>  6 files changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index a14ec32255d8..3ad19c384454 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -573,8 +573,11 @@ bool dax_mapping_is_dax(struct address_space *mapping)
>  EXPORT_SYMBOL_GPL(dax_mapping_is_dax);
>  
>  /**
> - * dax_layout_busy_page - find first pinned page in @mapping
> + * dax_layout_busy_page - find first pinned page in @mapping within
> + *                        the range @off - @off + @len
>   * @mapping: address space to scan for a page with ref count > 1
> + * @off: offset to start at
> + * @len: length to scan through
>   *
>   * DAX requires ZONE_DEVICE mapped pages. These pages are never
>   * 'onlined' to the page allocator so they are considered idle when
> @@ -587,9 +590,13 @@ EXPORT_SYMBOL_GPL(dax_mapping_is_dax);
>   * to be able to run unmap_mapping_range() and subsequently not race
>   * mapping_mapped() becoming true.
>   */
> -struct page *dax_layout_busy_page(struct address_space *mapping)
> +struct page *dax_layout_busy_page(struct address_space *mapping,
> +				  loff_t off, loff_t len)
>  {
> -	XA_STATE(xas, &mapping->i_pages, 0);
> +	unsigned long start_idx = off >> PAGE_SHIFT;
> +	unsigned long end_idx = (len == ULONG_MAX) ? ULONG_MAX
> +				: start_idx + (len >> PAGE_SHIFT);
> +	XA_STATE(xas, &mapping->i_pages, start_idx);
>  	void *entry;
>  	unsigned int scanned = 0;
>  	struct page *page = NULL;
> @@ -612,7 +619,7 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
>  	unmap_mapping_range(mapping, 0, 0, 1);

Should we unmap only those pages which fall in the range specified by caller.
Unmapping whole file seems to be less efficient.

Thanks
Vivek
