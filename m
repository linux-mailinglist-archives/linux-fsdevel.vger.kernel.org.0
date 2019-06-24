Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F4B50B0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 14:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfFXMrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 08:47:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46120 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfFXMro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:47:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so21557611edr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5R1XuJC9DE2YVjPQXPWriy0pxsYFqY6xXdBGHnrUnJs=;
        b=a2aeOwwqRc9sdanvz4ex1HZ3aDnbv42+RPlV99fm907NTH5b2ydB4YRrV8RXAsEsrg
         ZktJtepV3h00JBNvjW79HzJUAmHQOEibl375GFp3YLKds2zjIP2HuW0/fuhRBybWokZ5
         xOTpPtThyzge4iQ3ia1LpIffvCMUCkyjG01tU2HRseOpLuubnP3MlMoIMGwL6/EJJ4nX
         +GxOr+mOTru/UXDm0fZPauhHI2X/LF+35LNRW5E4b44TtqnOHeV1RUqSfAedXTcD1hFG
         6PVQaIJTnIbsXo1yxe6hHrj0L5DRk8ZnZtBXYVhaqEBEdPPH/Ym081LI3qjegmyeYuqD
         NSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5R1XuJC9DE2YVjPQXPWriy0pxsYFqY6xXdBGHnrUnJs=;
        b=WYn7Ze6Tnqxqffj6oGHc+NvRhwnF1mq7yy9sS3y5vR0IG9lKS9wgjTaSa6r8qO2CcA
         YnaYwl4T3hfwUslO06vx6EAJEadpDNSd4rDY2jfeBuwMzfZxFVFi+Kekrm3IXu8c/FEC
         yihYEaf2MuulK7OmjxN8zP+hr/Os2ryy397kqmSAVlNeDHLrzZPIHQp17k0lmRRDHEmv
         vbMIr4hmLJpHJPKFMvDmne15QvxOe2SiU15eBu6X9pVr0zZ4G9RQm8mJsJyBncHUyuVA
         3L1LaySB3aWRxVGONekHqTPbrimk+g7B206nzTJJgqF2G9WDWro8sbtuZg7/v574I6WQ
         UJHw==
X-Gm-Message-State: APjAAAUQ9xkRRKkzqC0N9Xg7U4gvvkAqaqAHcGSKvFr6E8Bg7aG0Z2CJ
        IGjSYdK1lcj6PqzitQ4SjvqWvg==
X-Google-Smtp-Source: APXvYqw6YlhAC3oIiA9s+aVARSckup/URDhBj1oaqoxAsYqXrJAtuunouiuEqz7c66HAgftkpi/aGg==
X-Received: by 2002:a17:907:2114:: with SMTP id qn20mr112521670ejb.138.1561380462147;
        Mon, 24 Jun 2019 05:47:42 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f7sm3884261edb.12.2019.06.24.05.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:47:41 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D1CEA10439E; Mon, 24 Jun 2019 15:47:46 +0300 (+03)
Date:   Mon, 24 Jun 2019 15:47:46 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Message-ID: <20190624124746.7evd2hmbn3qg3tfs@box>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-6-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623054749.4016638-6-songliubraving@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 22, 2019 at 10:47:48PM -0700, Song Liu wrote:
> This patch is (hopefully) the first step to enable THP for non-shmem
> filesystems.
> 
> This patch enables an application to put part of its text sections to THP
> via madvise, for example:
> 
>     madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);
> 
> We tried to reuse the logic for THP on tmpfs.
> 
> Currently, write is not supported for non-shmem THP. khugepaged will only
> process vma with VM_DENYWRITE. The next patch will handle writes, which
> would only happen when the vma with VM_DENYWRITE is unmapped.
> 
> An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
> feature.
> 
> Acked-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  mm/Kconfig      | 11 ++++++
>  mm/filemap.c    |  4 +--
>  mm/khugepaged.c | 90 ++++++++++++++++++++++++++++++++++++++++---------
>  mm/rmap.c       | 12 ++++---
>  4 files changed, 96 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index f0c76ba47695..0a8fd589406d 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -762,6 +762,17 @@ config GUP_BENCHMARK
>  
>  	  See tools/testing/selftests/vm/gup_benchmark.c
>  
> +config READ_ONLY_THP_FOR_FS
> +	bool "Read-only THP for filesystems (EXPERIMENTAL)"
> +	depends on TRANSPARENT_HUGE_PAGECACHE && SHMEM
> +
> +	help
> +	  Allow khugepaged to put read-only file-backed pages in THP.
> +
> +	  This is marked experimental because it is a new feature. Write
> +	  support of file THPs will be developed in the next few release
> +	  cycles.
> +
>  config ARCH_HAS_PTE_SPECIAL
>  	bool
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5f072a113535..e79ceccdc6df 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -203,8 +203,8 @@ static void unaccount_page_cache_page(struct address_space *mapping,
>  		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
>  		if (PageTransHuge(page))
>  			__dec_node_page_state(page, NR_SHMEM_THPS);
> -	} else {
> -		VM_BUG_ON_PAGE(PageTransHuge(page), page);
> +	} else if (PageTransHuge(page)) {
> +		__dec_node_page_state(page, NR_FILE_THPS);
>  	}
>  
>  	/*
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 158cad542627..090127e4e185 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -48,6 +48,7 @@ enum scan_result {
>  	SCAN_CGROUP_CHARGE_FAIL,
>  	SCAN_EXCEED_SWAP_PTE,
>  	SCAN_TRUNCATED,
> +	SCAN_PAGE_HAS_PRIVATE,
>  };
>  
>  #define CREATE_TRACE_POINTS
> @@ -404,7 +405,11 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>  	    (vm_flags & VM_NOHUGEPAGE) ||
>  	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>  		return false;
> -	if (shmem_file(vma->vm_file)) {
> +
> +	if (shmem_file(vma->vm_file) ||
> +	    (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +	     vma->vm_file &&
> +	     (vm_flags & VM_DENYWRITE))) {
>  		if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE))
>  			return false;
>  		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> @@ -456,8 +461,9 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  	unsigned long hstart, hend;
>  
>  	/*
> -	 * khugepaged does not yet work on non-shmem files or special
> -	 * mappings. And file-private shmem THP is not supported.
> +	 * khugepaged only supports read-only files for non-shmem files.
> +	 * khugepaged does not yet work on special mappings. And
> +	 * file-private shmem THP is not supported.
>  	 */
>  	if (!hugepage_vma_check(vma, vm_flags))
>  		return 0;
> @@ -1287,12 +1293,12 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  }
>  
>  /**
> - * collapse_file - collapse small tmpfs/shmem pages into huge one.
> + * collapse_file - collapse filemap/tmpfs/shmem pages into huge one.
>   *
>   * Basic scheme is simple, details are more complex:
>   *  - allocate and lock a new huge page;
>   *  - scan page cache replacing old pages with the new one
> - *    + swap in pages if necessary;
> + *    + swap/gup in pages if necessary;
>   *    + fill in gaps;
>   *    + keep old pages around in case rollback is required;
>   *  - if replacing succeeds:
> @@ -1316,7 +1322,11 @@ static void collapse_file(struct mm_struct *mm,
>  	LIST_HEAD(pagelist);
>  	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
>  	int nr_none = 0, result = SCAN_SUCCEED;
> +	bool is_shmem = shmem_file(file);
>  
> +#ifndef CONFIG_READ_ONLY_THP_FOR_FS
> +	VM_BUG_ON(!is_shmem);
> +#endif

	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);

>  	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
>  
>  	/* Only allocate from the target node */
> @@ -1348,7 +1358,8 @@ static void collapse_file(struct mm_struct *mm,
>  	} while (1);
>  
>  	__SetPageLocked(new_page);
> -	__SetPageSwapBacked(new_page);
> +	if (is_shmem)
> +		__SetPageSwapBacked(new_page);
>  	new_page->index = start;
>  	new_page->mapping = mapping;
>  
> @@ -1363,7 +1374,7 @@ static void collapse_file(struct mm_struct *mm,
>  		struct page *page = xas_next(&xas);
>  
>  		VM_BUG_ON(index != xas.xa_index);
> -		if (!page) {
> +		if (is_shmem && !page) {
>  			/*
>  			 * Stop if extent has been truncated or hole-punched,
>  			 * and is now completely empty.
> @@ -1384,7 +1395,7 @@ static void collapse_file(struct mm_struct *mm,
>  			continue;
>  		}
>  
> -		if (xa_is_value(page) || !PageUptodate(page)) {
> +		if (is_shmem && (xa_is_value(page) || !PageUptodate(page))) {
>  			xas_unlock_irq(&xas);
>  			/* swap in or instantiate fallocated page */
>  			if (shmem_getpage(mapping->host, index, &page,
> @@ -1392,6 +1403,23 @@ static void collapse_file(struct mm_struct *mm,
>  				result = SCAN_FAIL;
>  				goto xa_unlocked;
>  			}
> +		} else if (!page || xa_is_value(page)) {
> +			xas_unlock_irq(&xas);
> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
> +						  index, PAGE_SIZE);
> +			lru_add_drain();

Why?

> +			page = find_lock_page(mapping, index);
> +			if (unlikely(page == NULL)) {
> +				result = SCAN_FAIL;
> +				goto xa_unlocked;
> +			}
> +		} else if (!PageUptodate(page)) {

Maybe we should try wait_on_page_locked() here before give up?

> +			VM_BUG_ON(is_shmem);
> +			result = SCAN_FAIL;
> +			goto xa_locked;
> +		} else if (!is_shmem && PageDirty(page)) {
> +			result = SCAN_FAIL;
> +			goto xa_locked;
>  		} else if (trylock_page(page)) {
>  			get_page(page);
>  			xas_unlock_irq(&xas);
-- 
 Kirill A. Shutemov
