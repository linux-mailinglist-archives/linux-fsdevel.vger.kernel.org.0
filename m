Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5663FA7B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhH1VyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 17:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhH1VyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:54:23 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEFC061756
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 14:53:32 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r4so19881297ybp.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZLoRc8zgP/v6fBuiK/r7V3fCb7OpEy1oLfRJgXAgFE=;
        b=iNAUMJ1E+h3PcgTBuph6t34O4/GYB/x8t0AN3XLJYkzHXbSc+tcQQ+H6MHV4sZPerj
         Q5mSmXK7+qv3SX0wC+Z685Um9F5pgv/lIEZp511W1EZlAkLDGSnm2NFnsGYifzyyVj3k
         Jc2mIcY1g6wXGKMPg5v9NThOG24wc18zFxjqxaEul8Ody4x2qxR/y4CWpsADRayNckfJ
         DpxlTyHyTneIHkDURMtCvfp9/ofDgt+0KHIl/dwBauup9r4BEbGEQfWFDXMbNUgp8MB3
         aUKRlenZuGE/uEWidqXa/rS9Q6tcRXasRykFO0mGYSEsWITy9kxk+EONJAwoV/XdoFmF
         cNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZLoRc8zgP/v6fBuiK/r7V3fCb7OpEy1oLfRJgXAgFE=;
        b=ay9N1H0aeOlsy92njUHXBBFxRybm+tJqiuFqGIVY74AxUC3o9y2ak2J+XA2H62dp0I
         SYt1kMoNEfFeP3JZtIxc21AXNscjl18tLs+fobcCUGR414utkTO8JnQlPr4qaX0LO0zm
         9h7R86AAtgH8c3rijygBJ7SfBU4CiYp1YpfdWUD9fdCoenLZ2/76PibQL7pOTWXIc7PA
         DSyPYJXspKSqaNrgy8Wiaspk5BdlvEVH7IygZ2Xe2Kvt8EYyQ1+JfEsqEPMk1Go60KiM
         dnFlnJlUw3RC10CTs/5Q5oc6iL+2hyC9Afe1/7cHCKQ6uzuHnHwhnpi3zVL1XE8SzUfb
         kDxw==
X-Gm-Message-State: AOAM533eRiyvQQmNFXtvD73JjcOvINLEoH+ACFo2uAiHTtV6Iu62XjnF
        Kh4/RUfgauyR0WFHK3pJhVfoq+1t6pC18pxcE71Lug==
X-Google-Smtp-Source: ABdhPJwj1EM/du+54jmqkuXBOkV1QaQYiv7WXfuRvRGstLf/QXfLboXB4RNTPVw7h240QWLn4XdvgYE2TJv1Qj7tquw=
X-Received: by 2002:a25:21c5:: with SMTP id h188mr13130824ybh.23.1630187611436;
 Sat, 28 Aug 2021 14:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-3-surenb@google.com>
 <YSqqgJ7EC6PO9ggO@grain>
In-Reply-To: <YSqqgJ7EC6PO9ggO@grain>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 28 Aug 2021 14:53:20 -0700
Message-ID: <CAJuCfpGyT_4nrj9RQkAwH0W+u-uf_JzpuKZd2-BeS23kSu08Ug@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
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
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
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
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org, eb@emlix.com,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 2:28 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Fri, Aug 27, 2021 at 12:18:57PM -0700, Suren Baghdasaryan wrote:
> >
> > The name is stored in a pointer in the shared union in vm_area_struct
> > that points to a null terminated string. Anonymous vmas with the same
> > name (equivalent strings) and are otherwise mergeable will be merged.
> > The name pointers are not shared between vmas even if they contain the
> > same name. The name pointer is stored in a union with fields that are
> > only used on file-backed mappings, so it does not increase memory usage.
> >
> > The patch is based on the original patch developed by Colin Cross, more
> > specifically on its latest version [1] posted upstream by Sumit Semwal.
> > It used a userspace pointer to store vma names. In that design, name
> > pointers could be shared between vmas. However during the last upstreaming
> > attempt, Kees Cook raised concerns [2] about this approach and suggested
> > to copy the name into kernel memory space, perform validity checks [3]
> > and store as a string referenced from vm_area_struct.
> > One big concern is about fork() performance which would need to strdup
> > anonymous vma names. Dave Hansen suggested experimenting with worst-case
> > scenario of forking a process with 64k vmas having longest possible names
> > [4]. I ran this experiment on an ARM64 Android device and recorded a
> > worst-case regression of almost 40% when forking such a process. This
> > regression is addressed in the followup patch which replaces the pointer
> > to a name with a refcounted structure that allows sharing the name pointer
> > between vmas of the same name. Instead of duplicating the string during
> > fork() or when splitting a vma it increments the refcount.
> >
> > [1] https://lore.kernel.org/linux-mm/20200901161459.11772-4-sumit.semwal@linaro.org/
> > [2] https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescook/
> > [3] https://lore.kernel.org/linux-mm/202009031022.3834F692@keescook/
> > [4] https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d6a8e95@intel.com/
> ...
> > +
> > +/* mmap_lock should be read-locked */
> > +static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
> > +                                      const char *name)
> > +{
> > +     const char *vma_name = vma_anon_name(vma);
> > +
> > +     if (likely(!vma_name))
> > +             return name == NULL;
> > +
> > +     return name && !strcmp(name, vma_name);
> > +}
>
> Hi Suren! There is very important moment with this new feature: if
> we assign a name to some VMA it won't longer be mergeable even if
> near VMA matches by all other attributes such as flags, permissions
> and etc. I mean our vma_merge() start considering the vma namings
> and names mismatch potentially blocks merging which happens now
> without this new feature. Is it known behaviour or I miss something
> pretty obvious here?

Hi Cyrill,
Correct, this is a known drawback of naming an anonymous VMA. I think
I'll need to document this in prctl(2) manpage, which I should update
to include this new PR_SET_VMA_ANON_NAME option.
Thanks for pointing it out!
Suren.
