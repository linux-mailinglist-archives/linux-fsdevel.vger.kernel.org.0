Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A240D424A99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 01:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbhJFXnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 19:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbhJFXnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 19:43:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A97EC061746;
        Wed,  6 Oct 2021 16:41:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so15539075edj.1;
        Wed, 06 Oct 2021 16:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQwcNOx9GglWf+fmi9j9KTVEDziCVIDG+WjU0d3iHyc=;
        b=REIXGnTFX76AuXrOg1PBHPCrJgubDpKyWzesIIgbYb/3Y1lblxvvIMKDk38IqYCXaI
         gahT1OtBYzsAJl6la7acrGzJsLfC41qOT+GqL0q/k4j+Vf3n+jHO2Fd2z+WLOzPSEnII
         swrYnpKvLmqTlMIifw33maWy3B3BBg/Ri1xFohbzoKJYRxgH1Cm6vrhgvAjBHWh/sN0c
         qDzoBFqcaIS7JR7sFtc0AtYz2nSS5OAo7ItCQuMl1i4RrkfKVJY/CRMx09O2AspJT7B2
         579XJAPBhJBzRxDPejPk84TijqGqxpflHLcj0xRppl9zqcsckxSSjvXDT2GZjVtAnVCd
         3ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQwcNOx9GglWf+fmi9j9KTVEDziCVIDG+WjU0d3iHyc=;
        b=MgvsRTI4aQ4AtCPNrOBQsWl9idTlrnMKTKkuyqmiIsbWqvzX+3RWR0muIW3pkCOs5T
         FleDDt8s+GceWHkP98zlq+37OQEAn21BTdigV0BCJxlXuM+VJtsA7e2jXNoiqQelggkV
         kuMdl2LZP4Zmmpd8fn/qhSeHZcwaSVjvD2mYZjdbRO/FC5Yufpm+6jGP34leAqsRB88T
         2kWX/w0eAkcg1Nh2LEaVm0jKEgjeZT2YLdg8ivReOW1wAfR1Eo+DwsSWbjEqN0JqBcxd
         K+aVjwULIszn4opk7njCJweIf/hGfy0YfEC/fxgw1tSeJLGVVNKmvynBp5WrJ3Kceb9F
         hIsw==
X-Gm-Message-State: AOAM532yzMggRLR5vG9lNhM42EzmJ79lxA7LVC3kZkv1n6MveIkI3E4d
        h9dfXD39dc+wNUiHAPBM431J2H4O+QrsSo7Aa/M=
X-Google-Smtp-Source: ABdhPJy9+bUhXx3lkHWAACY8TPub7AApKhM1sGHByTwPknAcpEoB7cL0RuGAEs1bFyCX0GV1DS2BnTE9h+MfVy7XGe8=
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr1562092ejc.62.1633563707661;
 Wed, 06 Oct 2021 16:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name> <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name> <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
 <YV3+6K3uupLit3aH@t490s>
In-Reply-To: <YV3+6K3uupLit3aH@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 6 Oct 2021 16:41:35 -0700
Message-ID: <CAHbLzkpWSM_HvCmgaLd748BLcmZ3cnDRQ577o_U+qDi1iSK3Og@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
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

On Wed, Oct 6, 2021 at 12:54 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 04, 2021 at 01:13:07PM -0700, Yang Shi wrote:
> > On Mon, Oct 4, 2021 at 12:41 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > >
> > > On Mon, Oct 04, 2021 at 11:17:29AM -0700, Yang Shi wrote:
> > > > On Mon, Oct 4, 2021 at 7:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > > >
> > > > > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > > index dae481293b5d..2acc2b977f66 100644
> > > > > > --- a/mm/filemap.c
> > > > > > +++ b/mm/filemap.c
> > > > > > @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > > > >       }
> > > > > >
> > > > > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > > > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > > -         if (!ret) {
> > > > > > -                 /* The page is mapped successfully, reference consumed. */
> > > > > > -                 unlock_page(page);
> > > > > > -                 return true;
> > > > > > -         }
> > > > > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > > +             if (!ret) {
> > > > > > +                     /* The page is mapped successfully, reference consumed. */
> > > > > > +                     unlock_page(page);
> > > > > > +                     return true;
> > > > > > +             }
> > > > > >       }
> > > > > >
> > > > > >       if (pmd_none(*vmf->pmd)) {
> > > > >
> > > > > Hm. Is it unrelated whitespace fix?
> > > >
> > > > It is a coding style clean up. I thought it may be overkilling to have
> > > > a separate patch. Do you prefer separate one?
> > >
> > > Maybe. I tried to find what changed here. It's confusing.
> >
> > Yeah, maybe. Anyway I will separate the real big fix and the cleanup
> > into two patches. This may be helpful for backporting too.
>
> Or maybe we just don't touch it until there's need for a functional change?  I
> feel it a pity to lose the git blame info for reindent-only patches, but no
> strong opinion, because I know many people don't think the same and I'm fine
> with either ways.

TBH I really don't think keeping old "git blame" info should be an
excuse to avoid any coding style cleanup.

>
> Another side note: perhaps a comment above pageflags enum on PG_has_hwpoisoned
> would be nice?  I saw that we've got a bunch of those already.

I was thinking about that, but it seems PG_double_map doesn't have
comment there either so I didn't add.

>
> Thanks,
>
> --
> Peter Xu
>
