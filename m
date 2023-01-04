Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5FA65CF09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 10:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjADJFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 04:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjADJEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:04:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B1A25F0
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 01:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672823049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3v5Qr9aSLQNkwvt7Qa+s/hSgVujW47TYO8SFPz2SG6c=;
        b=gNcgWcpW7T7M27wiyfRYGewM2wXoUYxGqqSuzPL1lwZ9OmLOe9EYQUvSHpYz5N6V1cBCZI
        sVcVaVbgXLaVuTbj5iXyoD03BUwOPEPn0MjsrnEoI1J7NXjXB5YbMJkVIh2hqn7xwsQh2I
        3MWStow5Uun+HY/SBzxZBGQDVPCkd2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-ia9cchhbPSWsoH8y_cigXQ-1; Wed, 04 Jan 2023 04:04:08 -0500
X-MC-Unique: ia9cchhbPSWsoH8y_cigXQ-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c4f9200b003d993e08485so10507401wmq.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 01:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3v5Qr9aSLQNkwvt7Qa+s/hSgVujW47TYO8SFPz2SG6c=;
        b=NddzJX+7ULYzYLepIzvGFos5wknypthV4rhXQ5C4ot9K3zT0b/bBmTziiZZEeh9rcj
         Ppd5efB0WoFif16fvG75hBOEtUt95gNSjHexCi3lXVqRd25N/6Y270Yqz03E43t4m1WV
         TeJhU9/m/dUl4A/BSP/oR5PiCdsHXunMq/wOzF9YFR0kWzR207YaSe5H0h1GPnB91709
         DoKdAlUW+Wc1BP/svQhVsvG6hDaCY3EQvTEKmKYyiCEFc3U5fmeIDcUWfC0DywQOIwqy
         9l+afg/e15/jLkD55MStoQxIwojwtmuKh0TIHNmBmTYxxacLbRD6zIBzIKUpEe5hu28I
         TKRg==
X-Gm-Message-State: AFqh2kpSOzjFM15+zh/HYG+40Q5qUwoc955WPvJ/JaiZbRsxMWIwt9WX
        9I5PgCqe1KrDrUL8TLnGvAuFFDgyJg/746rCMs2cUOVso00Esxxp30oCGBjZlW7jNyemluW+0ve
        vvj2wWM9uGvau/7+VcBeP0o91+w==
X-Received: by 2002:a05:600c:2d85:b0:3d0:7d89:2256 with SMTP id i5-20020a05600c2d8500b003d07d892256mr32189741wmg.13.1672823047443;
        Wed, 04 Jan 2023 01:04:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu6TKYF8n/sbH/DYFQlrGieorL58hStPNcoaQHix/JEwDP10q76ayzPzUHCuWo/AHMULsh+lA==
X-Received: by 2002:a05:600c:2d85:b0:3d0:7d89:2256 with SMTP id i5-20020a05600c2d8500b003d07d892256mr32189690wmg.13.1672823046983;
        Wed, 04 Jan 2023 01:04:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:f100:8100:5a6c:eb:fd3b? (p200300cbc703f10081005a6c00ebfd3b.dip0.t-ipconnect.de. [2003:cb:c703:f100:8100:5a6c:eb:fd3b])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b003d99469ece1sm28460642wmo.24.2023.01.04.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 01:04:06 -0800 (PST)
Message-ID: <b3aec4d4-737d-255a-d25e-451222fc9bb9@redhat.com>
Date:   Wed, 4 Jan 2023 10:04:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20221228194249.170354-1-surenb@google.com>
 <6ddb468a-3771-92a1-deb1-b07a954293a3@redhat.com>
 <CAJuCfpGUpPPoKjAAmV7UK2H2o2NqsSa+-_M6JwesCfc+VRY2vw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJuCfpGUpPPoKjAAmV7UK2H2o2NqsSa+-_M6JwesCfc+VRY2vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.01.23 20:53, Suren Baghdasaryan wrote:
> On Mon, Jan 2, 2023 at 4:00 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 28.12.22 20:42, Suren Baghdasaryan wrote:
>>> free_anon_vma_name() is missing a check for anonymous shmem VMA which
>>> leads to a memory leak due to refcount not being dropped. Fix this by
>>> adding the missing check.
>>>
>>> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
>>> Reported-by: syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>    include/linux/mm_inline.h | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
>>> index e8ed225d8f7c..d650ca2c5d29 100644
>>> --- a/include/linux/mm_inline.h
>>> +++ b/include/linux/mm_inline.h
>>> @@ -413,7 +413,7 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
>>>         * Not using anon_vma_name because it generates a warning if mmap_lock
>>>         * is not held, which might be the case here.
>>>         */
>>> -     if (!vma->vm_file)
>>> +     if (!vma->vm_file || vma_is_anon_shmem(vma))
>>>                anon_vma_name_put(vma->anon_name);
>>
>> Wouldn't it be me more consistent to check for "vma->anon_name"?
>>
>> That's what dup_anon_vma_name() checks. And it's safe now because
>> anon_name is no longer overloaded in vm_area_struct.
> 
> Thanks for the suggestion, David. Yes, with the recent change that
> does not overload anon_name, checking for "vma->anon_name" would be
> simpler. I think we can also drop anon_vma_name() function now
> (https://elixir.bootlin.com/linux/v6.2-rc2/source/mm/madvise.c#L94)
> since vma->anon_name does not depend on vma->vm_file anymore, remove
> the last part of this comment:
> https://elixir.bootlin.com/linux/v6.2-rc2/source/include/linux/mm_types.h#L584
> and use vma->anon_name directly going forward. If all that sounds
> good, I'll post a separate patch implementing all these changes.
> So, for this patch I would suggest keeping it as is because
> functionally it is correct and will change this check along with other
> corrections I mentioned above in a separate patch. Does that sound
> good?

Works for me.

Acked-by: David Hildenbrand <david@redhat.com>

for this one, as it fixes the issue.

-- 
Thanks,

David / dhildenb

