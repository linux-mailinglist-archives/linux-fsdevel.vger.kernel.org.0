Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16C150842
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 15:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBCOUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 09:20:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:40974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbgBCOUJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:20:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF1D7AE2E;
        Mon,  3 Feb 2020 14:20:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 50EA41E0D69; Mon,  3 Feb 2020 15:20:06 +0100 (CET)
Date:   Mon, 3 Feb 2020 15:20:06 +0100
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
Subject: Re: [PATCH v3 02/12] mm/gup: split get_user_pages_remote() into two
 routines
Message-ID: <20200203142006.GD18591@quack2.suse.cz>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 31-01-20 19:40:19, John Hubbard wrote:
> An upcoming patch requires reusing the implementation of
> get_user_pages_remote(). Split up get_user_pages_remote() into an outer
> routine that checks flags, and an implementation routine that will be
> reused. This makes subsequent changes much easier to understand.
> 
> There should be no change in behavior due to this patch.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c | 56 +++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e13f4d211475..228aa7059018 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1557,6 +1557,37 @@ static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
>  }
>  #endif /* CONFIG_FS_DAX || CONFIG_CMA */
>  
> +#ifdef CONFIG_MMU
> +static long __get_user_pages_remote(struct task_struct *tsk,
> +				    struct mm_struct *mm,
> +				    unsigned long start, unsigned long nr_pages,
> +				    unsigned int gup_flags, struct page **pages,
> +				    struct vm_area_struct **vmas, int *locked)
> +{
> +	/*
> +	 * Parts of FOLL_LONGTERM behavior are incompatible with
> +	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> +	 * vmas. However, this only comes up if locked is set, and there are
> +	 * callers that do request FOLL_LONGTERM, but do not set locked. So,
> +	 * allow what we can.
> +	 */
> +	if (gup_flags & FOLL_LONGTERM) {
> +		if (WARN_ON_ONCE(locked))
> +			return -EINVAL;
> +		/*
> +		 * This will check the vmas (even if our vmas arg is NULL)
> +		 * and return -ENOTSUPP if DAX isn't allowed in this case:
> +		 */
> +		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
> +					     vmas, gup_flags | FOLL_TOUCH |
> +					     FOLL_REMOTE);
> +	}
> +
> +	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
> +				       locked,
> +				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
> +}
> +
>  /*
>   * get_user_pages_remote() - pin user pages in memory
>   * @tsk:	the task_struct to use for page fault accounting, or
> @@ -1619,7 +1650,6 @@ static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
>   * should use get_user_pages because it cannot pass
>   * FAULT_FLAG_ALLOW_RETRY to handle_mm_fault.
>   */
> -#ifdef CONFIG_MMU
>  long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  		unsigned long start, unsigned long nr_pages,
>  		unsigned int gup_flags, struct page **pages,
> @@ -1632,28 +1662,8 @@ long get_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>  		return -EINVAL;
>  
> -	/*
> -	 * Parts of FOLL_LONGTERM behavior are incompatible with
> -	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
> -	 * vmas. However, this only comes up if locked is set, and there are
> -	 * callers that do request FOLL_LONGTERM, but do not set locked. So,
> -	 * allow what we can.
> -	 */
> -	if (gup_flags & FOLL_LONGTERM) {
> -		if (WARN_ON_ONCE(locked))
> -			return -EINVAL;
> -		/*
> -		 * This will check the vmas (even if our vmas arg is NULL)
> -		 * and return -ENOTSUPP if DAX isn't allowed in this case:
> -		 */
> -		return __gup_longterm_locked(tsk, mm, start, nr_pages, pages,
> -					     vmas, gup_flags | FOLL_TOUCH |
> -					     FOLL_REMOTE);
> -	}
> -
> -	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
> -				       locked,
> -				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
> +	return __get_user_pages_remote(tsk, mm, start, nr_pages, gup_flags,
> +				       pages, vmas, locked);
>  }
>  EXPORT_SYMBOL(get_user_pages_remote);
>  
> -- 
> 2.25.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
