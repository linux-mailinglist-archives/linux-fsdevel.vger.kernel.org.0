Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5D156071
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 22:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGVFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 16:05:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14260 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgBGVFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:05:54 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3dd1220000>; Fri, 07 Feb 2020 13:05:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Feb 2020 13:05:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Feb 2020 13:05:52 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 21:05:52 +0000
Subject: Re: [PATCH v5 01/12] mm: dump_page(): better diagnostics for compound
 pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
 <20200207033735.308000-2-jhubbard@nvidia.com>
 <20200207172746.GE8731@bombadil.infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3477bf65-64dc-7854-6720-589f7fcdac07@nvidia.com>
Date:   Fri, 7 Feb 2020 13:05:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207172746.GE8731@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581109538; bh=7ut/wdkDS0FpA4HZltu5HfFGDc856CHfoKcOQZwZpKY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qz9fEfJsgWpbE4ES0N4b0U2KdwU7WUZEPZkyZm1lWT+ssrEe4QmCYIAwcG3u59fsO
         95bqQChY9FUbxQMy5LQyXcscufnj54mi7NnbUyVO1c9YXqIGoXNGYVv7DfIdlzn4Tj
         6eWA4Vw0ML9zfUsTRNEdC/sts2heSOLYkbUKAXS7fxbr6Uq8tSFyBtoxinnLFhqb6n
         aySRLrY5vdGSNUXd4haLTwimnVQ9jcXQ0irFEl9ctRbxH1z9GqDwtOj3hAHBktAXL6
         8uczRol4+YH/ds6EseuIL253d1QTCTZ+4mXBq7e7xq9kpwVILZjJfMVmcYDSZAZOkm
         0rCBfeUgW//tg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/20 9:27 AM, Matthew Wilcox wrote:
...
> 
> A definite improvement, but I think we could do better.  For example,
> you've changed PageCompound to PageTail here, whereas we really do want
> to dump some more information for PageHead pages than the plain vanilla
> order-0 page has.  Another thing is that page_mapping() calls compound_head(),
> so if the page is corrupted, we're going to get a funky pointer dereference.
> 
> I spent a bit of time on this reimplementation ... what do you think?
> 

It looks fine to me. I gave it a quick spin, here's the output for a normal
and a huge page, and it has everything we want to see:

page:ffffea0010f0d640 refcount:1025 mapcount:1 mapping:0000000021857089 index:0xed
anon flags: 0x17ffe0000080036(referenced|uptodate|lru|active|swapbacked)
raw: 017ffe0000080036 ffffea0011731f08 ffffea0011730008 ffff8884777272c1
raw: 00000000000000ed 0000000000000000 0000040100000000 0000000000000000
page dumped because: testing dump_page()

page:ffffea0010ef1b80 head:ffffea0010ef0000 refcount:0 mapcount:1 mapping:00000000a8e1c7fa index:0xed order:9 compound_mapcount: 1
anon flags: 0x17ffe0000000000()
raw: 017ffe0000000000 ffffea0010ef0001 ffffea0010ef1b88 dead000000000400
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 017ffe0000090036 ffffea0011734548 ffffea0010ef8008 ffff8884777271b9
head: 000000000000007f 0000000000000000 00000201ffffffff 0000000000000000
page dumped because: testing dump_page()


>  - Print the mapping pointer using %p insted of %px.  The actual value of
>    the pointer can be read out of the raw page dump and using %p gives a
>    chance to correlate it to earlier printk of the mapping pointer.
>  - Add the order of the page for compound pages
>  - Dump the raw head page as well as the raw page being dumped
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index ecccd9f17801..0564d4cb8233 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -44,8 +44,10 @@ const struct trace_print_flags vmaflag_names[] = {
>  
>  void __dump_page(struct page *page, const char *reason)
>  {
> +	struct page *head = compound_head(page);
>  	struct address_space *mapping;
>  	bool page_poisoned = PagePoisoned(page);
> +	bool compound = PageCompound(page);
>  	/*
>  	 * Accessing the pageblock without the zone lock. It could change to
>  	 * "isolate" again in the meantime, but since we are just dumping the
> @@ -66,25 +68,32 @@ void __dump_page(struct page *page, const char *reason)
>  		goto hex_only;
>  	}
>  
> -	mapping = page_mapping(page);
> +	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
> +		/* Corrupt page, cannot call page_mapping */
> +		mapping = page->mapping;
> +		head = page;
> +		compound = false;
> +	} else {
> +		mapping = page_mapping(page);
> +	}
>  
>  	/*
>  	 * Avoid VM_BUG_ON() in page_mapcount().
>  	 * page->_mapcount space in struct page is used by sl[aou]b pages to
>  	 * encode own info.
>  	 */
> -	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
> +	mapcount = PageSlab(head) ? 0 : page_mapcount(head);
>  
> -	if (PageCompound(page))
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
> -			"index:%#lx compound_mapcount: %d\n",
> -			page, page_ref_count(page), mapcount,
> +	if (compound)
> +		pr_warn("page:%px head:%px refcount:%d mapcount:%d mapping:%p "
> +			"index:%#lx order:%u compound_mapcount: %d\n",
> +			page, head, page_ref_count(page), mapcount,
>  			page->mapping, page_to_pgoff(page),
> -			compound_mapcount(page));
> +			compound_order(head), compound_mapcount(page));
>  	else
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
> +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%p index:%#lx\n",
>  			page, page_ref_count(page), mapcount,
> -			page->mapping, page_to_pgoff(page));
> +			mapping, page_to_pgoff(page));
>  	if (PageKsm(page))
>  		type = "ksm ";
>  	else if (PageAnon(page))
> @@ -106,6 +115,10 @@ void __dump_page(struct page *page, const char *reason)
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
>  			sizeof(struct page), false);
> +	if (!page_poisoned && compound)
> +		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
> +			sizeof(unsigned long), head,
> +			sizeof(struct page), false);


Good thought to get the hex dump of the head page in this case, yes.


>  
>  	if (reason)
>  		pr_warn("page dumped because: %s\n", reason);
> 


Seeing as how I want to further enhance dump_page() slightly for this series (to 
include the 3rd struct page's hpage_pincount), would you care to send this as a 
formal patch that I could insert into this series, to replace patch 5?


thanks,
-- 
John Hubbard
NVIDIA
