Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF2696D93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 20:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjBNTGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 14:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBNTGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:06:53 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35659AF;
        Tue, 14 Feb 2023 11:06:52 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 24so10903367pgt.7;
        Tue, 14 Feb 2023 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tR/3i49sq5hz9XtCZE+PWBTV406btHq8pkhmC0xJBgE=;
        b=kRXCfHvnVjapwi015b0xlR827EdxddRsUAxsIADH90lYdHsP3qc5xUijELcU47v5DP
         RKhwxn/KRl3n6lCNAchGzTRGaXFTazeQUYYDaLbgg/4v9jjtNlV+eMiQEkHmKx/ELiMa
         eFJAbuQ2f2QTiy/inbPj6O3YLNor8m7xNX3yCXP8j5nvVi151z1mZTF5eZzazTvgpplt
         2NlX6HDlCapdFRNgDhjHarJCwA0doM2TJJTXcytjM4zFHphszSKaFbrAJNP8xgmk1JLX
         aKncV6CBNTaSkfXSKXWx/HwNUD/7wIcUMIVjk3jYSkL57Y5VGcRZX00EZL/f3/vhRdHK
         baXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR/3i49sq5hz9XtCZE+PWBTV406btHq8pkhmC0xJBgE=;
        b=yC6ZxBjsksztdIn7IuAmSNCBwm1bkmAiciRdhkWdbNxyngvJCYhRAYFtzVXU7O6uug
         2CkUhLjBL0ZSPGL0BRfeycSWQ612geFGlVtLibnPyplQBACcYV22yARWg+58YNS21stL
         nw1lctaZi3s6db2BxScsFjy45m8E8kYGOwtmvY6d3gpE/n5yJnDNQ2TaUfZINXAP7UF6
         rY+t1x+m/ZefHUO0mdTYWkRvEoUUrtZF5Jb1N8Rvlw0T3zfPa0+jQ4mNQT8gYH69rudF
         f6j8ZYmfWT3gbhTVU7L0YTzE5FBWSj8UldjClkzfyuspJeU+5bY0cZPOsN42sMBcjr7k
         m5ew==
X-Gm-Message-State: AO0yUKUoLdnIKU/jTW+4o3uFpPJCrchSjs0UXJtr2xkZS5QvJc0nkzSD
        tczPsINi7FNQ2N011M00+8Q=
X-Google-Smtp-Source: AK7set9KDqtSpLuf4DjmW649rLWZQ9WMurHdl9XlWBl5a0mpXl+jxH6VIQhqsW0P4nmezUIMvrdTSQ==
X-Received: by 2002:a05:6a00:cf:b0:5a8:ac19:8f42 with SMTP id e15-20020a056a0000cf00b005a8ac198f42mr2623706pfj.14.1676401610866;
        Tue, 14 Feb 2023 11:06:50 -0800 (PST)
Received: from strix-laptop (2001-b011-20e0-1465-11be-7287-d61f-f938.dynamic-ip6.hinet.net. [2001:b011:20e0:1465:11be:7287:d61f:f938])
        by smtp.gmail.com with ESMTPSA id n19-20020a62e513000000b005a852450b14sm10172153pff.183.2023.02.14.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:06:50 -0800 (PST)
Date:   Wed, 15 Feb 2023 03:06:39 +0800
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
Message-ID: <Y+vbv2O6GtlKAJll@strix-laptop>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
 <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <Y+uv3iTajGoOuNMO@strix-laptop>
 <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
 <Y+vK3tXWHCgTC8qk@strix-laptop>
 <28f1e75a-a1fc-a172-3628-83575e387f9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f1e75a-a1fc-a172-3628-83575e387f9a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 06:59:50PM +0100, David Hildenbrand wrote:
> On 14.02.23 18:54, Chih-En Lin wrote:
> > > > 
> > > > > (2) break_cow_pte() can fail, which means that we can fail some
> > > > >       operations (possibly silently halfway through) now. For example,
> > > > >       looking at your change_pte_range() change, I suspect it's wrong.
> > > > 
> > > > Maybe I should add WARN_ON() and skip the failed COW PTE.
> > > 
> > > One way or the other we'll have to handle it. WARN_ON() sounds wrong for
> > > handling OOM situations (e.g., if only that cgroup is OOM).
> > 
> > Or we should do the same thing like you mentioned:
> > "
> > For example, __split_huge_pmd() is currently not able to report a
> > failure. I assume that we could sleep in there. And if we're not able to
> > allocate any memory in there (with sleeping), maybe the process should
> > be zapped either way by the OOM killer.
> > "
> > 
> > But instead of zapping the process, we just skip the failed COW PTE.
> > I don't think the user will expect their process to be killed by
> > changing the protection.
> 
> The process is consuming more memory than it is capable of consuming. The
> process most probably would have died earlier without the PTE optimization.
> 
> But yeah, it all gets tricky ...
> 
> > 
> > > > 
> > > > > (3) handle_cow_pte_fault() looks quite complicated and needs quite some
> > > > >       double-checking: we temporarily clear the PMD, to reset it
> > > > >       afterwards. I am not sure if that is correct. For example, what
> > > > >       stops another page fault stumbling over that pmd_none() and
> > > > >       allocating an empty page table? Maybe there are some locking details
> > > > >       missing or they are very subtle such that we better document them. I
> > > > >      recall that THP played quite some tricks to make such cases work ...
> > > > 
> > > > I think that holding mmap_write_lock may be enough (I added
> > > > mmap_assert_write_locked() in the fault function btw). But, I might
> > > > be wrong. I will look at the THP stuff to see how they work. Thanks.
> > > > 
> > > 
> > > Ehm, but page faults don't hold the mmap lock writable? And so are other
> > > callers, like MADV_DONTNEED or MADV_FREE.
> > > 
> > > handle_pte_fault()->handle_pte_fault()->mmap_assert_write_locked() should
> > > bail out.
> > > 
> > > Either I am missing something or you didn't test with lockdep enabled :)
> > 
> > You're right. I thought I enabled the lockdep.
> > And, why do I have the page fault will handle the mmap lock writable in my mind.
> > The page fault holds the mmap lock readable instead of writable.
> > ;-)
> > 
> > I should check/test all the locks again.
> > Thanks.
> 
> Note that we have other ways of traversing page tables, especially, using
> the rmap which does not hold the mmap lock. Not sure if there are similar
> issues when suddenly finding no page table where there logically should be
> one. Or when a page table gets replaced and modified, while rmap code still
> walks the shared copy. Hm.

It seems like I should take carefully for the page table entry in page
fault with rmap. ;)
While the rmap code walks the page table, it will hold the pt lock.
So, maybe I should hold the old (shared) PTE table's lock in
handle_cow_pte_fault() all the time.

Thanks,
Chih-En Lin
