Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028A341F6A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhJAVKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJAVKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:10:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A3DC061775;
        Fri,  1 Oct 2021 14:08:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so39408442edt.7;
        Fri, 01 Oct 2021 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXIGOwidwYWPojVj+QkQOP2rlviWSjFjrreCUlP7Pc4=;
        b=DxgSh1ywafLUskHGUCY9KcouyOj20cLCVdIUANPokB/UJC629Q5OP0LmBXsf3uEWaa
         taNAV1tnZ4MCrsdLuUrL58eTdgoN7HwZHRSR+EokiAvOrTujS6C+XGakU1Ar8C8Et2Kh
         GNZXlxVeHvhxDqB3W9Ol71t2gUQyVdCuloV3xjCysgfVNjH4TM/xBiyBhKiYMOrsQQBT
         3RiL4AIP5abLsmJd0fe8TKWLqcu/MD6Cn6jEGyGn+hopXMPHYg86JzTnsKzpbnKFrFSf
         oMGYuZGaP+Iz57c2wEUUsmDdCJ+jy2nZQUacD+mE/69ItZP6GqeOIkRE6ZfYXc3xlyKX
         rE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXIGOwidwYWPojVj+QkQOP2rlviWSjFjrreCUlP7Pc4=;
        b=IrdrF3FubIa6wdSnL0iYW3dr9Xlts7Tl7wRBlEqhUmnlutKEBIxd4DEavCLsxSxrfW
         zKxlCl84TyRIUuK0KzkkOhYQr5fVLRBw8szRSMfH7ff4CWyzaVTVLg3BlLbcGyaWJe85
         /9hX/DcZMtk7O//chHTSwGZ+BSkZxkt5lcv42fcjPK6tPUSeMXn3CYgkRO35tCTv+ulR
         jJLd50bDuaK2N5exeJZsgoxzLG40M1BbTwCBew3VciCrhKtGqgCNVpsgjC+vzCKVXEN2
         JdUwsTOKfffnb7I+9A0iyp0FlpxDiCnILfuaL1GelglLyaLUe6hoZb7t7BBO/ZRhOy79
         f8jg==
X-Gm-Message-State: AOAM53268uSxNhZd+LIuYJGjhkgGqQfkx2m4uHYKTIZZX2BkYAkT4YTZ
        BtqdEX/u2qwyQ1anffOAs+q2SW8HgB4Ug3VK5OQ=
X-Google-Smtp-Source: ABdhPJxNFruDUCogGSg8fAf4b1g6IqqCSmdf6Zz4PLYW/+LeRqbefG2WuhyXJmvtQctIoPkS6ygWiqwEHAdtUZuPXLY=
X-Received: by 2002:a50:e044:: with SMTP id g4mr337701edl.46.1633122534073;
 Fri, 01 Oct 2021 14:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-5-shy828301@gmail.com>
 <20211001070539.GA1364952@u2004>
In-Reply-To: <20211001070539.GA1364952@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 1 Oct 2021 14:08:41 -0700
Message-ID: <CAHbLzkouad1qTUr1KPV5Ubaa74=Q4Emvg5BX4iO3p8M3kY0XFw@mail.gmail.com>
Subject: Re: [v3 PATCH 4/5] mm: shmem: don't truncate page if memory failure happens
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
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

On Fri, Oct 1, 2021 at 12:05 AM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:10PM -0700, Yang Shi wrote:
> > The current behavior of memory failure is to truncate the page cache
> > regardless of dirty or clean.  If the page is dirty the later access
> > will get the obsolete data from disk without any notification to the
> > users.  This may cause silent data loss.  It is even worse for shmem
> > since shmem is in-memory filesystem, truncating page cache means
> > discarding data blocks.  The later read would return all zero.
> >
> > The right approach is to keep the corrupted page in page cache, any
> > later access would return error for syscalls or SIGBUS for page fault,
> > until the file is truncated, hole punched or removed.  The regular
> > storage backed filesystems would be more complicated so this patch
> > is focused on shmem.  This also unblock the support for soft
> > offlining shmem THP.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> ...
> > @@ -894,6 +896,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
> >               goto out;
> >       }
> >
> > +     /*
> > +      * The shmem page is kept in page cache instead of truncating
> > +      * so need decrement the refcount from page cache.
> > +      */
>
> This comment seems to me confusing because no refcount is decremented here.
> What the variable dec tries to do is to give the expected value of the
> refcount of the error page after successfull erorr handling, which differs
> according to the page state before error handling, so dec adjusts it.
>
> How about the below?
>
> +       /*
> +        * The shmem page is kept in page cache instead of truncating
> +        * so is expected to have an extra refcount after error-handling.
> +        */

Thanks for the suggestion, yes, it seems better.

>
> > +     dec = shmem_mapping(mapping);
> > +
> >       /*
> >        * Truncation is a bit tricky. Enable it per file system for now.
> >        *
> ...
> > @@ -2466,7 +2467,17 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> >                       return -EPERM;
> >       }
> >
> > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +
> > +     if (*pagep) {
> > +             if (PageHWPoison(*pagep)) {
>
> Unless you plan to add some code in the near future, how about merging
> these two if sentences?
>
>         if (*pagep && PageHWPoison(*pagep)) {

Sure.

>
> Thanks,
> Naoya Horiguchi
>
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
