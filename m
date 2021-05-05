Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8663746E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 19:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbhEERcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 13:32:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239815AbhEERZj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 13:25:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86517AD5C;
        Wed,  5 May 2021 17:24:41 +0000 (UTC)
Subject: Re: [PATCH v9 01/96] mm: Optimise nth_page for contiguous memmap
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20210505150628.111735-1-willy@infradead.org>
 <20210505150628.111735-2-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7557fdb7-dccf-16fc-3c30-51532558dc6f@suse.cz>
Date:   Wed, 5 May 2021 19:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505150628.111735-2-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/21 5:04 PM, Matthew Wilcox (Oracle) wrote:
> If the memmap is virtually contiguous (either because we're using
> a virtually mapped memmap or because we don't support a discontig
> memmap at all), then we can implement nth_page() by simple addition.
> Contrary to popular belief, the compiler is not able to optimise this
> itself for a vmemmap configuration.  This reduces one example user (sg.c)
> by four instructions:
> 
>         struct page *page = nth_page(rsv_schp->pages[k], offset >> PAGE_SHIFT);
> 
> before:
>    49 8b 45 70             mov    0x70(%r13),%rax
>    48 63 c9                movslq %ecx,%rcx
>    48 c1 eb 0c             shr    $0xc,%rbx
>    48 8b 04 c8             mov    (%rax,%rcx,8),%rax
>    48 2b 05 00 00 00 00    sub    0x0(%rip),%rax
>            R_X86_64_PC32      vmemmap_base-0x4
>    48 c1 f8 06             sar    $0x6,%rax
>    48 01 d8                add    %rbx,%rax
>    48 c1 e0 06             shl    $0x6,%rax
>    48 03 05 00 00 00 00    add    0x0(%rip),%rax
>            R_X86_64_PC32      vmemmap_base-0x4
> 
> after:
>    49 8b 45 70             mov    0x70(%r13),%rax
>    48 63 c9                movslq %ecx,%rcx
>    48 c1 eb 0c             shr    $0xc,%rbx
>    48 c1 e3 06             shl    $0x6,%rbx
>    48 03 1c c8             add    (%rax,%rcx,8),%rbx
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/mm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 25b9041f9925..2327f99b121f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -234,7 +234,11 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
>  int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
>  		pgoff_t index, gfp_t gfp, void **shadowp);
>  
> +#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> +#else
> +#define nth_page(page,n) ((page) + (n))
> +#endif
>  
>  /* to align the pointer to the (next) page boundary */
>  #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
> 

