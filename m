Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92F216D59
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGNAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 09:00:35 -0400
Received: from verein.lst.de ([213.95.11.211]:58732 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGNAf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:00:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B08468AFE; Tue,  7 Jul 2020 15:00:31 +0200 (CEST)
Date:   Tue, 7 Jul 2020 15:00:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, fdmanana@gmail.com, dsterba@suse.cz,
        david@fromorbit.com, darrick.wong@oracle.com,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return
 if page invalidation fails
Message-ID: <20200707130030.GA13870@lst.de>
References: <20200629192353.20841-1-rgoldwyn@suse.de> <20200629192353.20841-3-rgoldwyn@suse.de> <20200701075310.GB29884@lst.de> <20200707124346.xnr5gtcysuzehejq@fiona> <20200707125705.GK25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707125705.GK25523@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:57:05PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 07, 2020 at 07:43:46AM -0500, Goldwyn Rodrigues wrote:
> > On  9:53 01/07, Christoph Hellwig wrote:
> > > On Mon, Jun 29, 2020 at 02:23:49PM -0500, Goldwyn Rodrigues wrote:
> > > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > 
> > > > For direct I/O, add the flag IOMAP_DIO_RWF_NO_STALE_PAGECACHE to indicate
> > > > that if the page invalidation fails, return back control to the
> > > > filesystem so it may fallback to buffered mode.
> > > > 
> > > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > I'd like to start a discussion of this shouldn't really be the
> > > default behavior.  If we have page cache that can't be invalidated it
> > > actually makes a whole lot of sense to not do direct I/O, avoid the
> > > warnings, etc.
> > > 
> > > Adding all the relevant lists.
> > 
> > Since no one responded so far, let me see if I can stir the cauldron :)
> > 
> > What error should be returned in case of such an error? I think the
> 
> Christoph's message is ambiguous.  I don't know if he means "fail the
> I/O with an error" or "satisfy the I/O through the page cache".  I'm
> strongly in favour of the latter.

Same here.  Sorry if my previous mail was unclear.

> Indeed, I'm in favour of not invalidating
> the page cache at all for direct I/O.  For reads, I think the page cache
> should be used to satisfy any portion of the read which is currently
> cached.  For writes, I think we should write into the page cache pages
> which currently exist, and then force those pages to be written back,
> but left in cache.

Something like that, yes.
