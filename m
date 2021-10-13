Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A942B304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 05:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhJMDCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 23:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhJMDCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:02:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A563CC061570;
        Tue, 12 Oct 2021 20:00:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ec8so3933395edb.6;
        Tue, 12 Oct 2021 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uD7/xxEwM4AnRl/5PHzcJRyzYKic3SfztDUF3alZMoU=;
        b=BvxjOrwpeLJ7J1jBri14NRiKPnl7NctLM88EIysS4L64io8NBvn2ZFq4MqAWCogBCx
         3XoEqg2aGSsN9o2TzuLNC0BjAUDeCJVGBeauiW0cDX+kGOQq+nrgE4/j80T3uwAiDsy3
         vUbXXaVGqQWYo2Cej94MbVoFzs2xYnAuqa1EfhehJ34BhLK3XXKso7sV/VopHTIZnGYp
         30FpTlG4Y+AdOJeBN/5wOj/jgrya/oWKIqGHq2itR1h6bYn3HJu30L5J5WtAQDdhsRzI
         o/kSy2+P731DMSQCZTaT9HTGWwHoUFbDIlm3R44CCY2CaJ+vQENn/JeACcDSTuv8Mety
         sDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uD7/xxEwM4AnRl/5PHzcJRyzYKic3SfztDUF3alZMoU=;
        b=if3ok2KE9XzNQNLkTpn36083Eo2xQTTMa0wG4hm1LqwDPPI/uieP7tjzDYi9XgfHT3
         qw94GsWfPL9vGlv0rtrInmMhkumFi6cX3Kc5+EeyEuuFdM2qDo+imavMG7B9qa9QfSXC
         KXoBcC83DmBmlpxg3tIy1W/wdJESX4h5T8OZb0Ilutz1Hl0ag54Voe1dWXpzT+GC96zP
         BEUqjkr5OuJBog4g1D3sVwopaYh+jgNMxXoMTEfpVzYgOjr2U2mGabN1Sapu+BhbPKHD
         T9Rw8DWUmqxyIL0jkt1XZihKtIpfCXYVxdgAom/Mh4cWsprfwaOSD2BxRantzW5rMHB4
         3mQw==
X-Gm-Message-State: AOAM5320b6YzdtJiL1v5zcShKi6o81eX2AAQ+Yr9JocsOiL55lx44f4T
        7OMZGXbiIS6gJy7Lo2apKR6cO9PWyw6ytoxbVEk=
X-Google-Smtp-Source: ABdhPJxW5me4u4P1TFyqA7pV0a03ZgWXyGnH/2+8NRlHyfV1AP9NuSMcbvbbxYjdLGsyJJAKYDTjL57UyfHMCGz2N9s=
X-Received: by 2002:a17:907:170a:: with SMTP id le10mr35446437ejc.537.1634094043176;
 Tue, 12 Oct 2021 20:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-5-shy828301@gmail.com>
 <YWTrbgf0kpwayWHL@t490s> <CAHbLzkrJ9YZYUS+T64L9vFzg77qVg2SZ4DBGC013kgGTRvpieA@mail.gmail.com>
 <YWYLr3vOTgLDNiNL@t490s>
In-Reply-To: <YWYLr3vOTgLDNiNL@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 20:00:31 -0700
Message-ID: <CAHbLzkrYBpbDN4QHGP_HYwcoxOxOpEK1Q=mUxcos3MtdZ5fEzw@mail.gmail.com>
Subject: Re: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure happens
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

On Tue, Oct 12, 2021 at 3:27 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 12:17:33PM -0700, Yang Shi wrote:
> > On Mon, Oct 11, 2021 at 6:57 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Thu, Sep 30, 2021 at 02:53:10PM -0700, Yang Shi wrote:
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index 88742953532c..75c36b6a405a 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> > > >       struct inode *inode = mapping->host;
> > > >       struct shmem_inode_info *info = SHMEM_I(inode);
> > > >       pgoff_t index = pos >> PAGE_SHIFT;
> > > > +     int ret = 0;
> > > >
> > > >       /* i_rwsem is held by caller */
> > > >       if (unlikely(info->seals & (F_SEAL_GROW |
> > > > @@ -2466,7 +2467,17 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> > > >                       return -EPERM;
> > > >       }
> > > >
> > > > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > > +
> > > > +     if (*pagep) {
> > > > +             if (PageHWPoison(*pagep)) {
> > > > +                     unlock_page(*pagep);
> > > > +                     put_page(*pagep);
> > > > +                     ret = -EIO;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return ret;
> > > >  }
> > > >
> > > >  static int
> > > > @@ -2555,6 +2566,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > > >                       unlock_page(page);
> > > >               }
> > > >
> > > > +             if (page && PageHWPoison(page)) {
> > > > +                     error = -EIO;
> > > > +                     break;
> > > > +             }
> > > > +
> > > >               /*
> > > >                * We must evaluate after, since reads (unlike writes)
> > > >                * are called without i_rwsem protection against truncate
> > >
> > > [...]
> > >
> > > > @@ -4193,6 +4216,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> > > >               page = ERR_PTR(error);
> > > >       else
> > > >               unlock_page(page);
> > > > +
> > > > +     if (PageHWPoison(page))
> > > > +             page = ERR_PTR(-EIO);
> > > > +
> > > >       return page;
> > > >  #else
> > > >       /*
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 7a9008415534..b688d5327177 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -233,6 +233,11 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> > > >               goto out;
> > > >       }
> > > >
> > > > +     if (PageHWPoison(page)) {
> > > > +             ret = -EIO;
> > > > +             goto out_release;
> > > > +     }
> > > > +
> > > >       ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> > > >                                      page, false, wp_copy);
> > > >       if (ret)
> > > > --
> > > > 2.26.2
> > > >
> > >
> > > These are shmem_getpage_gfp() call sites:
> > >
> > >   shmem_getpage[151]             return shmem_getpage_gfp(inode, index, pagep, sgp,
> > >   shmem_fault[2112]              err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, SGP_CACHE,
> > >   shmem_read_mapping_page_gfp[4188] error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
> > >
> > > These are further shmem_getpage() call sites:
> > >
> > >   collapse_file[1735]            if (shmem_getpage(mapping->host, index, &page,
> > >   shmem_undo_range[965]          shmem_getpage(inode, start - 1, &page, SGP_READ);
> > >   shmem_undo_range[980]          shmem_getpage(inode, end, &page, SGP_READ);
> > >   shmem_write_begin[2467]        return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > >   shmem_file_read_iter[2544]     error = shmem_getpage(inode, index, &page, sgp);
> > >   shmem_fallocate[2733]          error = shmem_getpage(inode, index, &page, SGP_FALLOC);
> > >   shmem_symlink[3079]            error = shmem_getpage(inode, 0, &page, SGP_WRITE);
> > >   shmem_get_link[3120]           error = shmem_getpage(inode, 0, &page, SGP_READ);
> > >   mcontinue_atomic_pte[235]      ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
> > >
> > > Wondering whether this patch covered all of them.
> >
> > No, it doesn't need. Not all places care about hwpoison page, for
> > example, truncate, hole punch, etc. Only the APIs which return the
> > data back to userspace or write back to disk need care about if the
> > data is corrupted or not since. This has been elaborated in the cover
> > letter.
>
> I see, sorry I missed that.  However I still have two entries unsure in above
> list that this patch didn't cover (besides fault path, truncate, ...):
>
>   collapse_file[1735]            if (shmem_getpage(mapping->host, index, &page,
>   shmem_get_link[3120]           error = shmem_getpage(inode, 0, &page, SGP_READ);
>
> IIUC the 1st one is when we want to collapse a file thp, should we stop the
> attempt if we see a hwpoison small page?

The page refcount could stop collapsing hwpoison page. One could argue
khugepaged could bail out earlier by checking hwpoison flag, but it is
definitely not a must do. So it relies on refcount now.

>
> The 2nd one should be where we had a symlink shmem file and the 1st page which
> stores the link got corrupted.  Should we fail the get_link() then?

Thanks for catching this. Yeah, it seems this one is overlooked. I
didn't know that reading symlink needed to copy the first page. Will
fix it in the next version.

>
> --
> Peter Xu
>
