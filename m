Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E51729DC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbjFIPFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbjFIPF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:05:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ADB3ABA;
        Fri,  9 Jun 2023 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=coXBP4uiCO1t+RzMycgDz8wHMOO+2BU24l9WVlszhmU=; b=IUxZfN5FC1LT0jIoP/+NLUicEc
        /pud5dqcB2gCRR1QrRAMe3A8L6Gnl4STN4rJTDvsfxQoL+lMC7CFNghTexSUPXvMgenH0eBswBqcz
        p9PZo7KLHlJcUr/lRz21PVbCHgievGbtLp30vHD8mrPrm5jjzv7ujNoQetSrc0xu8kt+km9MEoA3z
        FQjHACnI/1q9TjbkmViLNlHzrDmzCDyKrTkmRxlUnB9hFBwHpKsG4uhXPEsKcgTkdpVAPdDq6BWde
        bQDH1/92Lq/SDT0ssqRgV8qNIdsQi0EOnSrSBnSZlhNxryba8njrnDQu+f2qQB8CRunapTSnO2XMg
        8XxZ3ZIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7de7-00GhRR-CC; Fri, 09 Jun 2023 15:03:23 +0000
Date:   Fri, 9 Jun 2023 16:03:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 5/6] mm: implement folio wait under VMA lock
Message-ID: <ZIM/O54Q0waFq/tx@casper.infradead.org>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-6-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:51:57PM -0700, Suren Baghdasaryan wrote:
>  static inline bool folio_lock_or_retry(struct folio *folio,
> -		struct mm_struct *mm, unsigned int flags)
> +		struct vm_area_struct *vma, unsigned int flags,
> +		bool *lock_dropped)

I hate these double-return-value functions.

How about this for an API:

vm_fault_t folio_lock_fault(struct folio *folio, struct vm_fault *vmf)
{
	might_sleep();
	if (folio_trylock(folio))
		return 0;
	return __folio_lock_fault(folio, vmf);
}

Then the users look like ...

> @@ -3580,8 +3581,10 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
>  	if (!folio_try_get(folio))
>  		return 0;
>  
> -	if (!folio_lock_or_retry(folio, vma->vm_mm, vmf->flags)) {
> +	if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) {
>  		folio_put(folio);
> +		if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> +			return VM_FAULT_VMA_UNLOCKED | VM_FAULT_RETRY;
>  		return VM_FAULT_RETRY;
>  	}

	ret = folio_lock_fault(folio, vmf);
	if (ret)
		return ret;

> @@ -3837,9 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		goto out_release;
>  	}
>  
> -	locked = folio_lock_or_retry(folio, vma->vm_mm, vmf->flags);
> -
> -	if (!locked) {
> +	if (!folio_lock_or_retry(folio, vma, vmf->flags, &lock_dropped)) {
> +		if (lock_dropped && vmf->flags & FAULT_FLAG_VMA_LOCK)
> +			ret |= VM_FAULT_VMA_UNLOCKED;
>  		ret |= VM_FAULT_RETRY;
>  		goto out_release;
>  	}

	ret |= folio_lock_fault(folio, vmf);
	if (ret & VM_FAULT_RETRY)
		goto out_release;

ie instead of trying to reconstruct what __folio_lock_fault() did from
its outputs, we just let folio_lock_fault() tell us what it did.
