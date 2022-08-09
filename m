Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D958D771
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 12:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241874AbiHIKc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbiHIKc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB7E2316F
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Aug 2022 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660041175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4/nlumMUczp73apm8CZRUgaBYhutP5eXhEt6NxdNHlY=;
        b=UDcH3CYKs+HnRVSRWKI966witE4avQ3MZGCtI/bS09GCptm+cw1NhiFOfNTRRBvq85rlCg
        xrLhiwq+MKi79O1v7PrW/F2b5fNIBm3fFYGlhAf09kusrkTSwBs1jQAudY8LEB92HT9SK2
        RZoB8Ch/7SguuKr64xGqFXDCyv6smvA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-a9TGymPoNqKxyhoA1Q7guQ-1; Tue, 09 Aug 2022 06:32:54 -0400
X-MC-Unique: a9TGymPoNqKxyhoA1Q7guQ-1
Received: by mail-ed1-f71.google.com with SMTP id z3-20020a056402274300b0043d4da3b4b5so7000465edd.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Aug 2022 03:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4/nlumMUczp73apm8CZRUgaBYhutP5eXhEt6NxdNHlY=;
        b=0Kv2e313URv0dsTE68o+FfjxHSu1NeaJgEJw3TDHO1iyHwMRE+0WKKyJTDoDFWeIZJ
         WqhGda6h7i6zzsfWuNO4Pv/nVUOnJMJCnsHTvWcd+kMYn/rywNBkqrcegNexn9G5jzHu
         09K4i1bPuzMt9nH6anY1xWdEL9nFEOqNAVTx6nUnlLQqzLyB+eqJAcmCNcXuLV2NiA3U
         gBr7fUDzLwTdXOfoio/X+eu7RXJ1iUmn17DloROpTeAp6XHhLkvNSG1iiI3945z00BLj
         9bLJM8N8eJpRueIuadPphWGwP7bNmEkPu8WefyDBb1nPPC3DUh+2xZnMnY1Vozo56nII
         9+LA==
X-Gm-Message-State: ACgBeo20X7tTyG6BJlexiwmv3e3YsGM1l7eCPcMCHYWEGqt40se1AuPM
        WvBSxudVxdoC+NAAiom+aTnKMAnim4NcUrMJoNaI5qKvsj+NbJErLWwIoG5NTBojvEJWm7DgNX6
        rBR/j67npZwxFJ/Aju/JnbojDNg==
X-Received: by 2002:a05:6402:278c:b0:43d:cd35:db25 with SMTP id b12-20020a056402278c00b0043dcd35db25mr21160260ede.44.1660041172533;
        Tue, 09 Aug 2022 03:32:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7kHfqy2K3ZZ0VU1/IEtq20+vgUMc90FDejB9zNFwNsrjyA2JfUM7Qy1rx71dvSPaxNUXUPVA==
X-Received: by 2002:a05:6402:278c:b0:43d:cd35:db25 with SMTP id b12-20020a056402278c00b0043dcd35db25mr21160248ede.44.1660041172290;
        Tue, 09 Aug 2022 03:32:52 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b0043a554818afsm5801531eds.42.2022.08.09.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:32:51 -0700 (PDT)
Date:   Tue, 9 Aug 2022 06:32:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
Message-ID: <20220809063111-mutt-send-email-mst@kernel.org>
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
 <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 09, 2022 at 12:49:32PM +0300, Alexander Atanasov wrote:
> Display reported in /proc/meminfo as:
> 
> Inflated(total) or Inflated(free)
> 
> depending on the driver.
> 
> Drivers use the sign bit to indicate where they do account
> the inflated memory.
> 
> Amount of inflated memory can be used by:
>  - as a hint for the oom a killer
>  - user space software that monitors memory pressure
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Nadav Amit <namit@vmware.com>
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  Documentation/filesystems/proc.rst |  5 +++++
>  fs/proc/meminfo.c                  | 11 +++++++++++
>  include/linux/mm.h                 |  4 ++++
>  mm/page_alloc.c                    |  4 ++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321..064b5b3d5bd8 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -986,6 +986,7 @@ Example output. You may not have all of these fields.
>      VmallocUsed:       40444 kB
>      VmallocChunk:          0 kB
>      Percpu:            29312 kB
> +    Inflated(total):  2097152 kB
>      HardwareCorrupted:     0 kB
>      AnonHugePages:   4149248 kB
>      ShmemHugePages:        0 kB
> @@ -1133,6 +1134,10 @@ VmallocChunk
>  Percpu
>                Memory allocated to the percpu allocator used to back percpu
>                allocations. This stat excludes the cost of metadata.
> +Inflated(total) or Inflated(free)
> +               Amount of memory that is inflated by the balloon driver.
> +               Due to differences among balloon drivers inflated memory
> +               is either subtracted from TotalRam or from MemFree.
>  HardwareCorrupted
>                The amount of RAM/memory in KB, the kernel identifies as
>                corrupted.
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6e89f0e2fd20..ebbe52ccbb93 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -38,6 +38,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	unsigned long pages[NR_LRU_LISTS];
>  	unsigned long sreclaimable, sunreclaim;
>  	int lru;
> +#ifdef CONFIG_MEMORY_BALLOON
> +	long inflated_kb;
> +#endif
>  
>  	si_meminfo(&i);
>  	si_swapinfo(&i);
> @@ -153,6 +156,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  		    global_zone_page_state(NR_FREE_CMA_PAGES));
>  #endif
>  
> +#ifdef CONFIG_MEMORY_BALLOON
> +	inflated_kb = atomic_long_read(&mem_balloon_inflated_kb);
> +	if (inflated_kb >= 0)
> +		seq_printf(m,  "Inflated(total): %8ld kB\n", inflated_kb);
> +	else
> +		seq_printf(m,  "Inflated(free): %8ld kB\n", -inflated_kb);
> +#endif
> +
>  	hugetlb_report_meminfo(m);
>  
>  	arch_report_meminfo(m);


This seems too baroque for my taste.
Why not just have two counters for the two pruposes?
And is there any value in having this atomic?
We want a consistent value but just READ_ONCE seems sufficient ...


> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7898e29bcfb5..b190811dc16e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2582,6 +2582,10 @@ extern int watermark_boost_factor;
>  extern int watermark_scale_factor;
>  extern bool arch_has_descending_max_zone_pfns(void);
>  
> +#ifdef CONFIG_MEMORY_BALLOON
> +extern atomic_long_t mem_balloon_inflated_kb;
> +#endif
> +
>  /* nommu.c */
>  extern atomic_long_t mmap_pages_allocated;
>  extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b0bcab50f0a3..12359179a3a2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -194,6 +194,10 @@ EXPORT_SYMBOL(init_on_alloc);
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
>  EXPORT_SYMBOL(init_on_free);
>  
> +#ifdef CONFIG_MEMORY_BALLOON
> +atomic_long_t mem_balloon_inflated_kb = ATOMIC_LONG_INIT(0);
> +#endif
> +
>  static bool _init_on_alloc_enabled_early __read_mostly
>  				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
>  static int __init early_init_on_alloc(char *buf)
> -- 
> 2.31.1
> 
> 

