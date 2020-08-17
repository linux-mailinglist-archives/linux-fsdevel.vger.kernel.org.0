Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04C0246068
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 10:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHQIin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 04:38:43 -0400
Received: from foss.arm.com ([217.140.110.172]:50254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgHQIim (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:38:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4B730E;
        Mon, 17 Aug 2020 01:38:41 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8539A3F6CF;
        Mon, 17 Aug 2020 01:38:38 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] mm: smaps*: extend smap_gather_stats to support
 specified beginning
To:     Chinwen Chang <chinwen.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1597472419-32314-1-git-send-email-chinwen.chang@mediatek.com>
 <1597472419-32314-3-git-send-email-chinwen.chang@mediatek.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5f4eb892-4980-8245-b93d-5358ffa01abe@arm.com>
Date:   Mon, 17 Aug 2020 09:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597472419-32314-3-git-send-email-chinwen.chang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/08/2020 07:20, Chinwen Chang wrote:
> Extend smap_gather_stats to support indicated beginning address at
> which it should start gathering. To achieve the goal, we add a new
> parameter @start assigned by the caller and try to refactor it for
> simplicity.
> 
> If @start is 0, it will use the range of @vma for gathering.
> 
> Change since v2:
> - This is a new change to make the retry behavior of smaps_rollup
> - more complete as suggested by Michel [1]
> 
> [1] https://lore.kernel.org/lkml/CANN689FtCsC71cjAjs0GPspOhgo_HRj+diWsoU1wr98YPktgWg@mail.gmail.com/
> 
> Signed-off-by: Chinwen Chang <chinwen.chang@mediatek.com>
> CC: Michel Lespinasse <walken@google.com>
> CC: Steven Price <steven.price@arm.com>

LGTM

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> ---
>   fs/proc/task_mmu.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index dbda449..76e623a 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -723,9 +723,21 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
>   	.pte_hole		= smaps_pte_hole,
>   };
>   
> +/*
> + * Gather mem stats from @vma with the indicated beginning
> + * address @start, and keep them in @mss.
> + *
> + * Use vm_start of @vma as the beginning address if @start is 0.
> + */
>   static void smap_gather_stats(struct vm_area_struct *vma,
> -			     struct mem_size_stats *mss)
> +		struct mem_size_stats *mss, unsigned long start)
>   {
> +	const struct mm_walk_ops *ops = &smaps_walk_ops;
> +
> +	/* Invalid start */
> +	if (start >= vma->vm_end)
> +		return;
> +
>   #ifdef CONFIG_SHMEM
>   	/* In case of smaps_rollup, reset the value from previous vma */
>   	mss->check_shmem_swap = false;
> @@ -742,18 +754,20 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>   		 */
>   		unsigned long shmem_swapped = shmem_swap_usage(vma);
>   
> -		if (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
> -					!(vma->vm_flags & VM_WRITE)) {
> +		if (!start && (!shmem_swapped || (vma->vm_flags & VM_SHARED) ||
> +					!(vma->vm_flags & VM_WRITE))) {
>   			mss->swap += shmem_swapped;
>   		} else {
>   			mss->check_shmem_swap = true;
> -			walk_page_vma(vma, &smaps_shmem_walk_ops, mss);
> -			return;
> +			ops = &smaps_shmem_walk_ops;
>   		}
>   	}
>   #endif
>   	/* mmap_lock is held in m_start */
> -	walk_page_vma(vma, &smaps_walk_ops, mss);
> +	if (!start)
> +		walk_page_vma(vma, ops, mss);
> +	else
> +		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
>   }
>   
>   #define SEQ_PUT_DEC(str, val) \
> @@ -805,7 +819,7 @@ static int show_smap(struct seq_file *m, void *v)
>   
>   	memset(&mss, 0, sizeof(mss));
>   
> -	smap_gather_stats(vma, &mss);
> +	smap_gather_stats(vma, &mss, 0);
>   
>   	show_map_vma(m, vma);
>   
> @@ -854,7 +868,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>   	hold_task_mempolicy(priv);
>   
>   	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
> -		smap_gather_stats(vma, &mss);
> +		smap_gather_stats(vma, &mss, 0);
>   		last_vma_end = vma->vm_end;
>   	}
>   
> 

