Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE121898F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgGHNz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 09:55:28 -0400
Received: from casper.infradead.org ([90.155.50.34]:35578 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbgGHNz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UB2tdF87tFQumNjUF6URWsZKnhuGKxYkdOBfeGqgmNc=; b=UeWTs1ynUHzLfr+5s7N2jufuZq
        hVJMkoOaL51orUJ2U6d/jXiD65aMw5gc4OGO/iGGnU4H5d+7sRGEgTEwnJmjw0Wvojw1vz0K1jIhX
        ROyUmisDAxlU1Qaw8C8IOh9jCz/mFEYKYXFV0g01q144YSfPf1SFBQs5YNmhGkhRtkHfecJm//rjj
        z0mzg63OZ9bdyw2OW79uVfvsYz2zBTM1edW2wTP9uRo6ZkQKXz/zcFQyxn440w3YjX89PhiFI6E5G
        fva+HWNLqN3VKzlfYtsID3IerAPVQF5Thq/MfdWQu4E8tRwiYt/HoJ/GNzJIU335YmyDNl7Fzxs0v
        a01ZHrsA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtAX1-0005vm-5p; Wed, 08 Jul 2020 13:54:43 +0000
Date:   Wed, 8 Jul 2020 14:54:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, darrick.wong@oracle.com,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200708135437.GP25523@casper.infradead.org>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org>
 <20200707130030.GA13870@lst.de>
 <20200708065127.GM2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708065127.GM2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 04:51:27PM +1000, Dave Chinner wrote:
> On Tue, Jul 07, 2020 at 03:00:30PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 07, 2020 at 01:57:05PM +0100, Matthew Wilcox wrote:
> > > Indeed, I'm in favour of not invalidating
> > > the page cache at all for direct I/O.  For reads, I think the page cache
> > > should be used to satisfy any portion of the read which is currently
> > > cached.  For writes, I think we should write into the page cache pages
> > > which currently exist, and then force those pages to be written back,
> > > but left in cache.
> > 
> > Something like that, yes.
> 
> So are we really willing to take the performance regression that
> occurs from copying out of the page cache consuming lots more CPU
> than an actual direct IO read? Or that direct IO writes suddenly
> serialise because there are page cache pages and now we have to do
> buffered IO?
> 
> Direct IO should be a deterministic, zero-copy IO path to/from
> storage. Using the CPU to copy data during direct IO is the complete
> opposite of the intended functionality, not to mention the behaviour
> that many applications have been careful designed and tuned for.

Direct I/O isn't deterministic though.  If the file isn't shared, then
it works great, but as soon as you get mixed buffered and direct I/O,
everything is already terrible.  Direct I/Os perform pagecache lookups
already, but instead of using the data that we found in the cache, we
(if it's dirty) write it back, wait for the write to complete, remove
the page from the pagecache and then perform another I/O to get the data
that we just wrote out!  And then the app that's using buffered I/O has
to read it back in again.

Nobody's proposing changing Direct I/O to exclusively work through the
pagecache.  The proposal is to behave less weirdly when there's already
data in the pagecache.

I have had an objection raised off-list.  In a scenario with a block
device shared between two systems and an application which does direct
I/O, everything is normally fine.  If one of the systems uses tar to
back up the contents of the block device then the application on that
system will no longer see the writes from the other system because
there's nothing to invalidate the pagecache on the first system.

Unfortunately, this is in direct conflict with the performance
problem caused by some little arsewipe deciding to do:

$ while true; do dd if=/lib/x86_64-linux-gnu/libc-2.30.so iflag=direct of=/dev/null; done

... doesn't hurt me because my root filesystem is on ext4 which doesn't
purge the cache.  But anything using iomap gets all the pages for libc
kicked out of the cache, and that's a lot of fun.
