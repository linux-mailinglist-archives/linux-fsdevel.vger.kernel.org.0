Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB54B786DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbjHXL0q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjHXL0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAD810FC
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692876346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pf8km5Wwirj+Pp5xkmndF+gQtFmnTLNzQCBzwGFpVXg=;
        b=gi7+Zs1UUG7jluEeIMMs+Rr+gAC6N0mIMTlqCZ6eB10TLgoHy3qr+ootiH8TnlAKu7DSWK
        RTAQdD/XCK2bS4Wmcj6yFXrgITP/VBxl/8mJsHQiG5jXwl9ue+UbQTcI0RFoW4w56d/fTo
        4N03mZKsiWZ8mEcoKlY1kLmPIjMeDxQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-8vxIobTpPAe8kfeK6Rx4cg-1; Thu, 24 Aug 2023 07:25:45 -0400
X-MC-Unique: 8vxIobTpPAe8kfeK6Rx4cg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c6c275c83so1210439f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 04:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876344; x=1693481144;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pf8km5Wwirj+Pp5xkmndF+gQtFmnTLNzQCBzwGFpVXg=;
        b=JcV3KD/KwC/WLtuM30ff+xAJ3xSGMa7iewPhU7l9gHA4Yzhfptu630xJpU0Ahbhm6s
         FaTQren+zZ+zDgGFHbAv5xd84PQknRGY7OoV68SZuuu+1sgputRymDa/9bcq9dNbiyv3
         Ms8LbdfQUwgckyctmDo7+7JAtLXa08GEosM4BnP4X3EUtb5W+/xyseO6jqpH/P+Yhkqt
         nat3jqH1nuRxtb6MVdKVKf3hi/pzKiOi+ZiHJCcwspD0dppW/M5f6pPny8LHAiwG5LIu
         t8kCxqwwCkJ7E7kdTwLfOBxGpq3uc1J0Suil36NhAx3URXM8Nb8AWwTNpAPoD9QeMaJC
         UgMA==
X-Gm-Message-State: AOJu0Yz9QC4/P9T1K4CWtJ+CiXHkbwZUH0KZkequZHMgcLPPS+fFUg3/
        /9wSD27BYYzJ8lpQfNoO2hx+HLcW+KozotDpfcjthR/5v/KH0blU8HhCkQb9811BCSRH/opWwIM
        piJGhpVBG+gk0n5W2d6zpMD1ypQ==
X-Received: by 2002:adf:f291:0:b0:319:8333:9052 with SMTP id k17-20020adff291000000b0031983339052mr12256620wro.26.1692876343999;
        Thu, 24 Aug 2023 04:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjgoZLvCXmRzs+SoRsWPKHZfVBXeQL7A57Cia6xx3CKAJ6M8J1WZ44nBdXmrWG3mqys2wyvg==
X-Received: by 2002:adf:f291:0:b0:319:8333:9052 with SMTP id k17-20020adff291000000b0031983339052mr12256571wro.26.1692876343532;
        Thu, 24 Aug 2023 04:25:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a? (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de. [2003:cb:c709:6200:16ba:af70:999d:6a1a])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0031773a8e5c4sm21950229wrm.37.2023.08.24.04.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 04:25:43 -0700 (PDT)
Message-ID: <0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com>
Date:   Thu, 24 Aug 2023 13:25:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
        akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
        pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com> <ZOc0fehF02MohuWr@arm.com>
 <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
In-Reply-To: <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.08.23 13:06, David Hildenbrand wrote:
> On 24.08.23 12:44, Catalin Marinas wrote:
>> On Thu, Aug 24, 2023 at 09:50:32AM +0200, David Hildenbrand wrote:
>>> after re-reading it 2 times, I still have no clue what your patch set is
>>> actually trying to achieve. Probably there is a way to describe how user
>>> space intents to interact with this feature, so to see which value this
>>> actually has for user space -- and if we are using the right APIs and
>>> allocators.
>>
>> I'll try with an alternative summary, hopefully it becomes clearer (I
>> think Alex is away until the end of the week, may not reply
>> immediately). If this still doesn't work, maybe we should try a
>> different implementation ;).
>>
>> The way MTE is implemented currently is to have a static carve-out of
>> the DRAM to store the allocation tags (a.k.a. memory colour). This is
>> what we call the tag storage. Each 16 bytes have 4 bits of tags, so this
>> means 1/32 of the DRAM, roughly 3% used for the tag storage. This is
>> done transparently by the hardware/interconnect (with firmware setup)
>> and normally hidden from the OS. So a checked memory access to location
>> X generates a tag fetch from location Y in the carve-out and this tag is
>> compared with the bits 59:56 in the pointer. The correspondence from X
>> to Y is linear (subject to a minimum block size to deal with some
>> address interleaving). The software doesn't need to know about this
>> correspondence as we have specific instructions like STG/LDG to location
>> X that lead to a tag store/load to Y.
>>
>> Now, not all memory used by applications is tagged (mmap(PROT_MTE)).
>> For example, some large allocations may not use PROT_MTE at all or only
>> for the first and last page since initialising the tags takes time. The
>> side-effect is that of these 3% DRAM, only part, say 1% is effectively
>> used. Some people want the unused tag storage to be released for normal
>> data usage (i.e. give it to the kernel page allocator).
>>
>> So the first complication is that a PROT_MTE page allocation at address
>> X will need to reserve the tag storage at location Y (and migrate any
>> data in that page if it is in use).
>>
>> To make things worse, pages in the tag storage/carve-out range cannot
>> use PROT_MTE themselves on current hardware, so this adds the second
>> complication - a heterogeneous memory layout. The kernel needs to know
>> where to allocate a PROT_MTE page from or migrate a current page if it
>> becomes PROT_MTE (mprotect()) and the range it is in does not support
>> tagging.
>>
>> Some other complications are arm64-specific like cache coherency between
>> tags and data accesses. There is a draft architecture spec which will be
>> released soon, detailing how the hardware behaves.
>>
>> To your question about user APIs/ABIs, that's entirely transparent. As
>> with the current kernel (without this dynamic tag storage), a user only
>> needs to ask for PROT_MTE mappings to get tagged pages.
> 
> Thanks, that clarifies things a lot.
> 
> So it sounds like you might want to provide that tag memory using CMA.
> 
> That way, only movable allocations can end up on that CMA memory area,
> and you can allocate selected tag pages on demand (similar to the
> alloc_contig_range() use case).
> 
> That also solves the issue that such tag memory must not be longterm-pinned.
> 
> Regarding one complication: "The kernel needs to know where to allocate
> a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> (mprotect()) and the range it is in does not support tagging.",
> simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> doesn't support tagging. You have to migrate to a !CMA page (for
> example, not specifying GFP_MOVABLE as a quick way to achieve that).
> 

Okay, I now realize that this patch set effectively duplicates some CMA 
behavior using a new migrate-type. Yeah, that's probably not what we 
want just to identify if memory is taggable or not.

Maybe there is a way to just keep reusing most of CMA instead.


Another simpler idea to get started would be to just intercept the first 
PROT_MTE, and allocate all CMA memory. In that case, systems that don't 
ever use PROT_MTE can have that additional 3% of memory.

You probably know better how frequent it is that only a handful of 
applications use PROT_MTE, such that there is still a significant 
portion of tag memory to be reused (and if it's really worth optimizing 
for that scenario).

-- 
Cheers,

David / dhildenb

