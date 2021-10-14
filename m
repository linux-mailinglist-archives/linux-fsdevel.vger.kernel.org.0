Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683FC42E0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhJNSEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 14:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229983AbhJNSEi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55C5260174;
        Thu, 14 Oct 2021 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634234553;
        bh=XREgYAXJhCji8H7zRG00lEAFIOm24wQYsyx1jQyoJJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RB5ufLHC6EEk6Ds+OrQfJKO49SiE0s8j7VKjeAKvLsFbq3ZfAMG+VSk4D3XxxTyIB
         3dkbWZ5fxwcn8hNVbp9CgG41yJ6krSa8V4Pc3Aya1C6t0rljybkLyV95GAbEOYY92k
         ZUqE9yBOJNsLJqwojKjiQiWriXngN5Hy+hFRVtgr0je87NX6NCHcMY44dakh/hu8E2
         1puKeYFCso/JIU2oxdMZLSlJmV83hYFOg0XqHnH8G6pOn/vXxjC+V3qb0j2PXBeMWW
         icOdYfbY3k1qWjZgq6Jt/Ms81CfLwKuPU/PE19xXK4wP2g67CsqCbyDk9CgQIARnAc
         S0hhMfIiwMeUA==
Date:   Thu, 14 Oct 2021 11:02:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH v7 3/8] mm: factor helpers for memory_failure_dev_pagemap
Message-ID: <20211014180233.GF24307@magnolia>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-4-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:54PM +0800, Shiyang Ruan wrote:
> memory_failure_dev_pagemap code is a bit complex before introduce RMAP
> feature for fsdax.  So it is needed to factor some helper functions to
> simplify these code.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

This looks like a reasonable hoist...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  mm/memory-failure.c | 140 ++++++++++++++++++++++++--------------------
>  1 file changed, 76 insertions(+), 64 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 54879c339024..8ff9b52823c0 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1430,6 +1430,79 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
>  	return 0;
>  }
>  
> +static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
> +		struct address_space *mapping, pgoff_t index, int flags)
> +{
> +	struct to_kill *tk;
> +	unsigned long size = 0;
> +
> +	list_for_each_entry(tk, to_kill, nd)
> +		if (tk->size_shift)
> +			size = max(size, 1UL << tk->size_shift);
> +	if (size) {
> +		/*
> +		 * Unmap the largest mapping to avoid breaking up device-dax
> +		 * mappings which are constant size. The actual size of the
> +		 * mapping being torn down is communicated in siginfo, see
> +		 * kill_proc()
> +		 */
> +		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
> +
> +		unmap_mapping_range(mapping, start, size, 0);
> +	}
> +
> +	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
> +}
> +
> +static int mf_generic_kill_procs(unsigned long long pfn, int flags,
> +		struct dev_pagemap *pgmap)
> +{
> +	struct page *page = pfn_to_page(pfn);
> +	LIST_HEAD(to_kill);
> +	dax_entry_t cookie;
> +
> +	/*
> +	 * Prevent the inode from being freed while we are interrogating
> +	 * the address_space, typically this would be handled by
> +	 * lock_page(), but dax pages do not use the page lock. This
> +	 * also prevents changes to the mapping of this pfn until
> +	 * poison signaling is complete.
> +	 */
> +	cookie = dax_lock_page(page);
> +	if (!cookie)
> +		return -EBUSY;
> +
> +	if (hwpoison_filter(page))
> +		return 0;
> +
> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> +		/*
> +		 * TODO: Handle HMM pages which may need coordination
> +		 * with device-side memory.
> +		 */
> +		return -EBUSY;
> +	}
> +
> +	/*
> +	 * Use this flag as an indication that the dax page has been
> +	 * remapped UC to prevent speculative consumption of poison.
> +	 */
> +	SetPageHWPoison(page);
> +
> +	/*
> +	 * Unlike System-RAM there is no possibility to swap in a
> +	 * different physical page at a given virtual address, so all
> +	 * userspace consumption of ZONE_DEVICE memory necessitates
> +	 * SIGBUS (i.e. MF_MUST_KILL)
> +	 */
> +	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> +	collect_procs(page, &to_kill, true);
> +
> +	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
> +	dax_unlock_page(page, cookie);
> +	return 0;
> +}
> +
>  static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  {
>  	struct page *p = pfn_to_page(pfn);
> @@ -1519,12 +1592,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		struct dev_pagemap *pgmap)
>  {
>  	struct page *page = pfn_to_page(pfn);
> -	unsigned long size = 0;
> -	struct to_kill *tk;
>  	LIST_HEAD(tokill);
> -	int rc = -EBUSY;
> -	loff_t start;
> -	dax_entry_t cookie;
> +	int rc = -ENXIO;
>  
>  	if (flags & MF_COUNT_INCREASED)
>  		/*
> @@ -1533,67 +1602,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		put_page(page);
>  
>  	/* device metadata space is not recoverable */
> -	if (!pgmap_pfn_valid(pgmap, pfn)) {
> -		rc = -ENXIO;
> -		goto out;
> -	}
> -
> -	/*
> -	 * Prevent the inode from being freed while we are interrogating
> -	 * the address_space, typically this would be handled by
> -	 * lock_page(), but dax pages do not use the page lock. This
> -	 * also prevents changes to the mapping of this pfn until
> -	 * poison signaling is complete.
> -	 */
> -	cookie = dax_lock_page(page);
> -	if (!cookie)
> +	if (!pgmap_pfn_valid(pgmap, pfn))
>  		goto out;
>  
> -	if (hwpoison_filter(page)) {
> -		rc = 0;
> -		goto unlock;
> -	}
> -
> -	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> -		/*
> -		 * TODO: Handle HMM pages which may need coordination
> -		 * with device-side memory.
> -		 */
> -		goto unlock;
> -	}
> -
> -	/*
> -	 * Use this flag as an indication that the dax page has been
> -	 * remapped UC to prevent speculative consumption of poison.
> -	 */
> -	SetPageHWPoison(page);
> -
> -	/*
> -	 * Unlike System-RAM there is no possibility to swap in a
> -	 * different physical page at a given virtual address, so all
> -	 * userspace consumption of ZONE_DEVICE memory necessitates
> -	 * SIGBUS (i.e. MF_MUST_KILL)
> -	 */
> -	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> -	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
> -
> -	list_for_each_entry(tk, &tokill, nd)
> -		if (tk->size_shift)
> -			size = max(size, 1UL << tk->size_shift);
> -	if (size) {
> -		/*
> -		 * Unmap the largest mapping to avoid breaking up
> -		 * device-dax mappings which are constant size. The
> -		 * actual size of the mapping being torn down is
> -		 * communicated in siginfo, see kill_proc()
> -		 */
> -		start = (page->index << PAGE_SHIFT) & ~(size - 1);
> -		unmap_mapping_range(page->mapping, start, size, 0);
> -	}
> -	kill_procs(&tokill, flags & MF_MUST_KILL, false, pfn, flags);
> -	rc = 0;
> -unlock:
> -	dax_unlock_page(page, cookie);
> +	rc = mf_generic_kill_procs(pfn, flags, pgmap);
>  out:
>  	/* drop pgmap ref acquired in caller */
>  	put_dev_pagemap(pgmap);
> -- 
> 2.33.0
> 
> 
> 
