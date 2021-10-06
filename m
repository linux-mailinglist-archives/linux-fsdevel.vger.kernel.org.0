Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8880D424ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 01:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbhJFX7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 19:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhJFX7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:59:44 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06FDC061746;
        Wed,  6 Oct 2021 16:57:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id d8so16041968edx.9;
        Wed, 06 Oct 2021 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3kwNDEY68OIwU8Je8RDowqnTfHPIHgvZzXHiiUTic4=;
        b=d/kT/ON2cmX4+vA2KqMxHsfjLTtYnJwPqvnfOukGEPxSSZ/GvLYKK8ZqBbxX6/uNRN
         gX4mSv7tqBcRrv4xthfBorbjKb1F7KThxFM55jvVHjfCIzhbkTY73sAjSXhWNB/qUgxP
         drtgusD6XAFCdTj0bBWvcER1gw0Q4r+8UBz23u0kYEZtZPSpTGET8E5O1llXAKk5DBxh
         MT+1EECqLY+IbKScKWrL+bF3HqmiXcamInnjYdDpu7GR0Y4Q5feYToEN5fHIFyG6Hlej
         MIYR9IMn1pjUbR5iUMnHeZZAjFGTc0wuVsVmRVhhIfyJbyIe0QRmx1+n6pc/XsJvmj9+
         aCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3kwNDEY68OIwU8Je8RDowqnTfHPIHgvZzXHiiUTic4=;
        b=4f+rCY/hzfKKplHBmSZb5cTEd7aQeOvG4XhuKH70Gpa0nRrTCYAf8BsGFVl2sFBDgo
         B4bT43DJYIswdCowkPqsNtQNDvqYiE/TmpSfspOVT04f3Dvfq9I+rVQWuHQTmPLVBsvK
         rkmNrBnWnwQ4CTZNixt2l+EC0Q/UvKCWNuQG7IDrVnzH+DO+JIi7Q+UuLZY1Q+DNTMvh
         S52XMfYoNyMOKaSZYIRO6friooJ6tK0vz1IIcE1QqxFnFzP4EAhwoDKdabXKhyS5q4lb
         mM/1aj5G6ixazLgoMK8zW2QF6Kx6RaEkE09Ycr11wkJPYrEkavan845s9be2qPQXcso+
         nvAg==
X-Gm-Message-State: AOAM530yuFhn2X24sVC8bRz5O71azaqdJwDh/AXtsjAgyxpe4b4nvrE+
        FpmDGb2jYoHV4BdwnKWSAkmIC1mqREq1QZ6VOgw=
X-Google-Smtp-Source: ABdhPJwVIbepnjWWz19zXaJafbtP/dZf6+Rn+UlMzvQw55V7S7jLI+XUI3omHo4rLNzH0BN5KP/IIYvljuQdhR1vZjI=
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr1495026ejb.555.1633564670339;
 Wed, 06 Oct 2021 16:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
In-Reply-To: <YV4Dz3y4NXhtqd6V@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 Oct 2021 16:57:38 -0700
Message-ID: <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 6, 2021 at 1:15 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > @@ -1148,8 +1148,12 @@ static int __get_hwpoison_page(struct page *page)
> >               return -EBUSY;
> >
> >       if (get_page_unless_zero(head)) {
> > -             if (head == compound_head(page))
> > +             if (head == compound_head(page)) {
> > +                     if (PageTransHuge(head))
> > +                             SetPageHasHWPoisoned(head);
> > +
> >                       return 1;
> > +             }
> >
> >               pr_info("Memory failure: %#lx cannot catch tail\n",
> >                       page_to_pfn(page));
>
> Sorry for the late comments.
>
> I'm wondering whether it's ideal to set this bit here, as get_hwpoison_page()
> sounds like a pure helper to get a refcount out of a sane hwpoisoned page.  I'm
> afraid there can be side effect that we set this without being noticed, so I'm
> also wondering we should keep it in memory_failure().
>
> Quotting comments for get_hwpoison_page():
>
>  * get_hwpoison_page() takes a page refcount of an error page to handle memory
>  * error on it, after checking that the error page is in a well-defined state
>  * (defined as a page-type we can successfully handle the memor error on it,
>  * such as LRU page and hugetlb page).
>
> For example, I see that both unpoison_memory() and soft_offline_page() will
> call it too, does it mean that we'll also set the bits e.g. even when we want
> to inject an unpoison event too?

unpoison_memory() should be not a problem since it will just bail out
once THP is met as the comment says:

/*
* unpoison_memory() can encounter thp only when the thp is being
* worked by memory_failure() and the page lock is not held yet.
* In such case, we yield to memory_failure() and make unpoison fail.
*/


And I think we should set the flag for soft offline too, right? The
soft offline does set the hwpoison flag for the corrupted sub page and
doesn't split file THP, so it should be captured by page fault as
well. And yes for poison injection.

But your comment reminds me that get_hwpoison_page() is just called
when !MF_COUNT_INCREASED, so it means MADV_HWPOISON still could
escape. This needs to be covered too.

BTW, I did the test with MADV_HWPOISON, but I didn't test this change
(moving flag set after get_page_unless_zero()) since I thought it was
just a trivial change and did overlook this case.

>
> Thanks,
>
> --
> Peter Xu
>
