Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAC32CAE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 04:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhCDDiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 22:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhCDDiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:38:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13742C061756
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 19:37:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so5901423pjs.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Mar 2021 19:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5aaETOTZkHBTtEXphmw/cUhBvHYGOGg2bi64gc0COM=;
        b=fZ7WA8txY9uXEXqTFaVbB4DIu0hZ0dICn+uHs2p4lCHU4k3P47Yo0zFYBBq7GpxFH+
         NRN/Iz/ofK337vNhjF8Ttoyok/6H25rgUDLSkYtumyFREI78IqpOuNJEU4YtAt++YJNA
         67QO5GDhjSaqve0o0ZH2ujiGkGQ60l6raKjrMw7Unc/KHTCOxJZc+OnXC5RMu/ESzfC0
         +QwEAaNeGndLDHeZgven22q6jpxUt00LwhdFxPtyE1s/lKjiVZ+8kNVQCmHmRFrh13dR
         +3Fe8JsYKC6e5qK1PDz5rkeqMlMIwccy5FdQaL2yEjluQ3A57xKCCUXuwtEEqu2IzbA8
         2Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5aaETOTZkHBTtEXphmw/cUhBvHYGOGg2bi64gc0COM=;
        b=M8eajidZd3nP7MOXVu83KAH5kaQkpTouP+Gg79sJ6CP/fDnJYkv1nAsVY7TTh2nT+J
         9m8zh1JAlK4qQQpn7jmgfJ3Ky4Sd6ObRSt5b+YUsJhm96jnMOjGkjdIhAoqe9M/LMlOF
         JI5UI6mRproJVxPHfDNRbS/2Gh12kyNL9hcvFpREPJJYa6Ks/i6FI8Ws1Jh4tSDtnZgF
         UjDEp/WYFBpbh4nbbZysaezBNQQLH2qfsKTtM4Cazb84nv/kjMp+UuobXAchF9UlhQko
         5JY/5tnOyoma0M0w/q1/ioF5a3WuE0xjPR8pdEeHAufqjBohURZu25MVBisQ39/8QrH4
         bN7g==
X-Gm-Message-State: AOAM5319opERQsXt+5QN7MHRYOt9RLgA8UJnERr+s/hNfXC8dr52FCNa
        G8JIj4cE1aHyk6yIKXMDfrWlT+82HGkMDUjHo1eq0A==
X-Google-Smtp-Source: ABdhPJw+Pt8GPG27iErHvkZjPIsoVxDhuetCkdHSYGA/hC/MW/L8FCiOy4ferytRGPCEKiUQQmnWNi6Pibpf7dqHNls=
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr2359360pjb.13.1614829041551;
 Wed, 03 Mar 2021 19:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20210225132130.26451-1-songmuchun@bytedance.com> <e9ef3479-24f1-9304-ee0e-6f06fb457d50@gmail.com>
In-Reply-To: <e9ef3479-24f1-9304-ee0e-6f06fb457d50@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 4 Mar 2021 11:36:44 +0800
Message-ID: <CAMZfGtWeyo8+uWf7oB4ODqpyOw_--K+LdYeJDhdFj+ob0OaoeA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v17 0/9] Free some vmemmap pages of HugeTLB page
To:     "Singh, Balbir" <bsingharora@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 4, 2021 at 11:14 AM Singh, Balbir <bsingharora@gmail.com> wrote:
>
> On 26/2/21 12:21 am, Muchun Song wrote:
> > Hi all,
> >
> > This patch series will free some vmemmap pages(struct page structures)
> > associated with each hugetlbpage when preallocated to save memory.
> >
> > In order to reduce the difficulty of the first version of code review.
> > From this version, we disable PMD/huge page mapping of vmemmap if this
> > feature was enabled. This accutualy eliminate a bunch of the complex code
> > doing page table manipulation. When this patch series is solid, we cam add
> > the code of vmemmap page table manipulation in the future.
> >
> > The struct page structures (page structs) are used to describe a physical
> > page frame. By default, there is a one-to-one mapping from a page frame to
> > it's corresponding page struct.
> >
> > The HugeTLB pages consist of multiple base page size pages and is supported
> > by many architectures. See hugetlbpage.rst in the Documentation directory
> > for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
> > are currently supported. Since the base page size on x86 is 4KB, a 2MB
> > HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> > 4096 base pages. For each base page, there is a corresponding page struct.
> >
> > Within the HugeTLB subsystem, only the first 4 page structs are used to
> > contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
> > provides this upper limit. The only 'useful' information in the remaining
> > page structs is the compound_head field, and this field is the same for all
> > tail pages.
>
> The HUGETLB_CGROUP_MIN_ORDER is only when CGROUP_HUGETLB is enabled, but I guess
> that does not matter

Agree.

>
> >
> > By removing redundant page structs for HugeTLB pages, memory can returned to
> > the buddy allocator for other uses.
> >
> > When the system boot up, every 2M HugeTLB has 512 struct page structs which
> > size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> >
> >     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> >  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> >  |           |                     |     0     | -------------> |     0     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     1     | -------------> |     1     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     2     | -------------> |     2     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     3     | -------------> |     3     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     4     | -------------> |     4     |
> >  |    2MB    |                     +-----------+                +-----------+
> >  |           |                     |     5     | -------------> |     5     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     6     | -------------> |     6     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     7     | -------------> |     7     |
> >  |           |                     +-----------+                +-----------+
> >  |           |
> >  |           |
> >  |           |
> >  +-----------+
> >
> > The value of page->compound_head is the same for all tail pages. The first
> > page of page structs (page 0) associated with the HugeTLB page contains the 4
> > page structs necessary to describe the HugeTLB. The only use of the remaining
> > pages of page structs (page 1 to page 7) is to point to page->compound_head.
> > Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
> > will be used for each HugeTLB page. This will allow us to free the remaining
> > 6 pages to the buddy allocator.
>
> What is page 1 used for? page 0 carries the 4 struct pages needed, does compound_head
> need a full page? IOW, why do we need two full pages -- may be the patches have the
> answer to something I am missing?

Yeah. It really can free 7 pages. But we need some work to support this. Why?

Now for the 2MB HugeTLB page, we only free 6 vmemmap pages. we really can
free 7 vmemmap pages. In this case, we can see 8 of the 512 struct page
structures have been set PG_head flag. If we can adjust compound_head()
slightly and make compound_head() return the real head struct page when
the parameter is the tail struct page but with PG_head flag set.

In order to make the code evolution route clearer. This feature can be
a separate patch (and send it out) after this patchset is solid and applied.

>
> >
> > Here is how things look after remapping.
> >
> >     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> >  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> >  |           |                     |     0     | -------------> |     0     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     1     | -------------> |     1     |
> >  |           |                     +-----------+                +-----------+
> >  |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
> >  |           |                     +-----------+                   | | | | |
> >  |           |                     |     3     | ------------------+ | | | |
> >  |           |                     +-----------+                     | | | |
> >  |           |                     |     4     | --------------------+ | | |
> >  |    2MB    |                     +-----------+                       | | |
> >  |           |                     |     5     | ----------------------+ | |
> >  |           |                     +-----------+                         | |
> >  |           |                     |     6     | ------------------------+ |
> >  |           |                     +-----------+                           |
> >  |           |                     |     7     | --------------------------+
> >  |           |                     +-----------+
> >  |           |
> >  |           |
> >  |           |
> >  +-----------+
> >
> > When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> > vmemmap pages and restore the previous mapping relationship.
> >
>
> Can these 6 pages come from the hugeTLB page itself? When you say 6 pages,
> I presume you mean 6 pages of PAGE_SIZE

There was a decent discussion about this in a previous version of the
series starting here:

https://lore.kernel.org/linux-mm/20210126092942.GA10602@linux/

In this thread various other options were suggested and discussed.

Thanks.

>
> > Apart from 2MB HugeTLB page, we also have 1GB HugeTLB page. It is similar
> > to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
> > pages.
> >
> > In this case, for the 1GB HugeTLB page, we can save 4094 pages. This is a
> > very substantial gain. On our server, run some SPDK/QEMU applications which
> > will use 1024GB hugetlbpage. With this feature enabled, we can save ~16GB
> > (1G hugepage)/~12GB (2MB hugepage) memory.
>
> Thanks,
> Balbir Singh
>
>
>
>
>
>
>
>
>
>
>
>
>
