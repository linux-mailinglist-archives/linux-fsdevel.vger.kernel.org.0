Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DE3696BDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjBNRki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjBNRk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:40:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD081B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676396375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QKLllZC1uEUOE2BdO7bzLxdbv09hiQiyoC40FRYKDo=;
        b=bplvXCMM/PomsOAvdnCxSrzC/eQUPpYVD2Xcbu2DOTPRtziir75GC+KSEi95UKYeY+8+uj
        39+C56KQBhk+bw420ZrDAtRPe3q8K3X6rPyY9/LtztTtoXC+Wd1N4cZpPpX0bvPqCjvMcg
        pea+ROUb3Sq/GgmDXkWKt2STXb/UPIc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-smmyHg3KP_up2QmeaE8FLQ-1; Tue, 14 Feb 2023 12:39:26 -0500
X-MC-Unique: smmyHg3KP_up2QmeaE8FLQ-1
Received: by mail-wm1-f71.google.com with SMTP id n4-20020a05600c3b8400b003dfe223de49so11301265wms.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QKLllZC1uEUOE2BdO7bzLxdbv09hiQiyoC40FRYKDo=;
        b=cNSDNk1ND6dCEoQge1swTgOtQDXOfaoP/6VEt6MSczyhJU9FqmFedC7fgrbXaR4QOR
         U3Zdcik5Kfz/xTGjRyQZ8CyJ8/tlVlwH3bkSaTYmQ+2sfRDM6bK4GWzruI2HA6ZhAZgN
         8owbfiyy65fckskmELBsh7wvPFad5NnfkrNG76gj0+sqxuPg0Rz1ucmbK9OyxBl+qCUO
         2o3xJHQ4baKK3LoKYqDhkhDU2jAlV3XPeSqIqZqvKKUPSQC/IOmU3t1wfj3j/p/VWDIE
         uSqS1TdxzhveBPCzqbi7s3t/ZfxTKU7wSSn/K4LfZJkM6y06TvjVEIrQQzplG0dO+qnK
         Iltg==
X-Gm-Message-State: AO0yUKXY1KObw//0y1RFhl35LyfiGiNqQPculcIx3l0q+iHEvO0kCtq5
        vuu40dHufbDuuHoIp8HmcmsZKUarlfgvw9ZakfX5acfpy4XjPSNieH38EwuhD9qZPBb9sPvGk++
        +EDLixGXJa+riMqm5mDUCfV+w8Q==
X-Received: by 2002:a5d:6806:0:b0:2c4:57d3:396 with SMTP id w6-20020a5d6806000000b002c457d30396mr2716948wru.40.1676396364812;
        Tue, 14 Feb 2023 09:39:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/r0DQ7+ma2F6crvNFnBEefDNPcQ1q0jtIdkDICXCjvMBFXmslFeTySfwfESBVH/z6uWOQnhg==
X-Received: by 2002:a5d:6806:0:b0:2c4:57d3:396 with SMTP id w6-20020a5d6806000000b002c457d30396mr2716932wru.40.1676396364345;
        Tue, 14 Feb 2023 09:39:24 -0800 (PST)
Received: from [192.168.3.108] (p5b0c60e7.dip0.t-ipconnect.de. [91.12.96.231])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm3582125wrp.53.2023.02.14.09.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:39:23 -0800 (PST)
Message-ID: <b1cada27-33b0-f53a-4059-07c54d9f1bc4@redhat.com>
Date:   Tue, 14 Feb 2023 18:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Chih-En Lin <shiyn.lin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
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
        Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
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
 <CAHbLzkoYo3Fwz2H=GM3X+ao33NN2fc2qh6y_ir4A-RL0LvJaZA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
In-Reply-To: <CAHbLzkoYo3Fwz2H=GM3X+ao33NN2fc2qh6y_ir4A-RL0LvJaZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.02.23 18:23, Yang Shi wrote:
> On Tue, Feb 14, 2023 at 1:58 AM David Hildenbrand <david@redhat.com> wrote:
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
> When you say "split THP", do you mean split the compound page to base
> pages? IIUC the backup PTE table page is used to guarantee the PMD
> split (just convert pmd mapped THP to PTE-mapped but not split the
> compound page) succeed. You may already notice there is no return
> value for PMD split.

Yes, as I raised in my other reply.

> 
> The PMD split may be called quite often, for example, MADV_DONTNEED,
> mbind, mlock, and even in memory reclamation context  (THP swap).

Yes, but with a single MADV_DONTNEED call you cannot PTE-map more than 2 
THP (all other overlapped THP will get zapped). Same with most other 
operations.

There are corner cases, though. I recall that s390x/kvm wants to break 
all THP in a given VMA range. But that operation could safely fail if we 
can't do that.

Certainly needs some investigation, that's most probably why it hasn't 
been done yet.

> 
>>
>> Optimizing that for THP (e.g., don't always allocate backup THP, have
>> some global allocation backup pool for splits + refill when
>> close-to-empty) might provide similar fork() improvements, both in speed
>> and memory consumption when it comes to anonymous memory.
> 
> It might work. But may be much more complicated than what you thought
> when handling multiple parallel PMD splits.


I consider the whole PTE-table linking to THPs complicated enough to 
eventually replace it by something differently complicated that wastes 
less memory ;)

-- 
Thanks,

David / dhildenb

