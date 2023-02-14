Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DB696AC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBNRFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjBNRFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:05:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCBD2B280
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676394244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NRv9ri62QZ3gJa1mEP8cILMMa4bJVoJu/pQsWSUh2bo=;
        b=DRJCyQwCmwxA/WB+ek+hgT2HvQUGhx4vywVXkS5J/HRJ/qCr7IlZnSU5y24LfYIPD3ryU/
        Pnw35PMlCA9nHhx/TKS+yuz1GN2z+z/Bh/JX5xranRYeZ0SBgsr4Ots3ykmR+Yehs7QuGO
        kwt5Vs+bt4rrLPtSKQJ/ITjmpGfLIkQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-OkYAPHwFNY-tYWzcV6Dpwg-1; Tue, 14 Feb 2023 12:04:03 -0500
X-MC-Unique: OkYAPHwFNY-tYWzcV6Dpwg-1
Received: by mail-wr1-f69.google.com with SMTP id w9-20020a5d6089000000b002c5669766a8so421543wrt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 09:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRv9ri62QZ3gJa1mEP8cILMMa4bJVoJu/pQsWSUh2bo=;
        b=1s58H3mq6q5T0HKK+XfTm8oPJJNLI24GXuafpLRwYU/4Crkev5m5r0U7cbpnvWURsp
         I8tPMatih62LOgw2Lyd114GD5lkDfrY37YnRPWT2Alqml024rMqx1RZkMvKExtmeB1EA
         Zi5DNFMv18SEQG2249OojEPOySdlqJl7URdjGY11sHR5Lu4Dtml+H8Z0q3EjhurPfwmk
         rcONka9+CJuYQ4vx5aMX7fxCpBczmbC75bGqqyjbJse/IPcByRTXovWLpLITw1AtNAep
         NdENqDgDnxHY8OFiwNpLPHZjke9L71BFjILUTe2ENnCgkUmqKd+TgSpzP+I0mGu/AWVK
         Bm+g==
X-Gm-Message-State: AO0yUKUnPJUYPXuhpQYP73Cnvi3+xD0lXcYLfNtvmTE85BM2u3QjmXQA
        Voh6eHY1kXvGWDywgtmuGZkS1RGe38qhnyRHL+K47H8U//JcHjNlo15EbXCyx8i8bTaicf/BMzM
        k6dh2uhNjM39hAfFr1mNtzFGSIA==
X-Received: by 2002:a05:600c:13c5:b0:3dd:daac:d99d with SMTP id e5-20020a05600c13c500b003dddaacd99dmr2527003wmg.36.1676394241783;
        Tue, 14 Feb 2023 09:04:01 -0800 (PST)
X-Google-Smtp-Source: AK7set8tSPkMFovKHAi9fQL2Lota2iYTdYbeJPkqZQwJOal/QZ6PhHFXtJ8m01VC2QuC7xPfjtZ3Cg==
X-Received: by 2002:a05:600c:13c5:b0:3dd:daac:d99d with SMTP id e5-20020a05600c13c500b003dddaacd99dmr2526969wmg.36.1676394241490;
        Tue, 14 Feb 2023 09:04:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b003dc42d48defsm20057888wmo.6.2023.02.14.09.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:04:00 -0800 (PST)
Message-ID: <1bee97ef-7632-b1bf-f042-29b97882bfb6@redhat.com>
Date:   Tue, 14 Feb 2023 18:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
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
Organization: Red Hat
In-Reply-To: <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
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

On 14.02.23 17:58, David Hildenbrand wrote:
> 
>>>>
>>>> Honestly, for improving the fork(), I have an idea to skip the per-page
>>>> operation without breaking the logic. However, this will introduce the
>>>> complicated mechanism and may has the overhead for other features. It
>>>> might not be worth it. It's hard to strike a balance between the
>>>> over-complicated mechanism with (probably) better performance and data
>>>> consistency with the page status. So, I would focus on the safety and
>>>> stable approach at first.
>>>
>>> Yes, it is most probably possible, but complexity, robustness and
>>> maintainability have to be considered as well.
>>>
>>> Thanks for implementing this approach (only deduplication without other
>>> optimizations) and evaluating it accordingly. It's certainly "cleaner", such
>>> that we only have to mess with unsharing and not with other
>>> accounting/pinning/mapcount thingies. But it also highlights how intrusive
>>> even this basic deduplication approach already is -- and that most benefits
>>> of the original approach requires even more complexity on top.
>>>
>>> I am not quite sure if the benefit is worth the price (I am not to decide
>>> and I would like to hear other options).
>>
>> I'm looking at the discussion of page table sharing in 2002 [1].
>> It looks like in 2002 ~ 2006, there also have some patches try to
>> improve fork().
>>
>> After that, I also saw one thread which is about another shared page
>> table patch's benchmark. I can't find the original patch though [2].
>> But, I found the probably same patch in 2005 [3], it also mentioned
>> the previous benchmark discussion:
>>
>> "
>> For those familiar with the shared page table patch I did a couple of years
>> ago, this patch does not implement copy-on-write page tables for private
>> mappings.  Analysis showed the cost and complexity far outweighed any
>> potential benefit.
>> "
> 
> Thanks for the pointer, interesting read. And my personal opinion is
> that part of that statement still hold true :)
> 
>>
>> However, it might be different right now. For example, the implemetation
>> . We have split page table lock now, so we don't have to consider the
>> page_table_share_lock thing. Also, presently, we have different use
>> cases (shells [2] v.s. VM cloning and fuzzing) to consider.


Oh, and because I stumbled over it, just as an interesting pointer on 
QEMU devel:

"[PATCH 00/10] Retire Fork-Based Fuzzing" [1]

[1] https://lore.kernel.org/all/20230205042951.3570008-1-alxndr@bu.edu/T/#u

-- 
Thanks,

David / dhildenb

