Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353DA720044
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjFBLTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjFBLTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:19:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28BCE53;
        Fri,  2 Jun 2023 04:18:50 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D34AA6605835;
        Fri,  2 Jun 2023 12:18:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685704729;
        bh=W110dc+egvPhy7okk5EJDPoLL/gsrq4vUY4VfhaGHKs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jx7CVIBVrhjV5mkDEuSTZY3aWoyg0qNNIy8j0C3nRt+RuIQa6df7dHBAbYTZda4JM
         HVtLzd6b7IQcfJ+fDfHz3db0ft+aPtL6q/j2oBmkCVRrkyr8RuaPe+055GK26uBULi
         lVgh7nDLg9qqyYNcy1T3j5zUKKjIMaQ/xd6xV3zGiWXr1S8O5Fj5IM8P+TBq+IDHP+
         m/VyYrvx5xThKFh7nrb1BVQYKUYKIBf7MyMjV67gx2JsjXb70FR4emk4f/PJr2tUT1
         H04+H7LHk1RYmI09goMFibovTGJ/fehAC4rOvR2PO5moM36bQyxCzQRCCrt9i7pdbL
         xsq8F3TGg61gQ==
Message-ID: <3589803d-5594-71de-d078-ad4499f233b6@collabora.com>
Date:   Fri, 2 Jun 2023 16:18:38 +0500
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
 <aeaaa33e-4d23-fd3a-1357-4751007aa3bd@collabora.com> <ZHj7jmJ5fKla1Rax@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZHj7jmJ5fKla1Rax@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/2/23 1:11 AM, Peter Xu wrote:
> On Thu, Jun 01, 2023 at 01:16:14PM +0500, Muhammad Usama Anjum wrote:
>> On 6/1/23 2:46 AM, Peter Xu wrote:
>>> Muhammad,
>>>
>>> Sorry, I probably can only review the non-interface part, and leave the
>>> interface/buffer handling, etc. review for others and real potential users
>>> of it..
>> Thank you so much for the review. I think mostly we should be okay with
>> interface as everybody has been making suggestions over the past revisions.
>>
>>>
>>> On Thu, May 25, 2023 at 01:55:14PM +0500, Muhammad Usama Anjum wrote:
>>>> +static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>>>> +					 unsigned long addr, pte_t *ptep,
>>>> +					 pte_t ptent)
>>>> +{
>>>> +	pte_t old_pte;
>>>> +
>>>> +	if (!huge_pte_none(ptent)) {
>>>> +		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
>>>> +		ptent = huge_pte_mkuffd_wp(old_pte);
>>>> +		ptep_modify_prot_commit(vma, addr, ptep, old_pte, ptent);
>>>
>>> huge_ptep_modify_prot_start()?
>> Sorry, I didn't realized that huge_ptep_modify_prot_start() is different
>> from its pte version.
> 
> Here I meant huge_ptep_modify_prot_commit()..
I'll update.

> 
>>
>>>
>>> The other thing is what if it's a pte marker already?  What if a hugetlb
>>> migration entry?  Please check hugetlb_change_protection().
>> I've updated it in more better way. Please let me know what do you think
>> about the following:
>>
>> static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>> 					 unsigned long addr, pte_t *ptep,
>> 					 pte_t ptent)
>> {
>> 	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
>> 		return;
>>
>> 	if (is_hugetlb_entry_migration(ptent))
>> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
>> 				pte_swp_mkuffd_wp(ptent));
>> 	else if (!huge_pte_none(ptent))
>> 		ptep_modify_prot_commit(vma, addr, ptep, ptent,
>> 					huge_pte_mkuffd_wp(ptent));
>> 	else
>> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
>> 				make_pte_marker(PTE_MARKER_UFFD_WP));
>> }
> 
> the is_pte_marker() check can be extended to double check
> pte_marker_uffd_wp() bit, but shouldn't matter a lot since besides the
> uffd-wp bit currently we only support swapin error which should sigbus when
> accessed, so no point in tracking anyway.
Yeah, we are good with what we have as even if more bits are supported in
pte markers, this function is only reached when UNPOPULATED + ASYNC WP are
enabled. So no other bit would be set on the marker.

> 
>>
>> As we always set UNPOPULATED, so markers are always set on none ptes
>> initially. Is it possible that a none pte becomes present, then swapped and
>> finally none again? So I'll do the following addition for make_uffd_wp_pte():
>>
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1800,6 +1800,9 @@ static inline void make_uffd_wp_pte(struct
>> vm_area_struct *vma,
>>  	} else if (is_swap_pte(ptent)) {
>>  		ptent = pte_swp_mkuffd_wp(ptent);
>>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
>> +	} else {
>> +		set_pte_at(vma->vm_mm, addr, pte,
>> +			   make_pte_marker(PTE_MARKER_UFFD_WP));
>>  	}
>>  }
> 
> Makes sense, you can leverage userfaultfd_wp_use_markers() here, and you
> should probably keep the protocol (only set the marker when WP_UNPOPULATED
> for anon).
This function is only reachable when UNPOPULATED + Async WP are set. So we
don't need to use userfaultfd_wp_use_markers().

> 
>>
>>
>>
>>
>>>
>>>> +	} else {
>>>> +		set_huge_pte_at(vma->vm_mm, addr, ptep,
>>>> +				make_pte_marker(PTE_MARKER_UFFD_WP));
>>>> +	}
>>>> +}
>>>> +#endif
>>>
>>> [...]
>>>
>>>> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>>>> +				  unsigned long end, struct mm_walk *walk)
>>>> +{
>>>> +	struct pagemap_scan_private *p = walk->private;
>>>> +	struct vm_area_struct *vma = walk->vma;
>>>> +	unsigned long addr = end;
>>>> +	pte_t *pte, *orig_pte;
>>>> +	spinlock_t *ptl;
>>>> +	bool is_written;
>>>> +	int ret = 0;
>>>> +
>>>> +	arch_enter_lazy_mmu_mode();
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +	ptl = pmd_trans_huge_lock(pmd, vma);
>>>> +	if (ptl) {
>>>> +		unsigned long n_pages = (end - start)/PAGE_SIZE;
>>>> +
>>>> +		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
>>>> +			n_pages = p->max_pages - p->found_pages;
>>>> +
>>>> +		is_written = !is_pmd_uffd_wp(*pmd);
>>>> +
>>>> +		/*
>>>> +		 * Break huge page into small pages if the WP operation need to
>>>> +		 * be performed is on a portion of the huge page.
>>>> +		 */
>>>> +		if (is_written && IS_PM_SCAN_WP(p->flags) &&
>>>> +		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
>>>> +			spin_unlock(ptl);
>>>> +
>>>> +			split_huge_pmd(vma, pmd, start);
>>>> +			goto process_smaller_pages;
>>>> +		}
>>>> +
>>>> +		if (IS_PM_SCAN_GET(p->flags))
>>>> +			ret = pagemap_scan_output(is_written, vma->vm_file,
>>>> +						  pmd_present(*pmd),
>>>> +						  is_swap_pmd(*pmd),
>>>> +						  p, start, n_pages);
>>>> +
>>>> +		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
>>>> +			make_uffd_wp_pmd(vma, addr, pmd);
>>>> +
>>>> +		if (IS_PM_SCAN_WP(p->flags))
>>>> +			flush_tlb_range(vma, start, end);
>>>> +
>>>> +		spin_unlock(ptl);
>>>> +
>>>> +		arch_leave_lazy_mmu_mode();
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +process_smaller_pages:
>>>> +	if (pmd_trans_unstable(pmd)) {
>>>> +		arch_leave_lazy_mmu_mode();
>>>> +		return 0;
>>>
>>> I'm not sure whether this is right..  Shouldn't you return with -EAGAIN and
>>> let the user retry?  Returning 0 means you'll move on with the next pmd
>>> afaict and ignoring this one.
>> This has come up before. We are just replicating pagemap_pmd_range() here
>> as we are doing almost the same thing through IOCTL. It doesn't return any
>> error in this case and just skips it. So we are doing the same.
> 
> Hmm, is it a bug for pagemap?  pagemapread.buffer should be linear to the
> address range to be scanned to me.  If it skips some unstable pmd without
> filling in anything it seems everything later will be shifted with
> PMD_SIZE..  I had a feeling that it should set walk->action==ACTION_AGAIN
> before return.
I don't think this is a bug if this is how it was implemented in the first
place. In this task_mmu.c file, we can find several examples of the same
pattern that error isn't returned if pmd_trans_unstable() succeeds.

> 

-- 
BR,
Muhammad Usama Anjum
