Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB69173FFA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 17:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjF0P2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 11:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjF0P2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDCB30F2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687879683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lbvc7C545XmCqolJUETDY5ipWdKDOQMSFc/9B60zY/Q=;
        b=F0WhETcU7tmIs7QPG35ZUtX20zV6l+5POJ3AoAUWzXB8wqZ/WI76yXxL5sdcBKMfMS3XJy
        iVaiLqai8S5vYJ/YjDVQsaDgbYtoND1yYM5QaivRGd0mJeI0ef/psrNqUv8k90j+2EiIbS
        xV5PgsVs7qI8lYXwUe5wfB78u9tOJ3E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-W8oMjFFEM46KOPu_y7tLDw-1; Tue, 27 Jun 2023 11:27:59 -0400
X-MC-Unique: W8oMjFFEM46KOPu_y7tLDw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62ffa1214edso8574876d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879678; x=1690471678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbvc7C545XmCqolJUETDY5ipWdKDOQMSFc/9B60zY/Q=;
        b=BHbleFxmaj3LCqJS0WhHdlsUWmjStmYDSaynrfFchBpk+FJjDnCkS7fLkbahoBxjk7
         /BJw09Ao1qt06+Z8kehurrcTT0RQ1ucCAoayJo7MyC8CtOi9wFDr7F3EwncqDYdIy+Op
         sOzw/okUHg83ZdRB9RdCjiywhhGUo33HpmmswNo+dECEfnWKk4kI2uBBsxjy/gHY2Hrw
         0xRp1Z4O0JX9oZ4RZHpzsROhIifVcGyyKbBtO5OhedXhDNA4712eaPKIJG7/RyeHLoeC
         Qy5/pZ0T8SLL1XN62rUDuf4Jx1KemH2oxwgKX0N8HXO0cV54+Dgu5joijkHQ0uUukqtM
         2m9w==
X-Gm-Message-State: AC+VfDw2hxZ339i3houlaPMO0Xi0IQv3PryCwyGKTA+HUuEzBXpRhAHD
        KIzyPfdX275z2Y/P0cEnkTL+RBptyRltkKQA19lvA2yDy3RGgiWwCuQZiBvr+otFZdSfoZrVrO2
        ZZ+dBJxNSvOovNJ6wcObF/8hgXQ==
X-Received: by 2002:ad4:5c65:0:b0:61b:2111:c2e2 with SMTP id i5-20020ad45c65000000b0061b2111c2e2mr2560727qvh.2.1687879678349;
        Tue, 27 Jun 2023 08:27:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gXsNcLZPQdxRYupGQTR9z9a/jaa4u7R2zWqSv3peFzSdnntX6G1UeITILMfbMy2+ESKSMVA==
X-Received: by 2002:ad4:5c65:0:b0:61b:2111:c2e2 with SMTP id i5-20020ad45c65000000b0061b2111c2e2mr2560695qvh.2.1687879678099;
        Tue, 27 Jun 2023 08:27:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o4-20020a0cfa84000000b00631fa7aa9f7sm4639955qvn.32.2023.06.27.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:27:57 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:27:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 3/8] mm: drop per-VMA lock in handle_mm_fault if
 retrying or when finished
Message-ID: <ZJr/+83t9ndwHCd6@x1n>
References: <20230627042321.1763765-1-surenb@google.com>
 <20230627042321.1763765-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230627042321.1763765-4-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:23:16PM -0700, Suren Baghdasaryan wrote:
> handle_mm_fault returning VM_FAULT_RETRY or VM_FAULT_COMPLETED means
> mmap_lock has been released. However with per-VMA locks behavior is
> different and the caller should still release it. To make the
> rules consistent for the caller, drop the per-VMA lock before returning
> from handle_mm_fault when page fault should be retried or is completed.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/arm64/mm/fault.c   |  3 ++-
>  arch/powerpc/mm/fault.c |  3 ++-
>  arch/s390/mm/fault.c    |  3 ++-
>  arch/x86/mm/fault.c     |  3 ++-
>  mm/memory.c             | 12 +++++++++++-
>  5 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 6045a5117ac1..89f84e9ea1ff 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -601,7 +601,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		goto lock_mmap;
>  	}
>  	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
> -	vma_end_read(vma);
> +	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +		vma_end_read(vma);
>  
>  	if (!(fault & VM_FAULT_RETRY)) {
>  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 531177a4ee08..4697c5dca31c 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -494,7 +494,8 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>  	}
>  
>  	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
> -	vma_end_read(vma);
> +	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +		vma_end_read(vma);
>  
>  	if (!(fault & VM_FAULT_RETRY)) {
>  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index b65144c392b0..cccefe41038b 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -418,7 +418,8 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  		goto lock_mmap;
>  	}
>  	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
> -	vma_end_read(vma);
> +	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +		vma_end_read(vma);
>  	if (!(fault & VM_FAULT_RETRY)) {
>  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
>  		goto out;
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index e4399983c50c..d69c85c1c04e 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1347,7 +1347,8 @@ void do_user_addr_fault(struct pt_regs *regs,
>  		goto lock_mmap;
>  	}
>  	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
> -	vma_end_read(vma);
> +	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +		vma_end_read(vma);
>  
>  	if (!(fault & VM_FAULT_RETRY)) {
>  		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> diff --git a/mm/memory.c b/mm/memory.c
> index f69fbc251198..9011ad63c41b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5086,7 +5086,17 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
>  		}
>  	}
>  
> -	return handle_pte_fault(&vmf);
> +	ret = handle_pte_fault(&vmf);
> +	if (ret & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)) {
> +		/*
> +		 * In case of VM_FAULT_RETRY or VM_FAULT_COMPLETED we might
> +		 * be still holding per-VMA lock to keep the vma stable as long
> +		 * as possible. Drop it before returning.
> +		 */
> +		if (vmf.flags & FAULT_FLAG_VMA_LOCK)
> +			vma_end_read(vma);
> +	}

This smells hackish.. I'd think better we just release the lock at the
place where we'll return RETRY, and AFAIU swap is the only place vma lock
returns a RETRY with current code base?

do_swap_page():
        if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+               vma_end_read(vma);
                ret = VM_FAULT_RETRY;
                goto out;
        }

I.e., I don't think VM_FAULT_COMPLETED can even be returned with vma lock
paths yet as it doesn't yet support VM_SHARED.

-- 
Peter Xu

