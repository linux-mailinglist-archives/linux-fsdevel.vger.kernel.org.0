Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9D2ABE7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 15:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgKIOUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 09:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgKIOUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:20:40 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB0EC0613D4
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 06:20:39 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e21so7256943pgr.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 06:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzZSafk58bq+f5L2n1A+XJgmXIfKfqr55EsbHaz5ToU=;
        b=anyEXQNBxl/WPiGhQQNwmAQb+fQoGWo0vJCypbVU0olYHgcNgdGNMOWRmxfxeUtv3o
         g26pAqMiAJOuq6UnzUPj5YGG+tQY8LLQaNhEpp1i2NBpd1rk3QXgSjo3rFc7n4A3rgRT
         2migm/LzuplMv3qzhqSicOFWm9bKmd8hcj+WFa8U9Bvl1MadZP78fp68EqVPtOeThjkF
         1FVJmmjavutK+fiGUf9u3YvoXYozI5tKWIP/YFbT7b3r8hcbG+AX8eOKYUa3HalOCEsK
         wYJoi97fMNPqIHVk3ZtTA4+Sm84h7F7d+jSzQrpK8GataVUIRXUTh5imfrXTBMUYi4jG
         48lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzZSafk58bq+f5L2n1A+XJgmXIfKfqr55EsbHaz5ToU=;
        b=RE+uKzPYA2Evok22Qx1/1aibpnl2fwqx8EAtlQjRGp7FFYPPiGjrSI51K/+XLdTvjM
         6XioUHO198Y9S2uz4tjyhQpNaYtQmjDTtkjfo2QConSLeikwyFT/KcHDC5hXmDNHNrr+
         8mmC9LM8DB48DQ1p5uGg+1ZocMWegkvrev6FSEZMCjVWPob7JPy2LsnjnXkSHHoj1KHr
         ttUNC7PnHUOXxza1FWN2euOP60dVbOXMWyNgZgXB6nEV5EToXFT8Dnf3f5awlVvKbleB
         hhXsuAAz4rMZBI79CwHS9KZ45U9TSBbzlfMz/I9W24iVsqCVjxHbzGeS9C53cmynExr4
         90nw==
X-Gm-Message-State: AOAM532NqRv31GiXREnDFkQRhO4x41mCd/srwIKga6VnzaQRcZzN/+QY
        b00CX7q171fvbGSGqHA9S04DM1bvOaBjk5CnchH/GQ==
X-Google-Smtp-Source: ABdhPJxkpM77kBmju2XOjMh8n98tAVXTI9znLZLfuG3dhhF1nJ7YKOpkysiIxpvhmPZsNVGS0wGQ7jgSEAlN/Hk9bPM=
X-Received: by 2002:a65:5383:: with SMTP id x3mr12825717pgq.341.1604931638489;
 Mon, 09 Nov 2020 06:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-4-songmuchun@bytedance.com> <20201109135215.GA4778@localhost.localdomain>
In-Reply-To: <20201109135215.GA4778@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 9 Nov 2020 22:20:02 +0800
Message-ID: <CAMZfGtVMFzFLzd5fMemopHfnsoye9yYN4V06eHZeO8qTu-4fAg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 03/21] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
To:     Oscar Salvador <osalvador@suse.de>
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
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 9:52 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Nov 08, 2020 at 10:10:55PM +0800, Muchun Song wrote:
> > The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
> > whether to enable the feature of freeing unused vmemmap associated
> > with HugeTLB pages. Now only support x86.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  arch/x86/mm/init_64.c |  2 +-
> >  fs/Kconfig            | 16 ++++++++++++++++
> >  mm/bootmem_info.c     |  3 +--
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index 0a45f062826e..0435bee2e172 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
> >
> >  static void __init register_page_bootmem_info(void)
> >  {
> > -#ifdef CONFIG_NUMA
> > +#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
> >       int i;
> >
> >       for_each_online_node(i)
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 976e8b9033c4..21b8d39a9715 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -245,6 +245,22 @@ config HUGETLBFS
> >  config HUGETLB_PAGE
> >       def_bool HUGETLBFS
> >
> > +config HUGETLB_PAGE_FREE_VMEMMAP
> > +     bool "Free unused vmemmap associated with HugeTLB pages"
> > +     default y
> > +     depends on X86
> > +     depends on HUGETLB_PAGE
> > +     depends on SPARSEMEM_VMEMMAP
> > +     depends on HAVE_BOOTMEM_INFO_NODE
> > +     help
> > +       There are many struct page structures associated with each HugeTLB
> > +       page. But we only use a few struct page structures. In this case,
> > +       it wastes some memory. It is better to free the unused struct page
> > +       structures to buddy system which can save some memory. For
> > +       architectures that support it, say Y here.
> > +
> > +       If unsure, say N.
>
> I am not sure the above is useful for someone who needs to decide
> whether he needs/wants to enable this or not.
> I think the above fits better in a Documentation part.
>
> I suck at this, but what about the following, or something along those
> lines?
>
> "
> When using SPARSEMEM_VMEMMAP, the system can save up some memory
> from pre-allocated HugeTLB pages when they are not used.
> 6 pages per 2MB HugeTLB page and 4095 per 1GB HugeTLB page.
> When the pages are going to be used or freed up, the vmemmap
> array representing that range needs to be remapped again and
> the pages we discarded earlier need to be rellocated again.
> Therefore, this is a trade-off between saving memory and
> increasing time in allocation/free path.
> "

Will do. Thanks for your suggestions.

>
> It would be also great to point out that this might be a
> trade-off between saving up memory and increasing the cost
> of certain operations on allocation/free path.
> That is why I mentioned it there.

OK, I will add this to the Documentation part, thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
