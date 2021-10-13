Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A207D42B322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 05:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhJMDLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 23:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhJMDLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:11:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AFBC061570;
        Tue, 12 Oct 2021 20:09:38 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a25so3975885edx.8;
        Tue, 12 Oct 2021 20:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCj1lkjwgbEmXu7cDtw3vmGVDAughdgaboyPo11IbyY=;
        b=gPg+9TXyXNbceMu0iZnHpqvcf/Dh8NUumwo5xVdgEzqQSBBRrM3O5An820DO8O/oPE
         I27gQ4e6omZrGCP9BZKNEqMjuoWXuqHfvmT0BtkdvKlX/afPEiihw0hOvsyQwbipoM6r
         JIt3oC8nckpl0NKL/Le5xeyZdnSSCJm334CwpRGYrfVd7Xcz648acE1gi5+TSB30kLED
         a5RPKNXRr2rQmmtNT+veO7ICttJac/qsZ64t/77ef+7mWbzWXMdDwMpMm3m0h/BlbRY4
         0GtqwLaEtL6a0vaOjGmktsJtnhMEwnhCGS+dO4I/zdKegxFqBncJ4lwyb+s3qBO2OClB
         7ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCj1lkjwgbEmXu7cDtw3vmGVDAughdgaboyPo11IbyY=;
        b=0Ic+9Ft3hzWGYJ1ABOy1uDs91msTZu5eMCTjwwAEq8x3LNCLkdrmEz7dX/m+a8hCD/
         qANfKjmHf+1gnIw0hVlNIqTVgOvRYwaYgKOd3NVx/Wc4RYjXjZGPCrTxsZvjMnEf/tw1
         SGRizrXNsTaKYOKpnFOrO/T1qbJcgYSrtOwYQiLnHtMACMXaE2dW5nIngiQdjq0V6B/T
         Nwqeelapcv7QGdKM/GSRxk538AOZnrZWaoBWvfIOjQv7bNKMkT4LLUQw32B9+v63q2gj
         riVs9Mwmsg8nU66A9YR0upQuoxgBU0Jz0ji4JvoxXVeyRX2++2OxVR/3XwcJOfNHrKUw
         ZkVQ==
X-Gm-Message-State: AOAM530FJTXuGjIFjzHRXrKWylB4/8oa9upvFU6vavB1LomwHRipsoGH
        4gfc6jem71srNU4Kfa9fHOkrCamZN3sblPPQ6X0=
X-Google-Smtp-Source: ABdhPJyuYJsTNqDNqpkO4cOocgXz+Ee+xNW+iBResKEZMLhch/S4NGvSvXFfukNYWy8lXyaKHbkK9TaixmdPHneWpoA=
X-Received: by 2002:a05:6402:1e8c:: with SMTP id f12mr5508316edf.71.1634094576961;
 Tue, 12 Oct 2021 20:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <YWZHOYgFrMYbmNA/@t490s>
In-Reply-To: <YWZHOYgFrMYbmNA/@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 20:09:24 -0700
Message-ID: <CAHbLzkoz6Gm31Qz-u_ohR6NK2RRE5OdEkSq_3t9Cjwkqf1+a7w@mail.gmail.com>
Subject: Re: [RFC v3 PATCH 0/5] Solve silent data loss caused by poisoned page
 cache (shmem/tmpfs)
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

On Tue, Oct 12, 2021 at 7:41 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:06PM -0700, Yang Shi wrote:
> > Yang Shi (5):
> >       mm: hwpoison: remove the unnecessary THP check
> >       mm: filemap: check if THP has hwpoisoned subpage for PMD page fault
> >       mm: hwpoison: refactor refcount check handling
> >       mm: shmem: don't truncate page if memory failure happens
> >       mm: hwpoison: handle non-anonymous THP correctly
>
> Today I just noticed one more thing: unpoison path has (unpoison_memory):
>
>         if (page_mapping(page)) {
>                 unpoison_pr_info("Unpoison: the hwpoison page has non-NULL mapping %#lx\n",
>                                  pfn, &unpoison_rs);
>                 return 0;
>         }
>
> I _think_ it was used to make sure we ignore page that was not successfully
> poisoned/offlined before (for anonymous), so raising this question up on
> whether we should make sure e.g. shmem hwpoisoned pages still can be unpoisoned
> for debugging purposes.

Yes, not only mapping, the refcount check is not right if page cache
page is kept in page cache instead of being truncated after this
series. But actually unpoison has been broken since commit
0ed950d1f28142ccd9a9453c60df87853530d778 ("mm,hwpoison: make
get_hwpoison_page() call get_any_page()"). And Naoya said in the
commit "unpoison_memory() is also unchanged because it's broken and
need thorough fixes (will be done later)."

I do have some fixes in my tree to unblock tests and fix unpoison for
this series (just make it work for testing). Naoya may have some ideas
in mind and it is just a debugging feature so I don't think it must be
fixed in this series. It could be done later. I could add a TODO
section in the cover letter to make this more clear.

>
> --
> Peter Xu
>
