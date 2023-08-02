Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7323B76D131
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjHBPNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjHBPNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065D210D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690989134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+0KWNa1xwubY/Ggk8izjhhZVuMUOv4VLooz2GsqEHg=;
        b=IRR7X9LPKMUcaSHSPlvUnuc8pgL9j4k4WJkCB/eHKcM6V32PasUO/dKJoYwIJYneC2RrPX
        +1E/hqr/GtGAgWSKqahcsUliRGtmEqjV+CFPEztG7dA4moto2tejAK+6NdIBVp+obSGiJU
        Ti9zOtCRDyKQPDvH6NUeyMekl21dSm8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-61jmZyBIP5K0tqdd8IvVhw-1; Wed, 02 Aug 2023 11:12:11 -0400
X-MC-Unique: 61jmZyBIP5K0tqdd8IvVhw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe1521678fso30499585e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 08:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989130; x=1691593930;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+0KWNa1xwubY/Ggk8izjhhZVuMUOv4VLooz2GsqEHg=;
        b=HhdshaO/jKX4a11MwBHUUvoNkBXQhxEYGQ36q/Uae5h5+fJixqvueGQAJRtxF93cDq
         t+NrYgDu0zTKlt/JA/L4x5VbDnR37x7vdeK6Ctv6jv5fVN3PMuuSGzREc3hWPJhvTla8
         arCFjArYwHdMs4BMROUScqDW37l/W9bbuekJ1Ujo49uIrmkhMFmaXMu8PypLGBG4EP8c
         KQzU47tJl27yyhXuEW7HY3vXTjGNzVL2DPGPPm9b1gBiKXQ5DWcRFHosqR0j9Pph4DBv
         SiyiuhJu3PJu8KNnDVy9L/TZHoC9Umebq9O8+qHkS/PUrz2OJX9o1clOVxyOPxhS5oGs
         QTEA==
X-Gm-Message-State: ABy/qLbocfQN69upxvfubE6BoPu53oB2Y0cA5ULIA71Pgg90L0J+2HgS
        HgvrSIlCCTHBseo1WGAGzRz6Kn/d46AokPxdEtXD5SXcHGb8QTUHZIWPMad6VMyzhCntS9A3XZH
        YqgIa0ytHNdVz+/uf3RlCNuXHPg==
X-Received: by 2002:a5d:595b:0:b0:316:f3cf:6f12 with SMTP id e27-20020a5d595b000000b00316f3cf6f12mr4856135wri.48.1690989130092;
        Wed, 02 Aug 2023 08:12:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFiwCmVukTG4b003Kw1jOw/WrbZSFH1/nxmUVT0cf0q5oxfG7XYzDO68q2V6Sj2RMU4SGVtAg==
X-Received: by 2002:a5d:595b:0:b0:316:f3cf:6f12 with SMTP id e27-20020a5d595b000000b00316f3cf6f12mr4856114wri.48.1690989129710;
        Wed, 02 Aug 2023 08:12:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4f12000000b0030647449730sm19346391wru.74.2023.08.02.08.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:12:09 -0700 (PDT)
Message-ID: <fa396bd9-9453-2212-6cfd-9dc0ae1c8c48@redhat.com>
Date:   Wed, 2 Aug 2023 17:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/8] mm/gup: reintroduce FOLL_NUMA as
 FOLL_HONOR_NUMA_FAULT
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-2-david@redhat.com>
 <20230802150816.aaubbx4t7745lqik@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230802150816.aaubbx4t7745lqik@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Reported-by: liubo <liubo254@huawei.com>
>> Closes: https://lore.kernel.org/r/20230726073409.631838-1-liubo254@huawei.com
>> Reported-by: Peter Xu <peterx@redhat.com>
>> Closes: https://lore.kernel.org/all/ZMKJjDaqZ7FW0jfe@x1n/
>> Fixes: 474098edac26 ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I agree that FOLL_REMOTE probably needs separate treatment but also agree
> that it's outside the context of this patch, particularly as a -stable
> candidate so
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> I've a minor nit below that would be nice to get fixed up, but not
> mandatory.

Thanks Mel for taking a look, so I don't mess up once more :)

> 
>> ---
>>   include/linux/mm.h       | 21 +++++++++++++++------
>>   include/linux/mm_types.h |  9 +++++++++
>>   mm/gup.c                 | 29 +++++++++++++++++++++++------
>>   mm/huge_memory.c         |  2 +-
>>   4 files changed, 48 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 2493ffa10f4b..f463d3004ddc 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>>   		gup_flags |= FOLL_UNLOCKABLE;
>>   	}
>>   
>> +	/*
>> +	 * For now, always trigger NUMA hinting faults. Some GUP users like
>> +	 * KVM really require it to benefit from autonuma.
>> +	 */
>> +	gup_flags |= FOLL_HONOR_NUMA_FAULT;
>> +
>>   	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>>   	if (WARN_ON_ONCE((gup_flags & (FOLL_PIN | FOLL_GET)) ==
>>   			 (FOLL_PIN | FOLL_GET)))
> 
> Expand on *why* KVM requires it even though I suspect this changes later
> in the series. Maybe "Some GUP users like KVM require the hint to be as
> the calling context of GUP is functionally similar to a memory reference
> from task context"?

It's raised later in this series but it doesn't hurt to discuss it here 
in a bit more detail.

Sounds good to me.

> 
> Also minor nit -- s/autonuma/NUMA Balancing/ or numab. autonuma refers to
> a specific implementation of automatic balancing that operated similar to
> khugepaged but not merged. If you grep for it, you'll find that autonuma
> is only referenced in powerpc-specific code. It's not important these
> days but very early on, it was very confusing if AutoNUMA was mentioned
> when NUMAB was intended.

Ah, yes, thanks. That's the one of the only place where that terminology 
accidentally slipped in.

I'll wait for more feedback and resend!

-- 
Cheers,

David / dhildenb

