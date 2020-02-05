Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D33152834
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 10:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgBEJXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 04:23:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:49146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgBEJXX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:23:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3962EB242;
        Wed,  5 Feb 2020 09:23:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 61F351E0A51; Wed,  5 Feb 2020 10:23:13 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:23:13 +0100
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
Subject: Re: [PATCH v4 04/12] mm: introduce page_ref_sub_return()
Message-ID: <20200205092313.GA28058@quack2.suse.cz>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204234117.2974687-5-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-02-20 15:41:09, John Hubbard wrote:
> An upcoming patch requires subtracting a large chunk of refcounts from
> a page, and checking what the resulting refcount is. This is a little
> different than the usual "check for zero refcount" that many of the
> page ref functions already do. However, it is similar to a few other
> routines that (like this one) are generally useful for things such as
> 1-based refcounting.
> 
> Add page_ref_sub_return(), that subtracts a chunk of refcounts
> atomically, and returns an atomic snapshot of the result.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/page_ref.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
> index 14d14beb1f7f..a0e171265b79 100644
> --- a/include/linux/page_ref.h
> +++ b/include/linux/page_ref.h
> @@ -102,6 +102,15 @@ static inline void page_ref_sub(struct page *page, int nr)
>  		__page_ref_mod(page, -nr);
>  }
>  
> +static inline int page_ref_sub_return(struct page *page, int nr)
> +{
> +	int ret = atomic_sub_return(nr, &page->_refcount);
> +
> +	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
> +		__page_ref_mod_and_return(page, -nr, ret);
> +	return ret;
> +}
> +
>  static inline void page_ref_inc(struct page *page)
>  {
>  	atomic_inc(&page->_refcount);
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
