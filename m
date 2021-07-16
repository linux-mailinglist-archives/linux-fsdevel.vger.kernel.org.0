Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA73CB945
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 17:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbhGPPGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 11:06:05 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44633 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240573AbhGPPGD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:06:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Ufzr3Mb_1626447785;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Ufzr3Mb_1626447785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 23:03:06 +0800
Date:   Fri, 16 Jul 2021 23:03:04 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chao Yu <chao@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [PATCH 1/2] iomap: support tail packing inline read
Message-ID: <YPGfqLcSiH3/z2RT@B-P7TQMD6M-0146.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chao Yu <chao@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
 <20210716050724.225041-2-hsiangkao@linux.alibaba.com>
 <YPGDZYT9OxdgNYf2@casper.infradead.org>
 <YPGQB3zT4Wp4Q38X@B-P7TQMD6M-0146.local>
 <YPGbNCdCNXIpNdqd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPGbNCdCNXIpNdqd@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 03:44:04PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 16, 2021 at 09:56:23PM +0800, Gao Xiang wrote:
> > Hi Matthew,
> > 
> > On Fri, Jul 16, 2021 at 02:02:29PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jul 16, 2021 at 01:07:23PM +0800, Gao Xiang wrote:
> > > > This tries to add tail packing inline read to iomap. Different from
> > > > the previous approach, it only marks the block range uptodate in the
> > > > page it covers.
> > > 
> > > Why?  This path is called under two circumstances: readahead and readpage.
> > > In both cases, we're trying to bring the entire page uptodate.  The inline
> > > extent is always the tail of the file, so we may as well zero the part of
> > > the page past the end of file and mark the entire page uptodate instead
> > > and leaving the end of the page !uptodate.
> > > 
> > > I see the case where, eg, we have the first 2048 bytes of the file
> > > out-of-inode and then 20 bytes in the inode.  So we'll create the iop
> > > for the head of the file, but then we may as well finish the entire
> > > PAGE_SIZE chunk as part of this iteration rather than update 2048-3071
> > > as being uptodate and leave the 3072-4095 block for a future iteration.
> > 
> > Thanks for your comments. Hmm... If I understand the words above correctly,
> > what I'd like to do is to cover the inline extents (blocks) only
> > reported by iomap_begin() rather than handling other (maybe)
> > logical-not-strictly-relevant areas such as post-EOF (even pages
> > will be finally entirely uptodated), I think such zeroed area should
> > be handled by from the point of view of the extent itself
> > 
> >          if (iomap_block_needs_zeroing(inode, iomap, pos)) {
> >                  zero_user(page, poff, plen);
> >                  iomap_set_range_uptodate(page, poff, plen);
> >                  goto done;
> >          }
> 
> That does work.  But we already mapped the page to write to it, and
> we already have to zero to the end of the block.  Why not zero to
> the end of the page?  It saves an iteration around the loop, it saves
> a mapping of the page, and it saves a call to flush_dcache_page().

I completely understand your concern, and that's also (sort of) why I
left iomap_read_inline_page() to make the old !pos behavior as before.

Anyway, I could update Christoph's patch to behave like what you
suggested. Will do later since I'm now taking some rest...

> 
> > The benefits I can think out are 1) it makes the logic understand
> > easier and no special cases just for tail-packing handling 2) it can
> > be then used for any inline extent cases (I mean e.g. in the middle of
> > the file) rather than just tail-packing inline blocks although currently
> > there is a BUG_ON to prevent this but it's easier to extend even further.
> > 3) it can be used as a part for later partial page uptodate logic in
> > order to match the legacy buffer_head logic (I remember something if my
> > memory is not broken about this...)
> 
> Hopefully the legacy buffer_head logic will go away soon.

Hmmm.. I partially agree on this (I agree buffer_head is a legacy stuff
but...), considering some big PAGE_SIZE like 64kb or bigger, partial
uptodate can save I/O for random file read pattern in general (not mmap
read, yes, also considering readahead, but I received some regression
due to I/O amplification like this when I was at the previous * 2 company).

Thanks,
Gao Xiang

