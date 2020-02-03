Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42109150836
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 15:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBCOSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 09:18:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:39328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbgBCOSQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:18:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B60FAB26A;
        Mon,  3 Feb 2020 14:18:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 802911E0D69; Mon,  3 Feb 2020 15:18:11 +0100 (CET)
Date:   Mon, 3 Feb 2020 15:18:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/12] mm/gup: require FOLL_GET for
 get_user_pages_fast()
Message-ID: <20200203141811.GB18591@quack2.suse.cz>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-7-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 31-01-20 19:40:23, John Hubbard wrote:
> Internal to mm/gup.c, require that get_user_pages_fast()
> and __get_user_pages_fast() identify themselves, by setting
> FOLL_GET. This is required in order to be able to make decisions
> based on "FOLL_PIN, or FOLL_GET, or both or neither are set", in
> upcoming patches.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 83473c2165f4..e899d2e6398c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2390,6 +2390,14 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	unsigned long len, end;
>  	unsigned long flags;
>  	int nr = 0;
> +	/*
> +	 * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
> +	 * because gup fast is always a "pin with a +1 page refcount" request.
> +	 */
> +	unsigned int gup_flags = FOLL_GET;
> +
> +	if (write)
> +		gup_flags |= FOLL_WRITE;
>  
>  	start = untagged_addr(start) & PAGE_MASK;
>  	len = (unsigned long) nr_pages << PAGE_SHIFT;
> @@ -2415,7 +2423,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
>  	    gup_fast_permitted(start, end)) {
>  		local_irq_save(flags);
> -		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
> +		gup_pgd_range(start, end, gup_flags, pages, &nr);
>  		local_irq_restore(flags);
>  	}
>  
> @@ -2454,7 +2462,7 @@ static int internal_get_user_pages_fast(unsigned long start, int nr_pages,
>  	int nr = 0, ret = 0;
>  
>  	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
> -				       FOLL_FORCE | FOLL_PIN)))
> +				       FOLL_FORCE | FOLL_PIN | FOLL_GET)))
>  		return -EINVAL;
>  
>  	start = untagged_addr(start) & PAGE_MASK;
> @@ -2521,6 +2529,13 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>  		return -EINVAL;
>  
> +	/*
> +	 * The caller may or may not have explicitly set FOLL_GET; either way is
> +	 * OK. However, internally (within mm/gup.c), gup fast variants must set
> +	 * FOLL_GET, because gup fast is always a "pin with a +1 page refcount"
> +	 * request.
> +	 */
> +	gup_flags |= FOLL_GET;
>  	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
>  }
>  EXPORT_SYMBOL_GPL(get_user_pages_fast);
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
