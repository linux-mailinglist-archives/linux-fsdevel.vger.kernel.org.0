Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B747218DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgGHRMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 13:12:18 -0400
Received: from casper.infradead.org ([90.155.50.34]:39480 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgGHRMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DHbykbSzvHZ+ERIXBMC0PVe/QodLlC0apKHTrr7dIjo=; b=aTEVjNxqStfGrVD1x6cdPIl3Pd
        wMtlbtM6BVtT9N2pu9XA/heTNYZPzM6kRmZK3R27RoAYHMirElga/oCrt5hnM5Oz6O3x+LM5RZ9Vs
        0m/ZAFyuZCHll+MyIquY+TPhalixp5WQIBS33s0Ra5J/BRuTAyvEIelIMGJ2X4kJfUwcM+fePqqLg
        l1q0ELOr7Ob062D6nPdhjxrNwlI124nMbkIR542HcTaf3lrccClz7BQOD6Iywr+041fTauw4FwY/V
        feJLTgV0dp5tgrU0KGlg2g/5ghH6xa9AjTEIiZuuN8oOKeZsDO+qAB15DG8b8vZB5CfGrg20RpPV3
        JjRzRQWQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtDbt-0007OU-3n; Wed, 08 Jul 2020 17:11:53 +0000
Date:   Wed, 8 Jul 2020 18:11:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, darrick.wong@oracle.com,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200708171152.GV25523@casper.infradead.org>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org>
 <20200707130030.GA13870@lst.de>
 <20200708065127.GM2005@dread.disaster.area>
 <20200708135437.GP25523@casper.infradead.org>
 <20200708165412.GA637@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708165412.GA637@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 06:54:12PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 08, 2020 at 02:54:37PM +0100, Matthew Wilcox wrote:
> > Direct I/O isn't deterministic though.  If the file isn't shared, then
> > it works great, but as soon as you get mixed buffered and direct I/O,
> > everything is already terrible.  Direct I/Os perform pagecache lookups
> > already, but instead of using the data that we found in the cache, we
> > (if it's dirty) write it back, wait for the write to complete, remove
> > the page from the pagecache and then perform another I/O to get the data
> > that we just wrote out!  And then the app that's using buffered I/O has
> > to read it back in again.
> 
> Mostly agreed.  That being said I suspect invalidating clean cache
> might still be a good idea.  The original idea was mostly on how
> to deal with invalidation failures of any kind, but falling back for
> any kind of dirty cache also makes at least some sense.

That's certainly the btrfs problem that needs to be solved, but I think
it's all part of the directio misdesign.

> > I have had an objection raised off-list.  In a scenario with a block
> > device shared between two systems and an application which does direct
> > I/O, everything is normally fine.  If one of the systems uses tar to
> > back up the contents of the block device then the application on that
> > system will no longer see the writes from the other system because
> > there's nothing to invalidate the pagecache on the first system.
> 
> Err, WTF?  If someone access shared block devices with random
> applications all bets are off anyway.

That doesn't mean that customers don't do it.  It is, of course, not
recommended, but we suspect people do it anyway.  Because it does
work, unfortunately.  I'd be open to making this exact situation
deterministically not work (eg disallowing mixing O_DIRECT and
non-O_DIRECT openers of block devices), but making it suddenly
non-deterministically give you old data is a non-starter.

> > Unfortunately, this is in direct conflict with the performance
> > problem caused by some little arsewipe deciding to do:
> > 
> > $ while true; do dd if=/lib/x86_64-linux-gnu/libc-2.30.so iflag=direct of=/dev/null; done
> > 
> > ... doesn't hurt me because my root filesystem is on ext4 which doesn't
> > purge the cache.  But anything using iomap gets all the pages for libc
> > kicked out of the cache, and that's a lot of fun.
> 
> ext4 uses iomap..

I happen to be running an older kernel that doesn't on this laptop ;-)
