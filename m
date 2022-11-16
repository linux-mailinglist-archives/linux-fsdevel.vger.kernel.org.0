Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2C562BA38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiKPKx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 05:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiKPKxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:53:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D365A40479
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:42:31 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id n21so2299198ejb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 02:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAxgUbyddhVo3IpeBqw30ZEwW76ZkPJXdLUvQUYid84=;
        b=d6cfkbaiUCF3jcE7ciXC2aRYYXmw+87IqcIKVhOtpEFdRJZ4KQxm3iVcblx23BHUgr
         HHoa/sDW2T40HWjeQ0kliGvDSS72XP4aauOCABGXC6QG9VIpsAyR1xUR1pt8BJH+DYar
         pkm7PpJ+NTGeeFwTqcLoSZt1WQaVqx7ds2jig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAxgUbyddhVo3IpeBqw30ZEwW76ZkPJXdLUvQUYid84=;
        b=l2g1IuOo4agRLbeQZqSwDRtGBIXRB6g0Sp0PKiZ+E/ytoL4VH6bpGvIeexfquo27+X
         ayQUFVPtlgj0096oI+IBhYhK1pXpkTGyBzcjnKVgCvJZ/x9ieFxsUlki4N9BJ7lTcWOi
         +ncuIVMKl8+gEefTOmGLmldqh+Zb+f8ZiIyg7aBKRA/7Lay6/FAfH0WjRlAfJBjclz8L
         gcQa2LcXUvqTau9H556umOH6HwzACqJwtpD+4Oi8Lmxrh0YTfAc+eqQFDprUZ1r/gokj
         K6pNpl2fx9qlJ0UiRXyAmRbfU3R295hWq7ozBfiGPI8YOAvCDCkfLa6kGN7cjMKD9rJq
         CO7w==
X-Gm-Message-State: ANoB5pnIn3jYsQXom1iha+YH05DgXn/yhUmzhcVGbR7VZlRLnjyxr4oJ
        UiYWVSBFQl2pu16lY62+GzMS3g==
X-Google-Smtp-Source: AA0mqf5vNSHCm0QqWZxKVpOqG6Th29+InWEHYWlpCOTfASasX9eEkW1nFZpzghpLRsB5JUmRrJDGJA==
X-Received: by 2002:a17:906:33da:b0:78d:b046:aaae with SMTP id w26-20020a17090633da00b0078db046aaaemr16631929eja.218.1668595350196;
        Wed, 16 Nov 2022 02:42:30 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7d2da000000b00467c3cbab6fsm4606455edr.77.2022.11.16.02.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:42:29 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:42:27 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vlastimil Babka <vbabka@suse.cz>, linux-media@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Oded Gabbay <ogabbay@kernel.org>,
        linux-mips@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH mm-unstable v1 09/20] mm/gup: reliable R/O long-term
 pinning in COW mappings
Message-ID: <Y3S+kwuxaJKR1A5I@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>,
        linux-media@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Oded Gabbay <ogabbay@kernel.org>, linux-mips@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-10-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:48AM +0100, David Hildenbrand wrote:
> We already support reliable R/O pinning of anonymous memory. However,
> assume we end up pinning (R/O long-term) a pagecache page or the shared
> zeropage inside a writable private ("COW") mapping. The next write access
> will trigger a write-fault and replace the pinned page by an exclusive
> anonymous page in the process page tables to break COW: the pinned page no
> longer corresponds to the page mapped into the process' page table.
> 
> Now that FAULT_FLAG_UNSHARE can break COW on anything mapped into a
> COW mapping, let's properly break COW first before R/O long-term
> pinning something that's not an exclusive anon page inside a COW
> mapping. FAULT_FLAG_UNSHARE will break COW and map an exclusive anon page
> instead that can get pinned safely.
> 
> With this change, we can stop using FOLL_FORCE|FOLL_WRITE for reliable
> R/O long-term pinning in COW mappings.
> 
> With this change, the new R/O long-term pinning tests for non-anonymous
> memory succeed:
>   # [RUN] R/O longterm GUP pin ... with shared zeropage
>   ok 151 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with memfd
>   ok 152 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with tmpfile
>   ok 153 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with huge zeropage
>   ok 154 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with memfd hugetlb (2048 kB)
>   ok 155 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP pin ... with memfd hugetlb (1048576 kB)
>   ok 156 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with shared zeropage
>   ok 157 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with memfd
>   ok 158 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with tmpfile
>   ok 159 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with huge zeropage
>   ok 160 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (2048 kB)
>   ok 161 Longterm R/O pin is reliable
>   # [RUN] R/O longterm GUP-fast pin ... with memfd hugetlb (1048576 kB)
>   ok 162 Longterm R/O pin is reliable
> 
> Note 1: We don't care about short-term R/O-pinning, because they have
> snapshot semantics: they are not supposed to observe modifications that
> happen after pinning.
> 
> As one example, assume we start direct I/O to read from a page and store
> page content into a file: modifications to page content after starting
> direct I/O are not guaranteed to end up in the file. So even if we'd pin
> the shared zeropage, the end result would be as expected -- getting zeroes
> stored to the file.
> 
> Note 2: For shared mappings we'll now always fallback to the slow path to
> lookup the VMA when R/O long-term pining. While that's the necessary price
> we have to pay right now, it's actually not that bad in practice: most
> FOLL_LONGTERM users already specify FOLL_WRITE, for example, along with
> FOLL_FORCE because they tried dealing with COW mappings correctly ...
> 
> Note 3: For users that use FOLL_LONGTERM right now without FOLL_WRITE,
> such as VFIO, we'd now no longer pin the shared zeropage. Instead, we'd
> populate exclusive anon pages that we can pin. There was a concern that
> this could affect the memlock limit of existing setups.
> 
> For example, a VM running with VFIO could run into the memlock limit and
> fail to run. However, we essentially had the same behavior already in
> commit 17839856fd58 ("gup: document and work around "COW can break either
> way" issue") which got merged into some enterprise distros, and there were
> not any such complaints. So most probably, we're fine.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

I don't think my ack is any good for the implementation, but for the
driver side semantics this sounds like what we want :-)

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  include/linux/mm.h | 27 ++++++++++++++++++++++++---
>  mm/gup.c           | 10 +++++-----
>  mm/huge_memory.c   |  2 +-
>  mm/hugetlb.c       |  7 ++++---
>  4 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6bd2ee5872dd..e8cc838f42f9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3095,8 +3095,12 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
>   * Must be called with the (sub)page that's actually referenced via the
>   * page table entry, which might not necessarily be the head page for a
>   * PTE-mapped THP.
> + *
> + * If the vma is NULL, we're coming from the GUP-fast path and might have
> + * to fallback to the slow path just to lookup the vma.
>   */
> -static inline bool gup_must_unshare(unsigned int flags, struct page *page)
> +static inline bool gup_must_unshare(struct vm_area_struct *vma,
> +				    unsigned int flags, struct page *page)
>  {
>  	/*
>  	 * FOLL_WRITE is implicitly handled correctly as the page table entry
> @@ -3109,8 +3113,25 @@ static inline bool gup_must_unshare(unsigned int flags, struct page *page)
>  	 * Note: PageAnon(page) is stable until the page is actually getting
>  	 * freed.
>  	 */
> -	if (!PageAnon(page))
> -		return false;
> +	if (!PageAnon(page)) {
> +		/*
> +		 * We only care about R/O long-term pining: R/O short-term
> +		 * pinning does not have the semantics to observe successive
> +		 * changes through the process page tables.
> +		 */
> +		if (!(flags & FOLL_LONGTERM))
> +			return false;
> +
> +		/* We really need the vma ... */
> +		if (!vma)
> +			return true;
> +
> +		/*
> +		 * ... because we only care about writable private ("COW")
> +		 * mappings where we have to break COW early.
> +		 */
> +		return is_cow_mapping(vma->vm_flags);
> +	}
>  
>  	/* Paired with a memory barrier in page_try_share_anon_rmap(). */
>  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> diff --git a/mm/gup.c b/mm/gup.c
> index 5182abaaecde..01116699c863 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -578,7 +578,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		}
>  	}
>  
> -	if (!pte_write(pte) && gup_must_unshare(flags, page)) {
> +	if (!pte_write(pte) && gup_must_unshare(vma, flags, page)) {
>  		page = ERR_PTR(-EMLINK);
>  		goto out;
>  	}
> @@ -2338,7 +2338,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>  			goto pte_unmap;
>  		}
>  
> -		if (!pte_write(pte) && gup_must_unshare(flags, page)) {
> +		if (!pte_write(pte) && gup_must_unshare(NULL, flags, page)) {
>  			gup_put_folio(folio, 1, flags);
>  			goto pte_unmap;
>  		}
> @@ -2506,7 +2506,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  		return 0;
>  	}
>  
> -	if (!pte_write(pte) && gup_must_unshare(flags, &folio->page)) {
> +	if (!pte_write(pte) && gup_must_unshare(NULL, flags, &folio->page)) {
>  		gup_put_folio(folio, refs, flags);
>  		return 0;
>  	}
> @@ -2572,7 +2572,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		return 0;
>  	}
>  
> -	if (!pmd_write(orig) && gup_must_unshare(flags, &folio->page)) {
> +	if (!pmd_write(orig) && gup_must_unshare(NULL, flags, &folio->page)) {
>  		gup_put_folio(folio, refs, flags);
>  		return 0;
>  	}
> @@ -2612,7 +2612,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		return 0;
>  	}
>  
> -	if (!pud_write(orig) && gup_must_unshare(flags, &folio->page)) {
> +	if (!pud_write(orig) && gup_must_unshare(NULL, flags, &folio->page)) {
>  		gup_put_folio(folio, refs, flags);
>  		return 0;
>  	}
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 68d00196b519..dec7a7c0eca8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1434,7 +1434,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(flags))
>  		return NULL;
>  
> -	if (!pmd_write(*pmd) && gup_must_unshare(flags, page))
> +	if (!pmd_write(*pmd) && gup_must_unshare(vma, flags, page))
>  		return ERR_PTR(-EMLINK);
>  
>  	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 383b26069b33..c3aab6d5b7aa 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6195,7 +6195,8 @@ static void record_subpages_vmas(struct page *page, struct vm_area_struct *vma,
>  	}
>  }
>  
> -static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
> +static inline bool __follow_hugetlb_must_fault(struct vm_area_struct *vma,
> +					       unsigned int flags, pte_t *pte,
>  					       bool *unshare)
>  {
>  	pte_t pteval = huge_ptep_get(pte);
> @@ -6207,7 +6208,7 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
>  		return false;
>  	if (flags & FOLL_WRITE)
>  		return true;
> -	if (gup_must_unshare(flags, pte_page(pteval))) {
> +	if (gup_must_unshare(vma, flags, pte_page(pteval))) {
>  		*unshare = true;
>  		return true;
>  	}
> @@ -6336,7 +6337,7 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 * directly from any kind of swap entries.
>  		 */
>  		if (absent ||
> -		    __follow_hugetlb_must_fault(flags, pte, &unshare)) {
> +		    __follow_hugetlb_must_fault(vma, flags, pte, &unshare)) {
>  			vm_fault_t ret;
>  			unsigned int fault_flags = 0;
>  
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
