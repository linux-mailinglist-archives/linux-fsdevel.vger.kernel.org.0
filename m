Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60B3216D3F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGGM5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGGM5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:57:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D206C061755;
        Tue,  7 Jul 2020 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NcqHrUmx33Xz3ikGjbmqyDITaJtyyUAxn+yVEQB5egg=; b=ofG/O9FXtmDtbWnntDxYn6vCii
        lBosd0F3EBZqz4nzmI+lv73zKOaBrCqAEbjSOSz6+dBhoy8VomVwvx8q/uvHSGVx0PXhyT7vfB0OR
        M6MiciRdpwivfdM8/gFIBl6ruQNxsAx8AfRS0ljHMcyqBJRoFZ7ipc1D2GEu4CNyYuYDypIIK71PW
        +7DBTJ3Zb6j5S+BeKyh5S1kKto5iZ1PYVHB1YBWRHIM8OyLHzxlVoRSDLpo1vx3U3hbQ+eclD/xAV
        abt24/JV4jwYmfFVukE2LgtHSmTv1+b+6KaDxsGni5ljaU+FBMf9he4KIh3fI18PX1CEuJXq7SK7y
        LujY/7ww==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsn9l-0004qG-Lq; Tue, 07 Jul 2020 12:57:05 +0000
Date:   Tue, 7 Jul 2020 13:57:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, fdmanana@gmail.com, dsterba@suse.cz,
        david@fromorbit.com, darrick.wong@oracle.com,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200707125705.GK25523@casper.infradead.org>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707124346.xnr5gtcysuzehejq@fiona>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 07:43:46AM -0500, Goldwyn Rodrigues wrote:
> On  9:53 01/07, Christoph Hellwig wrote:
> > On Mon, Jun 29, 2020 at 02:23:49PM -0500, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > For direct I/O, add the flag IOMAP_DIO_RWF_NO_STALE_PAGECACHE to indicate
> > > that if the page invalidation fails, return back control to the
> > > filesystem so it may fallback to buffered mode.
> > > 
> > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > I'd like to start a discussion of this shouldn't really be the
> > default behavior.  If we have page cache that can't be invalidated it
> > actually makes a whole lot of sense to not do direct I/O, avoid the
> > warnings, etc.
> > 
> > Adding all the relevant lists.
> 
> Since no one responded so far, let me see if I can stir the cauldron :)
> 
> What error should be returned in case of such an error? I think the

Christoph's message is ambiguous.  I don't know if he means "fail the
I/O with an error" or "satisfy the I/O through the page cache".  I'm
strongly in favour of the latter.  Indeed, I'm in favour of not invalidating
the page cache at all for direct I/O.  For reads, I think the page cache
should be used to satisfy any portion of the read which is currently
cached.  For writes, I think we should write into the page cache pages
which currently exist, and then force those pages to be written back,
but left in cache.

