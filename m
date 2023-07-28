Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2876767B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjG1TmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 15:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjG1TmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B06C469C
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690573260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6CFqQJrBMK5OCT43NGOkfBvaqBjcX1+gjelAIZOy930=;
        b=CFDqJ8Po8Iz2lI5EfGh/3i41licXKuao56/5gxedZXFoM5nAHVFBXMc+RDIqr78GNKmRaG
        7oVmHWikjaOb2bBW2kgoCUwFxIzYx767srhI71i9RoQTu3/dJaaUhnQ4I/VrX8u4XxwgJd
        GPLDyrp40A9r9ZeJkGdxcs8IKOrvTTU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-R8-jy3VPPhOYxgOnPYgBtg-1; Fri, 28 Jul 2023 15:40:58 -0400
X-MC-Unique: R8-jy3VPPhOYxgOnPYgBtg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3176549261aso1273431f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 12:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573257; x=1691178057;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :content-language:references:cc:to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CFqQJrBMK5OCT43NGOkfBvaqBjcX1+gjelAIZOy930=;
        b=YNkC36zHn7uUcJe8Ts3DBlWbHwouqnhB6Ou3DHuyTXu9mKLxBDRtfkx7NsYhQ713Tj
         XF1vTwUwa8rdIfjnRFYscVSkD8RgjK2UkeLy7xGi3UM1FlMzK5WyiZFTdK2qUgZQqdOI
         MrAycnu7AQYMYhzCIpxIZChqbG86QsXWztZZPllefoY4Wm/1fKRI5C/sSXeXPuc6+Fo+
         0Jxx6lc2pb43CTDHgWvn7FSeJFQgSaENxeEBKzbWToLBvHZsS3yxYn1/aNyjB4Pah87F
         CmdWz8FZMuWgpirWxelFk3EU9bJzk3ry4utMQAwpfTqa1TvarOUMKJOrkTOEuPYAwzLp
         bkOw==
X-Gm-Message-State: ABy/qLaxYm2498knveBhk2PSg25rakA3KmVThgU/Gpdy3qxjO7NjC478
        ajpzXPnpukP1rjC++TnSw+ForbNKBtOTBomiRCC4yFtNU8zkihC6QHaqNUy9vBZhhWiHweE6cVw
        steOzRMR4d5ffoWSZel6a6DGZ6w==
X-Received: by 2002:a5d:6606:0:b0:313:f9a0:c530 with SMTP id n6-20020a5d6606000000b00313f9a0c530mr2306625wru.52.1690573256904;
        Fri, 28 Jul 2023 12:40:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFePgWAB+PbJAsSFIJBhYiJefyMuHGcUdsjOuoT93P9W3fJx6mX384ZMq38qfMLqnXTTYgaQA==
X-Received: by 2002:a5d:6606:0:b0:313:f9a0:c530 with SMTP id n6-20020a5d6606000000b00313f9a0c530mr2306606wru.52.1690573256521;
        Fri, 28 Jul 2023 12:40:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b003fbfef555d2sm7614164wmm.23.2023.07.28.12.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 12:40:56 -0700 (PDT)
Message-ID: <b647fd9a-3d75-625c-9f2c-dd3c251528c4@redhat.com>
Date:   Fri, 28 Jul 2023 21:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   David Hildenbrand <david@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
Content-Language: en-US
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
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

On 28.07.23 19:30, David Hildenbrand wrote:
> On 28.07.23 18:18, Linus Torvalds wrote:
>> On Thu, 27 Jul 2023 at 14:28, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> This is my proposal on how to handle the fallout of 474098edac26
>>> ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()") where I
>>> accidentially missed that follow_page() and smaps implicitly kept the
>>> FOLL_NUMA flag clear by *not* setting it if FOLL_FORCE is absent, to
>>> not trigger faults on PROT_NONE-mapped PTEs.
>>
>> Ugh.
> 
> I was hoping for that reaction, with the assumption that we would get
> something cleaner :)
> 
>>
>> I hate how it uses FOLL_FORCE that is inherently scary.
> 
> I hate FOLL_FORCE, but I hate FOLL_NUMA even more, because to me it
> is FOLL_FORCE in disguise (currently and before 474098edac26, if
> FOLL_FORCE is set, FOLL_NUMA won't be set and the other way around).
> 
>>
>> Why do we have that "gup_can_follow_protnone()" logic AT ALL?
> 
> That's what I was hoping for.
> 
>>
>> Couldn't we just get rid of that disgusting thing, and just say that
>> GUP (and follow_page()) always just ignores NUMA hinting, and always
>> just follows protnone?
>>
>> We literally used to have this:
>>
>>           if (!(gup_flags & FOLL_FORCE))
>>                   gup_flags |= FOLL_NUMA;
>>
>> ie we *always* set FOLL_NUMA for any sane situation. FOLL_FORCE should
>> be the rare crazy case.
> 
> Yes, but my point would be that we now spell that "rare crazy case"
> out for follow_page().
> 
> If you're talking about patch #1, I agree, therefore patch #3 to
> avoid all that nasty FOLL_FORCE handling in GUP callers.
> 
> But yeah, if we can avoid all that, great.
> 
>>
>> The original reason for not setting FOLL_NUMA all the time is
>> documented in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting
>> page faults from gup/gup_fast") from way back in 2012:
>>
>>            * If FOLL_FORCE and FOLL_NUMA are both set, handle_mm_fault
>>            * would be called on PROT_NONE ranges. We must never invoke
>>            * handle_mm_fault on PROT_NONE ranges or the NUMA hinting
>>            * page faults would unprotect the PROT_NONE ranges if
>>            * _PAGE_NUMA and _PAGE_PROTNONE are sharing the same pte/pmd
>>            * bitflag. So to avoid that, don't set FOLL_NUMA if
>>            * FOLL_FORCE is set.
> 
> 
> In handle_mm_fault(), we never call do_numa_page() if
> !vma_is_accessible(). Same for do_huge_pmd_numa_page().
> 
> So, if we would ever end up triggering a page fault on
> mprotect(PROT_NONE) ranges (i.e., via FOLL_FORCE), we
> would simply do nothing.
> 
> At least that's the hope, I'll take a closer look just to make
> sure we're good on all call paths.
> 
>>
>> but I don't think the original reason for this is *true* any more.
>>
>> Because then two years later in 2014, in commit c46a7c817e66 ("x86:
>> define _PAGE_NUMA by reusing software bits on the PMD and PTE levels")
>> Mel made the code able to distinguish between PROT_NONE and NUMA
>> pages, and he changed the comment above too.
> 
> CCing Mel.
> 
> I remember that pte_protnone() can only distinguished between
> NUMA vs. actual mprotect(PROT_NONE) by looking at the VMA -- vma_is_accessible().
> 
> Indeed, include/linux/pgtable.h:
> 
> /*
>    * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
>    * the only case the kernel cares is for NUMA balancing and is only ever set
>    * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
>    * _PAGE_PROTNONE so by default, implement the helper as "always no". It
>    * is the responsibility of the caller to distinguish between PROT_NONE
>    * protections and NUMA hinting fault protections.
>    */
> 
>>
>> But I get the very very strong feeling that instead of changing the
>> comment, he should have actually removed the comment and the code.
>>
>> So I get the strong feeling that all these FOLL_NUMA games should just
>> go away. You removed the FOLL_NUMA bit, but you replaced it with using
>> FOLL_FORCE.
>>
>> So rather than make this all even more opaque and make it even harder
>> to figure out why we have that code in the first place, I think it
>> should all just be removed.
> 
> At least to me, spelling FOLL_FORCE in follow_page() now out is much
> less opaque then getting that implied by lack of FOLL_NUMA.
> 
>>
>> The original reason for FOLL_NUMA simply does not exist any more. We
>> know exactly when a page is marked for NUMA faulting, and we should
>> simply *ignore* it for GUP and follow_page().
>>
>> I think we should treat a NUMA-faulting page as just being present
>> (and not NUMA-fault it).
>>
>> Am I missing something?
> 
> There was the case for "FOLL_PIN represents application behavior and
> should trigger NUMA faults", but I guess that can be ignored.


Re-reading commit 0b9d705297b2 ("mm: numa: Support NUMA hinting page 
faults from gup/gup_fast"), it actually does spell out an important case 
that we should handle:

"KVM secondary MMU page faults will trigger the NUMA hinting page
  faults through gup_fast -> get_user_pages -> follow_page ->
  handle_mm_fault."

That is still the case today (and important). Not triggering NUMA 
hinting faults would degrade KVM.

Hmm. So three alternatives I see:

1) Use FOLL_FORCE in follow_page() to unconditionally disable protnone
    checks. Alternatively, have an internal FOLL_NO_PROTNONE flag if we
    don't like that.

2) Revert the commit and reintroduce unconditional FOLL_NUMA without
    FOLL_FORCE.

3) Have a FOLL_NUMA that callers like KVM can pass.

Thoughts?

-- 
Cheers,

David / dhildenb

