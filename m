Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251A240CBB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhIORaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIORaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:30:11 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D5C061574;
        Wed, 15 Sep 2021 10:28:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j13so6326502edv.13;
        Wed, 15 Sep 2021 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JknZZcds3P+ijp8iLza6R4NMNGNAffXXVQcBCVjKBxA=;
        b=LOZcdsB35CuvKoDLNkir+xm8Pk907ivp2Jijfe+OqKoX9XFSeFUCa9WYcpE25px2Q7
         9ieIdV2R20wM7kH74bbAztIZbquiJpBNXxzViyKjBYU1pOY32NpV5vHHi0bOdhdtBzJW
         8OoyJpC4wnRdpFoTki6smMLpagrRs59KyQ1aSmOWyACjybwDf34Djdb/9uEtDJteQrb3
         rMse5k5euK/Y+V36Jfd9kjWw3eNbxwMfY3Jety2bZGqpY8wHJHBmOPVlxeQQjwGPLABo
         PaqEdXR6ZIZyCrxYcScFZmGV4yyn5XVZk3GDyIYPM/u+aJfQGL8zBFGeaUVM87NdClmB
         x4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JknZZcds3P+ijp8iLza6R4NMNGNAffXXVQcBCVjKBxA=;
        b=peuF+S8mN4PDUWzA09/3MwXJjcpvCk3CRvFUVzgHogrkC47Iqh/+t5fmKqh40HlcGJ
         X7TTbUwuRJsYpc0Y3yaC/dTZRpP1i/Rz1MoqE3KMxQDHPZtV+Q8DamT6I3LdHqYrbKC1
         GX+3hWrQ7SEHSYN99odQ3flUUk//KY+w6+RMCx+eRLDOv+M0+eUE00l6RPqLrJkhG2pt
         zSAatdrFpRoo+ArAuzdp4qSRii3tMNzkM2FhyoPhOTZ6EPv6wJOwSilvHas/Wjd4jToh
         XNNL65rl5XTHvuqVAbqj1iaDcAh9qbojCIfsyWFtljS8hq4uGPe3vaEkml8tQhE/lCu7
         SKIw==
X-Gm-Message-State: AOAM533QFmIWgdz8p5GCRrd3y7jtK/CIxcvlSXKJQSLSAOXVzKU/tdy+
        VKuyWfzY861JIuFPmyHHmiJJZz23VjHIst6DEwI=
X-Google-Smtp-Source: ABdhPJzFH7fzb9SGKzkJkBGj/B+8nUEWdKuBz9U/Umi6TGAHuLqvjI3XP3GjcmTXBKO4WnSSZayJL/V0+4eq8LCYyb0=
X-Received: by 2002:a50:af86:: with SMTP id h6mr1182782edd.283.1631726930917;
 Wed, 15 Sep 2021 10:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210914183718.4236-1-shy828301@gmail.com> <20210914183718.4236-2-shy828301@gmail.com>
 <20210915114613.lo26l64iqjz2qo6a@box.shutemov.name>
In-Reply-To: <20210915114613.lo26l64iqjz2qo6a@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Sep 2021 10:28:38 -0700
Message-ID: <CAHbLzkorHGOK-h5vxOYFuXVNWRBYBMARwYO_f2osSjFtvZCj8w@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: filemap: check if any subpage is hwpoisoned for
 PMD page fault
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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

On Wed, Sep 15, 2021 at 4:46 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Tue, Sep 14, 2021 at 11:37:15AM -0700, Yang Shi wrote:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 25fc46e87214..1765bf72ed16 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3920,8 +3920,17 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> >       if (unlikely(!pmd_none(*vmf->pmd)))
> >               goto out;
> >
> > -     for (i = 0; i < HPAGE_PMD_NR; i++)
> > +     for (i = 0; i < HPAGE_PMD_NR; i++) {
> > +             /*
> > +              * Just backoff if any subpage of a THP is corrupted otherwise
> > +              * the corrupted page may mapped by PMD silently to escape the
> > +              * check.  This kind of THP just can be PTE mapped.  Access to
> > +              * the corrupted subpage should trigger SIGBUS as expected.
> > +              */
> > +             if (PageHWPoison(page + i))
> > +                     goto out;
> >               flush_icache_page(vma, page + i);
> > +     }
>
> This is somewhat costly.
>
> flush_icache_page() is empty on most archs so compiler makes the loop go
> away before the change. Also page->flags for most of the pages will not
> necessary be hot.

Yeah, good point.

>
> I wounder if we should consider making PG_hwpoison to cover full compound
> page. On marking page hwpoison we try to split it and mark relevant base
> page, if split fails -- mark full compound page.

We need extra bits to record exactly which subpage(s) are poisoned so
that the right page can be isolated when splitting.

>
> As alternative we can have one more flag that indicates that the compound
> page contains at least one hwpoisoned base page. We should have enough
> space in the first tail page.

Yes, actually I was thinking about the same thing too when debugging
this problem. I think this approach is more feasible. We could add a
new flag in the first tail page just like doublemap which indicates
there is/are poisoned subpage(s). It could be cleared when splitting.

I will try to implement this in the next version. Thanks a lot for the
suggestion.

>
> --
>  Kirill A. Shutemov
