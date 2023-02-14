Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37088696C27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjBNSAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 13:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBNSAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:00:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87B29173
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676397596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7+MNGw6vwnaHZ5KcVeVb+hrtvazbgYAm6V9+SE6quw=;
        b=d0sDkfWK6Yj3TmZw2dd+yvLNqFPq0apbO+v2wefdaBb+wx7eJUOupvoOPLHusPHcNcljLv
        LvWWb0ce3snr2EixTwcL5NOpG1CcEtkgD7/u6qRr6byELc2i+7h7vdzNeo2X7iQPodndt0
        YqgFUBNNLIurOV1c09e8l0P22oKz2v0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-62-RjNmKL6yNPyyn_A6glGduA-1; Tue, 14 Feb 2023 12:59:55 -0500
X-MC-Unique: RjNmKL6yNPyyn_A6glGduA-1
Received: by mail-wm1-f72.google.com with SMTP id p14-20020a05600c468e00b003e0107732f4so8127801wmo.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7+MNGw6vwnaHZ5KcVeVb+hrtvazbgYAm6V9+SE6quw=;
        b=bLNqfVAPlFYE8VVz6yof/LrXYefFjSWADXhKQmKfv1w64ykAEoZAFBFTm16eVzs9PK
         fmUgV6B0HhkGfSDc1GvvfmUVGsfWPU9w5mNUjpxZJMpWxwE1L5Ch5rWoreK/XbWq2hq6
         dFiIhsY/KSjca1t7TXovarNHejY6pQ91Xfsw5KksbdqtT8tdidFY6J42AXPM7uvPzvfp
         xNpFXw6hx+mBgqd2Jbs225wqoR/jtS7uzzIgHzlauSECOC+9k7UkAS5vlicrQyudVsye
         o0K+axRK2QA2z04hq6hX6xT1xpK/KrVNNUXTpY2D8vsir2Cl/wOxL+/OH9UF8zKe13nO
         GqCg==
X-Gm-Message-State: AO0yUKXoGvgFaMxmQ6lS41+p6T3IAz6ccnmtMujMOvgxFYf1QzZmzKVF
        Iwda1TAWftSGiaLS75kE9P22eyv03Wx00YkLJeNJfENnRzohNZQ+50906R1+Ij95/m5e7E3gwi9
        OOi2emQQ1VfqiI6kJP4CODXZB7g==
X-Received: by 2002:a05:600c:818:b0:3dc:5390:6499 with SMTP id k24-20020a05600c081800b003dc53906499mr2889180wmp.1.1676397593944;
        Tue, 14 Feb 2023 09:59:53 -0800 (PST)
X-Google-Smtp-Source: AK7set98816UCJl6OBxQQIva/LK43GcvL27hW/jwL7RgWSMiK6908hg+hJsKTx0b9fYemxxuQH+yLQ==
X-Received: by 2002:a05:600c:818:b0:3dc:5390:6499 with SMTP id k24-20020a05600c081800b003dc53906499mr2889151wmp.1.1676397593698;
        Tue, 14 Feb 2023 09:59:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b003e00c453447sm21363801wmq.48.2023.02.14.09.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:59:53 -0800 (PST)
Message-ID: <28f1e75a-a1fc-a172-3628-83575e387f9a@redhat.com>
Date:   Tue, 14 Feb 2023 18:59:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
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
 <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
 <Y+vK3tXWHCgTC8qk@strix-laptop>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y+vK3tXWHCgTC8qk@strix-laptop>
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

On 14.02.23 18:54, Chih-En Lin wrote:
>>>
>>>> (2) break_cow_pte() can fail, which means that we can fail some
>>>>       operations (possibly silently halfway through) now. For example,
>>>>       looking at your change_pte_range() change, I suspect it's wrong.
>>>
>>> Maybe I should add WARN_ON() and skip the failed COW PTE.
>>
>> One way or the other we'll have to handle it. WARN_ON() sounds wrong for
>> handling OOM situations (e.g., if only that cgroup is OOM).
> 
> Or we should do the same thing like you mentioned:
> "
> For example, __split_huge_pmd() is currently not able to report a
> failure. I assume that we could sleep in there. And if we're not able to
> allocate any memory in there (with sleeping), maybe the process should
> be zapped either way by the OOM killer.
> "
> 
> But instead of zapping the process, we just skip the failed COW PTE.
> I don't think the user will expect their process to be killed by
> changing the protection.

The process is consuming more memory than it is capable of consuming. 
The process most probably would have died earlier without the PTE 
optimization.

But yeah, it all gets tricky ...

> 
>>>
>>>> (3) handle_cow_pte_fault() looks quite complicated and needs quite some
>>>>       double-checking: we temporarily clear the PMD, to reset it
>>>>       afterwards. I am not sure if that is correct. For example, what
>>>>       stops another page fault stumbling over that pmd_none() and
>>>>       allocating an empty page table? Maybe there are some locking details
>>>>       missing or they are very subtle such that we better document them. I
>>>>      recall that THP played quite some tricks to make such cases work ...
>>>
>>> I think that holding mmap_write_lock may be enough (I added
>>> mmap_assert_write_locked() in the fault function btw). But, I might
>>> be wrong. I will look at the THP stuff to see how they work. Thanks.
>>>
>>
>> Ehm, but page faults don't hold the mmap lock writable? And so are other
>> callers, like MADV_DONTNEED or MADV_FREE.
>>
>> handle_pte_fault()->handle_pte_fault()->mmap_assert_write_locked() should
>> bail out.
>>
>> Either I am missing something or you didn't test with lockdep enabled :)
> 
> You're right. I thought I enabled the lockdep.
> And, why do I have the page fault will handle the mmap lock writable in my mind.
> The page fault holds the mmap lock readable instead of writable.
> ;-)
> 
> I should check/test all the locks again.
> Thanks.

Note that we have other ways of traversing page tables, especially, 
using the rmap which does not hold the mmap lock. Not sure if there are 
similar issues when suddenly finding no page table where there logically 
should be one. Or when a page table gets replaced and modified, while 
rmap code still walks the shared copy. Hm.

-- 
Thanks,

David / dhildenb

