Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A528037B222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 01:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhEKXGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 19:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKXGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 19:06:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19443C061574;
        Tue, 11 May 2021 16:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p90x9jEmQHND6fT7ufpXCKutOlzP8zjwAk/wUNBLalg=; b=U8SozuRvdhbYdNEKn+H/SqM6pR
        j31ruaTHW/AhJl8hSkM10yLKM/b8XqCa+aX4G4eg/6/vQgo69mxwNtIgiRtJD6tKQIqE51zXxGi8Z
        tku0eiD1yfoSJ3xNwIHV7++0vuQCFPCwgUCChBv0MiuvqKHF7Mr0q/vvyNKHGqIn353bMZRdKn1j4
        be2BJYeT+JMlhnupBDlT2ANFfIVAm/8F5SPL56ujiiIjfI/d7/6QFhF513bG3Sker7cv3uyaJw3Zq
        VjDRbgxhEa+9DiIqXBs7XFLrhLuXtM5l6LDr1m0SjRMj5CepfvilFtDf9b474sw7eYytMm1aoCqxz
        4sQhcsvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgbPa-007l6k-Jc; Tue, 11 May 2021 23:03:42 +0000
Date:   Wed, 12 May 2021 00:03:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, ziy@nvidia.com,
        william.kucharski@oracle.com, yang.shi@linux.alibaba.com,
        aneesh.kumar@linux.ibm.com, rcampbell@nvidia.com,
        songliubraving@fb.com, kirill.shutemov@linux.intel.com,
        riel@surriel.com, hannes@cmpxchg.org, minchan@kernel.org,
        hughd@google.com, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mm/huge_memory.c: use page->deferred_list
Message-ID: <YJsNRtg5IcMY7V/F@casper.infradead.org>
References: <20210511134857.1581273-1-linmiaohe@huawei.com>
 <20210511134857.1581273-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511134857.1581273-3-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 09:48:54PM +0800, Miaohe Lin wrote:
> Now that we can represent the location of ->deferred_list instead of
> ->mapping + ->index, make use of it to improve readability.
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..76ca1eb2a223 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
>  	list_for_each_safe(pos, next, &ds_queue->split_queue) {
> -		page = list_entry((void *)pos, struct page, mapping);
> +		page = list_entry((void *)pos, struct page, deferred_list);
>  		page = compound_head(page);

This is an equivalent transformation, but it doesn't really go far
enough.  I think you want something like this:

	struct page *page, *next;

	list_for_each_entry_safe(page, next, &ds_queue->split_queue,
							deferred_list) {
		struct page *head = page - 1;
		... then use head throughout ...
	}

