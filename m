Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3CA3C884B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhGNQE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44013 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239855AbhGNQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626278524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDdwf1XmUeNAele69YuflW7I8JQTNLYYUbHmho8CJjk=;
        b=DKrs4HEqOo975A+FhE5W4ahJ9PHRlgEUOkoVh54op3k3wg4B5RayVVM4xEDfdE2QPbnrhZ
        5ujDZ4HnBpeneXBaOGJONOJBNbCS+WEYOXpDhIy/wmughrXGI695YJlZkYOdSlK1vi7P9b
        vKN0U230QchlyvQaLIEBoRmVaxWSn3Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-2EKKgoD8PteuDKMel4RT_g-1; Wed, 14 Jul 2021 12:02:03 -0400
X-MC-Unique: 2EKKgoD8PteuDKMel4RT_g-1
Received: by mail-qt1-f199.google.com with SMTP id t6-20020ac80dc60000b029024e988e8277so2143175qti.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 09:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iDdwf1XmUeNAele69YuflW7I8JQTNLYYUbHmho8CJjk=;
        b=PK1bNqbNRAWRj/xgGtXW4gXZNW669IuVHhLEblHMLrxXjT9UeSMpOmFCT/rolZjoFA
         rS+VaGmpHM+3zNKcNzxUVc5Mt4VDRGFztGEMGo5RSDVF6yqEdyJrzA2Ls0LFJOSU6Rp8
         FbmayxUtaCTNVZY9J8gGGmBl1Xvz2HHOOrMnQENRA15aadowdvQljdQpv9YaqeOrnyCl
         oXMNNc1pGrdJ1ipRVZoEbA/9wBLDXqv6n31VCePxZ+jz5aHoezoRBXMWA97shK0xyS85
         oSMhpRhoGZMCzltfketOQU9FcbxZ/AiyCi9ltMBKFQRfUmhPFVgA+WuMsH1sK/j0t4kw
         1cJw==
X-Gm-Message-State: AOAM530EosXQVx8Cuq9T+oO3imUuF0O7QqNVIIbtPzr/I9Eg63G2C0F3
        DKvT9+5PQC/1oC68LaFuxLE3nHrSvow4szEf3BtEFQu+/b3lFSqFJpw9FWulM0/gKPDUf8xhTyr
        U1sz246NpGC5QNXkZFlfmLIslOA==
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr9872832qtw.141.1626278519914;
        Wed, 14 Jul 2021 09:01:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmBx7ehtHLFv1+6C/w89oUyoBrHdc2FU7lSB7HgqiXueL1nKb1EkEmByVFXTV9sw1ZSVVFYA==
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr9872799qtw.141.1626278519654;
        Wed, 14 Jul 2021 09:01:59 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id y4sm1227470qkc.27.2021.07.14.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:01:58 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:01:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH 0/1] pagemap: report swap location for shared pages
Message-ID: <YO8KdQYp4tNhci6o@t490s>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 03:24:25PM +0000, Tiberiu Georgescu wrote:
> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
> entry is cleared. In many cases, there is no difference between swapped-out
> shared pages and newly allocated, non-dirty pages in the pagemap interface.
> 
> Example pagemap-test code (Tested on Kernel Version 5.14-rc1):
> 
> 	#define NPAGES (256)
> 	/* map 1MiB shared memory */
> 	size_t pagesize = getpagesize();
> 	char *p = mmap(NULL, pagesize * NPAGES, PROT_READ | PROT_WRITE,
> 			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> 	/* Dirty new pages. */
> 	for (i = 0; i < PAGES; i++)
> 		p[i * pagesize] = i;
> 
> Run the above program in a small cgroup, which allows swapping:
> 
> 	/* Initialise cgroup & run a program */
> 	$ echo 512K > foo/memory.limit_in_bytes
> 	$ echo 60 > foo/memory.swappiness
> 	$ cgexec -g memory:foo ./pagemap-test
> 
> Check the pagemap report. This is an example of the current expected output:
> 
> 	$ dd if=/proc/$PID/pagemap ibs=8 skip=$(($VADDR / $PAGESIZE)) count=$COUNT | hexdump -C
> 	00000000  00 00 00 00 00 00 80 00  00 00 00 00 00 00 80 00  |................|
> 	*
> 	00000710  e1 6b 06 00 00 00 80 a1  9e eb 06 00 00 00 80 a1  |.k..............|
> 	00000720  6b ee 06 00 00 00 80 a1  a5 a4 05 00 00 00 80 a1  |k...............|
> 	00000730  5c bf 06 00 00 00 80 a1  90 b6 06 00 00 00 80 a1  |\...............|
> 
> The first pagemap entries are reported as zeroes, indicating the pages have
> never been allocated while they have actually been swapped out. It is
> possible for bit 55 (PTE is Soft-Dirty) to be set on all pages of the
> shared VMA, indicating some access to the page, but nothing else (frame
> location, presence in swap or otherwise).
> 
> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
> make use of the XArray associated with the virtual memory area struct
> passed as an argument. The XArray contains the location of virtual pages in
> the page cache, swap cache or on disk. If they are on either of the caches,
> then the original implementation still works. If not, then the missing
> information will be retrieved from the XArray.
> 
> The root cause of the missing functionality is that the PTE for the page
> itself is cleared when a swap out occurs on a shared page.  Please take a
> look at the proposed patch. I would appreciate it if you could verify a
> couple of points:
> 
> 1. Why do swappable and non-syncable shared pages have their PTEs cleared
>    when they are swapped out ? Why does the behaviour differ so much
>    between MAP_SHARED and MAP_PRIVATE pages? What are the origins of the
>    approach?

My understanding is linux mm treat this differently for file-backed memories,
MAP_SHARED is one of this kind.  For these memories, ptes can be dropped at any
time because it can be reloaded from page cache when faulted again.

Anonymous private memories cannot do that, so anonymous private memories keep
all things within ptes, including swap entry.

> 
> 2. PM_SOFT_DIRTY and PM_UFFD_WP are two flags that seem to get lost once
>    the shared page is swapped out. Is there any other way to retrieve
>    their value in the proposed patch, other than ensuring these flags are
>    set, when necessary, in the PTE?

uffd-wp has no problem on dropping them because uffd-wp does not yet support
shmem.  Shmem support is posted upstream but still during review:

https://lore.kernel.org/lkml/20210527201927.29586-1-peterx@redhat.com/

After that work they'll persist, then we won't have an issue using uffd-wp with
shmem swapping; the pagemap part is done in patch 25 of 27:

https://lore.kernel.org/lkml/20210527202340.32306-1-peterx@redhat.com/

However I agree soft-dirty seems to be still broken with it.

(Cc Hugh and Andrea too)

Thanks,

-- 
Peter Xu

