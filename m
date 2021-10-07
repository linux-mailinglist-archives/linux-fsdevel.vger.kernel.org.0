Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5B8424E67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhJGIBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 04:01:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhJGIBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:01:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75547225E7;
        Thu,  7 Oct 2021 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633593565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k1SjRykK8qSsuEpLbR/1BLHsqb/6nAB8R8Bq+VJeYNY=;
        b=d4VB9wDRP5RBYTz/tZZccmKEouWEMpxlGyzJ3cDxLEAWtJJfSvPKPXl7IfxWWsBOhVqzmB
        kiY4t9Hm32ScRgKORVWbDR3aTJg7VB01in/XMs8Jkfi5/94IuVtY1V1e0s8lcbRUVnOQZo
        PL7pwO6wfwPyOFHfUFdtbrpVBm89uu8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 95C36A3B95;
        Thu,  7 Oct 2021 07:59:24 +0000 (UTC)
Date:   Thu, 7 Oct 2021 09:59:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
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
Message-ID: <YV6o3Bsb4f87FaAy@dhcp22.suse.cz>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEPBM6ehQXgzp=g4SqtY6iaC8wuZ-CRE81oR1VOq7m4CA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 06-10-21 08:01:56, Suren Baghdasaryan wrote:
> On Wed, Oct 6, 2021 at 2:27 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 06.10.21 10:27, Michal Hocko wrote:
> > > On Tue 05-10-21 23:57:36, John Hubbard wrote:
> > > [...]
> > >> 1) Yes, just leave the strings in the kernel, that's simple and
> > >> it works, and the alternatives don't really help your case nearly
> > >> enough.
> > >
> > > I do not have a strong opinion. Strings are easier to use but they
> > > are more involved and the necessity of kref approach just underlines
> > > that. There are going to be new allocations and that always can lead
> > > to surprising side effects.  These are small (80B at maximum) so the
> > > overall footpring shouldn't all that large by default but it can grow
> > > quite large with a very high max_map_count. There are workloads which
> > > really require the default to be set high (e.g. heavy mremap users). So
> > > if anything all those should be __GFP_ACCOUNT and memcg accounted.
> > >
> > > I do agree that numbers are just much more simpler from accounting,
> > > performance and implementation POV.
> >
> > +1
> >
> > I can understand that having a string can be quite beneficial e.g., when
> > dumping mmaps. If only user space knows the id <-> string mapping, that
> > can be quite tricky.
> >
> > However, I also do wonder if there would be a way to standardize/reserve
> > ids, such that a given id always corresponds to a specific user. If we
> > use an uint64_t for an id, there would be plenty room to reserve ids ...
> >
> > I'd really prefer if we can avoid using strings and instead using ids.
> 
> I wish it was that simple and for some names like [anon:.bss] or
> [anon:dalvik-zygote space] reserving a unique id would work, however
> some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> are generated dynamically at runtime and include package name.
> Packages are constantly evolving, new ones are developed, names can
> change, etc. So assigning a unique id for these names is not really
> feasible.

I still do not follow. If you need a globaly consistent naming then
you need clear rules for that, no matter whether that is number or a
file. How do you handle this with strings currently?

-- 
Michal Hocko
SUSE Labs
