Return-Path: <linux-fsdevel+bounces-1666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12FD7DD70C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 21:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AD11C20D21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 20:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2D7225B1;
	Tue, 31 Oct 2023 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wo9lFuiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFAA11195;
	Tue, 31 Oct 2023 20:27:24 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B1DE4;
	Tue, 31 Oct 2023 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J24EvlKL0HTV1heFD4NanY/502+VJ56TUzZ3rmsx9yE=; b=Wo9lFuiN+tfkVPX49uRGez4hyH
	pG0l/rW81DbJuj66DwFPin39Dl56jTX5KQzu05WHnDAgpTYPL7hb7vfyD5fRtr51+9lElDrvYaMsD
	TGkDyBtHFZLpqwN5z6XEXObeg6bGTHCAQY3gjbyTWmCaSKKBLeKeKDIxTEhoh1RtNWwg7ZDxu62JQ
	yo/AXubuf0t85nkv+tFHGtZi3rt9aAVOs0Tk033CXvZB7Y8ZUuWczlhNhDoGKuXSJa9hFTMeEuIwO
	XeqfEXv05OSNVqpXmv1i69SfIWx55wA3BbBY+2XvdS79r6ggFJmb+ihfMqtewfqSnagfr90c1YiF8
	J7371lqw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxvJy-00C5Ur-MW; Tue, 31 Oct 2023 20:26:42 +0000
Date: Tue, 31 Oct 2023 20:26:42 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com,
	rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com,
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, weixugc@google.com
Subject: Re: [PATCH v3 1/1] mm: report per-page metadata information
Message-ID: <ZUFjAj8Liaa/Ijmm@casper.infradead.org>
References: <20231031174459.459480-1-souravpanda@google.com>
 <20231031174459.459480-2-souravpanda@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031174459.459480-2-souravpanda@google.com>

On Tue, Oct 31, 2023 at 10:44:59AM -0700, Sourav Panda wrote:
> +++ b/mm/hugetlb.c
> @@ -1790,6 +1790,10 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>  		destroy_compound_gigantic_folio(folio, huge_page_order(h));
>  		free_gigantic_folio(folio, huge_page_order(h));
>  	} else {
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +		__mod_node_page_state(NODE_DATA(page_to_nid(&folio->page)),
> +				      NR_PAGE_METADATA, -huge_page_order(h));
> +#endif

surely,
		__node_stat_sub_folio(folio, NR_PAGE_METADATA)

> @@ -2175,7 +2179,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>  		__count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
>  		return NULL;
>  	}
> -
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +	__mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, huge_page_order(h));

	__node_stat_add_folio(folio, NR_PAGE_METADATA)

(create the folio first ...)

> +		__mod_node_page_state(NODE_DATA(page_to_nid(page)),
> +				      NR_PAGE_METADATA, 1);

Are you allergic to page_pgdat()?

> @@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist_data *pgdat)
>  			panic("Failed to allocate %ld bytes for node %d memory map\n",
>  			      size, pgdat->node_id);
>  		pgdat->node_mem_map = map + offset;
> +		mod_node_early_perpage_metadata(pgdat->node_id,
> +						PAGE_ALIGN(size) >> PAGE_SHIFT);

I swear I said to use DIV_ROUND_UP().  Yes, I did:

https://lore.kernel.org/linux-mm/ZS%2Fm1KRwTLkcJY8y@casper.infradead.org/

Why have you done something different and claimed I said to do it?
You've annoyed me now; I shan't review the rest of this.

