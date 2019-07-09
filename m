Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD763E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfGIXdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 19:33:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38266 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfGIXdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 19:33:04 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so721072ioa.5;
        Tue, 09 Jul 2019 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIUrZj+BDjlHUYg9P/JNrT9rNRNZ1v2LjG+KSEP7U6w=;
        b=F0gxhoa3etuWdVoE30cEqcj0LqUKEAZwa0xkl0+GjSGDCJo3JUqNjtN3rZ85qRbGwB
         BVuYJbLydwo71dBAL8vNGXDIDFfJlrgNWwFo8TndYM9cK1XKCCmOpxCdQc3nG8F0UHz3
         W0bNeK4FX9aNoT5+IwvbH6lv79X9Dv/e3bS91aoIMV4DEDL3ferlxNcvQJq4N0c0TbX4
         ebHdOxF+vfTRwM4OLr/ZBq3RnuCTeGXsKSzxHjlg44JfXyHSXb+PYmgdWJuXFBSNSvJR
         kx9bd5P9uko4ncoPOuOxvQ6sIxAtqA4ISRS8wg4TmdChp6lg8Pp52utwoAOpS/EJiCWr
         EbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIUrZj+BDjlHUYg9P/JNrT9rNRNZ1v2LjG+KSEP7U6w=;
        b=Hy/n7J2xiB1iSBY3UHeaa8e8Y0sMlfVsy6wWXEQzDdOx4moH82w2Z9asROCScvUvVK
         z6nIrqspBk5IlxnBwd6EeLI7u25HsZe5ijJS4YLTdKhpe4JCxZpRu11kihKUpP3pc5TM
         C/Xlk2VHHh/wP5QiiuKc2Z3vpvHhMjuwS92QB8xfHUxjADvug1+J5fedadSwBFK7AU1k
         QNg1POeDNc08XRbHjKZdaktwB/60ljd4CXmQvAw1qIb7daiXXPN6tl7p9fIh+X7dLHaE
         m+w3MLZYG1teCSzkW2DsI6lJ64cUv4Jc13+d2MQHTfPAreJkufdKXgGcgxMoXWLpUYD1
         RGIA==
X-Gm-Message-State: APjAAAVLLnAZmtu0/WK5lI7qkyUAvOo1I2TAs5SC7wpRfXUcBANWcEmM
        xqXpWzDHSo40lQaP2HkmjqAyBYDc9Y5HwP/AsRs=
X-Google-Smtp-Source: APXvYqzLTEcrOgkBAiNGsyWRkbm4UAU6XiKTKxJaIUkpM0iYMbZzbs/wYgqL0457Bsfp0Mh93Gwx1+nlvICd2tE1EGo=
X-Received: by 2002:a5e:9e42:: with SMTP id j2mr22391505ioq.133.1562715183564;
 Tue, 09 Jul 2019 16:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190703075502.79782-1-yuchao0@huawei.com>
In-Reply-To: <20190703075502.79782-1-yuchao0@huawei.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 10 Jul 2019 01:32:51 +0200
Message-ID: <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing case
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>, chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chao,

Am Mi., 3. Juli 2019 um 09:55 Uhr schrieb Chao Yu <yuchao0@huawei.com>:
> Some filesystems like erofs/reiserfs have the ability to pack tail
> data into metadata, e.g.:
> IOMAP_MAPPED [0, 8192]
> IOMAP_INLINE [8192, 8200]
>
> However current IOMAP_INLINE type has assumption that:
> - inline data should be locating at page #0.
> - inline size should equal to .i_size
> Those restriction fail to convert to use iomap IOMAP_INLINE in erofs,
> so this patch tries to relieve above limits to make IOMAP_INLINE more
> generic to cover tail-packing case.

this patch suffers from the following problems:

* Fiemap distinguishes between FIEMAP_EXTENT_DATA_INLINE and
FIEMAP_EXTENT_DATA_TAIL. Someone will sooner or later inevitably use
iomap_fiemap on a filesystem with tail packing, so if we don't make
the same distinction in iomap, iomap_fiemap will silently produce the
wrong result. This means that IOMAP_TAIL should become a separate
mapping type.

* IOMAP_INLINE mappings always start at offset 0 and span an entire
page, so they are always page aligned. IOMAP_TAIL mappings only need
to be block aligned. If the block size is smaller than the page size,
a tail page can consist of more than one mapping. So
iomap_read_inline_data needs to be changed to only copy a single block
out of iomap->inline_data, and we need to adjust iomap_write_begin and
iomap_readpage_actor accordingly.

* Functions iomap_read_inline_data, iomap_write_end_inline, and
iomap_dio_inline_actor currently all assume that we are operating on
page 0, and that iomap->inline_data points at the data at offset 0.
That's no longer the case for IOMAP_TAIL mappings. We need to look
only at the offset within the page / block there.

* There are some asserts like the following int he code:

  BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));

Those should probably be tightened to check for block boundaries
instead of page boundaries, i.e. something like:

  BUG_ON(size > i_blocksize(inode) -
offset_in_block(iomap->inline_data, inode));

> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/iomap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/iomap.c b/fs/iomap.c
> index 12654c2e78f8..d1c16b692d31 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -264,13 +264,12 @@ static void
>  iomap_read_inline_data(struct inode *inode, struct page *page,
>                 struct iomap *iomap)
>  {
> -       size_t size = i_size_read(inode);
> +       size_t size = iomap->length;

Function iomap_read_inline_data fills the entire page here, not only
the iomap->length part, so this is wrong. But see my comment above
about changing iomap_read_inline_data to read a single block above as
well.

>         void *addr;
>
>         if (PageUptodate(page))
>                 return;
>
> -       BUG_ON(page->index);
>         BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
>
>         addr = kmap_atomic(page);
> @@ -293,7 +292,6 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         sector_t sector;
>
>         if (iomap->type == IOMAP_INLINE) {
> -               WARN_ON_ONCE(pos);
>                 iomap_read_inline_data(inode, page, iomap);
>                 return PAGE_SIZE;
>         }

Those last two changes look right to me.

Thanks,
Andreas
