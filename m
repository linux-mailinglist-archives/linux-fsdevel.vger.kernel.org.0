Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC42ACEE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 06:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgKJFRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 00:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731072AbgKJFRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:17:50 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2FC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 21:17:47 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f18so4667558pgi.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 21:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXC+/BleOfXkT9eayj4GUbnHyl7/dt6Mpch3dxKG+nw=;
        b=pLvSIdTaeIZHJo73IcVYhLxFlNpiP4U6E3UKJdrJ72FklZtdmaGGtdRYddauYc8rsf
         8vGAqMuYP6aoyQytiHO2wXjeJlQwD1esvWvuzjQG96OuCScE4Q6yvoGenHz0oL5Jz9rL
         7xELZc6ZqX07o5yxmTRVqs7HeXzXw4TkUxxyy8X//4qS7fYZ8VOEWDyMAcqwnoUJRWoB
         Y1SewOEXaBVU+S2DHHL2EjGLtCKyC/aoubsWEd/7zVcu87dPcAp9cgoBqu152E8MViw/
         Oei0lNDfYCSQ7ABLbplQc90cCWxeuTtUGtXRm95kwl1Y5sf/fDRn5MeRezrjhPOLOVCX
         E4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXC+/BleOfXkT9eayj4GUbnHyl7/dt6Mpch3dxKG+nw=;
        b=g54m8waZJBy2iwfhtBEldDAUz2H3Erhi9Vjl8T9ZzF/bhX+7ti3GUPCFZgjXoVZjoG
         bofBPVCs054zyOXWMJazeK9ArrfKDN3fA3bQVWyQMxSJERJ/iKXmpFxgj4zAcnz7SNqU
         +Hf2Jmaw8l+9SaK6JoCdIBErqI9ob+FZATdJ+4HBFq3MJVeCgKhTlEprjOUtzYIFtWxO
         p9xgp+jbRDdKLnWHWCDndWrgWAJ/QVgxCwQaEmsjGwIQhJ8yVrnAVt/qBfe3SayG94bZ
         65iOwUsfqr4VjdxpU+n9gO4K/lHsEu2mK/6l0MFX0uApHimpJrmh3XnQdyqtR1d38BqS
         91RA==
X-Gm-Message-State: AOAM532rYK1eN2iTK/I4iSDR+3lOist95UFnPp7v7K6IQX9Ux/WlWFKe
        YhHF4tFABOu49jAB2jrIVerd5fdt/eICSA+NRt0Jpw==
X-Google-Smtp-Source: ABdhPJw1XsBVc5s3suqABD9CcUsJOcngWrKu6Nkz0r9C1MF0alZME/00oO9I8hsjaBLtSiYVkkFfsBc/QpbX3EWvfKM=
X-Received: by 2002:a65:5383:: with SMTP id x3mr15431908pgq.341.1604985467243;
 Mon, 09 Nov 2020 21:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-9-songmuchun@bytedance.com> <20201109181104.GC17356@linux>
In-Reply-To: <20201109181104.GC17356@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 13:17:11 +0800
Message-ID: <CAMZfGtUB_28g1DzG2-eBrTu7DAgDag0roQ6AQQTh9o61dofZNA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 08/21] mm/vmemmap: Initialize page table
 lock for vmemmap
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

On Tue, Nov 10, 2020 at 2:11 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Sun, Nov 08, 2020 at 10:11:00PM +0800, Muchun Song wrote:
> > In the register_page_bootmem_memmap, the slab allocator is not ready
> > yet. So when ALLOC_SPLIT_PTLOCKS, we use init_mm.page_table_lock.
> > otherwise we use per page table lock(page->ptl). In the later patch,
> > we will use the vmemmap page table lock to guard the splitting of
> > the vmemmap huge PMD.
>
> I am not sure about this one.
> Grabbing init_mm's pagetable lock for specific hugetlb operations does not
> seem like a good idea, and we do not know how contented is that one.

These APIs are used to guard the operations on vmemmap page tables.
For now, it is only for specific hugetlb operations. But maybe in the future,
someone also wants to modify the vmemmap page tables, he also can
use these APIs. Yeah, we do not know how contented is init_mm's pagetable
lock. Grabbing this one may not be a good idea.

>
> I think a better fit would be to find another hook to initialize
> page_table_lock at a later stage.
> Anyway, we do not need till we are going to perform an operation
> on the range, right?

Yeah. You are right.

>
> Unless I am missing something, this should be doable in hugetlb_init.
>
> hugetlb_init is part from a init_call that gets called during do_initcalls.
> At this time, slab is fully operative.

If we initialize the page_table_lock in the hugetlb_init, we need to
walk the vmemmap page tables again. But the vmemmap pages
size is small, maybe the overhead of this is also small. And doing
this in hugetlb_init can make the code cleaner. Thanks very much.


>
> start_kernel
>  kmem_cache_init_late
>  kmem_cache_init_late
>  ...
>  arch_call_rest_init
>   rest_init
>    kernel_init_freeable
>     do_basic_setup
>      do_initcalls
>       hugetlb_init
>
> --
> Oscar Salvador
> SUSE L3



--
Yours,
Muchun
