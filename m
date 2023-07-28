Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211B17669FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjG1KOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjG1KNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB7230F5
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 03:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690539182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBSITkR13Me7nA0UvBku+KqeFgHRRHFCLDJ6AjKdk9M=;
        b=jFnf9neNBpjpv18J8HRR/RFkfea9B2RRvj3NPREFacHhlxGzuKPvkM6B9Fr4dQKvkMdOfd
        TZF5iU9MSiqMyexc7dARDEqlEs00O1u3Z/VX0DDAk+rlCE/7e6lP/yojTfh/CEOitcdH9S
        5sbHd856yNCWhUMnzPT6qnAylDU3UYY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-M-Ewf9SbN_yAE0J2pboBvg-1; Fri, 28 Jul 2023 06:13:01 -0400
X-MC-Unique: M-Ewf9SbN_yAE0J2pboBvg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b00a80e9so16951501fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 03:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539179; x=1691143979;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBSITkR13Me7nA0UvBku+KqeFgHRRHFCLDJ6AjKdk9M=;
        b=EQzHh1s1q1/glRX2tiVlbJUC51t8VRqvNMIHj0fRT3YdTOZyI8cXluUZaAcOkQXWEU
         ks8yuFvK8QrLncLIqfyFvN91tZOMKlOCJFu/Y7IRX6ml2AJSPQLgWSFWuEsfYeIg57jO
         6IaLNnjN88A/fMC/VvTghZBXFykuzSCLq2PfQFKl3XBvmHrKQA9jX5qmr98tJwkugZI+
         AEFlFUXcmdo0DA51dTD3ssfsEmnQlojK9yexmOugRsj+/YX+iNNxUuAFbGDUGNMHeD/h
         Y2cDvoH71xgQictkt1DnB+3awNXiPwBOpPMe2lXNMBMztUO+KsDQwys5m/bssiYOrZcG
         g8OA==
X-Gm-Message-State: ABy/qLZnWKKKDKRXb2NmC/hYsppgLdd2k4E5Y1C5YBqrnIII4MN/fFNd
        mWQIrqPjLc1T+m7ncqM4P4w4tYYtNGhfs7f8Ww89tjyjqhCVkw4pZFigrBkc4SJ9Wd1vjxjwCoz
        t2A6zWSnR6OMNIFH+WCAmdlONDg==
X-Received: by 2002:a2e:9d84:0:b0:2b9:d07f:ee50 with SMTP id c4-20020a2e9d84000000b002b9d07fee50mr1233690ljj.30.1690539179753;
        Fri, 28 Jul 2023 03:12:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkAr1jxNT4mmSwfn2e2XtO3UnoTO1B9ASM5Fa1JtMt3k6efdjWl5GqbHAD0g1vAdfROlzYmg==
X-Received: by 2002:a2e:9d84:0:b0:2b9:d07f:ee50 with SMTP id c4-20020a2e9d84000000b002b9d07fee50mr1233664ljj.30.1690539179271;
        Fri, 28 Jul 2023 03:12:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b003fc01495383sm6592524wmj.6.2023.07.28.03.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:12:58 -0700 (PDT)
Message-ID: <13b14aa6-302e-63cc-2a99-f5c22b9931fc@redhat.com>
Date:   Fri, 28 Jul 2023 12:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
References: <20230727212845.135673-1-david@redhat.com>
 <20230727212845.135673-3-david@redhat.com>
 <55c92738-e402-4657-3d46-162ad2c09d68@nvidia.com>
 <9de80e22-e89f-2760-34f4-61be5f8fd39c@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/4] mm/gup: Make follow_page() succeed again on
 PROT_NONE PTEs/PMDs
In-Reply-To: <9de80e22-e89f-2760-34f4-61be5f8fd39c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.07.23 11:08, David Hildenbrand wrote:
> On 28.07.23 04:30, John Hubbard wrote:
>> On 7/27/23 14:28, David Hildenbrand wrote:
>>> We accidentally enforced PROT_NONE PTE/PMD permission checks for
>>> follow_page() like we do for get_user_pages() and friends. That was
>>> undesired, because follow_page() is usually only used to lookup a currently
>>> mapped page, not to actually access it. Further, follow_page() does not
>>> actually trigger fault handling, but instead simply fails.
>>
>> I see that follow_page() is also completely undocumented. And that
>> reduces us to deducing how it should be used...these things that
>> change follow_page()'s behavior maybe should have a go at documenting
>> it too, perhaps.
> 
> I can certainly be motivated to do that. :)
> 
>>
>>>
>>> Let's restore that behavior by conditionally setting FOLL_FORCE if
>>> FOLL_WRITE is not set. This way, for example KSM and migration code will
>>> no longer fail on PROT_NONE mapped PTEs/PMDS.
>>>
>>> Handling this internally doesn't require us to add any new FOLL_FORCE
>>> usage outside of GUP code.
>>>
>>> While at it, refuse to accept FOLL_FORCE: we don't even perform VMA
>>> permission checks like in check_vma_flags(), so especially
>>> FOLL_FORCE|FOLL_WRITE would be dodgy.
>>>
>>> This issue was identified by code inspection. We'll add some
>>> documentation regarding FOLL_FORCE next.
>>>
>>> Reported-by: Peter Xu <peterx@redhat.com>
>>> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>     mm/gup.c | 10 +++++++++-
>>>     1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 2493ffa10f4b..da9a5cc096ac 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -841,9 +841,17 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>>>     	if (vma_is_secretmem(vma))
>>>     		return NULL;
>>>     
>>> -	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
>>> +	if (WARN_ON_ONCE(foll_flags & (FOLL_PIN | FOLL_FORCE)))
>>>     		return NULL;
>>
>> This is not a super happy situation: follow_page() is now prohibited
>> (see above: we should document that interface) from passing in
>> FOLL_FORCE...
> 
> I guess you saw my patch #4.
> 
> If you take a look at the existing callers (that are fortunately very
> limited), you'll see that nobody cares.
> 
> Most of the FOLL flags don't make any sense for follow_page(), and
> limiting further (ab)use is at least to me very appealing.
> 
>>
>>>     
>>> +	/*
>>> +	 * Traditionally, follow_page() succeeded on PROT_NONE-mapped pages
>>> +	 * but failed follow_page(FOLL_WRITE) on R/O-mapped pages. Let's
>>> +	 * keep these semantics by setting FOLL_FORCE if FOLL_WRITE is not set.
>>> +	 */
>>> +	if (!(foll_flags & FOLL_WRITE))
>>> +		foll_flags |= FOLL_FORCE;
>>> +
>>
>> ...but then we set it anyway, for special cases. It's awkward because
>> FOLL_FORCE is not an "internal to gup" flag (yet?).
>>
>> I don't yet have suggestions, other than:
>>
>> 1) Yes, the FOLL_NUMA made things bad.
>>
>> 2) And they are still very confusing, especially the new use of
>>       FOLL_FORCE.
>>
>> ...I'll try to let this soak in and maybe recommend something
>> in a more productive way. :)
> 
> What I can offer that might be very appealing is the following:
> 
> Get rid of the flags parameter for follow_page() *completely*. Yes, then
> we can even rename FOLL_ to something reasonable in the context where it
> is nowadays used ;)
> 
> 
> Internally, we'll then set
> 
> FOLL_GET | FOLL_DUMP | FOLL_FORCE
> 
> and document exactly what this functions does. Any user that needs
> something different should just look into using get_user_pages() instead.
> 
> I can prototype that on top of this work easily.

The end result looks something like:

/**
  * follow_page - look up and reference a page descriptor from a user-virtual
  * 		 address
  * @vma: vm_area_struct mapping @address
  * @address: virtual address to look up
  *
  * follow_page() will look up the page mapped at the given address and
  * take a reference on the page. The returned page has to be released using
  * put_page().
  *
  * follow_page() will not return special (like zero) pages and does not check
  * PTE protection: the returned page might be mapped PROT_NONE, R/O or R/W.
  * Consequently, follow_page() will not trigger NUMA hinting faults.
  *
  * follow_page() does not trigger page faults. If no page is mapped, or
  * a special (like zero) page is mapped, it returns %NULL or an error pointer.
  *
  * Note: new users with different requirements are probably better off using
  *       one of the get_user_pages() variants or one of the walk_page_range()
  *       variants.
  *
  * Return: the mapped (struct page *), %NULL if no mapping exists, or
  * an error pointer if there is a mapping to something not represented
  * by a page descriptor (see also vm_normal_page()) or the zero page.
  */
struct page *follow_page(struct vm_area_struct *vma, unsigned long address)
{
	struct follow_page_context ctx = { NULL };
	unsigned long gup_flags;
	struct page *page;

	if (vma_is_secretmem(vma))
		return NULL;

	/*
	 * FOLL_GET: We always want a reference on the returned page.
	 * FOL_DUMP: Ignore special (like zero) pages.
	 * FOLL_FORCE: Succeeded on PROT_NONE-mapped pages.
	 */
	gup_flags = FOLL_GET | FOLL_DUMP | FOLL_FORCE;

	page = follow_page_mask(vma, address, gup_flags, &ctx);
	if (ctx.pgmap)
		put_dev_pagemap(ctx.pgmap);
	return page;
}

-- 
Cheers,

David / dhildenb

