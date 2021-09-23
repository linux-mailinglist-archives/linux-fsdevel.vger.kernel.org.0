Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4667F4166CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 22:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhIWUlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 16:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhIWUlj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:41:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B6CC061574;
        Thu, 23 Sep 2021 13:40:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c22so27269723edn.12;
        Thu, 23 Sep 2021 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rROM2SQJGIjf7YaskdxJKjD00Nttcaop2C06zG+GQdk=;
        b=Get8jwpdrg7VgSWQme5Kpcu2NOvv0BNPWb2i8qGQynkG9g0Y0+SRut2kBzgMcwmGmp
         SYs8QZtCnGb9nyPJzQuzU+O+BDNU41IQwaV2kg1ZIQDSZFnRrRz6im63AHLVXpaYyqlk
         aRguPB5ImCSsXos+TufuMYLlUao6WAxVvWEqjepdt46geTF16Tvu5MbK3P2AdaynDH/n
         BwzCAm0tyzjHCYdaRkAg2llpPR8HLrpuIFaYLpA/jUv4DZJBE8u3Kddyb4Pbx2EWbbU9
         xmcgLx4E900vievL4iImM1V6wmoXHXXSNOdBdJ0wRQFK5SqUUeyvEvCatjwMsQgKOtRZ
         JPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rROM2SQJGIjf7YaskdxJKjD00Nttcaop2C06zG+GQdk=;
        b=CiJ6lNCtdIqA/VsTURy6yiWIbJHVqX2Vg/bcCdiDIfY4NVJ+HplG/CsWKk2sxCC9fU
         ori9KTRleuHahCtJCn1cmQv8RNj7aOZl8ISax2t8JVOeHm5H1atSO/zBezFqVpBpFSwc
         IpLGNc+ayk/Kq4xm0auoShjo9w9+Kccq6odAJ9CGrkXZPg5obp86g0myE3Sc56xX5gnI
         W0FJ2DpH7RHdceaiaQ89/Zh6c7j8WRXSKVVw8j1ScVau00WL0xMFw/PujMfCqaBfu+WO
         WegOLCfVbzc0R9/MCuFZ1q7el2I90EE+H5PLeTDRophccVMZZZDmzrb0Tq/cnABB8X1Z
         A78w==
X-Gm-Message-State: AOAM5305d2CvbGbykayYHVmkZRoilTgrg5sANRe4ZijO/PlTsou82/3V
        Vun7dU6lZ9Wt1h5GTff2OkItu3PC+dDNBiMRYtw=
X-Google-Smtp-Source: ABdhPJzEDnlbZpJuZ8uiE4FoKnNlFLHoMIEU5vEGgonHRoioJOqUedUclccqKpHYY0HT6iK/rt9jJh71w3BmVaDRICY=
X-Received: by 2002:a50:e0c8:: with SMTP id j8mr903525edl.283.1632429602265;
 Thu, 23 Sep 2021 13:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210923032830.314328-1-shy828301@gmail.com> <20210923032830.314328-2-shy828301@gmail.com>
 <20210923143901.mdc6rejuh7hmr5vh@box.shutemov.name> <CAHbLzkqb-6a7c=C8WF0G0X2yCey=t7OoL-oW2Y0CpM0MpgJbBg@mail.gmail.com>
In-Reply-To: <CAHbLzkqb-6a7c=C8WF0G0X2yCey=t7OoL-oW2Y0CpM0MpgJbBg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 23 Sep 2021 13:39:49 -0700
Message-ID: <CAHbLzkr5YkpuFpnZguDb46naLc3MXw0DmjkttbGU4Nmm=yX8gg@mail.gmail.com>
Subject: Re: [v2 PATCH 1/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:15 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Sep 23, 2021 at 7:39 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Wed, Sep 22, 2021 at 08:28:26PM -0700, Yang Shi wrote:
> > > When handling shmem page fault the THP with corrupted subpage could be PMD
> > > mapped if certain conditions are satisfied.  But kernel is supposed to
> > > send SIGBUS when trying to map hwpoisoned page.
> > >
> > > There are two paths which may do PMD map: fault around and regular fault.
> > >
> > > Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> > > the thing was even worse in fault around path.  The THP could be PMD mapped as
> > > long as the VMA fits regardless what subpage is accessed and corrupted.  After
> > > this commit as long as head page is not corrupted the THP could be PMD mapped.
> > >
> > > In the regulat fault path the THP could be PMD mapped as long as the corrupted
> >
> > s/regulat/regular/
> >
> > > page is not accessed and the VMA fits.
> > >
> > > This loophole could be fixed by iterating every subpage to check if any
> > > of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> > >
> > > So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> > > indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> > > is found hwpoisoned by memory failure and cleared when the THP is freed or
> > > split.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> >
> > ...
> >
> > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > index dae481293b5d..740b7afe159a 100644
> > > --- a/mm/filemap.c
> > > +++ b/mm/filemap.c
> > > @@ -3195,12 +3195,14 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > >       }
> > >
> > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > -         if (!ret) {
> > > -                 /* The page is mapped successfully, reference consumed. */
> > > -                 unlock_page(page);
> > > -                 return true;
> > > -         }
> > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > +             if (ret == VM_FAULT_FALLBACK)
> > > +                     goto out;
> >
> > Hm.. What? I don't get it. Who will establish page table in the pmd then?
>
> Aha, yeah. It should jump to the below PMD populate section. Will fix
> it in the next version.
>
> >
> > > +             if (!ret) {
> > > +                     /* The page is mapped successfully, reference consumed. */
> > > +                     unlock_page(page);
> > > +                     return true;
> > > +             }
> > >       }
> > >
> > >       if (pmd_none(*vmf->pmd)) {
> > > @@ -3220,6 +3222,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > >               return true;
> > >       }
> > >
> > > +out:
> > >       return false;
> > >  }
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 5e9ef0fc261e..0574b1613714 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2426,6 +2426,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > >       /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> > >       lruvec = lock_page_lruvec(head);
> > >
> > > +     ClearPageHasHWPoisoned(head);
> > > +
> >
> > Do we serialize the new flag with lock_page() or what? I mean what
> > prevents the flag being set again after this point, but before
> > ClearPageCompound()?
>
> No, not in this patch. But I think we could use refcount. THP split
> would freeze refcount and the split is guaranteed to succeed after
> that point, so refcount can be checked in memory failure. The
> SetPageHasHWPoisoned() call could be moved to __get_hwpoison_page()
> when get_unless_page_zero() bumps the refcount successfully. If the
> refcount is zero it means the THP is under split or being freed, we
> don't care about these two cases.

Setting the flag in __get_hwpoison_page() would make this patch depend
on patch #3. However, this patch probably will be backported to older
versions. To ease the backport, I'd like to have the refcount check in
the same place where THP is checked. So, something like "if
(PageTransHuge(hpage) && page_count(hpage) != 0)".

Then the call to set the flag could be moved to __get_hwpoison_page()
in the following patch (after patch #3). Does this sound good to you?

>
> The THP might be mapped before this flag is set, but the process will
> be killed later, so it seems fine.
>
> >
> > --
> >  Kirill A. Shutemov
