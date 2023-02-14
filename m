Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48769601A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjBNKA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 05:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjBNKAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:00:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B825E11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 01:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676368717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p2satF+hQ5FFdcjtgYoKpvsKHvu1xE8rXyO2IMUMeVs=;
        b=eTwlP9SA+VA5oNrnu3sv9UtiXrJoBvV+3a7uQghiG5txwUk6/I5J7oxglelCtspjZ8CjYn
        009YKLjlg38yciHuf7QSGCE/93LOppGIlRv6LiI2jEhOlV+eC0FbooOpXCyHs4DKZVIsXN
        EhBUSgv1j4/poOooE5RQHJm2GDa1tj8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-xFPDarghM562idH8yStEfA-1; Tue, 14 Feb 2023 04:58:34 -0500
X-MC-Unique: xFPDarghM562idH8yStEfA-1
Received: by mail-wr1-f71.google.com with SMTP id v5-20020adf8b45000000b002bde0366b11so2934432wra.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 01:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2satF+hQ5FFdcjtgYoKpvsKHvu1xE8rXyO2IMUMeVs=;
        b=46s0i4m7LWDoWLNxZRXj+K4oB4hQV5AU7poSEON4fmllj0TAmLqbZYtjpiYIdj6MhA
         XbA9qho19QoisWe9OkzDBJLiasDhhtocXWViPY+OC0B7iqffPFbDMNJAxCIaW1pPYSiw
         yt7hNcbR6jkoXqx7yaqlFM7NG7ZTae90RW5Y7PtXdBmaSeM3eARMe6+VN+bqDSIvkkok
         VZidfBjQWx0upIogqny94YAeNiL/XlzmMRsaJ2Eu23KP74xCIxkDajdfUA+Vzwe6cWYS
         5r+NkhcSgOy+0ZXYMJjcjiGNXlq5fMi416XfLUKEFIDUKdKeGzL8zDRy0XVugnxTNGnX
         6HuQ==
X-Gm-Message-State: AO0yUKWqFy05+cqnbhPs0jKFPN3zcbcK9QWmfJVNg2WCr/drKHFyyri1
        o/qJCfuAPSBJWZpXFKbtHbVG72+QvA5WJXI6k9qSc7yiv1OpkQHfvq2fULw9/D/PQ6UX2oV1Ecv
        uzfZaQ5WVBe/tBJcUXCksOpnvXA==
X-Received: by 2002:adf:f8d1:0:b0:2c5:4c9d:2dab with SMTP id f17-20020adff8d1000000b002c54c9d2dabmr1282093wrq.10.1676368713312;
        Tue, 14 Feb 2023 01:58:33 -0800 (PST)
X-Google-Smtp-Source: AK7set+2/NL6NVo4bVpqbzQ5N2dQQ7fBvgOyM9xawBoayfZ5rVsOIRGo9F1XR2LfxDgPz096coFAug==
X-Received: by 2002:adf:f8d1:0:b0:2c5:4c9d:2dab with SMTP id f17-20020adff8d1000000b002c54c9d2dabmr1282057wrq.10.1676368713026;
        Tue, 14 Feb 2023 01:58:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b002c55ec7f661sm3270850wrt.5.2023.02.14.01.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:58:32 -0800 (PST)
Message-ID: <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
Date:   Tue, 14 Feb 2023 10:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
In-Reply-To: <Y+Z8ymNYc+vJMBx8@strix-laptop>
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

On 10.02.23 18:20, Chih-En Lin wrote:
> On Fri, Feb 10, 2023 at 11:21:16AM -0500, Pasha Tatashin wrote:
>>>>> Currently, copy-on-write is only used for the mapped memory; the child
>>>>> process still needs to copy the entire page table from the parent
>>>>> process during forking. The parent process might take a lot of time and
>>>>> memory to copy the page table when the parent has a big page table
>>>>> allocated. For example, the memory usage of a process after forking with
>>>>> 1 GB mapped memory is as follows:
>>>>
>>>> For some reason, I was not able to reproduce performance improvements
>>>> with a simple fork() performance measurement program. The results that
>>>> I saw are the following:
>>>>
>>>> Base:
>>>> Fork latency per gigabyte: 0.004416 seconds
>>>> Fork latency per gigabyte: 0.004382 seconds
>>>> Fork latency per gigabyte: 0.004442 seconds
>>>> COW kernel:
>>>> Fork latency per gigabyte: 0.004524 seconds
>>>> Fork latency per gigabyte: 0.004764 seconds
>>>> Fork latency per gigabyte: 0.004547 seconds
>>>>
>>>> AMD EPYC 7B12 64-Core Processor
>>>> Base:
>>>> Fork latency per gigabyte: 0.003923 seconds
>>>> Fork latency per gigabyte: 0.003909 seconds
>>>> Fork latency per gigabyte: 0.003955 seconds
>>>> COW kernel:
>>>> Fork latency per gigabyte: 0.004221 seconds
>>>> Fork latency per gigabyte: 0.003882 seconds
>>>> Fork latency per gigabyte: 0.003854 seconds
>>>>
>>>> Given, that page table for child is not copied, I was expecting the
>>>> performance to be better with COW kernel, and also not to depend on
>>>> the size of the parent.
>>>
>>> Yes, the child won't duplicate the page table, but fork will still
>>> traverse all the page table entries to do the accounting.
>>> And, since this patch expends the COW to the PTE table level, it's not
>>> the mapped page (page table entry) grained anymore, so we have to
>>> guarantee that all the mapped page is available to do COW mapping in
>>> the such page table.
>>> This kind of checking also costs some time.
>>> As a result, since the accounting and the checking, the COW PTE fork
>>> still depends on the size of the parent so the improvement might not
>>> be significant.
>>
>> The current version of the series does not provide any performance
>> improvements for fork(). I would recommend removing claims from the
>> cover letter about better fork() performance, as this may be
>> misleading for those looking for a way to speed up forking. In my
> 
>  From v3 to v4, I changed the implementation of the COW fork() part to do
> the accounting and checking. At the time, I also removed most of the
> descriptions about the better fork() performance. Maybe it's not enough
> and still has some misleading. I will fix this in the next version.
> Thanks.
> 
>> case, I was looking to speed up Redis OSS, which relies on fork() to
>> create consistent snapshots for driving replicates/backups. The O(N)
>> per-page operation causes fork() to be slow, so I was hoping that this
>> series, which does not duplicate the VA during fork(), would make the
>> operation much quicker.
> 
> Indeed, at first, I tried to avoid the O(N) per-page operation by
> deferring the accounting and the swap stuff to the page fault. But,
> as I mentioned, it's not suitable for the mainline.
> 
> Honestly, for improving the fork(), I have an idea to skip the per-page
> operation without breaking the logic. However, this will introduce the
> complicated mechanism and may has the overhead for other features. It
> might not be worth it. It's hard to strike a balance between the
> over-complicated mechanism with (probably) better performance and data
> consistency with the page status. So, I would focus on the safety and
> stable approach at first.

Yes, it is most probably possible, but complexity, robustness and 
maintainability have to be considered as well.

Thanks for implementing this approach (only deduplication without other 
optimizations) and evaluating it accordingly. It's certainly "cleaner", 
such that we only have to mess with unsharing and not with other 
accounting/pinning/mapcount thingies. But it also highlights how 
intrusive even this basic deduplication approach already is -- and that 
most benefits of the original approach requires even more complexity on top.

I am not quite sure if the benefit is worth the price (I am not to 
decide and I would like to hear other options).

My quick thoughts after skimming over the core parts of this series

(1) forgetting to break COW on a PTE in some pgtable walker feels quite
     likely (meaning that it might be fairly error-prone) and forgetting
     to break COW on a PTE table, accidentally modifying the shared
     table.
(2) break_cow_pte() can fail, which means that we can fail some
     operations (possibly silently halfway through) now. For example,
     looking at your change_pte_range() change, I suspect it's wrong.
(3) handle_cow_pte_fault() looks quite complicated and needs quite some
     double-checking: we temporarily clear the PMD, to reset it
     afterwards. I am not sure if that is correct. For example, what
     stops another page fault stumbling over that pmd_none() and
     allocating an empty page table? Maybe there are some locking details
     missing or they are very subtle such that we better document them. I
    recall that THP played quite some tricks to make such cases work ...

> 
>>> Actually, at the RFC v1 and v2, we proposed the version of skipping
>>> those works, and we got a significant improvement. You can see the
>>> number from RFC v2 cover letter [1]:
>>> "In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
>>> for normal fork"
>>
>> I suspect the 93% improvement (when the mapcount was not updated) was
>> only for VAs with 4K pages. With 2M mappings this series did not
>> provide any benefit is this correct?
> 
> Yes. In this case, the COW PTE performance is similar to the normal
> fork().


The thing with THP is, that during fork(), we always allocate a backup 
PTE table, to be able to PTE-map the THP whenever we have to. Otherwise 
we'd have to eventually fail some operations we don't want to fail -- 
similar to the case where break_cow_pte() could fail now due to -ENOMEM 
although we really don't want to fail (e.g., change_pte_range() ).

I always considered that wasteful, because in many scenarios, we'll 
never ever split a THP and possibly waste memory.

Optimizing that for THP (e.g., don't always allocate backup THP, have 
some global allocation backup pool for splits + refill when 
close-to-empty) might provide similar fork() improvements, both in speed 
and memory consumption when it comes to anonymous memory.

-- 
Thanks,

David / dhildenb

