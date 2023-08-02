Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6376D22E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjHBPhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjHBPga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A52690
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690990485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n78bnGVsAoOJqkX1uLwNexotfEvlRn3c46tZUzNtPkg=;
        b=TFXtdhtxpB9vIlIBsDaOkxRrpLXMvXI/7OqU/98CI9rvpLAnkJ6pPOfcYy7atXORvenS9k
        u3dxuMpVSqfBmsTzdhsa1xmtL1ugbAAEI3OFCmr6UXEaJ2+hIu6HS1gnCuhXEVhv8VfhSN
        TwM4JiDoGas+yGo+D/Ax/Qh7x+sJ69o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-LJf3cQv7NuyfSFjy5okvtA-1; Wed, 02 Aug 2023 11:34:39 -0400
X-MC-Unique: LJf3cQv7NuyfSFjy5okvtA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fd2dec82b7so41618765e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 08:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990477; x=1691595277;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n78bnGVsAoOJqkX1uLwNexotfEvlRn3c46tZUzNtPkg=;
        b=V3imqUkGfezxPbtxtyAxiPzJhRL5XSDKh93t6P7bdifuAJ99QM2sRKHcAYXW8H7pbU
         9RtUk/4dhfuiJdNK/jfpjLJRAaoD9xQodtpi+CdxMwiTL1lEbnInYnZWBFfciQUXvUhj
         n7GYe1/tQnLtecn7RrI9vEFtjrFuhPV0mDV97YzzQy/2iJqZ2zB4swBLBBsBpITnnd9p
         1oE6N9rgisVs21jEzXGdAFog8v5Quk5+K/uxwZZLGfMvP37FCO+eqwPP1WCMxWgyw/UX
         f6+WbWfg3dIARSLrCii5C7CgWeV+viAdQbeLuqcgLOo6wkeWesgw7K5M/NAVD5RA8NQw
         RyUQ==
X-Gm-Message-State: ABy/qLY51i983oZarEPUjmsMSPR29IVaxsrSi1Nq4I8ucCgNCojENJTj
        hZz89Uh1LSMLq+3BcOWKHsQy69m8NeieJ0OiYdozpCEp37TYjE0L2v9V9Dd7q3Ln+Zq/kli8CDL
        vEJx4sAjy1L4zyFsj03/sbHNyKw==
X-Received: by 2002:a05:600c:22d8:b0:3fd:2e6b:10c8 with SMTP id 24-20020a05600c22d800b003fd2e6b10c8mr4768528wmg.23.1690990476923;
        Wed, 02 Aug 2023 08:34:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE7TrYd8KCPetPnWu6tIAydNWrryFMnACSUqOeeUTUc0h+AEVnhFN8Sv7HlT/gIPrHNuELzhg==
X-Received: by 2002:a05:600c:22d8:b0:3fd:2e6b:10c8 with SMTP id 24-20020a05600c22d800b003fd2e6b10c8mr4768509wmg.23.1690990476508;
        Wed, 02 Aug 2023 08:34:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:e00:b8a4:8613:1529:1caf? (p200300cbc70b0e00b8a4861315291caf.dip0.t-ipconnect.de. [2003:cb:c70b:e00:b8a4:8613:1529:1caf])
        by smtp.gmail.com with ESMTPSA id z1-20020adfd0c1000000b0031424f4ef1dsm19468614wrh.19.2023.08.02.08.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:34:36 -0700 (PDT)
Message-ID: <36dc6356-78b6-5cc5-0a1a-ef01bbce15f9@redhat.com>
Date:   Wed, 2 Aug 2023 17:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/8] smaps: use vm_normal_page_pmd() instead of
 follow_trans_huge_pmd()
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-3-david@redhat.com>
 <20230802151613.3nyg3xof3gyovlxu@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230802151613.3nyg3xof3gyovlxu@techsingularity.net>
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

On 02.08.23 17:16, Mel Gorman wrote:
> On Tue, Aug 01, 2023 at 02:48:38PM +0200, David Hildenbrand wrote:
>> We shouldn't be using a GUP-internal helper if it can be avoided.
>>
>> Similar to smaps_pte_entry() that uses vm_normal_page(), let's use
>> vm_normal_page_pmd() that similarly refuses to return the huge zeropage.
>>
>> In contrast to follow_trans_huge_pmd(), vm_normal_page_pmd():
>>
>> (1) Will always return the head page, not a tail page of a THP.
>>
>>   If we'd ever call smaps_account with a tail page while setting "compound
>>   = true", we could be in trouble, because smaps_account() would look at
>>   the memmap of unrelated pages.
>>
>>   If we're unlucky, that memmap does not exist at all. Before we removed
>>   PG_doublemap, we could have triggered something similar as in
>>   commit 24d7275ce279 ("fs/proc: task_mmu.c: don't read mapcount for
>>   migration entry").
>>
>>   This can theoretically happen ever since commit ff9f47f6f00c ("mm: proc:
>>   smaps_rollup: do not stall write attempts on mmap_lock"):
>>
>>    (a) We're in show_smaps_rollup() and processed a VMA
>>    (b) We release the mmap lock in show_smaps_rollup() because it is
>>        contended
>>    (c) We merged that VMA with another VMA
>>    (d) We collapsed a THP in that merged VMA at that position
>>
>>   If the end address of the original VMA falls into the middle of a THP
>>   area, we would call smap_gather_stats() with a start address that falls
>>   into a PMD-mapped THP. It's probably very rare to trigger when not
>>   really forced.
>>
>> (2) Will succeed on a is_pci_p2pdma_page(), like vm_normal_page()
>>
>>   Treat such PMDs here just like smaps_pte_entry() would treat such PTEs.
>>   If such pages would be anonymous, we most certainly would want to
>>   account them.
>>
>> (3) Will skip over pmd_devmap(), like vm_normal_page() for pte_devmap()
>>
>>   As noted in vm_normal_page(), that is only for handling legacy ZONE_DEVICE
>>   pages. So just like smaps_pte_entry(), we'll now also ignore such PMD
>>   entries.
>>
>>   Especially, follow_pmd_mask() never ends up calling
>>   follow_trans_huge_pmd() on pmd_devmap(). Instead it calls
>>   follow_devmap_pmd() -- which will fail if neither FOLL_GET nor FOLL_PIN
>>   is set.
>>
>>   So skipping pmd_devmap() pages seems to be the right thing to do.
>>
>> (4) Will properly handle VM_MIXEDMAP/VM_PFNMAP, like vm_normal_page()
>>
>>   We won't be returning a memmap that should be ignored by core-mm, or
>>   worse, a memmap that does not even exist. Note that while
>>   walk_page_range() will skip VM_PFNMAP mappings, walk_page_vma() won't.
>>
>>   Most probably this case doesn't currently really happen on the PMD level,
>>   otherwise we'd already be able to trigger kernel crashes when reading
>>   smaps / smaps_rollup.
>>
>> So most probably only (1) is relevant in practice as of now, but could only
>> cause trouble in extreme corner cases.
>>
>> Fixes: ff9f47f6f00c ("mm: proc: smaps_rollup: do not stall write attempts on mmap_lock")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Maybe move the follow_trans_huge_pmd() declaration from linux/huge_mm.h
> to mm/internal.h to discourage future mistakes? Otherwise
> 

Makes sense.

> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks!

-- 
Cheers,

David / dhildenb

