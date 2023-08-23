Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A25D7854F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjHWKKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjHWKKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBACDF
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692785385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BlfYARvXjr1F28IXgFG58ilrQHBrtyu82Jv5Eef7lQY=;
        b=U27pp8cZmZRpXPwFw8La68hgjcz9AifibMdKTiN1axXZzfuuo1aomyKilyF8QIZVjLVauO
        TlOQ8oD3JnmednpYm8xbKPz4uLG0rbuxs0Ght7i56T4Qjeqavxr9wb9pLk3J2xiKY6t8Oo
        Cra1sN9cF1qQlxzBPz2NyTuWUn46QnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-S9OGswnLM7OTEWvpccZQBw-1; Wed, 23 Aug 2023 06:09:43 -0400
X-MC-Unique: S9OGswnLM7OTEWvpccZQBw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe2a5ced6dso35768545e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 03:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692785382; x=1693390182;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlfYARvXjr1F28IXgFG58ilrQHBrtyu82Jv5Eef7lQY=;
        b=cuI3Pd6VijxOfkNoz3PmOVwBqeS0ktk8avq3PUygAsYzc6Pk1cg7N4GrKzt5eHNakG
         AP4LTrCctl7f8GwZ5jM0/+2GbCPPMU/MeG1wJ4zIq5aTwCybcGowrR1YrWp34TpukS1y
         trl2hMxyzLSHHfqJX/JxtY+ha+mSYrEbCbRrbNjLMM0VFGti0Y+88XmWojKrXD8/rfFu
         Li5yHSS06Ao6j9LQYnjtH0mJXNPOCjSpYKD3/QAHMjYYFlztM7wlWxFQvCfBYf6a7bq8
         4RyUfItf6GZC6zjz6PHWcYicnEgsXULAVL3JYN1S7HlbHo6xAuY2C9Pz8xdlrj5v2cKp
         euFg==
X-Gm-Message-State: AOJu0YypHyQPjCaVNp5HklGtxi5aDoG6NLDR/Gc7z5Vv/gBz6DZsGiDH
        MzF7FeETGyQW7tvw/o0MALQ6iNQU9/G8/AyZ8IBEE1fDzBPXflaexkKDBedXt3wsDE26fynjCrE
        td4ZR6FwHYFRAEujaSG9wYCLwUA==
X-Received: by 2002:a7b:cbcd:0:b0:3fe:25b3:951d with SMTP id n13-20020a7bcbcd000000b003fe25b3951dmr9488609wmi.5.1692785382722;
        Wed, 23 Aug 2023 03:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVbMW2VcEi17GbUpyPij27yRRiQBB6A/wFEV7rsIx6tgU2fyPnvx+MB2rA90P60UsZotfSvA==
X-Received: by 2002:a7b:cbcd:0:b0:3fe:25b3:951d with SMTP id n13-20020a7bcbcd000000b003fe25b3951dmr9488589wmi.5.1692785382328;
        Wed, 23 Aug 2023 03:09:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:e700:4d5c:81e2:253e:e397? (p200300cbc70ce7004d5c81e2253ee397.dip0.t-ipconnect.de. [2003:cb:c70c:e700:4d5c:81e2:253e:e397])
        by smtp.gmail.com with ESMTPSA id v21-20020a1cf715000000b003fe29dc0ff2sm18253291wmh.21.2023.08.23.03.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 03:09:41 -0700 (PDT)
Message-ID: <b380a853-4466-d060-1084-dcdd65a5ce13@redhat.com>
Date:   Wed, 23 Aug 2023 12:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230822180539.1424843-1-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4] proc/ksm: add ksm stats to /proc/pid/smaps
In-Reply-To: <20230822180539.1424843-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.08.23 20:05, Stefan Roesch wrote:
> With madvise and prctl KSM can be enabled for different VMA's. Once it
> is enabled we can query how effective KSM is overall. However we cannot
> easily query if an individual VMA benefits from KSM.
> 
> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
> how many of the pages are KSM pages. The returned value for KSM is
> independent of the use of the shared zeropage.

Maybe phrase that to something like "The returned value for KSM includes
KSM-placed zeropages, so we can observe the actual KSM benefit independent
of the usage of the shared zeropage for KSM.".

But thinking about it (see below), maybe we really just let any user figure that out by
temporarily disabling the shared zeropage.

So this would be

"It reports how many of the pages are KSM pages. Note that KSM-placed zeropages
are not included, only actual KSM pages."

> 
> Here is a typical output:
> 
> 7f420a000000-7f421a000000 rw-p 00000000 00:00 0
> Size:             262144 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:               51212 kB
> Pss:                8276 kB
> Shared_Clean:        172 kB
> Shared_Dirty:      42996 kB
> Private_Clean:       196 kB
> Private_Dirty:      7848 kB
> Referenced:        15388 kB
> Anonymous:         51212 kB
> KSM:               41376 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:             202016 kB
> SwapPss:            3882 kB
> Locked:                0 kB
> THPeligible:    0
> ProtectionKey:         0
> ksm_state:          0
> ksm_skip_base:      0
> ksm_skip_count:     0
> VmFlags: rd wr mr mw me nr mg anon
> 
> This information also helps with the following workflow:
> - First enable KSM for all the VMA's of a process with prctl.
> - Then analyze with the above smaps report which VMA's benefit the most
> - Change the application (if possible) to add the corresponding madvise
> calls for the VMA's that benefit the most
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   Documentation/filesystems/proc.rst |  4 ++++
>   fs/proc/task_mmu.c                 | 16 +++++++++++-----
>   2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 7897a7dafcbc..d5bdfd59f5b0 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -461,6 +461,7 @@ Memory Area, or VMA) there is a series of lines such as the following::
>       Private_Dirty:         0 kB
>       Referenced:          892 kB
>       Anonymous:             0 kB
> +    KSM:                   0 kB
>       LazyFree:              0 kB
>       AnonHugePages:         0 kB
>       ShmemPmdMapped:        0 kB
> @@ -501,6 +502,9 @@ accessed.
>   a mapping associated with a file may contain anonymous pages: when MAP_PRIVATE
>   and a page is modified, the file page is replaced by a private anonymous copy.
>   
> +"KSM" shows the amount of anonymous memory that has been de-duplicated. The
> +value is independent of the use of shared zeropage.

Maybe here as well.

> +
>   "LazyFree" shows the amount of memory which is marked by madvise(MADV_FREE).
>   The memory isn't freed immediately with madvise(). It's freed in memory
>   pressure if the memory is clean. Please note that the printed value might
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 51315133cdc2..4532caa8011c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -4,6 +4,7 @@
>   #include <linux/hugetlb.h>
>   #include <linux/huge_mm.h>
>   #include <linux/mount.h>
> +#include <linux/ksm.h>
>   #include <linux/seq_file.h>
>   #include <linux/highmem.h>
>   #include <linux/ptrace.h>
> @@ -396,6 +397,7 @@ struct mem_size_stats {
>   	unsigned long swap;
>   	unsigned long shared_hugetlb;
>   	unsigned long private_hugetlb;
> +	unsigned long ksm;
>   	u64 pss;
>   	u64 pss_anon;
>   	u64 pss_file;
> @@ -435,9 +437,9 @@ static void smaps_page_accumulate(struct mem_size_stats *mss,
>   	}
>   }
>   
> -static void smaps_account(struct mem_size_stats *mss, struct page *page,
> -		bool compound, bool young, bool dirty, bool locked,
> -		bool migration)
> +static void smaps_account(struct mem_size_stats *mss, pte_t *pte,
> +		struct page *page, bool compound, bool young, bool dirty,
> +		bool locked, bool migration)
>   {
>   	int i, nr = compound ? compound_nr(page) : 1;
>   	unsigned long size = nr * PAGE_SIZE;
> @@ -452,6 +454,9 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>   			mss->lazyfree += size;
>   	}
>   
> +	if (PageKsm(page) && (!pte || !is_ksm_zero_pte(*pte)))

I think this won't work either way, because smaps_pte_entry() never ends up calling
this function with !page. And the shared zeropage here always gives us !page.

What would work is:


diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 15ddf4653a19..ef6f39d7c5a2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -528,6 +528,9 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
                 page = vm_normal_page(vma, addr, ptent);
                 young = pte_young(ptent);
                 dirty = pte_dirty(ptent);
+
+               if (!page && is_ksm_zero_pte(ptent))
+                       mss->ksm += size;
         } else if (is_swap_pte(ptent)) {
                 swp_entry_t swpent = pte_to_swp_entry(ptent);
  

That means that "KSM" can be bigger than "Anonymous" and "RSS" when the shared
zeropage is used.

Interestingly, right now we account each KSM page individually towards
"Anonymous" and "RSS".

So if we have 100 times the same KSM page in a VMA, we will have 100 times anon
and 100 times rss.

Thinking about it, I guess considering the KSM-placed zeropage indeed adds more
confusion to that. Eventually, we might just want separate "Shared-zeropages" count.


So maybe v3 is better, clarifying the documentation a bit, that the
KSM-placed zeropage is not considered.

Sorry for changing my mind :D Thoughts?

-- 
Cheers,

David / dhildenb

