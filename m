Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A007251F380
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 06:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiEIEbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiEIEWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 00:22:18 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A7711990D;
        Sun,  8 May 2022 21:18:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VCcryDl_1652069899;
Received: from 30.32.96.14(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCcryDl_1652069899)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 12:18:20 +0800
Message-ID: <fa5eb0c8-ca63-4100-2200-192aa3e4fc91@linux.alibaba.com>
Date:   Mon, 9 May 2022 12:19:00 +0800
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
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
 <tencent_E3DE18C8CFE150F1EDCF887146BA374E6706@qq.com>
 <5e33cf5e-2c48-89fe-3447-2f29c7844928@linux.alibaba.com>
 <tencent_4743B3E2F61F15E3BBF4251CAF3C0810B207@qq.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <tencent_4743B3E2F61F15E3BBF4251CAF3C0810B207@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/9/2022 12:10 PM, nh26223@qq.com write:
> ----------------8<---------------
>>>>
>>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>>> index ca8e65c..ce39699 100644
>>>> --- a/arch/arm64/mm/hugetlbpage.c
>>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>>> @@ -158,6 +158,30 @@ static inline int num_contig_ptes(unsigned long
>>>> size,
>>>> size_t *pgsize) return contig_ptes;
>>>>
>>>>    }
>>>>
>>>> +pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned long sz)
>>>
>>> The function name looks to me that it returns access flags of PTE.
>>
>> Yes, not a good name. That's why this is a RFC patch set to get more
>> suggestion :)
>>
>> Maybe huge_ptep_get_with_access_flags()? or do you have some better idea?
> I don't have either. "Naming is hard". :)
> 
>>>> diff --git a/include/asm-generic/hugetlb.h
>>>> b/include/asm-generic/hugetlb.h
>>>> index a57d667..bb77fb0 100644
>>>> --- a/include/asm-generic/hugetlb.h
>>>> +++ b/include/asm-generic/hugetlb.h
>>>> @@ -150,6 +150,13 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>>>>
>>>>    }
>>>>    #endif
>>>>
>>>> +#ifndef __HAVE_ARCH_HUGE_PTEP_GET_ACCESS_FLAGS
>>>> +static inline pte_t huge_ptep_get_access_flags(pte_t *ptep, unsigned
>>>> long
>>>> sz) +{
>>>> +	return ptep_get(ptep);
>>>
>>> Should be:
>>> 	return huge_ptep_get(ptep) ?
>>
>> I don't think so. If no ARCH-specific definition, the
>> huge_ptep_get_access_flags() implementation should be same as
>> huge_ptep_get(). Thanks for your comments.
> If no __HAVE_ARCH_HUGE_PTEP_GET, huge_ptep_get() is same as
> ptep_get().
> 
> Or it's not possible no __HAVE_ARCH_HUGE_PTEP_GET_ACCESS_FLAGS
> but with __HAVE_ARCH_HUGE_PTEP_GET?

Yes, I am wrong, shoule be huge_ptep_get(). Thanks for pointing out 
issues :)

PS: I think I will follow Muchun's suggestion in next version, so no 
need to add a new interface.
