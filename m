Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7FC3E0839
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 20:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbhHDStf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 14:49:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238957AbhHDSte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628102961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIS1QzS1z5rPO1vnLNSXVbu6rEfqlxZ6uoU3oa+gFO8=;
        b=SOrWyBcwKkP9NtDN4r2HXZQiIIFzzbC7rx8i9uDvPi5UwCgfwFQsH/CxeEqKvAzFeHoHNG
        TaN9Mx++bP6riRBwcsQ6pJabKaP5xIkcsblVpPBueXBNeAXGnCxfl22Ut4yl4HwRKZWR9K
        XrtgmWCn9VmUXtZi04nC63DnvR7k5cU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-yUlOH97pOQaaELAaUCcC-g-1; Wed, 04 Aug 2021 14:49:18 -0400
X-MC-Unique: yUlOH97pOQaaELAaUCcC-g-1
Received: by mail-wr1-f72.google.com with SMTP id c1-20020a5d4cc10000b02901547bb2ef31so1136817wrt.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Aug 2021 11:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wIS1QzS1z5rPO1vnLNSXVbu6rEfqlxZ6uoU3oa+gFO8=;
        b=CFltStsjIKW9gtUNPBVLkoOencpl3RdiCneCo0FZ6/l/YzxprL/6ihr1M6JgoYhM3M
         z+rfqMC36YkjHbik+SGKNzC3+EYJuhMrG3liWCndJB4UbvC5wQRFyq0pYS2c4jHX5/o5
         C+dhEXlGLaWEKQv21FcjOF+QxmIR4AJxCKsy9199uTgMcwLFlxoe9X8ByNms90y+DMsJ
         +VmzrEZdgJhpWhv9DdrM7xhbOOFWo4HnPYxLnRoZ3f3aQsSLDFrCwDL5CA0i2pHew7Us
         S7FOfGy8R/Wk2bNORcymZgmq+nqLlBfuA7WbDc4Wt5MfNDQkbz6o0cpv5EbBT/Cb03wb
         DsLg==
X-Gm-Message-State: AOAM5337b+9W6vtz7xPK3MSEOdheCLP5xekOYgs1aHHN5KTSYuaEepaC
        2a32f2RCL/tigLHmutrcGlb55ORS06/F8nnesaxHLSn0Ggs+I3Ue3aPLCqReuPqMNkOL1VHq1x+
        alQvRd3ktXAzYRFegz2cRoG7I3w==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr762589wrt.107.1628102956784;
        Wed, 04 Aug 2021 11:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkGRiEHbgAzLaSSeRuv2og1EjDVGvwXPYpq1DOCWx9uW6w35PXJyhdwq9EteK8Oufq1WGU4Q==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr762568wrt.107.1628102956551;
        Wed, 04 Aug 2021 11:49:16 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65d3.dip0.t-ipconnect.de. [91.12.101.211])
        by smtp.gmail.com with ESMTPSA id f194sm6849056wmf.23.2021.08.04.11.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:49:15 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>,
        Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <YQrdY5zQOVgQJ1BI@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
Date:   Wed, 4 Aug 2021 20:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQrdY5zQOVgQJ1BI@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04.08.21 20:33, Peter Xu wrote:
> Hi, Tiberiu,
> 
> On Fri, Jul 30, 2021 at 04:08:25PM +0000, Tiberiu A Georgescu wrote:
>> This patch follows up on a previous RFC:
>> 20210714152426.216217-1-tiberiu.georgescu@nutanix.com
>>
>> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
>> entry is cleared. In many cases, there is no difference between swapped-out
>> shared pages and newly allocated, non-dirty pages in the pagemap interface.
>>
>> Example pagemap-test code (Tested on Kernel Version 5.14-rc3):
>>      #define NPAGES (256)
>>      /* map 1MiB shared memory */
>>      size_t pagesize = getpagesize();
>>      char *p = mmap(NULL, pagesize * NPAGES, PROT_READ | PROT_WRITE,
>>      		   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
>>      /* Dirty new pages. */
>>      for (i = 0; i < PAGES; i++)
>>      	p[i * pagesize] = i;
>>
>> Run the above program in a small cgroup, which causes swapping:
>>      /* Initialise cgroup & run a program */
>>      $ echo 512K > foo/memory.limit_in_bytes
>>      $ echo 60 > foo/memory.swappiness
>>      $ cgexec -g memory:foo ./pagemap-test
>>
>> Check the pagemap report. Example of the current expected output:
>>      $ dd if=/proc/$PID/pagemap ibs=8 skip=$(($VADDR / $PAGESIZE)) count=$COUNT | hexdump -C
>>      00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>>      *
>>      00000710  e1 6b 06 00 00 00 00 a1  9e eb 06 00 00 00 00 a1  |.k..............|
>>      00000720  6b ee 06 00 00 00 00 a1  a5 a4 05 00 00 00 00 a1  |k...............|
>>      00000730  5c bf 06 00 00 00 00 a1  90 b6 06 00 00 00 00 a1  |\...............|
>>
>> The first pagemap entries are reported as zeroes, indicating the pages have
>> never been allocated while they have actually been swapped out.
>>
>> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
>> make use of the XArray associated with the virtual memory area struct
>> passed as an argument. The XArray contains the location of virtual pages in
>> the page cache, swap cache or on disk. If they are in either of the caches,
>> then the original implementation still works. If not, then the missing
>> information will be retrieved from the XArray.
>>
>> Performance
>> ============
>> I measured the performance of the patch on a single socket Xeon E5-2620
>> machine, with 128GiB of RAM and 128GiB of swap storage. These were the
>> steps taken:
>>
>>    1. Run example pagemap-test code on a cgroup
>>      a. Set up cgroup with limit_in_bytes=4GiB and swappiness=60;
>>      b. allocate 16GiB (about 4 million pages);
>>      c. dirty 0,50 or 100% of pages;
>>      d. do this for both private and shared memory.
>>    2. Run `dd if=<PAGEMAP> ibs=8 skip=$(($VADDR / $PAGESIZE)) count=4194304`
>>       for each possible configuration above
>>      a.  3 times for warm up;
>>      b. 10 times to measure performance.
>>         Use `time` or another performance measuring tool.
>>
>> Results (averaged over 10 iterations):
>>                 +--------+------------+------------+
>>                 | dirty% |  pre patch | post patch |
>>                 +--------+------------+------------+
>>   private|anon  |     0% |      8.15s |      8.40s |
>>                 |    50% |     11.83s |     12.19s |
>>                 |   100% |     12.37s |     12.20s |
>>                 +--------+------------+------------+
>>    shared|anon  |     0% |      8.17s |      8.18s |
>>                 |    50% | (*) 10.43s |     37.43s |
>>                 |   100% | (*) 10.20s |     38.59s |
>>                 +--------+------------+------------+
>>
>> (*): reminder that pre-patch produces incorrect pagemap entries for swapped
>>       out pages.
>>
>>  From run to run the above results are stable (mostly <1% stderr).
>>
>> The amount of time it takes for a full read of the pagemap depends on the
>> granularity used by dd to read the pagemap file. Even though the access is
>> sequential, the script only reads 8 bytes at a time, running pagemap_read()
>> COUNT times (one time for each page in a 16GiB area).
>>
>> To reduce overhead, we can use batching for large amounts of sequential
>> access. We can make dd read multiple page entries at a time,
>> allowing the kernel to make optimisations and yield more throughput.
>>
>> Performance in real time (seconds) of
>> `dd if=<PAGEMAP> ibs=8*$BATCH skip=$(($VADDR / $PAGESIZE / $BATCH))
>> count=$((4194304 / $BATCH))`:
>> +---------------------------------+ +---------------------------------+
>> |     Shared, Anon, 50% dirty     | |     Shared, Anon, 100% dirty    |
>> +-------+------------+------------+ +-------+------------+------------+
>> | Batch |  Pre-patch | Post-patch | | Batch |  Pre-patch | Post-patch |
>> +-------+------------+------------+ +-------+------------+------------+
>> |     1 | (*) 10.43s |     37.43s | |     1 | (*) 10.20s |     38.59s |
>> |     2 | (*)  5.25s |     18.77s | |     2 | (*)  5.15s |     19.37s |
>> |     4 | (*)  2.63s |      9.42s | |     4 | (*)  2.63s |      9.74s |
>> |     8 | (*)  1.38s |      4.80s | |     8 | (*)  1.35s |      4.94s |
>> |    16 | (*)  0.73s |      2.46s | |    16 | (*)  0.72s |      2.54s |
>> |    32 | (*)  0.40s |      1.31s | |    32 | (*)  0.41s |      1.34s |
>> |    64 | (*)  0.25s |      0.72s | |    64 | (*)  0.24s |      0.74s |
>> |   128 | (*)  0.16s |      0.43s | |   128 | (*)  0.16s |      0.44s |
>> |   256 | (*)  0.12s |      0.28s | |   256 | (*)  0.12s |      0.29s |
>> |   512 | (*)  0.10s |      0.21s | |   512 | (*)  0.10s |      0.22s |
>> |  1024 | (*)  0.10s |      0.20s | |  1024 | (*)  0.10s |      0.21s |
>> +-------+------------+------------+ +-------+------------+------------+
>>
>> To conclude, in order to make the most of the underlying mechanisms of
>> pagemap and xarray, one should be using batching to achieve better
>> performance.
> 
> So what I'm still a bit worried is whether it will regress some existing users.
> Note that existing users can try to read pagemap in their own way; we can't
> expect all the userspaces to change their behavior due to a kernel change.

Then let's provide a way to enable the new behavior for a process if we 
don't find another way to extract that information. I would actually 
prefer finding a different interface for that, because with such things 
the "pagemap" no longer expresses which pages are currently mapped. 
Shared memory is weird.

> 
> Meanwhile, from the numbers, it seems to show a 4x speed down due to looking up
> the page cache no matter the size of ibs=.  IOW I don't see a good way to avoid
> that overhead, so no way to have the userspace run as fast as before.
> 
> Also note that it's not only affecting the PM_SWAP users; it potentially
> affects all the /proc/pagemap users as long as there're file-backed memory on
> the read region of pagemap, which is very sane to happen.
> 
> That's why I think if we want to persist it, we should still consider starting
> from the pte marker idea.

TBH, I tend to really dislike the PTE marker idea. IMHO, we shouldn't 
store any state information regarding shared memory in per-process page 
tables: it just doesn't make too much sense.

And this is similar to SOFTDIRTY or UFFD_WP bits: this information 
actually belongs to the shared file ("did *someone* write to this page", 
"is *someone* interested into changes to that page", "is there 
something"). I know, that screams for a completely different design in 
respect to these features.

I guess we start learning the hard way that shared memory is just 
different and requires different interfaces than per-process page table 
interfaces we have (pagemap, userfaultfd).

I didn't have time to explore any alternatives yet, but I wonder if 
tracking such stuff per an actual fd/memfd and not via process page 
tables is actually the right and clean approach. There are certainly 
many issues to solve, but conceptually to me it feels more natural to 
have these shared memory features not mangled into process page tables.

> 
> I do plan to move the pte marker idea forward unless that'll be NACKed upstream
> for some other reason, because that seems to be the only way for uffd-wp to
> support file based memories; no matter with a new swp type or with special swap
> pte.  I am even thinking about whether I should propose that with PM_SWAP first
> because that seems to be a simpler scenario than uffd-wp (which will get the
> rest uffd-wp patches involved then), then we can have a shared infrastructure.
> But haven't thought deeper than that.
> 
> Thanks,
> 


-- 
Thanks,

David / dhildenb

