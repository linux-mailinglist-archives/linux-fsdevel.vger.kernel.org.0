Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE04769646D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjBNNSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 08:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjBNNSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49387A5D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676380673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A8HDxZQVwZH5D2IeFvDjPWBFybx0kwEQ286b5EVXyXg=;
        b=JALzjGE7ISVOdYKDo3x8ovpMvJGGkv1bTim2MSS8nMVp8o2oFaML20CAZkUtD7I+izwUA1
        /eOnBOy27chggO+jED6CbFgCyYnCT5C5OLPRY86WK8SzYfKL8zbi1xeu5fY32tXzoVE7E5
        z5al1AMXEg/uOAIdNGG9hIq4ogDLeH0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-29A5NWg6OdG2_uopYuMz9g-1; Tue, 14 Feb 2023 08:17:52 -0500
X-MC-Unique: 29A5NWg6OdG2_uopYuMz9g-1
Received: by mail-wr1-f70.google.com with SMTP id c14-20020a5d528e000000b002c3f54b828bso3060802wrv.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 05:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8HDxZQVwZH5D2IeFvDjPWBFybx0kwEQ286b5EVXyXg=;
        b=7eTWzpfLKEGqe2PoN2fBkoVe4H+FHYOt9VyAao2K9Rmx9RKl7iP5x5+Vte3lkOqiyW
         bW2xjXi/Khfn2m5ODhMoUrxvhBigq0IcKV0PXaj2pA+eBrKQ5S1WQFgN8pCszX4VOZ4W
         L8Bc2Z+xW/jUQntyxg7CCtqRQzJSO45ekO/Az3jcEsu1sR1iye/9s597YK2O1WYQj7A0
         10KFTHG9mWM4ykMTyiyMradojEkQvs9wUbii8VYhM7bhIIIlp76ygeg+4NZ1l52NqhrP
         3gpmB+/BvFtStM1noz+YRiekuRYa7+CWi+vDgRLE5ulo+xL9VYGrY8cgOucyjGqgqW6o
         Zlyg==
X-Gm-Message-State: AO0yUKWh7RGID+/SRw5/Eh1BPq8rix03xBIbBiv7xsFVPAIP9k3AmCEi
        fYyDd/lHqH/6DGshnpsR2q1gF1/2LgAQPL/pccKuocvVwjoRU25f3obiIsG3KEutSgsBQyy6RxH
        1AWdsUbq3laBg/z751mWYMnDA7A==
X-Received: by 2002:a7b:c855:0:b0:3db:742:cfe9 with SMTP id c21-20020a7bc855000000b003db0742cfe9mr2536570wml.34.1676380670592;
        Tue, 14 Feb 2023 05:17:50 -0800 (PST)
X-Google-Smtp-Source: AK7set8G7hIRNYDyQy+XjnM15cKgAkRYhCepLR9sQ49WwOk3wVWBgaodOKoIYp/PJB0uaGk7AdXIjg==
X-Received: by 2002:a7b:c855:0:b0:3db:742:cfe9 with SMTP id c21-20020a7bc855000000b003db0742cfe9mr2536546wml.34.1676380670294;
        Tue, 14 Feb 2023 05:17:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id iv12-20020a05600c548c00b003dc521f336esm18770472wmb.14.2023.02.14.05.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 05:17:49 -0800 (PST)
Message-ID: <baa7c076-09b9-f38d-ff6d-914fe2523219@redhat.com>
Date:   Tue, 14 Feb 2023 14:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Chih-En Lin <shiyn.lin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
 <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <CA+CK2bB-dArab6scZU6tD7vnBBqbn9NwWbfwnddBzTxUmmhOfQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
In-Reply-To: <CA+CK2bB-dArab6scZU6tD7vnBBqbn9NwWbfwnddBzTxUmmhOfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.02.23 14:07, Pasha Tatashin wrote:
> On Tue, Feb 14, 2023 at 4:58 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 10.02.23 18:20, Chih-En Lin wrote:
>>> On Fri, Feb 10, 2023 at 11:21:16AM -0500, Pasha Tatashin wrote:
>>>>>>> Currently, copy-on-write is only used for the mapped memory; the child
>>>>>>> process still needs to copy the entire page table from the parent
>>>>>>> process during forking. The parent process might take a lot of time and
>>>>>>> memory to copy the page table when the parent has a big page table
>>>>>>> allocated. For example, the memory usage of a process after forking with
>>>>>>> 1 GB mapped memory is as follows:
>>>>>>
>>>>>> For some reason, I was not able to reproduce performance improvements
>>>>>> with a simple fork() performance measurement program. The results that
>>>>>> I saw are the following:
>>>>>>
>>>>>> Base:
>>>>>> Fork latency per gigabyte: 0.004416 seconds
>>>>>> Fork latency per gigabyte: 0.004382 seconds
>>>>>> Fork latency per gigabyte: 0.004442 seconds
>>>>>> COW kernel:
>>>>>> Fork latency per gigabyte: 0.004524 seconds
>>>>>> Fork latency per gigabyte: 0.004764 seconds
>>>>>> Fork latency per gigabyte: 0.004547 seconds
>>>>>>
>>>>>> AMD EPYC 7B12 64-Core Processor
>>>>>> Base:
>>>>>> Fork latency per gigabyte: 0.003923 seconds
>>>>>> Fork latency per gigabyte: 0.003909 seconds
>>>>>> Fork latency per gigabyte: 0.003955 seconds
>>>>>> COW kernel:
>>>>>> Fork latency per gigabyte: 0.004221 seconds
>>>>>> Fork latency per gigabyte: 0.003882 seconds
>>>>>> Fork latency per gigabyte: 0.003854 seconds
>>>>>>
>>>>>> Given, that page table for child is not copied, I was expecting the
>>>>>> performance to be better with COW kernel, and also not to depend on
>>>>>> the size of the parent.
>>>>>
>>>>> Yes, the child won't duplicate the page table, but fork will still
>>>>> traverse all the page table entries to do the accounting.
>>>>> And, since this patch expends the COW to the PTE table level, it's not
>>>>> the mapped page (page table entry) grained anymore, so we have to
>>>>> guarantee that all the mapped page is available to do COW mapping in
>>>>> the such page table.
>>>>> This kind of checking also costs some time.
>>>>> As a result, since the accounting and the checking, the COW PTE fork
>>>>> still depends on the size of the parent so the improvement might not
>>>>> be significant.
>>>>
>>>> The current version of the series does not provide any performance
>>>> improvements for fork(). I would recommend removing claims from the
>>>> cover letter about better fork() performance, as this may be
>>>> misleading for those looking for a way to speed up forking. In my
>>>
>>>   From v3 to v4, I changed the implementation of the COW fork() part to do
>>> the accounting and checking. At the time, I also removed most of the
>>> descriptions about the better fork() performance. Maybe it's not enough
>>> and still has some misleading. I will fix this in the next version.
>>> Thanks.
>>>
>>>> case, I was looking to speed up Redis OSS, which relies on fork() to
>>>> create consistent snapshots for driving replicates/backups. The O(N)
>>>> per-page operation causes fork() to be slow, so I was hoping that this
>>>> series, which does not duplicate the VA during fork(), would make the
>>>> operation much quicker.
>>>
>>> Indeed, at first, I tried to avoid the O(N) per-page operation by
>>> deferring the accounting and the swap stuff to the page fault. But,
>>> as I mentioned, it's not suitable for the mainline.
>>>
>>> Honestly, for improving the fork(), I have an idea to skip the per-page
>>> operation without breaking the logic. However, this will introduce the
>>> complicated mechanism and may has the overhead for other features. It
>>> might not be worth it. It's hard to strike a balance between the
>>> over-complicated mechanism with (probably) better performance and data
>>> consistency with the page status. So, I would focus on the safety and
>>> stable approach at first.
>>
>> Yes, it is most probably possible, but complexity, robustness and
>> maintainability have to be considered as well.
>>
>> Thanks for implementing this approach (only deduplication without other
>> optimizations) and evaluating it accordingly. It's certainly "cleaner",
>> such that we only have to mess with unsharing and not with other
>> accounting/pinning/mapcount thingies. But it also highlights how
>> intrusive even this basic deduplication approach already is -- and that
>> most benefits of the original approach requires even more complexity on top.
>>
>> I am not quite sure if the benefit is worth the price (I am not to
>> decide and I would like to hear other options).
>>
>> My quick thoughts after skimming over the core parts of this series
>>
>> (1) forgetting to break COW on a PTE in some pgtable walker feels quite
>>       likely (meaning that it might be fairly error-prone) and forgetting
>>       to break COW on a PTE table, accidentally modifying the shared
>>       table.
>> (2) break_cow_pte() can fail, which means that we can fail some
>>       operations (possibly silently halfway through) now. For example,
>>       looking at your change_pte_range() change, I suspect it's wrong.
>> (3) handle_cow_pte_fault() looks quite complicated and needs quite some
>>       double-checking: we temporarily clear the PMD, to reset it
>>       afterwards. I am not sure if that is correct. For example, what
>>       stops another page fault stumbling over that pmd_none() and
>>       allocating an empty page table? Maybe there are some locking details
>>       missing or they are very subtle such that we better document them. I
>>      recall that THP played quite some tricks to make such cases work ...
>>
>>>
>>>>> Actually, at the RFC v1 and v2, we proposed the version of skipping
>>>>> those works, and we got a significant improvement. You can see the
>>>>> number from RFC v2 cover letter [1]:
>>>>> "In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
>>>>> for normal fork"
>>>>
>>>> I suspect the 93% improvement (when the mapcount was not updated) was
>>>> only for VAs with 4K pages. With 2M mappings this series did not
>>>> provide any benefit is this correct?
>>>
>>> Yes. In this case, the COW PTE performance is similar to the normal
>>> fork().
>>
>>
>> The thing with THP is, that during fork(), we always allocate a backup
>> PTE table, to be able to PTE-map the THP whenever we have to. Otherwise
>> we'd have to eventually fail some operations we don't want to fail --
>> similar to the case where break_cow_pte() could fail now due to -ENOMEM
>> although we really don't want to fail (e.g., change_pte_range() ).
>>
>> I always considered that wasteful, because in many scenarios, we'll
>> never ever split a THP and possibly waste memory.
> 
> Yes, it does sound wasteful for a pretty rare corner case that
> combines splitting THP in a process, and not having enough memory to
> allocate PTE page tables.
> 
>> Optimizing that for THP (e.g., don't always allocate backup THP, have
>> some global allocation backup pool for splits + refill when
>> close-to-empty) might provide similar fork() improvements, both in speed
>> and memory consumption when it comes to anonymous memory.
> 
> This sounds like a reasonable way to optimize the fork performance for
> processes with large RSS, which in most cases would have 2M THP
> mappings. When you say global pool, do you mean per machine, per
> cgroup, or per process?

Good question. I recall that the problem is that we sometimes need a new 
pgtable when splitting a THP, but

(a) we might be under spinlock and cannot sleep. We need an atomic
     allocation that might fail. For this, a pool might be helpful.

(b) we might actually be out of memory.

My gut feeling is that a global pool would be sufficient, only yo be 
used when we run into (a) or (b) to be able to make progress in these 
rare cases.

Something that would be interesting to evaluate is which THP split 
operations might might require some way to recover when really OOM.

For example, __split_huge_pmd() is currently not able to report a 
failure. I assume that we could sleep in there. And if we're not able to 
allocate any memory in there (with sleeping), maybe the process should 
be zapped either way by the OOM killer.


-- 
Thanks,

David / dhildenb

