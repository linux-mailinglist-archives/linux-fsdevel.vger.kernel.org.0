Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D06D413AD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 21:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhIUTg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 15:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhIUTg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:36:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B1C061574;
        Tue, 21 Sep 2021 12:34:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id bx4so653802edb.4;
        Tue, 21 Sep 2021 12:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UibWS27dG8CTdjCuiOWaZ3ON4LxN1iE+u65371mY3a0=;
        b=ShnVAfrWu5IT9WTexqaZjjzqQU9EMo/+7ySpOf+s0xZCWk9Mc8wFc7xUSxhh5fjB5F
         wYz6AQeB6KOZx/N7GdlMWoIpSLktglS0E+IYJr+sBMcb6sEPsYqN5IEdqYcV2PcUqIHc
         UKw5fqkaZ60QeVChr7xp9oW4MwdtEHwI3RztFQ5zEl/soIKrZeKhgmSZiy3KJ4hwiIgt
         X5UTjooyVa9FTCjH0eT6WnMHC9IGHpgyr7g/FyBo45ucAT3Fdh+Hd+tUo6gAPtL9fCeR
         8p6VkYdfSksSKPgQVrrf79aWL40BphuEPMCTKUljg3H2pm2zVXNtoogJT8pZfrUMji7Z
         WX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UibWS27dG8CTdjCuiOWaZ3ON4LxN1iE+u65371mY3a0=;
        b=pDVp4AS3WrmIBmtYyC1rK9BbZHs2AERr0uEfQyzfg/XsxqbhP9lXOSZQ+Ta2Xu/+YS
         5KxmNchzLYF0uZiGVAYSr8bEQk3ISisd89u7wYL/U6UmDrLXJLnJAdiq39KQYBW7mJn9
         K7Ip/SsqCd1KoTx0kqYnRJ9nJryPqg1JJ796jAV3UlTf2M2ECXtxipng4jxYORprVpLC
         YQthVMhZhLxARBEkvau4afWC9kctvsRJsGXpMKN/+rgj0xgqTZCy2m10qYw/xd7wXwVJ
         uxW32TxTqdwcoGnxZ/Wi585rt2lPZHctiFPD1uah30hZqpQs1HXixVakIETT8009GNYa
         eZBA==
X-Gm-Message-State: AOAM532efN/8UEOg7eqTV8N3Xow8TYVeX16aHx2c5PMbVWSJgPYkOkAU
        ZrUCvcXbMKmd94BW9tD6WGJXfXYbwxj0ZTxV9/yEEy7UGJg=
X-Google-Smtp-Source: ABdhPJwOFmeQMvCgyBmT6psowBIEA54SUKqi+LlzYiTmkOhrdNgQSsWNofJcoRi6XBE2EFUaY1gkRxVHSF2cx8r2nbo=
X-Received: by 2002:a50:9d49:: with SMTP id j9mr26706153edk.81.1632252897323;
 Tue, 21 Sep 2021 12:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210914183718.4236-1-shy828301@gmail.com> <20210914183718.4236-4-shy828301@gmail.com>
 <20210921094915.GA817765@u2004>
In-Reply-To: <20210921094915.GA817765@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Sep 2021 12:34:44 -0700
Message-ID: <CAHbLzkrxFrG9ncaFMVZhnXut0VmON0MP1bM=4DqFgwqXGRtoJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: shmem: don't truncate page if memory failure happens
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
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

On Tue, Sep 21, 2021 at 2:49 AM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Tue, Sep 14, 2021 at 11:37:17AM -0700, Yang Shi wrote:
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
> >  mm/memory-failure.c |  3 ++-
> >  mm/shmem.c          | 25 +++++++++++++++++++++++--
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 54879c339024..3e06cb9d5121 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1101,7 +1101,8 @@ static int page_action(struct page_state *ps, struct page *p,
> >       result = ps->action(p, pfn);
> >
> >       count = page_count(p) - 1;
> > -     if (ps->action == me_swapcache_dirty && result == MF_DELAYED)
> > +     if ((ps->action == me_swapcache_dirty && result == MF_DELAYED) ||
> > +         (ps->action == me_pagecache_dirty && result == MF_FAILED))
>
> This new line seems to affect the cases of dirty page cache
> on other filesystems, whose result is to miss "still referenced"
> messages for some unmap failure cases (although it's not so critical).
> So checking filesystem type (for example with shmem_mapping())
> might be helpful?
>
> And I think that if we might want to have some refactoring to pass
> *ps to each ps->action() callback, then move this refcount check to
> the needed places.
> I don't think that we always need the refcount check, for example in
> MF_MSG_KERNEL and MF_MSG_UNKNOWN cases (because no one knows the
> expected values for these cases).

Yeah, seems make sense to me. How's about doing the below (totally untested):

static inline bool check_refcount(struct *page, bool dec)
{
    int count = page_count(page) - 1;

    if (dec || shmem_mapping(page->mapping))
        count -= 1;

    if (count > 0) {
         pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
                       pfn, action_page_types[ps->type], count);
         return false;
    }

    return true;
}

Then call this in the needed me_* functions and return right value per
the return value of it. I think me_swapcache_dirty() is the only place
need pass in true for dec parameter.

>
>
> >               count--;
> >       if (count > 0) {
> >               pr_err("Memory failure: %#lx: %s still referenced by %d users\n",
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 88742953532c..ec33f4f7173d 100644
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
> > @@ -2466,7 +2467,19 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> >                       return -EPERM;
> >       }
> >
> > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +
> > +     if (!ret) {
>
> Maybe this "!ret" check is not necessary because *pagep is set
> non-NULL only when ret is 0.  It could save one indent level.

Yes, sure.

>
> > +             if (*pagep) {
> > +                     if (PageHWPoison(*pagep)) {
> > +                             unlock_page(*pagep);
> > +                             put_page(*pagep);
> > +                             ret = -EIO;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return ret;
> >  }
> >
> >  static int
> > @@ -2555,6 +2568,11 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
> > @@ -3782,7 +3800,6 @@ const struct address_space_operations shmem_aops = {
> >  #ifdef CONFIG_MIGRATION
> >       .migratepage    = migrate_page,
> >  #endif
> > -     .error_remove_page = generic_error_remove_page,
>
> This change makes truncate_error_page() calls invalidate_inode_page(),
> and in my testing it fails with "Failed to invalidate" message.
> So as a result memory_failure() finally returns with -EBUSY. I'm not
> sure it's expected because this patchset changes to keep error pages
> in page cache as a proper error handling.
> Maybe you can avoid this by defining .error_remove_page in shmem_aops
> which simply returns 0.

Yes, the "Failed to invalidate" message seems confusing. I agree a
shmem specific callback is better.

>
> >  };
> >  EXPORT_SYMBOL(shmem_aops);
> >
> > @@ -4193,6 +4210,10 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> >               page = ERR_PTR(error);
> >       else
> >               unlock_page(page);
> > +
> > +     if (PageHWPoison(page))
> > +             page = NULL;
> > +
> >       return page;
>
> One more comment ...
>
>   - I guess that you add PageHWPoison() checks after some call sites
>     of shmem_getpage() and shmem_getpage_gfp(), but seems not cover all.
>     For example, mcontinue_atomic_pte() in mm/userfaultfd.c can properly
>     handle PageHWPoison?

No, I didn't touch anything outside shmem.c. I could add this in the
next version.

BTW, I just found another problem for the change in
shmem_read_mapping_page_gfp(), it should return ERR_PTR(-EIO) instead
of NULL since the callers may not handle NULL. Will fix in the next
version too.

>
> I'm trying to test more detail, but in my current understanding,
> this patch looks promising to me.  Thank you for your effort.

Thank a lot for taking time do the review.

>
> Thanks,
> Naoya Horiguchi
