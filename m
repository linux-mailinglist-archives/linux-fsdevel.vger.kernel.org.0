Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A442370A7B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEBGdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 02:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGdR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 02:33:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DA726128E;
        Sun,  2 May 2021 06:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937146;
        bh=IiEyzQs5MLcZFCvU0d7y1MV8UlTREQiWGwIM/9pwy/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlhipPfmdUEHaMz4+QQjq3Zbf4C91HXPY9jQtLKOtWhXziDi2vDX110O2ODTHZhkY
         jFmPlvBfLY2BUWZrFMUeguICwHOl7dXe99mF/2nXZtjUwtowpV1soCnNlZ9kkKV204
         z+s4nzQu24hvfIVUSL4ZPa6Cx4gNz2XQoIZ663xHMGJUxqp7SN0vf+X5xzTPN0yhCv
         lo9KL8d+NnO9W9LxDL7tT2WCdH97cyrejOoatl5+mj0A4RXiw5o4IBVBWoYYdoQt0E
         enrlier3FVU1aSesUwDjPdM6JgY1OQ9Bj42qMecSqHnIgEpFhW/TdKtyQlOsdi998M
         mElZpvzgq2zOw==
Date:   Sun, 2 May 2021 09:32:14 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Message-ID: <YI5HbhYPfENdQAre@kernel.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429122519.15183-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:25:15PM +0200, David Hildenbrand wrote:
> Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
> introduced page_is_poisoned(), however, v5 [1] of the patch used
> "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
> function and move it to page-flags.h, from where it can be used in other
> -- kcore -- context.
> 
> Move the comment to the place where it belongs and simplify.
> 
> [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/page-flags.h |  7 +++++++
>  mm/gup.c                   |  6 +++++-
>  mm/internal.h              | 20 --------------------
>  3 files changed, 12 insertions(+), 21 deletions(-)

Nice :)

> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 04a34c08e0a6..b8c56672a588 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -694,6 +694,13 @@ PAGEFLAG_FALSE(DoubleMap)
>  	TESTSCFLAG_FALSE(DoubleMap)
>  #endif
>  
> +static inline bool is_page_hwpoison(struct page *page)
> +{
> +	if (PageHWPoison(page))
> +		return true;
> +	return PageHuge(page) && PageHWPoison(compound_head(page));
> +}
> +
>  /*
>   * For pages that are never mapped to userspace (and aren't PageSlab),
>   * page_type may be used.  Because it is initialised to -1, we invert the
> diff --git a/mm/gup.c b/mm/gup.c
> index ef7d2da9f03f..000f3303e7f2 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1536,7 +1536,11 @@ struct page *get_dump_page(unsigned long addr)
>  	if (locked)
>  		mmap_read_unlock(mm);
>  
> -	if (ret == 1 && is_page_poisoned(page))
> +	/*
> +	 * We might have hwpoisoned pages still mapped into user space. Don't
> +	 * read these pages when creating a coredump, access could be fatal.
> +	 */
> +	if (ret == 1 && is_page_hwpoison(page))
>  		return NULL;
>  
>  	return (ret == 1) ? page : NULL;
> diff --git a/mm/internal.h b/mm/internal.h
> index cb3c5e0a7799..1432feec62df 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -97,26 +97,6 @@ static inline void set_page_refcounted(struct page *page)
>  	set_page_count(page, 1);
>  }
>  
> -/*
> - * When kernel touch the user page, the user page may be have been marked
> - * poison but still mapped in user space, if without this page, the kernel
> - * can guarantee the data integrity and operation success, the kernel is
> - * better to check the posion status and avoid touching it, be good not to
> - * panic, coredump for process fatal signal is a sample case matching this
> - * scenario. Or if kernel can't guarantee the data integrity, it's better
> - * not to call this function, let kernel touch the poison page and get to
> - * panic.
> - */
> -static inline bool is_page_poisoned(struct page *page)
> -{
> -	if (PageHWPoison(page))
> -		return true;
> -	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
> -		return true;
> -
> -	return false;
> -}
> -
>  extern unsigned long highest_memmap_pfn;
>  
>  /*
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
