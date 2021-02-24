Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D4D323635
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 04:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhBXDtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 22:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhBXDtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 22:49:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF8C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 19:48:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k22so383308pll.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 19:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3jEBbY4A/UGX153lu2E72Jwi3lU4l9DJKDSt9tjW5Q=;
        b=oOOuEBK72Tmj/AsITLSIjEWrvt7HNB/gWSE+VBImqLREZdfVm1dpZI8mf4k72Hxa/i
         yz6rqpz2vNUXnB1OxaJodya7pzUj87q/qibBdEQMTtVsQVKfuzEhmJMzAfyJ+Mbb2Fn9
         i65JdEo2JKdsp/A2cpG5N6kMA2fCekFGx9tDv5NKfhPCcdKHU2CdBfmMMm9qnY9ovJr4
         hhaeVaGjHvJ65SuOfuxbvFjlLDme47Q8kr9h2QXnHT+HFfbH9RURUJIUHpk7pMQg3iw7
         eQ3kBof44riyepos3rgTe6Mcloz+QQOhOmUHH0OrAw8lEEZZJwuWTz+mTEgrTksKjtyT
         TX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3jEBbY4A/UGX153lu2E72Jwi3lU4l9DJKDSt9tjW5Q=;
        b=IkD4AaeCXHwmXZcJ1QQswpCuSjcMknw0LAm2s4juTq0FgpbNJPO2WjRAmjSicLGqRq
         sEXMhawemz1OXCvqdfd0JFtkopjW5kWzuyYoVzGBdV2ZZJlo3MP9wpBZ2V0auy6YfzYt
         tbNciEWpTMjn6xNPsSlRjmFT9vmT2ymRAuZlFq3MCU6cCWOVTD7KXX+tCPZXamT/eCcq
         iCSVM3Z/1Qu1hryXnQV9Q25r20A77K08NiHmhwzu/V7iBMK7kwqvZ9LUNmGW1COsRsQW
         ATmLk54Q0uafapIAr06V+Ffq4hVBrVhX7PsrHDYufJXuU7QvqokUKzVKjI6EgRlrsw2m
         kOWw==
X-Gm-Message-State: AOAM533b7JKsCAyE3h9dmJUyf4dHZeYAW8VC+sU08BltnnwmLmaR9R1P
        sYEKhf+efISnjE0p8dN6uYuEyRibLqYhA+Mc9R/g/A==
X-Google-Smtp-Source: ABdhPJzp43cIb2gX9ENgBjGVlI9FQm0pVDYzvzqm2ZG0XDH8tXJp7biWDBSXXBsr0JJO9Dml11ss+IuaBHVyoXMHfB8=
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr2148311pjk.229.1614138507328;
 Tue, 23 Feb 2021 19:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20210219104954.67390-1-songmuchun@bytedance.com>
 <20210219104954.67390-5-songmuchun@bytedance.com> <13a5363c-6af4-1e1f-9a18-972ca18278b5@oracle.com>
 <20210223092740.GA1998@linux> <CAMZfGtVRSBkKe=tKAKLY8dp_hywotq3xL+EJZNjXuSKt3HK3bQ@mail.gmail.com>
 <20210223104957.GA3844@linux> <20210223154128.GA21082@localhost.localdomain> <20210223223157.GA2740@localhost.localdomain>
In-Reply-To: <20210223223157.GA2740@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 24 Feb 2021 11:47:49 +0800
Message-ID: <CAMZfGtUBMzAgPVgm=9wgJg+yytxwSGOK_BVOw93RPLb3_tFS_g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v16 4/9] mm: hugetlb: alloc the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
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

On Wed, Feb 24, 2021 at 6:32 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Feb 23, 2021 at 04:41:28PM +0100, Oscar Salvador wrote:
> > On Tue, Feb 23, 2021 at 11:50:05AM +0100, Oscar Salvador wrote:
> > > > CPU0:                           CPU1:
> > > >                                 set_compound_page_dtor(HUGETLB_PAGE_DTOR);
> > > > memory_failure_hugetlb
> > > >   get_hwpoison_page
> > > >     __get_hwpoison_page
> > > >       get_page_unless_zero
> > > >                                 put_page_testzero()
> > > >
> > > > Maybe this can happen. But it is a very corner case. If we want to
> > > > deal with this. We can put_page_testzero() first and then
> > > > set_compound_page_dtor(HUGETLB_PAGE_DTOR).
> > >
> > > I have to check further, but it looks like this could actually happen.
> > > Handling this with VM_BUG_ON is wrong, because memory_failure/soft_offline are
> > > entitled to increase the refcount of the page.
> > >
> > > AFAICS,
> > >
> > >  CPU0:                                    CPU1:
> > >                                           set_compound_page_dtor(HUGETLB_PAGE_DTOR);
> > >  memory_failure_hugetlb
> > >    get_hwpoison_page
> > >      __get_hwpoison_page
> > >        get_page_unless_zero
> > >                                           put_page_testzero()
> > >         identify_page_state
> > >          me_huge_page
> > >
> > > I think we can reach me_huge_page with either refcount = 1 or refcount =2,
> > > depending whether put_page_testzero has been issued.
> > >
> > > For now, I would not re-enqueue the page if put_page_testzero == false.
> > > I have to see how this can be handled gracefully.
> >
> > I took a brief look.
> > It is not really your patch fault. Hugetlb <-> memory-failure synchronization is
> > a bit odd, it definitely needs improvment.
> >
> > The thing is, we can have different scenarios here.
> > E.g: by the time we return from put_page_testzero, we might have refcount ==
> > 0 and PageHWPoison, or refcount == 1 PageHWPoison.
> >
> > The former will let a user get a page from the pool and get a sigbus
> > when it faults in the page, and the latter will be even more odd as we
> > will have a self-refcounted page in the free pool (and hwpoisoned).

I have been looking at the dequeue_huge_page_node_exact().
If a PageHWPoison huge page is in the free pool list, the page will
not be allocated to the user. The PageHWPoison huge page
will be skip in the dequeue_huge_page_node_exact().

> >
> > As I said, it is not this patchset fault. I just made me realize this
> > problem.
> >
> > I have to think some more about this.
>
> I have been thinking more about this.
> memory failure events can occur at any time, and we might not be in a
> position where we can handle gracefully the error, meaning that the page
> might end up in non desirable state.
>
> E.g: we could flag the page right before enqueing it.
>
> I still think that VM_BUG_ON should go, as the refcount can be perfectly
> increased by memory-failure/soft_offline handlers, so BUGing there does
> not make much sense.

Make sense. I will remove the VM_BUG_ON.

>
> One think we could do is to check the state of the page we want to
> retrieve from the free hugepage pool.
> We should discard any HWpoisoned ones, and dissolve them.
>
> The thing is, memory-failure/soft_offline should allocate a new hugepage
> for the free pool, so keep the pool stable.
> Something like [1].
>
> Anyway, this is orthogonal to this patch, and something I will work on
> soon.
>
> [1] https://lore.kernel.org/linux-mm/20210222135137.25717-2-osalvador@suse.de/T/#u

Thanks for your efforts on this.

>
> --
> Oscar Salvador
> SUSE L3
