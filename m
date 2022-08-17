Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C5A597A61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 01:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiHQXxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 19:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiHQXxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0A231370;
        Wed, 17 Aug 2022 16:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CEFB60BDB;
        Wed, 17 Aug 2022 23:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79D1C433C1;
        Wed, 17 Aug 2022 23:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660780411;
        bh=VoaM83Mj08hil6R3jdKE63+zf7uEg4CP7GNqpWatKOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z3zfu99KoDYraZpsGrhDqkZGjIKFlYh0N89crknDTujmNHM8MQ4QjHWCoIb+4t3MQ
         N3LfRoGyB3FoZpsgIjCxFgusiwozPp/JLg4bZCI7BMToTQUFzOY3FieNwW0QxNhC5Z
         7Rhq58gHWTClbbofjDUbKiI+zt+a85rZ9I8caOqBhKPwNk9neLY01EWsv0kOkIfVps
         Lqh3EddcQwR/xu96YvtRDzvL+UjyYvVuUus9IpWCfzXdun3BvjSlMe2pukMDv259Rd
         iLqDKUqnYSVUQ/pYna1vVdL4VVFtyYa+JgwOvB4M4MDgnJjZPjpjoa7RT9SQVlT0D3
         Eop+9wNIBJzXQ==
Date:   Wed, 17 Aug 2022 16:53:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Brian Foster <bfoster@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-mm@kvack.org
Subject: Re: Multi-page folio issues in 5.19-rc4 (was [PATCH v3 25/25] xfs:
 Support large folios)
Message-ID: <Yv1/e87U/LDrfSVg@magnolia>
References: <Yrm6YM2uS+qOoPcn@casper.infradead.org>
 <YrosM1+yvMYliw2l@magnolia>
 <20220628073120.GI227878@dread.disaster.area>
 <YrrlrMK/7pyZwZj2@casper.infradead.org>
 <Yrrmq4hmJPkf5V7s@casper.infradead.org>
 <Yrr/oBlf1Eig8uKS@casper.infradead.org>
 <20220628221757.GJ227878@dread.disaster.area>
 <YruNE72sW4Aizq8U@magnolia>
 <YrxMOgIvKVe6u/uR@bfoster>
 <20220817093627.GZ3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817093627.GZ3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 07:36:27PM +1000, Dave Chinner wrote:
> On Wed, Jun 29, 2022 at 08:57:30AM -0400, Brian Foster wrote:
> > On Tue, Jun 28, 2022 at 04:21:55PM -0700, Darrick J. Wong wrote:
> > > On Wed, Jun 29, 2022 at 08:17:57AM +1000, Dave Chinner wrote:
> > > > On Tue, Jun 28, 2022 at 02:18:24PM +0100, Matthew Wilcox wrote:
> > > > > On Tue, Jun 28, 2022 at 12:31:55PM +0100, Matthew Wilcox wrote:
> > > > > > On Tue, Jun 28, 2022 at 12:27:40PM +0100, Matthew Wilcox wrote:
> > > > > > > On Tue, Jun 28, 2022 at 05:31:20PM +1000, Dave Chinner wrote:
> > > > > > > > So using this technique, I've discovered that there's a dirty page
> > > > > > > > accounting leak that eventually results in fsx hanging in
> > > > > > > > balance_dirty_pages().
> > > > > > > 
> > > > > > > Alas, I think this is only an accounting error, and not related to
> > > > > > > the problem(s) that Darrick & Zorro are seeing.  I think what you're
> > > > > > > seeing is dirty pages being dropped at truncation without the
> > > > > > > appropriate accounting.  ie this should be the fix:
> > > > > > 
> > > > > > Argh, try one that actually compiles.
> > > > > 
> > > > > ... that one's going to underflow the accounting.  Maybe I shouldn't
> > > > > be writing code at 6am?
> > > > > 
> > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > index f7248002dad9..4eec6ee83e44 100644
> > > > > --- a/mm/huge_memory.c
> > > > > +++ b/mm/huge_memory.c
> > > > > @@ -18,6 +18,7 @@
> > > > >  #include <linux/shrinker.h>
> > > > >  #include <linux/mm_inline.h>
> > > > >  #include <linux/swapops.h>
> > > > > +#include <linux/backing-dev.h>
> > > > >  #include <linux/dax.h>
> > > > >  #include <linux/khugepaged.h>
> > > > >  #include <linux/freezer.h>
> > > > > @@ -2439,11 +2440,15 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > >  		__split_huge_page_tail(head, i, lruvec, list);
> > > > >  		/* Some pages can be beyond EOF: drop them from page cache */
> > > > >  		if (head[i].index >= end) {
> > > > > -			ClearPageDirty(head + i);
> > > > > -			__delete_from_page_cache(head + i, NULL);
> > > > > +			struct folio *tail = page_folio(head + i);
> > > > > +
> > > > >  			if (shmem_mapping(head->mapping))
> > > > >  				shmem_uncharge(head->mapping->host, 1);
> > > > > -			put_page(head + i);
> > > > > +			else if (folio_test_clear_dirty(tail))
> > > > > +				folio_account_cleaned(tail,
> > > > > +					inode_to_wb(folio->mapping->host));
> > > > > +			__filemap_remove_folio(tail, NULL);
> > > > > +			folio_put(tail);
> > > > >  		} else if (!PageAnon(page)) {
> > > > >  			__xa_store(&head->mapping->i_pages, head[i].index,
> > > > >  					head + i, 0);
> > > > > 
> > > > 
> > > > Yup, that fixes the leak.
> > > > 
> > > > Tested-by: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Four hours of generic/522 running is long enough to conclude that this
> > > is likely the fix for my problem and migrate long soak testing to my
> > > main g/522 rig and:
> > > 
> > > Tested-by: Darrick J. Wong <djwong@kernel.org>
> > > 
> > 
> > Just based on Willy's earlier comment.. what I would probably be a
> > little careful/curious about here is whether the accounting fix leads to
> > an indirect behavior change that does impact reproducibility of the
> > corruption problem. For example, does artificially escalated dirty page
> > tracking lead to increased reclaim/writeback activity than might
> > otherwise occur, and thus contend with the fs workload?
> 
> Yeah, I think you're right, Brian. There is an underlying problem
> here, and the writeback/memory pressure bugs exposed it for everyone
> to see.  IOWs, we do indeed have a pre-existing problem with partial
> writes, iomap, unwritten extents, writeback and memory reclaim.
> 
> (Please s/page/folio/ rather than complain I'm calling things pages
> and not folios, I'm juggling between RHEL-8 code and upstream
> here and it's just easier to refer to everything as pages as I write
> it.)
> 
> (I'm assuming people are familiar with the iomap buffered IO code
> at this point.)
> 
> Let's do a partial write into a page. Let's say the second half of
> the page. __iomap_begin_write() drops into iomap_adjust_read_range()
> to determine the range that needs zeroing or reading from disk.  We
> then call iomap_block_needs_zeroing() to determine if we zero -
> which we do if it's a newly allocated or unwritten extent. Otherwise
> we read it from disk.
> 
> Let's put this partial write over a large unwritten extent, which
> means we zero the first part of the page, and that writing it back
> runs unwritten extent conversion at IO completion. This changes the
> extent backing this file offset from unwritten to written.
> 
> Then, add extreme memory pressure, so writeback is already running
> and soon after the page has been dirtied it gets marked for
> cleaning. Therefore, we have the possibility of background IO
> submission and memory reclaim occurring at the same time as new
> writes are occurring to the file.
> 
> To that end, let's add a large racing write that *ends* on this same
> page that we have already partially filled with data - it will fill
> the start of the page that currently contains zeros with real data.
> 
> Let's start that write() just before writeback of the already
> uptodate partial page starts. iomap_apply will map the entire
> write (and well beyond) as a single unwritten extent. This extent is
> the same extent that the original page in the page cache already
> covers, and this write would end by filling the remaining part of
> that write.
> 
> While that second write is running around in the page cache
> copy-in loop for the unwritten extent that backs that range, IO
> submission runs and completes and converts the original partially
> filled page to a written extent, then marks it clean.

So if I understand this correctly --

Thread 1 fallocates 1G of contiguous space and writes 38 bytes to the
end of that gigabyte.  We instantiate a folio X for the region, zero the
parts we're not going to write, and copy the bytes we did want to write
into folio X.  The folio is now uptodate and dirty.  Thread 1 goes away.

Thread 2 starts a (1G-38) write of that fallocated (and mostly
unwritten) space.  It proceeds very slowly, one page at a time; it'll be
a while before it gets to folio X.

ramsnake.exe fires up and pushes the system hard into memory reclaim.
Reclaim initiates dirty writeback of folio X, which writes it to disk
and does the unwritten extent conversion.  Reclaim then removes X from
the page cache, and frees X.

Thread 2 finally gets to the end of its 1G write.  It is still using the
cached 1G unwritten mapping from before, unaware that some of the
mapping has changed to written state.  It grabs a folio for (1G - 38),
but it gets folio Y instead of folio X.  Y is not uptodate, so thread 2
copies bytes from userspace and zeroes the last 38 bytes.

**WRONG**

We now have folio Y with zeroes in the last 38 bytes, instead of
whatever thread 1 wrote.  Writeback pushes Y to disk, clobbering those
38 bytes forever.

> [ Ayup, the extent map of the file just changed to be different
> to the iomap that the current write() thinks the file layout has. ]
> 
> Further, because the partially written page is now clean,
> memory reclaim can snaffle it up and it gets removed from the page
> cache.
> 
> The second write finally gets to the last page of it's write and
> doesn't find it in the page cache because memory reclaim removed it.
> So it pulls a new page into the page cache in iomap_begin_write(),
> and then in __iomap_begin_write we see that the we need to fill the
> second half of the page with either zeros or data from disk.
> 
> We know that this data is on disk as the extent is now in written
> state.  *However*, the cached iomap that we are currently using for
> the write() says the range is -unwritten-, and so at that point
> iomap_block_needs_zeroing() says "page needs zeroing". Hence
> __iomap_begin_write zeroes the second half of the page instead of
> reading it from disk, obliterating the data that the previous write
> had already written there.

Yup.

> Ouchy, we have data corruption because the incoming write holds a
> stale cached iomap......
> 
> At this point, I had a nasty feeling of deja vu.
> 
> Oh, yeah, we already infrastructure in place to avoid using stale
> cached iomaps in ->writepages....
> 
> That is, iomap_writepage_map() calls ->map_block for every filesytem
> block, even though the iomap_writepage_ctx has a cached iomap in it.
> That's so the filesystem can check that the cached iomap is still
> valid whilst the page we are writing back is held locked. This
> protects writeback against races with truncate, hole punch, etc.
> 
> XFS does this via a call to xfs_imap_valid() - we keep a generation
> number in the XFS extent trees that is bumped on every change so
> that we can check whether a cached iomap is still valid. If the
> generation numbers don't match, then we generate a new iomap for the
> writepage context....
> 
> What is clear to me now is that we have the same stale cached iomap
> problem with iomap_apply() because writeback can change the extent
> map state in a way that influence incoming writes and those updates
> are not in any way serialised against the incoming write IO path.
> 
> Hence we have to validate that the cached iomap is not stale before
> we decide what to do with a new page in the page cache (zero or read
> from disk), and we have to do this iomap validation when the newly
> instantiated page is locked and ready for initialisation.
> 
> I have not thought past this point - I'm only *just* smart enough to
> be able to dig out the root cause of this problem. No scratch that,
> I'm not smart, just stubborn enough to ignore the fact I've got the
> analysis wrong at least a dozen times already.
> 
> That said, this stale mapping problem existed long before we started
> using unwritten extents for delayed allocation. The change to use
> unwritten extents (to fix other data corruption issues) exposed us
> to in-memory zeroing in this race condition case rather reading the
> block of data from disk. We just hadn't armed the landmine....
> 
> I suspect we are going to need a new iomap validation operation, and
> require the iomap actors to be able to handle iomap validation
> failure.  What that looks like, I don't know as my brain
> turned to goo and dribbled out my ears about 4 hours ago....

Euughg.  I suppose this means that ->iomap_begin has to be able to stuff
xfs_ifork.if_seq into a cookie value that we can set in struct iomap
somewhere?  And then iomap has to be able to call back to XFS to
revalidate iomap.cookie?  And if iomap.cookie != xfs_ifork.if_seq, then
I guess iomap will just ... unlock and put the folio, and return EAGAIN
(or something) so that its caller will return however many bytes have
been dirtied to iomap_apply so that _apply will go get a fresh mapping?

> BTW, all the credit for finding this goes to Frank Sorenson - he did
> all the hard work of reproducing the issue and narrowing down the
> scope of the problem to a handful of XFS commits combined with
> writeback and memory reclaim interactions. Without his hard work,
> we'd still have no idea what was going on.....

Thanks a bunch to him!!!

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
