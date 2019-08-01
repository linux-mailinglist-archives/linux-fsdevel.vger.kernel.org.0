Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 932BD7D53C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 08:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfHAGIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 02:08:02 -0400
Received: from verein.lst.de ([213.95.11.211]:40460 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAGIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:08:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9C9C468B05; Thu,  1 Aug 2019 08:07:55 +0200 (CEST)
Date:   Thu, 1 Aug 2019 08:07:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     john.hubbard@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/3] mm/gup: add make_dirty arg to
 put_user_pages_dirty_lock()
Message-ID: <20190801060755.GA14893@lst.de>
References: <20190730205705.9018-1-jhubbard@nvidia.com> <20190730205705.9018-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730205705.9018-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:57:03PM -0700, john.hubbard@gmail.com wrote:
> @@ -40,10 +40,7 @@
>  static void __qib_release_user_pages(struct page **p, size_t num_pages,
>  				     int dirty)
>  {
> -	if (dirty)
> -		put_user_pages_dirty_lock(p, num_pages);
> -	else
> -		put_user_pages(p, num_pages);
> +	put_user_pages_dirty_lock(p, num_pages, dirty);
>  }

__qib_release_user_pages should be removed now as a direct call to
put_user_pages_dirty_lock is a lot more clear.

> index 0b0237d41613..62e6ffa9ad78 100644
> --- a/drivers/infiniband/hw/usnic/usnic_uiom.c
> +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
> @@ -75,10 +75,7 @@ static void usnic_uiom_put_pages(struct list_head *chunk_list, int dirty)
>  		for_each_sg(chunk->page_list, sg, chunk->nents, i) {
>  			page = sg_page(sg);
>  			pa = sg_phys(sg);
> -			if (dirty)
> -				put_user_pages_dirty_lock(&page, 1);
> -			else
> -				put_user_page(page);
> +			put_user_pages_dirty_lock(&page, 1, dirty);
>  			usnic_dbg("pa: %pa\n", &pa);

There is a pre-existing bug here, as this needs to use the sg_page
iterator.  Probably worth throwing in a fix into your series while you
are at it.

> @@ -63,15 +63,7 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
>  static void siw_free_plist(struct siw_page_chunk *chunk, int num_pages,
>  			   bool dirty)
>  {
> -	struct page **p = chunk->plist;
> -
> -	while (num_pages--) {
> -		if (!PageDirty(*p) && dirty)
> -			put_user_pages_dirty_lock(p, 1);
> -		else
> -			put_user_page(*p);
> -		p++;
> -	}
> +	put_user_pages_dirty_lock(chunk->plist, num_pages, dirty);

siw_free_plist should just go away now.

Otherwise this looks good to me.
