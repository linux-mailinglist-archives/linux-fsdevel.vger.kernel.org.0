Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F112435E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 10:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHMIVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 04:21:40 -0400
Received: from foss.arm.com ([217.140.110.172]:51548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMIVk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:21:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F95F113E;
        Thu, 13 Aug 2020 01:21:39 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DCB63F70D;
        Thu, 13 Aug 2020 01:21:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] mm: proc: smaps_rollup: do not stall write
 attempts on mmap_lock
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
        Huang Ying <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
 <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3558246d-429e-5054-1bb1-c21e3b94817d@arm.com>
Date:   Thu, 13 Aug 2020 09:21:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597284810-17454-3-git-send-email-chinwen.chang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/08/2020 03:13, Chinwen Chang wrote:
> smaps_rollup will try to grab mmap_lock and go through the whole vma
> list until it finishes the iterating. When encountering large processes,
> the mmap_lock will be held for a longer time, which may block other
> write requests like mmap and munmap from progressing smoothly.
> 
> There are upcoming mmap_lock optimizations like range-based locks, but
> the lock applied to smaps_rollup would be the coarse type, which doesn't
> avoid the occurrence of unpleasant contention.
> 
> To solve aforementioned issue, we add a check which detects whether
> anyone wants to grab mmap_lock for write attempts.
> 
> Change since v1:
> - If current VMA is freed after dropping the lock, it will return
> - incomplete result. To fix this issue, refine the code flow as
> - suggested by Steve. [1]
> 
> [1] https://lore.kernel.org/lkml/bf40676e-b14b-44cd-75ce-419c70194783@arm.com/
> 
> Signed-off-by: Chinwen Chang <chinwen.chang@mediatek.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   fs/proc/task_mmu.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index dbda449..23b3a447 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -853,9 +853,63 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>   
>   	hold_task_mempolicy(priv);
>   
> -	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
> +	for (vma = priv->mm->mmap; vma;) {
>   		smap_gather_stats(vma, &mss);
>   		last_vma_end = vma->vm_end;
> +
> +		/*
> +		 * Release mmap_lock temporarily if someone wants to
> +		 * access it for write request.
> +		 */
> +		if (mmap_lock_is_contended(mm)) {
> +			mmap_read_unlock(mm);
> +			ret = mmap_read_lock_killable(mm);
> +			if (ret) {
> +				release_task_mempolicy(priv);
> +				goto out_put_mm;
> +			}
> +
> +			/*
> +			 * After dropping the lock, there are three cases to
> +			 * consider. See the following example for explanation.
> +			 *
> +			 *   +------+------+-----------+
> +			 *   | VMA1 | VMA2 | VMA3      |
> +			 *   +------+------+-----------+
> +			 *   |      |      |           |
> +			 *  4k     8k     16k         400k
> +			 *
> +			 * Suppose we drop the lock after reading VMA2 due to
> +			 * contention, then we get:
> +			 *
> +			 *	last_vma_end = 16k
> +			 *
> +			 * 1) VMA2 is freed, but VMA3 exists:
> +			 *
> +			 *    find_vma(mm, 16k - 1) will return VMA3.
> +			 *    In this case, just continue from VMA3.
> +			 *
> +			 * 2) VMA2 still exists:
> +			 *
> +			 *    find_vma(mm, 16k - 1) will return VMA2.
> +			 *    Iterate the loop like the original one.
> +			 *
> +			 * 3) No more VMAs can be found:
> +			 *
> +			 *    find_vma(mm, 16k - 1) will return NULL.
> +			 *    No more things to do, just break.
> +			 */
> +			vma = find_vma(mm, last_vma_end - 1);
> +			/* Case 3 above */
> +			if (!vma)
> +				break;
> +
> +			/* Case 1 above */
> +			if (vma->vm_start >= last_vma_end)
> +				continue;
> +		}
> +		/* Case 2 above */
> +		vma = vma->vm_next;
>   	}
>   
>   	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
> 

