Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1D766857
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjG1JLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjG1JLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2016C59F8
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690535310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vICWQosjgzvmsNNhYWSQCG3V0LU9ep5z1NVKRcrU2Uo=;
        b=F6qWBzs1mIVP7KZk7qIgPKkf0k3T69O7ps4MQkHn6DS/hAv71YzfkhyrUG/xnR/xnCBeW9
        W6garaOe1lGkyYZEgHo1/rgS/rig9hdIHXDZotVYDhrjXNyt77fxGeubmdfKQiUdIctvkZ
        VitTDeLAQbtV/F+Yh3iZt/PQ6zGP34U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-3nFQ0f3EO9OhJa_31gp4Eg-1; Fri, 28 Jul 2023 05:08:29 -0400
X-MC-Unique: 3nFQ0f3EO9OhJa_31gp4Eg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f2981b8364so1240582f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 02:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690535308; x=1691140108;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vICWQosjgzvmsNNhYWSQCG3V0LU9ep5z1NVKRcrU2Uo=;
        b=OoU9ZQxslF/hduF52eooNdV/x7NYhuSesSCi5JrstykOkh7nrZovaQ9lcLIsog+qI+
         mts6B6s0qLaQInxw5fsxhZqPq+cbfToXUEO7Rk+Ao8X7C2UttwLaGJ4m6tV2hl/X8ymc
         BfDBozmu/3U0NTcIiOXD5fbiCBp1kPy9SlSGcGbTB7sw/x8MIkb19QMgN1AIrq2BHk0x
         uyA5AhqPtSoUX7VoeIdRxvIRiQmFBKd3buvCrNtjrvDUZ+RLl2NRGTo9Sja1V02+iD0/
         VySAgxMBgFZzeFsxVyH3rHXfxLFeIyk9NoCYN127Re/kmDQeEMqljHdIfV+CmtutJk7O
         ndMg==
X-Gm-Message-State: ABy/qLa435SmtHKt6R6qxUJo0+oRJCId5OrrKa1xOaI4r8x1TjtQct49
        DNoYwRoaZaGPOXXG1tt79uXVeLE/+kWAeK3kL0ES55Z3xohQ9kdugQRO0q+IW4L/iytnXxnm4RE
        FJjuw4qqywndYyKomgc6mx5Qhkg==
X-Received: by 2002:a5d:67c5:0:b0:315:ad00:e628 with SMTP id n5-20020a5d67c5000000b00315ad00e628mr1568682wrw.47.1690535308173;
        Fri, 28 Jul 2023 02:08:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlET/x722nNr1YsUgbVHFCqqtp0/WG14rtyI/qnYZsfx1F2ctU05mFLkl1GS6ELaMkI9jDmxrA==
X-Received: by 2002:a5d:67c5:0:b0:315:ad00:e628 with SMTP id n5-20020a5d67c5000000b00315ad00e628mr1568654wrw.47.1690535307666;
        Fri, 28 Jul 2023 02:08:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4806000000b003143ac73fd0sm4343354wrq.1.2023.07.28.02.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 02:08:27 -0700 (PDT)
Message-ID: <9de80e22-e89f-2760-34f4-61be5f8fd39c@redhat.com>
Date:   Fri, 28 Jul 2023 11:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/4] mm/gup: Make follow_page() succeed again on
 PROT_NONE PTEs/PMDs
In-Reply-To: <55c92738-e402-4657-3d46-162ad2c09d68@nvidia.com>
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

On 28.07.23 04:30, John Hubbard wrote:
> On 7/27/23 14:28, David Hildenbrand wrote:
>> We accidentally enforced PROT_NONE PTE/PMD permission checks for
>> follow_page() like we do for get_user_pages() and friends. That was
>> undesired, because follow_page() is usually only used to lookup a currently
>> mapped page, not to actually access it. Further, follow_page() does not
>> actually trigger fault handling, but instead simply fails.
> 
> I see that follow_page() is also completely undocumented. And that
> reduces us to deducing how it should be used...these things that
> change follow_page()'s behavior maybe should have a go at documenting
> it too, perhaps.

I can certainly be motivated to do that. :)

> 
>>
>> Let's restore that behavior by conditionally setting FOLL_FORCE if
>> FOLL_WRITE is not set. This way, for example KSM and migration code will
>> no longer fail on PROT_NONE mapped PTEs/PMDS.
>>
>> Handling this internally doesn't require us to add any new FOLL_FORCE
>> usage outside of GUP code.
>>
>> While at it, refuse to accept FOLL_FORCE: we don't even perform VMA
>> permission checks like in check_vma_flags(), so especially
>> FOLL_FORCE|FOLL_WRITE would be dodgy.
>>
>> This issue was identified by code inspection. We'll add some
>> documentation regarding FOLL_FORCE next.
>>
>> Reported-by: Peter Xu <peterx@redhat.com>
>> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    mm/gup.c | 10 +++++++++-
>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 2493ffa10f4b..da9a5cc096ac 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -841,9 +841,17 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>>    	if (vma_is_secretmem(vma))
>>    		return NULL;
>>    
>> -	if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
>> +	if (WARN_ON_ONCE(foll_flags & (FOLL_PIN | FOLL_FORCE)))
>>    		return NULL;
> 
> This is not a super happy situation: follow_page() is now prohibited
> (see above: we should document that interface) from passing in
> FOLL_FORCE...

I guess you saw my patch #4.

If you take a look at the existing callers (that are fortunately very 
limited), you'll see that nobody cares.

Most of the FOLL flags don't make any sense for follow_page(), and 
limiting further (ab)use is at least to me very appealing.

> 
>>    
>> +	/*
>> +	 * Traditionally, follow_page() succeeded on PROT_NONE-mapped pages
>> +	 * but failed follow_page(FOLL_WRITE) on R/O-mapped pages. Let's
>> +	 * keep these semantics by setting FOLL_FORCE if FOLL_WRITE is not set.
>> +	 */
>> +	if (!(foll_flags & FOLL_WRITE))
>> +		foll_flags |= FOLL_FORCE;
>> +
> 
> ...but then we set it anyway, for special cases. It's awkward because
> FOLL_FORCE is not an "internal to gup" flag (yet?).
> 
> I don't yet have suggestions, other than:
> 
> 1) Yes, the FOLL_NUMA made things bad.
> 
> 2) And they are still very confusing, especially the new use of
>      FOLL_FORCE.
> 
> ...I'll try to let this soak in and maybe recommend something
> in a more productive way. :)

What I can offer that might be very appealing is the following:

Get rid of the flags parameter for follow_page() *completely*. Yes, then 
we can even rename FOLL_ to something reasonable in the context where it 
is nowadays used ;)


Internally, we'll then set

FOLL_GET | FOLL_DUMP | FOLL_FORCE

and document exactly what this functions does. Any user that needs 
something different should just look into using get_user_pages() instead.

I can prototype that on top of this work easily.

-- 
Cheers,

David / dhildenb

