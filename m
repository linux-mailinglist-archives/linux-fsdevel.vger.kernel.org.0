Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF6780E16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377759AbjHROgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377571AbjHROgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383D72D4A
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692369350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8Xyd7C4haXDCFCCJ82ZpXcIirbDRYbvnPlINe/0qeA=;
        b=JfJQ4DvJDMiboy5AQyBmQSFucRd8TGp1rD2fQWI55SNOjJMRUY/uvuQiE7oKa9i1Jg+0VQ
        Q3z/sNE38tlAkcu5yOyo/yUUmFP+e2DuZga0p8CDW2b5XK5RJdb6Vipse2yTwJhLVlzQiM
        WI4wp8HGjjG6+aAFUfuVLzEaajFBF+A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-j4GAdSLHNqWFbwHBGXOGJg-1; Fri, 18 Aug 2023 10:35:49 -0400
X-MC-Unique: j4GAdSLHNqWFbwHBGXOGJg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so7061045e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 07:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369348; x=1692974148;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Xyd7C4haXDCFCCJ82ZpXcIirbDRYbvnPlINe/0qeA=;
        b=LOq45fzpyd0F4WqOvnCBEt18LrjBDf5TDjwnEwQeoR38T8uw43G1rRP+u2gvB+jPqe
         EhTKLWKnhz0hKqq/4kXCs6K9LBC+lSrimYxZ7E5D2dJ5Ff1RgeDRqvfbjKW/yxdSWatT
         zhurOCS7ua/PxpczNBBqvZt5oFZMC4eY+3uAy5UCDmfld3f4/W8rTjxOse+ltbMRUxIZ
         RJd0skNlsOuU8dx4u648j0TVXQfIYzGykia0h8DWjmRdm86oHPIPL3XU2HRy/Fpb0IWY
         tmlv4DdtqfWptlPUp2ej91/bQhHgqwlzdizWEF2mJyGboPCY8ELquG5gfO/rquawqC+V
         vdhQ==
X-Gm-Message-State: AOJu0Yyb4rcCm9DxcB527pyVBsCJzD8LO3abDDNQ+KhagklmGUKzUgHi
        YAummN/N3WfdyIRfHs4qYpM300/byodDFfYY/JRiDfWf1ilr2oVvPnQwOMgiO3Iw7EVBUzQBGMB
        zQdNCoCeGtXS55mpPToH37ALZOQ==
X-Received: by 2002:a7b:cc13:0:b0:3fb:abd0:2b52 with SMTP id f19-20020a7bcc13000000b003fbabd02b52mr2322487wmh.13.1692369348130;
        Fri, 18 Aug 2023 07:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIHiBR/gYcfdq3hvKsYvo9XCnq0GuAu/JJnk9XxpFltL1dwHdEKx3/QYqZY/ZPy8Ry94efDA==
X-Received: by 2002:a7b:cc13:0:b0:3fb:abd0:2b52 with SMTP id f19-20020a7bcc13000000b003fbabd02b52mr2322464wmh.13.1692369347635;
        Fri, 18 Aug 2023 07:35:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c726:ff00:a22a:6d42:439d:de2? (p200300cbc726ff00a22a6d42439d0de2.dip0.t-ipconnect.de. [2003:cb:c726:ff00:a22a:6d42:439d:de2])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c379100b003fe26244858sm1493187wmr.46.2023.08.18.07.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 07:35:47 -0700 (PDT)
Message-ID: <886b6a56-8acb-e975-b5f3-d8098a2285ab@redhat.com>
Date:   Fri, 18 Aug 2023 16:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] proc/ksm: add ksm stats to /proc/pid/smaps
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230817162301.3472457-1-shr@devkernel.io>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230817162301.3472457-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.08.23 18:23, Stefan Roesch wrote:
> With madvise and prctl KSM can be enabled for different VMA's. Once it
> is enabled we can query how effective KSM is overall. However we cannot
> easily query if an individual VMA benefits from KSM.
> 
> This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
> how many of the pages are KSM pages. The returned value for KSM is
> independent of the use of the shared zeropage.
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
>   Documentation/filesystems/proc.rst | 4 ++++
>   fs/proc/task_mmu.c                 | 5 +++++
>   2 files changed, 9 insertions(+)
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
> +
>   "LazyFree" shows the amount of memory which is marked by madvise(MADV_FREE).
>   The memory isn't freed immediately with madvise(). It's freed in memory
>   pressure if the memory is clean. Please note that the printed value might
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 51315133cdc2..f591c750ffda 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -396,6 +396,7 @@ struct mem_size_stats {
>   	unsigned long swap;
>   	unsigned long shared_hugetlb;
>   	unsigned long private_hugetlb;
> +	unsigned long ksm;
>   	u64 pss;
>   	u64 pss_anon;
>   	u64 pss_file;
> @@ -452,6 +453,9 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>   			mss->lazyfree += size;
>   	}
>   
> +	if (PageKsm(page))
> +		mss->ksm += size;
> +

Did you accidentally not include handling of the KSM-shared zeropage?

Or did I misinterpret "independent of the use of the shared zeropage."

-- 
Cheers,

David / dhildenb

