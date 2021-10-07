Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288D0424BD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 04:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhJGClg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 22:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhJGClf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 22:41:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1586C61076;
        Thu,  7 Oct 2021 02:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633574382;
        bh=seB2mDoF7EhQhumx+fQ/P/EBwoDpNc1LmNcHuen000M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b7fobYiiYE5BmHhssdbXlDCCnK9i4BgS2A2AR7eh0Icy+AmV6ORxd+Z0gfYYKTU4c
         j+PZ6YrKt5ns3BCjdre/kwM0aeRQ4KkWUJa2LpIW53Zgyy5qSrmDkqa/72mAkGOZqE
         vE4eahfl5EH5bOyRZN7wX1KclIuC6Mos9bVfnOoI=
Date:   Wed, 6 Oct 2021 19:39:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
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
        Chinwen Chang (=?UTF-8?Q?=E5=BC=B5=E9=8C=A6?= =?UTF-8?Q?=E6=96=87?=) 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
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
        Pavel Machek <pavel@ucw.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v10 2/3] mm: add a field to store names for private
 anonymous memory
Message-Id: <20211006193940.c261f21fcd14b4b52aae1fbc@linux-foundation.org>
In-Reply-To: <CAJuCfpFWUXQ445VcqTcV1kNY3AWX=wB5iaeDAX_=+xZefjTUjg@mail.gmail.com>
References: <20211001205657.815551-1-surenb@google.com>
        <20211001205657.815551-2-surenb@google.com>
        <20211001160830.700c36b32b736478000b3420@linux-foundation.org>
        <CAJuCfpGpMru4z=ZMezRQW56tHNjrWHU3jWhG3qzuXvuUytq-3w@mail.gmail.com>
        <CAJuCfpFWUXQ445VcqTcV1kNY3AWX=wB5iaeDAX_=+xZefjTUjg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 4 Oct 2021 09:21:42 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> > > > The name pointers are not shared between vmas even if they contain the
> > > > same name. The name pointer is stored in a union with fields that are
> > > > only used on file-backed mappings, so it does not increase memory usage.
> > > >
> > > > The patch is based on the original patch developed by Colin Cross, more
> > > > specifically on its latest version [1] posted upstream by Sumit Semwal.
> > > > It used a userspace pointer to store vma names. In that design, name
> > > > pointers could be shared between vmas. However during the last upstreaming
> > > > attempt, Kees Cook raised concerns [2] about this approach and suggested
> > > > to copy the name into kernel memory space, perform validity checks [3]
> > > > and store as a string referenced from vm_area_struct.
> > > > One big concern is about fork() performance which would need to strdup
> > > > anonymous vma names. Dave Hansen suggested experimenting with worst-case
> > > > scenario of forking a process with 64k vmas having longest possible names
> > > > [4]. I ran this experiment on an ARM64 Android device and recorded a
> > > > worst-case regression of almost 40% when forking such a process. This
> > > > regression is addressed in the followup patch which replaces the pointer
> > > > to a name with a refcounted structure that allows sharing the name pointer
> > > > between vmas of the same name. Instead of duplicating the string during
> > > > fork() or when splitting a vma it increments the refcount.
> > >
> > > Generally, the patch adds a bunch of code which a lot of users won't
> > > want.  Did we bust a gut to reduce this impact?  Was a standalone
> > > config setting considered?
> >
> > I didn't consider a standalone config for this feature because when
> > not used it has no memory impact at runtime. As for the image size, I
> > built Linus' ToT with and without this patchset with allmodconfig and

allnoconfig would be more interesting.  People who want small kernels
won't be using allmodconfig!

> > the sizes are:
> > Without the patchset:
> > $ size vmlinux
> >    text    data     bss     dec     hex filename
> > 40763556 58424519 29016228 128204303 7a43e0f vmlinux
> >
> > With the patchset:
> > $ size vmlinux
> >    text    data     bss     dec     hex filename
> > 40765068 58424671 29016228 128205967 7a4448f vmlinux
> >
> > The increase seems quite small, so I'm not sure if it warrants a
> > separate config option.
> 
> Andrew, do you still think we need a separate CONFIG option? I fixed
> the build issue when CONFIG_ADVISE_SYSCALLS=n and would like to post
> the update but if you want to have a separate config then I can post
> that together with the fix. Please let me know.

I don't see much downside to the standalone option.  More complexity
for developers/testers, I guess.  But such is life?

