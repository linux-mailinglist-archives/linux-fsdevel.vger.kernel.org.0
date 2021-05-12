Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177E437B486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 05:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhELDaT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 23:30:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2634 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 23:30:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg0YR1p0YzQkTx;
        Wed, 12 May 2021 11:25:47 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:29:06 +0800
Subject: Re: [PATCH 3/8] mm/debug: Factor PagePoisoned out of __dump_page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <akpm@linux-foundation.org>
CC:     William Kucharski <william.kucharski@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210430145549.2662354-1-willy@infradead.org>
 <20210430145549.2662354-4-willy@infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <2baf684e-f35d-5c42-fa11-1e061a12a81f@huawei.com>
Date:   Wed, 12 May 2021 11:29:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210430145549.2662354-4-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/4/30 22:55, Matthew Wilcox (Oracle) wrote:
> Move the PagePoisoned test into dump_page().  Skip the hex print
> for poisoned pages -- we know they're full of ffffffff.  Move the
> reason printing from __dump_page() to dump_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   mm/debug.c | 25 +++++++------------------
>   1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 84cdcd0f7bd3..e73fe0a8ec3d 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -42,11 +42,10 @@ const struct trace_print_flags vmaflag_names[] = {
>   	{0, NULL}
>   };
>   
> -static void __dump_page(struct page *page, const char *reason)
> +static void __dump_page(struct page *page)
>   {
>   	struct page *head = compound_head(page);
>   	struct address_space *mapping;
> -	bool page_poisoned = PagePoisoned(page);
>   	bool compound = PageCompound(page);
>   	/*
>   	 * Accessing the pageblock without the zone lock. It could change to
> @@ -58,16 +57,6 @@ static void __dump_page(struct page *page, const char *reason)
>   	int mapcount;
>   	char *type = "";
>   
> -	/*
> -	 * If struct page is poisoned don't access Page*() functions as that
> -	 * leads to recursive loop. Page*() check for poisoned pages, and calls
> -	 * dump_page() when detected.
> -	 */
> -	if (page_poisoned) {
> -		pr_warn("page:%px is uninitialized and poisoned", page);
> -		goto hex_only;
> -	}
> -
>   	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
>   		/*
>   		 * Corrupt page, so we cannot call page_mapping. Instead, do a
> @@ -173,8 +162,6 @@ static void __dump_page(struct page *page, const char *reason)
>   
>   	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
>   		page_cma ? " CMA" : "");
> -
> -hex_only:
>   	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>   			sizeof(unsigned long), page,
>   			sizeof(struct page), false);
> @@ -182,14 +169,16 @@ static void __dump_page(struct page *page, const char *reason)
>   		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
>   			sizeof(unsigned long), head,
>   			sizeof(struct page), false);
> -
> -	if (reason)
> -		pr_warn("page dumped because: %s\n", reason);
>   }
>   
>   void dump_page(struct page *page, const char *reason)
>   {
> -	__dump_page(page, reason);
> +	if (PagePoisoned(page))
> +		pr_warn("page:%p is uninitialized and poisoned", page);
> +	else
> +		__dump_page(page);

Hi Matthew, dump_page_owenr() should be called when !PagePoisoned, right?


> +	if (reason)
> +		pr_warn("page dumped because: %s\n", reason);
>   	dump_page_owner(page);
>   }
>   EXPORT_SYMBOL(dump_page);
> 
