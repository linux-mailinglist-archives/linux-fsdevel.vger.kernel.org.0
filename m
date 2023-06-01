Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30555719534
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjFAIQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjFAIQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:16:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D119F;
        Thu,  1 Jun 2023 01:16:50 -0700 (PDT)
Received: from [192.168.127.158] (unknown [118.107.131.147])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 995F86606E8C;
        Thu,  1 Jun 2023 09:16:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685607409;
        bh=BA3QmEKFqxqHdhhS4O9rOqqxg4EqkWr8qScJTtUpscw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=BW8rTdw4F+NWs34EXLaSqYAKE0lj+Cv98P4+2+RNl+iH0+ECZUTXf4/7QhoYlrZJ1
         tHsJU8Mv9S2CiDymCEnw6J1uQVLylqwpKTuU8OZx7ObMcJ6tDqmYGsaOaV9XWTrlKu
         0TDMFNgWAZ2pXvXEwxr7mtw9LLAIOXXiW/Hz3wy1p6ZQk2aJiqZzKluI8obkWl5yyf
         Dfe93RFyS8Q7qzJ7hH6RxATRLtXGd8q7qpubaBB6coat4mHcZcaSgYe5F0ubVvzUws
         APPbBmq5x4AxTM/ddC2/4NMC2YoQisDIS3nI3YOhZAFLyM5eMAOzLpFTvwEfjbukgV
         poxEWcIJUaduA==
Message-ID: <aeaaa33e-4d23-fd3a-1357-4751007aa3bd@collabora.com>
Date:   Thu, 1 Jun 2023 13:16:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v16 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Peter Xu <peterx@redhat.com>
References: <20230525085517.281529-1-usama.anjum@collabora.com>
 <20230525085517.281529-3-usama.anjum@collabora.com> <ZHfAOAKj1ZQJ+zSy@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZHfAOAKj1ZQJ+zSy@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/23 2:46 AM, Peter Xu wrote:
> Muhammad,
> 
> Sorry, I probably can only review the non-interface part, and leave the
> interface/buffer handling, etc. review for others and real potential users
> of it..
Thank you so much for the review. I think mostly we should be okay with
interface as everybody has been making suggestions over the past revisions.

> 
> On Thu, May 25, 2023 at 01:55:14PM +0500, Muhammad Usama Anjum wrote:
>> +static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>> +					 unsigned long addr, pte_t *ptep,
>> +					 pte_t ptent)
>> +{
>> +	pte_t old_pte;
>> +
>> +	if (!huge_pte_none(ptent)) {
>> +		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
>> +		ptent = huge_pte_mkuffd_wp(old_pte);
>> +		ptep_modify_prot_commit(vma, addr, ptep, old_pte, ptent);
> 
> huge_ptep_modify_prot_start()?
Sorry, I didn't realized that huge_ptep_modify_prot_start() is different
from its pte version.

> 
> The other thing is what if it's a pte marker already?  What if a hugetlb
> migration entry?  Please check hugetlb_change_protection().
I've updated it in more better way. Please let me know what do you think
about the following:

static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
					 unsigned long addr, pte_t *ptep,
					 pte_t ptent)
{
	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
		return;

	if (is_hugetlb_entry_migration(ptent))
		set_huge_pte_at(vma->vm_mm, addr, ptep,
				pte_swp_mkuffd_wp(ptent));
	else if (!huge_pte_none(ptent))
		ptep_modify_prot_commit(vma, addr, ptep, ptent,
					huge_pte_mkuffd_wp(ptent));
	else
		set_huge_pte_at(vma->vm_mm, addr, ptep,
				make_pte_marker(PTE_MARKER_UFFD_WP));
}

As we always set UNPOPULATED, so markers are always set on none ptes
initially. Is it possible that a none pte becomes present, then swapped and
finally none again? So I'll do the following addition for make_uffd_wp_pte():

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1800,6 +1800,9 @@ static inline void make_uffd_wp_pte(struct
vm_area_struct *vma,
 	} else if (is_swap_pte(ptent)) {
 		ptent = pte_swp_mkuffd_wp(ptent);
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
+	} else {
+		set_pte_at(vma->vm_mm, addr, pte,
+			   make_pte_marker(PTE_MARKER_UFFD_WP));
 	}
 }




> 
>> +	} else {
>> +		set_huge_pte_at(vma->vm_mm, addr, ptep,
>> +				make_pte_marker(PTE_MARKER_UFFD_WP));
>> +	}
>> +}
>> +#endif
> 
> [...]
> 
>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>> +				  unsigned long end, struct mm_walk *walk)
>> +{
>> +	struct pagemap_scan_private *p = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	unsigned long addr = end;
>> +	pte_t *pte, *orig_pte;
>> +	spinlock_t *ptl;
>> +	bool is_written;
>> +	int ret = 0;
>> +
>> +	arch_enter_lazy_mmu_mode();
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	ptl = pmd_trans_huge_lock(pmd, vma);
>> +	if (ptl) {
>> +		unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +
>> +		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>> +			n_pages = p->max_pages - p->found_pages;
>> +
>> +		is_written = !is_pmd_uffd_wp(*pmd);
>> +
>> +		/*
>> +		 * Break huge page into small pages if the WP operation need to
>> +		 * be performed is on a portion of the huge page.
>> +		 */
>> +		if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +			spin_unlock(ptl);
>> +
>> +			split_huge_pmd(vma, pmd, start);
>> +			goto process_smaller_pages;
>> +		}
>> +
>> +		if (IS_PM_SCAN_GET(p->flags))
>> +			ret = pagemap_scan_output(is_written, vma->vm_file,
>> +						  pmd_present(*pmd),
>> +						  is_swap_pmd(*pmd),
>> +						  p, start, n_pages);
>> +
>> +		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
>> +			make_uffd_wp_pmd(vma, addr, pmd);
>> +
>> +		if (IS_PM_SCAN_WP(p->flags))
>> +			flush_tlb_range(vma, start, end);
>> +
>> +		spin_unlock(ptl);
>> +
>> +		arch_leave_lazy_mmu_mode();
>> +		return ret;
>> +	}
>> +
>> +process_smaller_pages:
>> +	if (pmd_trans_unstable(pmd)) {
>> +		arch_leave_lazy_mmu_mode();
>> +		return 0;
> 
> I'm not sure whether this is right..  Shouldn't you return with -EAGAIN and
> let the user retry?  Returning 0 means you'll move on with the next pmd
> afaict and ignoring this one.
This has come up before. We are just replicating pagemap_pmd_range() here
as we are doing almost the same thing through IOCTL. It doesn't return any
error in this case and just skips it. So we are doing the same.

> 
>> +	}
>> +#endif
>> +
>> +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
> 
> Just a heads-up that this may start to fail at some point if Hugh's work
> will land earlier:
> 
> https://lore.kernel.org/linux-mm/68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com/
Thank you so much for the heads up.

> 
>> +	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
>> +		is_written = !is_pte_uffd_wp(*pte);
>> +
>> +		if (IS_PM_SCAN_GET(p->flags))
>> +			ret = pagemap_scan_output(is_written, vma->vm_file,
>> +						  pte_present(*pte),
>> +						  is_swap_pte(*pte),
>> +						  p, addr, 1);
>> +
>> +		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
>> +			make_uffd_wp_pte(vma, addr, pte);
>> +	}
>> +
>> +	if (IS_PM_SCAN_WP(p->flags))
>> +		flush_tlb_range(vma, start, addr);
>> +
>> +	pte_unmap_unlock(orig_pte, ptl);
>> +	arch_leave_lazy_mmu_mode();
>> +
>> +	cond_resched();
>> +	return ret;
>> +}
>> +
>> +#ifdef CONFIG_HUGETLB_PAGE
>> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
>> +				      unsigned long start, unsigned long end,
>> +				      struct mm_walk *walk)
>> +{
>> +	unsigned long n_pages = (end - start)/PAGE_SIZE;
>> +	struct pagemap_scan_private *p = walk->private;
>> +	struct vm_area_struct *vma = walk->vma;
>> +	struct hstate *h = hstate_vma(vma);
>> +	spinlock_t *ptl;
>> +	bool is_written;
>> +	int ret = 0;
>> +	pte_t pte;
>> +
>> +	arch_enter_lazy_mmu_mode();
> 
> This _seems_ to be not needed for hugetlb entries.
I'll remove it.

> 
>> +
>> +	if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>> +		n_pages = p->max_pages - p->found_pages;
>> +
>> +	if (IS_PM_SCAN_WP(p->flags)) {
>> +		i_mmap_lock_write(vma->vm_file->f_mapping);
>> +		ptl = huge_pte_lock(h, vma->vm_mm, ptep);
>> +	}
>> +
>> +	pte = huge_ptep_get(ptep);
>> +	is_written = !is_huge_pte_uffd_wp(pte);
>> +
>> +	/*
>> +	 * Partial hugetlb page clear isn't supported
>> +	 */
>> +	if (is_written && IS_PM_SCAN_WP(p->flags) &&
>> +	    n_pages < HPAGE_SIZE/PAGE_SIZE) {
>> +		ret = -EPERM;
>> +		goto unlock_and_return;
>> +	}
>> +
>> +	if (IS_PM_SCAN_GET(p->flags)) {
>> +		ret = pagemap_scan_output(is_written, vma->vm_file,
>> +					  pte_present(pte), is_swap_pte(pte),
>> +					  p, start, n_pages);
>> +		if (ret < 0)
>> +			goto unlock_and_return;
>> +	}
>> +
>> +	if (is_written && IS_PM_SCAN_WP(p->flags)) {
>> +		make_uffd_wp_huge_pte(vma, start, ptep, pte);
>> +		flush_hugetlb_tlb_range(vma, start, end);
>> +	}
>> +
>> +unlock_and_return:
>> +	if (IS_PM_SCAN_WP(p->flags)) {
>> +		spin_unlock(ptl);
>> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
>> +	}
>> +
>> +	arch_leave_lazy_mmu_mode();
> 
> Same here.
> 
>> +
>> +	return ret;
>> +}
> 
> [...]
> 

-- 
BR,
Muhammad Usama Anjum
