Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A059432CB58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 05:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhCDE0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 23:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhCDE0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:26:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DCEC061756;
        Wed,  3 Mar 2021 20:25:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so5966222pjs.4;
        Wed, 03 Mar 2021 20:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rojC4O0oCsktRJUTt9F3mKHBIJy66/QAZjlv2XNqG9M=;
        b=I2fjb4+gTRiS9zXNfpHISoj4+i/hs8bn9HlryVoijTmVc5KEDQsXn33Z9WMRqNd2iP
         C6DC4LGIa+hlX34ePqUfU+Mr7iUym5fErKEtRbpMGZhNrM9+SlpyecJNQYArAhQT4NSg
         R9Wn3o5gfqTgkVpnPJwfuCLflOMF0gyPW7+KoqRmJZ9p+/i8yx7vUpM9j8ZEqD/b8KX3
         z7DR/ASUQxdRkkZ6OtROlG6YvHfvUr2Q8DLpHECOt5tj4yHdQHMyeRI4WLN8wL69X1Ey
         g1iS2w6YP1QxYZGNh09xvEStaFHYG5PwGIkbjFgiiXsqL0M4JiZP/FDgUVZeSotnL9j4
         yH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rojC4O0oCsktRJUTt9F3mKHBIJy66/QAZjlv2XNqG9M=;
        b=d7PLsom75UZmyOixX/X9WmcJIhDJm9JNBDbd5ZalZRjzMy4xIQsGMJ4iPg/r6Gs5GQ
         rrR6OTeABBNVqWCl8aCDJ839IUF43/eX2ToujUtRJFQAm1pPZA1GbwQWe+qRCJ4f/iiN
         fwNplnD753tT0gMLwfjFZLwYIMu5NLfXPzHIVOjZDncN/VLYf0iz6C8pMaDyULhLRVl6
         LNFimjRP3B1z7pAfcpVP8ydzBytZVLl/nHbqGb6EME260xJlVa/IJL/Bf2A7wyx3eFha
         n59EXxkgHP27V1D5aFmMKzQNUhBJgaU8jx0odN3B2m/Uqsv+GDKfcRMU3LKZGblxN9HF
         8VAw==
X-Gm-Message-State: AOAM533jT/ZqISu+Y8nUuxErKyTtGifQAxWCfNQQT5gM8t16VxAJVQQA
        4rFaJpiPdKExrvSMwxlO9tQ=
X-Google-Smtp-Source: ABdhPJxv9ZcbTRlgi8DGVf8G6sra9zwdlN564fVZ2DoXBhOo1lHDm3G/xPoKlwGAhwI5NszdyV0u2w==
X-Received: by 2002:a17:90a:c202:: with SMTP id e2mr2389462pjt.73.1614831926690;
        Wed, 03 Mar 2021 20:25:26 -0800 (PST)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id gg22sm8141915pjb.20.2021.03.03.20.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 20:25:25 -0800 (PST)
Date:   Thu, 4 Mar 2021 15:25:21 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
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
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v17 0/9] Free some vmemmap pages of
 HugeTLB page
Message-ID: <20210304042521.GA1223287@balbir-desktop>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <e9ef3479-24f1-9304-ee0e-6f06fb457d50@gmail.com>
 <CAMZfGtWeyo8+uWf7oB4ODqpyOw_--K+LdYeJDhdFj+ob0OaoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWeyo8+uWf7oB4ODqpyOw_--K+LdYeJDhdFj+ob0OaoeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:36:44AM +0800, Muchun Song wrote:
> On Thu, Mar 4, 2021 at 11:14 AM Singh, Balbir <bsingharora@gmail.com> wrote:
> >
> > On 26/2/21 12:21 am, Muchun Song wrote:
> > > Hi all,
> > >
> > > This patch series will free some vmemmap pages(struct page structures)
> > > associated with each hugetlbpage when preallocated to save memory.
> > >
> > > In order to reduce the difficulty of the first version of code review.
> > > From this version, we disable PMD/huge page mapping of vmemmap if this
> > > feature was enabled. This accutualy eliminate a bunch of the complex code
> > > doing page table manipulation. When this patch series is solid, we cam add
> > > the code of vmemmap page table manipulation in the future.
> > >
> > > The struct page structures (page structs) are used to describe a physical
> > > page frame. By default, there is a one-to-one mapping from a page frame to
> > > it's corresponding page struct.
> > >
> > > The HugeTLB pages consist of multiple base page size pages and is supported
> > > by many architectures. See hugetlbpage.rst in the Documentation directory
> > > for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
> > > are currently supported. Since the base page size on x86 is 4KB, a 2MB
> > > HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> > > 4096 base pages. For each base page, there is a corresponding page struct.
> > >
> > > Within the HugeTLB subsystem, only the first 4 page structs are used to
> > > contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
> > > provides this upper limit. The only 'useful' information in the remaining
> > > page structs is the compound_head field, and this field is the same for all
> > > tail pages.
> >
> > The HUGETLB_CGROUP_MIN_ORDER is only when CGROUP_HUGETLB is enabled, but I guess
> > that does not matter
> 
> Agree.
> 
> >
> > >
> > > By removing redundant page structs for HugeTLB pages, memory can returned to
> > > the buddy allocator for other uses.
> > >
> > > When the system boot up, every 2M HugeTLB has 512 struct page structs which
> > > size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> > >
> > >     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> > >  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> > >  |           |                     |     0     | -------------> |     0     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     1     | -------------> |     1     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     2     | -------------> |     2     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     3     | -------------> |     3     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     4     | -------------> |     4     |
> > >  |    2MB    |                     +-----------+                +-----------+
> > >  |           |                     |     5     | -------------> |     5     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     6     | -------------> |     6     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     7     | -------------> |     7     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |
> > >  |           |
> > >  |           |
> > >  +-----------+
> > >
> > > The value of page->compound_head is the same for all tail pages. The first
> > > page of page structs (page 0) associated with the HugeTLB page contains the 4
> > > page structs necessary to describe the HugeTLB. The only use of the remaining
> > > pages of page structs (page 1 to page 7) is to point to page->compound_head.
> > > Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
> > > will be used for each HugeTLB page. This will allow us to free the remaining
> > > 6 pages to the buddy allocator.
> >
> > What is page 1 used for? page 0 carries the 4 struct pages needed, does compound_head
> > need a full page? IOW, why do we need two full pages -- may be the patches have the
> > answer to something I am missing?
> 
> Yeah. It really can free 7 pages. But we need some work to support this. Why?
> 
> Now for the 2MB HugeTLB page, we only free 6 vmemmap pages. we really can
> free 7 vmemmap pages. In this case, we can see 8 of the 512 struct page
> structures have been set PG_head flag. If we can adjust compound_head()
> slightly and make compound_head() return the real head struct page when
> the parameter is the tail struct page but with PG_head flag set.
> 
> In order to make the code evolution route clearer. This feature can be
> a separate patch (and send it out) after this patchset is solid and applied.
>

Makes sense!
 
> >
> > >
> > > Here is how things look after remapping.
> > >
> > >     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> > >  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> > >  |           |                     |     0     | -------------> |     0     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     1     | -------------> |     1     |
> > >  |           |                     +-----------+                +-----------+
> > >  |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
> > >  |           |                     +-----------+                   | | | | |
> > >  |           |                     |     3     | ------------------+ | | | |
> > >  |           |                     +-----------+                     | | | |
> > >  |           |                     |     4     | --------------------+ | | |
> > >  |    2MB    |                     +-----------+                       | | |
> > >  |           |                     |     5     | ----------------------+ | |
> > >  |           |                     +-----------+                         | |
> > >  |           |                     |     6     | ------------------------+ |
> > >  |           |                     +-----------+                           |
> > >  |           |                     |     7     | --------------------------+
> > >  |           |                     +-----------+
> > >  |           |
> > >  |           |
> > >  |           |
> > >  +-----------+
> > >
> > > When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> > > vmemmap pages and restore the previous mapping relationship.
> > >
> >
> > Can these 6 pages come from the hugeTLB page itself? When you say 6 pages,
> > I presume you mean 6 pages of PAGE_SIZE
> 
> There was a decent discussion about this in a previous version of the
> series starting here:
> 
> https://lore.kernel.org/linux-mm/20210126092942.GA10602@linux/
> 
> In this thread various other options were suggested and discussed.
>

Thanks,
Balbir Singh 
