Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19D63CF8C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 13:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhGTKnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhGTKnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:43:15 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F98C061574;
        Tue, 20 Jul 2021 04:23:53 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a11so18840387ilf.2;
        Tue, 20 Jul 2021 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVnkGAPBzNUrDjo/vYV+V2SBEEyGsdjuUedWnsOzsis=;
        b=HhpzAjl09BeOsEUIHpVHWdklJxETeRFiANMBco0ll1FiBP/oqIp82Rp0IOuN4qVKf/
         qQnawPRP13Mt3ys+cZH7IYKZctRhluI109OvPpL4CRWr6teTA70+/oNb8BsdxyU63WHT
         hrG0rGLPRP2Jw46212Qk9eKPUTmtXFuZZ4SAmmSOfhJNiT38qdLD2BYccDeS8kZLk/I7
         XGrNwkZYwR4sP84muKsPDF6xLTxQ7OdUNrbC0O3LDULWEYeC2bq54/6iTi8y86jmCK6g
         kaII1t+FF7+XEDeZ8dFoloGAxGDqZxcTXvquESb2qtIbnU94CVRLN5/j5ulZPZU7FwXm
         DP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVnkGAPBzNUrDjo/vYV+V2SBEEyGsdjuUedWnsOzsis=;
        b=FpgEEIclCgEtvWrjfbEBemMHzehQl7lb9ynuQFs0AG83n6SRT9JhF4gI3OGul4Kor4
         iZtNLb5hssmSNYE9aDed8HzpQl4bwXm1gpLmjpIwxf+3uCx3WQcKpmH9eCcc7vSHT0oz
         44S4dQkPW/ii9MsejrTl8921W/rSRmK5Tgjhm/HibDivcX+HG78hB/xgML4TCc41nUUX
         s9HajtUsAjobCUhieHUtEx7WZd9Xd/DGeJnb0IDjl1EiPZ8+ZYuUybz4a9yj70+zAD0m
         5OsIMtrzJW1mSV0YzUT9sRqsP4L1mfFYiWc+cAr+oucd/oj4xUvQsBax1W0D780huiqa
         6hrA==
X-Gm-Message-State: AOAM533l35Ba5GX0iLyuucIua8Z6NrXTYCSolB38UFX4D7ioCxFQRAv1
        NanMwuNDwq6APzvXFlLAZzzWfR3IPtczewMBb1A=
X-Google-Smtp-Source: ABdhPJwvarTz9JB1YULDF9dibEw4xDmSKLba/T9RKxu2zqIT7IO1azlWgD4aPruTDh16Glzxq3MtzUk2SIEVDAghRYo=
X-Received: by 2002:a05:6e02:c73:: with SMTP id f19mr19729417ilj.291.1626780232988;
 Tue, 20 Jul 2021 04:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 20 Jul 2021 13:23:41 +0200
Message-ID: <CAHpGcMJ4T6byxqmO6zZF78wuw01twaEvSW5N6s90qWm0q_jCXQ@mail.gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mo., 19. Juli 2021 um 16:48 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> This tries to add tail packing inline read to iomap, which can support
> several inline tail blocks. Similar to the previous approach, it cleans
> post-EOF in one iteration.
>
> The write path remains untouched since EROFS cannot be used for testing.
> It'd be better to be implemented if upcoming real users care rather than
> leave untested dead code around.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2: https://lore.kernel.org/r/YPLdSja%2F4FBsjss%2F@B-P7TQMD6M-0146.local/
> changes since v2:
>  - update suggestion from Christoph:
>     https://lore.kernel.org/r/YPVe41YqpfGLNsBS@infradead.org/
>
> Hi Andreas,
> would you mind test on the gfs2 side? Thanks in advance!
>
> Thanks,
> Gao Xiang
>
>  fs/iomap/buffered-io.c | 50 ++++++++++++++++++++++++++----------------
>  fs/iomap/direct-io.c   | 11 ++++++----
>  2 files changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 87ccb3438bec..cac8a88660d8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -207,23 +207,22 @@ struct iomap_readpage_ctx {
>
>  static void
>  iomap_read_inline_data(struct inode *inode, struct page *page,
> -               struct iomap *iomap)
> +               struct iomap *iomap, loff_t pos)
>  {
> -       size_t size = i_size_read(inode);
> +       unsigned int size, poff = offset_in_page(pos);
>         void *addr;
>
> -       if (PageUptodate(page))
> -               return;
> -
> -       BUG_ON(page_has_private(page));
> -       BUG_ON(page->index);
> -       BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* inline source data must be inside a single page */
> +       BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* handle tail-packing blocks cross the current page into the next */
> +       size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> +                    PAGE_SIZE - poff);

Hmm, so EROFS really does multi-page tail packing? This contradicts
the comment and code in iomap_dio_inline_actor.

>         addr = kmap_atomic(page);
> -       memcpy(addr, iomap->inline_data, size);
> -       memset(addr + size, 0, PAGE_SIZE - size);
> +       memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> +       memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
>         kunmap_atomic(addr);
> -       SetPageUptodate(page);
> +       iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
>  }

It's been said before, but iomap_read_inline_data should return
PAGE_SIZE - poff, and no (void) casting when the return value is
ignored.

>  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>         unsigned poff, plen;
>         sector_t sector;
>
> -       if (iomap->type == IOMAP_INLINE) {
> -               WARN_ON_ONCE(pos);
> -               iomap_read_inline_data(inode, page, iomap);
> -               return PAGE_SIZE;
> -       }
> -
> -       /* zero post-eof blocks as the page may be mapped */
>         iop = iomap_page_create(inode, page);
> +       /* needs to skip some leading uptodated blocks */

"needs to skip some leading uptodate blocks"

>         iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
>         if (plen == 0)
>                 goto done;
>
> +       if (iomap->type == IOMAP_INLINE) {
> +               iomap_read_inline_data(inode, page, iomap, pos);
> +               plen = PAGE_SIZE - poff;
> +               goto done;
> +       }
> +
> +       /* zero post-eof blocks as the page may be mapped */
>         if (iomap_block_needs_zeroing(inode, iomap, pos)) {
>                 zero_user(page, poff, plen);
>                 iomap_set_range_uptodate(page, poff, plen);
> @@ -589,6 +589,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
>         return 0;
>  }
>
> +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> +               struct page *page, struct iomap *srcmap)
> +{
> +       /* needs more work for the tailpacking case, disable for now */
> +       if (WARN_ON_ONCE(pos != 0))

This should be a WARN_ON_ONCE(srcmap->offset != 0). Otherwise, something like:

  xfs_io -ft -c 'pwrite 1 2'

will fail because pos will be 1.

> +               return -EIO;
> +       if (PageUptodate(page))
> +               return 0;
> +       iomap_read_inline_data(inode, page, srcmap, pos);

The above means that passing pos to iomap_read_inline_data here won't
do the right thing, either.

> +       return 0;
> +}
> +
>  static int
>  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>                 struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> @@ -618,7 +630,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>         }
>
>         if (srcmap->type == IOMAP_INLINE)
> -               iomap_read_inline_data(inode, page, srcmap);
> +               status = iomap_write_begin_inline(inode, pos, page, srcmap);
>         else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>                 status = __block_write_begin_int(page, pos, len, NULL, srcmap);
>         else
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..ee6309967b77 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -379,22 +379,25 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  {
>         struct iov_iter *iter = dio->submit.iter;
>         size_t copied;
> +       void *dst = iomap->inline_data + pos - iomap->offset;
>
> -       BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> +       /* inline data must be inside a single page */
> +       BUG_ON(length > PAGE_SIZE - offset_in_page(iomap->inline_data));
>
>         if (dio->flags & IOMAP_DIO_WRITE) {
>                 loff_t size = inode->i_size;
>
>                 if (pos > size)
> -                       memset(iomap->inline_data + size, 0, pos - size);
> -               copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> +                       memset(iomap->inline_data + size - iomap->offset,
> +                              0, pos - size);
> +               copied = copy_from_iter(dst, length, iter);
>                 if (copied) {
>                         if (pos + copied > size)
>                                 i_size_write(inode, pos + copied);
>                         mark_inode_dirty(inode);
>                 }
>         } else {
> -               copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> +               copied = copy_to_iter(dst, length, iter);
>         }
>         dio->size += copied;
>         return copied;
> --
> 2.24.4
>

Thanks,
Andreas
