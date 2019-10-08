Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA9CF16D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 05:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfJHDyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 23:54:04 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44235 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729772AbfJHDyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 23:54:03 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E622F363F0F;
        Tue,  8 Oct 2019 14:53:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iHgZS-0003vt-H7; Tue, 08 Oct 2019 14:53:58 +1100
Date:   Tue, 8 Oct 2019 14:53:58 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] fs: Introduce i_blocks_per_page
Message-ID: <20191008035358.GW804@dread.disaster.area>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-3-willy@infradead.org>
 <20190925083650.GE804@dread.disaster.area>
 <20191004192812.GK32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004192812.GK32665@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=7-415B0cAAAA:8 a=Ezv6lXj58yBfwjVs_tMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 04, 2019 at 12:28:12PM -0700, Matthew Wilcox wrote:
> On Wed, Sep 25, 2019 at 06:36:50PM +1000, Dave Chinner wrote:
> > I'm actually working on abstrcting this code from both block size
> > and page size via the helpers below. We ahve need to support block
> > size > page size, and so that requires touching a bunch of all the
> > same code as this patchset. I'm currently trying to combine your
> > last patch set with my patchset so I can easily test allocating 64k
> > page cache pages on a 64k block size filesystem on a 4k page size
> > machine with XFS....
> 
> This all makes sense ...
> 
> > > -	if (iop || i_blocksize(inode) == PAGE_SIZE)
> > > +	if (iop || i_blocks_per_page(inode, page) <= 1)
> > >  		return iop;
> > 
> > That also means checks like these become:
> > 
> > 	if (iop || iomap_chunks_per_page(inode, page) <= 1)
> > 
> > as a single file can now have multiple pages per block, a page per
> > block and multiple blocks per page as the page size changes...
> > 
> > I'd like to only have to make one pass over this code to abstract
> > out page and block sizes, so I'm guessing we'll need to do some
> > co-ordination here....
> 
> Yup.  I'm happy if you want to send your patches out; I'll keep going
> with the patches I have for the moment, and we'll figure out how to
> merge the two series in a way that makes sense.

I'm waiting for the xfs -> iomap writeback changes to land in a
stable branch so I don't have to do things twice in slightly
different ways in the patchset. Once we get that in an iomap-next
branch I'll rebase my patches on top of it and go from there...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
