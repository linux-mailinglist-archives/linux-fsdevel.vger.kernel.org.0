Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7622D3F9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgLIKMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgLIKMH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:12:07 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB09C061793
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 02:11:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so691807plo.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 02:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8yNDgYWASv11UhUw/bWcMz19H0C2yz7qXfuD0bhUn0=;
        b=dmAazBXoyUeAWM3edEVyWfiXKxv66KTgKIwyOz0VOteoRRUk7F3ylzt43TAE3VMM8Q
         1sFsmFSjj63jlXMen3WT9Urn7Q2qLWZlj/66N9zfy28SAr77QjrM/kjt9v6gTeAZ2/2Q
         DxWcZVRg8JuBlOn1nCXBjiwDKXFW2UrRAxKKutGUL0No8NJ0uU46GIErudp/1bpk2YOV
         3iug93DTUMEW2TAmeCsIw3wEhf9IHF6uOKwqCNO1Hpl26TMxv9bmpX9TmdEvCRvUfsXA
         OCgNgwTE8xwzTzA2JxXQOVrq4aT16xBpCrfgLj1GoHU8UovIah/xqh1uMCcQl+Rf6li8
         QDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8yNDgYWASv11UhUw/bWcMz19H0C2yz7qXfuD0bhUn0=;
        b=ZseoMG0CzFhf6+T8zpqB501dYEKXH4tR6H4AayrMuKtIpmazMk7YgxvgOFdHmxELFs
         5Ri531EOAnEwmjp0Vhyh5B/r3x/lwTpy5AqjgK9oTn/lfzZ+S+X7mMjxgJYeB9d9Tg0f
         6AxQS/mJPlw3aMSN5bso1Y14EimxqNAJ700+Etlpe4FdqJFhvceKSbnEJwBfxW12yhe2
         zu/xK46u87WVvneXttWzscIaLGmDzonmK7Z9iyAsXbjORsk4/ZGYLuxf78VdgWw25JxY
         ZQe36OgQukSkEC4b2f6Yjpx3t81djmndR2+lrCLh7ax0h9cSCPrsoOCB/1w+gAAlpC24
         /g+g==
X-Gm-Message-State: AOAM530II6ubg23BBWMCIx0iRj3xP7zbBASV0gwyA9HdOQY/up1hJRga
        PKwTCI6wKErVyQfncG/2s1qpZfHnRota5yTOWLC4mg==
X-Google-Smtp-Source: ABdhPJyZbpmo6sQ/giSzPaUJeLNjnQbqSMGyDjlFlX08gqr+lliLp5PTVbu7rjbOxMBdYCStZdmNjSw4u/bBranfZic=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr1578160pjq.13.1607508686459;
 Wed, 09 Dec 2020 02:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-7-songmuchun@bytedance.com> <ba57ea7d-709b-bf36-d48a-cc72a26012cc@redhat.com>
 <CAMZfGtV5200NZXH9Z_Z9qXo5FCd9E6JOTXjQtzcF0xGi-gCuPg@mail.gmail.com> <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com>
In-Reply-To: <4b8a9389-1704-4d8c-ec58-abd753814dd9@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 9 Dec 2020 18:10:50 +0800
Message-ID: <CAMZfGtURKbRingD28boJoZ+MjMTcr7L8mOWPX+hQF9nVLV6S9w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 06/15] mm/hugetlb: Disable freeing
 vmemmap if struct page size is not power of two
To:     David Hildenbrand <david@redhat.com>
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
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 6:06 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 09.12.20 11:03, Muchun Song wrote:
> > On Wed, Dec 9, 2020 at 5:57 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 30.11.20 16:18, Muchun Song wrote:
> >>> We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
> >>> when the size of struct page is a power of two.
> >>>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  mm/hugetlb_vmemmap.c | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> >>> index 51152e258f39..ad8fc61ea273 100644
> >>> --- a/mm/hugetlb_vmemmap.c
> >>> +++ b/mm/hugetlb_vmemmap.c
> >>> @@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >>>       unsigned int nr_pages = pages_per_huge_page(h);
> >>>       unsigned int vmemmap_pages;
> >>>
> >>> +     if (!is_power_of_2(sizeof(struct page))) {
> >>> +             pr_info("disable freeing vmemmap pages for %s\n", h->name);
> >>
> >> I'd just drop that pr_info(). Users are able to observe that it's
> >> working (below), so they are able to identify that it's not working as well.
> >
> > The below is just a pr_debug. Do you suggest converting it to pr_info?
>
> Good question. I wonder if users really have to know in most cases.
> Maybe pr_debug() is good enough in environments where we want to debug
> why stuff is not working as expected.

When someone enables this feature via the boot cmdline, maybe he should
want to know whether this feature works. From this point of view, the pr_info
is necessary. Right?

>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
