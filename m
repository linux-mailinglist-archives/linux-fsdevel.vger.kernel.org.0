Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21C9696AA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBNRAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjBNRAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:00:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793ED2CFEA
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676393931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuHwzZTrvbVLrZIEtXxaNZLPc/tFsdLuSJJ5efA8PZ0=;
        b=S65friWBnFPwtPc1M2CvjvpHlL1j9nb8a0c9fh94JPLER1J9BjiiYPOgHnEqRvtD8KyT10
        tgyKHbBHuP/Wt60vsa1p+DeXrC3MgPsNG4w9TvEApticAGGzSzxwi80TlW7b+Zev+ck0pf
        HSiSmBDziRry20j51xHQpoj45VYIl74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-Yvh2umCvOBGOH2Qr9L8s6w-1; Tue, 14 Feb 2023 11:58:50 -0500
X-MC-Unique: Yvh2umCvOBGOH2Qr9L8s6w-1
Received: by mail-wr1-f70.google.com with SMTP id m10-20020a056000024a00b002c55068a8efso1498126wrz.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 08:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuHwzZTrvbVLrZIEtXxaNZLPc/tFsdLuSJJ5efA8PZ0=;
        b=4sqi07Kt0tpNwPXdJAXpeSe5X6EgiXGB4feOuTH/KGlpDxK1alsay9zpk9oK/vN7TT
         a8ztk9I/eS5xAfaT32OJ36fBO/3KqVxU8oU4hSdu8JsK6Qe31z2U1tsFapeN5woqIlts
         9+0ACybRn2IJFdaLI911bc5Nrjn6wkqaLz7RGiZZgEyY/QYyxSlNabRxvfEsaq4tt1hz
         ElsBK9QEdDv6sOYAon1KKuWviWxvT5N3C2R4G/OwM55/aGD5/8B9Eu1MvLelM+2tz6F0
         upnnEQXGjC5Bs09rMsn4gZjlh6ZCdh9nS0iHHhJgjjfVNnqciKSs+8Hvs6t7tEnKK+gs
         Qtzg==
X-Gm-Message-State: AO0yUKXhfcct31lfa4mgX+kNInUsOAkLsmPvyK9p3hseuaJAP/FJUwEG
        6q/NY8CANi/x+jwJCuO+wWk6UyfGM0BYWiX16oRsNlcTPs0z6C3MEaQlwx7unjDA0+LJ4RSiWF5
        K9qpGtGFxe6rItIp5dlGFcJK6VQ==
X-Received: by 2002:adf:fd11:0:b0:2c5:60e2:ed6b with SMTP id e17-20020adffd11000000b002c560e2ed6bmr2472181wrr.2.1676393929306;
        Tue, 14 Feb 2023 08:58:49 -0800 (PST)
X-Google-Smtp-Source: AK7set+c46SGb0cyt7nBCeLUBmB3MfNMmWwOtQ0u0jB0emQwNtfrzpIlWNiHXf7awUpb3XlyQknNdA==
X-Received: by 2002:adf:fd11:0:b0:2c5:60e2:ed6b with SMTP id e17-20020adffd11000000b002c560e2ed6bmr2472156wrr.2.1676393928992;
        Tue, 14 Feb 2023 08:58:48 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d6752000000b002c5503a8d21sm8549944wrw.70.2023.02.14.08.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 08:58:48 -0800 (PST)
Message-ID: <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
Date:   Tue, 14 Feb 2023 17:58:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
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
 <Y+uv3iTajGoOuNMO@strix-laptop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
In-Reply-To: <Y+uv3iTajGoOuNMO@strix-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


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
>> optimizations) and evaluating it accordingly. It's certainly "cleaner", such
>> that we only have to mess with unsharing and not with other
>> accounting/pinning/mapcount thingies. But it also highlights how intrusive
>> even this basic deduplication approach already is -- and that most benefits
>> of the original approach requires even more complexity on top.
>>
>> I am not quite sure if the benefit is worth the price (I am not to decide
>> and I would like to hear other options).
> 
> I'm looking at the discussion of page table sharing in 2002 [1].
> It looks like in 2002 ~ 2006, there also have some patches try to
> improve fork().
> 
> After that, I also saw one thread which is about another shared page
> table patch's benchmark. I can't find the original patch though [2].
> But, I found the probably same patch in 2005 [3], it also mentioned
> the previous benchmark discussion:
> 
> "
> For those familiar with the shared page table patch I did a couple of years
> ago, this patch does not implement copy-on-write page tables for private
> mappings.  Analysis showed the cost and complexity far outweighed any
> potential benefit.
> "

Thanks for the pointer, interesting read. And my personal opinion is 
that part of that statement still hold true :)

> 
> However, it might be different right now. For example, the implemetation
> . We have split page table lock now, so we don't have to consider the
> page_table_share_lock thing. Also, presently, we have different use
> cases (shells [2] v.s. VM cloning and fuzzing) to consider.
> 
> Nonetheless, I still think the discussion can provide some of the mind
> to us.
> 
> BTW, It seems like the 2002 patch [1] is different from the 2002 [2]
> and 2005 [3].
> 
> [1] https://lkml.iu.edu/hypermail/linux/kernel/0202.2/0102.html
> [2] https://lore.kernel.org/linux-mm/3E02FACD.5B300794@digeo.com/
> [3] https://lore.kernel.org/linux-mm/7C49DFF721CB4E671DB260F9@%5B10.1.1.4%5D/T/#u
> 
>> My quick thoughts after skimming over the core parts of this series
>>
>> (1) forgetting to break COW on a PTE in some pgtable walker feels quite
>>      likely (meaning that it might be fairly error-prone) and forgetting
>>      to break COW on a PTE table, accidentally modifying the shared
>>      table.
> 
> Maybe I should also handle arch/ and others parts.
> I will keep looking at where I missed.

One could add sanity checks when modifying a PTE while the PTE table is 
still marked shared ... but I guess there are some valid reasons where 
we might want to modify shared PTE tables (rmap).

> 
>> (2) break_cow_pte() can fail, which means that we can fail some
>>      operations (possibly silently halfway through) now. For example,
>>      looking at your change_pte_range() change, I suspect it's wrong.
> 
> Maybe I should add WARN_ON() and skip the failed COW PTE.

One way or the other we'll have to handle it. WARN_ON() sounds wrong for 
handling OOM situations (e.g., if only that cgroup is OOM).

> 
>> (3) handle_cow_pte_fault() looks quite complicated and needs quite some
>>      double-checking: we temporarily clear the PMD, to reset it
>>      afterwards. I am not sure if that is correct. For example, what
>>      stops another page fault stumbling over that pmd_none() and
>>      allocating an empty page table? Maybe there are some locking details
>>      missing or they are very subtle such that we better document them. I
>>     recall that THP played quite some tricks to make such cases work ...
> 
> I think that holding mmap_write_lock may be enough (I added
> mmap_assert_write_locked() in the fault function btw). But, I might
> be wrong. I will look at the THP stuff to see how they work. Thanks.
> 

Ehm, but page faults don't hold the mmap lock writable? And so are other 
callers, like MADV_DONTNEED or MADV_FREE.

handle_pte_fault()->handle_pte_fault()->mmap_assert_write_locked() 
should bail out.

Either I am missing something or you didn't test with lockdep enabled :)

Note that there are upstream efforts to use only a VMA lock (and some 
people even want to perform some page faults only protected by RCU).

-- 
Thanks,

David / dhildenb

