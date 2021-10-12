Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2393A42AD21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 21:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhJLTTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLTTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:19:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA4C061570;
        Tue, 12 Oct 2021 12:17:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d9so382976edh.5;
        Tue, 12 Oct 2021 12:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56fKb7CcbuqktWpgMry6SjvQCRBJgPclG+WWBci/N1U=;
        b=ofv0TOnNlGBFLe51dgG5OnmJG9qkC2CqbFDJxP5PdQqvaBETe9QiZBsVEzj/6275Me
         2gTNF8zQQjqsQ8W6T2DQ4jVOjf+5wWNOmax7L44r8hYXWq1ihO7vwFkZB2lYyyEzXs/H
         8VXQE/dgFRSZ1xcTzVrWcZLykFk6eW2wZQZxoJU7oSFMi9aBJpS26EX29z0r2EefPIdC
         oCmXu5KAtT3AG0os9ixKaZD7RDhKGyqV8rbfLimP3cyTUJajh3iM5bR2J2Y2bj5awPbt
         HrpR3esr8TEsXQoZ89DhUKu1U/OSEr3X/81npuwXDM24/TObn2Uyl0Zae2hfNhT/MLLg
         McLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56fKb7CcbuqktWpgMry6SjvQCRBJgPclG+WWBci/N1U=;
        b=L2z6B3qP6nFoUSUvSCR6i882xP02yJpmaBDMzyr9vK10Xr3/n2ihDAWzk90dBjdpql
         jgpHcHJDx8gHc3leiQaGYMM/XoeGA7eV1zGIS6etODeSmKYvXjqwu6X1Fp3hhXh97i0F
         rb3PPbB6Db13Fbghv2v3zw1EBwu6RxhxEsd2xw2cBr9KHxb//ycJSO6h0xFWSNfIbwQY
         cVQ8d/lGtQkVEWbsS7H6ulMiv48L29GcYvjKNdTyEhpsGVDWd/Hihwb15OTbyRXpR+F1
         sCQA5mE0qAFwjttKorfJc3Q/cAJ39kBkpqVHskB+99jTgvUiCikSJlleAnpPmJ49NdG9
         nmLA==
X-Gm-Message-State: AOAM532YY91MK028Of1/7gTk5aLIq6kW7lX/9R9q8cM/YyoX39t/g3J/
        yVkL9lnUbZOA5vo7EmrVbwGqeBQXNwS//qaQKgIS40Ka
X-Google-Smtp-Source: ABdhPJw8N+UTY9qYXvlJOjYjlnaJ60e7PjmRWzxiW5mF9oViVC/RcCLqBI5rfVRQKpM4JeBP3qZXJiH5m0OrDcinAkE=
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr36478716ejc.62.1634066265573;
 Tue, 12 Oct 2021 12:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-5-shy828301@gmail.com>
 <YWTrbgf0kpwayWHL@t490s>
In-Reply-To: <YWTrbgf0kpwayWHL@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 12:17:33 -0700
Message-ID: <CAHbLzkrJ9YZYUS+T64L9vFzg77qVg2SZ4DBGC013kgGTRvpieA@mail.gmail.com>
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

On Mon, Oct 11, 2021 at 6:57 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:10PM -0700, Yang Shi wrote:
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 88742953532c..75c36b6a405a 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2456,6 +2456,7 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> >       struct inode *inode = mapping->host;
> >       struct shmem_inode_info *info = SHMEM_I(inode);
> >       pgoff_t index = pos >> PAGE_SHIFT;
> > +     int ret = 0;
> >
> >       /* i_rwsem is held by caller */
> >       if (unlikely(info->seals & (F_SEAL_GROW |
> > @@ -2466,7 +2467,17 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> >                       return -EPERM;
> >       }
> >
> > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +
> > +     if (*pagep) {
> > +             if (PageHWPoison(*pagep)) {
> > +                     unlock_page(*pagep);
> > +                     put_page(*pagep);
> > +                     ret = -EIO;
> > +             }
> > +     }
> > +
> > +     return ret;
> >  }
> >
> >  static int
> > @@ -2555,6 +2566,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >                       unlock_page(page);
> >               }
> >
> > +             if (page && PageHWPoison(page)) {
> > +                     error = -EIO;
> > +                     break;
> > +             }
> > +
> >               /*
> >                * We must evaluate after, since reads (unlike writes)
> >                * are called without i_rwsem protection against truncate
>
> [...]
>
> > @@ -4193,6 +4216,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> >               page = ERR_PTR(error);
> >       else
> >               unlock_page(page);
> > +
> > +     if (PageHWPoison(page))
> > +             page = ERR_PTR(-EIO);
> > +
> >       return page;
> >  #else
> >       /*
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 7a9008415534..b688d5327177 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -233,6 +233,11 @@ static int mcontinue_atomic_pte(struct mm_struct *dst_mm,
> >               goto out;
> >       }
> >
> > +     if (PageHWPoison(page)) {
> > +             ret = -EIO;
> > +             goto out_release;
> > +     }
> > +
> >       ret = mfill_atomic_install_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
> >                                      page, false, wp_copy);
> >       if (ret)
> > --
> > 2.26.2
> >
>
> These are shmem_getpage_gfp() call sites:
>
>   shmem_getpage[151]             return shmem_getpage_gfp(inode, index, pagep, sgp,
>   shmem_fault[2112]              err = shmem_getpage_gfp(inode, vmf->pgoff, &vmf->page, SGP_CACHE,
>   shmem_read_mapping_page_gfp[4188] error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
>
> These are further shmem_getpage() call sites:
>
>   collapse_file[1735]            if (shmem_getpage(mapping->host, index, &page,
>   shmem_undo_range[965]          shmem_getpage(inode, start - 1, &page, SGP_READ);
>   shmem_undo_range[980]          shmem_getpage(inode, end, &page, SGP_READ);
>   shmem_write_begin[2467]        return shmem_getpage(inode, index, pagep, SGP_WRITE);
>   shmem_file_read_iter[2544]     error = shmem_getpage(inode, index, &page, sgp);
>   shmem_fallocate[2733]          error = shmem_getpage(inode, index, &page, SGP_FALLOC);
>   shmem_symlink[3079]            error = shmem_getpage(inode, 0, &page, SGP_WRITE);
>   shmem_get_link[3120]           error = shmem_getpage(inode, 0, &page, SGP_READ);
>   mcontinue_atomic_pte[235]      ret = shmem_getpage(inode, pgoff, &page, SGP_READ);
>
> Wondering whether this patch covered all of them.

No, it doesn't need. Not all places care about hwpoison page, for
example, truncate, hole punch, etc. Only the APIs which return the
data back to userspace or write back to disk need care about if the
data is corrupted or not since. This has been elaborated in the cover
letter.

>
> This also reminded me that whether we should simply fail shmem_getpage_gfp()
> directly, then all above callers will get a proper failure, rather than we do
> PageHWPoison() check everywhere?

Actually I did a prototype for this approach by returning
ERR_PTR(-EIO). But all the callers have to check this return value
even though the callers don't care about hwpoison page since all the
callers (not only shmem, but also all other filesystems) just check if
page is NULL but not check if it is an error pointer. This actually
incur more changes. It sounds not optimal IMHO. So I just treat
hwpoison as other flags, for example, Uptodate, and have callers check
it when necessary.

>
> --
> Peter Xu
>
