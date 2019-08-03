Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602C880888
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2019 00:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfHCW2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 18:28:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44028 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbfHCW2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 18:28:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x73MPuZ2132045;
        Sat, 3 Aug 2019 22:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UZU8IQYzscAihSaZnmtnPHPOXp262WKqqbOV44Kxtac=;
 b=gQ7OfVQ3rHduBEjrThd6yZHDga5vKw3DvHU09qVOZESiWe4ib/+mtFoySn8TSEtp+I3A
 iheqWNU/1FMDxYwc1lUNs4N5mesCqTAgAYQVF7NUIottCehUNR5LbE3+ZF0kh4ckine3
 Y/C/bLrLMDg8kkUEs9DQwxmmOVLDBwrEP0ok6BfR40jqUUkoP1YKufimzlhGA0jxEcXo
 klPLnijNO9OwP4GpiS0Dn+MZWu2wgX4jnG+sgY9N2d3WmRZ/pJBTv0oD0esc3H/CQ/9F
 oCbHozX/m5Q9eRsclGSZ/lnCRUeIGuJbdK3n56kJ+vPXuYWUInXrcvNVUwhApcDt4Dud HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u527pa245-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 22:28:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x73MRstZ121099;
        Sat, 3 Aug 2019 22:28:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u4yctje4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Aug 2019 22:28:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x73MRtIb022005;
        Sat, 3 Aug 2019 22:27:55 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 03 Aug 2019 22:27:52 +0000
Subject: Re: [PATCH v3 2/2] mm,thp: Add experimental config option
 RO_EXEC_FILEMAP_HUGE_FAULT_THP
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
 <20190731082513.16957-3-william.kucharski@oracle.com>
 <20190801123658.enpchkjkqt7cdkue@box>
From:   William Kucharski <william.kucharski@oracle.com>
Message-ID: <c8d02a3b-e1ad-2b95-ce15-13d3ed4cca87@oracle.com>
Date:   Sat, 3 Aug 2019 16:27:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801123658.enpchkjkqt7cdkue@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9338 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908030268
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9338 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908030267
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/1/19 6:36 AM, Kirill A. Shutemov wrote:

>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -#define HPAGE_PMD_SHIFT PMD_SHIFT
>> -#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
>> -#define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
>> -
>> -#define HPAGE_PUD_SHIFT PUD_SHIFT
>> -#define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>> -#define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
>> +#define HPAGE_PMD_SHIFT		PMD_SHIFT
>> +#define HPAGE_PMD_SIZE		((1UL) << HPAGE_PMD_SHIFT)
>> +#define HPAGE_PMD_OFFSET	(HPAGE_PMD_SIZE - 1)
>> +#define HPAGE_PMD_MASK		(~(HPAGE_PMD_OFFSET))
>> +
>> +#define HPAGE_PUD_SHIFT		PUD_SHIFT
>> +#define HPAGE_PUD_SIZE		((1UL) << HPAGE_PUD_SHIFT)
>> +#define HPAGE_PUD_OFFSET	(HPAGE_PUD_SIZE - 1)
>> +#define HPAGE_PUD_MASK		(~(HPAGE_PUD_OFFSET))
> 
> OFFSET vs MASK semantics can be confusing without reading the definition.
> We don't have anything similar for base page size, right (PAGE_OFFSET is
> completely different thing :P)?

I came up with the OFFSET definitions, the MASK definitions already existed
in huge_mm.h, e.g.:

#define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))

Is there different terminology you'd prefer to see me use here to clarify
this?


>> +#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
>> +extern vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
>> +			enum page_entry_size pe_size);
>> +#endif
>> +
> 
> No need for #ifdef here.

I wanted to avoid referencing an extern that wouldn't exist if the config
option wasn't set; I can remove it.


>> +
>> +#ifndef	CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
>>   	if (PageSwapBacked(page)) {
>>   		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
>>   		if (PageTransHuge(page))
>> @@ -206,6 +208,13 @@ static void unaccount_page_cache_page(struct address_space *mapping,
>>   	} else {
>>   		VM_BUG_ON_PAGE(PageTransHuge(page), page);
>>   	}
>> +#else
>> +	if (PageSwapBacked(page))
>> +		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
>> +
>> +	if (PageTransHuge(page))
>> +		__dec_node_page_state(page, NR_SHMEM_THPS);
>> +#endif
> 
> Again, no need for #ifdef: the new definition should be fine for
> everybody.

OK, I can do that; I didn't want to unnecessarily eliminate the
VM_BUG_ON_PAGE(PageTransHuge(page)) call for everyone given this
is CONFIG experimental code.

> PageCompound() and PageTransCompound() are the same thing if THP is
> enabled at compile time.

> PageHuge() check here is looking out of place. I don't thing we can ever
> will see hugetlb pages here.

What I'm trying to do is sanity check that what the cache contains is a THP 
page. I added the PageHuge() check simply because PageTransCompound() is true 
for both THP and hugetlbfs pages, and there's no routine that returns true JUST 
for THP pages; perhaps there should be?

>> +		 *	+ the enbry is a page page with an order other than
> 
> Typo.

Thanks, fixed.

> 
>> +		 *	  HPAGE_PMD_ORDER
> 
> If you see unexpected page order in page cache, something went horribly
> wrong, right?

This routine's main function other than validation is to make sure the page 
cache has not been polluted between when we go out to read the large page and 
when the page is added to the cache (more on that coming up.) For example, the 
way I was able to tell readahead() was polluting future possible THP mappings is 
because after a buffered read I would typically see 52 (the readahead size) 
PAGESIZE pages for the next 2M range in the page cache.

>> +		 *	+ the page's index is not what we expect it to be
> 
> Same here.

Same rationale.

> 
>> +		 *	+ the page is not up-to-date
>> +		 *	+ the page is unlocked
> 
> Confused here.

These should never be true, but I wanted to double check for them anyway. I can 
eliminate the checks if we are satisfied these states can "never" happen for a 
cached page.

> 
> Do you expect caller to lock page before the check? If so, state it in the
> comment for the function.

It's my understanding that pages in the page cache should be locked, so I wanted 
to check for that.

This routine is validating entries we find in the page cache to see whether they 
are conflicts or valid cached THP pages.

> Wow. That's unreadable. Can we rewrite it something like (commenting each
> check):

I can definitely break it down into multiple checks; it is a bit dense, thus the 
comment but you're correct, it will read better if broken down more.


> You also need to check that VMA alignment is suitable for huge pages.
> See transhuge_vma_suitable().

I don't really care if the start of the VMA is suitable, just whether I can map
the current faulting page with a THP. As far as I know, there's nothing wrong
with mapping all the pages before the VMA hits a properly aligned bound with
PAGESIZE pages and then aligned chunks in the middle with THP.

>> +	if (unlikely(!(PageCompound(new_page)))) {
> 
> How can it happen?

That check was already removed for a pending v4, thanks. I wasn't sure if
__page_cache_alloc() could ever erroneously return a non-compound page so
I wanted to check for it.

>> +	__SetPageLocked(new_page);
> 
> Again?

This is the page that content was just read to; readpage() will unlock the page
when it is done with I/O, but the page needs to be locked before it's inserted
into the page cache.

>> +	/* did it get truncated? */
>> +	if (unlikely(new_page->mapping != mapping)) {
> 
> Hm. IIRC this path only reachable for just allocated page that is not
> exposed to anybody yet. How can it be truncated?

Matthew advised I duplicate the similar routine from filemap_fault(), but that 
may be because of the normal way pages get added to the cache, which I may need 
to modify my code to do.

>> +	ret = alloc_set_pte(vmf, NULL, hugepage);
> 
> It has to be
> 
> 	ret = alloc_set_pte(vmf, vmf->memcg, hugepage);
> 
> right?

I can make that change; originally alloc_set_pte() didn't use the second 
parameter at all when mapping a read-only page.

Even now, if the page isn't writable, it would only be dereferenced by a
VM_BUG_ON_PAGE() call if it's COW.

> It looks backwards to me. I believe the page must be in page cache
> *before* it got mapped.
> 
> I expect all sorts of weird bug due to races when the page is mapped but
> not visible via syscalls.

You may be correct.

My original thinking on this was that as a THP is going to be rarer and more 
valuable to the system, I didn't want to add it to the page cache until its 
contents had been fully read and it was mapped. Talking with Matthew it seems I 
may need to change to do things the same way as PAGESIZE pages, where the page 
is added to the cache prior to the readpage() call and we rely upon PageUptodate 
to see if the reads were successful.

My thinking had been if any part of reading a large page and mapping it had 
failed, the code could just put_page() the newly allocated page and fallback to 
mapping the page with PAGESIZE pages rather than add a THP to the cache.


>> +#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
> 
> IS_ENABLED()?
> 
>>   	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
>>   		goto out;
>> +#endif

This code short-circuits the address generation routine if the memory isn't DAX,
and if this code is enabled I need it not to goto out but rather fall through to
__thp_get_unmapped_area().

>> +	if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
>> +		(!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
> 
> Why require PROT_EXEC && PROT_READ. You only must ask for !PROT_WRITE.
> 
> And how do you protect against mprotect() later? Should you ask for
> ro-file instead?

My original goal was to only map program TEXT with THP, which means only
RO EXEC code, not just any non-writable address space.

If mprotect() is called, wouldn't the pages be COWed to PAGESIZE pages the
first time the area was written to? I may be way off on this assumption.

> All size considerations are already handled by thp_get_unmapped_area(). No
> need to duplicate it here.

Thanks, I'll remove them.

> You might want to add thp_ro_get_unmapped_area() that would check file for
> RO, before going for THP-suitable mapping.

Once again, the question is whether we want to make this just RO or RO + EXEC
to maintain my goal of just mapping program TEXT via THP. I'm willing to hear 
arguments either way.

> 
>> +		addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);
>> +
>> +		if (addr && (!(addr & HPAGE_PMD_OFFSET)))
>> +			vm_maywrite = 0;
> 
> Oh. That's way too hacky. Better to ask for RO file instead.

I did that because the existing code just blindly sets VM_MAYWRITE and I 
obviously didn't want to, so making it a variable allowed me to shut it off if 
it was a THP mapping.


>> +#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
>>   		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
>> +#endif
>> +
> 
> Just remove it. Don't add more #ifdefs.

OK; once again I didn't want to remove the existing VM_BUG_ON_PAGE() call
because this was an experimental config for now.


>> +#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
>>   		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
>> +#endif
>> +
> 
> Ditto.

Same rationale.

Thanks for looking this over; I'm curious as to what others think about the need 
for an RO file and the issue of when the large page gets added to the page cache.

     -- Bill
