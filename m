Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8484D3203A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 05:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBTEVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 23:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTEVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 23:21:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23231C061786
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 20:21:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 75so6608697pgf.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 20:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mklg+AYwKzafXeovf7IuFZZrAWcs0LMC3PrPd1tFTKU=;
        b=12b7zh+2/tZORGhOPLBBGI1aC17iBV3qsfujetE2XOCQYGg56u4ElUYrHBoKbS5uuc
         jO3TCUFl/u8EdF5/kbZtA9RAFu2qywWZJg5tFL4Zx6Mo8+LxP5OZtio585fA619DKjJ+
         ktz7rSrKj1Je+nCBS7ttc5v2CMIqcb8xniDRheJ9NnFjuuNVIGbS2fUAcHlI7juzx31J
         kjJqPpW/Ryy0ikHGt904ok0oRJbarKGIlf3Yr7DuzgJL+wSZPrR8zRAaBa/0MjmIMxKt
         sCiDfxX9HN9h9LVSSW0pC+z19hvhXpFVDJUPrU0gTEuE9eWoh49+bAMQYodtQW3CnFVP
         SvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mklg+AYwKzafXeovf7IuFZZrAWcs0LMC3PrPd1tFTKU=;
        b=kpteTha/JhFMN/ZOIozBgpl67YU0Uf6/lACuUOIQyDdRQoc0mcoEMHftKYngyMoWWF
         +dohH5nsH68c2ODzVmDoeiuUBoRIunhKw66PNLFM/TRUJlccFx72VAT6DD7hB/MzsauL
         ebXKYjCzWs8wm4tcxOuH7aZE+v/tXcmbcM2otD0ALW97UMEbqoGDeTt4ay1/ugUYNCAN
         S1lORzeAN9Vp+F2kMIHh0RTSUiYBYbYvcYAWwQsV2HlUz/VoNJatkp3Im9eUxT2ypgu5
         ykQwwoaD4pVGa90RU5m1zZDLBP0oAalpZyucd71pvQNyxxb+2eKY8kTKzMrYleNaVssR
         kx4A==
X-Gm-Message-State: AOAM532Oa9zFGlKBtHE8xjsvcCgfqWW4M8bqOgztj3MGg1HKJshTCY2t
        ey7srzp+jtXLAbn5kASJkMIjJks9I5w4MZkliNtPvQ==
X-Google-Smtp-Source: ABdhPJzHovR+Dqry8e8TbF1nft1zNiAj/LjO/P0dMklt0n5mDlaBx7myVp+4tffX6GW6uG3XzrCZ0MNMiYeL7UoKw0Q=
X-Received: by 2002:aa7:910c:0:b029:1ed:ef1:81b with SMTP id
 12-20020aa7910c0000b02901ed0ef1081bmr10564219pfh.49.1613794872318; Fri, 19
 Feb 2021 20:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com> <YC/HRTq1MRaDWn7O@dhcp22.suse.cz>
In-Reply-To: <YC/HRTq1MRaDWn7O@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 20 Feb 2021 12:20:36 +0800
Message-ID: <CAMZfGtW-j=WizTckEWZNB2OSPkz662Vjr79Fb0he9tMD+bnT3Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
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

On Fri, Feb 19, 2021 at 10:12 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 19-02-21 18:49:49, Muchun Song wrote:
> > When we free a HugeTLB page to the buddy allocator, we should allocate
> > the vmemmap pages associated with it. But we may cannot allocate vmemmap
> > pages when the system is under memory pressure, in this case, we just
> > refuse to free the HugeTLB page instead of looping forever trying to
> > allocate the pages. This changes some behavior (list below) on some
> > corner cases.
> >
> >  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> >
> >     Need try again later by the user.
> >
> >  2) Failing to free a surplus huge page when freed by the application.
> >
> >     Try again later when freeing a huge page next time.
>
> This means that surplus pages can accumulate right? This should be
> rather unlikely because one released huge page could then be reused for
> normal allocations - including vmemmap. Unlucky timing might still end
> up in the accumulation though. Not something critical though.

Agree.

>
> >  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
> >     offline_pages().
> >
> >     This is a bit unfortunate if we have plenty of ZONE_MOVABLE memory
> >     but are low on kernel memory. For example, migration of huge pages
> >     would still work, however, dissolving the free page does not work.
> >     This is a corner cases. When the system is that much under memory
> >     pressure, offlining/unplug can be expected to fail.
>
> Please mention that this is unfortunate because it prevents from the
> memory offlining which shouldn't happen for movable zones. People
> depending on the memory hotplug and movable zone should carefuly
> consider whether savings on unmovable memory are worth losing their
> hotplug functionality in some situations.

Make sense. I will mention this in the change log. Thanks.

>
> >  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
> >     alloc_contig_range() - once we have that handling in place. Mainly
> >     affects CMA and virtio-mem.
>
> What about hugetlb page poisoning on HW failure (resp. soft offlining)?

If the HW poisoned hugetlb page failed to be dissolved, the page
will go back to the free list with PG_HWPoison set. But the page
will not be used, because we will check whether the page is HW
poisoned when it is dequeued from the free list. If so, we will skip
this page.

>
> >
> >     Similar to 3). virito-mem will handle migration errors gracefully.
> >     CMA might be able to fallback on other free areas within the CMA
> >     region.
> >
> > We do not want to use GFP_ATOMIC to allocate vmemmap pages. Because it
> > grants access to memory reserves and we do not think it is reasonable
> > to use memory reserves. We use GFP_KERNEL in alloc_huge_page_vmemmap().
>
> This likely needs more context around. Maybe something like
> "
> Vmemmap pages are allocated from the page freeing context. In order for
> those allocations to be not disruptive (e.g. trigger oom killer)
> __GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
> because a non sleeping allocation would be too fragile and it could fail
> too easily under memory pressure. GFP_ATOMIC or other modes to access
> memory reserves is not used because we want to prevent consuming
> reserves under heavy hugetlb freeing.
> "

Thanks. I will use this to the change log.

>
> I haven't gone through the patch in a great detail yet, from a high
> level POV it looks good although the counter changes and reshuffling
> seems little wild. That requires a more detailed look I do not have time
> for right now. Mike would be much better for that anywya ;)

Yeah. Hope Mike will review this (I believe he is good at this area).

>
> I do not see any check for an atomic context in free_huge_page path. I
> have suggested to replace in_task by in_atomic check (with a gotcha that
> the later doesn't work without preempt_count but there is a work to
> address that).

Sorry. I forgot it. I will replace in_task with in_atomic in the next version.
Thanks for your suggestions.

> --
> Michal Hocko
> SUSE Labs
