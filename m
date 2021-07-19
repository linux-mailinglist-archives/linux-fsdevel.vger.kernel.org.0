Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421BC3CD5B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhGSMun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 08:50:43 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:58608 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237861AbhGSMum (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:50:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UgGlGc3_1626701476;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UgGlGc3_1626701476)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Jul 2021 21:31:17 +0800
Date:   Mon, 19 Jul 2021 21:31:15 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gr??nbacher <andreas.gruenbacher@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPV+o+V7wU32j6m3@B-P7TQMD6M-0146.local>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        Andreas Gr??nbacher <andreas.gruenbacher@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
 <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
 <CAHpGcMJzEiJUbD=7ZOdH7NF+gq9MuEi8=ym34ay7QAm5_91s7g@mail.gmail.com>
 <YPLdSja/4FBsjss/@B-P7TQMD6M-0146.local>
 <YPVe41YqpfGLNsBS@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPVe41YqpfGLNsBS@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:15:47PM +0100, Christoph Hellwig wrote:
> On Sat, Jul 17, 2021 at 09:38:18PM +0800, Gao Xiang wrote:
> > >From 62f367245492e389711bcebbf7da5adae586299f Mon Sep 17 00:00:00 2001
> > From: Christoph Hellwig <hch@lst.de>
> > Date: Fri, 16 Jul 2021 10:52:48 +0200
> > Subject: [PATCH] iomap: support tail packing inline read
> 
> I'd still credit this to you as you did all the hard work.

Ok.

> 
> > +	/* inline source data must be inside a single page */
> > +	BUG_ON(iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data));
> > +	/* handle tail-packing blocks cross the current page into the next */
> > +	if (size > PAGE_SIZE - poff)
> > +		size = PAGE_SIZE - poff;
> 
> This should probably use min or min_t.

Okay, will update.

> 
> >  
> >  	addr = kmap_atomic(page);
> > -	memcpy(addr, iomap->inline_data, size);
> > -	memset(addr + size, 0, PAGE_SIZE - size);
> > +	memcpy(addr + poff, iomap->inline_data - iomap->offset + pos, size);
> > +	memset(addr + poff + size, 0, PAGE_SIZE - poff - size);
> >  	kunmap_atomic(addr);
> > -	SetPageUptodate(page);
> > +	flush_dcache_page(page);
> 
> The flush_dcache_page addition should be a separate patch.

I wondered what is the target order of recent iomap patches, since this is
a quite small change, so I'd like to just rebase on for-next for now . So
ok, I won't touch this in this patchset and I think flush_dcache_page() does
no harm to x86(_64) and arm(64) at least if I remember correctly.

> 
> >  
> >  	if (dio->flags & IOMAP_DIO_WRITE) {
> >  		loff_t size = inode->i_size;
> > @@ -394,7 +395,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
> >  			mark_inode_dirty(inode);
> >  		}
> >  	} else {
> > -		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
> > +		copied = copy_to_iter(iomap->inline_data + pos - iomap->offset,
> > +				length, iter);
> 
> We also need to take the offset into account for the write side.
> I guess it would be nice to have a local variable for the inline
> address to not duplicate that calculation multiple times.

ok. Will update.

Thanks,
Gao Xiang

