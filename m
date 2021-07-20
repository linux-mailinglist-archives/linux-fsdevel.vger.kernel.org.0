Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610FA3CF987
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhGTLnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 07:43:47 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43779 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237691AbhGTLnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:43:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgQyUIj_1626783838;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgQyUIj_1626783838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 20:23:59 +0800
Date:   Tue, 20 Jul 2021 20:23:57 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <YPbAXVois1QpOu7X@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <CAHpGcM+qhur4C2fLyR-dQx7CvumXVvMAM5NBCCXnL5ve-2qE8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcM+qhur4C2fLyR-dQx7CvumXVvMAM5NBCCXnL5ve-2qE8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 01:34:58PM +0200, Andreas Grünbacher wrote:
> Am Mo., 19. Juli 2021 um 16:48 Uhr schrieb Gao Xiang
> <hsiangkao@linux.alibaba.com>:
> > This tries to add tail packing inline read to iomap, which can support
> > several inline tail blocks. Similar to the previous approach, it cleans
> > post-EOF in one iteration.
> >
> > The write path remains untouched since EROFS cannot be used for testing.
> > It'd be better to be implemented if upcoming real users care rather than
> > leave untested dead code around.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Darrick J. Wong <djwong@kernel.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > v2: https://lore.kernel.org/r/YPLdSja%2F4FBsjss%2F@B-P7TQMD6M-0146.local/
> > changes since v2:
> >  - update suggestion from Christoph:
> >     https://lore.kernel.org/r/YPVe41YqpfGLNsBS@infradead.org/
> >
> > Hi Andreas,
> > would you mind test on the gfs2 side? Thanks in advance!
> >
> > Thanks,
> > Gao Xiang
> >
> >  fs/iomap/buffered-io.c | 50 ++++++++++++++++++++++++++----------------
> >  fs/iomap/direct-io.c   | 11 ++++++----
> >  2 files changed, 38 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 87ccb3438bec..cac8a88660d8 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -207,23 +207,22 @@ struct iomap_readpage_ctx {
> >
> >  static void
> >  iomap_read_inline_data(struct inode *inode, struct page *page,
> > -               struct iomap *iomap)
> > +               struct iomap *iomap, loff_t pos)
> >  {
> > -       size_t size = i_size_read(inode);
> > +       unsigned int size, poff = offset_in_page(pos);
> >         void *addr;
> >
> > -       if (PageUptodate(page))
> > -               return;
> > -
> > -       BUG_ON(page_has_private(page));
> > -       BUG_ON(page->index);
> > -       BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +       /* inline source data must be inside a single page */
> > +       BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +       /* handle tail-packing blocks cross the current page into the next */
> > +       size = min_t(unsigned int, iomap->length + pos - iomap->offset,
> > +                    PAGE_SIZE - poff);
> >
> >         addr = kmap_atomic(page);
> > -       memcpy(addr, iomap->inline_data, size);
> > -       memset(addr + size, 0, PAGE_SIZE - size);
> > +       memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > +       memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> >         kunmap_atomic(addr);
> > -       SetPageUptodate(page);
> > +       iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> >  }
> >
> >  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >         unsigned poff, plen;
> >         sector_t sector;
> >
> > -       if (iomap->type == IOMAP_INLINE) {
> > -               WARN_ON_ONCE(pos);
> > -               iomap_read_inline_data(inode, page, iomap);
> > -               return PAGE_SIZE;
> > -       }
> > -
> > -       /* zero post-eof blocks as the page may be mapped */
> >         iop = iomap_page_create(inode, page);
> 
> We can skip creating the iop when reading the entire page.

As I said before, I think it can be in a separated patch like
https://lore.kernel.org/r/YPMkKfegS+9KzEhK@casper.infradead.org/
and Christoph said it should be careful:
https://lore.kernel.org/r/YPVfxn6%2FoCPBZpKu@infradead.org/

Thanks,
Gao Xiang
