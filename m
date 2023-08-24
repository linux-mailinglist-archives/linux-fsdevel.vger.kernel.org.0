Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED5786D63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbjHXLHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbjHXLHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B371C10F3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692875193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LACO+pxS/EgbHrGHIC/ThA2X+uoq4Ub0kxpTjPb83QU=;
        b=CkHXNq1LgI8QPfRfMe0RlPENKzTW4UNVsg3sC4zwEDAUDLfBRL7jehYKF9pSE2Fn/cC99I
        oUUGABewyN1SxiXlheXmUJHhowTBmjVe4BGTcRAjwOFXBauIJnI6MjGHuHEu6zQ886pAWb
        hFKp7EOe9ns4BAf8rD/pnskYOerv3u8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-aMiKvUDAM726rdkl0cmdJQ-1; Thu, 24 Aug 2023 07:06:31 -0400
X-MC-Unique: aMiKvUDAM726rdkl0cmdJQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4011f56165eso3994905e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 04:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875190; x=1693479990;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LACO+pxS/EgbHrGHIC/ThA2X+uoq4Ub0kxpTjPb83QU=;
        b=DAgVMUA8VJvA+cflmLRQ2ID7aEdjUu12bramjxUU2n/awJMP+vQ7Z/VmwoHE5J16EH
         dBxMMPQzPoGvjQUS1ub0H2EwFO/egwhQAv14CLdSi8Sc1JGW+i/1oSYzBnanEEEY/nee
         SUfL/RCzI8sY2biHUKplx4bY1j9nMgdN9M5C9z60ua0KKqoQBKNRjPo2eoNX10Xs5KXu
         knxWCC/B1PI7X6XvclU/UHP+CCgzuWLCvyq+ii3KkWQfMAV637Dl1M2gMPcWnPDA9b11
         ZDe62ya6bsqnxLZ4X2zt+UHR4VfTEtWkUsuPkXukh5l2y7Vfs4eC8KJfJL/tNZmj+Ws1
         gC9g==
X-Gm-Message-State: AOJu0Yy0Hf/Tm4GnbD18+0/92T2XTB4E4Abpk7OGdKbzvLfF/Zc0ZvSx
        vrTdEHCDGkZGrmreKIliEiYCyrgsykzX362y2wRWqJXa1VsPhtVEa251ADrhpH+fn5o3AGInsol
        wdzlLuxxJMKEYHJkPGdF1SE+g+A==
X-Received: by 2002:a05:600c:54c1:b0:3fe:2677:ebe with SMTP id iw1-20020a05600c54c100b003fe26770ebemr11983875wmb.10.1692875190447;
        Thu, 24 Aug 2023 04:06:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcQ3sOOLGLPRMSDQbLxHyakemM3TRf3B8ljeDEy5F0Shgz9egn2Mcm6/k5AlQLeALLIU2ptw==
X-Received: by 2002:a05:600c:54c1:b0:3fe:2677:ebe with SMTP id iw1-20020a05600c54c100b003fe26770ebemr11983832wmb.10.1692875189864;
        Thu, 24 Aug 2023 04:06:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a? (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de. [2003:cb:c709:6200:16ba:af70:999d:6a1a])
        by smtp.gmail.com with ESMTPSA id z13-20020a05600c220d00b003fefb94ccc9sm2318864wml.11.2023.08.24.04.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 04:06:29 -0700 (PDT)
Message-ID: <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
Date:   Thu, 24 Aug 2023 13:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
In-Reply-To: <ZOc0fehF02MohuWr@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24.08.23 12:44, Catalin Marinas wrote:
> On Thu, Aug 24, 2023 at 09:50:32AM +0200, David Hildenbrand wrote:
>> after re-reading it 2 times, I still have no clue what your patch set is
>> actually trying to achieve. Probably there is a way to describe how user
>> space intents to interact with this feature, so to see which value this
>> actually has for user space -- and if we are using the right APIs and
>> allocators.
> 
> I'll try with an alternative summary, hopefully it becomes clearer (I
> think Alex is away until the end of the week, may not reply
> immediately). If this still doesn't work, maybe we should try a
> different implementation ;).
> 
> The way MTE is implemented currently is to have a static carve-out of
> the DRAM to store the allocation tags (a.k.a. memory colour). This is
> what we call the tag storage. Each 16 bytes have 4 bits of tags, so this
> means 1/32 of the DRAM, roughly 3% used for the tag storage. This is
> done transparently by the hardware/interconnect (with firmware setup)
> and normally hidden from the OS. So a checked memory access to location
> X generates a tag fetch from location Y in the carve-out and this tag is
> compared with the bits 59:56 in the pointer. The correspondence from X
> to Y is linear (subject to a minimum block size to deal with some
> address interleaving). The software doesn't need to know about this
> correspondence as we have specific instructions like STG/LDG to location
> X that lead to a tag store/load to Y.
> 
> Now, not all memory used by applications is tagged (mmap(PROT_MTE)).
> For example, some large allocations may not use PROT_MTE at all or only
> for the first and last page since initialising the tags takes time. The
> side-effect is that of these 3% DRAM, only part, say 1% is effectively
> used. Some people want the unused tag storage to be released for normal
> data usage (i.e. give it to the kernel page allocator).
> 
> So the first complication is that a PROT_MTE page allocation at address
> X will need to reserve the tag storage at location Y (and migrate any
> data in that page if it is in use).
> 
> To make things worse, pages in the tag storage/carve-out range cannot
> use PROT_MTE themselves on current hardware, so this adds the second
> complication - a heterogeneous memory layout. The kernel needs to know
> where to allocate a PROT_MTE page from or migrate a current page if it
> becomes PROT_MTE (mprotect()) and the range it is in does not support
> tagging.
> 
> Some other complications are arm64-specific like cache coherency between
> tags and data accesses. There is a draft architecture spec which will be
> released soon, detailing how the hardware behaves.
> 
> To your question about user APIs/ABIs, that's entirely transparent. As
> with the current kernel (without this dynamic tag storage), a user only
> needs to ask for PROT_MTE mappings to get tagged pages.

Thanks, that clarifies things a lot.

So it sounds like you might want to provide that tag memory using CMA.

That way, only movable allocations can end up on that CMA memory area, 
and you can allocate selected tag pages on demand (similar to the 
alloc_contig_range() use case).

That also solves the issue that such tag memory must not be longterm-pinned.

Regarding one complication: "The kernel needs to know where to allocate 
a PROT_MTE page from or migrate a current page if it becomes PROT_MTE 
(mprotect()) and the range it is in does not support tagging.", 
simplified handling would be if it's in a MIGRATE_CMA pageblock, it 
doesn't support tagging. You have to migrate to a !CMA page (for 
example, not specifying GFP_MOVABLE as a quick way to achieve that).

(I have no idea how tag/tagged memory interacts with memory hotplug, I 
assume it just doesn't work)

> 
>> So some dummy questions / statements
>>
>> 1) Is this about re-propusing the memory used to hold tags for different
>> purpose?
> 
> Yes. To allow part of this 3% to be used for data. It could even be the
> whole 3% if no application is enabling MTE.
> 
>> Or what exactly is user space going to do with the PROT_MTE memory?
>> The whole mprotect(PROT_MTE) approach might not eb the right thing to do.
> 
> As I mentioned above, there's no difference to the user ABI. PROT_MTE
> works as before with the kernel moving pages around as needed.
> 
>> 2) Why do we even have to involve the page allocator if this is some
>> special-purpose memory? Re-porpusing the buddy when later using
>> alloc_contig_range() either way feels wrong.
> 
> The aim here is to rebrand this special-purpose memory as a nearly
> general-purpose one (bar the PROT_MTE restriction).
> 
>> The core-mm changes don't look particularly appealing :)
> 
> OTOH, it's a fun project to learn about the mm ;).
> 
> Our aim for now is to get some feedback from the mm community on whether
> this special -> nearly general rebranding is acceptable together with
> the introduction of a heterogeneous memory concept for the general
> purpose page allocator.
> 
> There are some alternatives we looked at with a smaller mm impact but we
> haven't prototyped them yet: (a) use the available tag storage as a
> frontswap accelerator or (b) use it as a (compressed) ramdisk that can

Frontswap is no more :)

> be mounted as swap. The latter has the advantage of showing up in the
> available total memory, keeps customers happy ;). Both options would
> need some mm hooks when a PROT_MTE page gets allocated to release the
> corresponding page in the tag storage range.

Yes, some way of MM integration would be required. If CMA could get the 
job done, you might get most of what you need already.

-- 
Cheers,

David / dhildenb

