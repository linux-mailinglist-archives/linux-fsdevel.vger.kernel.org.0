Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C327D696C1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBNR4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBNR4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:56:42 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3232D16C;
        Tue, 14 Feb 2023 09:56:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 7so10778137pga.1;
        Tue, 14 Feb 2023 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vJaoDSitwkTGSgQwWnQeK+EQqLoSNY0n4EyW8soc+w=;
        b=Igbj7a9tepqc59z5eRzxZcMoUokHgeSoMtRBOizFx3CKNJkKuTCiLi0xOQYzOihtn6
         /u7z2gVsfqx+czaQ3Hmk2Sgd3FgyAFcrzTpUmMZ/RpllRncXKEi3oxrQxvNuTFXvcB9o
         uaey0FvFkdcPMe0UV9eNTdSUth3l/exzp5Y01wBzPwIN/bQos50PoaEHniUyFhGlcOZk
         mATeNl56n9QhrQUj2HfZOisJ4ihV4of3B3/FpGxTeFRepE4IiyfWYEoCRZiXJRS3NxBc
         weP2DJ/WdSd7dfMhRPKSu4GygZ4hPwmJqG5xwQLK0UxUWaveJQoeuDfT9TKKn8RnGl+H
         1kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vJaoDSitwkTGSgQwWnQeK+EQqLoSNY0n4EyW8soc+w=;
        b=yuyl5BVUyAo1GbSWn5EOatU47uZNMGGUXazmc/8bAnAIss/rfibqAyb8Dme9B429le
         rWX50uwQ6y1bPBIItLyzLJSc93bm84dyGLNK5znL0Q7w2/PZ5BojAlZs0dmMHYbv5zD2
         CLY8s8khKoewl4dJVvpzLjeSKYE9TZi79yd0/xrKfF7c1RQaJ5S5ZEtlL4XU1x/9W4tK
         xAKKkiIBpF5jXLGvl20l8+Kv5nVNki21qTg/OztU3OozuFKAz/maVtJDa0UDFi6aux//
         08HpYZFt1p8U5QMd1+VcVhINYgQY/flvy8AWDgyVP7be6SQfsBDGxEvcSQHl5njX2nWS
         Nx5g==
X-Gm-Message-State: AO0yUKXctyqqGn5RMPK8jETpHmv1qozdGkfqRG++uEcO8nx8SBzbhe8Q
        6Vzk52DLXyH/mTefX4Y0v1Q=
X-Google-Smtp-Source: AK7set8axHlRtyebWLewiILfyIm+eC4C+3CI43qb6+37raWc7AqWWJAfImHLAj798iIJo6ilumNtFg==
X-Received: by 2002:a62:64cb:0:b0:5a8:380d:7822 with SMTP id y194-20020a6264cb000000b005a8380d7822mr3031237pfb.23.1676397401070;
        Tue, 14 Feb 2023 09:56:41 -0800 (PST)
Received: from strix-laptop (2001-b011-20e0-1465-11be-7287-d61f-f938.dynamic-ip6.hinet.net. [2001:b011:20e0:1465:11be:7287:d61f:f938])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78717000000b005a8db4e3ecesm1674976pfo.69.2023.02.14.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:56:40 -0800 (PST)
Date:   Wed, 15 Feb 2023 01:56:30 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
Message-ID: <Y+vLTmGLJP8pR1BG@strix-laptop>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
 <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <Y+uv3iTajGoOuNMO@strix-laptop>
 <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
 <1bee97ef-7632-b1bf-f042-29b97882bfb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bee97ef-7632-b1bf-f042-29b97882bfb6@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 06:03:58PM +0100, David Hildenbrand wrote:
> On 14.02.23 17:58, David Hildenbrand wrote:
> > 
> > > > > 
> > > > > Honestly, for improving the fork(), I have an idea to skip the per-page
> > > > > operation without breaking the logic. However, this will introduce the
> > > > > complicated mechanism and may has the overhead for other features. It
> > > > > might not be worth it. It's hard to strike a balance between the
> > > > > over-complicated mechanism with (probably) better performance and data
> > > > > consistency with the page status. So, I would focus on the safety and
> > > > > stable approach at first.
> > > > 
> > > > Yes, it is most probably possible, but complexity, robustness and
> > > > maintainability have to be considered as well.
> > > > 
> > > > Thanks for implementing this approach (only deduplication without other
> > > > optimizations) and evaluating it accordingly. It's certainly "cleaner", such
> > > > that we only have to mess with unsharing and not with other
> > > > accounting/pinning/mapcount thingies. But it also highlights how intrusive
> > > > even this basic deduplication approach already is -- and that most benefits
> > > > of the original approach requires even more complexity on top.
> > > > 
> > > > I am not quite sure if the benefit is worth the price (I am not to decide
> > > > and I would like to hear other options).
> > > 
> > > I'm looking at the discussion of page table sharing in 2002 [1].
> > > It looks like in 2002 ~ 2006, there also have some patches try to
> > > improve fork().
> > > 
> > > After that, I also saw one thread which is about another shared page
> > > table patch's benchmark. I can't find the original patch though [2].
> > > But, I found the probably same patch in 2005 [3], it also mentioned
> > > the previous benchmark discussion:
> > > 
> > > "
> > > For those familiar with the shared page table patch I did a couple of years
> > > ago, this patch does not implement copy-on-write page tables for private
> > > mappings.  Analysis showed the cost and complexity far outweighed any
> > > potential benefit.
> > > "
> > 
> > Thanks for the pointer, interesting read. And my personal opinion is
> > that part of that statement still hold true :)
> > 
> > > 
> > > However, it might be different right now. For example, the implemetation
> > > . We have split page table lock now, so we don't have to consider the
> > > page_table_share_lock thing. Also, presently, we have different use
> > > cases (shells [2] v.s. VM cloning and fuzzing) to consider.
> 
> 
> Oh, and because I stumbled over it, just as an interesting pointer on QEMU
> devel:
> 
> "[PATCH 00/10] Retire Fork-Based Fuzzing" [1]
> 
> [1] https://lore.kernel.org/all/20230205042951.3570008-1-alxndr@bu.edu/T/#u

Thanks for the information.
It's interesting.

Thanks,
Chih-En Lin
