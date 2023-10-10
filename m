Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2C7C032A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjJJSLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjJJSLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:11:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744894;
        Tue, 10 Oct 2023 11:11:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40651a726acso55353935e9.1;
        Tue, 10 Oct 2023 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696961472; x=1697566272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMKJqRCieFxS9Yt+I9ZmXS+e5dIH6+uWGrTvHacyvUw=;
        b=WULWhmqLB2Kvi9CFWzfWY/j5nXO10cSccvrG0anSzfoRysZxBdiuscceyu9ibYxDYN
         SkqdFnGo9OY97oPGVrsry9UFeTGt09tKoBHYPuUbK5hf+tz/QkPPh33tdil5OpBILGTw
         K/r4o3tvwBCuDVj7nQy2NlLiJPjh98Hua2bGNdweaLsAcLzccaOj7upAzF4RvKAGOI9x
         /+Jt9dTm8eYf5i8UO0z/HCaRyutJEmGg2rkEst0zql6VG/afhXwd1zFprvO2cOb0PTq3
         A7Tz4I7wt0kdhIxiYGPjGV/oJFvb6p/xsk3F1f9qWLZNbGjvlWwf88uI26JwlUMw3n/I
         azqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696961472; x=1697566272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMKJqRCieFxS9Yt+I9ZmXS+e5dIH6+uWGrTvHacyvUw=;
        b=uAnKqxuUwXlZFBUzT03/f1zg/ubnOW0bWrombMw0AgYwIm3Jj8MKP+zhPuuCefDhoz
         fRQWZVI/B2NSUsaBl7P3Vele4tdYc3EZrWazQA6Kv1pv68deaZVhVXw0zjvvZcxMOtoX
         Ckhwwo7IB7t1I73C6MlWHdPi0u8snY00Zanv3x9p1g9Swg03H/6deghZtcrmjJu7GImc
         UFhCrwM9jMZa9rz+Z+d0LRQ/bwZZrUFgj6fjJuspoEkO665FHGDyOx0kWWOBGhgWmFiv
         RqtEYJHYtdexMjTgiBtC7f2qeBewPcLMXcFiz+reXbwt8wiS9lhAoNoxtYW7isIj11Vs
         b0Tw==
X-Gm-Message-State: AOJu0YxVJTomi+NKHkH5yB83/gtBk7hPgSzTuSqCjyhQj5aTtUcMvGsh
        bU3MS02nOcy2Aqcmlry8H7qfdYmAZeE=
X-Google-Smtp-Source: AGHT+IEJFrBCYlgJDwaTTRTyrKvS3QdTooKYqgrvhUV60Y68KFy9TuvSrFzFRjMUjCSS7M24CuRAlQ==
X-Received: by 2002:a1c:4b12:0:b0:405:4a8c:d4f8 with SMTP id y18-20020a1c4b12000000b004054a8cd4f8mr17490235wma.30.1696961471450;
        Tue, 10 Oct 2023 11:11:11 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id s26-20020a7bc39a000000b004064cd71aa8sm14712788wmj.34.2023.10.10.11.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:11:10 -0700 (PDT)
Date:   Tue, 10 Oct 2023 19:11:09 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] mm: abstract the vma_merge()/split_vma() pattern
 for mprotect() et al.
Message-ID: <a2060bfe-b6b0-4137-9c8a-b992885233f4@lucifer.local>
References: <cover.1696884493.git.lstoakes@gmail.com>
 <ade506aa09184dc06d57785fe90a6076682556ca.1696884493.git.lstoakes@gmail.com>
 <4b8ffa8e-2d34-e51e-504f-9aa43ded70eb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8ffa8e-2d34-e51e-504f-9aa43ded70eb@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 10, 2023 at 09:12:21AM +0200, Vlastimil Babka wrote:
> On 10/9/23 22:53, Lorenzo Stoakes wrote:
> > mprotect() and other functions which change VMA parameters over a range
> > each employ a pattern of:-
> >
> > 1. Attempt to merge the range with adjacent VMAs.
> > 2. If this fails, and the range spans a subset of the VMA, split it
> >    accordingly.
> >
> > This is open-coded and duplicated in each case. Also in each case most of
> > the parameters passed to vma_merge() remain the same.
> >
> > Create a new function, vma_modify(), which abstracts this operation,
> > accepting only those parameters which can be changed.
> >
> > To avoid the mess of invoking each function call with unnecessary
> > parameters, create inline wrapper functions for each of the modify
> > operations, parameterised only by what is required to perform the action.
> >
> > Note that the userfaultfd_release() case works even though it does not
> > split VMAs - since start is set to vma->vm_start and end is set to
> > vma->vm_end, the split logic does not trigger.
> >
> > In addition, since we calculate pgoff to be equal to vma->vm_pgoff + (start
> > - vma->vm_start) >> PAGE_SHIFT, and start - vma->vm_start will be 0 in this
> > instance, this invocation will remain unchanged.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> some nits below:
>
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2437,6 +2437,51 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	return __split_vma(vmi, vma, addr, new_below);
> >  }
> >
> > +/*
> > + * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
> > + * context and anonymous VMA name within the range [start, end).
> > + *
> > + * As a result, we might be able to merge the newly modified VMA range with an
> > + * adjacent VMA with identical properties.
> > + *
> > + * If no merge is possible and the range does not span the entirety of the VMA,
> > + * we then need to split the VMA to accommodate the change.
> > + */
>
> This could describe the return value too? It's not entirely trivial.
> But I also wonder if we could just return 'vma' for the split_vma() cases
> and the callers could simply stop distinguishing whether there was a merge
> or split, and their code would become even simpler?
> It seems to me most callers don't care, except mprotect, see below...

What a great idea, thanks! I have worked through and implemented this and
it does indeed work and simplify things even further, cheers!

>
> > +struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> > +				  struct vm_area_struct *prev,
> > +				  struct vm_area_struct *vma,
> > +				  unsigned long start, unsigned long end,
> > +				  unsigned long vm_flags,
> > +				  struct mempolicy *policy,
> > +				  struct vm_userfaultfd_ctx uffd_ctx,
> > +				  struct anon_vma_name *anon_name)
> > +{
> > +	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > +	struct vm_area_struct *merged;
> > +
> > +	merged = vma_merge(vmi, vma->vm_mm, prev, start, end, vm_flags,
> > +			   vma->anon_vma, vma->vm_file, pgoff, policy,
> > +			   uffd_ctx, anon_name);
> > +	if (merged)
> > +		return merged;
> > +
> > +	if (vma->vm_start < start) {
> > +		int err = split_vma(vmi, vma, start, 1);
> > +
> > +		if (err)
> > +			return ERR_PTR(err);
> > +	}
> > +
> > +	if (vma->vm_end > end) {
> > +		int err = split_vma(vmi, vma, end, 0);
> > +
> > +		if (err)
> > +			return ERR_PTR(err);
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> >   * @vmi: The vma iterator
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index b94fbb45d5c7..6f85d99682ab 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -581,7 +581,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
> >  	long nrpages = (end - start) >> PAGE_SHIFT;
> >  	unsigned int mm_cp_flags = 0;
> >  	unsigned long charged = 0;
> > -	pgoff_t pgoff;
> > +	struct vm_area_struct *merged;
> >  	int error;
> >
> >  	if (newflags == oldflags) {
> > @@ -625,34 +625,19 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
> >  		}
> >  	}
> >
> > -	/*
> > -	 * First try to merge with previous and/or next vma.
> > -	 */
> > -	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> > -	*pprev = vma_merge(vmi, mm, *pprev, start, end, newflags,
> > -			   vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> > -			   vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > -	if (*pprev) {
> > -		vma = *pprev;
> > -		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
> > -		goto success;
> > +	merged = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
> > +	if (IS_ERR(merged)) {
> > +		error = PTR_ERR(merged);
> > +		goto fail;
> >  	}
> >
> > -	*pprev = vma;
> > -
> > -	if (start != vma->vm_start) {
> > -		error = split_vma(vmi, vma, start, 1);
> > -		if (error)
> > -			goto fail;
> > -	}
> > -
> > -	if (end != vma->vm_end) {
> > -		error = split_vma(vmi, vma, end, 0);
> > -		if (error)
> > -			goto fail;
> > +	if (merged) {
> > +		vma = *pprev = merged;
> > +		VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
>
> This VM_WARN_ON() is AFAICS the only piece of code that cares about merged
> vs split. Would it be ok to call it for the split vma cases as well, or
> maybe remove it?

This is simply asserting a fundamental requirement of vma_merge() in
general, i.e. that the flags of what was merged match those of the VMA that
is being merged.

This is already checked in the VMA merge implementation, so this feels
super redundant, so I think we're good to simply remove it.

>
> > +	} else {
> > +		*pprev = vma;
> >  	}
> >
> > -success:
> >  	/*
> >  	 * vm_flags and vm_page_prot are protected by the mmap_lock
> >  	 * held in write mode.
>
