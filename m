Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66714352B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhJTSfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 14:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJTSfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:35:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6797FC06161C;
        Wed, 20 Oct 2021 11:32:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z20so127794edc.13;
        Wed, 20 Oct 2021 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsM4jLxeMymBTI6a6wnbQipLVv+fOhvGZcyhOoYnFOk=;
        b=pNoMx24xj3/RigF3UtWtulcuh1QGFMoN97+qQrfHD7LsrB3tkGpDiZgxIbeH8diy0r
         4UrcRHdSTAG1b8lcftXARzYc61ajv8CNwEX28qN+EdG798Io+hBgzdOwE7Mbul6WF5QR
         IUAPr3O7InmgVQoPZFtj7lYIDlC0lEX1AtwMOZv1GvGuD6WufOVc1BlPDti5Qa3+OmnD
         69jW/RHh/sYi80T+NE9e6BuR52CBB7bDtd7uLHbv+XS2mIpwhQr50IowbMl5Wl3TH5Wb
         6LdzDJ9ZW9Ep1Y0OIyUEh4oD1rf5YBmtfDn3DGmXuMsg4RwB99Ye3PGD5RyKR0cw3EHu
         8vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsM4jLxeMymBTI6a6wnbQipLVv+fOhvGZcyhOoYnFOk=;
        b=to4KlN+Dru9FnkW+z1vn+yzCwNze5f854ngZqr+22yAplszJFYruIWdW4wFBvtWsR4
         aUC1lbXslbATCQrvx+V5o7MNl2qYtPTTy4qfXrIZOwe7cRSstJK1/KLOhUXOuL5C4HUL
         48+yItVJeleX7mGuMZO6wyUbj4PLO9HR6EKx1aUSpr4jvPYyH3GU1k16WwOEeOFQ/d8J
         b0zXhG1Hnd79m6+kZhcvDk624/dnGulhVUq81BCLadHsBn4fpVlJ0U3BHKIhcLHXTK4G
         Ts1EdMWYkI1WTxPP/1YS+iK/oWzB/v63Gjk1wf78mohqMcv/12rL71R8KgPy/NjUGAfJ
         xrKg==
X-Gm-Message-State: AOAM530/PhXv+rFNvNa1WSl2oG26VztPbLURUzWGWoXq3bC/cN5IplLd
        u6zAE48SmVzMwAroHeZeicSP0wBiMbh4rWDOqFc=
X-Google-Smtp-Source: ABdhPJxkNo5L9kIdLwLpxQfVifGdQqoOvOJc71Xf1YnE1qBxOaQL8vfZmUp+FNmpXa+OM3DNiCo6qEuaaTrgppOADtE=
X-Received: by 2002:a05:6402:891:: with SMTP id e17mr779015edy.81.1634754771904;
 Wed, 20 Oct 2021 11:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211014191615.6674-1-shy828301@gmail.com> <20211014191615.6674-6-shy828301@gmail.com>
 <20211019055221.GC2268449@u2004>
In-Reply-To: <20211019055221.GC2268449@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Oct 2021 11:32:39 -0700
Message-ID: <CAHbLzkpTxn9a5WODAVOZhsOoTZoxstBeS1XpeKG6n1mL9rpBYA@mail.gmail.com>
Subject: Re: [v4 PATCH 5/6] mm: shmem: don't truncate page if memory failure happens
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

On Mon, Oct 18, 2021 at 10:52 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Thu, Oct 14, 2021 at 12:16:14PM -0700, Yang Shi wrote:
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
> >  mm/memory-failure.c | 10 +++++++++-
> >  mm/shmem.c          | 37 ++++++++++++++++++++++++++++++++++---
> >  mm/userfaultfd.c    |  5 +++++
> >  3 files changed, 48 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index cdf8ccd0865f..f5eab593b2a7 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -57,6 +57,7 @@
> >  #include <linux/ratelimit.h>
> >  #include <linux/page-isolation.h>
> >  #include <linux/pagewalk.h>
> > +#include <linux/shmem_fs.h>
> >  #include "internal.h"
> >  #include "ras/ras_event.h"
> >
> > @@ -866,6 +867,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
> >  {
> >       int ret;
> >       struct address_space *mapping;
> > +     bool extra_pins;
> >
> >       delete_from_lru_cache(p);
> >
> > @@ -894,6 +896,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
> >               goto out;
> >       }
> >
> > +     /*
> > +      * The shmem page is kept in page cache instead of truncating
> > +      * so is expected to have an extra refcount after error-handling.
> > +      */
> > +     extra_pins = shmem_mapping(mapping);
> > +
> >       /*
> >        * Truncation is a bit tricky. Enable it per file system for now.
> >        *
> > @@ -903,7 +911,7 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
> >  out:
> >       unlock_page(p);
> >
> > -     if (has_extra_refcount(ps, p, false))
> > +     if (has_extra_refcount(ps, p, extra_pins))
> >               ret = MF_FAILED;
> >
> >       return ret;
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b5860f4a2738..69eaf65409e6 100644
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
> > @@ -2466,7 +2467,15 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> >                       return -EPERM;
> >       }
> >
> > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +
> > +     if (*pagep && PageHWPoison(*pagep)) {
>
> shmem_getpage() could return with pagep == NULL, so you need check ret first
> to avoid NULL pointer dereference.
>
> > +             unlock_page(*pagep);
> > +             put_page(*pagep);
> > +             ret = -EIO;
> > +     }
> > +
> > +     return ret;
> >  }
> >
> >  static int
> > @@ -2555,6 +2564,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >                       unlock_page(page);
> >               }
> >
> > +             if (page && PageHWPoison(page)) {
> > +                     error = -EIO;
>
> Is it cleaner to add PageHWPoison() check in the existing "if (page)" block
> just above?  Then, you don't have to check "page != NULL" twice.
>
> @@ -2562,7 +2562,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>                         if (sgp == SGP_CACHE)
>                                 set_page_dirty(page);
>                         unlock_page(page);
>
> +                       if (PageHWPoison(page)) {
> +                               error = -EIO;
> +                               break;

Further looking shows I missed a "put_page" in the first place. Will
fix in the next version too.

> +                       }
>                 }
>
>                 /*
>
>
> Thanks,
> Naoya Horiguchi
