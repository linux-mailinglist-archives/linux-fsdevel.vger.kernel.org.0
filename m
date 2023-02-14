Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC237696C15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 18:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjBNRyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 12:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjBNRyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:54:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF91C2D174;
        Tue, 14 Feb 2023 09:54:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso8746351pjf.4;
        Tue, 14 Feb 2023 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a09WllYZDnimLE8v2wTR3vxHfJ4ytKtsiaLki5l7X90=;
        b=Qzg38EyqGAaADeTuF7AOzhFZ5UsLAmJ0g5L8w/2P0NokzD/mBFYc/xSZMycMBKS0Z5
         wupb9ekS9ypcL8sFebok6R3xKRsZhP8u+iaa12pEciXf21c8ZXJiOctYQYk9LVGEYCVu
         g3DGijIIyVE/ZMg8N79Qsna8x3qme/cmCgDsYVFxGbW9qE/xs2r0A9iTPcsosueeEqTu
         Jjr4TM2Qc8KOxzHBWYhxdTXRrHBL3CQ+Nv28xLmFXnyOa56lPyjadVTJqgogsd17m5P4
         o5bGV64r9s9UEghXDAd2No6h5gbin7zTwrT5EMqmeWba/l76WEkimFknICZVPr71c6ka
         FzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a09WllYZDnimLE8v2wTR3vxHfJ4ytKtsiaLki5l7X90=;
        b=XX1NXOMKTDv01vCelgr8njCfwMkaT4GCkIEtorgZNfSOSnd6jRYgVgS1n0xwP2lWLv
         6ZmT1MFxu2h0aqZqEaF9HeBKTMUthtU99TUN1xx/UayZlqxpBT/oD1yR/1qUq9IXJT6P
         C2cHQOoFNU0Z3id28myRo3kwjNQgTjRvZdLNZiHZPifXYnu15uzfT0y6ig9pi/dy3nim
         1rAmDeCojbRFCM1NxpXV2B2hO2ylwYGEyOrwYlowiqBlRonYz8WF6AvK8Lh7CgPL5Zyq
         8UQcY6rZkZzHJMinVzrvFDdKrOUn0fap83HKU87EJgvci2ixAev1CRJLT7YHMVIC/GzD
         OkuQ==
X-Gm-Message-State: AO0yUKXlSoZB5O1ojFASw/bF7jnubY1SPX6r/4W0nM5GSP22W05HiPRR
        telZFw3e/5pqCZesElxQ1fA=
X-Google-Smtp-Source: AK7set/RGBzMrGawJ2NUjzEXa9UQINjHfKyuBo/buaEy0zUQBjImCtSLL6T8Fy1l0Il06cXLI1p46w==
X-Received: by 2002:a17:902:e84a:b0:198:fded:3b69 with SMTP id t10-20020a170902e84a00b00198fded3b69mr4275449plg.53.1676397289002;
        Tue, 14 Feb 2023 09:54:49 -0800 (PST)
Received: from strix-laptop (2001-b011-20e0-1465-11be-7287-d61f-f938.dynamic-ip6.hinet.net. [2001:b011:20e0:1465:11be:7287:d61f:f938])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709028a8400b001993411d66bsm10427907plo.272.2023.02.14.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 09:54:48 -0800 (PST)
Date:   Wed, 15 Feb 2023 01:54:38 +0800
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
Message-ID: <Y+vK3tXWHCgTC8qk@strix-laptop>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
 <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
 <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
 <CA+CK2bAWnzqKDTjBbxXOvURwr7nWmf8q-mzD1x-ztwbWVQBQKA@mail.gmail.com>
 <Y+Z8ymNYc+vJMBx8@strix-laptop>
 <62c44d12-933d-ee66-ef50-467cd8d30a58@redhat.com>
 <Y+uv3iTajGoOuNMO@strix-laptop>
 <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a02714ee-3223-ba53-09eb-33f7b03ef038@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 05:58:45PM +0100, David Hildenbrand wrote:
> 
> > > > 
> > > > Honestly, for improving the fork(), I have an idea to skip the per-page
> > > > operation without breaking the logic. However, this will introduce the
> > > > complicated mechanism and may has the overhead for other features. It
> > > > might not be worth it. It's hard to strike a balance between the
> > > > over-complicated mechanism with (probably) better performance and data
> > > > consistency with the page status. So, I would focus on the safety and
> > > > stable approach at first.
> > > 
> > > Yes, it is most probably possible, but complexity, robustness and
> > > maintainability have to be considered as well.
> > > 
> > > Thanks for implementing this approach (only deduplication without other
> > > optimizations) and evaluating it accordingly. It's certainly "cleaner", such
> > > that we only have to mess with unsharing and not with other
> > > accounting/pinning/mapcount thingies. But it also highlights how intrusive
> > > even this basic deduplication approach already is -- and that most benefits
> > > of the original approach requires even more complexity on top.
> > > 
> > > I am not quite sure if the benefit is worth the price (I am not to decide
> > > and I would like to hear other options).
> > 
> > I'm looking at the discussion of page table sharing in 2002 [1].
> > It looks like in 2002 ~ 2006, there also have some patches try to
> > improve fork().
> > 
> > After that, I also saw one thread which is about another shared page
> > table patch's benchmark. I can't find the original patch though [2].
> > But, I found the probably same patch in 2005 [3], it also mentioned
> > the previous benchmark discussion:
> > 
> > "
> > For those familiar with the shared page table patch I did a couple of years
> > ago, this patch does not implement copy-on-write page tables for private
> > mappings.  Analysis showed the cost and complexity far outweighed any
> > potential benefit.
> > "
> 
> Thanks for the pointer, interesting read. And my personal opinion is that
> part of that statement still hold true :)

;)

> > 
> > However, it might be different right now. For example, the implemetation
> > . We have split page table lock now, so we don't have to consider the
> > page_table_share_lock thing. Also, presently, we have different use
> > cases (shells [2] v.s. VM cloning and fuzzing) to consider.
> > 
> > Nonetheless, I still think the discussion can provide some of the mind
> > to us.
> > 
> > BTW, It seems like the 2002 patch [1] is different from the 2002 [2]
> > and 2005 [3].
> > 
> > [1] https://lkml.iu.edu/hypermail/linux/kernel/0202.2/0102.html
> > [2] https://lore.kernel.org/linux-mm/3E02FACD.5B300794@digeo.com/
> > [3] https://lore.kernel.org/linux-mm/7C49DFF721CB4E671DB260F9@%5B10.1.1.4%5D/T/#u
> > 
> > > My quick thoughts after skimming over the core parts of this series
> > > 
> > > (1) forgetting to break COW on a PTE in some pgtable walker feels quite
> > >      likely (meaning that it might be fairly error-prone) and forgetting
> > >      to break COW on a PTE table, accidentally modifying the shared
> > >      table.
> > 
> > Maybe I should also handle arch/ and others parts.
> > I will keep looking at where I missed.
> 
> One could add sanity checks when modifying a PTE while the PTE table is
> still marked shared ... but I guess there are some valid reasons where we
> might want to modify shared PTE tables (rmap).

Sounds good for adding sanity checks. I will look at this.
One of the valid reasons that come to my head might be the
referenced bit (rmap).

> > 
> > > (2) break_cow_pte() can fail, which means that we can fail some
> > >      operations (possibly silently halfway through) now. For example,
> > >      looking at your change_pte_range() change, I suspect it's wrong.
> > 
> > Maybe I should add WARN_ON() and skip the failed COW PTE.
> 
> One way or the other we'll have to handle it. WARN_ON() sounds wrong for
> handling OOM situations (e.g., if only that cgroup is OOM).

Or we should do the same thing like you mentioned:
"
For example, __split_huge_pmd() is currently not able to report a 
failure. I assume that we could sleep in there. And if we're not able to 
allocate any memory in there (with sleeping), maybe the process should 
be zapped either way by the OOM killer.
"

But instead of zapping the process, we just skip the failed COW PTE.
I don't think the user will expect their process to be killed by
changing the protection.

> > 
> > > (3) handle_cow_pte_fault() looks quite complicated and needs quite some
> > >      double-checking: we temporarily clear the PMD, to reset it
> > >      afterwards. I am not sure if that is correct. For example, what
> > >      stops another page fault stumbling over that pmd_none() and
> > >      allocating an empty page table? Maybe there are some locking details
> > >      missing or they are very subtle such that we better document them. I
> > >     recall that THP played quite some tricks to make such cases work ...
> > 
> > I think that holding mmap_write_lock may be enough (I added
> > mmap_assert_write_locked() in the fault function btw). But, I might
> > be wrong. I will look at the THP stuff to see how they work. Thanks.
> > 
> 
> Ehm, but page faults don't hold the mmap lock writable? And so are other
> callers, like MADV_DONTNEED or MADV_FREE.
> 
> handle_pte_fault()->handle_pte_fault()->mmap_assert_write_locked() should
> bail out.
> 
> Either I am missing something or you didn't test with lockdep enabled :)

You're right. I thought I enabled the lockdep.
And, why do I have the page fault will handle the mmap lock writable in my mind.
The page fault holds the mmap lock readable instead of writable.
;-)

I should check/test all the locks again.
Thanks.

> 
> Note that there are upstream efforts to use only a VMA lock (and some people
> even want to perform some page faults only protected by RCU).

I saw the discussion (https://lwn.net/Articles/906852/) before.
If the page fault handler only uses a VMA lock, handle_cow_pte_fault() might not
be affected since it only takes one VMA at a time. handle_cow_pte_fault() just
allocate the PTE and copy the COW mapping entries to the new one.
It's alredy handle the checking and accounting in copy_cow_pte_range().

But, if we decide to skip the per-page operation during fork().
We should handle the VMA lock (or RCU) for the accounting and other
stuff. It might be more complicated than before...

Thanks,
Chih-En Lin
