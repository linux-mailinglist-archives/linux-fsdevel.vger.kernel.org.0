Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C8B40CBEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhIORts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhIORtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:49:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F9C061574;
        Wed, 15 Sep 2021 10:48:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c22so6521374edn.12;
        Wed, 15 Sep 2021 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUutvbwT+ImtyWQ/R4PZfCaPNu83uCoI/leGQrb46ts=;
        b=I3I/U/NyzLP3yFWBxVWrBHFbyqaxPdxCb8peY1C7jxRnsB3zaIdcFd0G0ax8uHHLSg
         Wh07Q+v5zhISaPdAvnMcMo8suNiSnQgsZqkdJ5YWTrluY3cZVrjxt2+/EvYq5+NLoxdC
         Dno0yngof71yCYbPMuqIlhTGHWWUVdy7amp2Se7R6BV+5/WWoTVQ+umNQT1pOAPSlN7t
         BsPoFoHF3FbBuhWUufXysW+vWeyxkjVRBpeDbxjFXUhG1moyLIuWnfXns/lj1OFTCKXP
         3SFLGRhGqaGPO6q3ljF3rxki5uQWP7NHH47MXpLMBeAKQBXt6+hgPKyxqm0Y/NQl8QWm
         ubAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUutvbwT+ImtyWQ/R4PZfCaPNu83uCoI/leGQrb46ts=;
        b=7xfyqPo+FA/icBb3DliurocTTWD0sgV0l6Mp1YRVWvxANUxIfdSBCR+LaH54GlpUn+
         3/sdN7U11YlmijUTIxsywrOadf4ppDNjwRHfl8aV3WQWahABJOL7MtLH75r2o7YPKTeT
         lyLTUCXkhLkiPMKXuBxtEbH4htJqqFmCJxRSfKZtvxaDaW2oStiBn8dFkyBBrfEnOvB6
         Ahm1ZjkSOxxxBbzyxt+X6V1RsZobpEOfIeSI9Jk8xJavfDkKDkzZ2iXmzXRg6BUTbAzg
         MU3bFTvZ16DzCp1UgZvU6k0bZPNBBN0LaQANgiHt9fE7MJiErPmrMLDZ03S4xfHz/yqX
         pJXA==
X-Gm-Message-State: AOAM533OVXisuzu3G70XH12z13blgz8kkovmpwpqFOy/dAzpATEUI4an
        45I0DXSnE8yDZmNUjFHUJqwZ5c0FMwtEGRa6TLc=
X-Google-Smtp-Source: ABdhPJyy6f9Q3pSMERBs4nQGD6A6iXjhxlJuqh1C/eP3fH6JCxRs0swIVnvjOlH1UirN3P/elCitiV2PY7WPHwfdXqc=
X-Received: by 2002:a17:906:680c:: with SMTP id k12mr1314252ejr.85.1631728107020;
 Wed, 15 Sep 2021 10:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210914183718.4236-1-shy828301@gmail.com> <20210914183718.4236-3-shy828301@gmail.com>
 <20210915114947.2zh7inouztenth6o@box.shutemov.name>
In-Reply-To: <20210915114947.2zh7inouztenth6o@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Sep 2021 10:48:15 -0700
Message-ID: <CAHbLzkpjAf+V5b40UFH2gWSRN4gVqoFmjHr9_wME2ofWC7Mfkw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: khugepaged: check if file page is on LRU after
 locking page
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

On Wed, Sep 15, 2021 at 4:49 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Tue, Sep 14, 2021 at 11:37:16AM -0700, Yang Shi wrote:
> > The khugepaged does check if the page is on LRU or not but it doesn't
> > hold page lock.  And it doesn't check this again after holding page
> > lock.  So it may race with some others, e.g. reclaimer, migration, etc.
> > All of them isolates page from LRU then lock the page then do something.
> >
> > But it could pass the refcount check done by khugepaged to proceed
> > collapse.  Typically such race is not fatal.  But if the page has been
> > isolated from LRU before khugepaged it likely means the page may be not
> > suitable for collapse for now.
> >
> > The other more fatal case is the following patch will keep the poisoned
> > page in page cache for shmem, so khugepaged may collapse a poisoned page
> > since the refcount check could pass.  3 refcounts come from:
> >   - hwpoison
> >   - page cache
> >   - khugepaged
> >
> > Since it is not on LRU so no refcount is incremented from LRU isolation.
> >
> > This is definitely not expected.  Checking if it is on LRU or not after
> > holding page lock could help serialize against hwpoison handler.
> >
> > But there is still a small race window between setting hwpoison flag and
> > bump refcount in hwpoison handler.  It could be closed by checking
> > hwpoison flag in khugepaged, however this race seems unlikely to happen
> > in real life workload.  So just check LRU flag for now to avoid
> > over-engineering.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/khugepaged.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 045cc579f724..bdc161dc27dc 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1808,6 +1808,12 @@ static void collapse_file(struct mm_struct *mm,
> >                       goto out_unlock;
> >               }
> >
> > +             /* The hwpoisoned page is off LRU but in page cache */
> > +             if (!PageLRU(page)) {
> > +                     result = SCAN_PAGE_LRU;
> > +                     goto out_unlock;
> > +             }
> > +
> >               if (isolate_lru_page(page)) {
>
> isolate_lru_page() should catch the case, no? TestClearPageLRU would fail
> and we get here.

Hmm... you are definitely right. How could I miss this point.

It might be because of I messed up the page state by some tests which
may do hole punch then reread the same index. That could drop the
poisoned page then collapse succeed. But I'm not sure. Anyway I didn't
figure out how the poisoned page could be collapsed. It seems
impossible. I will drop this patch.

>
> >                       result = SCAN_DEL_PAGE_LRU;
> >                       goto out_unlock;
> > --
> > 2.26.2
> >
> >
>
> --
>  Kirill A. Shutemov
