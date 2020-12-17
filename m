Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351492DD165
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 13:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgLQMTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 07:19:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31352 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgLQMTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608207494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTlbLSnNcMrJSDuydAJRjKKQ4AwImC6eBy5XwIiw1xI=;
        b=Mat6q3WeibKes36EpxuMVzJ+uQY96Sc+ebl4Q6OmmekQqlb5+iE5zmbUK1khzNTjBqr4Wi
        hmEzJzn+5e5QJuW+cru/FyXG8fyBOQmv9x8FeT9DJkjjgvYZg3iRDKJcbG8XEcYPZ4XMbB
        GG1RjMuYaRZGsLC064ZO3Dygg2p99AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593--W6qHNabMoa4KcgwSRp6ng-1; Thu, 17 Dec 2020 07:18:10 -0500
X-MC-Unique: -W6qHNabMoa4KcgwSRp6ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49FF5801AC9;
        Thu, 17 Dec 2020 12:18:05 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E2E11ACC7;
        Thu, 17 Dec 2020 12:17:57 +0000 (UTC)
Subject: Re: [PATCH v10 00/11] Free some vmemmap pages of HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201217121303.13386-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6fbd36f0-4864-89ff-15ef-9750059defab@redhat.com>
Date:   Thu, 17 Dec 2020 13:17:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217121303.13386-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.12.20 13:12, Muchun Song wrote:
> Hi all,
> 
> This patch series will free some vmemmap pages(struct page structures)
> associated with each hugetlbpage when preallocated to save memory.
> 
> In order to reduce the difficulty of the first version of code review.
> From this version, we disable PMD/huge page mapping of vmemmap if this
> feature was enabled. This accutualy eliminate a bunch of the complex code
> doing page table manipulation. When this patch series is solid, we cam add
> the code of vmemmap page table manipulation in the future.
> 
> The struct page structures (page structs) are used to describe a physical
> page frame. By default, there is a one-to-one mapping from a page frame to
> it's corresponding page struct.
> 
> The HugeTLB pages consist of multiple base page size pages and is supported
> by many architectures. See hugetlbpage.rst in the Documentation directory
> for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
> are currently supported. Since the base page size on x86 is 4KB, a 2MB
> HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> 4096 base pages. For each base page, there is a corresponding page struct.
> 
> Within the HugeTLB subsystem, only the first 4 page structs are used to
> contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
> provides this upper limit. The only 'useful' information in the remaining
> page structs is the compound_head field, and this field is the same for all
> tail pages.
> 
> By removing redundant page structs for HugeTLB pages, memory can returned to
> the buddy allocator for other uses.
> 
> When the system boot up, every 2M HugeTLB has 512 struct page structs which
> size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> 
>     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
>  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>  |           |                     |     0     | -------------> |     0     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     1     | -------------> |     1     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     2     | -------------> |     2     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     3     | -------------> |     3     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     4     | -------------> |     4     |
>  |    2MB    |                     +-----------+                +-----------+
>  |           |                     |     5     | -------------> |     5     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     6     | -------------> |     6     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     7     | -------------> |     7     |
>  |           |                     +-----------+                +-----------+
>  |           |
>  |           |
>  |           |
>  +-----------+
> 
> The value of page->compound_head is the same for all tail pages. The first
> page of page structs (page 0) associated with the HugeTLB page contains the 4
> page structs necessary to describe the HugeTLB. The only use of the remaining
> pages of page structs (page 1 to page 7) is to point to page->compound_head.
> Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
> will be used for each HugeTLB page. This will allow us to free the remaining
> 6 pages to the buddy allocator.
> 
> Here is how things look after remapping.
> 
>     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
>  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>  |           |                     |     0     | -------------> |     0     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     1     | -------------> |     1     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
>  |           |                     +-----------+                   | | | | |
>  |           |                     |     3     | ------------------+ | | | |
>  |           |                     +-----------+                     | | | |
>  |           |                     |     4     | --------------------+ | | |
>  |    2MB    |                     +-----------+                       | | |
>  |           |                     |     5     | ----------------------+ | |
>  |           |                     +-----------+                         | |
>  |           |                     |     6     | ------------------------+ |
>  |           |                     +-----------+                           |
>  |           |                     |     7     | --------------------------+
>  |           |                     +-----------+
>  |           |
>  |           |
>  |           |
>  +-----------+
> 
> When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> vmemmap pages and restore the previous mapping relationship.
> 
> Apart from 2MB HugeTLB page, we also have 1GB HugeTLB page. It is similar
> to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
> pages.
> 
> In this case, for the 1GB HugeTLB page, we can save 4088 pages(There are
> 4096 pages for struct page structs, we reserve 2 pages for vmemmap and 8
> pages for page tables. So we can save 4088 pages). This is a very substantial
> gain. On our server, run some SPDK/QEMU applications which will use 1024GB
> hugetlbpage. With this feature enabled, we can save ~16GB(1G hugepage)/~11GB
> (2MB hugepage, the worst case is 10GB while the best is 12GB) memory.
> 
> Because there are vmemmap page tables reconstruction on the freeing/allocating
> path, it increases some overhead. Here are some overhead analysis.
> 
> 1) Allocating 10240 2MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.166s
>    user     0m0.000s
>    sys      0m0.166s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [8K, 16K)           8360 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [16K, 32K)          1868 |@@@@@@@@@@@                                         |
>    [32K, 64K)            10 |                                                    |
>    [64K, 128K)            2 |                                                    |
> 
>    b) Without this patch series:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.066s
>    user     0m0.000s
>    sys      0m0.066s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)           10176 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)             62 |                                                    |
>    [16K, 32K)             2 |                                                    |
> 
>    Summarize: this feature is about ~2x slower than before.
> 
> 2) Freeing 10240 2MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.004s
>    user     0m0.000s
>    sys      0m0.002s
> 
>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [16K, 32K)         10240 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
>    b) Without this patch series:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.077s
>    user     0m0.001s
>    sys      0m0.075s
> 
>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)            9950 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)            287 |@                                                   |
>    [16K, 32K)             3 |                                                    |
> 
>    Summarize: The overhead of __free_hugepage is about ~2-4x slower than before.
>               But according to the allocation test above, I think that here is
> 	      also ~2x slower than before.
> 
>               But why the 'real' time of patched is smaller than before? Because
> 	      In this patch series, the freeing hugetlb is asynchronous(through
> 	      kwoker).
> 
> Although the overhead has increased, the overhead is not significant. Like Mike
> said, "However, remember that the majority of use cases create hugetlb pages at
> or shortly after boot time and add them to the pool. So, additional overhead is
> at pool creation time. There is no change to 'normal run time' operations of
> getting a page from or returning a page to the pool (think page fault/unmap)".
> 

Just FYI, I'll be offline until first week of January. I'm planning on
reviewing when I'm back.


-- 
Thanks,

David / dhildenb

