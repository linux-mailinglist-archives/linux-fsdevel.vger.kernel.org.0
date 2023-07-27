Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35421765A29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 19:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjG0R1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjG0R1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EF02D71
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690478827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwb5DpfJA543/ymBOV9D0j7LfkCqnFRKOW5fcvoaQRM=;
        b=UH/wvXz8RbnYPSXQ9iyKvInOSlCPV6bwMvH6ZGICQNmHzniCvLddKDfP6Nh8VWTqI48irB
        z6StyfCLCMdrJ6BmhdXRlbNrgqW/ba6mfa9wurPdU7HaMbysMyW0c/Pte58/VeljfSkLqj
        d0KJWt/EtpQjcuihzd3tTmwRyxMB9j8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-o0WHdgurPkSpitMRnN_dOg-1; Thu, 27 Jul 2023 13:27:05 -0400
X-MC-Unique: o0WHdgurPkSpitMRnN_dOg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa96b67ac1so6555985e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 10:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478824; x=1691083624;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwb5DpfJA543/ymBOV9D0j7LfkCqnFRKOW5fcvoaQRM=;
        b=ZsnsegO2QzfGXqq/DSAd8unft9XzOJeGK0o0hduKvh2WfaClHmv9dmn0zQhtbYT9X8
         2QOynLU4BzSsn2mcRDHqKqbFDwKcfF/cg4FlTntVQDOVDIvpvWLnkOY6zIKKTu2KT3sY
         kmdFYkLx9nSdMsNE1etumHEPzOU7llqAn51sRFhD0GR3fHl7JJUDasiN0A2f75vV1nVX
         raSMFcy9wvsTwCySTkyWe9FPffAtDcCneMCDjcnrSgNAvwfrj1FkxeaQk7ksHAVXpPCO
         4rSIPq3IiRtRpZbPzsYLITPo47dMLtYEfazyNKS2wR3t2eqks+6Q4lekEcAPM6oaVL7J
         yCjw==
X-Gm-Message-State: ABy/qLaKkJ2xzavu/sj1RG51eMt2kSUQs0lfbPoE/T+RYPhjgC3SGMB5
        5s/YShfLwT1sgYj3s7FqVMmT3mGoPmCO/TDiqpGzYoe9gfPy2XeHyM9q46SCjCK4BML+QpPmnRA
        +3I+qglbw5Qiv9yuQ1AT42sfMDw==
X-Received: by 2002:a05:600c:2110:b0:3fc:f9c:a3ed with SMTP id u16-20020a05600c211000b003fc0f9ca3edmr2408145wml.22.1690478824448;
        Thu, 27 Jul 2023 10:27:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEmOUf9Goj4S9RMowaOqUuIyTwRTX4cSCg0PW+wqLAO9C1ekxHrXPG+nYrhyzC1Dacyo1Q6eg==
X-Received: by 2002:a05:600c:2110:b0:3fc:f9c:a3ed with SMTP id u16-20020a05600c211000b003fc0f9ca3edmr2408128wml.22.1690478824018;
        Thu, 27 Jul 2023 10:27:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a? (p200300d82f434700d2cd2b81d4e68b2a.dip0.t-ipconnect.de. [2003:d8:2f43:4700:d2cd:2b81:d4e6:8b2a])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c0b4f00b003fbaade0735sm5239334wmr.19.2023.07.27.10.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:27:03 -0700 (PDT)
Message-ID: <5a2c9ae4-50f5-3301-3b50-f57026e1f8e8@redhat.com>
Date:   Thu, 27 Jul 2023 19:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Peter Xu <peterx@redhat.com>
Cc:     liubo <liubo254@huawei.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com, willy@infradead.org
References: <20230726073409.631838-1-liubo254@huawei.com>
 <CADFyXm5nkgZjVMj3iJhqQnyA1AOmqZ-AKdaWyUD=UvZsOEOcPg@mail.gmail.com>
 <ZMJt+VWzIG4GAjeb@x1n> <f49c2a51-4dd8-784b-57fa-34fb397db2b7@redhat.com>
 <ZMKJjDaqZ7FW0jfe@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] smaps: Fix the abnormal memory statistics obtained
 through /proc/pid/smaps
In-Reply-To: <ZMKJjDaqZ7FW0jfe@x1n>
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

>>
>> This was wrong from the very start. If we're not in GUP, we shouldn't call
>> GUP functions.
> 
> My understanding is !GET && !PIN is also called gup.. otherwise we don't
> need GET and it can just be always implied.

That's not the point. The point is that _arbitrary_ code shouldn't call 
into GUP internal helper functions, where they bypass, for example, any 
sanity checks.

> 
> The other proof is try_grab_page() doesn't fail hard on !GET && !PIN.  So I
> don't know whether that's "wrong" to be used..
> 

To me, that is arbitrary code using a GUP internal helper and, 
therefore, wrong.

> Back to the topic: I'd say either of the patches look good to solve the
> problem.  If p2pdma pages are mapped as PFNMAP/MIXEDMAP (?), I guess
> vm_normal_page_pmd() proposed here will also work on it, so nothing I see
> wrong on 2nd one yet.
> 
> It looks nicer indeed to not have FOLL_FORCE here, but it also makes me
> just wonder whether we should document NUMA behavior for FOLL_* somewhere,
> because we have an implication right now on !FOLL_FORCE over NUMA, which is
> not obvious to me..

Yes, we probably should. For get_use_pages() and friends that behavior 
was always like that and it makes sense: usually it represent 
application behavior.

> 
> And to look more over that aspect, see follow_page(): previously we can
> follow a page for protnone (as it never applies FOLL_NUMA) but now it won't
> (it never applies FOLL_FORCE, either, so it seems "accidentally" implies
> FOLL_NUMA now).  Not sure whether it's intended, though..

That was certainly an oversight, thanks for spotting that. That patch 
was not supposed to change semantics:

diff --git a/mm/gup.c b/mm/gup.c
index 76d222ccc3ff..ac926e19ff72 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -851,6 +851,13 @@ struct page *follow_page(struct vm_area_struct 
*vma, unsigned long address,
         if (WARN_ON_ONCE(foll_flags & FOLL_PIN))
                 return NULL;

+       /*
+        * In contrast to get_user_pages() and friends, we don't want to
+        * fail if the PTE is PROT_NONE: see gup_can_follow_protnone().
+        */
+       if (!(foll_flags & FOLL_WRITE))
+               foll_flags |= FOLL_FORCE;
+
         page = follow_page_mask(vma, address, foll_flags, &ctx);
         if (ctx.pgmap)
                 put_dev_pagemap(ctx.pgmap);


-- 
Cheers,

David / dhildenb

