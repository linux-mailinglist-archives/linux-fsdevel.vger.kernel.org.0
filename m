Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D61416437
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbhIWRRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 13:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbhIWRRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:17:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A7EC061574;
        Thu, 23 Sep 2021 10:15:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v10so21026711edj.10;
        Thu, 23 Sep 2021 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHYH6Vrz0laBG66JYJnRRiuzY/WhU/BobO0byYWnoRw=;
        b=XNQffNsPyyD+iqO4CgNLqqilvEBuxRZ4ZByo+ePQFgaw8IItw6RCN02BUMs4QJ1oca
         GeUY2dFljtG+qZM3ZV6QW+DGUo41vM544PU4TcDUz+4a2FhsT6GUvzzqbsmo0YgRbg0T
         JVLg20IFfpZX1CLCmMRWAnPBddvzUhFtlwank65jKj/ZS6h+hCIbR+WouCANhfRwwPJp
         HaXfG/J+1GijdoSu4R9XX3+tabSjdBAYWQi1Ongr8Yp4p1rAWZvspxCUEG5nn67SOklN
         QN3LnCSGbZ6d+fu/PdAaGFGb1M6JF2hKoiDni30WqBqBLz+3K4Q3dKAzqjDZenpDEitQ
         WcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHYH6Vrz0laBG66JYJnRRiuzY/WhU/BobO0byYWnoRw=;
        b=KaSEe6LR08Wc6VB7oqz8NIcU7SaaG5CDpMqHrUkFT27xuBEb/b7OjGFFANYHTNCrkv
         Mdy5NxnvKugKqAxu/1I/PS4I3kyXUj9jIUCKxvVFT8HSl/wAtuVlKxbgknJF1YlaP0qx
         Z7jnPFz0pGya38wzHSk84REpuqhHgMZoRAUYXuBtLhCN20wEq7uimhksUMQ3GKrX1dAJ
         v04BLvbn/yQkpQqlsk0gS2KzU+JNKn+kkAl7J22BNM0ucaAHg/9AZVaqpSWfwSP3cwCI
         P7R0aGz15R6dG+yeSUWeDRSlAFIlqM15xjqvAzib8gz08narANHt3MTV2lj5ir1wMm6d
         CIMw==
X-Gm-Message-State: AOAM532Cc2mtWW1big4/rQqF9gcgvWn42Nuvto8beJ/XoC5Og3kHtWqp
        BhrKYsuwKQwZgi1ucODSwYWJkQErK3R4pZGPJ6Y=
X-Google-Smtp-Source: ABdhPJxSv7vP1ns4r2NSsMM2sG4AnMbhdMd2u2JGPaOtI9CbdhwHffXf6dgVUZYIL+N/lkjxHxnDfuoEWBS/zZzrLiw=
X-Received: by 2002:a05:6402:16c8:: with SMTP id r8mr6836144edx.101.1632417357693;
 Thu, 23 Sep 2021 10:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210923032830.314328-1-shy828301@gmail.com> <20210923032830.314328-2-shy828301@gmail.com>
 <20210923143901.mdc6rejuh7hmr5vh@box.shutemov.name>
In-Reply-To: <20210923143901.mdc6rejuh7hmr5vh@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 23 Sep 2021 10:15:45 -0700
Message-ID: <CAHbLzkqb-6a7c=C8WF0G0X2yCey=t7OoL-oW2Y0CpM0MpgJbBg@mail.gmail.com>
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

On Thu, Sep 23, 2021 at 7:39 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Sep 22, 2021 at 08:28:26PM -0700, Yang Shi wrote:
> > When handling shmem page fault the THP with corrupted subpage could be PMD
> > mapped if certain conditions are satisfied.  But kernel is supposed to
> > send SIGBUS when trying to map hwpoisoned page.
> >
> > There are two paths which may do PMD map: fault around and regular fault.
> >
> > Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> > the thing was even worse in fault around path.  The THP could be PMD mapped as
> > long as the VMA fits regardless what subpage is accessed and corrupted.  After
> > this commit as long as head page is not corrupted the THP could be PMD mapped.
> >
> > In the regulat fault path the THP could be PMD mapped as long as the corrupted
>
> s/regulat/regular/
>
> > page is not accessed and the VMA fits.
> >
> > This loophole could be fixed by iterating every subpage to check if any
> > of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> >
> > So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> > indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> > is found hwpoisoned by memory failure and cleared when the THP is freed or
> > split.
> >
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
>
> ...
>
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index dae481293b5d..740b7afe159a 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3195,12 +3195,14 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> >       }
> >
> >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > -         if (!ret) {
> > -                 /* The page is mapped successfully, reference consumed. */
> > -                 unlock_page(page);
> > -                 return true;
> > -         }
> > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > +             if (ret == VM_FAULT_FALLBACK)
> > +                     goto out;
>
> Hm.. What? I don't get it. Who will establish page table in the pmd then?

Aha, yeah. It should jump to the below PMD populate section. Will fix
it in the next version.

>
> > +             if (!ret) {
> > +                     /* The page is mapped successfully, reference consumed. */
> > +                     unlock_page(page);
> > +                     return true;
> > +             }
> >       }
> >
> >       if (pmd_none(*vmf->pmd)) {
> > @@ -3220,6 +3222,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> >               return true;
> >       }
> >
> > +out:
> >       return false;
> >  }
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 5e9ef0fc261e..0574b1613714 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2426,6 +2426,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >       /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> >       lruvec = lock_page_lruvec(head);
> >
> > +     ClearPageHasHWPoisoned(head);
> > +
>
> Do we serialize the new flag with lock_page() or what? I mean what
> prevents the flag being set again after this point, but before
> ClearPageCompound()?

No, not in this patch. But I think we could use refcount. THP split
would freeze refcount and the split is guaranteed to succeed after
that point, so refcount can be checked in memory failure. The
SetPageHasHWPoisoned() call could be moved to __get_hwpoison_page()
when get_unless_page_zero() bumps the refcount successfully. If the
refcount is zero it means the THP is under split or being freed, we
don't care about these two cases.

The THP might be mapped before this flag is set, but the process will
be killed later, so it seems fine.

>
> --
>  Kirill A. Shutemov
