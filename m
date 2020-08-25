Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9C25237B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 00:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHYWVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 18:21:13 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45965 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgHYWVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:21:10 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 46746823043;
        Wed, 26 Aug 2020 08:21:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kAhJS-0000Td-G5; Wed, 26 Aug 2020 08:21:06 +1000
Date:   Wed, 26 Aug 2020 08:21:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] fs: Introduce i_blocks_per_page
Message-ID: <20200825222106.GP12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-3-willy@infradead.org>
 <20200825204922.GG6096@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825204922.GG6096@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=Qo8iioWGcHrh27a4tzsA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:49:22PM -0700, Darrick J. Wong wrote:
> On Mon, Aug 24, 2020 at 03:55:03PM +0100, Matthew Wilcox (Oracle) wrote:
> > This helper is useful for both THPs and for supporting block size larger
> > than page size.  Convert all users that I could find (we have a few
> > different ways of writing this idiom, and I may have missed some).
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> /me wonders what will happen when someone tries to make blocksz >
> pagesize work,

I abstract the page/block size stuff into "chunks". i.e. we work on
the smallest contiguous chunk of data the current combination of
page and inode define. In the context of this patch, it is simply
just:

s/i_blocks_per_page/iomap_chunks_per_page/g

i.e. The helper functions end up looking like this:

static inline unsigned
iomap_chunk_size(struct inode *inode, struct page *page)
{
       return min_t(unsigned, page_size(page), i_blocksize(inode));
}

static inline unsigned
iomap_chunk_bits(struct inode *inode, struct page *page)
{
       return min_t(unsigned, page_shift(page), inode->i_blkbits);
}

static inline unsigned
iomap_chunks_per_page(struct inode *inode, struct page *page)
{
       return page_size(page) >> inode->i_blkbits;
}

and the latter is actually the same as what i_block_per_page() is
currently implemented as....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
