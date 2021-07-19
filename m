Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B473CDC41
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbhGSOvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 10:51:51 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42188 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344265AbhGSOso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:48:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgI5qI7_1626708560;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgI5qI7_1626708560)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Jul 2021 23:29:22 +0800
Date:   Mon, 19 Jul 2021 23:29:20 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v3] iomap: support tail packing inline read
Message-ID: <YPWaUNeV1K13vpGF@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
References: <20210719144747.189634-1-hsiangkao@linux.alibaba.com>
 <YPWUBhxhoaEp8Frn@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPWUBhxhoaEp8Frn@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 04:02:30PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 19, 2021 at 10:47:47PM +0800, Gao Xiang wrote:
> > @@ -246,18 +245,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> >  	unsigned poff, plen;
> >  	sector_t sector;
> >  
> > -	if (iomap->type == IOMAP_INLINE) {
> > -		WARN_ON_ONCE(pos);
> > -		iomap_read_inline_data(inode, page, iomap);
> > -		return PAGE_SIZE;
> > -	}
> > -
> > -	/* zero post-eof blocks as the page may be mapped */
> >  	iop = iomap_page_create(inode, page);
> > +	/* needs to skip some leading uptodated blocks */
> >  	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
> >  	if (plen == 0)
> >  		goto done;
> >  
> > +	if (iomap->type == IOMAP_INLINE) {
> > +		iomap_read_inline_data(inode, page, iomap, pos);
> > +		plen = PAGE_SIZE - poff;
> > +		goto done;
> > +	}
> 
> This is going to break Andreas' case that he just patched to work.
> GFS2 needs for there to _not_ be an iop for inline data.  That's
> why I said we need to sort out when to create an iop before moving
> the IOMAP_INLINE case below the creation of the iop.

I have no idea how it breaks Andreas' case from the previous commit
message: "
iomap: Don't create iomap_page objects for inline files
In iomap_readpage_actor, don't create iop objects for inline inodes.
Otherwise, iomap_read_inline_data will set PageUptodate without setting
iop->uptodate, and iomap_page_release will eventually complain.

To prevent this kind of bug from occurring in the future, make sure the
page doesn't have private data attached in iomap_read_inline_data.
"

After this patch, iomap_read_inline_data() will set iop->uptodate with
iomap_set_range_uptodate() rather than set PageUptodate() directly, 
so iomap_page_release won't complain.

Am I missing something?

Thanks,
Gao Xiang

> 
> If we're not going to do that first, then I recommend leaving the
> IOMAP_INLINE case where it is and changing it to ...
> 
> 	if (iomap->type == IOMAP_INLINE)
> 		return iomap_read_inline_data(inode, page, iomap, pos);
> 
> ... and have iomap_read_inline_data() return the number of bytes that
> it copied + zeroed (ie PAGE_SIZE - poff).
