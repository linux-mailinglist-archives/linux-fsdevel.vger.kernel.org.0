Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF556417907
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbhIXQqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245680AbhIXQqm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:46:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDBBC061571;
        Fri, 24 Sep 2021 09:45:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg28so38608811edb.1;
        Fri, 24 Sep 2021 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZmwKu0BUurwbUnTZVEh8wLwYpJ31RDmtunI9Xt7VQk=;
        b=MJTNfFuYrmCv9ju452FVisH0MLHZx2gtJbWytFi6qbSQwa5/GUIo3uXp/gwJGOfZbG
         5XF1ppxhhT1aHn8g6IvZrysMrlpdAEzms8cwBBCuNSuDa9AvWLHWV1nOOa/AaF6QPZy+
         ljogh8W7YfWZP7c744Un/Ku7OEh89zaQrp78ItxjT68WM1LU+IyxDvwDm1LRVYw6ANHZ
         +EEgy4zLBc4OZShFJyj9oWHOJqF8a1hfs5N7uKVdVvJYySdyj+0O0gIErYdtugQ+D4xz
         qG52JEAGO9Ch3EEfQ/g4CAh6bzAo0XnUtTXE0BjOZwrv5PtapQ8ug2BVazV3I/PEXAEY
         iciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZmwKu0BUurwbUnTZVEh8wLwYpJ31RDmtunI9Xt7VQk=;
        b=M3bWtkRYt4zcAwkI9MhtfeysNXX9089hqDkINwgzwmbqmrwzsP/Wd8zUqUjHkDRqGS
         s2xidH4kNAmhhTLRiWuJgJ+TWFe8gx3jmttZfJhk1ZdmiAaGyXubLDhNxy+gy9HBvG+7
         RdgodiLKdjNFsfwyrkclP+KYvGvloH0YusjQDKptA0wWntl2K/04FWLr2XaulZWA+O/M
         Cv6g0rnteQ//EGx/iq8aE7mwaFkTQCcdgDDiV+i2zPYj90/SfHcJuhoopMTz9IkK+K4W
         y5oWU4PygO9SR/hXR0WB5yuCbGcN5EydhQgjnmOn8WzHxSRc97cSDHRAx9j816PPR2cM
         Hzjw==
X-Gm-Message-State: AOAM5327x44Jp7B3M0tRqspTrmRZWaJ9xRt4H7et+XoUS+lqAcfZsIoB
        siUtQHKPU1ZOQJsvwpImZJys+0wtqHsvjDS29d8=
X-Google-Smtp-Source: ABdhPJxY++oM8nSkIUfZpogdOZRn3Gd6ZYVjB9ICFpuA9aiCmV0nXei8lYBE+aMHq8pqbb5gNE68Rl2zQAlYHrG/CBE=
X-Received: by 2002:a17:906:680c:: with SMTP id k12mr12322522ejr.85.1632501907474;
 Fri, 24 Sep 2021 09:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210923032830.314328-1-shy828301@gmail.com> <20210923032830.314328-2-shy828301@gmail.com>
 <20210923143901.mdc6rejuh7hmr5vh@box.shutemov.name> <CAHbLzkqb-6a7c=C8WF0G0X2yCey=t7OoL-oW2Y0CpM0MpgJbBg@mail.gmail.com>
 <CAHbLzkr5YkpuFpnZguDb46naLc3MXw0DmjkttbGU4Nmm=yX8gg@mail.gmail.com> <20210924092621.kbg4byfidfzgjk3g@box>
In-Reply-To: <20210924092621.kbg4byfidfzgjk3g@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 24 Sep 2021 09:44:55 -0700
Message-ID: <CAHbLzkpXm4Si5u-uWvgAine3bb9N5os7=hcYRTQAtsakxB5YWw@mail.gmail.com>
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

On Fri, Sep 24, 2021 at 2:26 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Sep 23, 2021 at 01:39:49PM -0700, Yang Shi wrote:
> > On Thu, Sep 23, 2021 at 10:15 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Thu, Sep 23, 2021 at 7:39 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >
> > > > On Wed, Sep 22, 2021 at 08:28:26PM -0700, Yang Shi wrote:
> > > > > When handling shmem page fault the THP with corrupted subpage could be PMD
> > > > > mapped if certain conditions are satisfied.  But kernel is supposed to
> > > > > send SIGBUS when trying to map hwpoisoned page.
> > > > >
> > > > > There are two paths which may do PMD map: fault around and regular fault.
> > > > >
> > > > > Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> > > > > the thing was even worse in fault around path.  The THP could be PMD mapped as
> > > > > long as the VMA fits regardless what subpage is accessed and corrupted.  After
> > > > > this commit as long as head page is not corrupted the THP could be PMD mapped.
> > > > >
> > > > > In the regulat fault path the THP could be PMD mapped as long as the corrupted
> > > >
> > > > s/regulat/regular/
> > > >
> > > > > page is not accessed and the VMA fits.
> > > > >
> > > > > This loophole could be fixed by iterating every subpage to check if any
> > > > > of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> > > > >
> > > > > So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> > > > > indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> > > > > is found hwpoisoned by memory failure and cleared when the THP is freed or
> > > > > split.
> > > > >
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > > ---
> > > >
> > > > ...
> > > >
> > > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > index dae481293b5d..740b7afe159a 100644
> > > > > --- a/mm/filemap.c
> > > > > +++ b/mm/filemap.c
> > > > > @@ -3195,12 +3195,14 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > > >       }
> > > > >
> > > > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > -         if (!ret) {
> > > > > -                 /* The page is mapped successfully, reference consumed. */
> > > > > -                 unlock_page(page);
> > > > > -                 return true;
> > > > > -         }
> > > > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > +             if (ret == VM_FAULT_FALLBACK)
> > > > > +                     goto out;
> > > >
> > > > Hm.. What? I don't get it. Who will establish page table in the pmd then?
> > >
> > > Aha, yeah. It should jump to the below PMD populate section. Will fix
> > > it in the next version.
> > >
> > > >
> > > > > +             if (!ret) {
> > > > > +                     /* The page is mapped successfully, reference consumed. */
> > > > > +                     unlock_page(page);
> > > > > +                     return true;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >       if (pmd_none(*vmf->pmd)) {
> > > > > @@ -3220,6 +3222,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > > >               return true;
> > > > >       }
> > > > >
> > > > > +out:
> > > > >       return false;
> > > > >  }
> > > > >
> > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > index 5e9ef0fc261e..0574b1613714 100644
> > > > > --- a/mm/huge_memory.c
> > > > > +++ b/mm/huge_memory.c
> > > > > @@ -2426,6 +2426,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > >       /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> > > > >       lruvec = lock_page_lruvec(head);
> > > > >
> > > > > +     ClearPageHasHWPoisoned(head);
> > > > > +
> > > >
> > > > Do we serialize the new flag with lock_page() or what? I mean what
> > > > prevents the flag being set again after this point, but before
> > > > ClearPageCompound()?
> > >
> > > No, not in this patch. But I think we could use refcount. THP split
> > > would freeze refcount and the split is guaranteed to succeed after
> > > that point, so refcount can be checked in memory failure. The
> > > SetPageHasHWPoisoned() call could be moved to __get_hwpoison_page()
> > > when get_unless_page_zero() bumps the refcount successfully. If the
> > > refcount is zero it means the THP is under split or being freed, we
> > > don't care about these two cases.
> >
> > Setting the flag in __get_hwpoison_page() would make this patch depend
> > on patch #3. However, this patch probably will be backported to older
> > versions. To ease the backport, I'd like to have the refcount check in
> > the same place where THP is checked. So, something like "if
> > (PageTransHuge(hpage) && page_count(hpage) != 0)".
> >
> > Then the call to set the flag could be moved to __get_hwpoison_page()
> > in the following patch (after patch #3). Does this sound good to you?
>
> Could you show the code I'm not sure I follow. page_count(hpage) check
> looks racy to me. What if split happens just after the check?

Yes, it is racy. The flag has to be set after get_page_unless_zero().
Did some archeology, it seems patch #3 is also applicable to v4.9+.
So, the simplest way may be to have both patch #3 and this patch
backport to stable.



>
> --
>  Kirill A. Shutemov
