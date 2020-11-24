Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA362C2606
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgKXMqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 07:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387599AbgKXMqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:46:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327DC061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 04:46:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w187so3886521pfd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvMoedg9c3vAj7qTNNLGhSdFiVG9vOlTW6cU7Q9XeFo=;
        b=FrdMPUpDEFFjBtYI8z4IeWI2Z4ohddd3ZcheGrplS0kTOmz4h18rj8yx1KD0p94H/4
         4da07fC+FGhGMT861t9xebrdtDKWv9GNFNa7UdYTDzRWtSm8THlMn+8gUcHPYDBgU4BG
         0Ioe9Otk2VxnLl3jVXir6r5KJbCI/ivA9S5xTRVUBw7Q0usttObbgvmqqTbLfu3cCPpP
         gjzox5FYTLPTL7hND87YVmaJkLBvFPmyYgeJF/5aqmejfQ7Pst18yDrJ+VYwlnnykvgZ
         eJjGrnH6KVtJNyy+toC6DpaYps582AB+j+Zu9MrYeWS5JSy1WQj/QILf892bEpx8fxwL
         DhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvMoedg9c3vAj7qTNNLGhSdFiVG9vOlTW6cU7Q9XeFo=;
        b=QL4KbBo1KiN7BA4cdzYPQixGhFzABHHljIjX5WzJTFKhmpRCXixcS9GXiRjEnWkX2H
         IdsmhV+qX4OjIItGRuy+jx40Py99QudOWS25/G+DuzPPQaF5p45vglD6Vnk3IKnV5WhY
         ipeFXQSTiJDevrW9iI+xrGOMcKppc/NuICbWqTCeo9+gk8fs/1rgBHI51Ovj29lUJrNF
         Cdj9yBxcDH77qvRne/6i5O6oQZ+H2ZmBIUGCM21tmI0S0QbpFM0t6aicZBqWk4Xqmt2s
         Nca5ak5FGYZXZc+ltfLkeR0v2yPq18jH1RJYs2kbszOFBl72Ek4XygCYBQ1bH45YT/oe
         jDfQ==
X-Gm-Message-State: AOAM530Y1GMD1qEYi0UzqCf87Nc5uNC0Dp3ibUO5E+jXqQ06pgIGG6KS
        xNdwIldmE1r5DQePkTrMfB8/OBJm/fFTKYwlQ1KYBg==
X-Google-Smtp-Source: ABdhPJw4zreHDeiqTrvJd7toGaCPcJpurHA+IsBwgCC6p/FqJZJI2OUo3Y313QMps8SXpsVjl4nPz3fGSgYe8qccqlw=
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr4752466pjb.147.1606221969905;
 Tue, 24 Nov 2020 04:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-10-songmuchun@bytedance.com> <20201124115109.GW27488@dhcp22.suse.cz>
In-Reply-To: <20201124115109.GW27488@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 24 Nov 2020 20:45:30 +0800
Message-ID: <CAMZfGtV=_=f-AybncRDxyp9FB3e499RuPCz5B-8R2Or7285MrQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 09/16] mm/hugetlb: Defer freeing of
 HugeTLB pages
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

On Tue, Nov 24, 2020 at 7:51 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 24-11-20 17:52:52, Muchun Song wrote:
> > In the subsequent patch, we will allocate the vmemmap pages when free
> > HugeTLB pages. But update_and_free_page() is called from a non-task
> > context(and hold hugetlb_lock), so we can defer the actual freeing in
> > a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.
>
> This has been brought up earlier without any satisfying answer. Do we
> really have bother with the freeing from the pool and reconstructing the
> vmemmap page tables? Do existing usecases really require such a dynamic
> behavior? In other words, wouldn't it be much simpler to allow to use

If someone wants to free a HugeTLB page, there is no way to do that if we
do not allow this behavior. When do we need this? On our server, we will
allocate a lot of HugeTLB pages for SPDK or virtualization. Sometimes,
we want to debug some issues and want to apt install some debug tools,
but if the host has little memory and the install operation can be failed
because of no memory. In this time, we can try to free some HugeTLB
pages to buddy in order to continue debugging. So maybe we need this.

> hugetlb pages with sparse vmemmaps only for the boot time reservations
> and never allow them to be freed back to the allocator. This is pretty
> restrictive, no question about that, but it would drop quite some code

Yeah, if we do not allow freeing the HugeTLB page to buddy, it actually
can drop some code. But I think that it only drop this one and next one
patch. It seems not a lot. And if we drop this patch, we need to add some
another code to do the boot time reservations and other code to disallow
freeing HugeTLB pages. So why not support freeing now.

> AFAICS and the resulting series would be much easier to review really
> carefully. Additional enhancements can be done on top with specifics
> about usecases which require more flexibility.

The code of allocating vmemmap pages for the HugeTLB page is very
similar to the freeing vmemmap pages. The two operations are opposite.
I think that if someone can understand the freeing path, it is also easy
for him to understand the allcating path. If you look at close to this patch,
I believe that it is easy for you.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c         | 96 ++++++++++++++++++++++++++++++++++++++++++++++------
> >  mm/hugetlb_vmemmap.c |  5 ---
> >  mm/hugetlb_vmemmap.h | 10 ++++++
> >  3 files changed, 95 insertions(+), 16 deletions(-)
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
