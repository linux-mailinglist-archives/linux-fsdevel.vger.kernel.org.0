Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6859330B04A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhBATWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 14:22:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231983AbhBATWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612207285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2b/N50hu0sHq/kMoTQCMLs3X1tcdQtb/zYbLnwU7BM=;
        b=eQehGxMSD1Yt3VqGRbujaHOkUo9z0np61Q2s/CBT2VPsHx3jS9xCLMMiLM7V8l1AmLQWNr
        XWh+t03aF96ny7jCCh6JEGAsXeX41iF5qkA3U1YdT+gDyR1kXSNywRzAlXqKcn5EXUtp7l
        /qoI5ou6FFExyz+BRhLgSNYhQQJYP7s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-bsB5R12yMYmvhPGTOiIXaA-1; Mon, 01 Feb 2021 14:21:24 -0500
X-MC-Unique: bsB5R12yMYmvhPGTOiIXaA-1
Received: by mail-qk1-f197.google.com with SMTP id c63so8755007qkd.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 11:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2b/N50hu0sHq/kMoTQCMLs3X1tcdQtb/zYbLnwU7BM=;
        b=bKgUNnJcIZkOGudTjJ96kyvgaZ0VMiDM4hEt1QgEyFHRjmUYaZ44mG3UIhxzzt337d
         tcSMKZKJ6m2dJrXu7vc3cJkIdVFfLeq1Lt9KzjR209oQJ6lmPhaJIq+lQ0TuKxGzhUUd
         gN+lx65qJkFnAcer9ebsqelVNDiQs3IPEevMEHDu8HST4J77zdLNT3N0qYUydikeAPav
         tTWtADrq6d3EtGRGa5IUa26ZuI3c3kDOyjEgK7nywyEAgcDSD1308Bi3QqcuAmZl9HRp
         +hMjXK4t7STpyxkkZ2yQuWvY/oUgfkOtvv4aNLFPS1eq/5JCK7bOvaH5GPSc86xmgwtk
         Hb3A==
X-Gm-Message-State: AOAM533Cb7U0hoNz9wLxWYiyXWQ0Ke9E8NOzArJ59xt601xHTvPYKBqm
        5SAX4Lft3DRHo55O/F1hsjMJBqjs/kBq/whhFRoQL3Wg6LIwF3ZC0no9b7hBJEvYeDYl5yL8DEv
        i0PJBCFT5z8oukcbXLy5elNY89w==
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr16186210qta.309.1612207283700;
        Mon, 01 Feb 2021 11:21:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWmFLJGbGwctGCP9A/nYWy61WeOGTKC6d+y1Ba8IhsTF2WrQd3mliiW1G26lcHYKqEou/z+w==
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr16186156qta.309.1612207283172;
        Mon, 01 Feb 2021 11:21:23 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id o5sm14755572qko.85.2021.02.01.11.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 11:21:22 -0800 (PST)
Date:   Mon, 1 Feb 2021 14:21:20 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 7/9] userfaultfd: add UFFDIO_CONTINUE ioctl
Message-ID: <20210201192120.GG260413@xz-x1>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-8-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128224819.2651899-8-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 02:48:17PM -0800, Axel Rasmussen wrote:
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f94a35296618..79e1f0155afa 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -135,11 +135,14 @@ void hugetlb_show_meminfo(void);
>  unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags);
> +#ifdef CONFIG_USERFAULTFD

I'm confused why this is needed.. hugetlb_mcopy_atomic_pte() should only be
called in userfaultfd.c, but if without uffd config set it won't compile
either:

        obj-$(CONFIG_USERFAULTFD) += userfaultfd.o

>  int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
>  				struct vm_area_struct *dst_vma,
>  				unsigned long dst_addr,
>  				unsigned long src_addr,
> +				enum mcopy_atomic_mode mode,
>  				struct page **pagep);
> +#endif
>  int hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  						struct vm_area_struct *vma,
>  						vm_flags_t vm_flags);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index fb9abaeb4194..2fcb686211e8 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -37,6 +37,22 @@ extern int sysctl_unprivileged_userfaultfd;
>  
>  extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
>  
> +/*
> + * The mode of operation for __mcopy_atomic and its helpers.
> + *
> + * This is almost an implementation detail (mcopy_atomic below doesn't take this
> + * as a parameter), but it's exposed here because memory-kind-specific
> + * implementations (e.g. hugetlbfs) need to know the mode of operation.
> + */
> +enum mcopy_atomic_mode {
> +	/* A normal copy_from_user into the destination range. */
> +	MCOPY_ATOMIC_NORMAL,
> +	/* Don't copy; map the destination range to the zero page. */
> +	MCOPY_ATOMIC_ZEROPAGE,
> +	/* Just setup the dst_vma, without modifying the underlying page(s). */
> +	MCOPY_ATOMIC_CONTINUE,
> +};
> +

Maybe better to keep this to where it's used, e.g. hugetlb.h where we've
defined hugetlb_mcopy_atomic_pte()?

[...]

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6f9d8349f818..3d318ef3d180 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4647,6 +4647,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_USERFAULTFD

So I feel like you added the header ifdef for this.

IMHO we can drop both since that's what we have had.  I agree maybe it's better
to not compile that without CONFIG_USERFAULTFD but that may worth a standalone
patch anyways.

>  /*
>   * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
>   * modifications for huge pages.
> @@ -4656,6 +4657,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    struct vm_area_struct *dst_vma,
>  			    unsigned long dst_addr,
>  			    unsigned long src_addr,
> +			    enum mcopy_atomic_mode mode,
>  			    struct page **pagep)
>  {
>  	struct address_space *mapping;
> @@ -4668,7 +4670,10 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	int ret;
>  	struct page *page;
>  
> -	if (!*pagep) {
> +	mapping = dst_vma->vm_file->f_mapping;
> +	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> +
> +	if (!*pagep && mode != MCOPY_ATOMIC_CONTINUE) {
>  		ret = -ENOMEM;
>  		page = alloc_huge_page(dst_vma, dst_addr, 0);
>  		if (IS_ERR(page))
> @@ -4685,6 +4690,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			/* don't free the page */
>  			goto out;
>  		}
> +	} else if (mode == MCOPY_ATOMIC_CONTINUE) {
> +		ret = -EFAULT;
> +		page = find_lock_page(mapping, idx);
> +		*pagep = NULL;
> +		if (!page)
> +			goto out;
>  	} else {
>  		page = *pagep;
>  		*pagep = NULL;

I would write this as:

    if (mode == MCOPY_ATOMIC_CONTINUE)
        ...
    else if (!*pagep)
        ...
    else 
        ...

No strong opinion, but that'll look slightly cleaner to me.

[...]

> @@ -408,7 +407,7 @@ extern ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  				      unsigned long dst_start,
>  				      unsigned long src_start,
>  				      unsigned long len,
> -				      bool zeropage);
> +				      enum mcopy_atomic_mode mode);
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
> @@ -417,7 +416,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  						unsigned long dst_addr,
>  						unsigned long src_addr,
>  						struct page **page,
> -						bool zeropage,
> +						enum mcopy_atomic_mode mode,
>  						bool wp_copy)
>  {
>  	ssize_t err;
> @@ -433,22 +432,38 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
>  	 * and not in the radix tree.
>  	 */
>  	if (!(dst_vma->vm_flags & VM_SHARED)) {
> -		if (!zeropage)
> +		switch (mode) {
> +		case MCOPY_ATOMIC_NORMAL:
>  			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
>  					       dst_addr, src_addr, page,
>  					       wp_copy);
> -		else
> +			break;
> +		case MCOPY_ATOMIC_ZEROPAGE:
>  			err = mfill_zeropage_pte(dst_mm, dst_pmd,
>  						 dst_vma, dst_addr);
> +			break;
> +		/* It only makes sense to CONTINUE for shared memory. */
> +		case MCOPY_ATOMIC_CONTINUE:
> +			err = -EINVAL;
> +			break;
> +		}
>  	} else {
>  		VM_WARN_ON_ONCE(wp_copy);
> -		if (!zeropage)
> +		switch (mode) {
> +		case MCOPY_ATOMIC_NORMAL:
>  			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
>  						     dst_vma, dst_addr,
>  						     src_addr, page);
> -		else
> +			break;
> +		case MCOPY_ATOMIC_ZEROPAGE:
>  			err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
>  						       dst_vma, dst_addr);
> +			break;
> +		case MCOPY_ATOMIC_CONTINUE:
> +			/* FIXME: Add minor fault interception for shmem. */
> +			err = -EINVAL;
> +			break;
> +		}
>  	}
>  
>  	return err;

The whole chunk above is not needed for hugetlbfs it seems - I'd avoid touching
the anon/shmem code path until it's being supported.

What you need is probably set zeropage as below in __mcopy_atomic():

    zeropage = (mode == MCOPY_ATOMIC_ZEROPAGE);

Before passing it over to mfill_atomic_pte().  As long as we reject
UFFDIO_CONTINUE with !hugetlbfs correctly that'll be enough iiuc.

Thanks,

-- 
Peter Xu

