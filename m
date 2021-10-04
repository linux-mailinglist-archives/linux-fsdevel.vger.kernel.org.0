Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B1421635
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 20:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhJDSTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 14:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhJDSTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:19:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA43C061745;
        Mon,  4 Oct 2021 11:17:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b8so33764451edk.2;
        Mon, 04 Oct 2021 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1OSvDb4flrM7vqMy0d0m8z6YVSkZgWPxJGyGi50ATw=;
        b=U9w6Bi/zaRZct2JenV+NVutYNh91g/jdBva9yA/bKrtTMia3MI+MYcrS0EIw894eDb
         6N/Itct6PxVtQWwSwG/vmMNK0JcetUfrYonaS9BVyoMs3mm94OKwZwQhvsybpsLJGmm1
         9wJ6c7egRspNqUtmMHXfnunwUjz8uDiZwn5pHA7QI1S104vXFrGBbyG8VauT/uOaGEvx
         s7+4X4QOzTsxWE6R2+8Z3di3GQlitgzklu1H/RKLtOnX5CwN6EbrSrKFZcJmp75Ph3XV
         P7p8cYGx68oBGqM1uCWZlwkVN5kJW+PJP0W6JIE6siW55NHEt3iQOPMSlKZ+MXOgInP+
         r60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1OSvDb4flrM7vqMy0d0m8z6YVSkZgWPxJGyGi50ATw=;
        b=afs7tpF6VX9mJ/MWcnmZWYBBEbYCJa1izUjfL5+7cEW4vK+8vEouhFnLK271MeqJ7b
         moJbSA01BHB5bQJnFw3UK/olDywIeTNQ+MC3IN2VYOn2zCkEnWvNxsm6+4noZMdn3LEi
         3LOl9GISyIcdxaF8LN71BtJ2AG8KIcUP9ui0nNgzlOKZwTV6TjRoSCYzGATCZVh8aYfN
         uyt6QAw4WnoRkwhrNIRoIHjtQs+aTaicAtoekslitBkSRSD1sr5+Y18jLYP43mXfeZPp
         OnSbcIB7Kz/TGXpWyNfWKTChdedt8mlSX8ZdD0A1n8T7as4GrClqC1SJtKj/t86Ao7hh
         WGsw==
X-Gm-Message-State: AOAM531kHWuuoilzVE8yVYGRc0D1eR2271+EkNwzStrMvqpYdZiVWBrK
        +bdyTg97PlQ6OsrHFgshwuyOc0rLh0ZxmasmvfGSro+e
X-Google-Smtp-Source: ABdhPJyiqlAaEJw5chaLwE/+uRpnajHGMoQ/SjnHQFon0jCpmUlCUyW6Uf+uYok6k+AY3fALQ/bxtzEohx2OoLDTxVI=
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr19510961ejb.555.1633371461107;
 Mon, 04 Oct 2021 11:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
In-Reply-To: <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 4 Oct 2021 11:17:29 -0700
Message-ID: <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
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

On Mon, Oct 4, 2021 at 7:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index dae481293b5d..2acc2b977f66 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
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
> > +             if (!ret) {
> > +                     /* The page is mapped successfully, reference consumed. */
> > +                     unlock_page(page);
> > +                     return true;
> > +             }
> >       }
> >
> >       if (pmd_none(*vmf->pmd)) {
>
> Hm. Is it unrelated whitespace fix?

It is a coding style clean up. I thought it may be overkilling to have
a separate patch. Do you prefer separate one?

>
> --
>  Kirill A. Shutemov
