Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886D765BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjG0TSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjG0TSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9C52D73
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690485470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M6fNNlhfLLjy6Ffe5VEja4cq8lrssWOW4WwBPHdA3f4=;
        b=dobhaGqRXEWYdD0ZcTijndX7IWIim3j+AULa7r6qdoAjLMSO534O5fXFDYHDK4+bo12Gt5
        6toQm1kfPcx3ZjKu5knR0A2Qlc9hCh5HGp9Q3BjmCZZIQbtr3zAiBYAkBCwTYEPFZ+xIDu
        bgTqDz3COYflY4p786K8fvY1d/8Q038=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-YYusujpcOvC4JMIMmKUNww-1; Thu, 27 Jul 2023 15:17:48 -0400
X-MC-Unique: YYusujpcOvC4JMIMmKUNww-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3143ac4a562so678683f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485467; x=1691090267;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M6fNNlhfLLjy6Ffe5VEja4cq8lrssWOW4WwBPHdA3f4=;
        b=AQrdZ/a6LCtD/IZTdTwB7TnAJkjGMZw0q8as3Fjki3bfoJbAGgLeVvJRbz9QRBD+Do
         6A/cu5MPaRm5U3PYJfV5XZGiC2JwTY7TtzJ4A1i0p2o/ETpBMR/AXb57fnPiSCzBqUaw
         lOaSZFMosElcCwDGi9k1tjosnft3e+36p1sy4gMEuW/Z4iM64yyGUIuIdJ6M+n+LhUdJ
         4J0ZBAod4Wp4zR4To/5+vwWT3Dpy6hDOOGCXgSAwW6D/wsxzRlkjxvIK7nOwbCs52RVz
         LGT+LUsl6xRMhtzApQJgoGppOMW/dyGbjzhDasQEBt2hiIUEbEWHng5cdJRFZyaQ92wu
         S2cA==
X-Gm-Message-State: ABy/qLbl4kJ9qJUdafIYKNHO3Ge+cVb0BFJC885bT5a4/vnQuj9dWy6i
        zUFu/JW/aPHekzOJa4sU0lVL2FsB/0CfjpUmKHMGQXh55jhC1veZ8q7oKT8DnYjAk7xIIolHBfq
        wGvq2SCwB+2uYeoB+mNCexBYX+A==
X-Received: by 2002:adf:f502:0:b0:316:f25c:d0c0 with SMTP id q2-20020adff502000000b00316f25cd0c0mr98053wro.16.1690485467575;
        Thu, 27 Jul 2023 12:17:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGjaaCzclHToJETbNW6SrclFfMO44Qjruq5h6Xi98EUIJDqJFds0hNI7NFgUwj4flCCQQz0tA==
X-Received: by 2002:adf:f502:0:b0:316:f25c:d0c0 with SMTP id q2-20020adff502000000b00316f25cd0c0mr98042wro.16.1690485467134;
        Thu, 27 Jul 2023 12:17:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a? (p200300d82f434700d2cd2b81d4e68b2a.dip0.t-ipconnect.de. [2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d5151000000b0030fa3567541sm2828536wrt.48.2023.07.27.12.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 12:17:46 -0700 (PDT)
Message-ID: <30e58727-0a6a-4461-e9b1-f64d6eea026c@redhat.com>
Date:   Thu, 27 Jul 2023 21:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
 <ZMJt+VWzIG4GAjeb@x1n> <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
 <ZMKJjDaqZ7FW0jfe@x1n> <5a2c9ae4-50f5-3301-3b50-f57026e1f8e8@redhat.com>
 <ZMK+jSDgOmJKySTr@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
In-Reply-To: <ZMK+jSDgOmJKySTr@x1n>
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

On 27.07.23 20:59, Peter Xu wrote:
> On Thu, Jul 27, 2023 at 07:27:02PM +0200, David Hildenbrand wrote:
>>>>
>>>> This was wrong from the very start. If we're not in GUP, we shouldn't call
>>>> GUP functions.
>>>
>>> My understanding is !GET && !PIN is also called gup.. otherwise we don't
>>> need GET and it can just be always implied.
>>
>> That's not the point. The point is that _arbitrary_ code shouldn't call into
>> GUP internal helper functions, where they bypass, for example, any sanity
>> checks.
> 
> What's the sanity checks that you're referring to?
> 

For example in follow_page()

if (vma_is_secretmem(vma))
	return NULL;

if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
	return NULL;


Maybe you can elaborate why you think we should *not* be using 
vm_normal_page_pmd() and instead some arbitrary GUP internal helper? I 
don't get it.

>>
>>>
>>> The other proof is try_grab_page() doesn't fail hard on !GET && !PIN.  So I
>>> don't know whether that's "wrong" to be used..
>>>
>>
>> To me, that is arbitrary code using a GUP internal helper and, therefore,
>> wrong.
>>
>>> Back to the topic: I'd say either of the patches look good to solve the
>>> problem.  If p2pdma pages are mapped as PFNMAP/MIXEDMAP (?), I guess
>>> vm_normal_page_pmd() proposed here will also work on it, so nothing I see
>>> wrong on 2nd one yet.
>>>
>>> It looks nicer indeed to not have FOLL_FORCE here, but it also makes me
>>> just wonder whether we should document NUMA behavior for FOLL_* somewhere,
>>> because we have an implication right now on !FOLL_FORCE over NUMA, which is
>>> not obvious to me..
>>
>> Yes, we probably should. For get_use_pages() and friends that behavior was
>> always like that and it makes sense: usually it represent application
>> behavior.
>>
>>>
>>> And to look more over that aspect, see follow_page(): previously we can
>>> follow a page for protnone (as it never applies FOLL_NUMA) but now it won't
>>> (it never applies FOLL_FORCE, either, so it seems "accidentally" implies
>>> FOLL_NUMA now).  Not sure whether it's intended, though..
>>
>> That was certainly an oversight, thanks for spotting that. That patch was
>> not supposed to change semantics:
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 76d222ccc3ff..ac926e19ff72 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -851,6 +851,13 @@ struct page *follow_page(struct vm_area_struct *vma,
>> unsigned long address,
>>          if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
>>                  return NULL;
>>
>> +       /*
>> +        * In contrast to get_user_pages() and friends, we don't want to
>> +        * fail if the PTE is PROT_NONE: see gup_can_follow_protnone().
>> +        */
>> +       if (!(foll_flags & FOLL_WRITE))
>> +               foll_flags |= FOLL_FORCE;
>> +
>>          page = follow_page_mask(vma, address, foll_flags, &ctx);
>>          if (ctx.pgmap)
>>                  put_dev_pagemap(ctx.pgmap);
> 
> This seems to be slightly against your other solution though for smaps,
> where we want to avoid abusing FOLL_FORCE.. isn't it..

This is GUP internal, not some arbitrary code, so to me a *completely* 
different discussion.

> 
> Why read only?  That'll always attach FOLL_FORCE to all follow page call
> sites indeed for now, but just curious - logically "I want to fetch the
> page even if protnone" is orthogonal to do with write permission here to
> me.

Historical these were not the semantics, so I won't change them.

FOLL_FORCE | FOLL_WRITE always had a special taste to it (COW ...).

> 
> I still worry about further abuse of FOLL_FORCE, I believe you also worry
> that so you proposed the other way for the smaps issue.
> 
> Do you think we can just revive FOLL_NUMA?  That'll be very clear to me
> from that aspect that we do still have valid use cases for it.

FOLL_NUMA naming was nowadays wrong to begin with (not to mention, 
confusing a we learned). There are other reasons why we have PROT_NONE 
-- mprotect(), for example.

We could have a flag that goes the other way around: 
FOLL_IGNORE_PROTNONE ... which surprisingly then ends up being exactly 
what FOLL_FORCE means without FOLL_WRITE, and what this patch does.

Does that make sense to you?


> 
> The very least is if with above we should really document FOLL_FORCE - we
> should mention NUMA effects.  But that's ... really confusing. Thinking
> about that I personally prefer a revival of FOLL_NUMA, then smaps issue all
> go away.

smaps needs to be changed in any case IMHO. And I'm absolutely not in 
favor of revicing FOLL_NUMA.

-- 
Cheers,

David / dhildenb

