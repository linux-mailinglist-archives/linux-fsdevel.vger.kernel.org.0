Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B5A7868EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 09:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbjHXHvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 03:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbjHXHvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C351705
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692863439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VEiwM/469XoxPkv00kiY2u9t4qVyJoCjGxKGq/80WA=;
        b=g/MsZAgx31Lwy9vN5vwrriSIDcxkjIPS/nKgylY7QLX09VX+0XDN1fDWmKD22WqUOJMzpI
        CIbcS3tx0qGi7qJJiC86f9vFNszy8nAzhfWzzrWZzVoqNaKq637J7tGcXngDzVZ1BKH08N
        HQsLfTqkdppH+YNt/x3ng2W9bqi96k4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-h5Z81blOPo6f4URB-_nqQA-1; Thu, 24 Aug 2023 03:50:37 -0400
X-MC-Unique: h5Z81blOPo6f4URB-_nqQA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4ff92d9f376so6858782e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 00:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692863436; x=1693468236;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VEiwM/469XoxPkv00kiY2u9t4qVyJoCjGxKGq/80WA=;
        b=MoE1iwaLzCNGSof33CkeUBvbp+duTBA2Kf9/18R5gkkshvGW6XOtAgui8iV1nmxne2
         Y0CYJlSASBVk3KDXSPsCXWMQLhvsg6s4aao4dUZTbe+kPrubTjPG2RSkHiNkgZctHt2n
         R+c0zI3OOVWmFa67f3AyPQ+M83AyDQJyKcDuoEclTUSzgURZfFvAqBeR+sxX2ThYSI03
         jJER13p3l+nctLxsUt/n3fTjTkPZscJ9UR6jyxivl4BJMVupWhWXGPNJFTydL1xJ5zQ/
         AFJTJ8wxtFCjyAwN2+PZjNA1KVtAoA3FD6aa7j2DZeAQiK+Ym4K8HbRYeWCRigd8cnYY
         G+yg==
X-Gm-Message-State: AOJu0YxMVVHqvtUsZJxz7Yuw/2xsRB2bl8Xew0/p/I3yt6aewm77o/km
        ybqr9OZraCGvrtWWZOJHVflqrdALxwUvhWziqj/pM1aql/ucBepm4/wGo6fa5cV0keBQl/sh9ka
        uuJg33GlPV4q5zAimfu+4bjGT5w==
X-Received: by 2002:a05:6512:1296:b0:4fe:993:2218 with SMTP id u22-20020a056512129600b004fe09932218mr13520769lfs.31.1692863435814;
        Thu, 24 Aug 2023 00:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWxb3vEOPi9oDLO474PCk5smXiK4t0flJpP1QfkBeZvkQd0769Sd7lavC4bQKKWkbdbP5Q0A==
X-Received: by 2002:a05:6512:1296:b0:4fe:993:2218 with SMTP id u22-20020a056512129600b004fe09932218mr13520754lfs.31.1692863435397;
        Thu, 24 Aug 2023 00:50:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:6200:16ba:af70:999d:6a1a? (p200300cbc709620016baaf70999d6a1a.dip0.t-ipconnect.de. [2003:cb:c709:6200:16ba:af70:999d:6a1a])
        by smtp.gmail.com with ESMTPSA id w7-20020adfcd07000000b00313de682eb3sm21614062wrm.65.2023.08.24.00.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 00:50:34 -0700 (PDT)
Message-ID: <33def4fe-fdb8-6388-1151-fabd2adc8220@redhat.com>
Date:   Thu, 24 Aug 2023 09:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
In-Reply-To: <20230823131350.114942-1-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.08.23 15:13, Alexandru Elisei wrote:
> Introduction
> ============
> 
> Arm has implemented memory coloring in hardware, and the feature is called
> Memory Tagging Extensions (MTE). It works by embedding a 4 bit tag in bits
> 59..56 of a pointer, and storing this tag to a reserved memory location.
> When the pointer is dereferenced, the hardware compares the tag embedded in
> the pointer (logical tag) with the tag stored in memory (allocation tag).
> 
> The relation between memory and where the tag for that memory is stored is
> static.
> 
> The memory where the tags are stored have been so far unaccessible to Linux.
> This series aims to change that, by adding support for using the tag storage
> memory only as data memory; tag storage memory cannot be itself tagged.
> 
> 
> Implementation
> ==============
> 
> The series is based on v6.5-rc3 with these two patches cherry picked:
> 
> - mm: Call arch_swap_restore() from unuse_pte():
> 
>      https://lore.kernel.org/all/20230523004312.1807357-3-pcc@google.com/
> 
> - arm64: mte: Simplify swap tag restoration logic:
> 
>      https://lore.kernel.org/all/20230523004312.1807357-4-pcc@google.com/
> 
> The above two patches are queued for the v6.6 merge window:
> 
>      https://lore.kernel.org/all/20230702123821.04e64ea2c04dd0fdc947bda3@linux-foundation.org/
> 
> The entire series, including the above patches, can be cloned with:
> 
> $ git clone https://gitlab.arm.com/linux-arm/linux-ae.git \
> 	-b arm-mte-dynamic-carveout-rfc-v1
> 
> On the arm64 architecture side, an extension is being worked on that will
> clarify how MTE tag storage reuse should behave. The extension will be
> made public soon.
> 
> On the Linux side, MTE tag storage reuse is accomplished with the
> following changes:
> 
> 1. The tag storage memory is exposed to the memory allocator as a new
> migratetype, MIGRATE_METADATA. It behaves similarly to MIGRATE_CMA, with
> the restriction that it cannot be used to allocate tagged memory (tag
> storage memory cannot be tagged). On tagged page allocation, the
> corresponding tag storage is reserved via alloc_contig_range().
> 
> 2. mprotect(PROT_MTE) is implemented by changing the pte prot to
> PAGE_METADATA_NONE. When the page is next accessed, a fault is taken and
> the corresponding tag storage is reserved.
> 
> 3. When the code tries to copy tags to a page which doesn't have the tag
> storage reserved, the tags are copied to an xarray and restored in
> set_pte_at(), when the page is eventually mapped with the tag storage
> reserved.

Hi!

after re-reading it 2 times, I still have no clue what your patch set is 
actually trying to achieve. Probably there is a way to describe how user 
space intents to interact with this feature, so to see which value this 
actually has for user space -- and if we are using the right APIs and 
allocators.

So some dummy questions / statements

1) Is this about re-propusing the memory used to hold tags for different 
purpose? Or what exactly is user space going to do with the PROT_MTE 
memory? The whole mprotect(PROT_MTE) approach might not eb the right 
thing to do.

2) Why do we even have to involve the page allocator if this is some 
special-purpose memory? Re-porpusing the buddy when later using 
alloc_contig_range() either way feels wrong.


[...]

>   arch/arm64/Kconfig                       |  13 +
>   arch/arm64/include/asm/assembler.h       |  10 +
>   arch/arm64/include/asm/memory_metadata.h |  49 ++
>   arch/arm64/include/asm/mte-def.h         |  16 +-
>   arch/arm64/include/asm/mte.h             |  40 +-
>   arch/arm64/include/asm/mte_tag_storage.h |  36 ++
>   arch/arm64/include/asm/page.h            |   5 +-
>   arch/arm64/include/asm/pgtable-prot.h    |   2 +
>   arch/arm64/include/asm/pgtable.h         |  33 +-
>   arch/arm64/kernel/Makefile               |   1 +
>   arch/arm64/kernel/elfcore.c              |  14 +-
>   arch/arm64/kernel/hibernate.c            |  46 +-
>   arch/arm64/kernel/mte.c                  |  31 +-
>   arch/arm64/kernel/mte_tag_storage.c      | 667 +++++++++++++++++++++++
>   arch/arm64/kernel/setup.c                |   7 +
>   arch/arm64/kvm/arm.c                     |   6 +-
>   arch/arm64/lib/mte.S                     |  30 +-
>   arch/arm64/mm/copypage.c                 |  26 +
>   arch/arm64/mm/fault.c                    |  35 +-
>   arch/arm64/mm/mteswap.c                  | 113 +++-
>   fs/proc/meminfo.c                        |   8 +
>   fs/proc/page.c                           |   1 +
>   include/asm-generic/Kbuild               |   1 +
>   include/asm-generic/memory_metadata.h    |  50 ++
>   include/linux/gfp.h                      |  10 +
>   include/linux/gfp_types.h                |  14 +-
>   include/linux/huge_mm.h                  |   6 +
>   include/linux/kernel-page-flags.h        |   1 +
>   include/linux/migrate_mode.h             |   1 +
>   include/linux/mm.h                       |  12 +-
>   include/linux/mmzone.h                   |  26 +-
>   include/linux/page-flags.h               |   1 +
>   include/linux/pgtable.h                  |  19 +
>   include/linux/sched.h                    |   2 +-
>   include/linux/sched/mm.h                 |  13 +
>   include/linux/vm_event_item.h            |   5 +
>   include/linux/vmstat.h                   |   2 +
>   include/trace/events/mmflags.h           |   5 +-
>   mm/Kconfig                               |   5 +
>   mm/compaction.c                          |  52 +-
>   mm/huge_memory.c                         | 109 ++++
>   mm/internal.h                            |   7 +
>   mm/khugepaged.c                          |   7 +
>   mm/memory.c                              | 180 +++++-
>   mm/mempolicy.c                           |   7 +
>   mm/migrate.c                             |   6 +
>   mm/mm_init.c                             |  23 +-
>   mm/mprotect.c                            |  46 ++
>   mm/page_alloc.c                          | 136 ++++-
>   mm/page_isolation.c                      |  19 +-
>   mm/page_owner.c                          |   3 +-
>   mm/shmem.c                               |  14 +-
>   mm/show_mem.c                            |   4 +
>   mm/swapfile.c                            |   4 +
>   mm/vmscan.c                              |   3 +
>   mm/vmstat.c                              |  13 +-
>   56 files changed, 1834 insertions(+), 161 deletions(-)
>   create mode 100644 arch/arm64/include/asm/memory_metadata.h
>   create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
>   create mode 100644 arch/arm64/kernel/mte_tag_storage.c
>   create mode 100644 include/asm-generic/memory_metadata.h

The core-mm changes don't look particularly appealing :)

-- 
Cheers,

David / dhildenb

