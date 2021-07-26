Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366A23D5506
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 10:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhGZH3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhGZH3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:29:02 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5641C061757;
        Mon, 26 Jul 2021 01:08:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r6so10687728ioj.8;
        Mon, 26 Jul 2021 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FnewBZVPWQdLydCvHrQoackd+XUDXZKA3Tq877jifYI=;
        b=h1lvFiPEOQhlTCh2gAG8KcbpHnLWlp46bozAGui8/TwtT+a9pXpHEPNheWAEwWttQy
         5C72QozD1+pFhrPSiNjk48qasitPIDDBjv0lj3HyecpChQPrfB4G4yK++L/Haaz1aGJX
         iJ1qrkD/GsTpbCIybEOjjp8FMrpLPppxuRAVpyth206c0OjEEF73HWxsSPD2w++Grtz5
         1UTxIfRV4gWmKTqaeWSQNoJrKzeqGUFD1HCafQHBXX/NdSggLPfKnitZ4cZKuRr2iIkt
         QCChs7yh/uhMK27mOTBf3a8ztp0mEln0C0xZw5welS+6/Pgp73BwI9zulpVMfF+1AAs/
         QnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FnewBZVPWQdLydCvHrQoackd+XUDXZKA3Tq877jifYI=;
        b=r26CYoC8/REhzKsUhTWSG5Kt+QSg1XBlzDV3lK+52YTQqWD7BCIRzmvoysZpyDVfKG
         FcO/08iNms2/YF4WWeRME7RK0Du0Lz/QbP46J5ifHoRxTvUtibSqF5y2FKJrsPJKVy8O
         uLK/AAPLa68pIKZQpTXjQWbyUIZmPbH9U/vpPiLwmeY/zlDnL0vtTGh1g447l2Nh1BSd
         OHybvyj8vpXpwJdpELIrFzL7s3RH3Eq3MPtG7MmnTFNU1XClcVoEVxEVemk3UefjghRu
         1vrMqpkV5rTyHS8Pk8GfFN+zWgt/guO2448t3AWpN5Bc/saqzv6ffpW4Y6VxfSDEFp8S
         KTOw==
X-Gm-Message-State: AOAM532O5shLg7GjiAlm470Al9bgjyra58luMUnHbLl1oT+ZdoyW4u0z
        wTmspG6pvgsWjoZudg9NqPI9LjahFxUj4ljuoh0=
X-Google-Smtp-Source: ABdhPJwUjXQOqKo4yjuRDaKyKP/be6KIdaziNfhQnY6qVZ757FPfQYQ/Xy36YW4KTYvrqm4l7TP6ECaSiip3p+4WVHs=
X-Received: by 2002:a5d:928f:: with SMTP id s15mr13728787iom.142.1627286898019;
 Mon, 26 Jul 2021 01:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com> <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
In-Reply-To: <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Mon, 26 Jul 2021 10:08:06 +0200
Message-ID: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 26. Juli 2021 um 06:00 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > Here's a fixed and cleaned up version that passes fstests on gfs2.
>
> (cont.
> https://lore.kernel.org/r/YP4fk75mr%2FmIotDy@B-P7TQMD6M-0146.local)
>
> Would you mind listing what it fixed on gfs2 compared with v7?
> IOWs, I wonder which case failed with v7 on gfs2 so I could recheck
> this.

The use of iomap->length or pos in iomap_read_inline_data is
fundamentally broken, that's what I've fixed.

> > I see no reason why the combination of tail packing + writing should
> > cause any issues, so in my opinion, the check that disables that
> > combination in iomap_write_begin_inline should still be removed.
> >
> > It turns out that returning the number of bytes copied from
> > iomap_read_inline_data is a bit irritating: the function is really used
> > for filling the page, but that's not always the "progress" we're looking
> > for.  In the iomap_readpage case, we actually need to advance by an
> > antire page, but in the iomap_file_buffered_write case, we need to
> > advance by the length parameter of iomap_write_actor or less.  So I've
> > changed that back.
> >
> > I've also renamed iomap_inline_buf to iomap_inline_data and I've turned
> > iomap_inline_data_size_valid into iomap_within_inline_data, which seems
> > more useful to me.
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > Subject: [PATCH] iomap: Support tail packing
> >
> > The existing inline data support only works for cases where the entire
> > file is stored as inline data.  For larger files, EROFS stores the
> > initial blocks separately and then can pack a small tail adjacent to the
> > inode.  Generalise inline data to allow for tail packing.  Tails may not
> > cross a page boundary in memory.
> >
> > We currently have no filesystems that support tail packing and writing,
> > so that case is currently disabled (see iomap_write_begin_inline).  I'm
> > not aware of any reason why this code path shouldn't work, however.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> >  fs/iomap/direct-io.c   | 11 ++++++-----
> >  include/linux/iomap.h  | 22 +++++++++++++++++++++-
> >  3 files changed, 50 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 87ccb3438bec..334bf98fdd4a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
> >       struct readahead_control *rac;
> >  };
> >
> > -static void
> > -iomap_read_inline_data(struct inode *inode, struct page *page,
> > +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> >               struct iomap *iomap)
> >  {
> > -     size_t size = i_size_read(inode);
> > +     size_t size = i_size_read(inode) - iomap->offset;
> >       void *addr;
> >
> >       if (PageUptodate(page))
> > -             return;
> > +             return 0;
> >
> > -     BUG_ON(page_has_private(page));
> > -     BUG_ON(page->index);
> > -     BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     /* inline and tail-packed data must start page aligned in the file */
> > +     if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> > +             return -EIO;
> > +     if (WARN_ON_ONCE(size > PAGE_SIZE - offset_in_page(iomap->inline_data)))
> > +             return -EIO;
> > +     if (WARN_ON_ONCE(page_has_private(page)))
> > +             return -EIO;
> >
> >       addr = kmap_atomic(page);
> >       memcpy(addr, iomap->inline_data, size);
> >       memset(addr + size, 0, PAGE_SIZE - size);
> >       kunmap_atomic(addr);
> >       SetPageUptodate(page);
> > +     return 0;
> >  }
> >
> >  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > @@ -247,7 +251,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >       sector_t sector;
> >
> >       if (iomap->type == IOMAP_INLINE) {
> > -             WARN_ON_ONCE(pos);
> >               iomap_read_inline_data(inode, page, iomap);
> >               return PAGE_SIZE;
> >       }
> > @@ -589,6 +592,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> >       return 0;
> >  }
> >
> > +static int iomap_write_begin_inline(struct inode *inode,
> > +             struct page *page, struct iomap *srcmap)
> > +{
> > +     /* needs more work for the tailpacking case, disable for now */
> > +     if (WARN_ON_ONCE(srcmap->offset != 0))
> > +             return -EIO;
> > +     return iomap_read_inline_data(inode, page, srcmap);
> > +}
> > +
> >  static int
> >  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >               struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> > @@ -618,7 +630,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >       }
> >
> >       if (srcmap->type == IOMAP_INLINE)
> > -             iomap_read_inline_data(inode, page, srcmap);
> > +             status = iomap_write_begin_inline(inode, page, srcmap);
> >       else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> >               status = __block_write_begin_int(page, pos, len, NULL, srcmap);
> >       else
> > @@ -671,11 +683,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> >       void *addr;
> >
> >       WARN_ON_ONCE(!PageUptodate(page));
> > -     BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     BUG_ON(!iomap_within_inline_data(iomap, pos + copied - 1));
> >
> >       flush_dcache_page(page);
> >       addr = kmap_atomic(page);
> > -     memcpy(iomap->inline_data + pos, addr + pos, copied);
> > +     memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
> >       kunmap_atomic(addr);
> >
> >       mark_inode_dirty(inode);
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 9398b8c31323..c9424e58f613 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -380,21 +380,22 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> >       struct iov_iter *iter = dio->submit.iter;
> >       size_t copied;
> >
> > -     BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     if (WARN_ON_ONCE(!iomap_within_inline_data(iomap, pos + length - 1)))
> > +             return -EIO;
>
> I also wonder what is wrong with the previous patch:
>
> +       if (WARN_ON_ONCE(!iomap_inline_data_size_valid(iomap)))
> +               return -EIO;
>
> +/*
> + * iomap->inline_data is a potentially kmapped page, ensure it never crosses a
> + * page boundary.
> + */
> +static inline bool iomap_inline_data_size_valid(const struct iomap *iomap)
> +{
> +       return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
> +}
>
> In principle, the relationship of iomap->offset, pos, length and
> iomap->length is:
>
> "       iomap->offset <= pos < pos + length <= iomap->offset +
> iomap->length   "
>
> pos and pos + length are also impacted by what user requests rather
> than the original extent itself reported by fs.
>
> Here we need to make sure the whole extent in the page, so I think
> it'd be better to check with iomap->length rather than some pos,
> length related stuffs.

Yeah okay, the difference is that I've checked the validity of the
range of the extent actually used and iomap_inline_data_size_valid
checks if the entire mapping is valid. So let's stick with Christoph's
previous version.

> >
> >       if (dio->flags & IOMAP_DIO_WRITE) {
> > -             loff_t size = inode->i_size;
> > +             loff_t size = iomap->offset + iomap->length;
>
> and here, since it's the last extent and due to the current limitation
> in practice,
> iomap->offset + iomap->length == inode->i_size,
>
> yet I wonder why this part uses iomap->length to calculate instead of
> using i_size as in iomap_read_inline_data().
>
> My thought is "here it handles the i_size pointer and append write",
> so I think "loff_t size = inode->i_size" makes more sense here.

Hmm, right.

> >               if (pos > size)
> > -                     memset(iomap->inline_data + size, 0, pos - size);
> > -             copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> > +                     memset(iomap_inline_data(iomap, size), 0, pos - size);
> > +             copied = copy_from_iter(iomap_inline_data(iomap, pos), length, iter);
>
> iomap_inline_buf() was suggested by Darrick. From my point of view,
> I think it's better since it's a part of iomap->inline_data due to
> pos involved.

I find iomap_inline_buf a bit more confusing because it's not
immediately obvious that "buf" == "data".

I'll send an updated version.

Thanks,
Andreas
