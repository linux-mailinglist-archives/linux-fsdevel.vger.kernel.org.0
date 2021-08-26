Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279173F7F64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 02:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHZAqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 20:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232139AbhHZAqn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 20:46:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6240360240;
        Thu, 26 Aug 2021 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629938756;
        bh=q5xJFNvYEwk5av1L6RkuifsUJaXa2r5OhNrDB3ydAUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVRKlO6TBg0GYvsWAWOec+Taytc2AbmIvghTPw6DjPQ57I9I0jEukH/HIT8zUC7o2
         Yp/H/gBKPzcKM16Pr4px1TUt1b48zytV0goDZp0oEf7XV7IQtmHDmh+XwYgR4KYwut
         I8Vm+HzaJkwrZkuofvDbHJkaR3i6h70QBOJV+imet2ABtbbqmaFgF87NGAqNcIpL1l
         4NhFY98aMDZMA2g8WKiESYxCrixvSLmFQ3MlBiCHPzQzYzrRQkbyALbe5V6ckodYCr
         4gxHDGn/quDQzzOjXcOtLZbaEyA0hGtaLDyV91Us2acV9hgrPRYCcLJW/+HsXqXrdw
         Af/j+EJIWN+bQ==
Date:   Wed, 25 Aug 2021 17:45:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <20210826004555.GF12597@magnolia>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <YSQeFPTMn5WpwyAa@casper.infradead.org>
 <YSU7WCYAY+ZRy+Ke@cmpxchg.org>
 <YSVMAS2pQVq+xma7@casper.infradead.org>
 <YSZeKfHxOkEAri1q@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSZeKfHxOkEAri1q@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 25, 2021 at 11:13:45AM -0400, Johannes Weiner wrote:
> On Tue, Aug 24, 2021 at 08:44:01PM +0100, Matthew Wilcox wrote:
> > On Tue, Aug 24, 2021 at 02:32:56PM -0400, Johannes Weiner wrote:
> > > The folio doc says "It is at least as large as %PAGE_SIZE";
> > > folio_order() says "A folio is composed of 2^order pages";
> > > page_folio(), folio_pfn(), folio_nr_pages all encode a N:1
> > > relationship. And yes, the name implies it too.
> > > 
> > > This is in direct conflict with what I'm talking about, where base
> > > page granularity could become coarser than file cache granularity.
> > 
> > That doesn't make any sense.  A page is the fundamental unit of the
> > mm.  Why would we want to increase the granularity of page allocation
> > and not increase the granularity of the file cache?
> 
> I'm not sure why one should be tied to the other. The folio itself is
> based on the premise that a cache entry doesn't have to correspond to
> exactly one struct page. And I agree with that. I'm just wondering why
> it continues to imply a cache entry is at least one full page, rather
> than saying a cache entry is a set of bytes that can be backed however
> the MM sees fit. So that in case we do bump struct page size in the
> future we don't have to redo the filesystem interface again.
> 
> I've listed reasons why 4k pages are increasingly the wrong choice for
> many allocations, reclaim and paging. We also know there is a need to
> maintain support for 4k cache entries.
> 
> > > Are we going to bump struct page to 2M soon? I don't know. Here is
> > > what I do know about 4k pages, though:
> > > 
> > > - It's a lot of transactional overhead to manage tens of gigs of
> > >   memory in 4k pages. We're reclaiming, paging and swapping more than
> > >   ever before in our DCs, because flash provides in abundance the
> > >   low-latency IOPS required for that, and parking cold/warm workload
> > >   memory on cheap flash saves expensive RAM. But we're continously
> > >   scanning thousands of pages per second to do this. There was also
> > >   the RWF_UNCACHED thread around reclaim CPU overhead at the higher
> > >   end of buffered IO rates. There is the fact that we have a pending
> > >   proposal from Google to replace rmap because it's too CPU-intense
> > >   when paging into compressed memory pools.
> > 
> > This seems like an argument for folios, not against them.  If user
> > memory (both anon and file) is being allocated in larger chunks, there
> > are fewer pages to scan, less book-keeping to do, and all you're paying
> > for that is I/O bandwidth.
> 
> Well, it's an argument for huge pages, and we already have those in
> the form of THP.
> 
> The problem with THP today is that the page allocator fragments the
> physical address space at the 4k granularity per default, and groups
> random allocations with no type information and rudimentary
> lifetime/reclaimability hints together.
> 
> I'm having a hard time seeing 2M allocations scale as long as we do
> this. As opposed to making 2M the default block and using slab-style
> physical grouping by type and instantiation time for smaller cache
> entries - to improve the chances of physically contiguous reclaim.
> 
> But because folios are compound/head pages first and foremost, they
> are inherently tied to being multiples of PAGE_SIZE.
> 
> > > - It's a lot of internal fragmentation. Compaction is becoming the
> > >   default method for allocating the majority of memory in our
> > >   servers. This is a latency concern during page faults, and a
> > >   predictability concern when we defer it to khugepaged collapsing.
> > 
> > Again, the more memory that we allocate in higher-order chunks, the
> > better this situation becomes.
> 
> It only needs 1 unfortunately placed 4k page out of 512 to mess up a
> 2M block indefinitely. And the page allocator has little awareness
> whether the 4k page it's handing out to somebody pairs well with the
> 4k page adjacent to it in terms of type and lifetime.
> 
> > > - struct page is statically eating gigs of expensive memory on every
> > >   single machine, when only some of our workloads would require this
> > >   level of granularity for some of their memory. And that's *after*
> > >   we're fighting over every bit in that structure.
> > 
> > That, folios does not help with.  I have post-folio ideas about how
> > to address that, but I can't realistically start working on them
> > until folios are upstream.
> 
> How would you reduce the memory overhead of struct page without losing
> necessary 4k granularity at the cache level? As long as folio implies
> that cache entries can't be smaller than a struct page?
> 
> I appreciate folio is a big patchset and I don't mean to get too much
> into speculation about the future.
> 
> But we're here in part because the filesystems have been too exposed
> to the backing memory implementation details. So all I'm saying is, if
> you're touching all the file cache interface now anyway, why not use
> the opportunity to properly disconnect it from the reality of pages,
> instead of making the compound page the new interface for filesystems.
> 
> What's wrong with the idea of a struct cache_entry which can be
> embedded wherever we want: in a page, a folio or a pageset. Or in the
> future allocated on demand for <PAGE_SIZE entries, if need be. But
> actually have it be just a cache entry for the fs to read and write,
> not also a compound page and an anon page etc. all at the same time.

Pardon my ignorance, but ... how would adding yet another layer help a
filesystem?  No matter how the software is structured, we have to set up
and manage the (hardware) page state for programs, and we must keep that
coherent with the file space mappings that we maintain.  I already know
how to deal with pages and dealing with "folios" seems about the same.
Adding another layer of caching structures just adds another layer of
cra^Wcoherency management for a filesystem to screw up.

The folios change management of memory pages enough to disentangle the
page/compound page confusion that exists now, and it seems like a
reasonable means to supporting unreasonable things like copy on write
storage for filesystems with a 56k block size.

(And I'm sure I'll get tons of blowback for this, but XFS can manage
space in weird units like that (configure the rt volume, set a 56k rt
extent size, and all the allocations are multiples of 56k); if we ever
wanted to support reflink on /that/ hot mess, it would be awesome to be
able to say that we're only going to do 56k folios in the page cache for
those files instead of the crazy writeback games that the prototype
patchset does now.)

--D

> Even today that would IMO delineate more clearly between the file
> cache data plane and the backing memory plane. It doesn't get in the
> way of also fixing the base-or-compound mess inside MM code with
> folio/pageset, either.
> 
> And if down the line we change how the backing memory is implemented,
> the changes would be a more manageable scope inside MM proper.
> 
> Anyway, I think I've asked all this before and don't mean to harp on
> it if people generally disagree that this is a concern.
