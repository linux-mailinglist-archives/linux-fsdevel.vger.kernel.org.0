Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E302426D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 10:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHLIjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 04:39:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgHLIjN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:39:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AACB4D6E;
        Wed, 12 Aug 2020 01:39:12 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6792E3F22E;
        Wed, 12 Aug 2020 01:39:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] mm: proc: smaps_rollup: do not stall write attempts
 on mmap_lock
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
References: <1597120955-16495-1-git-send-email-chinwen.chang@mediatek.com>
 <1597120955-16495-3-git-send-email-chinwen.chang@mediatek.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <bf40676e-b14b-44cd-75ce-419c70194783@arm.com>
Date:   Wed, 12 Aug 2020 09:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597120955-16495-3-git-send-email-chinwen.chang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/08/2020 05:42, Chinwen Chang wrote:
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
> Signed-off-by: Chinwen Chang <chinwen.chang@mediatek.com>
> ---
>   fs/proc/task_mmu.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index dbda449..4b51f25 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -856,6 +856,27 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>   	for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
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
> +			/* Check whether current vma is available */
> +			vma = find_vma(mm, last_vma_end - 1);
> +			if (vma && vma->vm_start < last_vma_end)

I may be wrong, but this looks like it could return incorrect results. 
For example if we start reading with the following VMAs:

  +------+------+-----------+
  | VMA1 | VMA2 | VMA3      |
  +------+------+-----------+
  |      |      |           |
4k     8k     16k         400k

Then after reading VMA2 we drop the lock due to contention. So:

   last_vma_end = 16k

Then if VMA2 is freed while the lock is dropped, so we have:

  +------+      +-----------+
  | VMA1 |      | VMA3      |
  +------+      +-----------+
  |      |      |           |
4k     8k     16k         400k

find_vma(mm, 16k-1) will then return VMA3 and the condition vm_start < 
last_vma_end will be false.

> +				continue;
> +
> +			/* Current vma is not available, just break */
> +			break;

Which means we break out here and report an incomplete output (the 
numbers will be much smaller than reality).

Would it be better to have a loop like:

	for (vma = priv->mm->mmap; vma;) {
		smap_gather_stats(vma, &mss);
		last_vma_end = vma->vm_end;

		if (contended) {
			/* drop/acquire lock */

			vma = find_vma(mm, last_vma_end - 1);
			if (!vma)
				break;
			if (vma->vm_start >= last_vma_end)
				continue;
		}
		vma = vma->vm_next;
	}

that way if the VMA is removed while the lock is dropped the loop can 
just continue from the next VMA.

Or perhaps I missed something obvious? I haven't actually tested 
anything above.

Steve

> +		}
>   	}
>   
>   	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
> 

