Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87F976736F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjG1Rco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjG1RcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DD3AA9
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690565438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cl36FnvktkYbvD1zJaMZyNiWy19DEs6ZP3kw5lklrZI=;
        b=OXnLYqwZbmIwRRRZs+NeDMXHHAXI1va+uLc3oXMmAWY8QK+/ya61xoyuivGk1Yi6dvuuMQ
        PDZ8/S+EKYub3rnv1lZlrgDUBmx0UNY8Xj2OY/+NWq2VR5exK91EdKDeA2KCYpWKnMlL+Z
        9ZSqDX3ZTtsqe1+BeayUGCJvW+4nXUE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-H2quRNctMOuks0rhaVo4lw-1; Fri, 28 Jul 2023 13:30:37 -0400
X-MC-Unique: H2quRNctMOuks0rhaVo4lw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbcae05906so16242275e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 10:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690565436; x=1691170236;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl36FnvktkYbvD1zJaMZyNiWy19DEs6ZP3kw5lklrZI=;
        b=hgKE5VpPXIDldAGu+iEQCGnNuC3I1NSHXAa3BYrwAPKnAFXAeeI+Z1l4N0bWjxnJgh
         /TehcSetQDBfNtPD04UcWsjDae0CJ0wlEYZh+CZA/PS1hHREyFshOoxD2+0tizDoU4R7
         jzyL8CiPTvDszTU8uWLd/6wHtghcDeJz0jXN9AGn4KMW+pdFggf67/ISX+jfq3RPmSWQ
         9ybFiH8LWfVgjdNVHjIXJUIG5tlEUFKIzYG6A+zbH3p1zYr/zpJx81sRjG11PwCU7Mo4
         qgzfSLS3vib03inSJ+1SglDzynFqmvcTHGRcEHTeqBFgSge0IkCuMLfpQV8h8FDCrDdw
         45Zw==
X-Gm-Message-State: ABy/qLZt9pQnfoBzKgZqQfLLS6t11ZMJcmC9i7gvX0x9tE2PlUQe5LHb
        06JIjvSVNCaKDNIu6Wo8fCYO6SM8vmj8fppkQmKYU3rXzvKdV3D+i7UgcCXxpLHF7vb5KCu1/Gs
        opXl7TN2PAENeE0bHWi9IB9vQ9A==
X-Received: by 2002:a05:600c:20c4:b0:3fb:e643:1225 with SMTP id y4-20020a05600c20c400b003fbe6431225mr2509515wmm.13.1690565436054;
        Fri, 28 Jul 2023 10:30:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGYuCUIu0HPfQ49F3gjLsVAJ43VYP/e6HVfw6FA/RBySDmmJqoUBeIQbEqCC2TFy39iizz9aA==
X-Received: by 2002:a05:600c:20c4:b0:3fb:e643:1225 with SMTP id y4-20020a05600c20c400b003fbe6431225mr2509491wmm.13.1690565435629;
        Fri, 28 Jul 2023 10:30:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bca4a000000b003fbc0a49b57sm4712526wml.6.2023.07.28.10.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:30:35 -0700 (PDT)
Message-ID: <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
Date:   Fri, 28 Jul 2023 19:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
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

On 28.07.23 18:18, Linus Torvalds wrote:
> On Thu, 27 Jul 2023 at 14:28, David Hildenbrand <david@redhat.com> wrote:
>>
>> This is my proposal on how to handle the fallout of 474098edac26
>> ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()") where I
>> accidentially missed that follow_page() and smaps implicitly kept the
>> FOLL_NUMA flag clear by *not* setting it if FOLL_FORCE is absent, to
>> not trigger faults on PROT_NONE-mapped PTEs.
> 
> Ugh.

I was hoping for that reaction, with the assumption that we would get
something cleaner :)

> 
> I hate how it uses FOLL_FORCE that is inherently scary.

I hate FOLL_FORCE, but I hate FOLL_NUMA even more, because to me it
is FOLL_FORCE in disguise (currently and before 474098edac26, if
FOLL_FORCE is set, FOLL_NUMA won't be set and the other way around).

> 
> Why do we have that "gup_can_follow_protnone()" logic AT ALL?

That's what I was hoping for.

> 
> Couldn't we just get rid of that disgusting thing, and just say that
> GUP (and follow_page()) always just ignores NUMA hinting, and always
> just follows protnone?
> 
> We literally used to have this:
> 
>          if (!(gup_flags & FOLL_FORCE))
>                  gup_flags |= FOLL_NUMA;
> 
> ie we *always* set FOLL_NUMA for any sane situation. FOLL_FORCE should
> be the rare crazy case.

Yes, but my point would be that we now spell that "rare crazy case"
out for follow_page().

If you're talking about patch #1, I agree, therefore patch #3 to
avoid all that nasty FOLL_FORCE handling in GUP callers.

But yeah, if we can avoid all that, great.

> 
> The original reason for not setting FOLL_NUMA all the time is
> documented in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting
> page faults from gup/gup_fast") from way back in 2012:
> 
>           * If FOLL_FORCE and FOLL_NUMA are both set, handle_mm_fault
>           * would be called on PROT_NONE ranges. We must never invoke
>           * handle_mm_fault on PROT_NONE ranges or the NUMA hinting
>           * page faults would unprotect the PROT_NONE ranges if
>           * _PAGE_NUMA and _PAGE_PROTNONE are sharing the same pte/pmd
>           * bitflag. So to avoid that, don't set FOLL_NUMA if
>           * FOLL_FORCE is set.


In handle_mm_fault(), we never call do_numa_page() if
!vma_is_accessible(). Same for do_huge_pmd_numa_page().

So, if we would ever end up triggering a page fault on
mprotect(PROT_NONE) ranges (i.e., via FOLL_FORCE), we
would simply do nothing.

At least that's the hope, I'll take a closer look just to make
sure we're good on all call paths.

> 
> but I don't think the original reason for this is *true* any more.
> 
> Because then two years later in 2014, in commit c46a7c817e66 ("x86:
> define _PAGE_NUMA by reusing software bits on the PMD and PTE levels")
> Mel made the code able to distinguish between PROT_NONE and NUMA
> pages, and he changed the comment above too.

CCing Mel.

I remember that pte_protnone() can only distinguished between
NUMA vs. actual mprotect(PROT_NONE) by looking at the VMA -- vma_is_accessible().

Indeed, include/linux/pgtable.h:

/*
  * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
  * the only case the kernel cares is for NUMA balancing and is only ever set
  * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
  * _PAGE_PROTNONE so by default, implement the helper as "always no". It
  * is the responsibility of the caller to distinguish between PROT_NONE
  * protections and NUMA hinting fault protections.
  */

> 
> But I get the very very strong feeling that instead of changing the
> comment, he should have actually removed the comment and the code.
> 
> So I get the strong feeling that all these FOLL_NUMA games should just
> go away. You removed the FOLL_NUMA bit, but you replaced it with using
> FOLL_FORCE.
> 
> So rather than make this all even more opaque and make it even harder
> to figure out why we have that code in the first place, I think it
> should all just be removed.

At least to me, spelling FOLL_FORCE in follow_page() now out is much
less opaque then getting that implied by lack of FOLL_NUMA.

> 
> The original reason for FOLL_NUMA simply does not exist any more. We
> know exactly when a page is marked for NUMA faulting, and we should
> simply *ignore* it for GUP and follow_page().
> 
> I think we should treat a NUMA-faulting page as just being present
> (and not NUMA-fault it).
> 
> Am I missing something?

There was the case for "FOLL_PIN represents application behavior and
should trigger NUMA faults", but I guess that can be ignored.

But it would be much better to just remove all that if we can.

Let me look into some details.

Thanks Linus!

-- 
Cheers,

David / dhildenb

