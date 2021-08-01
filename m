Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3C3DC97C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhHADiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Jul 2021 23:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhHADiV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Jul 2021 23:38:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122BC0613D3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jul 2021 20:38:12 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f22so13513082qke.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jul 2021 20:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5WRI9ovrYarzT6P+AQzyPA+zqmSi1roZ3PpwFTiVvsU=;
        b=VP/8wrr+L9Dht4u0MJMeSSOm1ThNwDEsQqkwdL+2BxCgXIuJ+MtclIzdrzF/wfhwMO
         yQ9miYXYFYxmzqvE8QDOodcfyok+5jByfAzw8wF3wNFWeBLMx99WiZucz5wBgngYUAG0
         PNEfZyKutEQKhv6MNwosmIeiGLkol1lcMX9jMIOIlPL4LfC6ZJwo9ofOYjIlfyoo8elj
         Tk9j9lZLUVZfMBgp0+Zy/9aL+ydhZQxCzLimxef0eqhpgDaVFsu9AwrBGWIR+hiMR2JA
         DBAHTy92duQwewQ5ydWLQ4g3BiHgN7LOF2EDS7FnLkBJTpjECrqrXzcX7XbflLAbrVlY
         xtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=5WRI9ovrYarzT6P+AQzyPA+zqmSi1roZ3PpwFTiVvsU=;
        b=JWihCcVYdF+9j42Mweuof9f1oP6YAzu7HUfuQD4Wy+lw3bQnlsbH7k1xVHnE+nI9DC
         RUZ8ZuqqVklMjTidn4s9z29eSv5DOhTleMK10WfatcOzflKyb0138PVUTfBgVmIT/9u+
         TpfOjWkbuH25OuwDfhY2KpiyRwMOFMZjKROLGPFKBAPCcoaZ7IZUw+SniBBGm4Tv5qh9
         AhCxQVqU1LdpHjxd4Tg8gW4ovdEyinRC2KRqEuffwqyM90/SUJhEw0WPci08TgG89BHD
         U1uwNqLRkFEhmSmv7DVogJZgsVExcwEgqVylHXy/i39W0rvrIREC4LJ63YI5bS4fLUqN
         rfvA==
X-Gm-Message-State: AOAM532jM3ukxLAM44tZGsaPxDZBqzLMICTVYWKRk3gBpDB2SfAzkJvV
        RecOs2Cn46ZcCfo/9PTzW8itIw==
X-Google-Smtp-Source: ABdhPJzbeKbM+hBpLElHX4ZgSN+ykriUzfv8c09OhRuDRYE+xw9J+GYvowS5xY0q7CP8coU+Pjf4kA==
X-Received: by 2002:a05:620a:31a1:: with SMTP id bi33mr9497896qkb.146.1627789091715;
        Sat, 31 Jul 2021 20:38:11 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d200sm3505724qke.95.2021.07.31.20.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 20:38:11 -0700 (PDT)
Date:   Sat, 31 Jul 2021 20:38:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 01/16] huge tmpfs: fix fallocate(vanilla) advance over
 huge pages
In-Reply-To: <CAHbLzkqp5-SrOBkpvxieswD6OwPT70gsztNpXCTBXW2JnrFpfg@mail.gmail.com>
Message-ID: <422db5c4-2490-749c-964b-dd2b93286ed5@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <af71608e-ecc-af95-3511-1a62cbf8d751@google.com> <CAHbLzkqp5-SrOBkpvxieswD6OwPT70gsztNpXCTBXW2JnrFpfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Yang Shi wrote:
> On Fri, Jul 30, 2021 at 12:25 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > shmem_fallocate() goes to a lot of trouble to leave its newly allocated
> > pages !Uptodate, partly to identify and undo them on failure, partly to
> > leave the overhead of clearing them until later.  But the huge page case
> > did not skip to the end of the extent, walked through the tail pages one
> > by one, and appeared to work just fine: but in doing so, cleared and
> > Uptodated the huge page, so there was no way to undo it on failure.
> >
> > Now advance immediately to the end of the huge extent, with a comment on
> > why this is more than just an optimization.  But although this speeds up
> > huge tmpfs fallocation, it does leave the clearing until first use, and
> > some users may have come to appreciate slow fallocate but fast first use:
> > if they complain, then we can consider adding a pass to clear at the end.
> >
> > Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>

Many thanks for reviewing so many of these.

> 
> A nit below:
> 
> > ---
> >  mm/shmem.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 70d9ce294bb4..0cd5c9156457 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2736,7 +2736,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >         inode->i_private = &shmem_falloc;
> >         spin_unlock(&inode->i_lock);
> >
> > -       for (index = start; index < end; index++) {
> > +       for (index = start; index < end; ) {
> >                 struct page *page;
> >
> >                 /*
> > @@ -2759,13 +2759,26 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
> >                         goto undone;
> >                 }
> >
> > +               index++;
> > +               /*
> > +                * Here is a more important optimization than it appears:
> > +                * a second SGP_FALLOC on the same huge page will clear it,
> > +                * making it PageUptodate and un-undoable if we fail later.
> > +                */
> > +               if (PageTransCompound(page)) {
> > +                       index = round_up(index, HPAGE_PMD_NR);
> > +                       /* Beware 32-bit wraparound */
> > +                       if (!index)
> > +                               index--;
> > +               }
> > +
> >                 /*
> >                  * Inform shmem_writepage() how far we have reached.
> >                  * No need for lock or barrier: we have the page lock.
> >                  */
> > -               shmem_falloc.next++;
> >                 if (!PageUptodate(page))
> > -                       shmem_falloc.nr_falloced++;
> > +                       shmem_falloc.nr_falloced += index - shmem_falloc.next;
> > +               shmem_falloc.next = index;
> 
> This also fixed the wrong accounting of nr_falloced, so it should be
> able to avoid returning -ENOMEM prematurely IIUC. Is it worth
> mentioning in the commit log?

It took me a long time to see your point there: ah yes, because it made
the whole huge page Uptodate when it reached the first tail, there would
have been only one nr_falloced++ for the whole of the huge page: well
spotted, thanks, I hadn't realized that.

Though I'm not so sure about your premature -ENOMEM: because once it has
made the huge page Uptodate, the other end (shmem_writepage()) will not
be incrementing nr_unswapped at all: so -ENOMEM would have been deferred
rather than premature, wouldn't it?

Add a comment on this in the commit log: yes, I guess so, but I haven't
worked out what to write yet.

Hugh

> 
> >
> >                 /*
> >                  * If !PageUptodate, leave it that way so that freeable pages
> > --
> > 2.26.2
