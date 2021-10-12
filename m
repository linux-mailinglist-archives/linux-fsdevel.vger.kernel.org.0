Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CD42ABE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhJLS2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhJLS2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:28:48 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6564C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 11:26:46 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c7so20282070qka.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UTuSq4pUiA+lEbguKdAALIojpT52sPH6If+YjkHNeQk=;
        b=0VGUhp8rfAYh5i2ID6ejSb31wvZKXwBP2ikdcYiyNZDLb52wiJKT8E8mZ7D6P2T2aO
         T8YT3281DZm0X7na/m1UZbkOy8LfbYQJrgo6GjyLk7r1unw/EwelmR89447vwuH+PcV6
         GWeavNsaJ0KokPwmAqJpZN6iXbTM7YvKyEYMQ9xdSLic6ENDAhIbilbAlUhcZkOhXWPM
         EPsBasZbFrlPaLp0UiKdCtM1ULi6hGSvN/BbZaNBbGoayHRrZsCVtXJBz9Fb0evZfcYZ
         MOiTknGB2T05zFSD0EPWC/e1AQYKxrCITmCoRLSV9z+s2+R+7en/O5gvFz7UEac7GEfW
         cPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UTuSq4pUiA+lEbguKdAALIojpT52sPH6If+YjkHNeQk=;
        b=aH+n5vqvrYQyL2Lat6anCcas+224HVpPmw+4VRwzFdzQD6laKG3H+NAcQw6ESxPL2N
         H5jmBpxO0S/fK2lcQoffb2UOL5Bk814cSEZ3614xovjYhdOk7wKyCF/qvDJLAufVBxWu
         oi1cjVpVsAwcFpp1HJfxjxJ0FrOTaeqhS1s0UBRHbhgmEYR6Zh6eyXGT6RXNf5LYqmL/
         mCVAWF1IQ/diDyhh7pozkpvyQ4kD5q2O9Exf37C5p+VP+enIo/q/1VSepR6drUb2yzgE
         vwrh+TYbBHW9+HxGozAeZAnkHfB4J4KuELLNIgd1g14KPQ98Xi0F2BE0OhWX3tWZENQq
         Gzjw==
X-Gm-Message-State: AOAM531bu3W0M2GEmNeVKEU57rMlOjWAD4xvOHLihjmIHY/drLuSTIaI
        g+xIu5IKp3XMeBgyBuhm/rIs4w==
X-Google-Smtp-Source: ABdhPJyIGKWkZNgBeo4x1xYLqMnW+mHsUQ4qQbb22DOfdPjwgy6Sbpkn6u/PRV2Qrzzp5A7pP2Ve4A==
X-Received: by 2002:a05:620a:1a12:: with SMTP id bk18mr11319299qkb.266.1634063206025;
        Tue, 12 Oct 2021 11:26:46 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b20sm6579357qtt.2.2021.10.12.11.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:26:45 -0700 (PDT)
Date:   Tue, 12 Oct 2021 14:26:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
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
Message-ID: <YWXTZOXQ/NpoDJFI@cmpxchg.org>
References: <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
 <YV/mhyWH1ZwWazdE@dhcp22.suse.cz>
 <202110081344.FE6A7A82@keescook>
 <YWP3c/bozz5npQ8O@dhcp22.suse.cz>
 <CAJuCfpHQVMM4+6Lm_EnFk06+KrOjSjGA19K2cv9GmP3k9LW5vg@mail.gmail.com>
 <CAJuCfpHaF1e0V=wAoNO36nRL2A5EaNnuQrvZ2K3wh6PL6FrwZQ@mail.gmail.com>
 <YWT6Ptp/Uo4QGeP4@cmpxchg.org>
 <CAJuCfpERX-nqHkYzx8FAi_DuOU1vkoV5ppCAhLHziOm7o7wj6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpERX-nqHkYzx8FAi_DuOU1vkoV5ppCAhLHziOm7o7wj6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:36:24PM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 11, 2021 at 8:00 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Oct 11, 2021 at 06:20:25PM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Oct 11, 2021 at 6:18 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Mon, Oct 11, 2021 at 1:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 08-10-21 13:58:01, Kees Cook wrote:
> > > > > > - Strings for "anon" specifically have no required format (this is good)
> > > > > >   it's informational like the task_struct::comm and can (roughly)
> > > > > >   anything. There's no naming convention for memfds, AF_UNIX, etc. Why
> > > > > >   is one needed here? That seems like a completely unreasonable
> > > > > >   requirement.
> > > > >
> > > > > I might be misreading the justification for the feature. Patch 2 is
> > > > > talking about tools that need to understand memeory usage to make
> > > > > further actions. Also Suren was suggesting "numbering convetion" as an
> > > > > argument against.
> > > > >
> > > > > So can we get a clear example how is this being used actually? If this
> > > > > is just to be used to debug by humans than I can see an argument for
> > > > > human readable form. If this is, however, meant to be used by tools to
> > > > > make some actions then the argument for strings is much weaker.
> > > >
> > > > The simplest usecase is when we notice that a process consumes more
> > > > memory than usual and we do "cat /proc/$(pidof my_process)/maps" to
> > > > check which area is contributing to this growth. The names we assign
> > > > to anonymous areas are descriptive enough for a developer to get an
> > > > idea where the increased consumption is coming from and how to proceed
> > > > with their investigation.
> > > > There are of course cases when tools are involved, but the end-user is
> > > > always a human and the final report should contain easily
> > > > understandable data.
> > > >
> > > > IIUC, the main argument here is whether the userspace can provide
> > > > tools to perform the translations between ids and names, with the
> > > > kernel accepting and reporting ids instead of strings. Technically
> > > > it's possible, but to be practical that conversion should be fast
> > > > because we will need to make name->id conversion potentially for each
> > > > mmap. On the consumer side the performance is not as critical, but the
> > > > fact that instead of dumping /proc/$pid/maps we will have to parse the
> > > > file, do id->name conversion and replace all [anon:id] with
> > > > [anon:name] would be an issue when we do that in bulk, for example
> > > > when collecting system-wide data for a bugreport.
> >
> > Is that something you need to do client-side? Or could the bug tool
> > upload the userspace-maintained name:ids database alongside the
> > /proc/pid/maps dump for external processing?
> 
> You can generate a bugreport and analyze it locally or submit it as an
> attachment to a bug for further analyzes.
> Sure, we can attach the id->name conversion table to the bugreport but
> either way, some tool would have to post-process it to resolve the
> ids. If we are not analyzing the results immediately then that step
> can be postponed and I think that's what you mean? If so, then yes,
> that is correct.

Right, somebody needs to do it at some point, but I suppose it's less
of a problem if a developer machine does it than a mobile device.

One advantage of an ID over a string - besides not having to maintain
a deduplicating arbitrary string storage in the kernel - is that we
may be able to auto-assign unique IDs to VMAs in the kernel, in a way
that we could not with strings. You'd still have to do IPC calls to
write new name mappings into your db, but you wouldn't have to do the
prctl() to assign stuff in the kernel at all.

(We'd have to think of a solution of how IDs work with vma merging and
splitting, but I think to a certain degree that's policy and we should
be able to find something workable - a MAP_ID flag, using anon_vma as
identity, assigning IDs at mmap time and do merges only for protection
changes etc. etc.)
