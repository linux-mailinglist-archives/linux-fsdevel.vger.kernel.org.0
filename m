Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9F3E9925
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 21:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhHKTpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhHKTpN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:45:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC89C061765;
        Wed, 11 Aug 2021 12:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SJxrO0y01shP+avPksCS1mYotqi8G+hpGZz52MuWCdM=; b=BpdOjArhch449tZ/aezqWmRp04
        Qa2rbC3MIOzWVUilo5zXKrVe9sV4VaD6UoPlaB2RtDeNiv7h2BVe1yT99imVl14jRTM6QCY5eU2Xt
        Dpt9ZmRJhs8/jgqfMeZpowRPoRcZGqoXyW3rpwWH6yTT4wmNx9buhy6KwV225r9/FQK7zHjqAoUI8
        gEd8cXb9KVFNGIpq4Q8Rnv1/6wYaB+/zh68s3Dp7amwV5Qb64beqWFx7g/d/7Gnhhc46dHvecQubj
        9Q9V4Mnt2/9r+rwO3oskbcPebRXK12p3SrpmmN2UslBL515dpMb/XKC2ExzIgEqfLuMHQ2yjEVG54
        5TddRScg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDu7n-00Dn2h-RF; Wed, 11 Aug 2021 19:43:19 +0000
Date:   Wed, 11 Aug 2021 20:42:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuang521@gmail.com>, yukuai3@huawei.com,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>, linux-xfs@vger.kernel.org
Subject: Re: Dirty bits and sync writes
Message-ID: <YRQoOw2s/Omkq+NN@casper.infradead.org>
References: <YQlgjh2R8OzJkFoB@casper.infradead.org>
 <YRFAWPdMHp8Wpds/@infradead.org>
 <YRFKB0rBU51O1YpD@casper.infradead.org>
 <68817121af70e4c370c541b6d5cc48fe0f11e312.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68817121af70e4c370c541b6d5cc48fe0f11e312.camel@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 03:04:07PM -0400, Jeff Layton wrote:
> On Mon, 2021-08-09 at 16:30 +0100, Matthew Wilcox wrote:
> > On Mon, Aug 09, 2021 at 03:48:56PM +0100, Christoph Hellwig wrote:
> > > On Tue, Aug 03, 2021 at 04:28:14PM +0100, Matthew Wilcox wrote:
> > > > Solution 1: Add an array of dirty bits to the iomap_page
> > > > data structure.  This patch already exists; would need
> > > > to be adjusted slightly to apply to the current tree.
> > > > https://lore.kernel.org/linux-xfs/7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com/
> > > 
> > > > Solution 2a: Replace the array of uptodate bits with an array of
> > > > dirty bits.  It is not often useful to know which parts of the page are
> > > > uptodate; usually the entire page is uptodate.  We can actually use the
> > > > dirty bits for the same purpose as uptodate bits; if a block is dirty, it
> > > > is definitely uptodate.  If a block is !dirty, and the page is !uptodate,
> > > > the block may or may not be uptodate, but it can be safely re-read from
> > > > storage without losing any data.
> > > 
> > > 1 or 2a seems like something we should do once we have lage folio
> > > support.
> > > 
> > > 
> > > > Solution 2b: Lose the concept of partially uptodate pages.  If we're
> > > > going to write to a partial page, just bring the entire page uptodate
> > > > first, then write to it.  It's not clear to me that partially-uptodate
> > > > pages are really useful.  I don't know of any network filesystems that
> > > > support partially-uptodate pages, for example.  It seems to have been
> > > > something we did for buffer_head based filesystems "because we could"
> > > > rather than finding a workload that actually cares.
> > > 
> 
> I may be wrong, but I thought NFS actually could deal with partially
> uptodate pages. In some cases it can opt to just do a write to a page
> w/o reading first and flush just that section when the time comes.
> 
> I think the heuristics are in nfs_want_read_modify_write(). #3 may be a
> better way though.

Yes; I was talking specifically about iomap here.  I like what NFS does;
it makes a lot of sense to me.  The only thing I'd like to change for
NFS is to add an ->is_partially_uptodate implementation.  But that
only matters if somebody calls read() on some bytes they just wrote.
And I don't know that that's a particularly common or interesting
thing to do.  I suppose if there are two processes with one writing
to the file and the other reading from it, we might get that.

> > > The uptodate bit is important for the use case of a smaller than page
> > > size buffered write into a page that hasn't been read in already, which
> > > is fairly common for things like log writes.  So I'd hate to lose this
> > > optimization.
> > > 
> > > > (it occurs to me that solution 3 actually allows us to do IOs at storage
> > > > block size instead of filesystem block size, potentially reducing write
> > > > amplification even more, although we will need to be a bit careful if
> > > > we're doing a CoW.)
> > > 
> > > number 3 might be nice optimization.  The even better version would
> > > be a disk format change to just log those updates in the log and
> > > otherwise use the normal dirty mechanism.  I once had a crude prototype
> > > for that.
> > 
> > That's a bit beyond my scope at this point.  I'm currently working on
> > write-through.  Once I have that working, I think the next step is:
> > 
> >  - Replace the ->uptodate array with a ->dirty array
> >  - If the entire page is Uptodate, drop the iomap_page.  That means that
> >    writebacks will write back the entire folio, not just the dirty
> >    pieces.
> >  - If doing a partial page write
> >    - If the write is block-aligned (offset & length), leave the page
> >      !Uptodate and mark the dirty blocks
> >    - Otherwise bring the entire page Uptodate first, then mark it dirty
> > 
> > To take an example of a 512-byte block size file accepting a 520 byte
> > write at offset 500, we currently submit two reads, one for bytes 0-511
> > and the second for 1024-1535.  We're better off submitting a read for
> > bytes 0-4095 and then overwriting the entire thing.
> > 
> > But it's still better to do no reads at all if someone submits a write
> > for bytes 512-1023, or 512-N where N is past EOF.  And I'd preserve
> > that behaviour.
> 
> I like this idea too.
> 
> I'd also point out that both cifs and ceph (at least) can read and write
> "around" the cache in some cases (using non-pagecache pages) when they
> can't get the proper oplock/lease/caps from the server. Both of them
> have completely separate "uncached" codepaths, that are distinct from
> the O_DIRECT cases.
> 
> This scheme could potentially be a saner method of dealing with those
> situations too.

Possibly ... how do cifs & ceph handle writable mmap() when they can't
get the proper exclusive access from the server?

The major downside I can see is that if you have multiple writes to
the same page then the writes will be serialised.  But maybe they
already are by the scheme used by cifs & ceph?

(That could be worked around by tracking outstanding writes to the
server and only clearing the writeback bit once all writes have
completed)
