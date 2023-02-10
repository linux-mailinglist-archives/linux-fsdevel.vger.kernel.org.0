Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1569244F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 18:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjBJRUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 12:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjBJRU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:20:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC06F70CD2;
        Fri, 10 Feb 2023 09:20:27 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m2so7157792plg.4;
        Fri, 10 Feb 2023 09:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMbKVouMASLzJM91iOKsN1uPCY/b7K76uQnJa1gTFMw=;
        b=pFDCtIF1XgirwuX0oWehxHYtaQbsuvr1QwuxAo9k0F+3ptyVb1ST3SzENpLVfZVyWK
         KouQE1XmiRHq5ABrKjlx7a8Ddwdh5A5hhu900oPBnoqyz46bHHODNu3ifc07gRXVNBwC
         biamt+rATAqc8xARw9IU5FhCpOQ6onbbR0uoovVh4qQ1pCChm0qSKaRn4WgkXGuLd+WR
         YcfQorSWIcumYh3wu9nJyzrjEpiQbUfF/DfX+PAXBodlE9EVh4eoql2N/xgIJS7ovFKb
         cz2EV5Uk2kEQ3kqvAIxF7s0ZKRK0vgeOb5kSuQcNYjJNLTJBIeFvJsxHm8lWw9N8b0id
         jQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMbKVouMASLzJM91iOKsN1uPCY/b7K76uQnJa1gTFMw=;
        b=VDAfVqGl0d54O47q6ZFt7ObMBdfWXf+xSdXwoBiURzdgJdy0pQa/wuRq8T3YtT8cmH
         LQmY5I54b6IkroaC496tRS0k73E1qGYjtwIqTUQuqTA+WOW3EIvO9gi9uqsnUGmmMkTa
         oRK+hM3QHaG4MfCTP/UlwJfuhVw2lHJxpIW0ZFGAGotrsICcx39ofltBCLexvzVJ+4hu
         SiqJY73rihk4SsjWH9cZBY1XjjEJMmKFIqYXjAN4SXY2RSMor0Xo4eHxeyjDmjGqQ1Jh
         EIXAadWCipXqcrwGAfFOWS1bmUVZi7//63oqb/d5cQMkMH4IXQt7RvkspTALc8nNaCNv
         f4Sw==
X-Gm-Message-State: AO0yUKWqxo27fwgyaxFRtdoRXSYDQeWd0iW1kWubU0IjefoFG54OANl5
        I+yNRURE7H5HHNbIQjh1FM8=
X-Google-Smtp-Source: AK7set/22jYwlRoq3JJRkdhMuoVUH4dOoOiTm+bHbi6ug2EgKCKELtcfBHYA5wjVSaUoSMsnv5Z8Gg==
X-Received: by 2002:a17:902:dad0:b0:199:1f42:8bed with SMTP id q16-20020a170902dad000b001991f428bedmr5843680plx.12.1676049627175;
        Fri, 10 Feb 2023 09:20:27 -0800 (PST)
Received: from strix-laptop ([123.110.9.95])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b00188c9c11559sm1645994plb.1.2023.02.10.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:20:26 -0800 (PST)
Date:   Sat, 11 Feb 2023 01:20:10 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
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
Message-ID: <Y+Z8ymNYc+vJMBx8@strix-laptop>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:21:16AM -0500, Pasha Tatashin wrote:
> > > > Currently, copy-on-write is only used for the mapped memory; the child
> > > > process still needs to copy the entire page table from the parent
> > > > process during forking. The parent process might take a lot of time and
> > > > memory to copy the page table when the parent has a big page table
> > > > allocated. For example, the memory usage of a process after forking with
> > > > 1 GB mapped memory is as follows:
> > >
> > > For some reason, I was not able to reproduce performance improvements
> > > with a simple fork() performance measurement program. The results that
> > > I saw are the following:
> > >
> > > Base:
> > > Fork latency per gigabyte: 0.004416 seconds
> > > Fork latency per gigabyte: 0.004382 seconds
> > > Fork latency per gigabyte: 0.004442 seconds
> > > COW kernel:
> > > Fork latency per gigabyte: 0.004524 seconds
> > > Fork latency per gigabyte: 0.004764 seconds
> > > Fork latency per gigabyte: 0.004547 seconds
> > >
> > > AMD EPYC 7B12 64-Core Processor
> > > Base:
> > > Fork latency per gigabyte: 0.003923 seconds
> > > Fork latency per gigabyte: 0.003909 seconds
> > > Fork latency per gigabyte: 0.003955 seconds
> > > COW kernel:
> > > Fork latency per gigabyte: 0.004221 seconds
> > > Fork latency per gigabyte: 0.003882 seconds
> > > Fork latency per gigabyte: 0.003854 seconds
> > >
> > > Given, that page table for child is not copied, I was expecting the
> > > performance to be better with COW kernel, and also not to depend on
> > > the size of the parent.
> >
> > Yes, the child won't duplicate the page table, but fork will still
> > traverse all the page table entries to do the accounting.
> > And, since this patch expends the COW to the PTE table level, it's not
> > the mapped page (page table entry) grained anymore, so we have to
> > guarantee that all the mapped page is available to do COW mapping in
> > the such page table.
> > This kind of checking also costs some time.
> > As a result, since the accounting and the checking, the COW PTE fork
> > still depends on the size of the parent so the improvement might not
> > be significant.
> 
> The current version of the series does not provide any performance
> improvements for fork(). I would recommend removing claims from the
> cover letter about better fork() performance, as this may be
> misleading for those looking for a way to speed up forking. In my

From v3 to v4, I changed the implementation of the COW fork() part to do
the accounting and checking. At the time, I also removed most of the
descriptions about the better fork() performance. Maybe it's not enough
and still has some misleading. I will fix this in the next version.
Thanks.

> case, I was looking to speed up Redis OSS, which relies on fork() to
> create consistent snapshots for driving replicates/backups. The O(N)
> per-page operation causes fork() to be slow, so I was hoping that this
> series, which does not duplicate the VA during fork(), would make the
> operation much quicker.

Indeed, at first, I tried to avoid the O(N) per-page operation by
deferring the accounting and the swap stuff to the page fault. But,
as I mentioned, it's not suitable for the mainline.

Honestly, for improving the fork(), I have an idea to skip the per-page
operation without breaking the logic. However, this will introduce the
complicated mechanism and may has the overhead for other features. It
might not be worth it. It's hard to strike a balance between the
over-complicated mechanism with (probably) better performance and data
consistency with the page status. So, I would focus on the safety and
stable approach at first.

> > Actually, at the RFC v1 and v2, we proposed the version of skipping
> > those works, and we got a significant improvement. You can see the
> > number from RFC v2 cover letter [1]:
> > "In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
> > for normal fork"
> 
> I suspect the 93% improvement (when the mapcount was not updated) was
> only for VAs with 4K pages. With 2M mappings this series did not
> provide any benefit is this correct?

Yes. In this case, the COW PTE performance is similar to the normal
fork().

> >
> > However, it might break the existing logic of the refcount/mapcount of
> > the page and destabilize the system.
> 
> This makes sense.

;)

Thanks,
Chih-En Lin
