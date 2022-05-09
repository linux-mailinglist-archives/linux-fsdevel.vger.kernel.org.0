Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001AF51F23C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 03:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiEIBaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 21:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiEIBWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 21:22:17 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F044DEAA;
        Sun,  8 May 2022 18:18:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCc6ZLn_1652059099;
Received: from 30.32.96.14(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCc6ZLn_1652059099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 09:18:20 +0800
Message-ID: <5e33cf5e-2c48-89fe-3447-2f29c7844928@linux.alibaba.com>
Date:   Mon, 9 May 2022 09:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/3] arm64/hugetlb: Introduce new
 huge_ptep_get_access_flags() interface
To:     nh26223@qq.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        sj@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
 <a73f07314e79299b85fa4d7612d6ac22548f58c1.1651998586.git.baolin.wang@linux.alibaba.com>
 <tencent_E3DE18C8CFE150F1EDCF887146BA374E6706@qq.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <tencent_E3DE18C8CFE150F1EDCF887146BA374E6706@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/8/2022 9:14 PM, nh26223@qq.com wrote:
> On 2022年5月8日星期日 CST 下午4:58:52 Baolin Wang wrote:
>> Now we use huge_ptep_get() to get the pte value of a hugetlb page,
>> however it will only return one specific pte value for the CONT-PTE
>> or CONT-PMD size hugetlb on ARM64 system, which can contain seravel
>> continuous pte or pmd entries with same page table attributes. And it
>> will not take into account the subpages' dirty or young bits of a
>> CONT-PTE/PMD size hugetlb page.
>>
>> So the huge_ptep_get() is inconsistent with huge_ptep_get_and_clear(),
>> which already takes account the dirty or young bits for any subpages
>> in this CONT-PTE/PMD size hugetlb [1]. Meanwhile we can miss dirty or
>> young flags statistics for hugetlb pages with current huge_ptep_get(),
>> such as the gather_hugetlb_stats() function.
>>
>> Thus introduce a new huge_ptep_get_access_flags() interface and define
>> an ARM64 specific implementation, that will take into account any subpages'
>> dirty or young bits for CONT-PTE/PMD size hugetlb page, for those functions
>> that want to check the dirty and young flags of a hugetlb page.
>>
>> [1]
>> https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracl
>> e.com/
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h |  2 ++
>>   arch/arm64/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
>>   include/asm-generic/hugetlb.h    |  7 +++++++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h
>> b/arch/arm64/include/asm/hugetlb.h index 616b2ca..a473544 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -44,6 +44,8 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct
>> *vma, #define __HAVE_ARCH_HUGE_PTE_CLEAR
>>   extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>   			   pte_t *ptep, unsigned long sz);
>> +#define __HAVE_ARCH_HUGE_PTEP_GET_ACCESS_FLAGS
>> +extern pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned long sz);
>>   extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>>   				 pte_t *ptep, pte_t pte, unsigned long
> sz);
>>   #define set_huge_swap_pte_at set_huge_swap_pte_at
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index ca8e65c..ce39699 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -158,6 +158,30 @@ static inline int num_contig_ptes(unsigned long size,
>> size_t *pgsize) return contig_ptes;
>>   }
>>
>> +pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned long sz)
> The function name looks to me that it returns access flags of PTE.

Yes, not a good name. That's why this is a RFC patch set to get more 
suggestion :)

Maybe huge_ptep_get_with_access_flags()? or do you have some better idea?

> 
>> +{
>> +	int ncontig, i;
>> +	size_t pgsize;
>> +	pte_t orig_pte = ptep_get(ptep);
>> +
>> +	if (!pte_cont(orig_pte))
>> +		return orig_pte;
>> +
>> +	ncontig = num_contig_ptes(sz, &pgsize);
>> +
>> +	for (i = 0; i < ncontig; i++, ptep++) {
>> +		pte_t pte = ptep_get(ptep);
>> +
>> +		if (pte_dirty(pte))
>> +			orig_pte = pte_mkdirty(orig_pte);
>> +
>> +		if (pte_young(pte))
>> +			orig_pte = pte_mkyoung(orig_pte);
>> +	}
>> +
>> +	return orig_pte;
>> +}
> Not sure whether it's worthy being changed to:
> 
>          bool dirty = false, young = false;
> 
>          for (i = 0; i < ncontig; i++, ptep++) {
>                  pte_t pte = ptep_get(ptep);
> 
>                  if (pte_dirty(pte))
>                          dirty = true;
> 
>                  if (pte_young(pte))
>                          young = true;
> 
>                  if (dirty && young)
>                          break;
>          }
> 
>          if (dirty)
>                  orig_pte = pte_mkdirty(orig_pte);
> 
>          if (young)
>                  orig_pte = pte_mkyoung(orit_pte);
> 
>          return orig_pte;

I followed the same logics in get_clear_flush(), which is more readable 
I think. Yes, your approach can save some cycles, I can change to use it 
in next version if arm64 maintainers have no objection.

>> +
>>   /*
>>    * Changing some bits of contiguous entries requires us to follow a
>>    * Break-Before-Make approach, breaking the whole contiguous set
>> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
>> index a57d667..bb77fb0 100644
>> --- a/include/asm-generic/hugetlb.h
>> +++ b/include/asm-generic/hugetlb.h
>> @@ -150,6 +150,13 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>>   }
>>   #endif
>>
>> +#ifndef __HAVE_ARCH_HUGE_PTEP_GET_ACCESS_FLAGS
>> +static inline pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned long
>> sz) +{
>> +	return ptep_get(ptep);
> Should be:
> 	return huge_ptep_get(ptep) ?

I don't think so. If no ARCH-specific definition, the 
huge_ptep_get_access_flags() implementation should be same as 
huge_ptep_get(). Thanks for your comments.

#ifndef __HAVE_ARCH_HUGE_PTEP_GET
static inline pte_t huge_ptep_get(pte_t *ptep)
{
         return ptep_get(ptep);
}
#endif
