Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91994218D95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgGHQyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 12:54:19 -0400
Received: from verein.lst.de ([213.95.11.211]:36202 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbgGHQyS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:54:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 74C6168B05; Wed,  8 Jul 2020 18:54:13 +0200 (CEST)
Date:   Wed, 8 Jul 2020 18:54:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, darrick.wong@oracle.com,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return
 if page invalidation fails
Message-ID: <20200708165412.GA637@lst.de>
References: <20200629192353.20841-1-rgoldwyn@suse.de> <20200629192353.20841-3-rgoldwyn@suse.de> <20200701075310.GB29884@lst.de> <20200707124346.xnr5gtcysuzehejq@fiona> <20200707125705.GK25523@casper.infradead.org> <20200707130030.GA13870@lst.de> <20200708065127.GM2005@dread.disaster.area> <20200708135437.GP25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708135437.GP25523@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:54:37PM +0100, Matthew Wilcox wrote:
> Direct I/O isn't deterministic though.  If the file isn't shared, then
> it works great, but as soon as you get mixed buffered and direct I/O,
> everything is already terrible.  Direct I/Os perform pagecache lookups
> already, but instead of using the data that we found in the cache, we
> (if it's dirty) write it back, wait for the write to complete, remove
> the page from the pagecache and then perform another I/O to get the data
> that we just wrote out!  And then the app that's using buffered I/O has
> to read it back in again.

Mostly agreed.  That being said I suspect invalidating clean cache
might still be a good idea.  The original idea was mostly on how
to deal with invalidation failures of any kind, but falling back for
any kind of dirty cache also makes at least some sense.

> I have had an objection raised off-list.  In a scenario with a block
> device shared between two systems and an application which does direct
> I/O, everything is normally fine.  If one of the systems uses tar to
> back up the contents of the block device then the application on that
> system will no longer see the writes from the other system because
> there's nothing to invalidate the pagecache on the first system.

Err, WTF?  If someone access shared block devices with random
applications all bets are off anyway.

> 
> Unfortunately, this is in direct conflict with the performance
> problem caused by some little arsewipe deciding to do:
> 
> $ while true; do dd if=/lib/x86_64-linux-gnu/libc-2.30.so iflag=direct of=/dev/null; done
> 
> ... doesn't hurt me because my root filesystem is on ext4 which doesn't
> purge the cache.  But anything using iomap gets all the pages for libc
> kicked out of the cache, and that's a lot of fun.

ext4 uses iomap..
