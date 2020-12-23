Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757F2E152E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 03:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgLWCsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 21:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbgLWCsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:48:18 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C49C0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 18:47:37 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f17so9663144pge.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 18:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RxImZ5WYRvc5MqAscnk3rOKSiD33zPjRspOINuFOmk=;
        b=ZSofn4JpoLY62LuOFvyMLW+ht/GEoFFtWL44njivDzeC44346+fsAkf51YIrkwCt2u
         e2mpu3QIlWALgYyhUPkEOBqOTgcw9ONcKGAKeMFjoYsw+0+c/myum8tIRTLkx6Uovt3x
         vefkC30tlRJr9xGylZUk2ekApJbfFrL/zqxqYpbCV3u9e2tU4xB1l7JGNsLzUCzx8gKc
         aiD3IUH6WV7BuQgcmFP+vCAkkEilhHnrKQvlrcr0BMLsT8Fqai4rFo0sXus8YL16+hky
         ybNCa/sVjeKRTu9uF98dXi4tZ/Aw7wqr/1HzihhnIwwX8eYMX6FebuTri8TMrS3u/JhC
         CK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RxImZ5WYRvc5MqAscnk3rOKSiD33zPjRspOINuFOmk=;
        b=DXSVkk8YAQJ6ai0+6Hi2UGGpsCHJ/1ahCp+17G07SKAAc/s4qBomH0cA61NPs8TuEq
         3/223k7oTHvBA8JQalrureRr1jMvOnz7IwO4a4blVhT03JsZ5pT/8GkoyBTt7yK7neKg
         4bizK9f6CnNIv92PDMU8SMVOFb6RkF8MqLvkRufI4AmAYcnc2f9fKHI7fFujK4jASLDL
         PggcFJiioABPqwaC/ZiuHk8MjWvNRXvBzM5I/BSOVXqxIGA0a5BgVy62WCT470PlScZO
         jmuFI72Hhrl4Dn0Ve/fQTVEec7CBBwCfHFdsSRXiWEd0EqArtPHs1hGRcUGhjRfqr1y3
         iVFg==
X-Gm-Message-State: AOAM532DkSsHpwhHECc1lqMf+z6uVZcwmcPFzo8nSw2Q74558j2ZXRfR
        CgE2eE9Am9PC8PU46Q8Hzz0eTzONjgtaqya6LFzigg==
X-Google-Smtp-Source: ABdhPJy8EmvuJ4kATkeRW6z5LeXrJXJXVcrcQ/jIwvne3ldCQrTuBWBNVQlwzNU1j2RO4aEF/9ZHp8TsxaRao9smtm0=
X-Received: by 2002:a63:50a:: with SMTP id 10mr22501568pgf.273.1608691657419;
 Tue, 22 Dec 2020 18:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20201222142440.28930-1-songmuchun@bytedance.com>
 <20201222142440.28930-11-songmuchun@bytedance.com> <20201222162948.GA31385@linux>
In-Reply-To: <20201222162948.GA31385@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 23 Dec 2020 10:46:58 +0800
Message-ID: <CAMZfGtV6a9UYO0Gzs7QoTTY12vEUesYGnH762MM0JxnAfMHH+A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 10/11] mm/hugetlb: Gather discrete
 indexes of tail page
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
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 12:30 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Dec 22, 2020 at 10:24:39PM +0800, Muchun Song wrote:
> > +#else
> > +static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> > +{
> > +}
> > +
> > +static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
> > +                                     struct page *page)
> > +{
> > +     if (PageHWPoison(head) && page != head) {
> > +             /*
> > +              * Move PageHWPoison flag from head page to the raw error page,
> > +              * which makes any subpages rather than the error page reusable.
> > +              */
> > +             SetPageHWPoison(page);
> > +             ClearPageHWPoison(head);
> > +     }
> > +}
> > +#endif
>
> Sorry, I guess I should have made a more clear statement.
> This patch should really be about changing the numeric index to its symbolic
> names, so the #ifdef handling of hwpoison_subpage_* should have been gone into
> patch#6.

Because patch#6 is also compatible with !CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.
So I add the #ifdef handling in this patch. But moving it to patch#6
also makes sense to me. Thanks.

>
> I will have a closer look later on though.

Thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
