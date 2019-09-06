Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C28FAC22E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 23:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404700AbfIFVso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 17:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404449AbfIFVso (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:48:44 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D70D7C08C321
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2019 21:48:43 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id a17so4000044oto.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 14:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WJRsnFYnpcG/84+37k58Ernnh9jii5S94NsOJ3BU2I=;
        b=rWdvjcwriUwg6WiZ5gYDBlnicVnpwq7gxEkq6bBvJm1jvLkWK3jSgl+GW4XwHf4KI0
         9GYs9lt1Nt9YhC8E2vrQczY6yYUMibBkXLgDTZf0A+oNuPOT7lF5FX4pPoY8ucOg2CV9
         hl1kzKRK7qDOgu0VrxqW4auUEJrHpPpsH/PH7QAD5VqakVfPLt2TWP46PGwuyMTlK66/
         sfEIUsfphErQfLSpmjZnXkS8EfGp4xYUUgyhtUhzHBzJwnuYuZ3Qb/UeF5uADAgmfPRy
         hmfOn3WXRvBd/sDRbf0U1NB+3iBgjpeZtS1WholeGhIPZu9+ExoL5Yes8HrNwYz8VzPV
         Gq/Q==
X-Gm-Message-State: APjAAAXTImtTLLrHiRT4ZT2guuuawvmsO8xoicvAZ+xEnJiVBq0gsn/E
        QgCs4rKUw2xqlMXwCqbTLkxoTFrz93APcougSJF3u75dK+GNXAFMHRq6ACiG8g6+IxN+2m5YNcJ
        03+xGuCCGzgItgOqFm+O5U4D5LLG9rrqaoBgBYaDmeg==
X-Received: by 2002:aca:aa56:: with SMTP id t83mr8874744oie.178.1567806523101;
        Fri, 06 Sep 2019 14:48:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqye15i1gX9ZpzmamOPH9muPyVRWyZCi7G16OHNSbCrx+GNtAlQVhmii1YJoF0040MhZwNkhDvufnkahA0N59EU=
X-Received: by 2002:aca:aa56:: with SMTP id t83mr8874736oie.178.1567806522876;
 Fri, 06 Sep 2019 14:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190906205241.2292-1-agruenba@redhat.com> <20190906212758.GO1119@dread.disaster.area>
In-Reply-To: <20190906212758.GO1119@dread.disaster.area>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 6 Sep 2019 23:48:31 +0200
Message-ID: <CAHc6FU5BxOHkgHKKWTL7jFq0oL4TbAPpe49QDB6X35ndjYTWKQ@mail.gmail.com>
Subject: Re: [Q] gfs2: mmap write vs. punch_hole consistency
To:     Dave Chinner <david@fromorbit.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Lukas Czerner <lczerner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 6, 2019 at 11:28 PM Dave Chinner <david@fromorbit.com> wrote:
> On Fri, Sep 06, 2019 at 10:52:41PM +0200, Andreas Gruenbacher wrote:
> > Hi,
> >
> > I've just fixed a mmap write vs. truncate consistency issue on gfs on
> > filesystems with a block size smaller that the page size [1].
> >
> > It turns out that the same problem exists between mmap write and hole
> > punching, and since xfstests doesn't seem to cover that,
>
> AFAIA, fsx exercises it pretty often. Certainly it's found problems
> with XFS in the past w.r.t. these operations.
>
> > I've written a
> > new test [2].
>
> I suspect that what we really want is a test that runs
> _test_generic_punch using mmap rather than pwrite...
>
> > Ext4 and xfs both pass that test; they both apparently
> > mark the pages that have a hole punched in them as read-only so that
> > page_mkwrite is called before those pages can be written to again.
>
> XFS invalidates the range being hole punched (see
> xfs_flush_unmap_range() under XFS_MMAPLOCK_EXCL, which means any
> attempt to fault that page back in will block on the MMAPLOCK until
> the hole punch finishes.

This isn't about writes during the hole punching, this is about writes
once the hole is punched. For example, the test case I've posted
creates the following file layout with 1k blocksize:

  DDDD DDDD DDDD

Then it punches a hole like this:

  DDHH HHHH HHDD

Then it fills the hole again with mwrite:

  DDDD DDDD DDDD

As far as I can tell, that needs to trigger page faults on all three
pages. I did get these on ext4; judging from the fact that xfs works,
the also seem to occur there; but on gfs2, page_mkwrite isn't called
for the two partially mapped pages, only for the page in the middle
that's entirely within the hole. And I don't see where those pages are
marked read-only; it appears like pagecache_isize_extended isn't
called on ext4 or xfs. So how does this work there?

> > gfs2 fails that: for some reason, the partially block-mapped pages are
> > not marked read-only on gfs2, and so page_mkwrite is not called for the
> > partially block-mapped pages, and the hole is not filled in correctly.
> >
> > The attached patch fixes the problem, but this really doesn't look right
> > as neither ext4 nor xfs require this kind of hack.  So what am I
> > overlooking, how does this work on ext4 and xfs?
>
> XFS uses XFS_MMAPLOCK_* to serialise page faults against extent
> manipulations (shift, hole punch, truncate, swap, etc) and ext4 uses
> a similar locking mechanism to do the same thing. Fundamentally, the
> page cache does not provide the necessary mechanisms to detect and
> prevent invalidation races inside EOF....

Yes, but that unfortunately doesn't answer my question.

Thanks,
Andreas

> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  fs/gfs2/bmap.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > index 9ef543dd38e2..e677e813be4c 100644
> > --- a/fs/gfs2/bmap.c
> > +++ b/fs/gfs2/bmap.c
> > @@ -2475,6 +2475,13 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
> >                       if (error)
> >                               goto out;
> >               }
> > +             /*
> > +              * If the first or last page partially lies in the hole, mark
> > +              * the page read-only so that memory-mapped writes will trigger
> > +              * page_mkwrite.
> > +              */
> > +             pagecache_isize_extended(inode, offset, inode->i_size);
> > +             pagecache_isize_extended(inode, offset + length, inode->i_size);
>
> See xfs_flush_unmap_range(), which is run under XFS_MMAPLOCK_EXCL
> to serialise against incoming page faults...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
