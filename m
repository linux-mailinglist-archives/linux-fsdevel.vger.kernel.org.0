Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB3429EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhJLHjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 03:39:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34702 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhJLHi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:38:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA78A22150;
        Tue, 12 Oct 2021 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634024216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4nD2ISDAf2TQ3t3VfHUt8r1cCwete3O5TAZWbE4kE7M=;
        b=C6A/Psx27DoZPrXya2lWB+l7IwGjlMGmwcL8xgtP+rlT5//7r1Ou5LMxdw1roHmjKf3q7F
        81xK5su5B8gm1HWP+lEF6NWpiv2Ko43ifsKNqSqqA1lnIYYJT+AHiZufyRXlgf0cF/5ivF
        Cpowdql7MZF6RmK+IF0F45XrHXvkJIE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 854B8A3B89;
        Tue, 12 Oct 2021 07:36:54 +0000 (UTC)
Date:   Tue, 12 Oct 2021 09:36:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <YWU7FELcxIFmr9uz@dhcp22.suse.cz>
References: <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
 <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook>
 <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 11-10-21 18:20:25, Suren Baghdasaryan wrote:
> On Mon, Oct 11, 2021 at 6:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 1:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 08-10-21 13:58:01, Kees Cook wrote:
> > > > - Strings for "anon" specifically have no required format (this is good)
> > > >   it's informational like the task_struct::comm and can (roughly)
> > > >   anything. There's no naming convention for memfds, AF_UNIX, etc. Why
> > > >   is one needed here? That seems like a completely unreasonable
> > > >   requirement.
> > >
> > > I might be misreading the justification for the feature. Patch 2 is
> > > talking about tools that need to understand memeory usage to make
> > > further actions. Also Suren was suggesting "numbering convetion" as an
> > > argument against.
> > >
> > > So can we get a clear example how is this being used actually? If this
> > > is just to be used to debug by humans than I can see an argument for
> > > human readable form. If this is, however, meant to be used by tools to
> > > make some actions then the argument for strings is much weaker.
> >
> > The simplest usecase is when we notice that a process consumes more
> > memory than usual and we do "cat /proc/$(pidof my_process)/maps" to
> > check which area is contributing to this growth. The names we assign
> > to anonymous areas are descriptive enough for a developer to get an
> > idea where the increased consumption is coming from and how to proceed
> > with their investigation.
> > There are of course cases when tools are involved, but the end-user is
> > always a human and the final report should contain easily
> > understandable data.

OK, it would have been much more preferable to be explicit about this
main use case from the very beginning. Just to make sure we are at the
same page. Is the primary usecase usage and bug reporting?

My initial understanding was that at userspace managed memory management
could make an educated guess about targeted reclaim (e.g. MADV_{FREE,COLD,PAGEOUT}
for cached data in memory like uncompressed images/data). Such a usecase
would clearly require a standardized id/naming convention to be
application neutral.

> > IIUC, the main argument here is whether the userspace can provide
> > tools to perform the translations between ids and names, with the
> > kernel accepting and reporting ids instead of strings. Technically
> > it's possible, but to be practical that conversion should be fast
> > because we will need to make name->id conversion potentially for each
> > mmap. On the consumer side the performance is not as critical, but the
> > fact that instead of dumping /proc/$pid/maps we will have to parse the
> > file, do id->name conversion and replace all [anon:id] with
> > [anon:name] would be an issue when we do that in bulk, for example
> > when collecting system-wide data for a bugreport.

Whether you use ids or human readable strings you still have to
understand the underlying meaning to make any educated guess. Let me
give you an example. Say I have an application with a memory leak. Right
now I can only tell that it is anonymous memory growing but it is not
clear who uses that anonymous. You are adding a means to tell different
users appart. That is really helpful. Now I know this is an anon
user 1234 or MySuperAnonMemory. Neither of the will not tell me more
without a id/naming convention or reading the code. A convention can be
useful for the most common users (e.g. a specific allocator) but I am
rather dubious there are many more that would be _generally_ recognized
without some understanding of the said application.

Maybe the situation in Android is different because the runtime is more
coupled but is it reasonable to expect any common naming conventions for
general Linux platforms?

I am slightly worried that we have spent way too much time talking
specifics about id->name translation rather than the actual usability
of the token.
-- 
Michal Hocko
SUSE Labs
