Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9C767763
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjG1VDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 17:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjG1VDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27198449C
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690578171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wkcm2vsBSrFML/GWUxYGG5U3iYViWt9LTI9JWBRvcyA=;
        b=b3UIJ/i/D4VGzdzFodQTc2ywOJWfvab0l8VAm13HF+WBSegBkRurcEJkTmQMkRStPtVnpm
        +W/8hfxB8ffeja+f3EHROUF+wFSNLiOhO3xrAEuUWINq8bXfesM0l1AKUmoZii8ipOjMcd
        LnJdOK0CwM0li/6lrMpWzvx22EqsfU0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-79ZbLTXsN4i993f3RBdxSQ-1; Fri, 28 Jul 2023 17:02:49 -0400
X-MC-Unique: 79ZbLTXsN4i993f3RBdxSQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe15547164so926825e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 14:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690578168; x=1691182968;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wkcm2vsBSrFML/GWUxYGG5U3iYViWt9LTI9JWBRvcyA=;
        b=QW3NmfP7B9Cgmi/HvyzxtNZUcFUtmsoYbwlondBLqa+kRpKvqqea5JOtWpfLI3njmf
         BNBFgisdjFXd9uPcuc5d6kuyETxHlQ50iNv59Awlld8blwFZCt9LUdyrfF71BKY7DO4Y
         pyeI5CeH6mXALBjaE2Fe4eXb01NoexiGXIHuNVbL4RSOHDP3k514KeJSfrUe+Iopxevv
         lA9qyW9Ve01w5t+2W1nsbkIC/Y1cYLVDMmjkFeTV9M7H+Ot7JDrSm7ehwYIxSBTvDKWw
         gcrxeWJGc9LExNsR+Ju4QvD9SWr2/i+APNBnre8KxCz5osM+5btdpDdzelWrJHtLkmZZ
         JmLQ==
X-Gm-Message-State: ABy/qLYw4ZVjHyCql19dPWh426aTYcrVl7iUNfdEkjCgNIxkkvM3pZFN
        xidsTAHSgn7u+f1xiW877Ip1KvPDv+cwHguQZspKuboi0drfkB5xFmZIGl9kXcqpuNCRuWS+G1c
        adzQy3z0Z6c69oFOOrO2U6tDndg==
X-Received: by 2002:a7b:cc88:0:b0:3fe:10d8:e7ef with SMTP id p8-20020a7bcc88000000b003fe10d8e7efmr2086249wma.19.1690578168575;
        Fri, 28 Jul 2023 14:02:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGDhYAogGggViLK1Uq2Uh1kiDC6aD5EdFYHUetEZH44a98xWY4bpVsN0bm7KKuxmYxzTm9RA==
X-Received: by 2002:a7b:cc88:0:b0:3fe:10d8:e7ef with SMTP id p8-20020a7bcc88000000b003fe10d8e7efmr2086233wma.19.1690578168215;
        Fri, 28 Jul 2023 14:02:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:6b00:bf49:f14b:380d:f871? (p200300cbc7066b00bf49f14b380df871.dip0.t-ipconnect.de. [2003:cb:c706:6b00:bf49:f14b:380d:f871])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c308900b003fe15c466f3sm235178wmn.0.2023.07.28.14.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 14:02:47 -0700 (PDT)
Message-ID: <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com>
Date:   Fri, 28 Jul 2023 23:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
In-Reply-To: <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
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

On 28.07.23 22:50, Linus Torvalds wrote:
> On Fri, 28 Jul 2023 at 13:33, David Hildenbrand <david@redhat.com> wrote:
>>
>> So would you rather favor a FOLL_NUMA that has to be passed from the
>> outside by selected callers or a FOLL_NUMA that is set on the GUP path
>> unconditionally (but left clear for follow_page())?
> 
> I'd rather see the FOLL_NUMA that has to be set by odd cases, and that
> is never set by any sane user.

Thanks!

> 
> And it should not be called FOLL_NUMA. It should be called something
> else. Because *not* having it doesn't disable following pages across
> NUMA boundaries, and the name is actively misleading.
> 
> It sounds like what KVM actually wants is a "Do NOT follow NUMA pages,
> I'll force a page fault".
> 
> And the fact that KVM wants a fault for NUMA pages shouldn't mean that
> others - who clearly cannot care - get that insane behavior by
> default.

For KVM it represents actual CPU access. To map these pages into the VM 
MMU we have to look them up from the process -- in the context of the 
faulting CPU. So it makes a lot of sense for KVM. (which is also where 
autonuma gets heavily used)

> 
> The name should reflect that, instead of being the misleading mess of
> FOLL_FORCE and bad naming that it is now.
> 
> So maybe it can be called "FOLL_HONOR_NUMA_FAULT" or something, to
> make it clear that it's the *opposite* of FOLL_FORCE, and that it
> honors the NUMA faulting that nobody should care about.

Naming sounds much better to me.

> 
> Then the KVM code can have a big comment about *why* it sets that bit.

Yes.

> 
> Hmm? Can we please aim for something that is understandable and
> documented? No odd implicit rules. No "force NUMA fault even when it
> makes no sense". No tie-in with FOLL_FORCE.

I mean, I messed all that FOLL_NUMA handling up because I was very 
confused. So I'm all for better documentation.


Can we get a simple revert in first (without that FOLL_FORCE special 
casing and ideally with a better name) to handle stable backports, and 
I'll follow-up with more documentation and letting GUP callers pass in 
that flag instead?

That would help a lot. Then we also have more time to let that "move it 
to GUP callers" mature a bit in -next, to see if we find any surprises?

-- 
Cheers,

David / dhildenb

