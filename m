Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC54B424BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 04:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhJGCbX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 22:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhJGCbW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:31:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53E5561215;
        Thu,  7 Oct 2021 02:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633573770;
        bh=QKnJdE88voYB/9FaSah2G1VK75svKZo3+imFlVbkWFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sy3Id8Xw5K5JSS0QPe6KDaxwGmEsoiHtqVrOeqe1WMmSTAOI9kUw4iT3U1l7U1Buu
         3w5tGvkoDfNxV23My6X1HDBhvus6DnOB/Q8phFYwuZC071WMp5Bs8FZl11x3GMauiE
         Im+2fhvnN7zYh48vimu0ZpWrbH7fQ4uo59x+NuAc=
Date:   Wed, 6 Oct 2021 19:29:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
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
        Chinwen Chang ( =?UTF-8?Q?=E5=BC=B5=E9=8C=A6=E6=96=87?=) 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-Id: <20211006192927.f7a735f1afe4182bf4693838@linux-foundation.org>
In-Reply-To: <CAJuCfpH4KT=fOAWsYhaAb_LLg-VwPvL4Bmv32NYuUtZ3Ceo+PA@mail.gmail.com>
References: <20211001205657.815551-1-surenb@google.com>
        <20211001205657.815551-3-surenb@google.com>
        <20211005184211.GA19804@duo.ucw.cz>
        <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
        <20211005200411.GB19804@duo.ucw.cz>
        <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
        <efdffa68-d790-72e4-e6a3-80f2e194d811@nvidia.com>
        <YV1eCu0eZ+gQADNx@dhcp22.suse.cz>
        <6b15c682-72eb-724d-bc43-36ae6b79b91a@redhat.com>
        <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
        <192438ab-a095-d441-6843-432fbbb8e38a@redhat.com>
        <CAJuCfpH4KT=fOAWsYhaAb_LLg-VwPvL4Bmv32NYuUtZ3Ceo+PA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 6 Oct 2021 08:20:20 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Wed, Oct 6, 2021 at 8:08 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 06.10.21 17:01, Suren Baghdasaryan wrote:
> > > On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
> > >>
> > >> On 06.10.21 10:27, Michal Hocko wrote:
> > >>> On Tue 05-10-21 23:57:36, John Hubbard wrote:
> > >>> [...]
> > >>>> 1) Yes, just leave the strings in the kernel, that's simple and
> > >>>> it works, and the alternatives don't really help your case nearly
> > >>>> enough.
> > >>>
> > >>> I do not have a strong opinion. Strings are easier to use but they
> > >>> are more involved and the necessity of kref approach just underlines
> > >>> that. There are going to be new allocations and that always can lead
> > >>> to surprising side effects.  These are small (80B at maximum) so the
> > >>> overall footpring shouldn't all that large by default but it can grow
> > >>> quite large with a very high max_map_count. There are workloads which
> > >>> really require the default to be set high (e.g. heavy mremap users). So
> > >>> if anything all those should be __GFP_ACCOUNT and memcg accounted.
> > >>>
> > >>> I do agree that numbers are just much more simpler from accounting,
> > >>> performance and implementation POV.
> > >>
> > >> +1
> > >>
> > >> I can understand that having a string can be quite beneficial e.g., when
> > >> dumping mmaps. If only user space knows the id <-> string mapping, that
> > >> can be quite tricky.
> > >>
> > >> However, I also do wonder if there would be a way to standardize/reserve
> > >> ids, such that a given id always corresponds to a specific user. If we
> > >> use an uint64_t for an id, there would be plenty room to reserve ids ...
> > >>
> > >> I'd really prefer if we can avoid using strings and instead using ids.
> > >
> > > I wish it was that simple and for some names like [anon:.bss] or
> > > [anon:dalvik-zygote space] reserving a unique id would work, however
> > > some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> > > are generated dynamically at runtime and include package name.
> >
> > Valuable information
> 
> Yeah, I should have described it clearer the first time around.

If it gets this fancy then the 80 char limit is likely to become a
significant limitation and the choice should be explained & justified.

Why not 97?  1034?  Why not just strndup_user() and be done with it?

> > My question would be, if we really have to expose these strings to the
> > kernel, or if an id is sufficient. Sure, it would move complexity to
> > user space, but keeping complexity out of the kernel is usually a good idea.
> 
> My worry here is not the additional complexity on the userspace side
> but the performance hit we would have to endure due to these
> conversions.

Has the performance hit been quantified?

I've seen this many times down the ages.  Something which *could* be
done in userspace is instead done in the kernel because coordinating
userspace is Just So Damn Hard.  I guess the central problem is that
userspace isn't centrally coordinated.  I wish we were better at this.


