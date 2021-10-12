Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCD429AA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 02:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhJLA5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 20:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231905AbhJLA5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634000137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XDAu3SGcluw99zx826t100OV6JMSzpG+T+53hkiL5g=;
        b=K09u9CQ4/2KFzfVf43Z08XpiGplBvJdyZZNnZwk6r3z23ioZxkIgxG+kt/spMGIb6us9nm
        AO+X4/dWyGvUOn+nygdHDuo11AsLb/zvM0hLU+H4FZQZE/tBfiXewQQbC3qxBfmikSWTgL
        tOT4RtVBm614aE3/jaTBWoWaFx6+t8g=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-8HYEjQR_PUC-yhqDTPxAtg-1; Mon, 11 Oct 2021 20:55:36 -0400
X-MC-Unique: 8HYEjQR_PUC-yhqDTPxAtg-1
Received: by mail-pj1-f71.google.com with SMTP id oo5-20020a17090b1c8500b0019e585e8f6fso565824pjb.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 17:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XDAu3SGcluw99zx826t100OV6JMSzpG+T+53hkiL5g=;
        b=Iu2JlggpgU7m6IyoyQqcr/FlEYRmWKBGirG9ZtXtrj5xb9/xznpiUqsjzEPAPEimIF
         ml/1STLgetpdE8Zk6XI4LuzhWH7RUIvifZ3OJ9++c4Vv2/4jmaqSDsl3tgcQ0Ry5QBv+
         sHnHIjR1lJENeJD9mM58bbijRD1MVMiK8NV34i6xan7xjxQ4cgyRNiNWDJFpQb8UYvXg
         s2m5I/UpCS/X9pogieosPuv9FiH+UKiRjDPEFxxMKUwCe+EnjmnNgV4Oxsh16giD9NMA
         u9DuKg3LyZ6f/i18HjEDpPZvAU2quW84XgaFEUM3Bv43I548knqufhkzrRNqnFVWQF2T
         AwEg==
X-Gm-Message-State: AOAM531JhQmGOgGBw67zljlO80u9RUeHjEIWDRlq6/1cOok7FAx6LFAX
        0C2hXrd+/PvYUahhrs01Q3xgnKv3hPtt6boqUqXevpPSPiC/CoSXOF9J1Z8YhUMeBSdRbm+MEyk
        HA1R+lyVfKDgBZ6yKMyonGOS1qA==
X-Received: by 2002:a17:90a:5583:: with SMTP id c3mr2475840pji.133.1634000135064;
        Mon, 11 Oct 2021 17:55:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiMrYc31WKAIet63PwjB3iBU25JIVgyGtttIqJYbNFV+SGkFsxX1I3SP8DPzgGL+Ed6sKQAA==
X-Received: by 2002:a17:90a:5583:: with SMTP id c3mr2475808pji.133.1634000134583;
        Mon, 11 Oct 2021 17:55:34 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z9sm578759pji.42.2021.10.11.17.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 17:55:33 -0700 (PDT)
Date:   Mon, 11 Oct 2021 20:55:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YWTc/n4r6CJdvPpt@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 07, 2021 at 02:28:35PM -0700, Yang Shi wrote:
> On Wed, Oct 6, 2021 at 4:57 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Oct 6, 2021 at 1:15 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > > @@ -1148,8 +1148,12 @@ static int __get_hwpoison_page(struct page *page)
> > > >               return -EBUSY;
> > > >
> > > >       if (get_page_unless_zero(head)) {
> > > > -             if (head == compound_head(page))
> > > > +             if (head == compound_head(page)) {
> > > > +                     if (PageTransHuge(head))
> > > > +                             SetPageHasHWPoisoned(head);
> > > > +
> > > >                       return 1;
> > > > +             }
> > > >
> > > >               pr_info("Memory failure: %#lx cannot catch tail\n",
> > > >                       page_to_pfn(page));
> > >
> > > Sorry for the late comments.
> > >
> > > I'm wondering whether it's ideal to set this bit here, as get_hwpoison_page()
> > > sounds like a pure helper to get a refcount out of a sane hwpoisoned page.  I'm
> > > afraid there can be side effect that we set this without being noticed, so I'm
> > > also wondering we should keep it in memory_failure().
> > >
> > > Quotting comments for get_hwpoison_page():
> > >
> > >  * get_hwpoison_page() takes a page refcount of an error page to handle memory
> > >  * error on it, after checking that the error page is in a well-defined state
> > >  * (defined as a page-type we can successfully handle the memor error on it,
> > >  * such as LRU page and hugetlb page).
> > >
> > > For example, I see that both unpoison_memory() and soft_offline_page() will
> > > call it too, does it mean that we'll also set the bits e.g. even when we want
> > > to inject an unpoison event too?
> >
> > unpoison_memory() should be not a problem since it will just bail out
> > once THP is met as the comment says:
> >
> > /*
> > * unpoison_memory() can encounter thp only when the thp is being
> > * worked by memory_failure() and the page lock is not held yet.
> > * In such case, we yield to memory_failure() and make unpoison fail.
> > */
> >
> >
> > And I think we should set the flag for soft offline too, right? The
> > soft offline does set the hwpoison flag for the corrupted sub page and
> > doesn't split file THP, so it should be captured by page fault as
> > well. And yes for poison injection.
> 
> Err... I must be blind. The soft offline does *NOT* set hwpoison flag
> for any page. So your comment does stand. The flag should be set
> outside get_hwpoison_page().

I saw that page_handle_poison() sets it, so perhaps we do need to take care of
soft offline?  Though I still think the extra bit should be set outside of the
get_hwpoison_page() function.

Another thing is I noticed soft_offline_in_use_page() will still ignore file
backed split.  I'm not sure whether it means we'd better also handle that case
as well, so shmem thp can be split there too?

-- 
Peter Xu

