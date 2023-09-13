Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69E379F0B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjIMR4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMR4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:56:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E01419AF;
        Wed, 13 Sep 2023 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j6TR8SsaVNvXoZXM4p/X/ufLRTS7CLck9GylhLcr1pc=; b=QeAR9aJryEAZJrtFCudhXKDxSz
        H5VXRj/oxyS2qFjva1YVKSyydJvO/mb6S6E89Zcl5M0wGSgx0a/Mr9Aes8l0gqhFXtfdLqSxBPpLz
        pY4zFybsnQ7KsMfP2uHON558nFCdGHpl53X5MKFQbDywZIytry2FDPvi/ynDYoqf+c3l6USNb4iiK
        X//XRYh2fRmoJF3Nl2BfH/LQQAoIaxF5skuRyXOVR5oW9cR2F4hGw/zdue20NPVABOZD1uhDUGNxx
        RgOlO3y1xYLFGel/VHJRUyWj3XDXt/jcrbC0VM9bfXWH80InfSRLuaHuZQ1Sjr7g9eyln5CaMyWyY
        pUii1Ipw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgU5s-00FIt1-Ok; Wed, 13 Sep 2023 17:56:04 +0000
Date:   Wed, 13 Sep 2023 18:56:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sourav Panda <souravpanda@google.com>
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
        rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 1/1] mm: report per-page metadata information
Message-ID: <ZQH3tHbz2ghsyqHG@casper.infradead.org>
References: <20230913173000.4016218-1-souravpanda@google.com>
 <20230913173000.4016218-2-souravpanda@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913173000.4016218-2-souravpanda@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 10:30:00AM -0700, Sourav Panda wrote:
> @@ -387,8 +390,12 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
>  
>  	while (nr_pages--) {
>  		page = alloc_pages_node(nid, gfp_mask, 0);
> -		if (!page)
> +		if (!page) {
>  			goto out;
> +		} else {
> +			__mod_node_page_state(NODE_DATA(page_to_nid(page)),
> +					      NR_PAGE_METADATA, 1);
> +		}
>  		list_add_tail(&page->lru, list);

What a strange way of writing this.  Why not simply:

		if (!page)
			goto out;
+		__mod_node_page_state(NODE_DATA(page_to_nid(page)),
+				NR_PAGE_METADATA, 1);
		list_add_tail(&page->lru, list);

> @@ -314,6 +319,10 @@ static void free_page_ext(void *addr)
>  		BUG_ON(PageReserved(page));
>  		kmemleak_free(addr);
>  		free_pages_exact(addr, table_size);
> +
> +		__mod_node_page_state(NODE_DATA(page_to_nid(page)), NR_PAGE_METADATA,
> +				      (long)-1 * (PAGE_ALIGN(table_size) >> PAGE_SHIFT));

Why not spell that as "-1L"?

And while I'm asking questions, why NODE_DATA(page_to_nid(page)) instead
of page_pgdat(page)?

> @@ -2274,4 +2275,24 @@ static int __init extfrag_debug_init(void)
>  }
>  
>  module_init(extfrag_debug_init);
> +
> +// Page metadata size (struct page and page_ext) in pages

Don't use // comments.

> +void __init writeout_early_perpage_metadata(void)

"writeout" is something swap does.  I'm sure this has a better name,
though I can't think what it might be.

> +{
> +	int nid;
> +	struct pglist_data *pgdat;
> +
> +	for_each_online_pgdat(pgdat) {
> +		nid = pgdat->node_id;
> +		__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> +				      early_perpage_metadata[nid]);
> +	}
> +}
>  #endif
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 
