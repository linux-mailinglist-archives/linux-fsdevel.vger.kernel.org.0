Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4E21EF84D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 14:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFEMsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 08:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgFEMsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:48:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829EC08C5C2;
        Fri,  5 Jun 2020 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+W0k3BgZajHHBqJN7IRx+U2nGAZwZKKC8BfjUAFcIMA=; b=kG53gJfK5kWHtokiyBxfJbTb7v
        v5xJMhAwcLxLaxyos1C08nBeenVsOEyKQ6HM1vCbCxSd8fQswpm59H0WHRf9V+tgqDYFM+dhemQU1
        sNWSPO90/4ev/NU8qpRPUz7bisgIm22+Ofsnl6dEu2n7WHaYIfTBQblXb6tP9G5PY2FSonicbr+jP
        cWrOh2VOgwaxkr7Pr6hfiXMKzyVWJWRTGZBsmWLqE07afy0vc4lUT91n1ML+adFJAKzRjOKTvZSpI
        6vtM0o/tzVO9JU5IZFClD1STvj85a9/5aB60JqrEurQmzZL202ZxCgPrTU5DExyKe8Hv/TNCx9N5H
        3a+9Uv9w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhBlq-00058s-76; Fri, 05 Jun 2020 12:48:26 +0000
Date:   Fri, 5 Jun 2020 05:48:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200605124826.GF19604@bombadil.infradead.org>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
 <20200604233053.GW2040@dread.disaster.area>
 <20200604235050.GX19604@bombadil.infradead.org>
 <20200605003159.GX2040@dread.disaster.area>
 <20200605022451.GZ19604@bombadil.infradead.org>
 <20200605030758.GB2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605030758.GB2040@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 01:07:58PM +1000, Dave Chinner wrote:
> On Thu, Jun 04, 2020 at 07:24:51PM -0700, Matthew Wilcox wrote:
> > On Fri, Jun 05, 2020 at 10:31:59AM +1000, Dave Chinner wrote:
> > > On Thu, Jun 04, 2020 at 04:50:50PM -0700, Matthew Wilcox wrote:
> > > > > Sure, but that's not really what I was asking: why isn't this
> > > > > !uptodate state caught before the page fault code calls
> > > > > ->page_mkwrite? The page fault code has a reference to the page,
> > > > > after all, and in a couple of paths it even has the page locked.
> > > > 
> > > > If there's already a PTE present, then the page fault code doesn't
> > > > check the uptodate bit.  Here's the path I'm looking at:
> > > > 
> > > > do_wp_page()
> > > >  -> vm_normal_page()
> > > >  -> wp_page_shared()
> > > >      -> do_page_mkwrite()
> > > > 
> > > > I don't see anything in there that checked Uptodate.
> > > 
> > > Yup, exactly the code I was looking at when I asked this question.
> > > The kernel has invalidated the contents of a page, yet we still have
> > > it mapped into userspace as containing valid contents, and we don't
> > > check it at all when userspace generates a protection fault on the
> > > page?
> > 
> > Right.  The iomap error path only clears PageUptodate.  It doesn't go
> > to the effort of unmapping the page from userspace, so userspace has a
> > read-only view of a !Uptodate page.
> 
> Hmmm - did you miss the ->discard_page() callout just before we call
> ClearPageUptodate() on error in iomap_writepage_map()? That results
> in XFS calling iomap_invalidatepage() on the page, which ....

... I don't think that's the interesting path.  I mean, that's
the submission path, and usually we discover errors in the completion
path, not the submission path.

> /me sighs as he realises that ->invalidatepage doesn't actually
> invalidate page mappings but only clears the page dirty state and
> releases filesystem references to the page.
> 
> Yay. We leave -invalidated page cache pages- mapped into userspace,
> and page faults on those pages don't catch access to invalidated
> pages.

More than that ... by clearing Uptodate, you're trying to prevent
future reads to this page from succeeding without verifying the data
is still on storage, but a task that had it mapped before can still
load the data that was written but never made it to storage.
So at some point it'll teleport backwards when another task has a
successful read().  Funfunfun.

> Geez, we really suck at this whole software thing, don't we?

Certainly at handling errors ...

> It's not clear to me that we can actually unmap those pages safely
> in a race free manner from this code - can we actually do that from
> the page writeback path?

I don't see why it can't be done from the submission path.
unmap_mapping_range() calls i_mmap_lock_write(), which is
down_write(i_mmap_rwsem) in drag.  There might be a lock ordering
issue there, although lockdep should find it pretty quickly.

The bigger problem is the completion path.  We're in softirq context,
so that will have to punt to a thread that can take mutexes.
