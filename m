Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5D65FA89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 05:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjAFEAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 23:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAFEA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:00:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7606B59C;
        Thu,  5 Jan 2023 20:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C88BCE1C06;
        Fri,  6 Jan 2023 04:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53430C433D2;
        Fri,  6 Jan 2023 04:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672977624;
        bh=+UPdXkytzKMtZ3ZWHr4CnIskWe+T5fdDfosPD98BIPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RiI1TTlG8cChT7br22VuUsCCJFUjhv1+2U6wbep8GVwXIEmQZQqtkiVFnz49/AiI1
         oMzPMIkX+w0SlJpfyZ+MrlzPWmOyc1FG7DOJDsPxKlFGiwlpUT9KGdYNXEbV8Dp3HV
         5gXx+czAystFOUsVKop9Yjv8GXgV9V7DIFNk64yY=
Date:   Thu, 5 Jan 2023 20:00:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Righi <andrea.righi@canonical.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Larabel <michael@michaellarabel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com
Subject: Re: [PATCH mm-unstable v2 1/2] mm: add vma_has_recency()
Message-Id: <20230105200023.ac9f34f5b7738eae4fd940d6@linux-foundation.org>
In-Reply-To: <20221230215252.2628425-1-yuzhao@google.com>
References: <20221230215252.2628425-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Dec 2022 14:52:51 -0700 Yu Zhao <yuzhao@google.com> wrote:

> This patch adds vma_has_recency() to indicate whether a VMA may
> exhibit temporal locality that the LRU algorithm relies on.
> 
> This function returns false for VMAs marked by VM_SEQ_READ or
> VM_RAND_READ. While the former flag indicates linear access, i.e., a
> special case of spatial locality, both flags indicate a lack of
> temporal locality, i.e., the reuse of an area within a relatively
> small duration.
> 
> "Recency" is chosen over "locality" to avoid confusion between
> temporal and spatial localities.
> 
> Before this patch, the active/inactive LRU only ignored the accessed
> bit from VMAs marked by VM_SEQ_READ. After this patch, the
> active/inactive LRU and MGLRU share the same logic: they both ignore
> the accessed bit if vma_has_recency() returns false.
> 
> For the active/inactive LRU, the following fio test showed a [6, 8]%
> increase in IOPS when randomly accessing mapped files under memory
> pressure.
> 
>   kb=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
>   kb=$((kb - 8*1024*1024))
> 
>   modprobe brd rd_nr=1 rd_size=$kb
>   dd if=/dev/zero of=/dev/ram0 bs=1M
> 
>   mkfs.ext4 /dev/ram0
>   mount /dev/ram0 /mnt/
>   swapoff -a
> 
>   fio --name=test --directory=/mnt/ --ioengine=mmap --numjobs=8 \
>       --size=8G --rw=randrw --time_based --runtime=10m \
>       --group_reporting
> 
> The discussion that led to this patch is here [1]. Additional test
> results are available in that thread.
> 
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -595,4 +595,12 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
>  #endif
>  }
>  
> +static inline bool vma_has_recency(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
> +		return false;

I guess it's fairly obvious why these hints imply "doesn't have
recency".  But still, some comments wouldn't hurt!

> +	return true;
> +}
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 4000e9f017e0..ee72badad847 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1402,8 +1402,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  						force_flush = 1;
>  					}
>  				}
> -				if (pte_young(ptent) &&
> -				    likely(!(vma->vm_flags & VM_SEQ_READ)))
> +				if (pte_young(ptent) && likely(vma_has_recency(vma)))

So we're newly using VM_RAND_READ for the legacy LRU?  Deliberate?  If
so, what are the effects and why?

>  					mark_page_accessed(page);
>  			}
>  			rss[mm_counter(page)]--;
> @@ -5148,8 +5147,8 @@ static inline void mm_account_fault(struct pt_regs *regs,
>  #ifdef CONFIG_LRU_GEN
>  static void lru_gen_enter_fault(struct vm_area_struct *vma)
>  {
> -	/* the LRU algorithm doesn't apply to sequential or random reads */
> -	current->in_lru_fault = !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ));
> +	/* the LRU algorithm only applies to accesses with recency */
> +	current->in_lru_fault = vma_has_recency(vma);
>  }
>  
>  static void lru_gen_exit_fault(void)
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 8a24b90d9531..9abffdd63a6a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -823,25 +823,14 @@ static bool folio_referenced_one(struct folio *folio,
>  		}
>  
>  		if (pvmw.pte) {
> -			if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
> -			    !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
> +			if (lru_gen_enabled() && pte_young(*pvmw.pte)) {
>  				lru_gen_look_around(&pvmw);
>  				referenced++;
>  			}

I'd expect a call to vma_has_recency() here, but I'll trust you ;)


>  			if (ptep_clear_flush_young_notify(vma, address,
> -						pvmw.pte)) {
> -				/*
> -				 * Don't treat a reference through
> -				 * a sequentially read mapping as such.
> -				 * If the folio has been used in another mapping,
> -				 * we will catch it; if this other mapping is
> -				 * already gone, the unmap path will have set
> -				 * the referenced flag or activated the folio.
> -				 */
> -				if (likely(!(vma->vm_flags & VM_SEQ_READ)))
> -					referenced++;
> -			}
> +						pvmw.pte))
> +				referenced++;
>  		} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>  			if (pmdp_clear_flush_young_notify(vma, address,
>  						pvmw.pmd))
> ...
>

The posix_fadvise() manpage will need an update, please.  Not now, but
if/when these changes are heading into mainline.  "merged into
mm-stable" would be a good trigger for this activity.

The legacy LRU has had used-once drop-behind for a long time (Johannes
touched it last).  Have you noticed whether that's all working OK?
