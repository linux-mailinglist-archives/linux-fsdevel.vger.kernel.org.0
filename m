Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5B2AE6FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 04:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKKDVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 22:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKDVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:21:46 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAF3C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:21:46 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id j5so246319plk.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 19:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4qDi+ouWuBdSJxvoPwdL43KPC7vewj+MLdxXOGRkg8=;
        b=hG/AFLNTcR1IkDfRHH8n79FIEaWe/yacXuyFXxlG+yLoWvDg+Vk8zWXkyB4HVff80T
         1xvNCi3XL7lsvSul5oJFy5uPD9FPwGqC5ivijazdaIQi0BiNABqzZ3CfThl2hLLoV7u2
         sj6xzzY3dNia4iP+eb0LGSZpGctAEyDj2VCqvugs8qI9kW4piWvKAGKHR1VeVvvw/7XF
         7h/60JstnuuQgTlephCxD2CkmI1oE0I0jakaFCbNV2wtBCwyOIc5IMTIpAnD8OBBDQ/a
         AUMz14R9m4cA3uspJttVlLwumZCYUYAseRPJuZd530chjNTm/njEHQoY3fUJtQ+qLot2
         FeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4qDi+ouWuBdSJxvoPwdL43KPC7vewj+MLdxXOGRkg8=;
        b=g4+BXJcu8dQqSvFA3MsAlUHm/lSvaszTs26dz523YLGKRCoGGRaYLOmSk4D5GMhRa2
         /Ap/7CnQAduCxNxRQGoe6r/uDx679Iolz5yfc/ggBKavPKzBaHKj++4AG1sbWEkj5ZZf
         ra5goWV1isN6m6CTGg8HBrQYnkT8c5xxRbcuUIt1AhA74nLPU4Y0utbUXNstQ6nlGi/v
         9WCgUtTCUvVuK9PGo+EZ7JJbMKtlyDxl5xm5qgXjs38dqA4Xxy1Oq4N2omTUtJYWxubH
         4vW9b82wNhFg5i5QnDsBgmE759+Z/dJIelETWMApdnNVlITtanTVlAuxQ1p/5ZVmwuEO
         JfAA==
X-Gm-Message-State: AOAM530JiAms5lU8qflYeVAQeIfYML5k7b9C/gQSLDmnMfDyjbXtFnpZ
        Rukpfn8WsPq0LaNjQwCVBSKiEb5Ad5Ip146yR8nw8Q==
X-Google-Smtp-Source: ABdhPJzTOu4f2ULZGXFqrl7VpP6gHdaquXk5U2Y7P8DgCKmytl8a29FQar+Tbc8IV2ekOw439u1VSNJEAWCu08afiG4=
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id
 11-20020a170902c14bb02900d6ab18108dmr20333440plj.20.1605064905842; Tue, 10
 Nov 2020 19:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com> <78b4cb8b-6511-d50e-7018-ea52c50e4b07@oracle.com>
In-Reply-To: <78b4cb8b-6511-d50e-7018-ea52c50e4b07@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 11 Nov 2020 11:21:09 +0800
Message-ID: <CAMZfGtVvBk6eHRRBcyKxQGx5HG7K0xD8LL7hC2f=bK1cizC2VA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 00/21] Free some vmemmap pages of
 hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 3:23 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
>
> Thanks for continuing to work this Muchun!
>
> On 11/8/20 6:10 AM, Muchun Song wrote:
> ...
> > For tail pages, the value of compound_head is the same. So we can reuse
> > first page of tail page structs. We map the virtual addresses of the
> > remaining 6 pages of tail page structs to the first tail page struct,
> > and then free these 6 pages. Therefore, we need to reserve at least 2
> > pages as vmemmap areas.
> >
> > When a hugetlbpage is freed to the buddy system, we should allocate six
> > pages for vmemmap pages and restore the previous mapping relationship.
> >
> > If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> > substantial gain.
>
> Is that 4095 number accurate?  Are we not using two pages of struct pages
> as in the 2MB case?

Oh, yeah, here should be 4094 and subtract page tables. For a 1GB
HugeTLB page, it should be 4086 pages. Thanks for pointing out
this problem.

>
> Also, because we are splitting the huge page mappings in the vmemmap
> additional PTE pages will need to be allocated.  Therefore, some additional
> page table pages may need to be allocated so that we can free the pages
> of struct pages.  The net savings may be less than what is stated above.
>
> Perhaps this should mention that allocation of additional page table pages
> may be required?

Yeah, you are right. In the later patch, I will rework the analysis
here. Make it
more clear and accurate.

>
> ...
> > Because there are vmemmap page tables reconstruction on the freeing/allocating
> > path, it increases some overhead. Here are some overhead analysis.
> >
> > 1) Allocating 10240 2MB hugetlb pages.
> >
> >    a) With this patch series applied:
> >    # time echo 10240 > /proc/sys/vm/nr_hugepages
> >
> >    real     0m0.166s
> >    user     0m0.000s
> >    sys      0m0.166s
> >
> >    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
> >    Attaching 2 probes...
> >
> >    @latency:
> >    [8K, 16K)           8360 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> >    [16K, 32K)          1868 |@@@@@@@@@@@                                         |
> >    [32K, 64K)            10 |                                                    |
> >    [64K, 128K)            2 |                                                    |
> >
> >    b) Without this patch series:
> >    # time echo 10240 > /proc/sys/vm/nr_hugepages
> >
> >    real     0m0.066s
> >    user     0m0.000s
> >    sys      0m0.066s
> >
> >    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
> >    Attaching 2 probes...
> >
> >    @latency:
> >    [4K, 8K)           10176 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> >    [8K, 16K)             62 |                                                    |
> >    [16K, 32K)             2 |                                                    |
> >
> >    Summarize: this feature is about ~2x slower than before.
> >
> > 2) Freeing 10240 @MB hugetlb pages.
> >
> >    a) With this patch series applied:
> >    # time echo 0 > /proc/sys/vm/nr_hugepages
> >
> >    real     0m0.004s
> >    user     0m0.000s
> >    sys      0m0.002s
> >
> >    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
> >    Attaching 2 probes...
> >
> >    @latency:
> >    [16K, 32K)         10240 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> >
> >    b) Without this patch series:
> >    # time echo 0 > /proc/sys/vm/nr_hugepages
> >
> >    real     0m0.077s
> >    user     0m0.001s
> >    sys      0m0.075s
> >
> >    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
> >    Attaching 2 probes...
> >
> >    @latency:
> >    [4K, 8K)            9950 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> >    [8K, 16K)            287 |@                                                   |
> >    [16K, 32K)             3 |                                                    |
> >
> >    Summarize: The overhead of __free_hugepage is about ~2-4x slower than before.
> >               But according to the allocation test above, I think that here is
> >             also ~2x slower than before.
> >
> >               But why the 'real' time of patched is smaller than before? Because
> >             In this patch series, the freeing hugetlb is asynchronous(through
> >             kwoker).
> >
> > Although the overhead has increased. But the overhead is not on the
> > allocating/freeing of each hugetlb page, it is only once when we reserve
> > some hugetlb pages through /proc/sys/vm/nr_hugepages. Once the reservation
> > is successful, the subsequent allocating, freeing and using are the same
> > as before (not patched). So I think that the overhead is acceptable.
>
> Thank you for benchmarking.  There are still some instances where huge pages
> are allocated 'on the fly' instead of being pulled from the pool.  Michal
> pointed out the case of page migration.  It is also possible for someone to
> use hugetlbfs without pre-allocating huge pages to the pool.  I remember the
> use case pointed out in commit 099730d67417.  It says, "I have a hugetlbfs
> user which is never explicitly allocating huge pages with 'nr_hugepages'.
> They only set 'nr_overcommit_hugepages' and then let the pages be allocated
> from the buddy allocator at fault time."  In this case, I suspect they were
> using 'page fault' allocation for initialization much like someone using
> /proc/sys/vm/nr_hugepages.  So, the overhead may not be as noticeable.

Thanks for pointing out this using case.

>
> --
> Mike Kravetz



-- 
Yours,
Muchun
