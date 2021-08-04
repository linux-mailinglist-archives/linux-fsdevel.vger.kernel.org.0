Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288723E07A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbhHDSd0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 14:33:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238604AbhHDSd0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628101992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWfQ4ISwjwffNQ7YHGuZ5FJ03xVMdb5Rajli0vTZ9tM=;
        b=hkpKzjCe19k/xYwyzS1MnmDhA2r6Hfzv2g4Pz1XRmoMOsiohIOspormrEf0jgoDm91eG20
        yCHq1pUHOSTwqwKeXciDvHv54ZKx7Fm32G7Qppq1mCb9Aq5y38Zc5gR86KB54ayp21lIpQ
        NKw1x4jmDxr6YzqAN+J5GQNs93JAJ0g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-9M6l__-HO1mNRY_s38zY9A-1; Wed, 04 Aug 2021 14:33:11 -0400
X-MC-Unique: 9M6l__-HO1mNRY_s38zY9A-1
Received: by mail-qt1-f198.google.com with SMTP id o11-20020ac85a4b0000b029028acd99a680so1406126qta.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 11:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWfQ4ISwjwffNQ7YHGuZ5FJ03xVMdb5Rajli0vTZ9tM=;
        b=XYYhWIhSYyuRChj/xUiHVD0ETg/gi/d0xPHNjVQfLyPayujm0sQfwYZ3ZhBG7egGdJ
         iNSEWI1vKT+KOpnTRPmuMravT1u6IAbPdHvBCwxlWwK/z1Bl4wsGWDtHIwKdfN/9d8yu
         3Y0BIHTpFLRz9SQ6ssWfA70sLVvGajBWM3WoCSJl2LcOcc3yiFK2TrYN4TNFvcYicyDq
         kaGwJr05eMf+r9BEpSbqWpRwIt2odwKTVa5hL1VtUVYLV7zZUTOJdcmBDu0/WlGa8NKC
         hyca3QHb11ILvjOOxjtqc1j/mpPjrOhurBXSNSoQGjv8I7re+51eIEKTAeMsw3utUOuo
         jCUw==
X-Gm-Message-State: AOAM530e9zrxFR28QFqU+kWUcRSBcKmZ9hsZGEv4lOaQvvR/8fX0uLrg
        toTMz+HnZGpnVYRAca7Ba1B20Wu4/hYm09QjKhu9+InAMNmL6ZKnSmL1iBg93R86YCB1rqRIanE
        EDhHLH5thrJvBlArmrAGnXy5wuA==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr824987qtw.343.1628101991052;
        Wed, 04 Aug 2021 11:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznD6r9qJJsML71uwOWGJ7AtcsNDE2L3CoWfiJ+z4195j80LyXBqS0JqLw/mvR2d81qYKN2fA==
X-Received: by 2002:a05:622a:142:: with SMTP id v2mr824969qtw.343.1628101990769;
        Wed, 04 Aug 2021 11:33:10 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id v11sm1287314qtc.0.2021.08.04.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 11:33:08 -0700 (PDT)
Date:   Wed, 4 Aug 2021 14:33:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        david@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com, adobriyan@gmail.com,
        songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <YQrdY5zQOVgQJ1BI@t490s>
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Tiberiu,

On Fri, Jul 30, 2021 at 04:08:25PM +0000, Tiberiu A Georgescu wrote:
> This patch follows up on a previous RFC:
> 20210714152426.216217-1-tiberiu.georgescu@nutanix.com
> 
> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
> entry is cleared. In many cases, there is no difference between swapped-out
> shared pages and newly allocated, non-dirty pages in the pagemap interface.
> 
> Example pagemap-test code (Tested on Kernel Version 5.14-rc3):
>     #define NPAGES (256)
>     /* map 1MiB shared memory */
>     size_t pagesize = getpagesize();
>     char *p = mmap(NULL, pagesize * NPAGES, PROT_READ | PROT_WRITE,
>     		   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
>     /* Dirty new pages. */
>     for (i = 0; i < PAGES; i++)
>     	p[i * pagesize] = i;
> 
> Run the above program in a small cgroup, which causes swapping:
>     /* Initialise cgroup & run a program */
>     $ echo 512K > foo/memory.limit_in_bytes
>     $ echo 60 > foo/memory.swappiness
>     $ cgexec -g memory:foo ./pagemap-test
> 
> Check the pagemap report. Example of the current expected output:
>     $ dd if=/proc/$PID/pagemap ibs=8 skip=$(($VADDR / $PAGESIZE)) count=$COUNT | hexdump -C
>     00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>     *
>     00000710  e1 6b 06 00 00 00 00 a1  9e eb 06 00 00 00 00 a1  |.k..............|
>     00000720  6b ee 06 00 00 00 00 a1  a5 a4 05 00 00 00 00 a1  |k...............|
>     00000730  5c bf 06 00 00 00 00 a1  90 b6 06 00 00 00 00 a1  |\...............|
> 
> The first pagemap entries are reported as zeroes, indicating the pages have
> never been allocated while they have actually been swapped out.
> 
> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
> make use of the XArray associated with the virtual memory area struct
> passed as an argument. The XArray contains the location of virtual pages in
> the page cache, swap cache or on disk. If they are in either of the caches,
> then the original implementation still works. If not, then the missing
> information will be retrieved from the XArray.
> 
> Performance
> ============
> I measured the performance of the patch on a single socket Xeon E5-2620
> machine, with 128GiB of RAM and 128GiB of swap storage. These were the
> steps taken:
> 
>   1. Run example pagemap-test code on a cgroup
>     a. Set up cgroup with limit_in_bytes=4GiB and swappiness=60;
>     b. allocate 16GiB (about 4 million pages);
>     c. dirty 0,50 or 100% of pages;
>     d. do this for both private and shared memory.
>   2. Run `dd if=<PAGEMAP> ibs=8 skip=$(($VADDR / $PAGESIZE)) count=4194304`
>      for each possible configuration above
>     a.  3 times for warm up;
>     b. 10 times to measure performance.
>        Use `time` or another performance measuring tool.
> 
> Results (averaged over 10 iterations):
>                +--------+------------+------------+
>                | dirty% |  pre patch | post patch |
>                +--------+------------+------------+
>  private|anon  |     0% |      8.15s |      8.40s |
>                |    50% |     11.83s |     12.19s |
>                |   100% |     12.37s |     12.20s |
>                +--------+------------+------------+
>   shared|anon  |     0% |      8.17s |      8.18s |
>                |    50% | (*) 10.43s |     37.43s |
>                |   100% | (*) 10.20s |     38.59s |
>                +--------+------------+------------+
> 
> (*): reminder that pre-patch produces incorrect pagemap entries for swapped
>      out pages.
> 
> From run to run the above results are stable (mostly <1% stderr).
> 
> The amount of time it takes for a full read of the pagemap depends on the
> granularity used by dd to read the pagemap file. Even though the access is
> sequential, the script only reads 8 bytes at a time, running pagemap_read()
> COUNT times (one time for each page in a 16GiB area).
> 
> To reduce overhead, we can use batching for large amounts of sequential
> access. We can make dd read multiple page entries at a time,
> allowing the kernel to make optimisations and yield more throughput.
> 
> Performance in real time (seconds) of
> `dd if=<PAGEMAP> ibs=8*$BATCH skip=$(($VADDR / $PAGESIZE / $BATCH))
> count=$((4194304 / $BATCH))`:
> +---------------------------------+ +---------------------------------+
> |     Shared, Anon, 50% dirty     | |     Shared, Anon, 100% dirty    |
> +-------+------------+------------+ +-------+------------+------------+
> | Batch |  Pre-patch | Post-patch | | Batch |  Pre-patch | Post-patch |
> +-------+------------+------------+ +-------+------------+------------+
> |     1 | (*) 10.43s |     37.43s | |     1 | (*) 10.20s |     38.59s |
> |     2 | (*)  5.25s |     18.77s | |     2 | (*)  5.15s |     19.37s |
> |     4 | (*)  2.63s |      9.42s | |     4 | (*)  2.63s |      9.74s |
> |     8 | (*)  1.38s |      4.80s | |     8 | (*)  1.35s |      4.94s |
> |    16 | (*)  0.73s |      2.46s | |    16 | (*)  0.72s |      2.54s |
> |    32 | (*)  0.40s |      1.31s | |    32 | (*)  0.41s |      1.34s |
> |    64 | (*)  0.25s |      0.72s | |    64 | (*)  0.24s |      0.74s |
> |   128 | (*)  0.16s |      0.43s | |   128 | (*)  0.16s |      0.44s |
> |   256 | (*)  0.12s |      0.28s | |   256 | (*)  0.12s |      0.29s |
> |   512 | (*)  0.10s |      0.21s | |   512 | (*)  0.10s |      0.22s |
> |  1024 | (*)  0.10s |      0.20s | |  1024 | (*)  0.10s |      0.21s |
> +-------+------------+------------+ +-------+------------+------------+
> 
> To conclude, in order to make the most of the underlying mechanisms of
> pagemap and xarray, one should be using batching to achieve better
> performance.

So what I'm still a bit worried is whether it will regress some existing users.
Note that existing users can try to read pagemap in their own way; we can't
expect all the userspaces to change their behavior due to a kernel change.

Meanwhile, from the numbers, it seems to show a 4x speed down due to looking up
the page cache no matter the size of ibs=.  IOW I don't see a good way to avoid
that overhead, so no way to have the userspace run as fast as before.

Also note that it's not only affecting the PM_SWAP users; it potentially
affects all the /proc/pagemap users as long as there're file-backed memory on
the read region of pagemap, which is very sane to happen.

That's why I think if we want to persist it, we should still consider starting
from the pte marker idea.

I do plan to move the pte marker idea forward unless that'll be NACKed upstream
for some other reason, because that seems to be the only way for uffd-wp to
support file based memories; no matter with a new swp type or with special swap
pte.  I am even thinking about whether I should propose that with PM_SWAP first
because that seems to be a simpler scenario than uffd-wp (which will get the
rest uffd-wp patches involved then), then we can have a shared infrastructure.
But haven't thought deeper than that.

Thanks,

-- 
Peter Xu

