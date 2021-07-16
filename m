Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACA33CBA20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhGPP4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhGPP4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:56:30 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1885C06175F;
        Fri, 16 Jul 2021 08:53:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z11so11190393iow.0;
        Fri, 16 Jul 2021 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yShQ0w4qzLoVnuPkOVdukVpyIyk/pCo4eKwDcVHu++E=;
        b=qUSqXqr/51Qsk99OqBkZ1bu50pzl443gJ88idV65QHwFQXDybGkypN5TfGy/Xjt+TF
         SBIpZQdWLPm6SgZjqzzpxr/i9Ndcs+9v/AZlRS6UAHPYv+ny132MYHTKvqppqv1ZGjqj
         LPqRT4IhdeHDwAmetkXvhy3xs2PY30ZwdyZECeeoFi5j/Z6A6i5xilImoZjzqkQQRuZF
         GrmTSmI6II7RXQXzoPoSErEAr/3XgxkkBc495fy0rFxPGToiM2JpKB5ErBHSfZjXl4Q3
         R2Rt0oc9uRqLW0zN7mvL3nSUnzfdsZSOZFWNrK+fHL/CrxvrDvRtgkJCuYTMYOC6N7fT
         P/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yShQ0w4qzLoVnuPkOVdukVpyIyk/pCo4eKwDcVHu++E=;
        b=XztJ10ZAvhZ+9MgXaqiso67JPGLDcFu+1UgDzBq7sIqGHH5ZOKHwIP5uTL2ip4kuK+
         +DCHCB1JNXNqHSZ5TqVRw1Luh+JP5wRQW7ZkkOb1FURyz9gzgvLpZbbbqALrRjk06Xo9
         phidc3elyAAvsaxfTLZn8+TR6oRma/TskDxJeb92wkBEl1dl/4Yi+PBj+3152hhOHFb3
         Ghug2kjU5tOiaSoVv71t/L6dcgLd5lXu7W7PRx4R5raWYj3KTbjDNpLJAQH+RaGnT6CX
         r4dKlvkG8MhG669qXPW85rABFLggwk/rHF6kFiQ7KqqLJC99jiTzwBu1HlNDXpCnoYFI
         T/qA==
X-Gm-Message-State: AOAM533MO1VZ9v+l9ONSc1MMXRnurw5TGbAqFDry/3P8zUDWQh/pYIa1
        bbWrpiNxPQJhNIulKulHNRyFyOs9KKvXUIOib6E=
X-Google-Smtp-Source: ABdhPJxXIP3px6bE903QFzXiDL8FsSzF8D/Z+LKnJqHfKwdULQ3dBLvztnF9spyN0ub8f+zFBc2br/Wp1e0jwWWkBpY=
X-Received: by 2002:a6b:c90f:: with SMTP id z15mr7703884iof.183.1626450810983;
 Fri, 16 Jul 2021 08:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com> <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local> <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
In-Reply-To: <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 16 Jul 2021 17:53:19 +0200
Message-ID: <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
To:     Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chao Yu <chao@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Fr., 16. Juli 2021 um 17:03 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> On Fri, Jul 16, 2021 at 03:44:04PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 16, 2021 at 09:56:23PM +0800, Gao Xiang wrote:
> > > Hi Matthew,
> > >
> > > On Fri, Jul 16, 2021 at 02:02:29PM +0100, Matthew Wilcox wrote:
> > > > On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> > > > > This tries to add tail packing inline read to iomap. Different from
> > > > > the previous approach, it only marks the block range uptodate in the
> > > > > page it covers.
> > > >
> > > > Why?  This path is called under two circumstances: readahead and readpage.
> > > > In both cases, we're trying to bring the entire page uptodate.  The inline
> > > > extent is always the tail of the file, so we may as well zero the part of
> > > > the page past the end of file and mark the entire page uptodate instead
> > > > and leaving the end of the page !uptodate.
> > > >
> > > > I see the case where, eg, we have the first 2048 bytes of the file
> > > > out-of-inode and then 20 bytes in the inode.  So we'll create the iop
> > > > for the head of the file, but then we may as well finish the entire
> > > > PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
> > > > as being uptodate and leave the 3072-4095 block for a future iteration.
> > >
> > > Thanks for your comments. Hmm... If I understand the words above correctly,
> > > what I'd like to do is to cover the inline extents (blocks) only
> > > reported by iomap_begin() rather than handling other (maybe)
> > > logical-not-strictly-relevant areas such as post-EOF (even pages
> > > will be finally entirely uptodated), I think such zeroed area should
> > > be handled by from the point of view of the extent itself
> > >
> > >          if (iomap_block_needs_zeroing(inode, iomap, pos)) {
> > >                  zero_user(page, poff, plen);
> > >                  iomap_set_range_uptodate(page, poff, plen);
> > >                  goto done;
> > >          }
> >
> > That does work.  But we already mapped the page to write to it, and
> > we already have to zero to the end of the block.  Why not zero to
> > the end of the page?  It saves an iteration around the loop, it saves
> > a mapping of the page, and it saves a call to flush_dcache_page().
>
> I completely understand your concern, and that's also (sort of) why I
> left iomap_read_inline_page() to make the old !pos behavior as before.
>
> Anyway, I could update Christoph's patch to behave like what you
> suggested. Will do later since I'm now taking some rest...

Looking forward to that for some testing; Christoph's version was
already looking pretty good.

This code is a bit brittle, hopefully less so with the recent iop
fixes on iomap-for-next.

> > > The benefits I can think out are 1) it makes the logic understand
> > > easier and no special cases just for tail-packing handling 2) it can
> > > be then used for any inline extent cases (I mean e.g. in the middle of
> > > the file) rather than just tail-packing inline blocks although currently
> > > there is a BUG_ON to prevent this but it's easier to extend even further.
> > > 3) it can be used as a part for later partial page uptodate logic in
> > > order to match the legacy buffer_head logic (I remember something if my
> > > memory is not broken about this...)
> >
> > Hopefully the legacy buffer_head logic will go away soon.
>
> Hmmm.. I partially agree on this (I agree buffer_head is a legacy stuff
> but...), considering some big PAGE_SIZE like 64kb or bigger, partial
> uptodate can save I/O for random file read pattern in general (not mmap
> read, yes, also considering readahead, but I received some regression
> due to I/O amplification like this when I was at the previous * 2 company).

Thanks,
Andreas
