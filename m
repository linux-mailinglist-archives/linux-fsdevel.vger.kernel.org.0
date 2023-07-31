Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94EB769C32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 18:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjGaQVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 12:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjGaQVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C3E78
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690820412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELxJX61JZUDVuGbmYJL8JIXJbn1HuECeDtl+/N3Ieec=;
        b=BatY2vWQ3ERquyky/OT1oLi/FQ/kA5GbGuuycPCS/yQHEJG0LpQxcSswqFt/i2pOHFH53n
        H7Jly3N1togUVYVTL2XBy/nYOJfGwicoAItY3QmjY2fm6hjOiIQqReI4pLqrqTCND8tKcW
        sgAnKHejKM0LRYlqPsQf7LFTTCCDHnA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-_4OaM2w1NGi5FPbad99SdQ-1; Mon, 31 Jul 2023 12:20:11 -0400
X-MC-Unique: _4OaM2w1NGi5FPbad99SdQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31758708b57so2965506f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jul 2023 09:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820410; x=1691425210;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELxJX61JZUDVuGbmYJL8JIXJbn1HuECeDtl+/N3Ieec=;
        b=YohF6vG3kUZ1uV3JwwI3CP0hx7UTfUw3MxM5MGFlFxeME8qsUch9xomzOoxC2COi7n
         lhIBmuoDBIewe/7bVVAt+4/x0VsB77bakTsCT8qZIhCA97XpL+fyWGOcSiiv3nFVjw6Q
         T4SnR/V4/FEQZMqDP3d0P7RRqVpyoCJt/3bKAAhF1pQ1CYUV+U5LFaHmngmZB9E9MJ2H
         CyhVf5NLJraMvO3ARD8z8+uD+0euQtURKz+kMikhhxssNPJdlh3xg/MDg4wd7a8S+BOb
         4xLlMezQl/9vfFwlPVOtKGNSrMg+Y2Hxj4/jSfP/ReQFedsFXw2Ob60DqwsWcMbD93zv
         E6KA==
X-Gm-Message-State: ABy/qLYG7LeBiwGitpWRZXwoburI6kxuco1Hcvy0QycSvtkP58IC8PQm
        FWC/2m1RCfw3amy93CVkPmNcau+DhhJWGsCJvi+EEYFUhSp4qP56vvL9Q5raWg29/JYNtqtQ1Ow
        Y267sIYOa58ef8P2E8rtSD6/rEQ==
X-Received: by 2002:a5d:50d0:0:b0:317:3c89:7f03 with SMTP id f16-20020a5d50d0000000b003173c897f03mr277785wrt.5.1690820409792;
        Mon, 31 Jul 2023 09:20:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHji9irVcFvjgqTFzYi9UvadswfJmbPmvwON5KNwN0L5dqmoVjMWxUCBTVI0m2yqO2THnHwhA==
X-Received: by 2002:a5d:50d0:0:b0:317:3c89:7f03 with SMTP id f16-20020a5d50d0000000b003173c897f03mr277760wrt.5.1690820409394;
        Mon, 31 Jul 2023 09:20:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c723:4c00:5c85:5575:c321:cea3? (p200300cbc7234c005c855575c321cea3.dip0.t-ipconnect.de. [2003:cb:c723:4c00:5c85:5575:c321:cea3])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm13606935wrv.71.2023.07.31.09.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 09:20:09 -0700 (PDT)
Message-ID: <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
Date:   Mon, 31 Jul 2023 18:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com>
 <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com> <ZMfc9+/44kViqjeN@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMfc9+/44kViqjeN@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> (2) Consequently, commit c46a7c817e66 from 2014 does not tell the whole
>>      story.
>>
>>      commit 21d9ee3eda77 ("mm: remove remaining references to NUMA
>>      hinting bits and helpers") from 2015 made the distinction again
>>      impossible.
>>
>>      Setting FOLL_FORCE | FOLL_HONOR_NUMA_HINT would end up never making
>>      progress in GUP with an inaccessible (PROT_NONE) VMA.
> 
> If we also teach follow_page_mask() on vma_is_accessible(), we should still
> be good, am I right?
> 
> Basically fast-gup will stop working on protnone, and it always fallbacks
> to slow-gup. Then it seems we're good decoupling FORCE with NUMA hint.
> 
> I assume that that's what you did below in the patch too, which looks right
> to me.

I modified it slightly: FOLL_HONOR_NUMA_FAULT is now set in 
is_valid_gup_args(), such that it will always be set for any GUP users, 
including GUP-fast.

[...]

>> +/*
>> + * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
>> + * a (NUMA hinting) fault is required.
>> + */
>> +static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
>> +					   unsigned int flags)
>> +{
>> +	/*
>> +	 * If callers don't want to honor NUMA hinting faults, no need to
>> +	 * determine if we would actually have to trigger a NUMA hinting fault.
>> +	 */
>> +	if (!(flags & FOLL_HONOR_NUMA_FAULT))
>> +		return true;
>> +
>> +	/* We really need the VMA ... */
>> +	if (!vma)
>> +		return false;
> 
> I'm not sure whether the compiler will be smart enough to inline this for
> fast-gup on pmd/pte.

Why shouldn't it? It's placed in a head file and the vma == NULL is not 
obfuscated. :)

Anyhow, I'll take a look at the compiler output.


Thanks!


-- 
Cheers,

David / dhildenb

