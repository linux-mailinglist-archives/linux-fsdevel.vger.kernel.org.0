Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0056166D11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 03:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgBUCnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 21:43:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9206 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgBUCnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:43:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e4f43b30000>; Thu, 20 Feb 2020 18:42:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Feb 2020 18:43:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Feb 2020 18:43:32 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 02:43:32 +0000
Subject: Re: [PATCH v7 01/24] mm: Move readahead prototypes from mm.h
To:     Matthew Wilcox <willy@infradead.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <cluster-devel@redhat.com>, <ocfs2-devel@oss.oracle.com>,
        <linux-xfs@vger.kernel.org>
References: <20200219210103.32400-1-willy@infradead.org>
 <20200219210103.32400-2-willy@infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <e065679e-222f-7323-9782-0c4471bb9233@nvidia.com>
Date:   Thu, 20 Feb 2020 18:43:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219210103.32400-2-willy@infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582252979; bh=FupvP/7fBUSXeaHkpIPB/6auVkQxSnSk5TKtwtzmqZs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PTZvZBMqGka5juXI/K7VSjqGZuA2OQhrqobKWw47A6aYHII6j1MhFAvbELI3dGadM
         PrgKfenh6ZhddOY03XwMVWxrJdpVuH9XaaraajiQH62Xt5kO01Jn6Qq64S3BQBsQnu
         FX+2chIKaTlsU4YvxA1ANZxAzhOAPicsBXho8Xa1oRypUcTkxEzLnDv0caGzVLZrPo
         FwY554vv2RX9xx1O6PYXsc2ug3Oc5f7qahsBWhrzIuj6pupPO0et9/uor0PLX1V8Yf
         Sgy5K80isbnmNaNcnOFvHQt/nevDdWbyhIlyy/b+G7tAh95wVP/qHY4GiW4ZIyVq2q
         Oo9GNFt84iUNA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/19/20 1:00 PM, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The readahead code is part of the page cache so should be found in the
> pagemap.h file.  force_page_cache_readahead is only used within mm,
> so move it to mm/internal.h instead.  Remove the parameter names where
> they add no value, and rename the ones which were actively misleading.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/blk-core.c        |  1 +
>  include/linux/mm.h      | 19 -------------------
>  include/linux/pagemap.h |  8 ++++++++
>  mm/fadvise.c            |  2 ++
>  mm/internal.h           |  2 ++
>  5 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 089e890ab208..41417bb93634 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -20,6 +20,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/highmem.h>
>  #include <linux/mm.h>
> +#include <linux/pagemap.h>

Yes. But I think these files also need a similar change:

    fs/btrfs/disk-io.c
    fs/nfs/super.c
    

...because they also use VM_READAHEAD_PAGES, and do not directly include
pagemap.h yet.


>  #include <linux/kernel_stat.h>
>  #include <linux/string.h>
>  #include <linux/init.h>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..68dcda9a2112 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2401,25 +2401,6 @@ extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
>  int __must_check write_one_page(struct page *page);
>  void task_dirty_inc(struct task_struct *tsk);
>  
> -/* readahead.c */
> -#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
> -
> -int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
> -			pgoff_t offset, unsigned long nr_to_read);
> -
> -void page_cache_sync_readahead(struct address_space *mapping,
> -			       struct file_ra_state *ra,
> -			       struct file *filp,
> -			       pgoff_t offset,
> -			       unsigned long size);
> -
> -void page_cache_async_readahead(struct address_space *mapping,
> -				struct file_ra_state *ra,
> -				struct file *filp,
> -				struct page *pg,
> -				pgoff_t offset,
> -				unsigned long size);
> -
>  extern unsigned long stack_guard_gap;
>  /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
>  extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ccb14b6a16b5..24894b9b90c9 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -614,6 +614,14 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
>  void delete_from_page_cache_batch(struct address_space *mapping,
>  				  struct pagevec *pvec);
>  
> +#define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
> +
> +void page_cache_sync_readahead(struct address_space *, struct file_ra_state *,
> +		struct file *, pgoff_t index, unsigned long req_count);


Yes, "struct address_space *mapping" is weird, but I don't know if it's
"misleading", given that it's actually one of the things you have to learn
right from the beginning, with linux-mm, right? Or is that about to change?

I'm not asking to restore this to "struct address_space *mapping", but I thought
it's worth mentioning out loud, especially if you or others are planning on
changing those names or something. Just curious.



thanks,
-- 
John Hubbard
NVIDIA


> +void page_cache_async_readahead(struct address_space *, struct file_ra_state *,
> +		struct file *, struct page *, pgoff_t index,
> +		unsigned long req_count);
> +
>  /*
>   * Like add_to_page_cache_locked, but used to add newly allocated pages:
>   * the page is new, so we can just run __SetPageLocked() against it.
> diff --git a/mm/fadvise.c b/mm/fadvise.c
> index 4f17c83db575..3efebfb9952c 100644
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -22,6 +22,8 @@
>  
>  #include <asm/unistd.h>
>  
> +#include "internal.h"
> +
>  /*
>   * POSIX_FADV_WILLNEED could set PG_Referenced, and POSIX_FADV_NOREUSE could
>   * deactivate the pages and clear PG_Referenced.
> diff --git a/mm/internal.h b/mm/internal.h
> index 3cf20ab3ca01..83f353e74654 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -49,6 +49,8 @@ void unmap_page_range(struct mmu_gather *tlb,
>  			     unsigned long addr, unsigned long end,
>  			     struct zap_details *details);
>  
> +int force_page_cache_readahead(struct address_space *, struct file *,
> +		pgoff_t index, unsigned long nr_to_read);
>  extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
>  		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
>  		unsigned long lookahead_size);
> 



