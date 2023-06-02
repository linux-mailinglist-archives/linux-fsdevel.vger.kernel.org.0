Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A196872088B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbjFBRnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbjFBRnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:43:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFF1A8;
        Fri,  2 Jun 2023 10:42:58 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9B04F6603219;
        Fri,  2 Jun 2023 18:42:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685727776;
        bh=L0+U78HTWagUwT0U3upt9ZPc9drPbE7g2HOGcZx4mCE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=LeJMYY6wKBnv7EDGH62hwm8At5cqeLNlFPvkpvffEz6xuhvDCPrUML8prH4kUTDRR
         JWO4lQM4PnBtnd4Ie/+Y1VOsOwW6kLMnfVilkXRxe65jBrW3IBDTYTGYTWshApZNbx
         VL23DSeorVLuptfblOWGCDJzB4owZi6JxtNrBooOmZFEV1TeDdpI1FwWrYrzLgYiGe
         9a1jZx4e3hzcx6jChuICMDluuWFoWO1ld0oNxypjaXN8FHRoSyTgSbIYdphtLCFrAu
         H58NQIimv07V0LLPHu4HZYXfl7LTWU6a+CGMcujHO+m0/DHLDw/L29/ZDVFL6LyGEh
         ncRw+pPm5ykSQ==
Message-ID: <be70e76a-3875-6e1b-a5aa-b89d2368b904@collabora.com>
Date:   Fri, 2 Jun 2023 22:42:45 +0500
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
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230525085517.281529-1-usama.anjum@collabora.com>
 <20230525085517.281529-3-usama.anjum@collabora.com> <ZHfAOAKj1ZQJ+zSy@x1n>
 <aeaaa33e-4d23-fd3a-1357-4751007aa3bd@collabora.com> <ZHj7jmJ5fKla1Rax@x1n>
 <3589803d-5594-71de-d078-ad4499f233b6@collabora.com> <ZHodIFQesrCA53To@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZHodIFQesrCA53To@x1n>
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

Thank you for reviewing and helping out.

On 6/2/23 9:47 PM, Peter Xu wrote:
[...]
>>>> static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
>>>> 					 unsigned long addr, pte_t *ptep,
>>>> 					 pte_t ptent)
>>>> {
>>>> 	if (is_hugetlb_entry_hwpoisoned(ptent) || is_pte_marker(ptent))
>>>> 		return;
>>>>
>>>> 	if (is_hugetlb_entry_migration(ptent))
>>>> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
>>>> 				pte_swp_mkuffd_wp(ptent));
>>>> 	else if (!huge_pte_none(ptent))
>>>> 		ptep_modify_prot_commit(vma, addr, ptep, ptent,
>>>> 					huge_pte_mkuffd_wp(ptent));
>>>> 	else
>>>> 		set_huge_pte_at(vma->vm_mm, addr, ptep,
>>>> 				make_pte_marker(PTE_MARKER_UFFD_WP));
>>>> }
>>>
>>> the is_pte_marker() check can be extended to double check
>>> pte_marker_uffd_wp() bit, but shouldn't matter a lot since besides the
>>> uffd-wp bit currently we only support swapin error which should sigbus when
>>> accessed, so no point in tracking anyway.
>> Yeah, we are good with what we have as even if more bits are supported in
>> pte markers, this function is only reached when UNPOPULATED + ASYNC WP are
>> enabled. So no other bit would be set on the marker.
> 
> I think we don't know?  swapin error bit can be set there afaiu, if someone
> swapoff -a and found a swap device broken for some swapped out ptes.
Oops, so I remove returning on pte marker detection. Instead the last else
is already setting marker wp-ed.

> 
> But again I think that's fine for now.
> 
>>
>>>
>>>>
>>>> As we always set UNPOPULATED, so markers are always set on none ptes
>>>> initially. Is it possible that a none pte becomes present, then swapped and
>>>> finally none again? So I'll do the following addition for make_uffd_wp_pte():
>>>>
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -1800,6 +1800,9 @@ static inline void make_uffd_wp_pte(struct
>>>> vm_area_struct *vma,
>>>>  	} else if (is_swap_pte(ptent)) {
>>>>  		ptent = pte_swp_mkuffd_wp(ptent);
>>>>  		set_pte_at(vma->vm_mm, addr, pte, ptent);
>>>> +	} else {
>>>> +		set_pte_at(vma->vm_mm, addr, pte,
>>>> +			   make_pte_marker(PTE_MARKER_UFFD_WP));
>>>>  	}
>>>>  }
>>>
>>> Makes sense, you can leverage userfaultfd_wp_use_markers() here, and you
>>> should probably keep the protocol (only set the marker when WP_UNPOPULATED
>>> for anon).
>> This function is only reachable when UNPOPULATED + Async WP are set. So we
>> don't need to use userfaultfd_wp_use_markers().
> 
> I don't remember where you explicitly checked that to make sure it'll
> always be the case, but if you do it'll still be nice if you can add a
> comment right above here explaining.
I was only testing for WP and WP Async in pagemap_scan_test_walk() as WP
async can only be enabled if unpopulated is enabled which in turn enables
the markers. I'll add userfaultfd_wp_use_markers() to pagemap_scan_test_walk().

> 
> Or, maybe you can still use userfaultfd_wp_use_markers() here, then you can
> just WARN_ON_ONCE() on it, which looks even better?
> 
> [...]
> 
>>> Hmm, is it a bug for pagemap?  pagemapread.buffer should be linear to the
>>> address range to be scanned to me.  If it skips some unstable pmd without
>>> filling in anything it seems everything later will be shifted with
>>> PMD_SIZE..  I had a feeling that it should set walk->action==ACTION_AGAIN
>>> before return.
>> I don't think this is a bug if this is how it was implemented in the first
>> place. In this task_mmu.c file, we can find several examples of the same
>> pattern that error isn't returned if pmd_trans_unstable() succeeds.
> 
> I don't see why multiple same usages mean it's correct.. maybe they're all
> buggy?
> 
> I can post a patch for this to collect opinions to see if I missed
> something. I'd suggest you figure out what's the right thing to do for the
> new interface and make it right from the start, no matter how it was
> implemented elsewhere.
Alright. At first sight, it seems I should return -EAGAIN here. But there
maybe a case where there are 3 THPs. I've cleared WP over the first THP and
put data in the user buffer. If I return -EAGAIN, the data in the user
buffer would be not used by the user correctly as negative value has been
returned. So the best way here would be to skip this second VMA and don't
abort the operation. Thus we'll not be giving any information about the
second THP as it was in transition.

I'll think about it again before sending next version.

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
