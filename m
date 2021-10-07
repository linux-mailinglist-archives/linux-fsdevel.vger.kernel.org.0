Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1241B424BF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 04:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbhJGCzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 22:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239889AbhJGCzh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:55:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07A2161177;
        Thu,  7 Oct 2021 02:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633575224;
        bh=S1b6BfNXTnYn99oV3r2hF6nTfU3qu7id07vNeo0dX5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YFNKHhelEKjbA4XqN33VsZKu56RyL7QHiTH4RmFZxW9Hdv8ZK3wXQZmVqFnkZgAjG
         p7PRlhvDnembO12u3F6qCHm5nHTHUiU2yhYd0euxccRhMA5M7eJb7LAE7uamjWu8nj
         njE18CPPkCyKlhDMFUalDCkL1suG3syPAcsJyGrc=
Date:   Wed, 6 Oct 2021 19:53:42 -0700
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
        Chinwen Chang <chinwen.chang@mediatek.com>,
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
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-Id: <20211006195342.0503b3a3cbcd2c3c3417df46@linux-foundation.org>
In-Reply-To: <CAJuCfpGLQK5aVe5zQfdkP=K4NBZXPjtG=ycjk3E4D64CAvVPsg@mail.gmail.com>
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
        <20211006192927.f7a735f1afe4182bf4693838@linux-foundation.org>
        <CAJuCfpGLQK5aVe5zQfdkP=K4NBZXPjtG=ycjk3E4D64CAvVPsg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 6 Oct 2021 19:46:57 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > > > > I wish it was that simple and for some names like [anon:.bss] or
> > > > > [anon:dalvik-zygote space] reserving a unique id would work, however
> > > > > some names like [anon:dalvik-/system/framework/boot-core-icu4j.art]
> > > > > are generated dynamically at runtime and include package name.
> > > >
> > > > Valuable information
> > >
> > > Yeah, I should have described it clearer the first time around.
> >
> > If it gets this fancy then the 80 char limit is likely to become a
> > significant limitation and the choice should be explained & justified.
> >
> > Why not 97?  1034?  Why not just strndup_user() and be done with it?
> 
> The original patch from 8 years ago used 256 as the limit but Rasmus
> argued that the string content should be human-readable, so 80 chars
> seems to be a reasonable limit (see:
> https://lore.kernel.org/all/d8619a98-2380-ca96-001e-60fe9c6204a6@rasmusvillemoes.dk),
> which makes sense to me. We should be able to handle the 80 char limit
> by trimming it before calling prctl().

What's the downside to making it unlimited?


