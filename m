Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337202BA799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 11:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKTKj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgKTKjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:39:55 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DDC0617A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 02:39:55 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b3so4643164pls.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tp1Yn6PcYwDveyfmiNUMjqoohGn5JgQdU6bb6b54s7c=;
        b=QXuoT0YGe3HDxz+HXbH17h6UKx5WhqJBvvvjMJBBZq2FNc1zrSX59gmBtx3vzBZalN
         JT69SsXhQtlq1zgI7hllhxrbDFAWelFFMocFYKNiAHFPd5YNckbSBCW1yYHdh5TG2aQL
         86Qjz9M3UfKWKIdCX60Vb3vV9Nw/Si4ZgfNwJiqW8V5+i+oGqzDL+Uld/Y+1WfRtkHSK
         WRDFJirytKoexo3twKJEkEJiKOJNBPqHqr5pHmcKGY+1KcjFueMlE++7eWtExSbgVy0R
         C5Ottl56Y88HOgabvGotKsHw4tK3CnHE2/6KOZHcaAaWTxdEIcT6NkeMwHIkSdKIXeuS
         lwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tp1Yn6PcYwDveyfmiNUMjqoohGn5JgQdU6bb6b54s7c=;
        b=JLawROeN5snQxdWVl7ndVs+FBXKX/ok3FEDTaNwGX/Hi4Y4eC/rM3wHhN++has2XxG
         2j1hnWnGiJwmUfW1Mdp4EaHz+t4iRJ6VwpC+BRnGgR1zf+py9Q7GsUaE8kDcZ7YC2M7y
         Gs8MoZ0xAiYy397DbMyko9dM5ci52xKs41EB58oOMSbrFzfaYypt8iDyvOPVHjue+wXN
         hAy2XHO+Zr9K+0KAXwhphBLne8fDNTKAD7NZukK2AnRqdu9Y7NI85cJ2LgQRMe1QFbwv
         NvB6UUoEHzvzQbyd2AcS+p2B02aSOhamD/KdYsw6nJaRyKoQL1I89XRSs7znWbP08sgp
         KT0A==
X-Gm-Message-State: AOAM532ATm995ULWVZo7PRf482p0Bu1egkvhZNO1uNOw+Xbds5yYJ5hZ
        dOlXRuXTI9om66ZX5mDKg4wbQspcbynqazbJMAcI2w==
X-Google-Smtp-Source: ABdhPJwyeHponJyLYkFShPtIMQjhm14hpbv9nuNdyb0slhePQUiE+rmZ2muvx54FRFWkF7TSl9xDPloHXXLtI1r7PYw=
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id
 11-20020a170902c14bb02900d6ab18108dmr13501415plj.20.1605868795137; Fri, 20
 Nov 2020 02:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-18-songmuchun@bytedance.com> <20201120082212.GG3200@dhcp22.suse.cz>
In-Reply-To: <20201120082212.GG3200@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 20 Nov 2020 18:39:12 +0800
Message-ID: <CAMZfGtU693Q-CoSENZ+5ReLEXu3_QfU0RNwh8SspMNC1kV6OZA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 17/21] mm/hugetlb: Add a kernel
 parameter hugetlb_free_vmemmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:22 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 20-11-20 14:43:21, Muchun Song wrote:
> > Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> > freeing unused vmemmap pages associated with each hugetlb page on boot.
>
> As replied to the config patch. This is fine but I would argue that the
> default should be flipped. Saving memory is nice but it comes with
> overhead and therefore should be an opt-in. The config option should
> only guard compile time dependencies not a user choice.

Got it. The default will be flipped in the next version. Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
> >  mm/hugetlb_vmemmap.c                            | 21 +++++++++++++++++++++
> >  3 files changed, 33 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 5debfe238027..ccf07293cb63 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1551,6 +1551,15 @@
> >                       Documentation/admin-guide/mm/hugetlbpage.rst.
> >                       Format: size[KMG]
> >
> > +     hugetlb_free_vmemmap=
> > +                     [KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> > +                     this controls freeing unused vmemmap pages associated
> > +                     with each HugeTLB page.
> > +                     Format: { on (default) | off }
> > +
> > +                     on:  enable the feature
> > +                     off: disable the feature
> > +
> >       hung_task_panic=
> >                       [KNL] Should the hung task detector generate panics.
> >                       Format: 0 | 1
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> > index f7b1c7462991..7d6129ee97dd 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -145,6 +145,9 @@ default_hugepagesz
> >
> >       will all result in 256 2M huge pages being allocated.  Valid default
> >       huge page size is architecture dependent.
> > +hugetlb_free_vmemmap
> > +     When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this disables freeing
> > +     unused vmemmap pages associated each HugeTLB page.
> >
> >  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
> >  indicates the current number of pre-allocated huge pages of the default size.
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 3629165d8158..c958699d1393 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -144,6 +144,22 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
> >  }
> >  #endif
> >
> > +static bool hugetlb_free_vmemmap_disabled __initdata;
> > +
> > +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     if (!strcmp(buf, "off"))
> > +             hugetlb_free_vmemmap_disabled = true;
> > +     else if (strcmp(buf, "on"))
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
> > +
> >  static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
> >  {
> >       return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
> > @@ -541,6 +557,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >       unsigned int order = huge_page_order(h);
> >       unsigned int vmemmap_pages;
> >
> > +     if (hugetlb_free_vmemmap_disabled) {
> > +             pr_info("disable free vmemmap pages for %s\n", h->name);
> > +             return;
> > +     }
> > +
> >       vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
> >       /*
> >        * The head page and the first tail page are not to be freed to buddy
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
