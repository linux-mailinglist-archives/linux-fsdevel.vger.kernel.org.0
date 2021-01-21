Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4470C2FF498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbhAUTdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbhAUSvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611254984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6TBkn8Pkdag13BDPCcX3RZw7vW2DCMiBVqUE7wTSuKQ=;
        b=aob6rBYcQBsjpbP+tce5qAJAcefpByz4EgICCX+59M7rckh2c+t2YKUyQAVrxijhWnRcJl
        Zam/eC3Z5FPmbIuZ1PSZcQ9v1Ybqbp8UJsc5QVXFnm4MM/qqaOUixWIJvdxN/6vNBhZdSR
        L7+FkEyS2s75+b2zWrqeIzdn8/yftOw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-JrRlhW94ODqhv_I5cQZJKA-1; Thu, 21 Jan 2021 13:49:42 -0500
X-MC-Unique: JrRlhW94ODqhv_I5cQZJKA-1
Received: by mail-qt1-f200.google.com with SMTP id t20so2105471qtq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 10:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TBkn8Pkdag13BDPCcX3RZw7vW2DCMiBVqUE7wTSuKQ=;
        b=YBvZZZEq2KYVq2Kl4Lep2F5nOFvUW2H4nZRYe26T3bRjjxlk3wuJUYkZf1SF6btCsm
         G8a5FspRjt2gFkWvmXfEHPgbSZQmV3Hpzdhf5Q02Gwzll8e8J7AwDpb+QzB1GBCmlB27
         DD7B2s4EsERJq7OuLBPO5FpODmDx7fS143+ymfFB6aO5fzIlT1QzqG7uaP4W4twUPlne
         W81kuUcyD0iOombRQtqwhFmJ8+VVg5EfUOOF7vPrNY/xMOvKwkQ+HL1z9Lm8NiQp+dKn
         zvZN5yyffDe4OST4jXwQ87fhZLlMrURnPWMy42gazwXEAJyWN10inuLmaxcoJA6RqDHJ
         vgnA==
X-Gm-Message-State: AOAM530/udIstRnF1/hEM7icnPq8qdfVLDzAfWeM699Bex8jwBZNJJid
        0Qd1RyOy7THdA7HooGupdwM+SeX2kSkRbNbgT/EtolTC1a55uFRT9FBZg/9O/R+0EIS8fQhdOme
        WJuPsXuuO3F/fgb+ATJ3gUZaJsw==
X-Received: by 2002:aed:232d:: with SMTP id h42mr969240qtc.143.1611254981804;
        Thu, 21 Jan 2021 10:49:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9EXEbSwwBAfssfPtJdgfpx76Zd/+F9KwLJUZY61Z2fBXkPSvOmQovBQztwF+Z2ca8S+P7cw==
X-Received: by 2002:aed:232d:: with SMTP id h42mr969190qtc.143.1611254981496;
        Thu, 21 Jan 2021 10:49:41 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id c7sm3846216qtc.82.2021.01.21.10.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 10:49:40 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:49:38 -0500
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
Subject: Re: [PATCH 5/9] userfaultfd: add minor fault registration mode
Message-ID: <20210121184938.GD260413@xz-x1>
References: <20210115190451.3135416-1-axelrasmussen@google.com>
 <20210115190451.3135416-6-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115190451.3135416-6-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Axel,

On Fri, Jan 15, 2021 at 11:04:47AM -0800, Axel Rasmussen wrote:
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index c63ccdae3eab..7aa1461e1a8b 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -71,6 +71,11 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_UFFD_WP;
>  }
>  
> +static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & VM_UFFD_MINOR;
> +}
> +
>  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
>  				      pte_t pte)
>  {
> @@ -85,7 +90,7 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
>  
>  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
> +	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR);
>  }

Maybe move the __VM_UFFD_FLAGS into this header so use it too here?

[...]

> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index 5f2d88212f7c..1cc2cd8a5279 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -19,15 +19,19 @@
>   * means the userland is reading).
>   */
>  #define UFFD_API ((__u64)0xAA)
> +#define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |	\
> +				 UFFDIO_REGISTER_MODE_WP |	\
> +				 UFFDIO_REGISTER_MODE_MINOR)
>  #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
>  			   UFFD_FEATURE_EVENT_FORK |		\
>  			   UFFD_FEATURE_EVENT_REMAP |		\
> -			   UFFD_FEATURE_EVENT_REMOVE |	\
> +			   UFFD_FEATURE_EVENT_REMOVE |		\
>  			   UFFD_FEATURE_EVENT_UNMAP |		\
>  			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
>  			   UFFD_FEATURE_MISSING_SHMEM |		\
>  			   UFFD_FEATURE_SIGBUS |		\
> -			   UFFD_FEATURE_THREAD_ID)
> +			   UFFD_FEATURE_THREAD_ID |		\
> +			   UFFD_FEATURE_MINOR_FAULT_HUGETLBFS)

I'd remove the "_FAULT" to align with the missing features...

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 61d6346ed009..2b3741d6130c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4377,6 +4377,37 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		}
>  	}
>  
> +	/* Check for page in userfault range. */
> +	if (!new_page && userfaultfd_minor(vma)) {
> +		u32 hash;
> +		struct vm_fault vmf = {
> +			.vma = vma,
> +			.address = haddr,
> +			.flags = flags,
> +			/*
> +			 * Hard to debug if it ends up being used by a callee
> +			 * that assumes something about the other uninitialized
> +			 * fields... same as in memory.c
> +			 */
> +		};
> +
> +		unlock_page(page);
> +
> +		/*
> +		 * hugetlb_fault_mutex and i_mmap_rwsem must be dropped before
> +		 * handling userfault.  Reacquire after handling fault to make
> +		 * calling code simpler.
> +		 */
> +
> +		hash = hugetlb_fault_mutex_hash(mapping, idx);
> +		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +		i_mmap_unlock_read(mapping);
> +		ret = handle_userfault(&vmf, VM_UFFD_MINOR);
> +		i_mmap_lock_read(mapping);
> +		mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +		goto out;

I figured it easier if the whole chunk be put into the else block right after
find_lock_page(); will that work the same?

It's just not obviously clear on when we'll go into this block otherwise,
basically the dependency of new_page variable and when it's unset.

Thanks,

-- 
Peter Xu

