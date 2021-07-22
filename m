Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D63D1B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 02:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhGVAQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 20:16:47 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55460 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhGVAQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 20:16:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgZDZy5_1626915438;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgZDZy5_1626915438)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Jul 2021 08:57:20 +0800
Date:   Thu, 22 Jul 2021 08:57:18 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v5] iomap: support tail packing inline read
Message-ID: <YPjCbmgYdMji4WMH@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <20210721082323.41933-1-hsiangkao@linux.alibaba.com>
 <20210721222404.GA8639@magnolia>
 <YPi3/okpVH7Q1O2X@B-P7TQMD6M-0146.local>
 <20210722001911.GD8572@magnolia>
 <YPi7MKYjMzjJjFB0@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPi7MKYjMzjJjFB0@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 08:26:24AM +0800, Gao Xiang wrote:
> On Wed, Jul 21, 2021 at 05:19:11PM -0700, Darrick J. Wong wrote:
> > On Thu, Jul 22, 2021 at 08:12:46AM +0800, Gao Xiang wrote:

...

> > > > 
> > > > >  	addr = kmap_atomic(page);
> > > > > -	memcpy(addr, iomap->inline_data, size);
> > > > > -	memset(addr + size, 0, PAGE_SIZE - size);
> > > > > +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > > > 
> > > > I keep seeing this (iomap->inline_data + pos - iomap->offset)
> > > > construction in this patch, maybe it should be a helper?
> > > 
> > > I'm fine with this, (but I'm not good at naming), may I ask for
> > > some suggested naming? e.g.
> > > 
> > > static inline void *iomap_adjusted_inline_data(iomap, pos)
> > > 
> > > does that look good?
> > 
> > static inline void *
> > iomap_inline_buf(const struct iomap *iomap, loff_t pos)
> > {
> > 	return iomap->inline_data + pos - iomap->offset;
> > }
> > 
> > (gcc complaints about pointer arithmetic on void pointers notwithstanding)

Ok, will update, thanks!

> > 
> > > 
> > > > 
> > > > > +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> > > > >  	kunmap_atomic(addr);
> > > > > -	SetPageUptodate(page);
> > > > > +	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
> > > > > +	return PAGE_SIZE - poff;
> > > > >  }
> > > > >  
> > > > >  static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > > > > @@ -245,19 +247,23 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> > > > >  	loff_t orig_pos = pos;
> > > > >  	unsigned poff, plen;
> > > > >  	sector_t sector;
> > > > > +	int ret;
> > > > >  
> > > > > -	if (iomap->type == IOMAP_INLINE) {
> > > > > -		WARN_ON_ONCE(pos);
> > > > > -		iomap_read_inline_data(inode, page, iomap);
> > > > > -		return PAGE_SIZE;
> > > > > -	}
> > > > > -
> > > > > -	/* zero post-eof blocks as the page may be mapped */
> > > > >  	iop = iomap_page_create(inode, page);
> > > > > +	/* needs to skip some leading uptodate blocks */
> > > > >  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> > > > >  	if (plen == 0)
> > > > >  		goto done;
> > > > >  
> > > > > +	if (iomap->type == IOMAP_INLINE) {
> > > > > +		ret = iomap_read_inline_data(inode, page, iomap, pos);
> > > > > +		if (ret < 0)
> > > > > +			return ret;
> > > > > +		plen = ret;
> > > > > +		goto done;
> > > > > +	}
> > > > > +
> > > > > +	/* zero post-eof blocks as the page may be mapped */
> > > > >  	if (iomap_block_needs_zeroing(inode, iomap, pos)) {
> > > > >  		zero_user(page, poff, plen);
> > > > >  		iomap_set_range_uptodate(page, poff, plen);
> > > > > @@ -589,6 +595,18 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, int flags,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> > > > > +		struct page *page, struct iomap *srcmap)
> > > > > +{
> > > > > +	/* needs more work for the tailpacking case, disable for now */
> > > > > +	if (WARN_ON_ONCE(srcmap->offset != 0))
> > > > > +		return -EIO;
> > > > > +	if (PageUptodate(page))
> > > > > +		return 0;
> > > > > +	iomap_read_inline_data(inode, page, srcmap, 0);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int
> > > > >  iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> > > > >  		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
> > > > > @@ -618,7 +636,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
> > > > >  	}
> > > > >  
> > > > >  	if (srcmap->type == IOMAP_INLINE)
> > > > > -		iomap_read_inline_data(inode, page, srcmap);
> > > > > +		status = iomap_write_begin_inline(inode, pos, page, srcmap);
> > > > >  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> > > > >  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
> > > > >  	else
> > > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > > index 9398b8c31323..cbadb99fb88c 100644
> > > > > --- a/fs/iomap/direct-io.c
> > > > > +++ b/fs/iomap/direct-io.c
> > > > > @@ -379,22 +379,27 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> > > > >  {
> > > > >  	struct iov_iter *iter = dio->submit.iter;
> > > > >  	size_t copied;
> > > > > +	void *dst = iomap->inline_data + pos - iomap->offset;
> > > > >  
> > > > > -	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > > > > +	/* inline data must be inside a single page */
> > > > > +	if (WARN_ON_ONCE(length > PAGE_SIZE -
> > > > > +			 offset_in_page(iomap->inline_data)))
> > > > > +		return -EIO;
> > > > 
> > > > 	/*
> > > > 	 * iomap->inline_data is a kernel-mapped memory page, so we must
> > > > 	 * terminate the write at the end of that page.
> > > > 	 */
> > > > 	if (WARN_ON_ONCE(...))
> > > > 		return -EIO;
> > > 
> > > Ok.
> > > 
> > > > 
> > > > >  	if (dio->flags & IOMAP_DIO_WRITE) {
> > > > 
> > > > I thought we weren't allowing writes to an inline mapping unless
> > > > iomap->offset == 0?  Why is it necessary to change the directio write
> > > > path?  Shouldn't this be:
> > > > 
> > > > 		/* needs more work for the tailpacking case, disable for now */
> > > > 		if (WARN_ON_ONCE(pos > 0))
> > > > 			return -EIO;
> > > 
> > > That is because Andreas once pointed out a case in:
> > > https://lore.kernel.org/r/CAHpGcMJ4T6byxqmO6zZF78wuw01twaEvSW5N6s90qWm0q_jCXQ@mail.gmail.com/
> > > 
> > > "This should be a WARN_ON_ONCE(srcmap->offset != 0). Otherwise, something like:
> > > 
> > >   xfs_io -ft -c 'pwrite 1 2'
> > > 
> > > will fail because pos will be 1."
> > > 
> > > I think that is reasonable to gfs2. So I changed like this.
> > 
> > Ah, right.  I forgot that reads are always done for an entire page at a
> > time, whereas writes are of course byte-aligned.  I still wonder why any
> > changes are needed for directio write?
> 
> Very sorry about that, I misunderstood the hunk, here my original v1
> entirely disabled pos != 0 write direct I/O path like this:
> 
> https://lore.kernel.org/linux-fsdevel/20210716050724.225041-2-hsiangkao@linux.alibaba.com/
> "+	if (WARN_ON_ONCE(pos && (dio->flags & IOMAP_DIO_WRITE)))
> +		return -EIO;"
> 
> Then Christoph pointed out a case why pos != 0 may not be sufficient:
> https://lore.kernel.org/linux-fsdevel/YPFPDS5ktWJEUKTo@infradead.org/
> "I'm pretty sure gfs2 supports direct writes to inline data, so we should
> not disable it. "

Sorry, I was completely buried in the previous comments. I forgot to
mention the last part of this, then Christoph suggested:

https://lore.kernel.org/linux-fsdevel/YPVe41YqpfGLNsBS@infradead.org/

"We also need to take the offset into account for the write side.
 I guess it would be nice to have a local variable for the inline
 address to not duplicate that calculation multiple times."

I think that is reasonable since we allow pos != 0 direct write now,
so that was the whole story.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
