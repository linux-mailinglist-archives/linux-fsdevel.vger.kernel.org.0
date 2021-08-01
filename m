Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97A3DCB7E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Aug 2021 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhHAMDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Aug 2021 08:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231527AbhHAMDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Aug 2021 08:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627819427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2Sl+xhZ07fi1CiyZFUc8volC3Ldaw50waFma86MTYk=;
        b=hg3DGMbdZd4gyrWmEm1lCFuyL6PZB437vIUJFIJlQT3Eq41eQLMwYmtiQzmkL49WwTIa85
        fB7Kzu7rBmNFBJnlvlrom19Zca2zEEob6oZThnREteXE2rYNoaaxYRB7DRY0PowIfqR1f6
        8fyLe+FvtBG7a38DhDeUkg2wYfQhrDg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-zUVjwtLqMcqse71M22FS-g-1; Sun, 01 Aug 2021 08:03:45 -0400
X-MC-Unique: zUVjwtLqMcqse71M22FS-g-1
Received: by mail-wm1-f72.google.com with SMTP id c41-20020a05600c4a29b0290253935d0f82so4525436wmp.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Aug 2021 05:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2Sl+xhZ07fi1CiyZFUc8volC3Ldaw50waFma86MTYk=;
        b=bwN9Zjxi52jsw2MvfKqmlns152qwAC1qIOUJYXIybUSNedq6Xmdlgrpgr81/MEki81
         zz9XEfVIc4hiT75pXZgeJTaBCuxtJHTfXosBEG1dZdBkrOIVnclaQIl6ukyJVnEp/pFV
         yV0VEsPHXtx6vIc0ItAU+GJMffnuAzUL47SIeFrlE+cmqSTkjr6AWyGshlUKolwa2UaD
         /CFjRtCCK6M7osGGKU2C5qteGtWpkw3v2HmYX6zbAUyCWY1kY+nooFRDFpCMA9fmOlEC
         Uq6Ld2ZnmN6vqu/Po3x1SGlL1vi6DF6T5PlZFM553E/R2ySpIK5tT8gcVxCz+K0rshvI
         nUvg==
X-Gm-Message-State: AOAM5328KqoWDnf7tKKKbWXM8FanpSLT2vOlQ++BBOx6sUsdPLqnDzBR
        7UkpxY81zZFwNa7BseZ3T5sE/kYyweJzOkZkmevDOQPKogburIi5gF1BhjCIFQi0yKPgnPudT1I
        HCt42Dk/iaXAUfqN0Li/uGDNtctgn4NX/UrbHta12lQ==
X-Received: by 2002:adf:dd07:: with SMTP id a7mr12098465wrm.377.1627819424741;
        Sun, 01 Aug 2021 05:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxin7fSOKTA/2+6Wli3DPO8r9DTT4yPQtSqbMy0Ofb2InWsVF6RHpk3vh1EWlAKwHFL5ikAFILUBPDJvWbnuWc=
X-Received: by 2002:adf:dd07:: with SMTP id a7mr12098452wrm.377.1627819424528;
 Sun, 01 Aug 2021 05:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 1 Aug 2021 14:03:33 +0200
Message-ID: <CAHc6FU5x3XOTyu8vooReSZ-hacfTdo3cu7wFJRcQrfTH8NkVeg@mail.gmail.com>
Subject: Re: [PATCH v9] iomap: Support file tail packing
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 5:00 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> The existing inline data support only works for cases where the entire
> file is stored as inline data.  For larger files, EROFS stores the
> initial blocks separately and then can pack a small tail adjacent to the
> inode.  Generalise inline data to allow for tail packing.  Tails may not
> cross a page boundary in memory.
>
> We currently have no filesystems that support tail packing and writing,
> so that case is currently disabled (see iomap_write_begin_inline).
>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v8: https://lore.kernel.org/r/20210726145734.214295-1-hsiangkao@linux.alibaba.com
> changes since v8:
>  - update the subject to 'iomap: Support file tail packing' as there
>    are clearly a number of ways to make the inline data support more
>    flexible (Matthew);
>
>  - add one extra safety check (Darrick):
>         if (WARN_ON_ONCE(size > iomap->length))
>                 return -EIO;
>
>  fs/iomap/buffered-io.c | 42 ++++++++++++++++++++++++++++++------------
>  fs/iomap/direct-io.c   | 10 ++++++----
>  include/linux/iomap.h  | 18 ++++++++++++++++++
>  3 files changed, 54 insertions(+), 16 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..f429b9d87dbe 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -205,25 +205,32 @@ struct iomap_readpage_ctx {
>         struct readahead_control *rac;
>  };
>
> -static void
> -iomap_read_inline_data(struct inode *inode, struct page *page,
> +static int iomap_read_inline_data(struct inode *inode, struct page *page,
>                 struct iomap *iomap)
>  {
> -       size_t size = i_size_read(inode);
> +       size_t size = i_size_read(inode) - iomap->offset;
>         void *addr;
>
>         if (PageUptodate(page))
> -               return;
> +               return 0;
>
> -       BUG_ON(page_has_private(page));
> -       BUG_ON(page->index);
> -       BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* inline data must start page aligned in the file */
> +       if (WARN_ON_ONCE(offset_in_page(iomap->offset)))
> +               return -EIO;
> +       if (WARN_ON_ONCE(size > PAGE_SIZE -
> +                        offset_in_page(iomap->inline_data)))
> +               return -EIO;
> +       if (WARN_ON_ONCE(size > iomap->length))
> +               return -EIO;
> +       if (WARN_ON_ONCE(page_has_private(page)))
> +               return -EIO;
>
>         addr = kmap_atomic(page);
>         memcpy(addr, iomap->inline_data, size);
>         memset(addr + size, 0, PAGE_SIZE - size);
>         kunmap_atomic(addr);
>         SetPageUptodate(page);
> +       return 0;
>  }
>
>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -247,8 +254,10 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         sector_t sector;
>
>         if (iomap->type == IOMAP_INLINE) {
> -               WARN_ON_ONCE(pos);
> -               iomap_read_inline_data(inode, page, iomap);
> +               int ret = iomap_read_inline_data(inode, page, iomap);
> +
> +               if (ret)
> +                       return ret;
>                 return PAGE_SIZE;
>         }
>
> @@ -589,6 +598,15 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>         return 0;
>  }
>
> +static int iomap_write_begin_inline(struct inode *inode,
> +               struct page *page, struct iomap *srcmap)
> +{
> +       /* needs more work for the tailpacking case, disable for now */

Nit: the comma should be a semicolon or period here.

> +       if (WARN_ON_ONCE(srcmap->offset != 0))
> +               return -EIO;
> +       return iomap_read_inline_data(inode, page, srcmap);
> +}
> +
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>                 struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> @@ -618,7 +636,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>         }
>
>         if (srcmap->type == IOMAP_INLINE)
> -               iomap_read_inline_data(inode, page, srcmap);
> +               status = iomap_write_begin_inline(inode, page, srcmap);
>         else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>                 status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>         else
> @@ -671,11 +689,11 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
>         void *addr;
>
>         WARN_ON_ONCE(!PageUptodate(page));
> -       BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       BUG_ON(!iomap_inline_data_valid(iomap));
>
>         flush_dcache_page(page);
>         addr = kmap_atomic(page);
> -       memcpy(iomap->inline_data + pos, addr + pos, copied);
> +       memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
>         kunmap_atomic(addr);
>
>         mark_inode_dirty(inode);
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..41ccbfc9dc82 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -378,23 +378,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>                 struct iomap_dio *dio, struct iomap *iomap)
>  {
>         struct iov_iter *iter = dio->submit.iter;
> +       void *inline_data = iomap_inline_data(iomap, pos);
>         size_t copied;
>
> -       BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
> +               return -EIO;
>
>         if (dio->flags & IOMAP_DIO_WRITE) {
>                 loff_t size = inode->i_size;
>
>                 if (pos > size)
> -                       memset(iomap->inline_data + size, 0, pos - size);
> -               copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +                       memset(iomap_inline_data(iomap, size), 0, pos - size);
> +               copied = copy_from_iter(inline_data, length, iter);
>                 if (copied) {
>                         if (pos + copied > size)
>                                 i_size_write(inode, pos + copied);
>                         mark_inode_dirty(inode);
>                 }
>         } else {
> -               copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +               copied = copy_to_iter(inline_data, length, iter);
>         }
>         dio->size += copied;
>         return copied;
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 479c1da3e221..b8ec145b2975 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -97,6 +97,24 @@ iomap_sector(struct iomap *iomap, loff_t pos)
>         return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
>
> +/*
> + * Returns the inline data pointer for logical offset @pos.
> + */
> +static inline void *iomap_inline_data(struct iomap *iomap, loff_t pos)
> +{
> +       return iomap->inline_data + pos - iomap->offset;
> +}
> +
> +/*
> + * Check if the mapping's length is within the valid range for inline data.
> + * This is used to guard against accessing data beyond the page inline_data
> + * points at.
> + */
> +static inline bool iomap_inline_data_valid(struct iomap *iomap)
> +{
> +       return iomap->length <= PAGE_SIZE - offset_in_page(iomap->inline_data);
> +}
> +
>  /*
>   * When a filesystem sets page_ops in an iomap mapping it returns, page_prepare
>   * and page_done will be called for each page written to.  This only applies to
> --
> 2.24.4
>

Andreas

