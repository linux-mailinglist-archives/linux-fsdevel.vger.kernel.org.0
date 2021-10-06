Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670754235DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 04:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhJFChk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 22:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFChj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:37:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3E8C061749;
        Tue,  5 Oct 2021 19:35:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l7so4026452edq.3;
        Tue, 05 Oct 2021 19:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85A/CcRPHhhXw8lA9VmoZH5xmu6YeHwEGNssFuE34AM=;
        b=alPUn4l6o6zYJDg47kJX2QWqgVy1dfmAl6MARjpJwoFFmt6O9svnYVl17zWhBuHyJk
         V2yp/fI9QC5UMDWbsL58PiIGY3Djgw5xVFae0JgbNrLyuRGQFcdgrQ21DnJuTG77LSI8
         aBi+OGA7HT3C2vMnN+NeEvZl8U2AsDcNjgMMP/LtSjR6CnmuD0NDJRQti43dzJMQcoFj
         FzCQNsKnHa+XaRvi2Si1r4UYGt3S4vNOmZEvHE4KOfpsx2iKx4ZVqeNSOD7s4UsEwQgG
         ut1DNHUUgP8l3Hv4bQ7shtXEYnC9+/TPfQTCHvJva+pIfOu5LEJKowM6Ptf7HKPpt6ux
         1BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85A/CcRPHhhXw8lA9VmoZH5xmu6YeHwEGNssFuE34AM=;
        b=y3q9CjNWEXO+CvzvYx/Ocdb2kkIz3loXKjzSdfNnEWH0ouv5f0qUIbuPYS9sYlr9N5
         n7bC5w6XnGbqYpimJ1eYwrQC2HpQjUamZ8n7jFuSoj5IucoQr/H6rHZg43n6NxoZAehe
         nglGyECbyUywFw9sNXHYVORSebZJnjdjuMp7Q1fxu/g6Qo+tUy+bmIXmt97/8MCxqz2B
         zFszpHIaqAjjqlPVMlRfxhB+Rn4Kxs6zB/eo0lyrFPa0lcV58QsvPfIT/PXTKWEOtdy0
         ipUlYrdL29ZFW/+LzVlFzKnn8GOcGJnMCK5SvkCEXTvu+hfmmT4zQDJyB/QNneNpOGIA
         zcTg==
X-Gm-Message-State: AOAM5324/oTHQW5gpPVcYxyUK7BXv2U9H3017+lYhY0K40hQkdfCILRf
        elOgquAMJSJfNeZC+cxgPcNVv3vCfPvUuTsdJZcjGZfQ
X-Google-Smtp-Source: ABdhPJyjAEY2McGhuJwN9uhBXqn2n0pq+eQv3ZQT2FMbgOKU8q35tglFj/tBCEY2Y6naGmP74j/r/2eCHEd1y05zMKQ=
X-Received: by 2002:a50:8d85:: with SMTP id r5mr30685431edh.312.1633487747024;
 Tue, 05 Oct 2021 19:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-2-shy828301@gmail.com>
In-Reply-To: <20210930215311.240774-2-shy828301@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 5 Oct 2021 19:35:35 -0700
Message-ID: <CAHbLzkpyxnvm3w0M_CEU7cYRCYr0coNCoiY1DvtnBzqb1R1nsw@mail.gmail.com>
Subject: Re: [v3 PATCH 1/5] mm: hwpoison: remove the unnecessary THP check
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Naoya,

Any comment on this patch and patch #3? I'd prefer to fix more
comments for a new version.

Thanks,
Yang


On Thu, Sep 30, 2021 at 2:53 PM Yang Shi <shy828301@gmail.com> wrote:
>
> When handling THP hwpoison checked if the THP is in allocation or free
> stage since hwpoison may mistreat it as hugetlb page.  After
> commit 415c64c1453a ("mm/memory-failure: split thp earlier in memory error
> handling") the problem has been fixed, so this check is no longer
> needed.  Remove it.  The side effect of the removal is hwpoison may
> report unsplit THP instead of unknown error for shmem THP.  It seems not
> like a big deal.
>
> The following patch depends on this, which fixes shmem THP with
> hwpoisoned subpage(s) are mapped PMD wrongly.  So this patch needs to be
> backported to -stable as well.
>
> Cc: <stable@vger.kernel.org>
> Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/memory-failure.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 54879c339024..ed28eba50f98 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1147,20 +1147,6 @@ static int __get_hwpoison_page(struct page *page)
>         if (!HWPoisonHandlable(head))
>                 return -EBUSY;
>
> -       if (PageTransHuge(head)) {
> -               /*
> -                * Non anonymous thp exists only in allocation/free time. We
> -                * can't handle such a case correctly, so let's give it up.
> -                * This should be better than triggering BUG_ON when kernel
> -                * tries to touch the "partially handled" page.
> -                */
> -               if (!PageAnon(head)) {
> -                       pr_err("Memory failure: %#lx: non anonymous thp\n",
> -                               page_to_pfn(page));
> -                       return 0;
> -               }
> -       }
> -
>         if (get_page_unless_zero(head)) {
>                 if (head == compound_head(page))
>                         return 1;
> --
> 2.26.2
>
