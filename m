Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9063DE0C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhHBUg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhHBUg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:36:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC5BC06175F;
        Mon,  2 Aug 2021 13:36:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hs10so24238883ejc.0;
        Mon, 02 Aug 2021 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBWtV7N+RxH/CGPxWHVVPsVwXrz5q6//82lIjHdhJwk=;
        b=dZjqXQSQJ+v4/jf7G29LGsKvh6x+AOb0oGYBMMznnJ3q4NjcfHQ8mHJzkBCKKQ9CzU
         4bMEE0mY2rh8+ivUJqwoBfUTrZgLkE66Xc15R8Uvy+tIaLRkFCkGRhFKNeLfq71pM3WX
         RQBOA3ryTimbaIeOc6CNntH0Q7FBxwucGeE2btN5wWeue9iDtUs19AZySnaq+FJeJ2Di
         wJQmkgU/Tw5eMvjDKRw+f1nlXnsoWiODiKmtOb0/AjY9Rd7Pn8w7uarkaD9qTIod3nn8
         i8JegkEq4i0r0aOrscicZ2LtIHQhNGMjKVwJ0+j2hJSFg6JaaIxESpYHjE/o8oVGiqtn
         skYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBWtV7N+RxH/CGPxWHVVPsVwXrz5q6//82lIjHdhJwk=;
        b=oJxTJsHv/h4BpKXZb5X+mQif8e3vHMKVzbVW8+Gf+5t6Pz5hab++Y/W3VyKms9yvhO
         u27mVKw0S2rId/aGGcUuCnKGeNObx+ZT3mxCWrqZdGDuySPHK6g5IYEk9rIjPRVs8Lwe
         XzvDsfMcR4i4NR/WG3w2HuPUbagv4cdiRcjTcDYjh2ZUTfayfkTNl38BpuTXWCTo2NQh
         OtWhkNeAefO27ahqbqdCJ9JWocITAkZ6lKci0phWoS0fK0FXOqPHDd1s4SVoj7MrXKqp
         KicLVURrzJrPH0Vbuk6yDBObr8a+LditGNU7KxEqGh7HTCepMHfFbhFflbXkT+AS5B5L
         3TWg==
X-Gm-Message-State: AOAM532aZIvN3Kexp6DBE3y3DNSkFD5N/UiS41OSC2fZ64h8dv3wohEF
        oXqFEDZSLB1eL1w90e6tDLRTzaZKvcyIoMvB9lQ=
X-Google-Smtp-Source: ABdhPJwFajkjqJ/lrekCzz9XwsvODk97FD+a2XwTBTnhhdH0saAAl6Z3OYjKtXSNXFb1fHhngk46UbjmPQt3yc+CIGE=
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr16721382ejf.383.1627936576255;
 Mon, 02 Aug 2021 13:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <af71608e-ecc-af95-3511-1a62cbf8d751@google.com> <CAHbLzkqp5-SrOBkpvxieswD6OwPT70gsztNpXCTBXW2JnrFpfg@mail.gmail.com>
 <422db5c4-2490-749c-964b-dd2b93286ed5@google.com>
In-Reply-To: <422db5c4-2490-749c-964b-dd2b93286ed5@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 2 Aug 2021 13:36:04 -0700
Message-ID: <CAHbLzkrvB6r5CKxwhcKmLZN+H3t10UuqeXT5vgi=YzkZjA2qnw@mail.gmail.com>
Subject: Re: [PATCH 01/16] huge tmpfs: fix fallocate(vanilla) advance over
 huge pages
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 31, 2021 at 8:38 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Fri, 30 Jul 2021, Yang Shi wrote:
> > On Fri, Jul 30, 2021 at 12:25 AM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > shmem_fallocate() goes to a lot of trouble to leave its newly allocated
> > > pages !Uptodate, partly to identify and undo them on failure, partly to
> > > leave the overhead of clearing them until later.  But the huge page case
> > > did not skip to the end of the extent, walked through the tail pages one
> > > by one, and appeared to work just fine: but in doing so, cleared and
> > > Uptodated the huge page, so there was no way to undo it on failure.
> > >
> > > Now advance immediately to the end of the huge extent, with a comment on
> > > why this is more than just an optimization.  But although this speeds up
> > > huge tmpfs fallocation, it does leave the clearing until first use, and
> > > some users may have come to appreciate slow fallocate but fast first use:
> > > if they complain, then we can consider adding a pass to clear at the end.
> > >
> > > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> >
> > Reviewed-by: Yang Shi <shy828301@gmail.com>
>
> Many thanks for reviewing so many of these.
>
> >
> > A nit below:
> >
> > > ---
> > >  mm/shmem.c | 19 ++++++++++++++++---
> > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 70d9ce294bb4..0cd5c9156457 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -2736,7 +2736,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> > >         inode->i_private = &shmem_falloc;
> > >         spin_unlock(&inode->i_lock);
> > >
> > > -       for (index = start; index < end; index++) {
> > > +       for (index = start; index < end; ) {
> > >                 struct page *page;
> > >
> > >                 /*
> > > @@ -2759,13 +2759,26 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> > >                         goto undone;
> > >                 }
> > >
> > > +               index++;
> > > +               /*
> > > +                * Here is a more important optimization than it appears:
> > > +                * a second SGP_FALLOC on the same huge page will clear it,
> > > +                * making it PageUptodate and un-undoable if we fail later.
> > > +                */
> > > +               if (PageTransCompound(page)) {
> > > +                       index = round_up(index, HPAGE_PMD_NR);
> > > +                       /* Beware 32-bit wraparound */
> > > +                       if (!index)
> > > +                               index--;
> > > +               }
> > > +
> > >                 /*
> > >                  * Inform shmem_writepage() how far we have reached.
> > >                  * No need for lock or barrier: we have the page lock.
> > >                  */
> > > -               shmem_falloc.next++;
> > >                 if (!PageUptodate(page))
> > > -                       shmem_falloc.nr_falloced++;
> > > +                       shmem_falloc.nr_falloced += index - shmem_falloc.next;
> > > +               shmem_falloc.next = index;
> >
> > This also fixed the wrong accounting of nr_falloced, so it should be
> > able to avoid returning -ENOMEM prematurely IIUC. Is it worth
> > mentioning in the commit log?
>
> It took me a long time to see your point there: ah yes, because it made
> the whole huge page Uptodate when it reached the first tail, there would
> have been only one nr_falloced++ for the whole of the huge page: well
> spotted, thanks, I hadn't realized that.
>
> Though I'm not so sure about your premature -ENOMEM: because once it has
> made the huge page Uptodate, the other end (shmem_writepage()) will not
> be incrementing nr_unswapped at all: so -ENOMEM would have been deferred
> rather than premature, wouldn't it?

Ah, ok, I didn't pay too much attention to how nr_unswapped is
incremented. Just thought nr_falloced will be incremented by 512
rather than 1, so it is more unlikely to return -ENOMEM.

>
> Add a comment on this in the commit log: yes, I guess so, but I haven't
> worked out what to write yet.
>
> Hugh
>
> >
> > >
> > >                 /*
> > >                  * If !PageUptodate, leave it that way so that freeable pages
> > > --
> > > 2.26.2
