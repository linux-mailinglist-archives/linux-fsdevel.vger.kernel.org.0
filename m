Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B983CE67C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242647AbhGSQHB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 12:07:01 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42244 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347041AbhGSQFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 12:05:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgJZ4D3_1626713130;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgJZ4D3_1626713130)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 00:45:32 +0800
Date:   Tue, 20 Jul 2021 00:45:30 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <YPWsKi33ZOS2rhCy@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <YPWUBhxhoaEp8Frn@casper.infradead.org>
 <20210719151310.GA22355@lst.de>
 <YPWkRRzy5reIMu8u@B-P7TQMD6M-0146.local>
 <YPWozhzNIljcC83R@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPWozhzNIljcC83R@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 05:31:10PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 20, 2021 at 12:11:49AM +0800, Gao Xiang wrote:
> > On Mon, Jul 19, 2021 at 05:13:10PM +0200, Christoph Hellwig wrote:
> > > On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> > > > > +	if (iomap->type == IOMAP_INLINE) {
> > > > > +		iomap_read_inline_data(inode, page, iomap, pos);
> > > > > +		plen = PAGE_SIZE - poff;
> > > > > +		goto done;
> > > > > +	}
> > > > 
> > > > This is going to break Andreas' case that he just patched to work.
> > > > GFS2 needs for there to _not_ be an iop for inline data.  That's
> > > > why I said we need to sort out when to create an iop before moving
> > > > the IOMAP_INLINE case below the creation of the iop.
> > > > 
> > > > If we're not going to do that first, then I recommend leaving the
> > > > IOMAP_INLINE case where it is and changing it to ...
> > > > 
> > > > 	if (iomap->type == IOMAP_INLINE)
> > > > 		return iomap_read_inline_data(inode, page, iomap, pos);
> > > > 
> > > > ... and have iomap_read_inline_data() return the number of bytes that
> > > > it copied + zeroed (ie PAGE_SIZE - poff).
> > > 
> > > Returning the bytes is much cleaner anyway.  But we still need to deal
> > > with the sub-page uptodate status in one form or another.
> > 
> > There is another iomap_read_inline_data() caller as in:
> > +static int iomap_write_begin_inline(struct inode *inode, loff_t pos,
> > +		struct page *page, struct iomap *srcmap)
> > +{
> > +	/* needs more work for the tailpacking case, disable for now */
> > +	if (WARN_ON_ONCE(pos != 0))
> > +		return -EIO;
> > +	if (PageUptodate(page))
> > +		return 0;
> > +	iomap_read_inline_data(inode, page, srcmap, pos);
> > +	return 0;
> > +}
> > 
> > I'd like to avoid it as (void)iomap_read_inline_data(...). That's why it
> > left as void return type.
> 
> You don't need to cast away the return value in C.

Well, I don't check the current behavior of this, but see:
http://c-faq.com/style/voidcasts.html

Anyway, that's minor and easy to update if really needed.
I'd like to check if it works first...

Thanks,
Gao Xiang

