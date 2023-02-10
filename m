Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09676925FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 20:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjBJTCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 14:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjBJTCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:02:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6EA7CCAB;
        Fri, 10 Feb 2023 11:02:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id be8so7442013plb.7;
        Fri, 10 Feb 2023 11:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1cOhpJR3Kvbh9HZADpLcoUR0+gYgMIFfLat/AASZX0=;
        b=UQ+9s6t4bnN7xq/qk4qKXpVS0fA5hjb9cQysWiQXGOw9sPbgxVC1j+th2xjSq94/ed
         eRvdsolTfVMY3PoljYoCbTkdsmOI8pvt+k70XVKF4ZqMRLlu+DodzWwx+vdeWlEa7J81
         eEszcT7Saa8bO3NougBlhx1qn4jvY2dYx/Wc8Q1OXr8dlpSIxSRjj5bHDYfgPiN8zqnt
         0wVhAfhnQ73XAbCenDaLigho9YNDBCcGCjjlDcfpa1NWNuSCqNPo/SGwGqIbKQaBJWVS
         1+0istMIS9kDB6T79b0rBV8Fz1/VvuIFFvUHJ0vpy+QNoR0FI79bMGaKj2PBYpZGl1yg
         KcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1cOhpJR3Kvbh9HZADpLcoUR0+gYgMIFfLat/AASZX0=;
        b=bQaDvIfUqoyf2Qeri0O8Rrp7h2Opuyn3BPU86Xt75sYB1rtcGWi6LAqnOAM/LAey7n
         sbJGg+dO8SbxfJP+mMSZxgf5IF6PahlK+MmRF2Hbr2Qt9qLSLrPFMSuXe/DsZVTw/rxS
         9b+427DlAjTmtYUWS7xtRqWqo17y7B0oqO4p0UKw59p0RnMnsC6saG1rN/qDBK+zRsw8
         g58U161GJInNhVDMg+Dw8gpEhkx9sE/d7ZP2zumw+1hI+w9DNjFQlU0sBJ92bUiq8c2T
         Uc4kANgdijJtri4TaY7d8ABrMQd1Z0gQ0W5gLFBei8igvXV+rttD0SUa+qF6w4FwE3Wb
         7XiQ==
X-Gm-Message-State: AO0yUKUnDc5rfWWkTIZHLG1y2+EMtwrH05gWPDeNBbCWM6A6/FYHqRNL
        fxJLYy8TGaJorFaQPEfRX9U=
X-Google-Smtp-Source: AK7set/dbUQDWhmep7CTi9/LcTRrHRCnUiwSqFkMOSYdaaHV8nzu9SC6LSieQdGiQ7i/nPcO7dHyMQ==
X-Received: by 2002:a05:6a20:e488:b0:b5:389e:870e with SMTP id ni8-20020a056a20e48800b000b5389e870emr13945541pzb.4.1676055756388;
        Fri, 10 Feb 2023 11:02:36 -0800 (PST)
Received: from zhienlin-MacBook-Pro.local ([123.110.9.95])
        by smtp.gmail.com with ESMTPSA id i5-20020a63a845000000b00477bfac06b7sm3352172pgp.34.2023.02.10.11.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:02:35 -0800 (PST)
Date:   Sat, 11 Feb 2023 03:02:17 +0800
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
Message-ID: <Y+aUuVLEXmRhHlC9@zhienlin-MacBook-Pro.local>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Z8ymNYc+vJMBx8@strix-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 11, 2023 at 01:20:10AM +0800, Chih-En Lin wrote:
> On Fri, Feb 10, 2023 at 11:21:16AM -0500, Pasha Tatashin wrote:
> > > > > Currently, copy-on-write is only used for the mapped memory; the child
> > > > > process still needs to copy the entire page table from the parent
> > > > > process during forking. The parent process might take a lot of time and
> > > > > memory to copy the page table when the parent has a big page table
> > > > > allocated. For example, the memory usage of a process after forking with
> > > > > 1 GB mapped memory is as follows:
> > > >
> > > > For some reason, I was not able to reproduce performance improvements
> > > > with a simple fork() performance measurement program. The results that
> > > > I saw are the following:
> > > >
> > > > Base:
> > > > Fork latency per gigabyte: 0.004416 seconds
> > > > Fork latency per gigabyte: 0.004382 seconds
> > > > Fork latency per gigabyte: 0.004442 seconds
> > > > COW kernel:
> > > > Fork latency per gigabyte: 0.004524 seconds
> > > > Fork latency per gigabyte: 0.004764 seconds
> > > > Fork latency per gigabyte: 0.004547 seconds
> > > >
> > > > AMD EPYC 7B12 64-Core Processor
> > > > Base:
> > > > Fork latency per gigabyte: 0.003923 seconds
> > > > Fork latency per gigabyte: 0.003909 seconds
> > > > Fork latency per gigabyte: 0.003955 seconds
> > > > COW kernel:
> > > > Fork latency per gigabyte: 0.004221 seconds
> > > > Fork latency per gigabyte: 0.003882 seconds
> > > > Fork latency per gigabyte: 0.003854 seconds
> > > >
> > > > Given, that page table for child is not copied, I was expecting the
> > > > performance to be better with COW kernel, and also not to depend on
> > > > the size of the parent.
> > >
> > > Yes, the child won't duplicate the page table, but fork will still
> > > traverse all the page table entries to do the accounting.
> > > And, since this patch expends the COW to the PTE table level, it's not
> > > the mapped page (page table entry) grained anymore, so we have to
> > > guarantee that all the mapped page is available to do COW mapping in
> > > the such page table.
> > > This kind of checking also costs some time.
> > > As a result, since the accounting and the checking, the COW PTE fork
> > > still depends on the size of the parent so the improvement might not
> > > be significant.
> > 
> > The current version of the series does not provide any performance
> > improvements for fork(). I would recommend removing claims from the
> > cover letter about better fork() performance, as this may be
> > misleading for those looking for a way to speed up forking. In my
> 
> From v3 to v4, I changed the implementation of the COW fork() part to do

Sorry, it's "RFC v2 to v3".

> the accounting and checking. At the time, I also removed most of the
> descriptions about the better fork() performance. Maybe it's not enough
> and still has some misleading. I will fix this in the next version.
> Thanks.

Thanks,
Chih-En Lin
