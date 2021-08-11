Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F045A3E983F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhHKTEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 15:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhHKTEd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:04:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2C3461077;
        Wed, 11 Aug 2021 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628708649;
        bh=jScylGJuwjKMORyLGXSXMDTyjRrlSYsq/C10m9K+XeM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KexzI3E1dNjTjZieeWppa1roWWQuXrcbEo3FYd8LpBIKXMJ27Y9yKR8YFn4D7JvTE
         KCRywyT9P1WLLDONixgy4eZpi8jejoyWFXoRkGe69muLJLQqmX4kNKdJV8Tu4B5VMz
         3XdHtfx8HJckJu9o+ergU++8RYYWqppYf13jGp50CKQ4xGYXVqjTcNxjaKIOZztk40
         O1SVqYvu4Ov3gteWLKbJ1q24+I2Lgx+r1H/GdTUQ3JC6JoiQcfEAFlB2X1uGrwwMHx
         sKD5J9u7OScJyHP9HKg4XAQJamhvXX///PkslLxq5fzeobPBun3keHuFMkvJaHqfY3
         nzkvzE74+qLhQ==
Message-ID: <68817121af70e4c370c541b6d5cc48fe0f11e312.camel@kernel.org>
Subject: Re: Dirty bits and sync writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuang521@gmail.com>, yukuai3@huawei.com,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>, linux-xfs@vger.kernel.org
Date:   Wed, 11 Aug 2021 15:04:07 -0400
In-Reply-To: <YRFKB0rBU51O1YpD@casper.infradead.org>
References: <YQlgjh2R8OzJkFoB@casper.infradead.org>
         <YRFAWPdMHp8Wpds/@infradead.org> <YRFKB0rBU51O1YpD@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-08-09 at 16:30 +0100, Matthew Wilcox wrote:
> On Mon, Aug 09, 2021 at 03:48:56PM +0100, Christoph Hellwig wrote:
> > On Tue, Aug 03, 2021 at 04:28:14PM +0100, Matthew Wilcox wrote:
> > > Solution 1: Add an array of dirty bits to the iomap_page
> > > data structure.  This patch already exists; would need
> > > to be adjusted slightly to apply to the current tree.
> > > https://lore.kernel.org/linux-xfs/7fb4bb5a-adc7-5914-3aae-179dd8f3adb1@huawei.com/
> > 
> > > Solution 2a: Replace the array of uptodate bits with an array of
> > > dirty bits.  It is not often useful to know which parts of the page are
> > > uptodate; usually the entire page is uptodate.  We can actually use the
> > > dirty bits for the same purpose as uptodate bits; if a block is dirty, it
> > > is definitely uptodate.  If a block is !dirty, and the page is !uptodate,
> > > the block may or may not be uptodate, but it can be safely re-read from
> > > storage without losing any data.
> > 
> > 1 or 2a seems like something we should do once we have lage folio
> > support.
> > 
> > 
> > > Solution 2b: Lose the concept of partially uptodate pages.  If we're
> > > going to write to a partial page, just bring the entire page uptodate
> > > first, then write to it.  It's not clear to me that partially-uptodate
> > > pages are really useful.  I don't know of any network filesystems that
> > > support partially-uptodate pages, for example.  It seems to have been
> > > something we did for buffer_head based filesystems "because we could"
> > > rather than finding a workload that actually cares.
> > 

I may be wrong, but I thought NFS actually could deal with partially
uptodate pages. In some cases it can opt to just do a write to a page
w/o reading first and flush just that section when the time comes.

I think the heuristics are in nfs_want_read_modify_write(). #3 may be a
better way though.

> > The uptodate bit is important for the use case of a smaller than page
> > size buffered write into a page that hasn't been read in already, which
> > is fairly common for things like log writes.  So I'd hate to lose this
> > optimization.
> > 
> > > (it occurs to me that solution 3 actually allows us to do IOs at storage
> > > block size instead of filesystem block size, potentially reducing write
> > > amplification even more, although we will need to be a bit careful if
> > > we're doing a CoW.)
> > 
> > number 3 might be nice optimization.  The even better version would
> > be a disk format change to just log those updates in the log and
> > otherwise use the normal dirty mechanism.  I once had a crude prototype
> > for that.
> 
> That's a bit beyond my scope at this point.  I'm currently working on
> write-through.  Once I have that working, I think the next step is:
> 
>  - Replace the ->uptodate array with a ->dirty array
>  - If the entire page is Uptodate, drop the iomap_page.  That means that
>    writebacks will write back the entire folio, not just the dirty
>    pieces.
>  - If doing a partial page write
>    - If the write is block-aligned (offset & length), leave the page
>      !Uptodate and mark the dirty blocks
>    - Otherwise bring the entire page Uptodate first, then mark it dirty
> 
> To take an example of a 512-byte block size file accepting a 520 byte
> write at offset 500, we currently submit two reads, one for bytes 0-511
> and the second for 1024-1535.  We're better off submitting a read for
> bytes 0-4095 and then overwriting the entire thing.
> 
> But it's still better to do no reads at all if someone submits a write
> for bytes 512-1023, or 512-N where N is past EOF.  And I'd preserve
> that behaviour.
> 

I like this idea too.

I'd also point out that both cifs and ceph (at least) can read and write
"around" the cache in some cases (using non-pagecache pages) when they
can't get the proper oplock/lease/caps from the server. Both of them
have completely separate "uncached" codepaths, that are distinct from
the O_DIRECT cases.

This scheme could potentially be a saner method of dealing with those
situations too.
-- 
Jeff Layton <jlayton@kernel.org>

