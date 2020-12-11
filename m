Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0100B2D777B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393752AbgLKOKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 09:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbgLKOKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:10:17 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D9FC0617A6
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 06:09:20 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id iq13so2250715pjb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 06:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJUsAyZid8ZpUCO1A6kJYtQfMdu1p6LphB094f0w3bg=;
        b=Aj8ew0Hu3yHmTNKkdhjZ+X6b43SrHaczF4qZhuusrFL6cDfM/7VhTojRP/QDHzTBgT
         iDuj+C/tHmdYwmm3ovc+i3N17HKVh7cYSnCelcgWY6O35mMi2Hu2VjqHvqEp96zhjev4
         bZF/f0upjqsusL81IM5qMfVkpPR8mmnU4STGZxHf6Lw68FsEjUq+PRoTZ1HtyxQysEyG
         fsawhedIjAPMW9279hsd3DFuGCQ+oKgIdwYrTdcM3PcFdVjVktEb/zZXpIwfIbkWAYOh
         ErnmdqTBkSBXpel99roVOLdClBLUeF3AUteTb4o7wLJdhlLKA+6IYVvPF3py6NLkTwBB
         5WEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJUsAyZid8ZpUCO1A6kJYtQfMdu1p6LphB094f0w3bg=;
        b=TPgvDvJoNYfdCmSFJHrhYv1LTn6MNgVaBf3CICNgtZWHyuJFns9sfsDwhUyVgRHxGO
         1D82RrYgd++GsbPuQKUDJaoIGyVXFwvt505kywYqOZmaz2B54EngnDPM4p631F3d6K0t
         XJjA/KHd7OVmK7GJZGOfNbCkUJz6YUR38Exygn2VOpn0v2WUcon+K4nKdHLNDpG/g9jB
         xZ2+0PiEBPlSmwuaki7MNoGg5hziQ6PVaP5rY3oumYiwnBR1OrpklQv+xE+DebJlBVS2
         Bxuto+iut+ft61ijwyIvZAWUofDuxSeu6oLur5dQPnTNLgGDqoaElHoLyXXnq39mfNJB
         0uOA==
X-Gm-Message-State: AOAM532XgY/+K4Bm5d5jTa4pXOapkd3nqIB6sssLbLo0E4G3AXdhp35T
        9IhRPu6OQrP+JQQPx5yo06paXyWDuS8au64OR/MYIw==
X-Google-Smtp-Source: ABdhPJwrLNBJOldmJmyWaGlf9L4YnEd4a4zJ98KF8M3D+Gy0rq+4D6xov12z8j4f0zvZiLabKSGqTiyYXwKPUSSjrQM=
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id
 j8-20020a17090276c8b02900d9d6c3357dmr11055737plt.34.1607695759816; Fri, 11
 Dec 2020 06:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-8-songmuchun@bytedance.com> <20201211133624.GA27050@linux>
In-Reply-To: <20201211133624.GA27050@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Dec 2020 22:08:43 +0800
Message-ID: <CAMZfGtXFtzJBifOrB2XdCrpazGP5MDuU3mp1Uag+TGLE3w49yw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 07/12] mm/hugetlb: Set the PageHWPoison
 to the raw error page
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 11, 2020 at 9:36 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 11:55:21AM +0800, Muchun Song wrote:
> > +static inline void subpage_hwpoison_deliver(struct hstate *h, struct page *head)
> > +{
> > +     struct page *page = head;
> > +
> > +     if (!free_vmemmap_pages_per_hpage(h))
> > +             return;
> > +
> > +     if (PageHWPoison(head))
> > +             page = head + page_private(head + 4);
> > +
> > +     /*
> > +      * Move PageHWPoison flag from head page to the raw error page,
> > +      * which makes any subpages rather than the error page reusable.
> > +      */
> > +     if (page != head) {
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
> > +}
>
> I would make the names coherent.
> I am not definitely goot at names, but something like:
> hwpoison_subpage_{foo,bar} looks better.

It's better than mine. Thank you.

>
> Also, could not subpage_hwpoison_deliver be rewritten like:
>
>   static inline void subpage_hwpoison_deliver(struct hstate *h, struct page *head)
>   {
>        struct page *page;
>
>        if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
>                return;
>
>        page = head + page_private(head + 4);
>        /*
>         * Move PageHWPoison flag from head page to the raw error page,
>         * which makes any subpages rather than the error page reusable.
>         */
>        if (page != head) {
>                SetPageHWPoison(page);
>                ClearPageHWPoison(head);
>        }
>   }
>
> I think it is better code-wise.

Will do. Thank you.

>
> > +      * Move PageHWPoison flag from head page to the raw error page,
> > +      * which makes any subpages rather than the error page reusable.
> > +      */
> > +     if (page != head) {
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
>
> I would put this in an else-if above:
>
>         if (free_vmemmap_pages_per_hpage(h)) {
>                 set_page_private(head + 4, page - head);
>                 return;
>         } else if (page != head) {
>                 SetPageHWPoison(page);
>                 ClearPageHWPoison(head);
>         }
>
> or will we lose the optimization in case free_vmemmap_pages_per_hpage gets compiled out?
>

Either is OK. The compiler will help us optimize the code when
free_vmemmap_pages_per_hpage always returns false.

Thanks for your suggestions. :-)

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
