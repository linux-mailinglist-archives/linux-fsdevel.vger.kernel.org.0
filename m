Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD266BE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGLLyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 07:54:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45292 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfGLLyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 07:54:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so9145448otq.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 04:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UP2JkXb8rivDdZry18yWq0+s2llH13OfYegmlQ9SgOE=;
        b=tPj9zkAXc4XbXFTT6guGNQffwX7WAgMPeiUUwKuoMAVLrDwnSYcL3Z0lcdF2aSNY5n
         aXeEgjzj37PqYw4W+f0NUJ8m47i48L9gzofZcmdqOcqyObngWb5xemAuLJn12DquzoQL
         9CfWI/VOSwEdechG4I2eTiyLVhX+QcAmtoGYA6M0lp5biHWiBI93K5NcK4f9tvx+49c0
         Zp4qGJVnIn3h2bgHGJfZCfPiX/DNoOZePLKe/XQPF83CfhRZ0mj1Pon0bqJFSmGjhfWc
         N8gN1jsuVxpGmlmZMP9miZjzaBbycbTtfiaFsm43sdDThYPQz8ib2neo8Y28oXyPgdgo
         zpQQ==
X-Gm-Message-State: APjAAAVtsQsMWxUHMB3lbgDD05uWMsWEkKB8MEuq4VpIvzEQ92uEcjtr
        HtB5BUoxivLSEybUD8B6HxwdxYqTzWZXZRK2Du+yZA==
X-Google-Smtp-Source: APXvYqyY8nYd03eHG9X2xYDGSW0so0hztg5PJhY8JZAT0v52ZdXRojd+rBlh8GPnvwD50u7QDWhTz8klRBrL218WtyQ=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr8207862otn.297.1562932458374;
 Fri, 12 Jul 2019 04:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190703075502.79782-1-yuchao0@huawei.com> <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com> <20190711122831.3970-1-agruenba@redhat.com>
 <cb41acf2-f222-102a-d31b-02243c77996c@huawei.com>
In-Reply-To: <cb41acf2-f222-102a-d31b-02243c77996c@huawei.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 12 Jul 2019 13:54:07 +0200
Message-ID: <CAHc6FU5tBXeJ6xzZzfCQeaQFy-NZ5ryZ+QMGLu7yxcGXwYisNw@mail.gmail.com>
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing case
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>, chao@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 Jul 2019 at 11:31, Chao Yu <yuchao0@huawei.com> wrote:
> On 2019/7/11 20:28, Andreas Gruenbacher wrote:
> > Something along the lines of the attached, broken patch might work in
> > the end.
> >
> > Andreas
> >
> > ---
> >  fs/buffer.c           | 10 ++++--
> >  fs/iomap.c            | 74 +++++++++++++++++++++++++++++--------------
> >  include/linux/iomap.h |  3 ++
> >  3 files changed, 61 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index e450c55f6434..8d8668e377ab 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -1873,8 +1873,8 @@ void page_zero_new_buffers(struct page *page, unsigned from, unsigned to)
> >  EXPORT_SYMBOL(page_zero_new_buffers);
> >
> >  static void
> > -iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
> > -             struct iomap *iomap)
> > +iomap_to_bh(struct inode *inode, struct page *page, sector_t block,
> > +             struct buffer_head *bh, struct iomap *iomap)
> >  {
> >       loff_t offset = block << inode->i_blkbits;
> >
> > @@ -1924,6 +1924,10 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
> >                               inode->i_blkbits;
> >               set_buffer_mapped(bh);
> >               break;
> > +     case IOMAP_INLINE:
> > +             __iomap_read_inline_data(inode, page, iomap);
> > +             set_buffer_uptodate(bh);
> > +             break;
> >       }
> >  }
> >
> > @@ -1969,7 +1973,7 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
> >                               if (err)
> >                                       break;
> >                       } else {
> > -                             iomap_to_bh(inode, block, bh, iomap);
> > +                             iomap_to_bh(inode, page, block, bh, iomap);
> >                       }
> >
> >                       if (buffer_new(bh)) {
> > diff --git a/fs/iomap.c b/fs/iomap.c
> > index 45aa58e837b5..61188e95def2 100644
> > --- a/fs/iomap.c
> > +++ b/fs/iomap.c
> > @@ -260,24 +260,47 @@ struct iomap_readpage_ctx {
> >       struct list_head        *pages;
> >  };
> >
> > -static void
> > -iomap_read_inline_data(struct inode *inode, struct page *page,
> > +#define offset_in_block(offset, inode) \
> > +     ((unsigned long)(offset) & (i_blocksize(inode) - 1))
> > +
> > +static bool
> > +inline_data_within_block(struct inode *inode, struct iomap *iomap,
> > +             unsigned int size)
> > +{
> > +     unsigned int off = offset_in_block(iomap->inline_data, inode);
> > +
> > +     return size <= i_blocksize(inode) - off;
> > +}
> > +
> > +void
> > +__iomap_read_inline_data(struct inode *inode, struct page *page,
> >               struct iomap *iomap)
> >  {
> > -     size_t size = i_size_read(inode);
> > +     size_t size = offset_in_block(i_size_read(inode), inode);
> > +     unsigned int poff = offset_in_page(iomap->offset);
> > +     unsigned int bsize = i_blocksize(inode);
> >       void *addr;
> >
> >       if (PageUptodate(page))
> >               return;
> >
> > -     BUG_ON(page->index);
> > -     BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     BUG_ON(!inline_data_within_block(inode, iomap, size));
> >
> >       addr = kmap_atomic(page);
> > -     memcpy(addr, iomap->inline_data, size);
> > -     memset(addr + size, 0, PAGE_SIZE - size);
> > +     memcpy(addr + poff, iomap->inline_data, size);
> > +     memset(addr + poff + size, 0, bsize - size);
> >       kunmap_atomic(addr);
> > -     SetPageUptodate(page);
> > +}
> > +
> > +static void
> > +iomap_read_inline_data(struct inode *inode, struct page *page,
> > +             struct iomap *iomap)
> > +{
> > +     unsigned int poff = offset_in_page(iomap->offset);
> > +     unsigned int bsize = i_blocksize(inode);
> > +
> > +     __iomap_read_inline_data(inode, page, iomap);
> > +     iomap_set_range_uptodate(page, poff, bsize);
> >  }
> >
> >  static loff_t
> > @@ -292,11 +315,8 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >       unsigned poff, plen;
> >       sector_t sector;
> >
> > -     if (iomap->type == IOMAP_INLINE) {
> > -             WARN_ON_ONCE(pos);
> > +     if (iomap->type == IOMAP_INLINE)
> >               iomap_read_inline_data(inode, page, iomap);
> > -             return PAGE_SIZE;
>
> Hi Andreas,
>
> Thanks for your patch.
>
> In my erofs test case, filled inline data will be zeroed out due to we fallback
> to following flow:
>
>         if (iomap->type != IOMAP_MAPPED || pos >= i_size_read(inode)) {
>                 zero_user(page, poff, plen);
>
> Should we return before this condition check?

Yes, probably by returning i_blocksize(inode) after
iomap_read_inline_data, but that alone isn't enough to make the patch
work completely. This really needs a review from Christoph and careful
testing of all the code paths.

Andreas

> Thanks,
>
> > -     }
> >
> >       /* zero post-eof blocks as the page may be mapped */
> >       iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> > @@ -637,6 +657,11 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
> >       if (PageUptodate(page))
> >               return 0;
> >
> > +     if (iomap->type == IOMAP_INLINE) {
> > +             iomap_read_inline_data(inode, page, iomap);
> > +             return 0;
> > +     }
> > +
> >       do {
> >               iomap_adjust_read_range(inode, iop, &block_start,
> >                               block_end - block_start, &poff, &plen);
> > @@ -682,9 +707,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> >               goto out_no_page;
> >       }
> >
> > -     if (iomap->type == IOMAP_INLINE)
> > -             iomap_read_inline_data(inode, page, iomap);
> > -     else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> > +     if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> >               status = __block_write_begin_int(page, pos, len, NULL, iomap);
> >       else
> >               status = __iomap_write_begin(inode, pos, len, page, iomap);
> > @@ -761,11 +784,11 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
> >  {
> >       void *addr;
> >
> > -     WARN_ON_ONCE(!PageUptodate(page));
> > -     BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     BUG_ON(!inline_data_within_block(inode, iomap, pos + copied));
> >
> >       addr = kmap_atomic(page);
> > -     memcpy(iomap->inline_data + pos, addr + pos, copied);
> > +     memcpy(iomap->inline_data + offset_in_block(pos, inode),
> > +            addr + offset_in_page(pos), copied);
> >       kunmap_atomic(addr);
> >
> >       mark_inode_dirty(inode);
> > @@ -1064,7 +1087,7 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
> >               const struct iomap_ops *ops)
> >  {
> >       unsigned int blocksize = i_blocksize(inode);
> > -     unsigned int off = pos & (blocksize - 1);
> > +     unsigned int off = offset_in_block(pos, inode);
> >
> >       /* Block boundary? Nothing to do */
> >       if (!off)
> > @@ -1772,21 +1795,26 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> >       struct iov_iter *iter = dio->submit.iter;
> >       size_t copied;
> >
> > -     BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +     BUG_ON(!inline_data_within_block(inode, iomap, pos + length));
> >
> >       if (dio->flags & IOMAP_DIO_WRITE) {
> >               loff_t size = inode->i_size;
> >
> >               if (pos > size)
> > -                     memset(iomap->inline_data + size, 0, pos - size);
> > -             copied = copy_from_iter(iomap->inline_data + pos, length, iter);
> > +                     memset(iomap->inline_data +
> > +                            offset_in_block(size, inode), 0, pos - size);
> > +             copied = copy_from_iter(iomap->inline_data +
> > +                                     offset_in_block(pos, inode),
> > +                                     length, iter);
> >               if (copied) {
> >                       if (pos + copied > size)
> >                               i_size_write(inode, pos + copied);
> >                       mark_inode_dirty(inode);
> >               }
> >       } else {
> > -             copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> > +             copied = copy_to_iter(iomap->inline_data +
> > +                                   offset_in_block(pos, inode),
> > +                                   length, iter);
> >       }
> >       dio->size += copied;
> >       return copied;
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 2103b94cb1bf..a8a60dd2fdc0 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -131,6 +131,9 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
> >       return NULL;
> >  }
> >
> > +void __iomap_read_inline_data(struct inode *inode, struct page *page,
> > +             struct iomap *iomap);
> > +
> >  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
> >               const struct iomap_ops *ops);
> >  int iomap_readpage(struct page *page, const struct iomap_ops *ops);
> >
