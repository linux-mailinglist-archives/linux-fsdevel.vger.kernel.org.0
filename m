Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0104130F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhIUJwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 05:52:14 -0400
Received: from out0.migadu.com ([94.23.1.103]:57839 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhIUJwM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:52:12 -0400
Date:   Tue, 21 Sep 2021 18:50:34 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1632217840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPRQDB+cf55TSto6+2IaK/1yaAZ8EqxZw27am8rgyfE=;
        b=QwK2TqI8SGnkU2Q64iH5TYfsIO7EcLgz41GXymySEHouHrYP7FGITUs7008YIDBYf/qcvO
        WtlmUoN9aZYv5mYRQQ/bDmxF5ttB6BPISY5HJAU8S8eo3ou83lqcGgCg4/jqNnxuUcqGRK
        bt+lEGsp2xhybzhWNyNvvRtRwnnzbpE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: hwpoison: handle non-anonymous THP correctly
Message-ID: <20210921095034.GB817765@u2004>
References: <20210914183718.4236-1-shy828301@gmail.com>
 <20210914183718.4236-5-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914183718.4236-5-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:18AM -0700, Yang Shi wrote:
> Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
> support for tmpfs and read-only file cache has been added.  They could
> be offlined by split THP, just like anonymous THP.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/memory-failure.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3e06cb9d5121..6f72aab8ec4a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1150,13 +1150,16 @@ static int __get_hwpoison_page(struct page *page)
>  
>  	if (PageTransHuge(head)) {
>  		/*
> -		 * Non anonymous thp exists only in allocation/free time. We
> -		 * can't handle such a case correctly, so let's give it up.
> -		 * This should be better than triggering BUG_ON when kernel
> -		 * tries to touch the "partially handled" page.
> +		 * We can't handle allocating or freeing THPs, so let's give
> +		 * it up. This should be better than triggering BUG_ON when
> +		 * kernel tries to touch the "partially handled" page.
> +		 *
> +		 * page->mapping won't be initialized until the page is added
> +		 * to rmap or page cache.  Use this as an indicator for if
> +		 * this is an instantiated page.
>  		 */
> -		if (!PageAnon(head)) {
> -			pr_err("Memory failure: %#lx: non anonymous thp\n",
> +		if (!head->mapping) {
> +			pr_err("Memory failure: %#lx: non instantiated thp\n",
>  				page_to_pfn(page));
>  			return 0;
>  		}

How about cleaning up this whole "PageTransHuge()" block?  As explained in
commit 415c64c1453a (mm/memory-failure: split thp earlier in memory error
handling), this check was introduced to avoid that non-anonymous thp is
considered as hugetlb and code for hugetlb is executed (resulting in crash).

With recent improvement in __get_hwpoison_page(), this confusion never
happens (because hugetlb check is done before this check), so this check
seems to finish its role.

Thanks,
Naoya Horiguchi

> @@ -1415,12 +1418,12 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>  static int try_to_split_thp_page(struct page *page, const char *msg)
>  {
>  	lock_page(page);
> -	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> +	if (!page->mapping || unlikely(split_huge_page(page))) {
>  		unsigned long pfn = page_to_pfn(page);
>  
>  		unlock_page(page);
> -		if (!PageAnon(page))
> -			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
> +		if (!page->mapping)
> +			pr_info("%s: %#lx: not instantiated thp\n", msg, pfn);
>  		else
>  			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
>  		put_page(page);
> -- 
> 2.26.2
> 
