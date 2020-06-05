Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509971EEFBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFEDIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 23:08:09 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:46107 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgFEDIJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:08:09 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 0B30BD588CC;
        Fri,  5 Jun 2020 13:08:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jh2i6-0002cj-5n; Fri, 05 Jun 2020 13:07:58 +1000
Date:   Fri, 5 Jun 2020 13:07:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200605030758.GB2040@dread.disaster.area>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
 <20200604233053.GW2040@dread.disaster.area>
 <20200604235050.GX19604@bombadil.infradead.org>
 <20200605003159.GX2040@dread.disaster.area>
 <20200605022451.GZ19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605022451.GZ19604@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=ruQhQeNdVRnZAG6APzsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:24:51PM -0700, Matthew Wilcox wrote:
> On Fri, Jun 05, 2020 at 10:31:59AM +1000, Dave Chinner wrote:
> > On Thu, Jun 04, 2020 at 04:50:50PM -0700, Matthew Wilcox wrote:
> > > > Sure, but that's not really what I was asking: why isn't this
> > > > !uptodate state caught before the page fault code calls
> > > > ->page_mkwrite? The page fault code has a reference to the page,
> > > > after all, and in a couple of paths it even has the page locked.
> > > 
> > > If there's already a PTE present, then the page fault code doesn't
> > > check the uptodate bit.  Here's the path I'm looking at:
> > > 
> > > do_wp_page()
> > >  -> vm_normal_page()
> > >  -> wp_page_shared()
> > >      -> do_page_mkwrite()
> > > 
> > > I don't see anything in there that checked Uptodate.
> > 
> > Yup, exactly the code I was looking at when I asked this question.
> > The kernel has invalidated the contents of a page, yet we still have
> > it mapped into userspace as containing valid contents, and we don't
> > check it at all when userspace generates a protection fault on the
> > page?
> 
> Right.  The iomap error path only clears PageUptodate.  It doesn't go
> to the effort of unmapping the page from userspace, so userspace has a
> read-only view of a !Uptodate page.

Hmmm - did you miss the ->discard_page() callout just before we call
ClearPageUptodate() on error in iomap_writepage_map()? That results
in XFS calling iomap_invalidatepage() on the page, which ....

/me sighs as he realises that ->invalidatepage doesn't actually
invalidate page mappings but only clears the page dirty state and
releases filesystem references to the page.

Yay. We leave -invalidated page cache pages- mapped into userspace,
and page faults on those pages don't catch access to invalidated
pages.

Geez, we really suck at this whole software thing, don't we?

It's not clear to me that we can actually unmap those pages safely
in a race free manner from this code - can we actually do that from
the page writeback path?

> > > I think the iomap code is the only filesystem which clears PageUptodate
> > > on errors. 
> > 
> > I don't think you looked very hard. A quick scan shows at least
> > btrfs, f2fs, hostfs, jffs2, reiserfs, vboxfs and anything using the
> > iomap path will call ClearPageUptodate() on a write IO error.
> 
> I'll give you btrfs and jffs2, but I don't think it's true for f2fs.
> The only other filesystem using the iomap bufferd IO paths today
> is zonefs, afaik.

gfs2 as well.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
