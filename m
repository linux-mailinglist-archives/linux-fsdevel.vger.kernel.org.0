Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E76C7BF3D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 09:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442381AbjJJHM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378097AbjJJHM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:12:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3499;
        Tue, 10 Oct 2023 00:12:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD5802188D;
        Tue, 10 Oct 2023 07:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696921941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BrX/uXOL7D1lmY2XvIGdfkkJkG5aTexZ1MApRXO43s=;
        b=gp6OEPo/ofBTxZnCA6Ex4rXYzAHkJ35kX9i44gUB/3hR6WKUQZk640Q+IODk+07eOJzt4W
        EH87+lIfZZbgsv2ZljfxoUPtYKYLCkTsx+rJXD+FRqbgnmPD73BgkVcT5CoD+5HCpaJCkh
        NZQtxf+Pd8owA9/5IONe27uJ0QoVfcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696921941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6BrX/uXOL7D1lmY2XvIGdfkkJkG5aTexZ1MApRXO43s=;
        b=l6cXuIk/aTWTnfxOtNw1OCvx1Wbspdss4ceLQYDb6EzkSExgmLtHsyPeBT9bNdg8YEJy+6
        Oj8QoCWQsVSu8oBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCEA01358F;
        Tue, 10 Oct 2023 07:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2OyQLFX5JGXZMgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Oct 2023 07:12:21 +0000
Message-ID: <4b8ffa8e-2d34-e51e-504f-9aa43ded70eb@suse.cz>
Date:   Tue, 10 Oct 2023 09:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] mm: abstract the vma_merge()/split_vma() pattern
 for mprotect() et al.
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <cover.1696884493.git.lstoakes@gmail.com>
 <ade506aa09184dc06d57785fe90a6076682556ca.1696884493.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ade506aa09184dc06d57785fe90a6076682556ca.1696884493.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/9/23 22:53, Lorenzo Stoakes wrote:
> mprotect() and other functions which change VMA parameters over a range
> each employ a pattern of:-
> 
> 1. Attempt to merge the range with adjacent VMAs.
> 2. If this fails, and the range spans a subset of the VMA, split it
>    accordingly.
> 
> This is open-coded and duplicated in each case. Also in each case most of
> the parameters passed to vma_merge() remain the same.
> 
> Create a new function, vma_modify(), which abstracts this operation,
> accepting only those parameters which can be changed.
> 
> To avoid the mess of invoking each function call with unnecessary
> parameters, create inline wrapper functions for each of the modify
> operations, parameterised only by what is required to perform the action.
> 
> Note that the userfaultfd_release() case works even though it does not
> split VMAs - since start is set to vma->vm_start and end is set to
> vma->vm_end, the split logic does not trigger.
> 
> In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> instance, this invocation will remain unchanged.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

some nits below:

> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2437,6 +2437,51 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return __split_vma(vmi, vma, addr, new_below);
>  }
>  
> +/*
> + * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
> + * context and anonymous VMA name within the range [start, end).
> + *
> + * As a result, we might be able to merge the newly modified VMA range with an
> + * adjacent VMA with identical properties.
> + *
> + * If no merge is possible and the range does not span the entirety of the VMA,
> + * we then need to split the VMA to accommodate the change.
> + */

This could describe the return value too? It's not entirely trivial.
But I also wonder if we could just return 'vma' for the split_vma() cases
and the callers could simply stop distinguishing whether there was a merge
or split, and their code would become even simpler?
It seems to me most callers don't care, except mprotect, see below...

> +struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> +				  struct vm_area_struct *prev,
> +				  struct vm_area_struct *vma,
> +				  unsigned long start, unsigned long end,
> +				  unsigned long vm_flags,
> +				  struct mempolicy *policy,
> +				  struct vm_userfaultfd_ctx uffd_ctx,
> +				  struct anon_vma_name *anon_name)
> +{
> +	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> +	struct vm_area_struct *merged;
> +
> +	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
> +			   vma->anon_vma, vma->vm_file, pgoff, policy,
> +			   uffd_ctx, anon_name);
> +	if (merged)
> +		return merged;
> +
> +	if (vma->vm_start < start) {
> +		int err = split_vma(vmi, vma, start, 1);
> +
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	if (vma->vm_end > end) {
> +		int err = split_vma(vmi, vma, end, 0);
> +
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	return NULL;
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index b94fbb45d5c7..6f85d99682ab 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -581,7 +581,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	long nrpages = (end - start) >> PAGE_SHIFT;
>  	unsigned int mm_cp_flags = 0;
>  	unsigned long charged = 0;
> -	pgoff_t pgoff;
> +	struct vm_area_struct *merged;
>  	int error;
>  
>  	if (newflags == oldflags) {
> @@ -625,34 +625,19 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  		}
>  	}
>  
> -	/*
> -	 * First try to merge with previous and/or next vma.
> -	 */
> -	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> -	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
> -			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -	if (*pprev) {
> -		vma = *pprev;
> -		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
> -		goto success;
> +	merged = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
> +	if (IS_ERR(merged)) {
> +		error = PTR_ERR(merged);
> +		goto fail;
>  	}
>  
> -	*pprev = vma;
> -
> -	if (start != vma->vm_start) {
> -		error = split_vma(vmi, vma, start, 1);
> -		if (error)
> -			goto fail;
> -	}
> -
> -	if (end != vma->vm_end) {
> -		error = split_vma(vmi, vma, end, 0);
> -		if (error)
> -			goto fail;
> +	if (merged) {
> +		vma = *pprev = merged;
> +		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);

This VM_WARN_ON() is AFAICS the only piece of code that cares about merged
vs split. Would it be ok to call it for the split vma cases as well, or
maybe remove it?

> +	} else {
> +		*pprev = vma;
>  	}
>  
> -success:
>  	/*
>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>  	 * held in write mode.

