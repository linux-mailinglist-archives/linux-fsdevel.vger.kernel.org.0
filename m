Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D664E1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 23:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfGJVuv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 17:50:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37018 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbfGJVuv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:50:51 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so8086656iog.4;
        Wed, 10 Jul 2019 14:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=szjTCXs/+qzPjQoJIlXrmJ5QRPtMUoSrM9cPDUs6dgg=;
        b=dIVcKYaknlt37uO6ESWKfchDa+WB9+B5g+y3PeiUwxUyVLmkiVYp7v9ARUuAw2Aufo
         qGkvuaajAEo9I2w3whE7ewAT903bK7+tGpe6rM1uH/dblZd38Kbrk49gH/IdMkurUTRH
         1D+MBld/AiyH02qS4bit48NM4gq7fpia4ATUjr3PN2It5TORTrmoNFIOFCnZcHcPLijF
         gnGSAJot0Ytfr1kUIAeV0yMTCIMnBkOqE2hkdXhb6RM0Tqy3+9wYqHvzBqCzfbq7Q8QG
         V/27WRLaSAGyOfYo0qFCPMIkBs5G7IEB+UfDqJo4bSEsfwbScXtZuaQLgiwrvg6DJFrp
         Vj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=szjTCXs/+qzPjQoJIlXrmJ5QRPtMUoSrM9cPDUs6dgg=;
        b=I6eXmfA9sFaPxRZA3+FBNcfiwMSmfCPuD6vRwvbm7xTGiSj4VqcKu+gAN7D3QHwqFk
         T3b+8dqP3y9DgkCoCTbO31cW6H2FOorXeqcOEtYQzozZDeGMT3JDSXT3NogOtECAjR+V
         HBAav4ECHoFgX75SHl5U+5KH2Vu9Gy4voWwKoNiOhnyyu0g6pwJAXA5d1TW2Hz45fOrK
         zQcmJ+lWXspgidSir4QelSDNb1hgYg8ferc8ccAJUPYpeqmcrAJa1pFlBD+CTb5KlJYd
         iWPfuTGWa4PrnDKxYXYfX62Vv8WbGFu31x5HJ4ImnTSfsnnWdImUJlsM3JptiEFzjUbE
         Mp4w==
X-Gm-Message-State: APjAAAUIYMiPBjLJbisJQtezp/svGwujOvcgK91JfSu0LCCgmUBz8eqM
        37BLU87K8cJqH6DFFL+Nsgo1SW7CggnVG2ObBYYyolzE
X-Google-Smtp-Source: APXvYqywSqqa4SHlujvNVxfUYsAaEqPdPXoF6aCEi5Pmeih57jtNFLzWD6Y8hjCf/hTm6N2bo/WYmWoiS6J9eljuGtQ=
X-Received: by 2002:a5e:9e42:: with SMTP id j2mr360059ioq.133.1562795450420;
 Wed, 10 Jul 2019 14:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190703075502.79782-1-yuchao0@huawei.com> <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
In-Reply-To: <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 10 Jul 2019 23:50:39 +0200
Message-ID: <CAHpGcMJ_wPJf8KtF3xMP_28pe4Vq4XozFtmd2EuZ+RTqZKQxLA@mail.gmail.com>
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing case
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>, chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 10. Juli 2019 um 12:31 Uhr schrieb Chao Yu <yuchao0@huawei.com>:
> Hi Andreas,
>
> Thanks for your review in advance. :)
>
> On 2019/7/10 7:32, Andreas Gr=C3=BCnbacher wrote:
> > Hi Chao,
> >
> > Am Mi., 3. Juli 2019 um 09:55 Uhr schrieb Chao Yu <yuchao0@huawei.com>:
> >> Some filesystems like erofs/reiserfs have the ability to pack tail
> >> data into metadata, e.g.:
> >> IOMAP_MAPPED [0, 8192]
> >> IOMAP_INLINE [8192, 8200]
> >>
> >> However current IOMAP_INLINE type has assumption that:
> >> - inline data should be locating at page #0.
> >> - inline size should equal to .i_size
> >> Those restriction fail to convert to use iomap IOMAP_INLINE in erofs,
> >> so this patch tries to relieve above limits to make IOMAP_INLINE more
> >> generic to cover tail-packing case.
> >
> > this patch suffers from the following problems:
> >
> > * Fiemap distinguishes between FIEMAP_EXTENT_DATA_INLINE and
> > FIEMAP_EXTENT_DATA_TAIL. Someone will sooner or later inevitably use
> > iomap_fiemap on a filesystem with tail packing, so if we don't make
> > the same distinction in iomap, iomap_fiemap will silently produce the
> > wrong result. This means that IOMAP_TAIL should become a separate
> > mapping type.
>
> I'm a little confused, IIUC, IOMAP_TAIL and FIEMAP_EXTENT_DATA_TAIL are w=
ith
> different semantics:
>
> - IOMAP_TAIL:
>   we may introduce this flag to cover tail-packing case, in where we merg=
e
> small-sized data in the tail of file into free space of its metadata.
> - FIEMAP_EXTENT_DATA_TAIL:
> quoted from Documentation/filesystems/fiemap.txt
> "  This will also set FIEMAP_EXTENT_NOT_ALIGNED
> Data is packed into a block with data from other files."
> It looks like this flag indicates that blocks from different files stores=
 into
> one common block.

Well, maybe FIEMAP_EXTENT_DATA_INLINE is indeed the more appropriate
flag in your scenario. In that case, we should be fine on the fiemap
front.

> I'm not familiar with fiemap flags' history, but maybe FIEMAP_EXTENT_DATA=
_TAIL
> should be better to rename to FIEMAP_EXTENT_DATA_PACKING to avoid ambigui=
ty. And
> then FIEMAP_EXTENT_DATA_INLINE will be enough to cover normal inline case=
 and
> tail-packing case?

Those definitions are user-visible.

> > * IOMAP_INLINE mappings always start at offset 0 and span an entire
> > page, so they are always page aligned. IOMAP_TAIL mappings only need
>
> Why can't #0 page consist of more than one block/mapping? I didn't get wh=
at's
> difference here.

Currently, iomap_write_begin will read the inline data into page #0
and mark that page up-to-date. There's a check for that in
iomap_write_end_inline. If a page contains more than one mapping, we
won't be able to mark the entire page up to date anymore; we'd need to
track which parts of the page are up to date and which are not. Iomap
supports two tracking mechanisms, buffer heads and iomap_page, and
we'd need to implement that tracking code for each of those cases.

> > to be block aligned. If the block size is smaller than the page size,
>
> - reiserfs tries to find last page's content, if the size of that page's =
valid
> content is smaller than threshold (at least less than one block), reiserf=
s can
> do the packing.
>
> - erofs' block size is 4kb which is the same as page size.
>
>
> Actually, for IOMAP_TAIL, there is no users who need to map more than one=
 block
> into metadata, so I'm not sure that we should support that, or we just ne=
ed to
> let code preparing for that to those potential users?

How about architectures with PAGE_SIZE > 4096? I'm assuming that erofs
doesn't require block size =3D=3D PAGE_SIZE?

> Thanks,
>
> > a tail page can consist of more than one mapping. So
> > iomap_read_inline_data needs to be changed to only copy a single block
> > out of iomap->inline_data, and we need to adjust iomap_write_begin and
> > iomap_readpage_actor accordingly.
> >
> > * Functions iomap_read_inline_data, iomap_write_end_inline, and
> > iomap_dio_inline_actor currently all assume that we are operating on
> > page 0, and that iomap->inline_data points at the data at offset 0.
> > That's no longer the case for IOMAP_TAIL mappings. We need to look
> > only at the offset within the page / block there.
> >
> > * There are some asserts like the following int he code:
> >
> >   BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> >
> > Those should probably be tightened to check for block boundaries
> > instead of page boundaries, i.e. something like:
> >
> >   BUG_ON(size > i_blocksize(inode) -
> > offset_in_block(iomap->inline_data, inode));
> >
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/iomap.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/fs/iomap.c b/fs/iomap.c
> >> index 12654c2e78f8..d1c16b692d31 100644
> >> --- a/fs/iomap.c
> >> +++ b/fs/iomap.c
> >> @@ -264,13 +264,12 @@ static void
> >>  iomap_read_inline_data(struct inode *inode, struct page *page,
> >>                 struct iomap *iomap)
> >>  {
> >> -       size_t size =3D i_size_read(inode);
> >> +       size_t size =3D iomap->length;
> >
> > Function iomap_read_inline_data fills the entire page here, not only
> > the iomap->length part, so this is wrong. But see my comment above
> > about changing iomap_read_inline_data to read a single block above as
> > well.
> >
> >>         void *addr;
> >>
> >>         if (PageUptodate(page))
> >>                 return;
> >>
> >> -       BUG_ON(page->index);
> >>         BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> >>
> >>         addr =3D kmap_atomic(page);
> >> @@ -293,7 +292,6 @@ iomap_readpage_actor(struct inode *inode, loff_t p=
os, loff_t length, void *data,
> >>         sector_t sector;
> >>
> >>         if (iomap->type =3D=3D IOMAP_INLINE) {
> >> -               WARN_ON_ONCE(pos);
> >>                 iomap_read_inline_data(inode, page, iomap);
> >>                 return PAGE_SIZE;
> >>         }
> >
> > Those last two changes look right to me.
> >
> > Thanks,
> > Andreas
> > .
> >

At this point, can I ask how important this packing mechanism is to
you? I can see a point in implementing inline files, which help
because there tends to be a large number of very small files. But for
not-so-small files, is saving an extra block really worth the trouble,
especially given how cheap storage has become?

Thanks,
Andreas
